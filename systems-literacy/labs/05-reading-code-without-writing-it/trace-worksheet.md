# Business rule trace: BR-05

## 1. Call path for POST /api/v1/orders

1.
2.
3.
4.

## 2. Rule trace

| Contract rule | File and line | Error code thrown | Matches the contract (yes / no / partly) | Notes |
|---|---|---|---|---|
| 1 Account exists | | | | |
| 2 Account ACTIVE | | | | |
| 3 Instrument exists and tradable | | | | |
| 4 Quantity > 0 | | | | |
| 5 Price > 0 | | | | |
| 6 BUY: cash >= quantity x price | | | | |
| 7 SELL: held >= quantity | | | | |
| 8 Idempotency key unique | | | | |

## 3. Copilot explanation, verified

| Copilot statement | Verified / wrong / unverifiable | Evidence (line) |
|---|---|---|
| | | |

## 4. Findings

| # | Contract says | Code does | Example order treated wrongly | BR at risk | Resolved by |
|---|---|---|---|---|---|
| 1 | | | | | |
| 2 | | | | | |

## 5. Questions for the engineer
