# Business rule trace: BR-05 (reference solution)

## 1. Call path for POST /api/v1/orders

1. `OrderController.placeOrder` (checks the token's `accountId` matches the request, BR-02)
2. `OrderService.placeOrder`
3. `OrderValidator.validate` (rules 1 to 7)
4. On success `OrderRepository.saveNew` (rule 8 by unique constraint), then
   `OrderPublisher.publishOrderPlaced`; on failure `OrderRepository.saveRejected`

## 2. Rule trace

| Contract rule | File and line | Error code thrown | Matches | Notes |
|---|---|---|---|---|
| 1 Account exists | OrderValidator.java 22-23 | ACC-404 | yes | |
| 2 Account ACTIVE | OrderValidator.java 26-28 | ACC-403 | yes | |
| 3 Instrument exists and tradable | OrderValidator.java 31-32 | INS-404 | partly | Existence only; the `tradable` flag is never checked |
| 4 Quantity > 0 | OrderValidator.java 35-37 | VAL-422 | yes | |
| 5 Price > 0 | OrderValidator.java 40-42 | VAL-422 | yes | |
| 6 BUY: cash >= quantity x price | OrderValidator.java 46-49 | ORD-400 | yes | `< 0` rejects only when cash is less than cost; BigDecimal used for money |
| 7 SELL: held >= quantity | OrderValidator.java 52-55 | ORD-409 | no | `held > quantity` rejects a sale of the entire holding |
| 8 Idempotency key unique | OrderService.java (`saveNew`), database constraint | ORD-409 | yes, by design | Not in the validator; the contract requires the database constraint |

## 3. Copilot explanation

Typical errors to look for in the AI answer: stating that rule 3 checks tradability (wrong:
line 31 only looks the symbol up); describing rule 7 as "at least" (wrong: line 53 is strictly
greater than); claiming the validator checks duplicates (wrong: rule 8 is in the database).
Statements about the repositories' behaviour are unverifiable from this code.

## 4. Findings

| # | Contract says | Code does | Example order treated wrongly | BR at risk | Resolved by |
|---|---|---|---|---|---|
| 1 | SELL allowed when held quantity is at least the order quantity | Requires held quantity strictly greater than the order quantity | Account 1 holds 100 ACME and sells 100: rejected with ORD-409 | BR-05, BR-04, 9.5 usability | Engineer fixes; analyst writes the acceptance criterion and test case |
| 2 | Instrument must exist and be tradable | Checks existence only | BUY 10 TSLA after it was made non-tradable: accepted | BR-05, BR-12 | Engineer; confirm with Trading Desk whether the executor also checks |

Acceptable additional observation: the controller checks the token's account before rule 1,
so a request for a non-existent account by another user returns ACC-403 rather than ACC-404.
That hides whether an account exists, which is arguably correct for security; record it as a
question, not a defect.

## 5. Questions for the engineer

- Is `tradable` checked anywhere else, for example in the Trade Executor before the fill?
- Is there a unit test for selling an entire position, and what does it expect?
- Does `findQuantity` return the net position, or a figure that excludes pending sells?

## Marking notes

- Finding 1 is the key finding; accept it expressed in plain words without Java terms.
- Finding 2 links to the Week 2 anomaly of a fill on a non-tradable instrument (TSLA).
- The analyst stops at "the code does not match the contract, here is an example"; fixing
  the code is the engineer's job.
