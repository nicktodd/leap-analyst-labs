# Demo: Module 15 - Subqueries, CTEs and safe querying

**Duration:** 20 minutes
**Prerequisite:** training database running; `demos/15-data-dictionary-and-sql-part2/demo.sql`
open.

## Part 1: a read-only session (4 min)

1. Run `BEGIN TRANSACTION READ ONLY;`.
2. Type `UPDATE accounts SET status = 'ACTIVE' WHERE id = 8;` and run it. Postgres refuses:
   the transaction is read only. Run `ROLLBACK;` then `BEGIN TRANSACTION READ ONLY;` again.
3. Narration: on shared or production-like data, make a write impossible before you start.

## Part 2: subquery (6 min)

1. Run Part 2. The inner query returns the non-tradable instruments (TSLA); the outer query
   finds orders for them from April 2026. One row: a FILLED TSLA order on 14 April 2026.
2. Narration: that fill breaks BR-05. The data model allowed it; the rule was not enforced.

## Part 3: the same question as a CTE (6 min)

1. Run Part 3. Each `WITH` block is a named step that can be run and checked on its own.
2. Narration: CTEs are how analysts make a long query reviewable by someone else.

## Part 4: connect to the dictionary (4 min)

1. Open `docs/15-DataDictionary.docx` and show the `instruments.tradable` entry.
2. Narration: the dictionary states the rule ("orders for a non-tradable instrument must be
   rejected"); the query tests it; the finding goes in "Known data issues".

## Key message

Subqueries and CTEs turn business rules into checks. Running them read-only keeps
investigation safe; recording results in the data dictionary makes them useful to the team.
