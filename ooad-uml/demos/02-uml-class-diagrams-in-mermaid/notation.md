# UML class diagram notation in Mermaid

Each diagram below shows one relationship type from Module 02, using classes from the
Enterprise Trading Platform. GitHub renders the diagrams when this file is viewed in the
browser.

## 1. A class with attributes and operations

```mermaid
classDiagram
    class Order {
        +UUID id
        +Side side
        +int quantity
        +decimal price
        +OrderStatus status
        +place()
        +cancel()
    }
```

## 2. Association with multiplicity

```mermaid
classDiagram
    Account "1" --> "0..*" Order : places
```

## 3. Aggregation: the part can exist without the whole

```mermaid
classDiagram
    Account "1" o-- "0..*" Position : holds
```

## 4. Composition: the part lives and dies with the whole

```mermaid
classDiagram
    Order "1" *-- "1..*" OrderEvent : audit trail
```

## 5. Inheritance (generalisation)

```mermaid
classDiagram
    Instrument <|-- Equity
    Instrument <|-- ETF
    Instrument <|-- Bond
    class Instrument {
        +string symbol
        +string currency
        +bool tradable
    }
    class Bond {
        +date maturity
    }
```

## 6. Enumerations

```mermaid
classDiagram
    class OrderStatus {
        <<enumeration>>
        NEW
        FILLED
        REJECTED
        CANCELLED
    }
    Order --> OrderStatus
```
