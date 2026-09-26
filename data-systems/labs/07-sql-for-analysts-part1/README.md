# Lab 07: Joins and aggregation

## Objectives

- Join tables in SQL (Structured Query Language) on their key columns, including the `accounts.id` surrogate key.
- Summarise data with `GROUP BY`, `COUNT`, `SUM` and `HAVING`.
- Read a query written by someone else and explain what it returns.

## Setup

1. Connect to the training database as in Lab 06.
2. Open `exercises.sql` and `read-this-query.sql` from this folder.

Time: 75 minutes, pairs.

## Tasks

1. Complete tasks 1 to 9 in `exercises.sql`, recording answers in comments.
2. For task 5, explain in a comment why currency must appear in the `GROUP BY`.
3. For task 10, run `read-this-query.sql`, then write a plain-English description of the
   result and at least one question you would put to its author.

## Acceptance criteria

- Joins between `orders` and `accounts` use `orders.account_id = accounts.id`.
- No query adds GBP and USD values together.
- Task 7 uses `HAVING`, not `WHERE`, to filter on the count.
- Task 9 uses a `LEFT JOIN` and states the result, even if it is empty.
- The task 10 explanation names at least one weakness in the query.

## Stretch

- Produce a monthly report of filled value by currency and asset class, in one query.
