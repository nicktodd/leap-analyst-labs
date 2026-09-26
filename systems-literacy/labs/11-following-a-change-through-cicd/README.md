# Lab 11: Following a change through the CI/CD pipeline

## Objectives

- Read a CI/CD (Continuous Integration and Continuous Delivery) pipeline file and name its
  stages, triggers and gates.
- Follow one change from pull request to production and say what evidence each stage
  produces.
- Identify where the analyst contributes: acceptance criteria, test cases and approvals.

## Setup

Time: 60 minutes, pairs.

1. Open `pipeline/trade-api-pipeline.yml` from this folder. It is a GitHub Actions workflow.
2. Open `change-walkthrough.md` for your answers.
3. Keep `labs/05-reading-code-without-writing-it/trace-worksheet.md` to hand.

The change: Module 05 found that `OrderValidator` rejects a SELL of the entire holding. An
engineer changes `held > request.getQuantity()` to `held >= request.getQuantity()`, adds a
unit test, and opens a pull request against `main`.

## Tasks

1. Identify the triggers (`on:`) and say which jobs run on the pull request and which run
   only after the merge to `main`.
2. List the jobs in order with their `needs:` dependencies. Draw them as a Mermaid
   `flowchart LR` in `change-walkthrough.md`.
3. For each job, record what it checks, what evidence it leaves (log, report, image, approval)
   and what happens to the change if it fails.
4. Mark the points where an analyst contributes and say how: the acceptance criterion for the
   fix, the Postman regression test, the production approval, the release note.
5. Write the acceptance criterion for the fix in Given/When/Then form, and the Postman test
   that the `deploy-test` job would run to prove it.
6. Answer the questions at the end of `change-walkthrough.md`.

## Acceptance criteria

- Triggers and job order are correct, including which jobs are skipped on a pull request.
- The Mermaid diagram renders in GitHub and matches the `needs:` chain.
- Every job has its check, evidence and failure consequence recorded.
- The acceptance criterion names the exact holding and order quantities.
- At least three analyst touch points are identified.

## Stretch

- The pipeline has no step that tests with the Trade Executor and Kafka running. Describe
  what could still go wrong in production for this change, and which environment should
  catch it.
