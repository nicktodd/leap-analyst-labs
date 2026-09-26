# Level 1 data flow diagram: order placement

Processes are numbered circles, data stores are marked D1 to D4, external entities are
rectangles. Every flow is labelled with the data it carries.

```mermaid
flowchart LR
    Client[Retail client]
    Market[Market data provider]
    Priya[Commercial analyst]
    P1((1.0 Validate order))
    P2((2.0 Execute order))
    P3((3.0 Report activity))
    D1[(D1 Accounts)]
    D2[(D2 Orders)]
    D3[(D3 Positions and cash)]
    D4[(D4 Reporting copy)]
    Client -- order request --> P1
    D1 -- account status and cash --> P1
    P1 -- accepted order --> D2
    P1 -- rejection reason --> Client
    D2 -- new order --> P2
    Market -- quote --> P2
    P2 -- fill --> D3
    P2 -- status update --> D2
    P2 -- order status --> Client
    D2 -- order history --> P3
    P3 -- activity extract --> D4
    D4 -- volumes by instrument --> Priya
```

Checks a reviewer applies:

- Every process has at least one input and one output.
- No flow runs directly between two data stores or between two external entities.
- Flows into and out of the platform match the context diagram.
