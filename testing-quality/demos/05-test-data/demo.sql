-- Part 1: what states does the data cover
SELECT status, COUNT(*) AS accounts
FROM accounts
GROUP BY status
ORDER BY status;

-- Part 2: mask personal data in a test extract
SELECT id,
       'ACC-T' || LPAD(id::text, 5, '0')     AS account_ref,
       'Test Client ' || id                  AS holder_name,
       CASE WHEN email IS NULL THEN NULL
            ELSE 'client' || id || '@example.test' END AS email,
       country, status, cash_balance
FROM accounts
ORDER BY id
LIMIT 5;

-- Part 3: derive a boundary value from the data
SELECT a.account_id, a.cash_balance, m.close_price,
       FLOOR(a.cash_balance / m.close_price) AS max_affordable_qty
FROM accounts a
JOIN market_prices m ON m.symbol = 'AAPL'
 AND m.price_date = (SELECT MAX(price_date) FROM market_prices)
WHERE a.account_id = 'ACC-100036';
