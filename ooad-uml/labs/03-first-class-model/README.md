# Lab 03: Produce and peer review a first class model

## Objectives

- Produce a first UML (Unified Modelling Language) class model of the Enterprise Trading
  Platform domain in Mermaid.
- Trace each class and relationship to a requirement in the Business Requirements
  Specification (BRS).
- Review another pair's model against a checklist and record the findings.

## Setup

1. Open `class-model.md` from this folder in your editor, with a Mermaid preview (GitHub,
   or the Markdown preview in Visual Studio Code).
2. Have the BRS (`LEAP-Project-Business-Requirements-Specification.docx`, Week 1 docs folder)
   and your Week 2 data model to hand.
3. Open `docs/03-ClassModelPeerReview.docx` (Week 4 docs folder) for the review.

Time: 75 minutes, pairs. 45 minutes to model, 30 minutes to review.

## Tasks

1. From BR-01 to BR-15, list candidate classes (nouns) and responsibilities (verbs). Discard
   nouns that are attributes or synonyms, and record why.
2. Complete the diagram in `class-model.md`: at least eight classes, each with its key
   attributes and at least one operation where the class has behaviour.
3. Add every relationship with a multiplicity at both ends. Use at least one association, one
   aggregation, one composition and one inheritance, and be ready to justify each choice.
4. Fill in the traceability table under the diagram: each class to the BR numbers it serves.
5. Swap files with another pair. Review their model with the checklist in
   `docs/03-ClassModelPeerReview.docx` and record at least five findings.
6. Update your own model from the review you receive. Keep a short change log at the end of
   the file.

## Acceptance criteria

- The Mermaid diagram renders without errors.
- At least eight classes; each class traces to at least one BR number.
- Every relationship has multiplicities at both ends and reads as a true sentence.
- Aggregation, composition and inheritance are each used once and justified in a comment.
- The peer review records at least five findings with a severity and a proposed change.

## Stretch

- Add the enumerations (order side, order status, account status) as `<<enumeration>>`
  classes and link them.
- Mark which attributes are identifiers, and compare them with the keys in the Week 2 data
  model. Where do the two models differ, and why.
