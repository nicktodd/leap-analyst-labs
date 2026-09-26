-- Module 06 demo: SQL fundamentals against the trading database
-- Part 1: look at a whole (small) table
SELECT * FROM instruments;

-- Part 2: choose columns and filter rows
SELECT symbol, name, currency
FROM instruments
WHERE exchange = 'LSE';

-- Part 3: combine conditions and sort
SELECT id, symbol, side, quantity, created_on
FROM orders
WHERE status = 'REJECTED'
  AND channel = 'WEB'
ORDER BY created_on DESC
LIMIT 10;

-- Part 4: NULL needs IS NULL, not = NULL
SELECT account_id, holder_name
FROM accounts
WHERE email IS NULL;
