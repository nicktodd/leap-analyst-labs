-- Module 15 demo: subqueries and CTEs
-- Part 1: work read-only;
-- the session refuses any write
BEGIN TRANSACTION READ ONLY;

-- Part 2: a subquery in WHERE:
-- orders for non-tradable instruments
SELECT id, symbol, status, created_on
FROM orders
WHERE symbol IN (SELECT symbol
                 FROM instruments
                 WHERE tradable = FALSE)
  AND created_on >= '2026-04-01';

-- Part 3: the same question as a CTE,
-- built step by step
WITH withdrawn AS (
  SELECT symbol FROM instruments
  WHERE tradable = FALSE
),
late_orders AS (
  SELECT o.id, o.symbol, o.status
  FROM orders o
  JOIN withdrawn w ON w.symbol = o.symbol
  WHERE o.created_on >= '2026-04-01'
)
SELECT status, COUNT(*)
FROM late_orders
GROUP BY status;

ROLLBACK;
