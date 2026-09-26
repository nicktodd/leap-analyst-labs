-- Module 07 demo: joins, grouping and aggregation
-- Part 1: INNER JOIN orders to accounts to show the business reference
SELECT a.account_id, a.holder_name,
       o.symbol, o.side, o.quantity, o.status
FROM orders o
JOIN accounts a ON a.id = o.account_id
ORDER BY o.created_on
LIMIT 10;

-- Part 2: count orders by status
SELECT status, COUNT(*) AS order_count
FROM orders
GROUP BY status
ORDER BY order_count DESC;

-- Part 3: filled value per currency
-- (never add GBP to USD)
SELECT i.currency, o.symbol,
       COUNT(*) AS fills,
       SUM(o.quantity * o.executed_price)
         AS filled_value
FROM orders o
JOIN instruments i ON i.symbol = o.symbol
WHERE o.status = 'FILLED'
GROUP BY i.currency, o.symbol
ORDER BY i.currency, filled_value DESC;

-- Part 4: HAVING filters groups,
-- WHERE filters rows
SELECT a.account_id,
       COUNT(*) AS rejected_orders
FROM orders o
JOIN accounts a ON a.id = o.account_id
WHERE o.status = 'REJECTED'
GROUP BY a.account_id
HAVING COUNT(*) >= 4
ORDER BY rejected_orders DESC;
