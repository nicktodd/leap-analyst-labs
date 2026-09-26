-- Module 15 reference solutions (verified against the training database)
BEGIN TRANSACTION READ ONLY;

-- Task 1: 24 rows
SELECT account_id, holder_name, cash_balance
FROM accounts
WHERE cash_balance > (SELECT AVG(cash_balance) FROM accounts)
ORDER BY cash_balance DESC;

-- Task 2: 1 row. Order a147f876-3bb5-46fa-b96a-04f0f46b4a2e has no FILLED event
SELECT o.id, o.symbol, o.executed_on
FROM orders o
WHERE o.status = 'FILLED'
  AND NOT EXISTS (SELECT 1 FROM order_events e
                  WHERE e.order_id = o.id AND e.event_type = 'FILLED');

-- Task 3: 2 rows, both ACC-100008 through the DESK channel
WITH inactive AS (
    SELECT id, account_id, status, status_changed_on
    FROM accounts
    WHERE status IN ('SUSPENDED', 'CLOSED')
)
SELECT i.account_id, i.status, i.status_changed_on, o.id, o.channel, o.created_on
FROM inactive i
JOIN orders o ON o.account_id = i.id
WHERE o.status = 'FILLED'
  AND o.created_on::date > i.status_changed_on
ORDER BY o.created_on;

-- Task 4: 3 rows.
--   ACC-100003 ISF   position 115, fills 100 (position 15 too high)
--   ACC-100004 TSLA  position 1, fills 6 (the withdrawn-instrument fill, Task 5, never
--                    reached positions)
--   ACC-100030 UST10 position 17, fills 20 (the duplicate fill, Task 7, was applied once)
WITH net_fills AS (
    SELECT account_id, symbol,
           SUM(CASE WHEN side = 'BUY' THEN quantity ELSE -quantity END) AS net_qty
    FROM orders
    WHERE status = 'FILLED'
    GROUP BY account_id, symbol
)
SELECT a.account_id, COALESCE(p.symbol, n.symbol) AS symbol,
       p.quantity AS position_qty, n.net_qty AS filled_qty
FROM net_fills n
FULL OUTER JOIN positions p ON p.account_id = n.account_id AND p.symbol = n.symbol
JOIN accounts a ON a.id = COALESCE(p.account_id, n.account_id)
WHERE COALESCE(p.quantity, 0) <> COALESCE(n.net_qty, 0)
ORDER BY a.account_id, symbol;

-- Task 5: 1 row. TSLA order 5510566b-f874-43e1-9f20-a28eeab9a479 filled 2026-04-14
WITH not_tradable AS (SELECT symbol FROM instruments WHERE tradable = FALSE)
SELECT o.id, o.symbol, o.created_on, o.executed_on
FROM orders o
JOIN not_tradable t ON t.symbol = o.symbol
WHERE o.status = 'FILLED' AND o.created_on >= '2026-04-01';

-- Task 6: 1 row. Settlement 89
SELECT settlement_id, order_id, trade_date, settlement_date
FROM settlements
WHERE settlement_date < trade_date;

-- Task 7: 1 pair. Orders 28451736-... and 84656131-..., one second apart
SELECT o1.id AS first_order, o2.id AS second_order, o1.symbol, o1.quantity,
       o2.created_on - o1.created_on AS gap
FROM orders o1
JOIN orders o2 ON o2.account_id = o1.account_id AND o2.symbol = o1.symbol
              AND o2.side = o1.side AND o2.quantity = o1.quantity
              AND o2.created_on > o1.created_on
              AND o2.created_on <= o1.created_on + INTERVAL '5 seconds'
WHERE o1.status = 'FILLED' AND o2.status = 'FILLED';

-- Stretch: 7 rows (April is a tie between UST10 and VWRL on 14 fills each)
WITH monthly AS (
    SELECT DATE_TRUNC('month', executed_on) AS month, symbol, COUNT(*) AS fills,
           RANK() OVER (PARTITION BY DATE_TRUNC('month', executed_on)
                        ORDER BY COUNT(*) DESC) AS rnk
    FROM orders
    WHERE status = 'FILLED'
    GROUP BY DATE_TRUNC('month', executed_on), symbol
)
SELECT month, symbol, fills FROM monthly WHERE rnk = 1 ORDER BY month, symbol;

ROLLBACK;
