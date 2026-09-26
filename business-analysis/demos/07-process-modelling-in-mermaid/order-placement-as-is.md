# As-is: client trade through the phone dealing desk

Source: BRS section 2 (Business Background). At present a dealer stands behind every trade.

```mermaid
flowchart TD
    A([Client wants to trade]) --> B[Client phones dealing desk]
    B --> C{Dealer available}
    C -- No --> D[Client waits in queue or is called back]
    D --> B
    C -- Yes --> E[Dealer verifies client identity]
    E --> F[Dealer checks cash or holding]
    F --> G{Sufficient}
    G -- No --> H[Dealer explains and ends call]
    G -- Yes --> I[Dealer reads back order and price]
    I --> J[Dealer enters order in dealing system]
    J --> K[Order executed at market]
    K --> L[Dealer confirms fill by phone]
    L --> M[Back office posts cash and holding overnight]
    M --> N([Client sees update next day])
```

Pain points to discuss:

- P1 Wait for a dealer (no client self-service)
- P2 Manual re-keying of the order by the dealer
- P3 Holdings and cash updated in an overnight batch, not at the fill
