# Enterprise Trading Platform: context and data feeds

Source: `leap-enterprise-trading-platform/docs/ARCHITECTURE.md`. The feeds marked
*illustrative* are not built by the engineering track; they show the kind of file-based and
scheduled integrations a platform of this type has in a firm such as Fidelity.

## Services and stores

```mermaid
flowchart LR
  UI["Angular UI"] -->|"login"| AUTH["Auth service"]
  UI -->|"REST + JWT"| TRADE["Trade REST API"]
  TRADE -->|"read and write"| PG[("PostgreSQL<br/>system of record")]
  TRADE -->|"orders topic"| K["Kafka"]
  K -->|"orders"| EXEC["Trade Executor"]
  EXEC -->|"quote"| FAUX["Fauxnance API"]
  EXEC -->|"fills, cash, positions"| PG
  EXEC -->|"trade-events topic"| K
  POLL["Market-data poller"] -->|"market-data topic"| K
  POLL -->|"quotes"| FAUX
  PG -->|"scheduled extract"| ETL["Python ETL"]
  ETL --> WH[("Analytical store")]
```

## Inbound and outbound feeds

```mermaid
flowchart LR
  subgraph IN["Inbound"]
    Q["Fauxnance quotes<br/>API, polled"]
    B["Broker trade file<br/>daily CSV, staging_trade_feed"]
    R["Instrument reference data<br/>daily file, illustrative"]
  end
  P["Enterprise Trading Platform"]
  subgraph OUT["Outbound"]
    A["Analytical store<br/>nightly ETL extract"]
    S["Settlement instructions<br/>file to custodian, illustrative"]
    G["Finance ledger extract<br/>end of day, illustrative"]
    T["Regulatory transaction report<br/>T+1 file, illustrative"]
  end
  Q --> P
  B --> P
  R --> P
  P --> A
  P --> S
  P --> G
  P --> T
```

## Questions an analyst asks of every feed

| Question | Example answer for the broker trade file |
|---|---|
| Who owns it, upstream and downstream | Broker A operations; loaded by the platform ETL |
| Format and transport | CSV over SFTP (Secure File Transfer Protocol) |
| Schedule and cut-off | Once per business day, by 06:00 ET (Eastern Time) |
| Volume | A few hundred rows per file |
| What happens when it is late or missing | Reconciliation cannot run; desk alerted |
| What happens to a bad row | Quarantined with a reason code (Week 2 Module 13) |
| Which requirement it serves | BR-15 reconstruction, BR-16 reporting |
