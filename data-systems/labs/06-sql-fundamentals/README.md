# Lab 06: Explore the trading schema

## Objectives

- Connect to the training database with pgAdmin or DBeaver.
- Write SQL (Structured Query Language) `SELECT` queries that choose columns, filter rows with `WHERE`, and sort with
  `ORDER BY`.
- Handle `NULL`, date ranges and lists of values correctly.

## Setup

1. Start the database: follow `shared/trading-db/README.md` (`docker compose up -d` in
   `shared/trading-db`).
2. Connect pgAdmin or DBeaver to host `localhost`, port `5432`, database `trading`, user
   `analyst`, password `analyst`.
3. Open `exercises.sql` from this folder in the query editor.

Time: 60 minutes, pairs.

## Tasks

1. Browse the table list and open the columns of `instruments`, `accounts` and `orders`.
   Note which column is the primary key of each.
2. Complete the eight tasks in `exercises.sql`. Write one query per task.
3. Record the row count each query returns in a comment beneath it.
4. For task 7, write one sentence on what a Trading Desk user would want to know about
   those accounts.

## Acceptance criteria

- All eight queries run without errors.
- Each query returns only the columns the task needs (no `SELECT *` except task 1 if you
  choose).
- Date filters use a half-open range (`>=` start and `<` next period start).
- Row counts are recorded in comments.

## Stretch

- Find the earliest and latest `created_on` in `orders` using `ORDER BY` and `LIMIT`.
- Find the orders whose `executed_price` differs from the requested `price` by more than 5
  percent.
