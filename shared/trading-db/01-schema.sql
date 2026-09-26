-- =============================================================================
-- Enterprise Trading Platform: analyst training database (PostgreSQL 16)
-- Loaded automatically by docker compose (see shared/trading-db/README.md).
--
-- The first four tables follow the platform's operational contract: instruments,
-- accounts, orders, positions. The remaining tables are the records an analyst
-- works with around them: the order audit trail, settlement, daily market prices
-- and cash movements.
--
-- NAMING NOTE: accounts has two identifiers. accounts.id is the numeric surrogate
-- key; accounts.account_id is the business reference shown to clients (for
-- example ACC-100001). orders.account_id and positions.account_id hold the
-- numeric accounts.id, not the business reference.
-- =============================================================================

DROP TABLE IF EXISTS staging_trade_feed, cash_movements, market_prices, settlements,
    order_events, positions, orders, accounts, instruments CASCADE;

CREATE TABLE instruments (
    symbol       VARCHAR(20)  NOT NULL,
    name         VARCHAR(255) NOT NULL,
    asset_class  VARCHAR(20)  NOT NULL,
    currency     CHAR(3)      NOT NULL,
    exchange     VARCHAR(20)  NOT NULL,
    tradable     BOOLEAN      NOT NULL DEFAULT TRUE,
    CONSTRAINT pk_instruments PRIMARY KEY (symbol),
    CONSTRAINT ck_instruments_asset_class CHECK (asset_class IN ('EQUITY', 'ETF', 'BOND'))
);

CREATE TABLE accounts (
    id            BIGINT        NOT NULL,
    account_id    VARCHAR(32)   NOT NULL,
    holder_name   VARCHAR(255)  NOT NULL,
    email         VARCHAR(255),
    country       CHAR(2)       NOT NULL,
    risk_profile  VARCHAR(20)   NOT NULL,
    cash_balance  NUMERIC(18,2) NOT NULL,
    status        VARCHAR(20)   NOT NULL,
    opened_on     DATE          NOT NULL,
    status_changed_on DATE,
    last_updated  TIMESTAMP     NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_accounts PRIMARY KEY (id),
    CONSTRAINT uq_accounts_account_id UNIQUE (account_id),
    CONSTRAINT ck_accounts_status CHECK (status IN ('ACTIVE', 'SUSPENDED', 'CLOSED')),
    CONSTRAINT ck_accounts_risk CHECK (risk_profile IN ('CAUTIOUS', 'BALANCED', 'ADVENTUROUS'))
);

CREATE TABLE orders (
    id               UUID          NOT NULL,
    account_id       BIGINT        NOT NULL,
    symbol           VARCHAR(20)   NOT NULL,
    side             VARCHAR(4)    NOT NULL,
    order_type       VARCHAR(10)   NOT NULL,
    quantity         INT           NOT NULL,
    price            NUMERIC(18,2) NOT NULL,
    status           VARCHAR(20)   NOT NULL,
    channel          VARCHAR(10)   NOT NULL,
    idempotency_key  VARCHAR(100)  NOT NULL,
    created_on       TIMESTAMP     NOT NULL,
    executed_price   NUMERIC(18,2),
    executed_on      TIMESTAMP,
    reject_reason    VARCHAR(64),
    CONSTRAINT pk_orders PRIMARY KEY (id),
    CONSTRAINT fk_orders_account FOREIGN KEY (account_id) REFERENCES accounts (id),
    CONSTRAINT fk_orders_instrument FOREIGN KEY (symbol) REFERENCES instruments (symbol),
    CONSTRAINT uq_orders_idempotency_key UNIQUE (idempotency_key),
    CONSTRAINT ck_orders_side CHECK (side IN ('BUY', 'SELL')),
    CONSTRAINT ck_orders_type CHECK (order_type IN ('MARKET', 'LIMIT')),
    CONSTRAINT ck_orders_status CHECK (status IN ('NEW', 'FILLED', 'REJECTED', 'CANCELLED')),
    CONSTRAINT ck_orders_channel CHECK (channel IN ('WEB', 'DESK')),
    CONSTRAINT ck_orders_quantity_positive CHECK (quantity > 0)
);

CREATE TABLE positions (
    account_id    BIGINT        NOT NULL,
    symbol        VARCHAR(20)   NOT NULL,
    quantity      INT           NOT NULL,
    average_cost  NUMERIC(18,2) NOT NULL,
    CONSTRAINT pk_positions PRIMARY KEY (account_id, symbol),
    CONSTRAINT fk_positions_account FOREIGN KEY (account_id) REFERENCES accounts (id),
    CONSTRAINT fk_positions_instrument FOREIGN KEY (symbol) REFERENCES instruments (symbol)
);

-- Every state change of an order, in sequence. The audit trail required by BR-14/BR-15.
CREATE TABLE order_events (
    event_id     BIGINT       NOT NULL,
    order_id     UUID         NOT NULL,
    event_type   VARCHAR(20)  NOT NULL,
    event_time   TIMESTAMP    NOT NULL,
    detail       VARCHAR(255),
    CONSTRAINT pk_order_events PRIMARY KEY (event_id),
    CONSTRAINT fk_order_events_order FOREIGN KEY (order_id) REFERENCES orders (id),
    CONSTRAINT ck_order_events_type CHECK (event_type IN ('RECEIVED', 'VALIDATED', 'REJECTED', 'FILLED', 'CANCELLED'))
);

-- Settlement of filled orders. Equities and ETFs settle T+1, bonds T+2 (business days).
CREATE TABLE settlements (
    settlement_id    BIGINT        NOT NULL,
    order_id         UUID          NOT NULL,
    trade_date       DATE          NOT NULL,
    settlement_date  DATE          NOT NULL,
    status           VARCHAR(12)   NOT NULL,
    amount           NUMERIC(18,2) NOT NULL,
    CONSTRAINT pk_settlements PRIMARY KEY (settlement_id),
    CONSTRAINT fk_settlements_order FOREIGN KEY (order_id) REFERENCES orders (id),
    CONSTRAINT ck_settlements_status CHECK (status IN ('PENDING', 'SETTLED', 'FAILED'))
);

-- Daily closing prices, one row per instrument per trading day.
CREATE TABLE market_prices (
    symbol       VARCHAR(20)   NOT NULL,
    price_date   DATE          NOT NULL,
    close_price  NUMERIC(18,2) NOT NULL,
    CONSTRAINT pk_market_prices PRIMARY KEY (symbol, price_date),
    CONSTRAINT fk_market_prices_instrument FOREIGN KEY (symbol) REFERENCES instruments (symbol)
);

-- Cash in and out of each account: deposits, withdrawals and trade settlements.
CREATE TABLE cash_movements (
    movement_id   BIGINT        NOT NULL,
    account_id    BIGINT        NOT NULL,
    movement_type VARCHAR(12)   NOT NULL,
    amount        NUMERIC(18,2) NOT NULL,
    movement_on   TIMESTAMP     NOT NULL,
    order_id      UUID,
    CONSTRAINT pk_cash_movements PRIMARY KEY (movement_id),
    CONSTRAINT fk_cash_movements_account FOREIGN KEY (account_id) REFERENCES accounts (id),
    CONSTRAINT ck_cash_movements_type CHECK (movement_type IN ('DEPOSIT', 'WITHDRAWAL', 'BUY', 'SELL'))
);

CREATE INDEX ix_orders_account_created ON orders (account_id, created_on DESC);
CREATE INDEX ix_orders_symbol_created ON orders (symbol, created_on DESC);
CREATE INDEX ix_order_events_order ON order_events (order_id, event_time);
