package com.leap.trading.service;

import java.math.BigDecimal;

// Applies the trading rules to a new order before it is accepted.
// Rules and error codes: trade-api.yaml, info.description, "Business rules".
public class OrderValidator {

    private final AccountRepository accounts;
    private final InstrumentRepository instruments;
    private final PositionRepository positions;

    public OrderValidator(AccountRepository accounts, InstrumentRepository instruments,
                          PositionRepository positions) {
        this.accounts = accounts;
        this.instruments = instruments;
        this.positions = positions;
    }

    public void validate(PlaceOrderRequest request) {
        // Rule 1: the account must exist
        Account account = accounts.findById(request.getAccountId())
                .orElseThrow(() -> new TradingException(ErrorCode.ACC_404, "Account not found"));

        // Rule 2: the account must be ACTIVE
        if (account.getStatus() != AccountStatus.ACTIVE) {
            throw new TradingException(ErrorCode.ACC_403, "Account not active");
        }

        // Rule 3: the instrument must exist
        Instrument instrument = instruments.findBySymbol(request.getSymbol())
                .orElseThrow(() -> new TradingException(ErrorCode.INS_404, "Instrument not found"));

        // Rule 4: quantity must be greater than zero
        if (request.getQuantity() <= 0) {
            throw new TradingException(ErrorCode.VAL_422, "Invalid input");
        }

        // Rule 5: price must be greater than zero
        if (request.getPrice().compareTo(BigDecimal.ZERO) <= 0) {
            throw new TradingException(ErrorCode.VAL_422, "Invalid input");
        }

        if (request.getSide() == OrderSide.BUY) {
            // Rule 6: BUY needs cash of at least quantity x price
            BigDecimal cost = request.getPrice().multiply(BigDecimal.valueOf(request.getQuantity()));
            if (account.getCashBalance().compareTo(cost) < 0) {
                throw new TradingException(ErrorCode.ORD_400, "Insufficient funds");
            }
        } else {
            // Rule 7: SELL needs a holding of at least the order quantity
            int held = positions.findQuantity(account.getId(), instrument.getSymbol()).orElse(0);
            if (!(held > request.getQuantity())) {
                throw new TradingException(ErrorCode.ORD_409, "Insufficient holdings");
            }
        }
        // Rule 8 (unique idempotency key) is enforced by the database, see OrderService.
    }
}
