# Lab 05: Trace a business rule from requirement to code

## Objectives

- Navigate a small repository and follow a request from its entry point to the rule that
  decides it.
- Trace BR-05 (orders checked against the trading rules) through the contract into code.
- Use GitHub Copilot Chat to explain unfamiliar code, then verify every claim it makes
  against the code itself.
- Decide where the analyst's investigation stops and an engineer must be involved.

## Setup

Time: 60 minutes, pairs.

1. Open this folder in VS Code (or browse it on GitHub). The code is in `code/`:
   - `OrderController.java`: the entry point for `POST /api/v1/orders`
   - `OrderService.java`: records the order after validation
   - `OrderValidator.java`: applies the trading rules
   - `ErrorCode.java`: the error catalogue
2. Open `shared/contracts/trade-api.yaml` and find the "Business rules" table in
   `info.description`.
3. Open `trace-worksheet.md` from this folder for your answers.

You do not need to run or compile the code. The supporting classes (repositories, `Account`,
`TradingException`) are not included: read their names as a description of what they do.

## Tasks

1. Start at `OrderController.java`. Write down, in order, every method a `POST /api/v1/orders`
   request passes through until a rule is checked.
2. Complete the trace table in `trace-worksheet.md`: for each of the eight contract rules,
   record the file and line where it is enforced, the error code thrown, and whether the code
   matches the contract exactly.
3. Ask Copilot Chat: "Explain what OrderValidator.validate does, rule by rule." Paste its
   answer into the worksheet. Mark each statement as verified, wrong or unverifiable, with the
   line number that proves it.
4. Record every mismatch between the code and the contract as a finding: what the contract
   says, what the code does, a concrete example order that would be treated wrongly, and the
   BRS requirement at risk.
5. For each finding, decide whether you can close it yourself or must hand it to an engineer,
   and write the question you would ask.

## Acceptance criteria

- The call path lists at least three methods in the correct order.
- All eight rules are traced to a file and line, or marked as enforced elsewhere with the
  reason.
- At least two mismatches between the code and the contract are recorded, each with an
  example order.
- Every Copilot statement is marked verified, wrong or unverifiable, with evidence.
- Each finding names who resolves it.

## Stretch

- Week 2 found an order for an instrument that was not tradable being filled. Explain, from
  this code, how that could happen, and which service (API or Trade Executor) you would ask
  about next.

## Apply it to your project

Trace one trading rule from your team's backlog (BR-05 is a good start) through the team's actual code, with Copilot's help and your own verification. Record where the rule is enforced, file and line, and raise a question if the code and the story disagree.
