# Lab 10: Mapping the trading workflow and peer review

## Objectives

- Map the as-is process for a client trade through the phone dealing desk, and the to-be
  process for the same trade on the direct trading platform.
- Identify pain points, handoffs and automation candidates, and trace each to-be step to a
  Business Requirements Specification (BRS) requirement (BR-nn).
- Record the agreed version as Mermaid flowcharts in your team repository, alongside the
  Week 2 data model, and review another team's version.

## Setup

1. Complete the workshop in Zoom Whiteboard first, following
   `docs/10-ProcessMappingWorkshop.docx` (Week 3 docs folder). This lab turns the agreed
   whiteboard version into version-controlled text.
2. Copy `process-map.md` from this folder into your team repository under
   `analysis/process/process-map.md`.
3. Preview Mermaid in GitHub or VS Code (see the Module 07 demo in
   `demos/07-process-modelling-in-mermaid`).

Time: 40 minutes for this part (after 50 minutes in Zoom Whiteboard), then 20 minutes of peer
review.

## Tasks

1. **As-is flowchart.** Replace the placeholder as-is block with your team's as-is flow. Use a
   start event, an end event, and a labelled exit on every decision.
2. **Pain points.** Mark each pain point on the as-is flow with a label of the form `P1`, `P2`
   and list them in the pain point table with the step and the stakeholder affected.
3. **To-be flowchart.** Write the to-be flow for a client placing a buy order, including the
   rejection path when a trading rule fails (BR-05) and the path when execution fails after the
   order is recorded (BR-06).
4. **Handoffs and automation.** Complete the handoff table: every place work or data passes
   between a person, team or system, and whether the to-be process automates it.
5. **Traceability.** Complete the traceability table so every to-be activity names a BR number
   or is marked as a question for the business.
6. **Commit and review.** Commit on a branch, open a pull request, and review another team's
   pull request using the checklist at the end of `process-map.md`.

## Acceptance criteria

- Both diagrams render in GitHub without errors.
- The as-is flow shows at least three pain points, each linked to a step.
- The to-be flow includes a rejection path and shows the order recorded before execution.
- Every handoff is listed with its automation decision.
- Every to-be activity traces to a BR number or an open question with a named stakeholder.
- The pull request has at least three review comments from another team, each answered.

## Stretch

- Add a flowchart for the Trading Desk handling a client dispute (BR-15), showing which records
  David needs and where each comes from.
