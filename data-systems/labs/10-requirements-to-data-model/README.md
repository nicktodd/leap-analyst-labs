# Lab 10: Translating business requirements into a data model

## Objectives

- Identify the entities, attributes and relationships implied by the Business Requirements
  Specification (BRS) for the Enterprise Trading Platform.
- Express the model as a Mermaid entity relationship (ER) diagram kept in Git.
- Trace every entity back to at least one BRS requirement (BR-nn), and record the questions
  the requirements leave open.

## Setup

1. Open the BRS (`LEAP-Project-Business-Requirements-Specification.docx`, Week 1 docs folder).
   Focus on sections 8.1 to 8.6, the glossary and the personas.
2. Copy `data-model.md` from this folder into your team repository under
   `analysis/data-model/data-model.md`.
3. Preview Mermaid in GitHub or VS Code (see the Module 08 demo).

Work in your project team. Time: 90 minutes, including 10 minutes to commit and open a pull
request.

## Tasks

1. **Noun and verb pass.** Read BR-01 to BR-17 and list candidate entities (nouns) and
   relationships (verbs) in the table in `data-model.md`. Mark each candidate as entity,
   attribute or out of scope.
2. **Entities and keys.** For each entity, record its identifier and five to eight key
   attributes. Decide for each identifier whether it is a business reference or a surrogate key.
3. **Relationships and cardinality.** Write the `erDiagram` block. Every relationship needs
   both ends of its cardinality and a verb label.
4. **Traceability.** Complete the requirement-to-entity table so every Must requirement from
   BR-01 to BR-16 is supported by at least one entity, or explicitly marked as not a data
   concern.
5. **Open questions.** Record at least four questions for the business (Trading Desk, Risk and
   Compliance, Finance) that the model exposes.
6. **Commit.** Commit the file with a clear message and open a pull request for peer review
   in Module 11.

## Acceptance criteria

- The Mermaid diagram renders in GitHub without errors.
- The model contains, at minimum, client or account, instrument, order, an audit or event
  record, position, cash and a market price or quote.
- Every relationship shows cardinality at both ends and has a verb label.
- The traceability table covers BR-02, BR-04 to BR-06, BR-08 to BR-12 and BR-14 to BR-16.
- At least four open questions are recorded, each naming the stakeholder who can answer it.
- The work is committed to the team repository on a branch with a pull request open.

## Stretch

- Compare your model with the training database diagram in
  `demos/08-er-diagrams-in-mermaid/trading-db-erd.md`. List what the training database is
  missing against the BRS (for example the instrument classes in BR-12) and what your model is
  missing against the database.
