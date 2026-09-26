# Demo: Module 06 - SQL fundamentals

**Duration:** 20 minutes
**Prerequisite:** training database running (`shared/trading-db/README.md`), pgAdmin or
DBeaver connected, `demos/06-sql-fundamentals/demo.sql` open.

## Part 1: the whole table (4 min)

1. Run `SELECT * FROM instruments;`.
2. Narration: 20 rows, one per listed instrument. `SELECT *` is fine for a 20-row reference
   table; on `orders` it is a habit to avoid.
3. Point at `tradable`: TSLA is the only `f` row.

## Part 2: choose columns, filter rows (5 min)

1. Run the LSE query. Five rows: VOD, HSBA, ULVR, VWRL and ISF. GILT30 is a GBP instrument
   but trades OTC (over the counter), so the filter on exchange excludes it.
2. Narration: text values go in single quotes and are case sensitive in Postgres.

## Part 3: combine and sort (6 min)

1. Run the rejected WEB orders query. Show `AND`, `ORDER BY ... DESC` and `LIMIT 10`. There are 89 rejected WEB orders; the limit shows the latest ten.
2. Change `DESC` to `ASC` and rerun. Ask what question each version answers.

## Part 4: NULL (5 min)

1. Run the `email IS NULL` query: two accounts, ACC-100012 and ACC-100035.
2. Change it to `email = NULL` and rerun: zero rows. Narration: `NULL` means unknown, and
   nothing is equal to unknown.

## Key message

Four clauses (`SELECT`, `FROM`, `WHERE`, `ORDER BY`) answer most first questions an analyst
asks of a table. Knowing how `NULL` behaves prevents the most common wrong answer.
