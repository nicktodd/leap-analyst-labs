# Lab 13: Validate the domain model against the data

## Objectives

- Turn rules stated by the class model, the order state model and the Business Requirements
  Specification (BRS) into SQL (Structured Query Language) checks.
- Run the checks against the training database and investigate every failure from symptom to
  root cause.
- Report the findings for an engineering audience: evidence, impact, probable cause and a
  proposed fix.

## Setup

1. Connect to the training database read-only, as in Module 12.
2. Open `validation.sql` from this folder.
3. Open `docs/13-ModelValidationFindings.docx` (Week 4 docs folder).
4. Have your extended domain model (Lab 09) and the order state diagram
   (`demos/10-state-and-activity-modelling/order-lifecycle.md`) to hand.

Time: 120 minutes, pairs. Allow 40 minutes for the write-up.

## Tasks

1. Read the eight model rules at the top of `validation.sql`. For each, name the class,
   state or BR it comes from.
2. Complete checks 1 to 8. Each query must return only the rows that break the rule.
3. For every failing row, follow the evidence into related tables (order_events, positions,
   cash_movements, settlements, accounts) until you can state what happened.
4. Look for one symptom with more than one cause, and for one cause that produces more than
   one symptom. Record both.
5. Decide for each finding whether the fault is in the data, in the platform's enforcement of
   a rule, or in the model or requirement itself.
6. Write the findings report in the Word document, one finding per table row, and a summary
   of the three most important findings for the engineering lead.

## Acceptance criteria

- All eight checks run and return only offending rows.
- Every finding quotes its evidence: the identifiers and values returned by the query.
- Each finding names the rule it breaks and a probable root cause.
- Findings that share a root cause are linked, not reported twice.
- The report separates data defects from open business-rule questions.

## Stretch

- Write one query that returns, for every FILLED order, a list of which of the checks it
  fails, using `CASE` expressions and `CONCAT_WS`.
