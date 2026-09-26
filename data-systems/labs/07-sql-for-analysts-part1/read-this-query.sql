-- Written by a colleague for the monthly commercial report. What does it return?
SELECT i.asset_class,
       DATE_TRUNC('month', o.executed_on) AS month,
       COUNT(DISTINCT o.account_id)       AS active_clients,
       SUM(o.quantity * o.executed_price) AS traded_value
FROM orders o
JOIN instruments i ON i.symbol = o.symbol
WHERE o.status = 'FILLED'
GROUP BY i.asset_class, DATE_TRUNC('month', o.executed_on)
ORDER BY month, i.asset_class;
