-- Module 07 reference solutions (verified against the training database)

-- Task 1: 1312 rows
SELECT c.movement_id, a.account_id, a.holder_name, c.movement_type, c.amount, c.movement_on
FROM cash_movements c
JOIN accounts a ON a.id = c.account_id;

-- Task 2: BUY 1180, SELL 192
SELECT side, COUNT(*) AS order_count
FROM orders
GROUP BY side
ORDER BY order_count DESC;

-- Task 3: 6 rows (WEB FILLED 1032, DESK FILLED 95)
SELECT channel, status, COUNT(*) AS order_count
FROM orders
GROUP BY channel, status
ORDER BY channel, status;

-- Task 4: EQUITY 797, ETF 218, BOND 112
SELECT i.asset_class, COUNT(*) AS filled_orders
FROM orders o
JOIN instruments i ON i.symbol = o.symbol
WHERE o.status = 'FILLED'
GROUP BY i.asset_class
ORDER BY filled_orders DESC;

-- Task 5: 20 rows (top: GBP VOD 19834.09). Currency must be grouped because GBP and USD
-- amounts cannot be added together.
SELECT i.currency, o.symbol, SUM(o.quantity * o.executed_price) AS filled_value
FROM orders o
JOIN instruments i ON i.symbol = o.symbol
WHERE o.status = 'FILLED'
  AND o.side = 'SELL'
GROUP BY i.currency, o.symbol
ORDER BY i.currency, filled_value DESC;

-- Task 6: ACC-100026 and ACC-100033 lead with 30 fills each
SELECT a.account_id, a.holder_name, COUNT(*) AS filled_orders
FROM orders o
JOIN accounts a ON a.id = o.account_id
WHERE o.status = 'FILLED'
GROUP BY a.account_id, a.holder_name
ORDER BY filled_orders DESC
LIMIT 5;

-- Task 7: 7 rows; ACC-100010, ACC-100020 and ACC-100041 have 6 each
SELECT a.account_id, COUNT(*) AS cancelled_orders
FROM orders o
JOIN accounts a ON a.id = o.account_id
WHERE o.status = 'CANCELLED'
GROUP BY a.account_id
HAVING COUNT(*) >= 5
ORDER BY cancelled_orders DESC;

-- Task 8: 6 rows, January to June 2026
SELECT DATE_TRUNC('month', created_on) AS month, COUNT(*) AS orders
FROM orders
GROUP BY DATE_TRUNC('month', created_on)
ORDER BY month;

-- Task 9: 0 rows. Every account has at least one order; an empty result is a valid answer.
SELECT a.account_id, a.holder_name, a.status
FROM accounts a
LEFT JOIN orders o ON o.account_id = a.id
WHERE o.id IS NULL;

-- Task 10 (model answer): one row per asset class per month, showing how many distinct
-- accounts had a fill and the summed traded value. Questions for the author: the value
-- adds GBP and USD together (it must be split by currency); one FILLED order (SPY, March)
-- has a NULL executed_price, so SUM drops it from the value without warning; COUNT(DISTINCT account_id) counts accounts, not clients.
