# Demo: Module 13 - From a vague criterion to Given, When, Then

**Duration:** 15 minutes
**Prerequisite:** the BRS open at BR-05. The Trade REST API contract
(`shared/contracts/trade-api.yaml`) open at the business rules table.

## Part 1: start from the vague version (4 min)

1. Write on screen: "The system should check the client has enough money."
2. Ask the group for three questions a tester would ask. Expected: how much is enough, what
   happens if not, what does the client see.
3. Narration: every unanswered question becomes a guess by an engineer.

## Part 2: rewrite it (8 min)

1. Open `place-order.feature`. Read the Background aloud: it fixes the starting state.
2. Read the first scenario. Point out the exact numbers: 5 at 80.00 is 400.00, inside 1000.00.
3. Read the second scenario: 20 at 80.00 is 1600.00. Point out the final `And`: the cash balance
   must not change, which tests BR-09 as well as BR-05.
4. Show rule 6 in the contract table (`ORD-400`). Narration: the criteria and the contract must
   agree; the analyst checks both.

## Part 3: the boundary (3 min)

1. Ask: what happens at exactly 1000.00. The contract says "at least", so it is accepted.
2. Add the boundary scenario in the file live as a third scenario.

## Key message

A Given, When, Then criterion states the starting data, one action and observable results
with exact values. If a tester cannot run it without asking a question, it is not finished.
