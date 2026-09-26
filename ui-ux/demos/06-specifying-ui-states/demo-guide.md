# Demo: Module 06 - UI states as a Mermaid state diagram

**Duration:** 20 minutes
**Prerequisite:** GitHub or VS Code with a Mermaid preview. `order-ticket-states.md` from this
folder and `shared/contracts/trade-api.yaml` open side by side.

## Part 1: the happy path is one state in ten (5 min)

1. Show the Module 03 order ticket wireframe. Ask: how many screens does this wireframe
   describe. Take answers, then state that it describes one state out of roughly ten.
2. Open a new Markdown file and type `stateDiagram-v2` inside a Mermaid fence.
3. Add `[*] --> Ready`, `Ready --> Submitting : Submit`, `Submitting --> Filled`. Preview it.

## Part 2: let the contract add the states (10 min)

1. Open `trade-api.yaml` at the `placeOrder` responses. Read out the status codes: 200, 400,
   401, 403, 404, 409, 422.
2. Narration: every response the API can return is a state the screen must show. Add
   `Rejected`, `PermissionDenied` and `SessionExpired` with the error codes as transition labels.
3. Read the description of `OrderStatus`: `NEW` is a working state. Add `Working`, with
   transitions to `Filled`, `Rejected` and `Cancelled`.
4. Ask the group which states are missing before the form is shown. Add `Loading` and
   `LoadError`.
5. Open the finished `order-ticket-states.md` and compare.

## Part 3: the state notes table (5 min)

1. Scroll to the state notes table. Narration: the diagram gives the states and transitions;
   the table tells the engineer what the user sees in each and where the rule came from.
2. Point at `SubmitError`. Ask: if the network fails after the user presses Confirm, has the
   order been placed. The honest answer is "unknown", which is why the message tells the user
   to check order history rather than retry (business rule 8, idempotency).

## Key message

A screen specification is incomplete until every state has been named. The API contract is
the fastest way to find them: each response code is a state, and each state needs words,
behaviour and an accessibility note.
