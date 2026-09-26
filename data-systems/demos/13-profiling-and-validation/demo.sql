-- Module 13 demo: profiling staging_trade_feed
-- Part 1: size and completeness in one pass
SELECT COUNT(*) AS total_rows,
  COUNT(*) - COUNT(symbol) AS no_symbol,
  COUNT(*) - COUNT(account_ref) AS no_account,
  COUNT(*) - COUNT(price) AS no_price,
  COUNT(*) - COUNT(trade_time) AS no_time
FROM staging_trade_feed;

-- Part 2: distinct values reveal
-- inconsistent coding
SELECT side, COUNT(*)
FROM staging_trade_feed
GROUP BY side
ORDER BY side;

-- Part 3: duplicates on the business key
SELECT external_ref, COUNT(*) AS copies
FROM staging_trade_feed
GROUP BY external_ref
HAVING COUNT(*) > 1;

-- Part 4: referential check against
-- the instruments master
SELECT s.external_ref, s.symbol
FROM staging_trade_feed s
LEFT JOIN instruments i
  ON i.symbol = s.symbol
WHERE s.symbol IS NOT NULL
  AND i.symbol IS NULL;
