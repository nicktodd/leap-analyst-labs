# Demo: Module 08 - ER diagrams in Mermaid

**Duration:** 20 minutes
**Prerequisite:** a GitHub account with access to the course repository, or VS Code with a
Mermaid preview extension. The training database schema (`shared/trading-db/01-schema.sql`)
open in a second window.

## Part 1: from schema to entities (5 min)

1. Open `shared/trading-db/01-schema.sql` and scroll through the `CREATE TABLE` statements.
2. Narration: each table is an entity; each `PRIMARY KEY` identifies one instance; each
   `FOREIGN KEY` is a relationship line on the diagram.
3. Point out the two identifiers on `accounts`: `id` (surrogate key) and `account_id`
   (business reference). The foreign keys point at `id`.

## Part 2: build the diagram live (10 min)

1. Open a new Markdown file and type the opening fence with `mermaid` and `erDiagram`.
2. Add `ACCOUNTS ||--o{ ORDERS : places` and preview it. Read the line aloud.
3. Add `INSTRUMENTS`, `POSITIONS` and `ORDER_EVENTS`. Ask the group what cardinality each
   end needs before typing it.
4. Add attribute blocks for two entities, marking `PK`, `FK` and `UK`.
5. Open `demos/08-er-diagrams-in-mermaid/trading-db-erd.md` to show the complete version.
6. If the live preview is unavailable, use the deck: each Mermaid code slide is followed by
   its rendered diagram (Step 1 to Step 3), and `shared/trading-db/erd.png` is the complete
   rendered diagram.

## Part 3: what the diagram does not say (5 min)

1. Point at `ORDERS |o--o{ CASH_MOVEMENTS`. Narration: the schema has an `order_id` column on
   `cash_movements` but no foreign key constraint, so the database will not stop a movement
   pointing at an order that does not exist. The diagram shows intent; the constraint list
   shows enforcement.
2. Point at `ORDERS ||--o| SETTLEMENTS`. Ask: is "zero or one" right for a cancelled order, and
   for a filled order that failed settlement and was retried.

## Key message

A Mermaid ER diagram is text in Git: it is reviewed, versioned and diffed like any other
artefact. Its value is the questions it forces about cardinality and ownership, which are
business questions for the analyst to answer.
