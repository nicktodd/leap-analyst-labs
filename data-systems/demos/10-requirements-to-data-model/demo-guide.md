# Demo: Module 10 - From requirement to entity

**Duration:** 15 minutes
**Prerequisite:** the BRS open at section 8.2; a blank Markdown file with a Mermaid preview.

## Part 1: noun and verb pass on one requirement (5 min)

1. Read BR-06 aloud. Underline the nouns: order, firm commitment, execution, record of intent.
2. Narration: "order" and "execution" are separate things that happen at separate times, so
   they are separate entities. An order with no execution is valid (BR-06 says execution can
   fail or be delayed).

## Part 2: cardinality from the wording (5 min)

1. Type `ORDER ||--o{ EXECUTION : "is filled by"` and preview.
2. Ask the group: can one order have more than one execution. The BRS does not say. Record it
   as an open question for the Trading Desk instead of guessing.

## Part 3: traceability (5 min)

1. Add a row to a traceability table: BR-06, supported by ORDER and ORDER_EVENT.
2. Narration: every entity should trace to a requirement, and every Must requirement should
   trace to the model or be marked "not a data concern".

## Key message

The model comes from the requirements, one sentence at a time. Where the wording does not
settle a cardinality, the analyst asks; the question is part of the deliverable.
