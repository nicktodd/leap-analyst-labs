# Lab 07: Validating an AI-generated screen spec against WCAG

## Objectives

- Review an AI-generated screen specification for the order ticket against WCAG (Web Content
  Accessibility Guidelines) 2.2 level AA and the Trade REST API contract.
- Find the states the AI-generated Mermaid state diagram is missing or has wrong, and correct
  the diagram.
- Record every gap as a defect the Angular build would otherwise inherit.

## Setup

1. Open `docs/07-AIGeneratedScreenSpec.docx` (the AI-generated screen specification) and
   `docs/07-WCAGValidationFindings.docx` (your findings log) from the Week 5 docs folder.
2. Open `ai-generated-states.md` in this folder and `shared/contracts/trade-api.yaml`.
3. Copy `ai-generated-states.md` into your team repository as
   `analysis/ui-states/order-ticket-states.md` on a new branch.

Work in pairs. Time: 90 minutes (50 minutes for the specification, 30 minutes for the state
diagram, 10 minutes to commit).

## Tasks

1. **WCAG pass.** Read the screen specification section by section. For each element, check
   it against the Module 02 WCAG checklist (perceivable, operable, understandable, robust).
   Log each gap in the findings document with the success criterion number.
2. **Contract pass.** Compare every field, status and error message in the specification with
   `trade-api.yaml`. Log anything the contract does not support.
3. **State diagram review.** Compare `ai-generated-states.md` with the `OrderStatus` enum, the
   `placeOrder` and `cancelOrder` responses and the Module 06 state checklist (empty, loading,
   error, permission-denied). List every missing, invented or wrong state and transition.
4. **Correct the diagram.** Edit your copy of the diagram so it matches the contract and covers
   every state. Update the state notes table so no state relies on colour alone and no error
   displays the raw API `message`.
5. **Commit.** Commit with a message that names what changed and open a pull request.

## Acceptance criteria

- The findings log contains at least eight WCAG gaps, each with a success criterion number,
  a severity and a proposed fix.
- At least three contract gaps are logged.
- The corrected diagram renders in GitHub, contains no `PartiallyFilled` state, does not allow
  a filled order to be cancelled, and includes loading, load error, working (`NEW`),
  permission-denied and session-expired states.
- Every state in the notes table describes text, not only colour or an icon.
- The work is committed on a branch with a pull request open.

## Stretch

- Ask Copilot Chat to review your corrected diagram against `trade-api.yaml`. Record one point
  where you accepted its suggestion and one where you rejected it, with your reason.
