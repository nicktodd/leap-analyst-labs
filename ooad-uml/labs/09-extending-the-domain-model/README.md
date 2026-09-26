# Lab 09: Extend the domain model and cross-check acceptance criteria

## Objectives

- Extend the class model to cover the user stories written in Week 3.
- Cross-check every acceptance criterion against the model: each criterion must be testable
  using classes, attributes and relationships the model contains.
- Record gaps in both directions: criteria the model cannot support, and model elements no
  requirement asks for.

## Setup

1. Copy your corrected Lab 03 model into this folder as `domain-model.md`. If you need a
   starting point, use `domain-model-start.md`, which contains the Lab 03 reference model.
2. Have your team's Week 3 user stories and acceptance criteria open. If your backlog is
   incomplete, use the eight stories in `docs/09-AcceptanceCriteriaCrossCheck.docx`.
3. Keep the notes from the joint domain-model reconciliation session with the engineering
   track to hand.

Time: 75 minutes, pairs.

## Tasks

1. Read each user story and mark the nouns and rules its acceptance criteria depend on.
2. Extend the model: add the classes, attributes, operations and relationships the stories
   need (for example cancelling an order, a watchlist, notifications, price alerts or an
   account suspension reason).
3. Apply every change agreed in the reconciliation session, and mark each with a Mermaid
   comment (`%% agreed with engineering: ...`).
4. For every acceptance criterion, fill one row of the cross-check table in the Word
   document: the model elements it uses, and Supported, Partly supported or Not supported.
5. List model elements that no story or BR (business requirement) uses. Decide for each:
   remove, keep with a reason, or raise a question.
6. Write the three open questions you would take to the Product Owner.

## Acceptance criteria

- The extended model renders and every new element traces to a story or BR number.
- Every acceptance criterion has a row in the cross-check table.
- Each Not supported row has a proposed model change or a question.
- Changes agreed with engineering are visible as comments in the model.

## Stretch

- Add an `<<interface>>` for a Notifier and show which classes depend on it. Explain in one
  sentence why an analyst might model an interface.
