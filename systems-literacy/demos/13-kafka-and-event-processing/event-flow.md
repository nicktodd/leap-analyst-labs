# Order events through Kafka

Source: `shared/contracts/kafka-topics.md`.

```mermaid
flowchart LR
  T["Trade REST API"] -->|"produce ORDER_PLACED<br/>key accountId"| O(["orders<br/>3 partitions"])
  O -->|"group trade-executor"| X["Trade Executor"]
  X -->|"produce ORDER_FILLED,<br/>REJECTED, CANCELLED"| E(["trade-events<br/>3 partitions"])
  E -->|"group portfolio-service"| P["Portfolio and P&L"]
  E -->|"group notification-service"| N["Customer notifications"]
  E -->|"group analytics-loader"| L["Python ETL"]
  M["Market-data poller"] -->|"key symbol"| Q(["market-data<br/>6 partitions"])
  Q --> P
```

## Tracing a missing fill

| Question | Where to look |
|---|---|
| Was the order recorded | `orders` table, status `NEW` |
| Was `ORDER_PLACED` published | `orders` topic, search by `orderId` |
| Did the executor consume it | Consumer group `trade-executor` lag |
| Did it fail and go to the dead-letter topic | `orders.DLT`, failure reason header |
| Was the outcome published | `trade-events`, search by `orderId` |
| Did a downstream consumer process it | That consumer group's lag and its own records |
