# Demo: Module 09 - Context and data flow diagrams

**Duration:** 15 minutes
**Prerequisite:** GitHub access to the course repository. The BRS open at section 5
(Stakeholders).

## Part 1: context diagram (5 min)

1. Open `context-diagram.md` in GitHub.
2. Narration: the platform is one circle. The diagram answers two questions only: who does the
   system exchange data with, and what data.
3. Ask the group which stakeholder in BRS section 5 is missing from the diagram (Programme
   Sponsor and Delivery Partner: they exchange no operational data with the system).

## Part 2: level 1 data flow diagram (7 min)

1. Open `dfd-level1.md`. Name the notation: processes, data stores, external entities, flows.
2. Follow one order from "order request" to "order status". Point out that the order is written
   to D2 before execution (BR-06).
3. Show that D4 (reporting copy) feeds Priya, not D2 directly (BR-16).

## Part 3: balance check (3 min)

1. Compare the flows crossing the boundary in the level 1 diagram with the context diagram.
2. Ask: which context flow does not appear in level 1 (trading rules from the Trading Desk,
   and the audit trail to Risk). Narration: an unbalanced diagram means a missing process or a
   missing requirement.

## Key message

A context diagram fixes the system boundary; a data flow diagram shows where data is created,
stored and consumed. Checking that the two balance finds gaps in the requirements.
