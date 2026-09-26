# Demo: Module 05 - Test data from the training database

**Duration:** 15 minutes
**Prerequisite:** training database running; `demos/05-test-data/demo.sql` open in pgAdmin or DBeaver.

## Part 1: what states does the data cover (4 min)

1. Run Part 1. Result: ACTIVE 55, CLOSED 2, SUSPENDED 3.
2. Narration: before choosing test data, check which states exist. A test case for a suspended
   account needs a suspended account; three exist, so the negative case can be run. If none
   existed, the analyst would have to request one or create it.

## Part 2: masking (6 min)

1. Run Part 2. Show the synthetic account reference, name and email.
2. Narration: the mask replaces what identifies a person and keeps what the test needs:
   status, country and cash balance are unchanged, so business rules behave the same.
3. Point out the `CASE` on email: an account with no email stays without one, because "client
   has no email" is itself a test condition.

## Part 3: a boundary value from the data (5 min)

1. Run Part 3. Result: ACC-100036 has 19612.13 in cash; AAPL closed at 186.99 on 2026-06-30;
   the largest affordable quantity is 104.
2. Narration: the boundary test cases are therefore 104 units (accepted) and 105 units
   (rejected for insufficient funds). The analyst calculates the boundary; nobody guesses it.

## Key message

Test data is designed, not found. Check coverage, mask what identifies a person, and derive
boundary values from the data so every test case has exactly the record it needs.
