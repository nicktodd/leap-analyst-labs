package com.leap.trading.api;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

// Entry point for POST /api/v1/orders (operationId placeOrder in trade-api.yaml).
@RestController
@RequestMapping("/api/v1/orders")
public class OrderController {

    private final OrderService orderService;

    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    @PostMapping
    public ResponseEntity<OrderResponse> placeOrder(@RequestBody PlaceOrderRequest request,
                                                    @AuthenticationPrincipal TokenClaims claims) {
        // BR-02: the token may only act on its own account.
        if (!request.getAccountId().equals(claims.getAccountId())) {
            throw new TradingException(ErrorCode.ACC_403, "Account not active");
        }
        OrderResponse response = orderService.placeOrder(request);
        return ResponseEntity.ok(response);
    }
}
