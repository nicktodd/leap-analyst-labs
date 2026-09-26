# Demo: Module 06 - UML sequence diagrams

**Duration:** 15 minutes
**Prerequisite:** `demos/06-uml-sequence-diagrams/view-holdings-sequence.md` open in GitHub; the platform `ARCHITECTURE.md` diagram available to show.

## Part 1: lifelines and messages (5 min)

1. Map each lifeline to a box on the architecture diagram. Narration: the participants in a
   sequence diagram are the components that already exist; the diagram adds time and order.
2. Walk messages 1 to 8. Solid arrow for a request, dashed for a reply.

## Part 2: fragments (5 min)

1. Point to the `alt` block. Narration: it states BR-02 as behaviour, so a tester can write
   one test per branch.
2. Show `opt` and `loop` in the Mermaid documentation and name one use for each on the
   platform (loop: polling order status; opt: showing an indicative price, BR-13).

## Part 3: edit live (5 min)

1. Add `Note over API,DB: read only` and preview.
2. Ask: which message would change if the Trade REST API cached positions. Take answers.

## Key message

A sequence diagram answers "who calls whom, in what order, and what happens when it goes
wrong". Each alternative branch is a test case for the engineering and quality assurance (QA)
teams.
