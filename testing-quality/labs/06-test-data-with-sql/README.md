# Lab 06: Preparing and validating test data with SQL

## Objectives

- Profile the training database to see which test conditions its data can and cannot support.
- Select accounts and instruments for positive, negative and boundary test cases, using SQL
  (Structured Query Language).
- Exclude records whose own integrity is in doubt, so a test failure points at the platform
  and not at the data.
- Build a masked extract of client data and prove the masking with a query.

## Setup

1. Start the training database and connect with pgAdmin or DBeaver (see
   `shared/trading-db/README.md`).
2. Open `exercises.sql` from this folder.
3. Open `docs/06-TestDataSheet.docx` (Week 8 docs folder) and your test cases from Lab 04.

Time: 75 minutes, pairs. Allow 20 minutes of that for the test data sheet.

## Tasks

1. **Coverage.** Run Tasks 1a to 1c. Note every test condition the data cannot support, for
   example an order status or an asset class with no rows.
2. **Happy-path candidates.** Complete Task 2.
3. **Integrity screen.** Complete Tasks 3a and 3b, then combine them in Task 3c to produce a
   clean list of happy-path accounts. Record which accounts you removed and why.
4. **Negative-test data.** Complete Tasks 4a to 4c.
5. **Boundary values.** Complete Tasks 5 and 6. Write down the exact quantities for the
   boundary test cases (at the limit, and one above it).
6. **Masking.** Complete Tasks 7a and 7b. The view is temporary: it disappears when you
   disconnect and does not change the database.
7. **Test data sheet.** Complete the Word document: one row per test data need, the record you
   chose, the query that found it and why it is fit for purpose.

## Acceptance criteria

- Every query runs and returns only the rows the task asks for.
- The coverage findings name at least two conditions the data cannot support.
- The happy-path list excludes every account with a position mismatch or an incomplete filled
  order.
- Boundary quantities are calculated from the data, not estimated.
- The masking proof shows zero original names or emails remaining and an unchanged cash total.
- The test data sheet links each record to at least one test case from Lab 04.

## Stretch

- Write a query that returns, for every clean happy-path account, the instrument it holds the
  most units of and the quantity. That gives each sell test its own data.

## Apply it to your project

Prepare the test data for your team's test pack against the team's own database: choose the accounts and instruments each test case needs, exclude records whose integrity is in doubt, and record them in the team's test data sheet so the engineers can seed the UAT environment.
