# Trading platform class model (extended reference solution)

One defensible model. Other answers are acceptable where the choice is justified and traced
to the Business Requirements Specification (BRS).

```mermaid
classDiagram
    direction LR

    class Client {
        +string name
        +string email
        +register()
        +signIn()
    }
    class Account {
        +string accountRef
        +string country
        +RiskProfile riskProfile
        +decimal cashBalance
        +AccountStatus status
        +canTrade() bool
    }
    class Instrument {
        <<abstract>>
        +string symbol
        +string name
        +string currency
        +string exchange
        +bool tradable
    }
    class Equity
    class ETF
    class Bond {
        +date maturity
    }
    class Order {
        +UUID id
        +Side side
        +OrderType orderType
        +int quantity
        +decimal limitPrice
        +OrderStatus status
        +Channel channel
        +string idempotencyKey
        +decimal executedPrice
        +datetime executedOn
        +place()
        +cancel()
    }
    class OrderEvent {
        +EventType type
        +datetime eventTime
        +string detail
    }
    class Position {
        +int quantity
        +decimal averageCost
    }
    class CashMovement {
        +MovementType type
        +decimal amount
        +datetime movementOn
    }
    class Settlement {
        +date tradeDate
        +date settlementDate
        +SettlementStatus status
        +decimal amount
    }
    class Quote {
        +decimal price
        +datetime asOf
    }

    Client "1" --> "1..*" Account : owns
    Account "1" --> "0..*" Order : places
    Account "1" o-- "0..*" Position : holds
    Account "1" --> "0..*" CashMovement : records
    Instrument <|-- Equity
    Instrument <|-- ETF
    Instrument <|-- Bond
    Order "0..*" --> "1" Instrument : for
    Order "1" *-- "1..*" OrderEvent : audit trail
    Order "1" --> "0..1" Settlement : settles as
    Order "1" --> "0..2" CashMovement : moves cash
    Position "0..*" --> "1" Instrument : in
    Instrument "1" --> "0..*" Quote : priced by


    class Watchlist {
        +string name
        +addInstrument()
        +removeInstrument()
    }
    class PriceAlert {
        +decimal threshold
        +Direction direction
        +bool active
        +trigger()
    }
    class Notification {
        +Channel channel
        +string message
        +datetime sentOn
    }
    class AccountStatusChange {
        +AccountStatus fromStatus
        +AccountStatus toStatus
        +string reason
        +string changedBy
        +datetime changedOn
    }
    class Notifier {
        <<interface>>
        +send(Notification)
    }

    Account "1" --> "0..*" Watchlist : keeps
    Watchlist "0..*" --> "0..*" Instrument : tracks
    Account "1" --> "0..*" PriceAlert : sets
    PriceAlert "0..*" --> "1" Instrument : on
    Account "1" --> "0..*" Notification : receives
    Notification ..> Notifier : sent via
    Account "1" *-- "0..*" AccountStatusChange : status history
    
    %% agreed with engineering: fill stays as attributes of Order (no partial fills)
    %% agreed with engineering: cancel allowed only while status is NEW
    %% AccountStatusChange answers "when was the account suspended and why" (BR-05, BR-15)

    %% Aggregation: closed accounts still hold positions in the data, and a position
    %%   can be transferred, so its life is not bound to the account.
    %% Composition: an audit event has no meaning without its order (BR-14, BR-15).
    %% Inheritance: Bond adds maturity and settles T+2; equities and ETFs settle T+1.
```

## Traceability

| Class | Responsibility | BR references |
|---|---|---|
| Client | Registers, signs in, sees only own data | BR-01, BR-02, BR-03 |
| Account | Holds cash and positions; decides whether it can trade | BR-02, BR-05, BR-10 |
| Instrument (Equity, ETF, Bond) | Defines what can be traded and whether it is tradable | BR-04, BR-05, BR-12 |
| Order | Records the client's intent, independent of execution | BR-04, BR-06, BR-07 |
| OrderEvent | Permanent audit trail of each state change | BR-14, BR-15 |
| Quote | Current price used at execution | BR-08, BR-13 |
| Position | Current holding, updated with each fill | BR-09, BR-10 |
| CashMovement | Cash in and out, updated with each fill | BR-09, BR-10 |
| Settlement | What the trade settled as | BR-15 |

## Additions traced

| Element | Story or BR |
|---|---|
| Order.cancel() and CANCELLED status | US-03 Cancel an open order; BR-07 |
| Watchlist | US-06 Keep a watchlist (BR-18 candidate) |
| PriceAlert, Notification, Notifier | US-07 Price alert (BR-18 candidate) |
| AccountStatusChange | US-05 Suspended account cannot trade; BR-05, BR-15 |
| Order.channel | US-08 Desk orders follow the same rules; BR-05 |

## Elements with no requirement

- Client.email: needed for notifications (US-07); keep.
- Bond.maturity: no story uses it; keep, needed to derive T+2 settlement. Raise with the
  Trading Desk whether matured bonds must become untradable automatically.
