# Place an order: sequence diagram from the contract

Derived from `shared/contracts/trade-api.yaml` (operation `placeOrder`) and
`shared/contracts/auth-api.yaml` (operation `login`). Sprint 7 behaviour: the API returns `NEW`.

```mermaid
sequenceDiagram
  actor J as Joanna
  participant UI as Angular UI
  participant A as Auth service
  participant T as Trade REST API
  J->>UI: Enter order and press Buy
  UI->>A: POST /auth/login
  A-->>UI: 200 accessToken, refreshToken
  UI->>T: POST /api/v1/orders (Bearer token)
  alt token missing or invalid
    T-->>UI: 401 AUTH-401
  else business rule fails
    T-->>UI: 400, 403, 404, 409 or 422 with errorCode
  else accepted
    T-->>UI: 200 orderId, status NEW
  end
  UI-->>J: Show order status
```

## Reading it

- Solid arrows are requests; dashed arrows are responses.
- The `alt` block lists the outcomes the contract allows. Every branch comes from a
  `responses` entry in the YAML.
- The UI must branch on `errorCode`, never on `message` and never on the HTTP status alone:
  404 and 409 each carry two codes.
