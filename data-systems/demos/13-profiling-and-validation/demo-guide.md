# Demo: Module 13 - Profiling a dataset

**Duration:** 20 minutes
**Prerequisite:** training database running; `demos/13-profiling-and-validation/demo.sql` open.

## Part 1: completeness in one pass (5 min)

1. Run Part 1. Narration: `COUNT(column)` skips nulls, so `COUNT(*) - COUNT(column)` is the
   null count. The feed has 264 rows and one missing value in each of symbol, account, price
   and trade time.

## Part 2: distinct values (5 min)

1. Run Part 2. Result: BUY 190, SELL 72, and one row each coded `B` and `S`.
2. Ask: is `B` wrong, or a different broker convention the load should translate. That is a
   question for the feed owner, not a decision for the analyst alone.

## Part 3: duplicates (5 min)

1. Run Part 3: EXT-700180, EXT-700181 and EXT-700182 each appear twice.
2. Narration: this finds exact key duplicates only. The same trade under two different
   references needs a grouping on the trade attributes instead (the lab covers it).

## Part 4: referential check (5 min)

1. Run Part 4: `APPL` (a typo for AAPL) and `isf` (lower case) do not match an instrument.
2. Narration: the two need different fixes. A case rule can correct `isf`; `APPL` must be
   rejected or confirmed with the broker.

## Key message

Profiling is a small set of repeatable queries: counts, nulls, distinct values, duplicates and
lookups. Each finding becomes a validation rule that engineering can build and QA can test.
