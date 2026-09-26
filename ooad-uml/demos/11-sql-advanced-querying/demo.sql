-- Module 11 demo: advanced querying against the trading database
-- Part 1: ROW_NUMBER, the latest order per account
SELECT account_id, id, symbol, status, created_on
FROM (
    SELECT o.*, ROW_NUMBER() OVER (
               PARTITION BY account_id ORDER BY created_on DESC) AS rn
    FROM orders o
) latest
WHERE rn = 1
ORDER BY account_id
LIMIT 5;

-- Part 2: RANK, top three instruments by filled value each month
WITH monthly AS (
    SELECT DATE_TRUNC('month', executed_on)::date AS month, symbol,
           SUM(quantity * executed_price) AS filled_value
    FROM orders
    WHERE status = 'FILLED' AND executed_price IS NOT NULL
    GROUP BY 1, 2
)
SELECT month, symbol, filled_value, rnk
FROM (SELECT m.*, RANK() OVER (PARTITION BY month
                               ORDER BY filled_value DESC) AS rnk
      FROM monthly m) ranked
WHERE rnk <= 3
ORDER BY month, rnk;

-- Part 3: running total, the cash history of one account
-- amount is signed: deposits and sells positive, withdrawals and buys negative
SELECT movement_on, movement_type, amount,
       SUM(amount) OVER (ORDER BY movement_on, movement_id) AS running_cash
FROM cash_movements
WHERE account_id = 3
ORDER BY movement_on, movement_id
LIMIT 10;

-- Part 4: LAG, seconds between audit events for each order
SELECT order_id, event_type, event_time,
       EXTRACT(EPOCH FROM event_time - LAG(event_time)
           OVER (PARTITION BY order_id ORDER BY event_time, event_id))
           AS seconds_since_previous
FROM order_events
WHERE order_id = '0c46a952-c4b3-4097-bb1a-30ac3f707f79'
ORDER BY event_time, event_id;

-- Part 5: FILTER, order outcomes by channel in one row each
SELECT channel,
       COUNT(*) AS orders,
       COUNT(*) FILTER (WHERE status = 'FILLED')    AS filled,
       COUNT(*) FILTER (WHERE status = 'REJECTED')  AS rejected,
       COUNT(*) FILTER (WHERE status = 'CANCELLED') AS cancelled,
       ROUND(100.0 * COUNT(*) FILTER (WHERE status = 'REJECTED')
             / COUNT(*), 1) AS reject_pct
FROM orders
GROUP BY channel
ORDER BY channel;
