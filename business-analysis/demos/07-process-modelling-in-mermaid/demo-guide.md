# Demo: Module 07 - As-is and to-be flows in Mermaid

**Duration:** 20 minutes
**Prerequisite:** GitHub access to the course repository, or VS Code with a Mermaid preview
extension. The BRS open at section 2 and section 8.2.

## Part 1: read the as-is flow (7 min)

1. Open `order-placement-as-is.md` in GitHub so the diagram renders.
2. Narration: rounded shapes are start and end events, rectangles are activities, diamonds are
   decisions. Every decision has labelled exits.
3. Trace the path from "Client wants to trade" to "Client sees update next day". Ask the group
   where the client waits.
4. Point at the three pain points under the diagram and link each to a step.

## Part 2: build part of the to-be flow live (8 min)

1. Open a new Markdown file, type the `mermaid` fence and `flowchart TD`.
2. Add the start event, "Client enters order" and "Platform checks trading rules". Preview.
3. Add the decision "All rules pass" with a `No` and a `Yes` exit. Ask: what does BR-06 say must
   happen before execution. Add "Order recorded as NEW".
4. Open `order-placement-to-be.md` to show the complete version and the traceability table.

## Part 3: diff and review (5 min)

1. Change the label on one arrow and show the change as a Git diff: one line, easy to review.
2. Narration: a flow kept as text sits in the same repository as the Week 2 data model, so a
   reviewer sees process and data change in one pull request.

## Key message

An as-is flow shows where the current process hurts; a to-be flow shows how the requirements
remove that pain. Kept in Mermaid, both are versioned, diffed and reviewed like code.
