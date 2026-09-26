-- Lab 13: validating the domain model against the data
--
-- Model rules to test (from the class model, the order state model and the BRS):
--   R1 Every FILLED order has a FILLED event in order_events
--   R2 A FILLED order has an executed price and an executed time
--   R3 No order is filled for an account after it stopped being ACTIVE
--   R4 Each position equals the net quantity of the account's fills (BUY minus SELL)
--   R5 The same order is never recorded twice
--   R6 No order is filled for an instrument that is not tradable
--   R7 A settlement date is never before its trade date
--   R8 Every FILLED order has a settlement and a trade cash movement
--
-- Each check must return only the rows that break the rule.

-- Check 1 (R1): hint, use NOT EXISTS against order_events
SELECT o.id, o.status, o.executed_on
FROM orders o
WHERE o.status = 'FILLED'
  -- AND NOT EXISTS ( ... )
;

-- Check 2 (R2)


-- Check 3 (R3): hint, accounts.status_changed_on records when the status changed


-- Check 4 (R4): hint, build net fills in a CTE, then FULL OUTER JOIN to positions


-- Check 5 (R5): hint, self-join orders on account, symbol, side and quantity,
--               created within a few seconds of each other


-- Check 6 (R6)


-- Check 7 (R7)


-- Check 8 (R8)

