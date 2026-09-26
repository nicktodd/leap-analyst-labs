# Reading an OpenAPI contract: analyst checklist

Use this list when reviewing a contract in `shared/contracts/` ahead of sign-off. Record each
answer against the screen that depends on it.

| # | Question | Where to look | Example from `trade-api.yaml` |
|---|---|---|---|
| 1 | What does the service do, in one sentence | `info.summary` | Order placement, order cancellation and account queries |
| 2 | Which business rules does it enforce, and in what order | `info.description` | Eight rules; the first failure wins |
| 3 | Which endpoints does each screen need | `paths` | Order ticket: `POST /api/v1/orders`, `DELETE /api/v1/orders/{id}` |
| 4 | Which fields are required, and what are their limits | `components.schemas`, `required`, `minimum`, `maxLength` | `quantity` minimum 1; `price` above 0, two decimal places |
| 5 | Which values are allowed | `enum` | `OrderStatus`: NEW, FILLED, REJECTED, CANCELLED |
| 6 | What comes back on success | `responses.'200'` | `OrderResponse` with `status` NEW (Sprint 7 onwards) |
| 7 | Every way it can fail | `responses` 4xx, `ErrorResponse.errorCode` | Seven error codes; 404 and 409 each carry two |
| 8 | Who may call it | `security`, `securitySchemes`, `auth-api.yaml` claims | Bearer JWT (JSON Web Token); `accountId` claim must match |
| 9 | What the user must never see | descriptions | No stack trace or SQL (Structured Query Language) in `message` |
| 10 | What the contract leaves out that a screen needs | compare with the wireframe | No market value on `/balance`; only two roles |

## Findings template

| Screen | Finding | Contract reference | Question for | Status |
|---|---|---|---|---|
| Portfolio | Market value is not on `/balance` or `/positions` | `getBalance`, `getPositions` | Product owner | Open |
| Order ticket | Order still `NEW` when the response arrives; screen needs a working state | `placeOrder` description | Engineering lead | Resolved in state diagram |
| All | Roles are `CUSTOMER` and `ADMIN` only; no read-only operations role | `auth-api.yaml` `Role` | Risk and Compliance | Open |
