# Postman observations

Target used (live platform or Prism mock):

## Token claims

| Claim | Value | What it controls |
|---|---|---|
| sub | | |
| accountId | | |
| roles | | |
| exp | | |

## Responses

| Request | Status | errorCode | Business rule (1-8) | BR ref | What it means for the user |
|---|---|---|---|---|---|
| Get account | | | | | |
| Get balance | | | | | |
| Get positions | | | | | |
| Get order history | | | | | |
| Get rejected orders | | | | | |
| Get another account | | | | | |
| Get balance without a token | | | | | |
| Place order (BUY) | | | | | |
| Place order (duplicate key) | | | | | |
| Place order (zero quantity) | | | | | |
| Place order (insufficient funds) | | | | | |
| Place order (unknown instrument) | | | | | |
| Place order (SELL more than held) | | | | | |
| Cancel order | | | | | |

## Questions

1. `Place order (BUY)` returned status `NEW`. What must the screen show next, and which BR
   requires it?
2. Two different failures return HTTP 409. How must the UI tell them apart?
3. Name one thing these calls cannot prove about BR-09.
