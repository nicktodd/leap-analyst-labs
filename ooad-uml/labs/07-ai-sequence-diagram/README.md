# Lab 07: AI-assisted sequence diagram generation and validation

## Objectives

- Model the trade capture interaction end to end, from Joanna pressing Buy to her position
  updating.
- Generate a first draft with GitHub Copilot Chat, then validate it against the architecture,
  the API (Application Programming Interface) contract, the Kafka topic catalogue and the
  Business Requirements Specification (BRS).
- Record every defect in the AI output and produce a corrected diagram.

## Setup

1. Open this folder in Visual Studio Code with GitHub Copilot Chat enabled.
2. Open the sources you validate against:
   - `leap-enterprise-trading-platform/docs/ARCHITECTURE.md`
   - `shared/contracts/trade-api.yaml` (operation `placeOrder`)
   - `shared/contracts/kafka-topics.md`
   - your Lab 03 class model
3. Open `docs/07-SequenceDiagramValidation.docx` (Week 4 docs folder).

Time: 90 minutes, pairs.

## Tasks

1. Paste the prompt from `prompt.md` into Copilot Chat. Save its answer as
   `my-copilot-draft.md` in this folder. If Copilot is unavailable, use
   `copilot-draft-sequence.md`, a draft produced with the same prompt.
2. Check that the draft renders. Fix syntax errors only; do not correct content yet.
3. Validate the draft message by message against the sources. For each message ask: does
   this participant exist, does it make this call, in this order, with this name and payload.
4. Check the entities and cardinalities in the messages against your class model: one order
   per request, one or more audit events per order, one position per account and instrument.
5. Record each defect in the validation table in the Word document with its source and the
   rule or requirement it breaks.
6. Write `trade-capture-sequence.md`: the corrected diagram, with an `alt` block for a
   rejection at validation and one for a rejection at execution.

## Acceptance criteria

- The corrected diagram renders and uses only participants from `ARCHITECTURE.md`.
- Topic names, event types and the endpoint match the contracts exactly.
- The order is recorded before it is published and before execution (BR-06).
- Position, cash and the trade record update in one step (BR-09).
- At least six defects in the AI draft are recorded, each with its evidence.

## Stretch

- Ask Copilot to review your corrected diagram against BR-06 and BR-09. Record whether its
  review found anything you missed, and anything it claimed wrongly.

## Apply it to your project

Draw the same trade capture sequence for your team's own platform, using the team's API contract and event design rather than the shared contracts. Keep it in the team repository under `analysis/sequence/` and update it when the design changes.
