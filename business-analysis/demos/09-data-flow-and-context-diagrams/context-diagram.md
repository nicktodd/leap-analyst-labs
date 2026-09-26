# Context diagram: direct trading platform

The system is one box. Everything outside it is an external entity. Arrows are named data flows.

```mermaid
flowchart LR
    Client[Retail client]
    Desk[Trading Desk]
    Risk[Risk and Compliance]
    Finance[Finance]
    Market[Market data provider]
    P((Direct trading platform))
    Client -- order request --> P
    P -- order status and holdings --> Client
    Market -- quotes --> P
    Desk -- trading rules --> P
    P -- trade record and audit trail --> Risk
    P -- trading activity reports --> Finance
```

Sources: BRS section 5 (stakeholders), BR-04, BR-08, BR-10, BR-14, BR-16.
