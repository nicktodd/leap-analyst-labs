-- Module 13 lab: profile staging_trade_feed
-- For each check, write a query that returns the offending rows (external_ref plus the
-- column concerned). Record the external_ref values in docs/13-DataQualityFindings.docx.

-- Check 1  (completeness): rows with any required column missing
--          (account_ref, symbol, side, quantity, price, trade_time).

-- Check 2  (validity): side values other than BUY and SELL.

-- Check 3  (validity): quantity zero or negative.

-- Check 4  (consistency): symbol not in the instruments table.
--          Look at the values: which are typos and which are formatting problems?

-- Check 5  (consistency): account_ref not in the accounts table (accounts.account_id).

-- Check 6  (consistency): currency different from the instrument's currency.

-- Check 7  (timeliness / validity): trade_time in the future, or outside Jan to Jun 2026.

-- Check 8  (uniqueness): external_ref appearing more than once.

-- Check 9  (uniqueness): the same trade under two different external_ref values
--          (same account, symbol, side, quantity, price and trade_time).

-- Check 10 (accuracy): price more than 50 percent away from the market close on that day.
--          Hint: join market_prices on symbol and trade_time::date.

-- Check 11 (consistency): source_system values, exactly as stored.
