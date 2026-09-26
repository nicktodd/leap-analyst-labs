-- Module 15 lab: SQL Part 2 (subqueries, CTEs, safe querying)
-- Start every session with:  BEGIN TRANSACTION READ ONLY;   and end with ROLLBACK;
-- Each task tests a business rule from the BRS. Record what you find.

-- Task 1 (subquery): accounts whose cash_balance is above the average cash_balance.
--         Hint: WHERE cash_balance > (SELECT AVG(cash_balance) FROM accounts)

-- Task 2 (subquery, BR-14/BR-15): FILLED orders with no FILLED row in order_events.
--         Hint: WHERE NOT EXISTS (SELECT 1 FROM order_events e
--                WHERE e.order_id = o.id AND e.event_type = 'FILLED')

-- Task 3 (CTE, BR-05): orders FILLED for an account after the date that account became
--         SUSPENDED or CLOSED (accounts.status_changed_on). Show the channel.
--         Hint: CTE 1 = non-ACTIVE accounts; then join orders and compare
--         o.created_on > i.status_changed_on.

-- Task 4 (CTE, BR-09): for each account and symbol, compare positions.quantity with the
--         net filled quantity (BUY minus SELL). List the mismatches.
--         Hint: CTE with SUM(CASE WHEN side = 'BUY' THEN quantity ELSE -quantity END),
--         then FULL OUTER JOIN positions and compare with COALESCE(..., 0).

-- Task 5 (CTE, BR-05/BR-08): FILLED orders for an instrument that is not tradable,
--         placed on or after 2026-04-01.
--         Hint: adapt the Module 15 demo CTE; keep only status = 'FILLED'.

-- Task 6: settlements whose settlement_date is earlier than their trade_date.
--         Hint: a simple WHERE comparing the two columns.

-- Task 7: pairs of FILLED orders from the same account, symbol, side and quantity created
--         within 5 seconds of each other (possible duplicates, BR-09).
--         Hint: self-join orders o1 JOIN orders o2 on account, symbol, side and quantity,
--         with o2.created_on > o1.created_on
--         AND o2.created_on <= o1.created_on + INTERVAL '5 seconds'.

-- Stretch: for each month, the most traded instrument by number of fills (use a CTE and
--          RANK() or a correlated subquery).
--          Hint: RANK() OVER (PARTITION BY month ORDER BY COUNT(*) DESC); keep rank 1.
