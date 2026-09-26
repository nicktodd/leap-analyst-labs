# Demo: Module 13 - Kafka and event processing

**Duration:** 15 minutes
**Prerequisite:** `event-flow.md` open in GitHub; `trade-event-filled.json` and
`shared/contracts/kafka-topics.md` open in an editor.

## Part 1: topics, producers, consumers (6 min)

1. Open `event-flow.md`. Trace an order from the Trade REST API to `orders`, to the Trade
   Executor, to `trade-events` and out to three consumer groups.
2. Narration: the API does not know who listens to `trade-events`; adding a consumer needs no
   change to the producer.

## Part 2: read one event (5 min)

1. Open `trade-event-filled.json`. Point to the envelope (`eventId`, `eventType`,
   `eventTime`, `source`, `schemaVersion`) and the payload.
2. Point to `cashDelta` and `positionQuantityAfter`. Narration: this one message is evidence
   for BR-09, because it states the cash and position change the fill produced.

## Part 3: tracing a problem (4 min)

1. Show the "Tracing a missing fill" table. Ask: Joanna's order has been `NEW` for ten
   minutes. Which row do you check first. Expected answer: whether the executor consumed it
   (consumer lag), then the dead-letter topic.

## Key message

Events decouple the producer from its consumers. When something goes wrong, trace the
message: produced, consumed, processed, or parked in a dead-letter topic.
