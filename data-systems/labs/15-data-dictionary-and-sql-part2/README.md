# Lab 15: Data dictionary and SQL Part 2

## Objectives

- Write SQL (Structured Query Language) subqueries and CTEs (Common Table Expressions) that test business rules from the
  Business Requirements Specification (BRS).
- Query production-like data safely, inside a read-only transaction.
- Author data dictionary entries that engineers can build against.

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
