-- Module 13 reference solution (results verified against the training database)

-- Check 1: 4 rows. EXT-700010 (symbol), EXT-700025 (account), EXT-700150 (price),
--          EXT-700210 (trade_time)
SELECT external_ref, account_ref, symbol, side, quantity, price, trade_time
FROM staging_trade_feed
WHERE account_ref IS NULL OR symbol IS NULL OR side IS NULL
   OR quantity IS NULL OR price IS NULL OR trade_time IS NULL;

-- Check 2: 2 rows. EXT-700070 ('B'), EXT-700071 ('S')
SELECT external_ref, side
FROM staging_trade_feed
WHERE side NOT IN ('BUY', 'SELL');

-- Check 3: 2 rows. EXT-700040 (negative), EXT-700230 (zero)
SELECT external_ref, quantity
FROM staging_trade_feed
WHERE quantity <= 0;

-- Check 4: 2 rows. EXT-700055 ('isf', lower case), EXT-700100 (APPL, typo for AAPL)
SELECT s.external_ref, s.symbol
FROM staging_trade_feed s
LEFT JOIN instruments i ON i.symbol = s.symbol
WHERE s.symbol IS NOT NULL AND i.symbol IS NULL;

-- Check 5: 1 row. EXT-700120
SELECT s.external_ref, s.account_ref
FROM staging_trade_feed s
LEFT JOIN accounts a ON a.account_id = s.account_ref
WHERE s.account_ref IS NOT NULL AND a.account_id IS NULL;

-- Check 6: 2 rows on a strict comparison. EXT-700130 (GILT30 coded 'usd': lower case
--          and the wrong currency for a GBP gilt), EXT-700131 (AMZN coded EUR). EXT-700100 (APPL) cannot be checked because the symbol is unknown.
SELECT s.external_ref, s.symbol, s.currency, i.currency AS instrument_currency
FROM staging_trade_feed s
JOIN instruments i ON i.symbol = s.symbol
WHERE s.currency <> i.currency;

-- Check 7: 1 row. EXT-700090 (future trade time)
SELECT external_ref, trade_time
FROM staging_trade_feed
WHERE trade_time > NOW()
   OR trade_time < '2026-01-01' OR trade_time >= '2026-07-01';

-- Check 8: 3 rows. EXT-700180, EXT-700181, EXT-700182 (two copies each)
SELECT external_ref, COUNT(*) AS copies
FROM staging_trade_feed
GROUP BY external_ref
HAVING COUNT(*) > 1
ORDER BY external_ref;

-- Check 9: 1 row. EXT-700200 and EXT-799999
SELECT account_ref, symbol, side, quantity, price, trade_time,
       STRING_AGG(DISTINCT external_ref, ', ') AS external_refs
FROM staging_trade_feed
GROUP BY account_ref, symbol, side, quantity, price, trade_time
HAVING COUNT(DISTINCT external_ref) > 1;

-- Check 10: 1 row. EXT-700160 (AMZN at 14808.00, about 100 times the close)
SELECT s.external_ref, s.symbol, s.price, m.close_price
FROM staging_trade_feed s
JOIN market_prices m ON m.symbol = s.symbol AND m.price_date = s.trade_time::date
WHERE ABS(s.price - m.close_price) > 0.5 * m.close_price;

-- Check 11: 2 distinct values. 'BROKER-A' (263 rows) and one row (EXT-700220) stored
--           as 'broker-a ' (lower case, trailing space)
SELECT '[' || source_system || ']' AS stored_value, COUNT(*) AS row_count,
       MIN(external_ref) AS example_ref
FROM staging_trade_feed
GROUP BY source_system;
