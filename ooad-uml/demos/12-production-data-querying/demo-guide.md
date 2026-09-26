# Demo: Module 12 - Production data querying

**Duration:** 15 minutes
**Prerequisite:** training database running; `demos/12-production-data-querying/safe-patterns.sql` open.

## Part 1: read-only by default (5 min)

1. Run Part 1: `BEGIN TRANSACTION READ ONLY` and a 30 second statement timeout.
2. Uncomment and run the UPDATE in Part 2. Result: `ERROR: cannot execute UPDATE in a
   read-only transaction`. Run `ROLLBACK` and start again from Part 1.
3. Narration: a read-only connection is a control, not a courtesy. In production the
   analyst's role should have no write permission at all.

## Part 2: count, then fetch (3 min)

1. Run Part 3: 217 orders since 1 June 2026. Narration: check the size before pulling rows.

## Part 3: minimise personal data (4 min)

1. Run Part 4. Names and email addresses are masked in the query itself.
2. Narration: select only the columns the question needs; personal data that never leaves
   the database cannot leak from a spreadsheet.

## Part 4: check the plan (3 min)

1. Run Part 5. The plan uses the index `ix_orders_account_created`.
2. Narration: a query that scans a large table can slow live trading (BR-16). Heavy analysis
   belongs on the analytical store, not the operational database.

## Key message

Query production data read-only, with a time limit, for the columns you need, and with a
record of why you ran the query. Every query against production is an auditable event.
