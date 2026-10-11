# Lab 13: Profile a dataset for quality issues

## Objectives

- Profile the raw broker feed in `staging_trade_feed` against the data quality dimensions
  from Module 12.
- Write SQL (Structured Query Language) checks that return the offending rows for each issue.
- Turn each check into a validation rule written as a testable acceptance criterion.

## What you need to know

Modules 06, 07 and 13 cover the SQL for most checks. A few checks also need:

- `UPPER(symbol)` and `TRIM(symbol)`: upper-case a value and strip leading or trailing
  spaces, so you can see whether a value matches after tidying (checks 4 and 6).
- `trade_time::date`: turns a timestamp into a date, so it can be joined to
  `market_prices.price_date` (check 10).
- `CURRENT_DATE`: today's date, for spotting trade times in the future (check 7).
- `ABS(x)`: the size of a number ignoring its sign, useful for "more than 50 percent away"
  (check 10).
- Checks 2, 4 and 8 start from the Module 13 demo queries: go further by recording every
  offending row and deciding the action for each.

## Setup

1. Connect to the training database as in Lab 06.
2. Open `profiling.sql` from this folder.
3. Open `docs/13-DataQualityFindings.docx` (Week 2 docs folder) for the write-up.

Time: 90 minutes, pairs. Allow 30 minutes of that for the write-up.

## Tasks

1. Run a first profile: row count, null count per column and distinct values of `side`,
   `currency` and `source_system`.
2. Complete checks 1 to 11 in `profiling.sql`. Each query returns the `external_ref` of every
   offending row.
3. Record each issue in the findings table in the Word document: dimension, rows affected,
   evidence query, business impact and a proposed action (reject, correct, quarantine or ask).
4. Write at least five validation rules in Given/When/Then form, for example: Given a feed row,
   When price is empty, Then the row is quarantined with reason MISSING_PRICE.
5. Rank the issues by business impact and list the three questions you would take to the
   Trading Desk.

## Acceptance criteria

- Every check query runs and returns only offending rows.
- At least 12 distinct issues are recorded, each with its `external_ref` values.
- Each issue is mapped to one quality dimension.
- At least five validation rules are written as testable acceptance criteria.
- The findings separate data errors from questions of business rule.

## Stretch

- Write a single query that labels every row with the first rule it fails, or `CLEAN`, and
  count the clean rows.

## Apply it to your project

Turn the validation rules you wrote into the data validation section of your team's data dictionary, each as a testable criterion. Agree with the engineers which rules become database constraints and which become tests, and record the decision.
