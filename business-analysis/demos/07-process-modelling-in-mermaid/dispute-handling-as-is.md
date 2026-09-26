# As-is: answering a client's disputed fill

Source: BRS section 2 and the Module 02 interview with David (disputes take up to two days).

```mermaid
flowchart TD
    A([Client disputes a fill])
    A --> B[Desk logs complaint]
    B --> C[Dealer recalls the call]
    C --> D[Ops requests call recording]
    D --> E[Ops asks engineers for logs]
    E --> F{Quote and time found}
    F -- No --> G[Ops chases again]
    G --> E
    F -- Yes --> H[Ops compares fill to quote]
    H --> I{Price correct}
    I -- No --> J([Client refunded])
    I -- Yes --> K([Explanation sent])
```

Pain points to discuss:

- P1 Up to two days per dispute, about forty disputes a month
- P2 The answer depends on memory and call recordings
- P3 Engineers are pulled into operations work to find logs
