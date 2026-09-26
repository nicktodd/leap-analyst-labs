-- Module 06 reference solutions (row counts verified against the training database)

-- Task 1: 20 rows
SELECT symbol, name, asset_class, currency
FROM instruments
ORDER BY symbol;

-- Task 2: 1 row (TSLA)
SELECT symbol, name
FROM instruments
WHERE tradable = FALSE;

-- Task 3: 29 rows
SELECT account_id, holder_name, opened_on
FROM accounts
WHERE status = 'ACTIVE'
  AND country = 'GB'
ORDER BY opened_on DESC;

-- Task 4: 71 rows
SELECT id, account_id, symbol, side, quantity, created_on
FROM orders
WHERE reject_reason = 'INSUFFICIENT_FUNDS';

-- Task 5: 30 rows
SELECT id, account_id, symbol, side, quantity, status, created_on
FROM orders
WHERE channel = 'DESK'
  AND created_on >= '2026-03-01'
  AND created_on <  '2026-04-01'
ORDER BY created_on;

-- Task 6: 10 rows
SELECT id, account_id, side, quantity, price, status
FROM orders
WHERE symbol = 'VOD'
ORDER BY quantity DESC
LIMIT 10;

-- Task 7: 5 rows
SELECT account_id, holder_name, status, status_changed_on
FROM accounts
WHERE status <> 'ACTIVE'
ORDER BY status_changed_on;

-- Task 8: 27 rows (15 FAILED, 12 PENDING)
SELECT settlement_id, order_id, trade_date, settlement_date, status, amount
FROM settlements
WHERE status IN ('FAILED', 'PENDING')
ORDER BY trade_date;
