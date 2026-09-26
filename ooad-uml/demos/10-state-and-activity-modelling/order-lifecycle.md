# The lifecycle of a trade: state and activity views

## State diagram: the Order

The states match `orders.status` (NEW, FILLED, REJECTED, CANCELLED) and the audit events in
`order_events` (RECEIVED, VALIDATED, REJECTED, FILLED, CANCELLED).

```mermaid
stateDiagram-v2
    [*] --> Received : client submits
    Received --> Rejected : invalid (BR-05)
    Received --> New : recorded (BR-06)
    New --> Filled : executed (BR-08)
    New --> Rejected : execution rejected
    New --> Cancelled : client cancels
    Filled --> [*]
    Rejected --> [*]
    Cancelled --> [*]

    state Filled {
        [*] --> Pending
        Pending --> Settled : T+1 or T+2
        Pending --> SettlementFailed
    }
```

Rules the diagram states, which the data must obey (Lab 13 tests them):

- A FILLED order has an executed price and time.
- Every state change writes one audit event.
- No transition leaves a terminal state.
- Settlement is T+1 for equities and ETFs, T+2 for bonds.

## Activity diagram: placing an order

Mermaid has no activity diagram type. A flowchart with decision diamonds and swimlanes
(subgraphs) serves the same purpose.

```mermaid
flowchart TB
    subgraph Client
        A([Start]) --> B[Enter order]
        J[See status update]
    end
    subgraph TradeAPI["Trade REST API"]
        C{Account ACTIVE and owned by client?}
        D{Instrument tradable?}
        E{Sufficient cash or holding?}
        F[Record order as NEW and publish to orders topic]
        R[Return rejection]
    end
    subgraph Executor["Trade Executor"]
        G[Get current quote]
        H{Price acceptable?}
        I[Update position, cash and trade record together]
        X[Publish ORDER_REJECTED]
    end
    B --> C
    C -- no --> R
    C -- yes --> D
    D -- no --> R
    D -- yes --> E
    E -- no --> R
    E -- yes --> F
    F --> G --> H
    H -- yes --> I --> J
    H -- no --> X --> J
    R --> J
    J --> K([End])
```
