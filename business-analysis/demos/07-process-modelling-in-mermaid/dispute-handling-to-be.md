# To-be: answering a disputed fill on the direct trading platform

Sources: BR-08, BR-11, BR-14 and BR-15.

```mermaid
flowchart TD
    A([Client disputes a fill])
    A --> B[Ops opens dispute case]
    B --> C[Ops finds order by ID]
    C --> D[Platform shows order lifecycle]
    D --> E[Ops checks quote and time used]
    E --> F{Price correct}
    F -- No --> G[Ops raises correction]
    G --> H[Correction recorded]
    H --> I([Client refunded])
    F -- Yes --> J([Evidence sent to client])
```

Traceability:

| Step | Requirement |
|---|---|
| Platform shows order lifecycle | BR-15 (reconstruct the full lifecycle) |
| Ops checks quote and time used | BR-08, BR-15 |
| Correction recorded | BR-14 (the original record is never altered) |
| Ops finds order by ID | BR-11 (order history) |
