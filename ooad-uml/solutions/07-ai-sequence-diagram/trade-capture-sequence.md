# Trade capture sequence (reference solution)

Validated against `ARCHITECTURE.md`, `trade-api.yaml` (placeOrder), `kafka-topics.md` and
the Business Requirements Specification (BRS).

```mermaid
sequenceDiagram
    autonumber
    actor Joanna as Joanna (client)
    participant UI as Angular UI
    participant Auth as Auth service
    participant API as Trade REST API
    participant DB as Postgres
    participant K as Kafka
    participant Exec as Trade Executor
    participant Faux as Fauxnance API

    Note over Joanna,Auth: Joanna is already signed in and holds a JWT (BR-01, BR-03)
    Joanna->>UI: Buy 10 AAPL
    UI->>API: POST /api/v1/orders {accountId, symbol, side, quantity, price, idempotencyKey} + Bearer JWT
    API->>Auth: Verify token signature
    Auth-->>API: Valid, subject = accountId
    API->>DB: Read account, instrument, cash
    alt validation fails (not own account, not ACTIVE, not tradable, insufficient cash, duplicate key)
        API-->>UI: 4xx with errorCode (ACC-403, INS-404, ORD-400, ORD-409, VAL-422)
        UI-->>Joanna: Order rejected, reason shown
    else validation passes (BR-05)
        API->>DB: INSERT order status NEW + events RECEIVED, VALIDATED
        API->>K: ORDER_PLACED on orders topic (key accountId)
        API-->>UI: 200 {orderId, status NEW}
        UI-->>Joanna: Order accepted
        K->>Exec: Consume ORDER_PLACED
        Exec->>Faux: GET /quotes AAPL
        Faux-->>Exec: Current quote
        alt price acceptable (BR-08)
            Exec->>DB: One transaction: order FILLED + FILLED event + position + cash movement (BR-09, BR-14)
            Exec->>K: ORDER_FILLED on trade-events
        else rejected at execution
            Exec->>DB: One transaction: order REJECTED + REJECTED event
            Exec->>K: ORDER_REJECTED on trade-events
        end
        loop until a terminal status (BR-07)
            UI->>API: GET /api/v1/accounts/{id}/orders
            API-->>UI: Order status
        end
        UI-->>Joanna: Status and updated position
    end
```

## Defects in the Copilot draft

| # | Defect | Evidence | Rule broken |
|---|---|---|---|
| 1 | Login inside the order flow | Auth issues the token at sign-in, not per order | ARCHITECTURE.md |
| 2 | UI calls Fauxnance directly and sends its own price | Executor prices at execution; the UI has no API key | BR-08 |
| 3 | Order not recorded before publishing; INSERT happens only on fill | The Trade REST API writes the order as NEW first | BR-06 |
| 4 | Topic named `trades` | Catalogue name is `orders` | kafka-topics.md |
| 5 | No validation step before accepting | Rules 1 to 8 in placeOrder | BR-05 |
| 6 | Position, order and cash updated in three separate writes | Must change together | BR-09 |
| 7 | No audit events written | order_events RECEIVED, VALIDATED, FILLED | BR-14, BR-15 |
| 8 | Executor replies to the API synchronously | Executor publishes to trade-events; nothing waits | ARCHITECTURE.md |
| 9 | Response 201 with status FILLED | Contract returns 200 with status NEW | trade-api.yaml |
| 10 | Endpoint `/orders`, missing accountId and idempotencyKey | `/api/v1/orders` with PlaceOrderRequest | trade-api.yaml |
| 11 | Generic 500 as the only error; no rejection path | Named error codes and a rejected status | trade-api.yaml, BR-07 |
| 12 | No check that the account belongs to the client | Token subject must match accountId | BR-02 |
