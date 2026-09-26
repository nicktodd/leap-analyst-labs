-- Module 12 demo: safe patterns
-- Part 1: read-only transaction, time limit
BEGIN TRANSACTION READ ONLY;
SET LOCAL statement_timeout = '30s';

-- Part 2: a write is refused (run alone,
-- see the error, then ROLLBACK and restart)
-- UPDATE accounts SET status = 'ACTIVE'
--  WHERE account_id = 'ACC-100008';

-- Part 3: count before you fetch
SELECT COUNT(*) FROM orders
WHERE created_on >= DATE '2026-06-01';

-- Part 4: needed columns only, masked
SELECT account_id,
       LEFT(holder_name, 1) || '***'
           AS holder_masked,
       REGEXP_REPLACE(email, '^[^@]+', '***')
           AS email_masked,
       status
FROM accounts
ORDER BY account_id
LIMIT 5;

-- Part 5: check the plan before a heavy query
EXPLAIN
SELECT o.symbol, COUNT(*)
FROM orders o
WHERE o.account_id = 8
GROUP BY o.symbol;

ROLLBACK;
