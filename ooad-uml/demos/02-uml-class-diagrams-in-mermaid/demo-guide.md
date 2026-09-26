# Demo: Module 02 - UML class diagrams in Mermaid

**Duration:** 20 minutes
**Prerequisite:** a browser signed in to GitHub; `demos/02-uml-class-diagrams-in-mermaid/notation.md` open in the repository view and in an editor.

## Part 1: from text to picture (5 min)

1. Show diagram 1 as source, then as rendered. Narration: a class diagram is text that
   renders as a picture, so it can be reviewed line by line in a pull request.
2. Point out the attribute type, the visibility marker `+` and the operations section.

## Part 2: the four relationships (10 min)

1. Show diagrams 2 to 5 in turn. For each, read the arrow aloud as a sentence: "one account
   places zero or more orders".
2. Aggregation against composition: ask the room whether a position can exist without its
   account (in the data, closed accounts keep positions, so aggregation) and whether an order
   event can exist without its order (no: composition).
3. Inheritance: an equity is an instrument. Only Bond adds an attribute (maturity).

## Part 3: edit live (5 min)

1. In the editor, change diagram 2's multiplicity to `"1..*"` and preview. Ask: what business
   rule does that now state, and is it true (no: a new account has no orders).
2. Add `Instrument "1" --> "0..*" Order : traded in` and preview.

## Key message

Every line of a class diagram states a business rule. Read each relationship as a sentence
and check it against the Business Requirements Specification (BRS) and the data before you
commit it.
