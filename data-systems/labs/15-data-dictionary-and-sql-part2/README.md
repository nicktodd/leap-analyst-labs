# Lab 15: Data dictionary and SQL Part 2

## Objectives

- Write SQL (Structured Query Language) subqueries and CTEs (Common Table Expressions) that test business rules from the
  Business Requirements Specification (BRS).
- Query production-like data safely, inside a read-only transaction.
- Author data dictionary entries that engineers can build against.

## What you need to know

Module 15 introduced subqueries, CTEs and read-only sessions. The tasks also use:

- `NOT EXISTS (SELECT ...)`: keeps a row only when the inner query returns nothing (Task 2).
- `CASE WHEN side = 'BUY' THEN quantity ELSE -quantity END`: chooses a value row by row
  (Task 4).
- `FULL OUTER JOIN`: keeps rows from both tables whether or not they match; missing columns
  are NULL (Task 4).
- `COALESCE(x, 0)`: returns 0 when x is NULL, so a missing row compares as zero (Task 4).
- Self-join: join a table to itself with two aliases, e.g. `orders o1 JOIN orders o2` (Task 7).
- `created_on + INTERVAL '5 seconds'`: adds a time span to a timestamp (Task 7).
- Stretch only: `RANK() OVER (PARTITION BY ... ORDER BY ...)` numbers rows within each group,
  giving equal values the same rank.

## Setup

1. Connect to the training database as in Lab 06.
2. Open `exercises.sql` from this folder.
3. Open `docs/15-DataDictionary.docx` (Week 2 docs folder).

Time: 120 minutes in project teams: 60 minutes SQL, 60 minutes data dictionary.

## Tasks

1. Start a read-only session with `BEGIN TRANSACTION READ ONLY;`.
2. Complete tasks 1 to 7 in `exercises.sql`. For each finding, note the BR number the data
   breaks.
3. End the session with `ROLLBACK;`.
4. In the data dictionary document, complete entries for `orders`, `order_events` and
   `positions` (every column), then for the entities your team added in Lab 10.
5. For each column record: business name, definition, data type, allowed values or format,
   nullability, source, owner and one validation rule.
6. Add the findings from step 2 to the "Known data issues" section of the dictionary.

## Acceptance criteria

- All queries run inside a read-only transaction.
- Tasks 2 to 7 each identify the specific order, account or settlement concerned.
- Every dictionary entry has a definition a non-engineer can understand, with no circular
  definitions ("status: the status").
- Allowed values match the check constraints in `shared/trading-db/01-schema.sql`.
- Known data issues cite the query that found them.

## Stretch

- Complete the stretch query in `exercises.sql` and explain how ties are handled.
