-- Module 12 demo: safe patterns for querying production-like data
-- Part 1: open a read-only transaction with a time limit
BEGIN TRANSACTION READ ONLY;
SET LOCAL statement_timeout = '30s';

-- Part 2: a write is refused inside the read-only transaction
-- (run this line on its own to show the error, then ROLLBACK and start again)
-- UPDATE accounts SET status = 'ACTIVE' WHERE account_id = 'ACC-100008';

-- Part 3: count before you fetch
SELECT COUNT(*) FROM orders WHERE created_on >= DATE '2026-06-01';

-- Part 4: select only the columns you need, mask personal data
SELECT account_id,
       LEFT(holder_name, 1) || '***' AS holder_masked,
       REGEXP_REPLACE(email, '^[^@]+', '***') AS email_masked,
       status
FROM accounts
ORDER BY account_id
LIMIT 5;

-- Part 5: check the plan before running a heavy query
EXPLAIN
SELECT o.symbol, COUNT(*)
FROM orders o
WHERE o.account_id = 8
GROUP BY o.symbol;

ROLLBACK;
