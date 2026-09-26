# Process map: client trade (reference solution)

Team versions will differ in detail. A good answer has the elements below.

## As-is: client trade through the phone dealing desk

```mermaid
flowchart TD
    A([Client wants to trade]) --> B[Client phones dealing desk]
    B --> C{Dealer available}
    C -- No --> D[P1 Client waits or is called back]
    D --> B
    C -- Yes --> E[Dealer verifies identity]
    E --> F[Dealer checks cash or holding in back-office screen]
    F --> G{Sufficient}
    G -- No --> H[Dealer explains and ends call]
    H --> X([No trade])
    G -- Yes --> I[Dealer reads back order and indicative price]
    I --> J[P2 Dealer re-keys order into dealing system]
    J --> K[Order executed at market]
    K --> L[Dealer confirms fill by phone]
    L --> M[P3 Back office posts cash and holding overnight]
    M --> N[P4 Paper and call recording form the audit trail]
    N --> O([Client sees update next day])
```

### Pain points

| Ref | Step | Pain point | Stakeholder affected |
|---|---|---|---|
| P1 | Dealer available | Client waits for a dealer; no self-service | Retail client (Joanna) |
| P2 | Dealer re-keys order | Manual re-keying risks wrong quantity or instrument | Trading Desk (David) |
| P3 | Back office posts overnight | Holdings and cash lag the fill by a day | Retail client, Finance |
| P4 | Audit trail | Reconstructing a disputed trade needs call recordings and paper | Trading Desk, Risk and Compliance |

## To-be: client places a buy order on the platform

```mermaid
flowchart TD
    A([Client signed in]) --> B[Client selects instrument and sees indicative price]
    B --> C[Client enters quantity and submits]
    C --> D[Platform checks trading rules]
    D --> E{All rules pass}
    E -- No --> F[Order recorded as REJECTED with reason]
    F --> G([Client sees rejection reason])
    E -- Yes --> H[Order recorded as NEW]
    H --> I[Client sees order accepted]
    H --> J[Executor prices against current quote]
    J --> K{Fill rules met}
    K -- No --> L[Order updated to REJECTED]
    K -- Yes --> M[Order, cash and position updated together]
    L --> N[Outcome published to trade-events]
    M --> N
    N --> O([Client sees final status without refresh])
```

### Handoffs and automation

| From | To | What is handed over | As-is | To-be decision |
|---|---|---|---|---|
| Client | Dealer | Order instruction by phone | Manual | Automated: client enters order directly |
| Dealer | Dealing system | Order details | Manual re-key | Removed |
| Dealing system | Back office | Fill for posting | Overnight batch | Automated: posted in the same transaction as the fill (BR-09) |
| Trade REST API | Trade Executor | Accepted order | Not applicable | Automated via the `orders` topic |
| Platform | Risk and Compliance | Audit trail | Call recordings and paper | Automated: order events recorded permanently (BR-14) |

### Traceability

| To-be activity | Requirement or open question | Stakeholder |
|---|---|---|
| Client sees indicative price | BR-13 | Retail client |
| Platform checks trading rules | BR-05 | Trading Desk |
| Order recorded as NEW | BR-06, BR-14 | Risk and Compliance |
| Executor prices against current quote | BR-08 | Trading Desk |
| Order, cash and position updated together | BR-09 | Finance |
| Client sees final status without refresh | BR-07 | Retail client |
| How long a NEW order may wait before it is treated as failed | Open question | Trading Desk (David) |
| Whether a rejected order at execution is shown differently from a validation rejection | Open question | Retail client research, Programme Sponsor |
