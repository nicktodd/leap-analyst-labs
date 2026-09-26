# Lab 13: Profile a dataset for quality issues

## Objectives

- Profile the raw broker feed in `staging_trade_feed` against the data quality dimensions
  from Module 12.
- Write SQL (Structured Query Language) checks that return the offending rows for each issue.
- Turn each check into a validation rule written as a testable acceptance criterion.

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
   When side is not BUY or SELL, Then the row is rejected with reason INVALID_SIDE.
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
