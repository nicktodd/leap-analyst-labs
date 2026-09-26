# To-be: client places an order on the direct trading platform

Sources: BR-04 to BR-09, the Trade REST API contract (`shared/contracts/trade-api.yaml`) and
the Kafka topic catalogue (`shared/contracts/kafka-topics.md`).

```mermaid
flowchart TD
    A([Client signed in]) --> B[Client enters order]
    B --> C[Platform checks trading rules]
    C --> D{All rules pass}
    D -- No --> E[Order recorded as REJECTED]
    E --> F([Client sees reason])
    D -- Yes --> G[Order recorded as NEW]
    G --> H[Order published to orders topic]
    H --> I[Executor prices against current quote]
    I --> J{Fill rules met}
    J -- No --> K[Order updated to REJECTED]
    J -- Yes --> L[Order, cash and position updated together]
    K --> M[Outcome published to trade-events]
    L --> M
    M --> N([Client sees status change without refresh])
```

Traceability:

| Step | Requirement |
|---|---|
| Platform checks trading rules | BR-05 |
| Order recorded as NEW before execution | BR-06 |
| Executor prices against current quote | BR-08 |
| Order, cash and position updated together | BR-09 |
| Client sees status change without refresh | BR-07 |
