-- Lab 06: preparing and validating test data with SQL
-- Write one query under each task. Record what you choose, and why, in
-- docs/06-TestDataSheet.docx (Week 8 docs folder).

-- Task 1a: which order statuses and channels does the data cover?
-- Hint: GROUP BY status, channel on orders.


-- Task 1b: which asset classes have orders? Compare with BR-12.
-- Hint: LEFT JOIN instruments to orders so a class with no orders still shows.


-- Task 1c: which rejection reasons are present?


-- Task 2: happy-path candidates. ACTIVE accounts with an email address,
-- a cash balance of at least 10000 and at least one position above zero.
-- Return account_id, cash_balance and the number of holdings.


-- Task 3a: accounts whose positions do not match their fills.
-- Hint: net filled quantity = SUM of BUY quantity minus SELL quantity for
-- FILLED orders, per account and symbol. Compare with positions.quantity.
-- Use a FULL OUTER JOIN so a mismatch on either side is found.


-- Task 3b: accounts with a FILLED order whose record is incomplete:
-- executed_price is NULL, or there is no FILLED row in order_events.


-- Task 3c: repeat Task 2, excluding every account found in 3a and 3b.
-- Hint: put the 3a and 3b queries in a WITH clause as two named results
-- (mismatched, incomplete), each returning the numeric account id, then add
-- AND NOT EXISTS (SELECT 1 FROM mismatched m WHERE m.id = a.id) and the same
-- for incomplete. Replace the JOIN to positions with an EXISTS test so each
-- account appears once.


-- Task 4a: accounts for negative tests (status is not ACTIVE).


-- Task 4b: instruments the platform must refuse (tradable is FALSE).


-- Task 4c: accounts with no email address.


-- Task 5: for ACC-100036, the largest whole quantity of AAPL it can afford
-- at the latest close in market_prices, the cost at that quantity and the
-- cost at one more unit.
-- Hint: FLOOR(cash_balance / close_price) rounds down to a whole number.
-- Latest close: m.price_date = (SELECT MAX(price_date) FROM market_prices).
-- Adapt Part 3 of demos/05-test-data/demo.sql.


-- Task 6: ACTIVE accounts with the smallest AAPL holdings (sell boundary).


-- Task 7a: create a masked extract of accounts as a temporary view.
-- Replace account_id, holder_name and email with synthetic values.
-- Keep NULL emails NULL, so the "no email" test condition survives.
-- Start from Part 2 of demos/05-test-data/demo.sql (|| joins text, LPAD pads
-- with zeros, id::text turns the number into text) and wrap it in:
-- CREATE TEMP VIEW masked_accounts AS ...


-- Task 7b: prove the mask. One query returning: rows masked, distinct
-- emails, null emails, number of values still equal to the original,
-- and whether the total cash balance is unchanged.
-- Hint: join masked_accounts to accounts on id; COUNT(*) FILTER (WHERE ...)
-- from Week 4 counts the rows that meet a condition.

