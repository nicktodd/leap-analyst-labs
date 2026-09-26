# Trading platform class model (first draft)

Team: <names>

```mermaid
classDiagram
    direction LR

    class Client {
        +string name
        +string email
    }

    class Account {
        +string accountRef
        +AccountStatus status
    }

    class Order {
        +UUID id
    }

    Client "1" --> "1..*" Account : owns
    Account "1" --> "0..*" Order : places

    %% TODO: add Instrument and its subtypes
    %% TODO: add Position, OrderEvent, CashMovement, Settlement, Quote
    %% TODO: add multiplicities to every relationship
```

## Traceability

| Class | Responsibility | BR references |
|---|---|---|
| Client | Registers and signs in | BR-01, BR-02 |
| Account | | |
| Order | | |

## Change log

| Change | Reason (review finding) |
|---|---|
| | |
