# Demo: Module 07 - As-is and to-be flows in Mermaid

**Duration:** 20 minutes
**Prerequisite:** GitHub access to the course repository, or VS Code with a Mermaid preview
extension. The BRS open at sections 2 and 8.5 (BR-14 and BR-15).

The demo uses the dispute-handling process, not order placement: participants map order
placement themselves in the Module 10 lab.

## Part 1: read the as-is flow (7 min)

1. Open `dispute-handling-as-is.md` in GitHub so the diagram renders.
2. Narration: rounded shapes are start and end events, rectangles are activities, diamonds are
   decisions. Every decision has labelled exits.
3. Trace the path from "Client disputes a fill" to each end event. Ask the group where the time
   goes (the loop between "Ops asks engineers for logs" and "Ops chases again").
4. Point at the three pain points under the diagram and link each to a step.

## Part 2: build part of the to-be flow live (8 min)

1. Open a new Markdown file, type the `mermaid` fence and `flowchart TD`.
2. Add the start event, "Ops opens dispute case" and "Ops finds order by ID". Preview.
3. Ask: what does BR-15 say must be possible. Add "Platform shows order lifecycle" and
   "Ops checks quote and time used", then the decision "Price correct" with a `No` and a `Yes`
   exit.
4. Open `dispute-handling-to-be.md` to show the complete version and the traceability table.
   Point out that the correction is recorded as a new entry (BR-14): the original is never
   changed.

## Part 3: diff and review (5 min)

1. Change the label on one arrow and show the change as a Git diff: one line, easy to review.
2. Narration: a flow kept as text sits in the same repository as the Week 2 data model, so a
   reviewer sees process and data change in one pull request.

## Key message

An as-is flow shows where the current process hurts; a to-be flow shows how the requirements
remove that pain. Kept in Mermaid, both are versioned, diffed and reviewed like code.
