-- Module 15 lab: SQL Part 2 (subqueries, CTEs, safe querying)
-- Start every session with:  BEGIN TRANSACTION READ ONLY;   and end with ROLLBACK;
-- Each task tests a business rule from the BRS. Record what you find.

-- Task 1 (subquery): accounts whose cash_balance is above the average cash_balance.

-- Task 2 (subquery, BR-14/BR-15): FILLED orders with no FILLED row in order_events.

-- Task 3 (CTE, BR-05): orders FILLED for an account after the date that account became
--         SUSPENDED or CLOSED (accounts.status_changed_on). Show the channel.

-- Task 4 (CTE, BR-09): for each account and symbol, compare positions.quantity with the
--         net filled quantity (BUY minus SELL). List the mismatches.

-- Task 5 (CTE, BR-05/BR-08): FILLED orders for an instrument that is not tradable,
--         placed on or after 2026-04-01.

-- Task 6: settlements whose settlement_date is earlier than their trade_date.

-- Task 7: pairs of FILLED orders from the same account, symbol, side and quantity created
--         within 5 seconds of each other (possible duplicates, BR-09).

-- Stretch: for each month, the most traded instrument by number of fills (use a CTE and
--          RANK() or a correlated subquery).
