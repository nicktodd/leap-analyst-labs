# Demo: Module 11 - Following a change through CI/CD

**Duration:** 15 minutes
**Prerequisite:** `labs/11-following-a-change-through-cicd/pipeline/trade-api-pipeline.yml`
open; optionally the Actions tab of any GitHub repository with a recent run.

## Part 1: the shape of the file (7 min)

1. Point to `on:`. Narration: triggers decide when the pipeline runs.
2. Point to `jobs:` and each `needs:`. Narration: `needs` makes the order; a failed job stops
   everything that depends on it.
3. Point to `environment: production`. Narration: GitHub holds the deployment until a named
   reviewer approves.

## Part 2: what a run looks like (8 min)

1. If a live repository is available, open a completed run and show the job graph, a log and
   a test summary. Otherwise draw the job chain on the whiteboard.
2. Ask: where in this chain would you want evidence that BR-05 still holds after a change.
   Expected answer: the regression suite in `deploy-test`.

## Key message

A pipeline is a sequence of gates. Each gate leaves evidence; the analyst supplies the tests
that make the gates meaningful.
