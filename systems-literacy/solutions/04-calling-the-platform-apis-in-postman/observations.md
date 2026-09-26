# Postman observations: reference solution

Results below are those defined by `shared/contracts/trade-api.yaml`. Against the Prism mock
they are the contract examples; against the live platform the values differ but the status
codes and `errorCode` values must match. A mismatch on the live platform is a defect to raise.

## Token claims

| Claim | Value | What it controls |
|---|---|---|
| sub | A UUID for the user | Identity; stable even if username changes |
| accountId | 1 (numeric `ACCOUNTS.id`) | Which account the token can reach (BR-02) |
| roles | `["CUSTOMER"]` | Authorisation level |
| exp | `iat` + 900 seconds | Session time limit of 15 minutes (BR-03) |

## Responses

| Request | Status | errorCode | Business rule | BR ref | What it means for the user |
|---|---|---|---|---|---|
| Get account | 200 | none | none | BR-02, BR-10 | Account details shown; `accountId` in the body is the string `ACC-000001`, not the key |
| Get balance | 200 | none | none | BR-10 | Available cash only, not the value of holdings |
| Get positions | 200 | none | none | BR-10 | Quantity and average cost; zero positions are omitted; no market value |
| Get order history | 200 | none | none | BR-11, BR-15 | Every order, newest first, including rejected and cancelled |
| Get rejected orders | 200 | none | none | BR-11 | Filter by `status`; default is unfiltered because it is the audit trail |
| Get another account | 403 | ACC-403 | Authentication section | BR-02 | Valid token, wrong account: access refused |
| Get balance without a token | 401 | AUTH-401 | Authentication section | BR-01, BR-03 | User must sign in again |
| Place order (BUY) | 200 | none | 1 to 8 passed | BR-04, BR-06 | Order recorded as `NEW`; fill follows later |
| Place order (duplicate key) | 409 | ORD-409 (Duplicate order) | 8 | BR-14, section 9.1 | Retry did not create a second order |
| Place order (zero quantity) | 422 | VAL-422 | 4 | BR-05 | Field validation message on the order ticket |
| Place order (insufficient funds) | 400 | ORD-400 | 6 | BR-05 | Tell Joanna she does not have enough cash |
| Place order (unknown instrument) | 404 | INS-404 | 3 | BR-05, BR-12 | Instrument not found or not tradable |
| Place order (SELL more than held) | 409 | ORD-409 (Insufficient holdings) | 7 | BR-05 | Tell Joanna she does not hold enough |
| Cancel order | 200 or 409 | ORD-409 if not NEW | Cancel operation | BR-07, BR-11 | Cancelled only while still `NEW` |

## Questions

1. The order is recorded but not executed. The screen must show it as submitted and update to
   filled or rejected without a manual refresh (BR-07). Until push is built the UI polls
   `GET /api/v1/accounts/{id}/orders`; it must not retry the POST with the same key.
2. Both are `ORD-409`, and the contract separates them only by the `message` text, which it
   also says never to branch on. The UI can use context (a SELL order versus a repeated key),
   but this is a contract gap worth raising: a separate code for duplicates would remove the
   ambiguity.
3. That holdings, cash and the trade record updated together (atomicity). The API response
   shows only the order status. Evidence needs the database (Week 2 SQL) or the
   `trade-events` payload (`cashDelta`, `positionQuantityAfter`).

## Marking notes

- The mock cannot prove any business rule is enforced; strong answers say so.
- Strong answers spot the two meanings of `accountId` and the shared `ORD-409` code.
