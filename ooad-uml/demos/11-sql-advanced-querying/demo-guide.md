# Demo: Module 11 - SQL for analysis: advanced querying

**Duration:** 30 minutes
**Prerequisite:** training database running; pgAdmin or DBeaver connected; `demos/11-sql-advanced-querying/demo.sql` open.

## Part 1: ROW_NUMBER (5 min)

1. Run Part 1. Narration: `OVER (PARTITION BY account_id ORDER BY created_on DESC)` numbers
   each account's orders newest first; keeping `rn = 1` gives the latest order per account.
2. Compare with `GROUP BY`: grouping loses the other columns, a window keeps them.

## Part 2: RANK (8 min)

1. Run Part 2. Result: the top three instruments by filled value for each month, January to
   June 2026 (18 rows). VWRL leads January at 30647.37.
2. Ask: why does the query filter `executed_price IS NOT NULL`. One filled order has no
   executed price. Leave the question open: Lab 13 returns to it.

## Part 3: running total (7 min)

1. Run Part 3 for account 3 (ACC-100003). The `amount` column is signed, so a running
   `SUM(amount)` is the cash balance over time. After the first ten movements it stands at
   10789.04.
2. Narration: the full sum for the account (7890.04) equals `accounts.cash_balance`. A
   reconciliation like this is how an analyst checks the model rule "balance is the sum of
   movements".

## Part 4: LAG (5 min)

1. Run Part 4. The order took 23 seconds from VALIDATED to FILLED.
2. Narration: time between lifecycle events is a service measure, and it feeds the
   responsiveness expectation in section 9.2 of the BRS.

## Part 5: FILTER (5 min)

1. Run Part 5. WEB: 1259 orders, 7.1 percent rejected. DESK: 113 orders, 5.3 percent.
2. Ask: what would you need to know before saying the desk "performs better".

## Key message

Window functions answer questions that compare a row with its neighbours: latest, top N,
running totals and gaps between events. They are the analyst's main tool for checking a model
rule across the whole dataset.
