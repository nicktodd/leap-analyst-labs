-- Lab 13 reference solution: validating the domain model against the data.
-- Each check tests one rule from the class model, state model or BRS.
-- Every query returns only offending rows. Run against the trading database.

-- Check 1 (BR-14, BR-15): every FILLED order has a FILLED event in the audit trail
SELECT o.id, o.status, o.executed_on
FROM orders o
WHERE o.status = 'FILLED'
  AND NOT EXISTS (SELECT 1 FROM order_events e
                  WHERE e.order_id = o.id AND e.event_type = 'FILLED');

-- Check 2 (state model): a FILLED order has an executed price and time
SELECT id, status, executed_price, executed_on
FROM orders
WHERE status = 'FILLED'
  AND (executed_price IS NULL OR executed_on IS NULL);

-- Check 3 (BR-05): no order filled for an account after it left ACTIVE
SELECT a.account_id, a.status, a.status_changed_on,
       o.id, o.channel, o.executed_on
FROM orders o
JOIN accounts a ON a.id = o.account_id
WHERE o.status = 'FILLED'
  AND a.status <> 'ACTIVE'
  AND o.executed_on::date > a.status_changed_on
ORDER BY o.executed_on;

-- Check 4 (BR-09, BR-10): each position equals the net of its fills
WITH fills AS (
    SELECT account_id, symbol,
           SUM(CASE WHEN side = 'BUY' THEN quantity ELSE -quantity END) AS net_filled
    FROM orders
    WHERE status = 'FILLED'
    GROUP BY account_id, symbol
)
SELECT a.account_id, COALESCE(p.symbol, f.symbol) AS symbol,
       p.quantity AS position_qty, f.net_filled,
       COALESCE(p.quantity, 0) - COALESCE(f.net_filled, 0) AS difference
FROM positions p
FULL OUTER JOIN fills f ON f.account_id = p.account_id AND f.symbol = p.symbol
JOIN accounts a ON a.id = COALESCE(p.account_id, f.account_id)
WHERE COALESCE(p.quantity, 0) <> COALESCE(f.net_filled, 0)
ORDER BY a.account_id, symbol;

-- Check 5 (service expectation 9.1): no duplicate orders
SELECT o1.id AS first_order, o2.id AS second_order, o1.account_id, o1.symbol,
       o1.side, o1.quantity, o1.created_on, o2.created_on AS second_created_on
FROM orders o1
JOIN orders o2
  ON o2.account_id = o1.account_id AND o2.symbol = o1.symbol
 AND o2.side = o1.side AND o2.quantity = o1.quantity
 AND o2.id <> o1.id
 AND o2.created_on BETWEEN o1.created_on AND o1.created_on + INTERVAL '5 seconds'
WHERE o1.status = 'FILLED' AND o2.status = 'FILLED';

-- Check 6 (BR-05): no fill for an instrument that is not tradable
SELECT o.id, o.symbol, o.status, o.executed_on, i.tradable
FROM orders o
JOIN instruments i ON i.symbol = o.symbol
WHERE o.status = 'FILLED' AND i.tradable = FALSE
  AND o.executed_on >= DATE '2026-04-01';

-- Check 7 (settlement rule): settlement date is never before trade date
SELECT settlement_id, order_id, trade_date, settlement_date, status
FROM settlements
WHERE settlement_date < trade_date;

-- Check 8 (BR-09): every FILLED order has a settlement and a trade cash movement
SELECT o.id,
       (SELECT COUNT(*) FROM settlements s WHERE s.order_id = o.id) AS settlements,
       (SELECT COUNT(*) FROM cash_movements c WHERE c.order_id = o.id) AS cash_movements
FROM orders o
WHERE o.status = 'FILLED'
  AND (NOT EXISTS (SELECT 1 FROM settlements s WHERE s.order_id = o.id)
       OR NOT EXISTS (SELECT 1 FROM cash_movements c WHERE c.order_id = o.id));

-- Stretch (root cause for check 3): which channel do the post-suspension fills use
SELECT o.channel, COUNT(*) AS fills_after_status_change
FROM orders o
JOIN accounts a ON a.id = o.account_id
WHERE o.status = 'FILLED' AND a.status <> 'ACTIVE'
  AND o.executed_on::date > a.status_changed_on
GROUP BY o.channel;
