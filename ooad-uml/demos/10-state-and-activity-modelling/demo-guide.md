# Demo: Module 10 - The lifecycle of a trade

**Duration:** 20 minutes
**Prerequisite:** `demos/10-state-and-activity-modelling/order-lifecycle.md` open in GitHub.

## Part 1: the state diagram (10 min)

1. Show the Order state diagram. Narration: a state diagram answers "what can happen to one
   thing over its life". It names the states, the transitions and the events that trigger them.
2. Map each state to `orders.status` and each transition to an `order_events.event_type`.
   Point out that Received is a modelling state with no status value: the database records it
   only as an event.
3. Show the composite Filled state. Ask: is settlement a state of the order or of a separate
   thing. Take both views; in the data it is a separate `settlements` table.

## Part 2: the activity diagram (7 min)

1. Show the flowchart. Narration: an activity diagram answers "what steps happen, in what
   order, and who does each". Swimlanes show responsibility.
2. Trace one rejected path (suspended account) and one filled path.

## Part 3: choose the diagram (3 min)

1. Read three questions and ask which diagram answers each: "Can a cancelled order be
   filled" (state), "Who checks the cash balance" (activity or sequence), "Which services
   exchange messages to fill an order" (sequence).

## Key message

Choose the diagram from the question. State diagrams give the rules of one object's life;
activity diagrams give the flow of work; sequence diagrams give the messages between parts.
