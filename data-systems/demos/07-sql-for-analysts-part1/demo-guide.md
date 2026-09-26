# Demo: Module 07 - SQL for analysts Part 1

**Duration:** 25 minutes
**Prerequisite:** Module 06 demo completed; `demos/07-sql-for-analysts-part1/demo.sql` open.

## Part 1: joining on the surrogate key (6 min)

1. Run Part 1. Narration: `orders.account_id` holds the numeric `accounts.id`. Joining it to
   `accounts.account_id` (the ACC- reference) returns nothing or an error, a common first
   mistake.
2. Show the result: the ACC- reference and holder name now sit beside each order.

## Part 2: GROUP BY and COUNT (5 min)

1. Run Part 2: FILLED 1127, CANCELLED 150, REJECTED 95, total 1372.
2. Narration: every column in the `SELECT` is either grouped or aggregated.

## Part 3: SUM across currencies (8 min)

1. Run Part 3. Point out the GBP and USD blocks.
2. Remove `i.currency` from the `SELECT` and `GROUP BY`, group by asset class only, and ask
   what the total means. Answer: nothing, because it adds pounds to dollars.
3. Narration: one FILLED SPY order has no executed price; `SUM` skips it without warning.
   Aggregates hide gaps, so profile before summing.

## Part 4: WHERE versus HAVING (6 min)

1. Run Part 4: ACC-100017, ACC-100020 and ACC-100054 each have four rejected orders.
2. Narration: `WHERE` removes rows before grouping; `HAVING` removes groups after counting.

## Key message

Most analyst questions are "how many" or "how much, by what". Joins bring the business
labels in; grouping answers the question; checking units and nulls keeps the answer true.
