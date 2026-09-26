-- Lab 06 reference solution: preparing and validating test data with SQL
-- Run against the training database (shared/trading-db).

-- Task 1a: order states and channels the data covers
SELECT status, channel, COUNT(*) AS orders
FROM orders
GROUP BY status, channel
ORDER BY status, channel;
-- Result: CANCELLED, FILLED and REJECTED on both channels. No NEW orders at all.

-- Task 1b: asset classes the data covers
SELECT i.asset_class, COUNT(o.id) AS orders
FROM instruments i
LEFT JOIN orders o ON o.symbol = i.symbol
GROUP BY i.asset_class
ORDER BY i.asset_class;
-- Result: BOND 135, EQUITY 974, ETF 263. No FX or crypto (BR-12 gap).

-- Task 1c: rejection reasons present
SELECT reject_reason, COUNT(*) AS orders
FROM orders
WHERE status = 'REJECTED'
GROUP BY reject_reason
ORDER BY orders DESC;
-- Result: INSUFFICIENT_FUNDS 71, MARKET_CLOSED 24.

-- Task 2: happy-path candidate accounts
SELECT a.account_id, a.cash_balance, COUNT(p.symbol) AS holdings
FROM accounts a
JOIN positions p ON p.account_id = a.id AND p.quantity > 0
WHERE a.status = 'ACTIVE'
  AND a.email IS NOT NULL
  AND a.cash_balance >= 10000
GROUP BY a.account_id, a.cash_balance
ORDER BY a.cash_balance DESC;
-- Result: 13 accounts, ACC-100036 (19612.13) to ACC-100002 (10245.52).

-- Task 3a: accounts whose positions do not match their fills
WITH fills AS (
    SELECT account_id, symbol,
           SUM(CASE WHEN side = 'BUY' THEN quantity ELSE -quantity END) AS net_qty
    FROM orders
    WHERE status = 'FILLED'
    GROUP BY account_id, symbol
)
SELECT a.account_id, COALESCE(p.symbol, f.symbol) AS symbol,
       p.quantity AS position_qty, f.net_qty
FROM positions p
FULL OUTER JOIN fills f ON f.account_id = p.account_id AND f.symbol = p.symbol
JOIN accounts a ON a.id = COALESCE(p.account_id, f.account_id)
WHERE COALESCE(p.quantity, 0) <> COALESCE(f.net_qty, 0)
ORDER BY a.account_id, symbol;
-- Result: ACC-100003 ISF (115 vs 100), ACC-100004 TSLA (1 vs 6), ACC-100030 UST10 (17 vs 20).

-- Task 3b: accounts with a filled order that has an incomplete record
SELECT DISTINCT a.account_id, o.id AS order_id,
       CASE WHEN o.executed_price IS NULL THEN 'FILLED without executed price'
            ELSE 'FILLED without FILLED event' END AS problem
FROM orders o
JOIN accounts a ON a.id = o.account_id
WHERE o.status = 'FILLED'
  AND (o.executed_price IS NULL
       OR NOT EXISTS (SELECT 1 FROM order_events e
                      WHERE e.order_id = o.id AND e.event_type = 'FILLED'))
ORDER BY a.account_id;
-- Result: ACC-100027 (no executed price), ACC-100049 (no FILLED event).

-- Task 3c: clean happy-path accounts (Task 2 minus Task 3a and 3b)
WITH fills AS (
    SELECT account_id, symbol,
           SUM(CASE WHEN side = 'BUY' THEN quantity ELSE -quantity END) AS net_qty
    FROM orders WHERE status = 'FILLED'
    GROUP BY account_id, symbol
),
bad AS (
    SELECT COALESCE(p.account_id, f.account_id) AS id
    FROM positions p
    FULL OUTER JOIN fills f ON f.account_id = p.account_id AND f.symbol = p.symbol
    WHERE COALESCE(p.quantity, 0) <> COALESCE(f.net_qty, 0)
    UNION
    SELECT o.account_id FROM orders o
    WHERE o.status = 'FILLED'
      AND (o.executed_price IS NULL
           OR NOT EXISTS (SELECT 1 FROM order_events e
                          WHERE e.order_id = o.id AND e.event_type = 'FILLED'))
)
SELECT a.account_id, a.cash_balance
FROM accounts a
WHERE a.status = 'ACTIVE'
  AND a.email IS NOT NULL
  AND a.cash_balance >= 10000
  AND EXISTS (SELECT 1 FROM positions p WHERE p.account_id = a.id AND p.quantity > 0)
  AND a.id NOT IN (SELECT id FROM bad)
ORDER BY a.cash_balance DESC;
-- Result: 12 accounts. ACC-100049 is removed.

-- Task 4a: accounts for negative tests (not ACTIVE)
SELECT account_id, status, status_changed_on
FROM accounts
WHERE status <> 'ACTIVE'
ORDER BY status, account_id;
-- Result: CLOSED ACC-100016, ACC-100053; SUSPENDED ACC-100008, ACC-100024, ACC-100042.

-- Task 4b: instruments that must be refused
SELECT symbol, name
FROM instruments
WHERE tradable = FALSE;
-- Result: TSLA.

-- Task 4c: accounts with no email address
SELECT account_id FROM accounts WHERE email IS NULL ORDER BY account_id;
-- Result: ACC-100012, ACC-100035.

-- Task 5: buy boundary for ACC-100036 on AAPL at the latest close
SELECT a.account_id, a.cash_balance, m.close_price,
       FLOOR(a.cash_balance / m.close_price)             AS max_qty,
       FLOOR(a.cash_balance / m.close_price) * m.close_price AS cost_at_max,
       (FLOOR(a.cash_balance / m.close_price) + 1) * m.close_price AS cost_at_max_plus_one
FROM accounts a
JOIN market_prices m ON m.symbol = 'AAPL'
 AND m.price_date = (SELECT MAX(price_date) FROM market_prices)
WHERE a.account_id = 'ACC-100036';
-- Result: close 186.99 on 2026-06-30, max_qty 104, cost 19446.96; 105 costs 19633.95 (above 19612.13).

-- Task 6: sell boundary, smallest AAPL holdings on ACTIVE accounts
SELECT a.account_id, p.quantity
FROM positions p
JOIN accounts a ON a.id = p.account_id
WHERE p.symbol = 'AAPL' AND a.status = 'ACTIVE'
ORDER BY p.quantity, a.account_id
LIMIT 5;
-- Result: ACC-100001, ACC-100006, ACC-100038 hold 1; ACC-100005, ACC-100022 hold 2.

-- Task 7a: masked extract of accounts
CREATE TEMP VIEW masked_accounts AS
SELECT id,
       'ACC-T' || LPAD(id::text, 5, '0')      AS account_ref,
       'Test Client ' || id                   AS holder_name,
       CASE WHEN email IS NULL THEN NULL
            ELSE 'client' || id || '@example.test' END AS email,
       country, risk_profile, cash_balance, status
FROM accounts;

-- Task 7b: prove the mask
SELECT COUNT(*)                                   AS rows_masked,
       COUNT(DISTINCT m.email)                    AS distinct_emails,
       COUNT(*) FILTER (WHERE m.email IS NULL)    AS null_emails,
       COUNT(*) FILTER (WHERE m.holder_name = a.holder_name
                           OR m.email = a.email)  AS unmasked_values,
       SUM(m.cash_balance) = SUM(a.cash_balance)  AS balances_preserved
FROM masked_accounts m
JOIN accounts a ON a.id = m.id;
-- Result: 60 rows, 58 distinct emails, 2 null emails, 0 unmasked values, balances preserved true.
