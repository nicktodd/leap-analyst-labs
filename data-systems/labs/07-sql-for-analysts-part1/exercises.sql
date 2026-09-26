-- Module 07 lab: joins and aggregation
-- Write one query under each task and record the answer in a comment.

-- Task 1: list every order with the account business reference (ACC-...) and holder name.
--         Hint: orders.account_id holds accounts.id, not accounts.account_id.

-- Task 2: count orders per status.

-- Task 3: count orders per channel and status.

-- Task 4: for each asset class, count FILLED orders.

-- Task 5: total filled value (quantity * executed_price) per instrument, grouped by currency.
--         Why must currency be in the GROUP BY?

-- Task 6: the five accounts with the most FILLED orders (show ACC- reference).

-- Task 7: accounts with three or more REJECTED orders.

-- Task 8: number of orders per month (use DATE_TRUNC('month', created_on)).

-- Task 9: accounts that have never placed an order (LEFT JOIN).

-- Task 10: read the query in read-this-query.sql. Write, in plain English, what it returns
--          and one question you would ask its author.
