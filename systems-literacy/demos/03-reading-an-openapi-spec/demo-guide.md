# Demo: Module 03 - Reading an OpenAPI spec

**Duration:** 25 minutes
**Prerequisite:** `shared/contracts/trade-api.yaml` open in an editor with a YAML outline, or
pasted into editor.swagger.io; `place-order-sequence.md` from this folder open in GitHub.

## Part 1: find your way around the file (8 min)

1. Collapse the file to the top level: `info`, `servers`, `security`, `paths`, `components`.
   Narration: `paths` is what you can call; `components` is the vocabulary those calls share.
2. Expand `info.description` and read the business rules table. Narration: these eight rules
   are BR-05 made precise.

## Part 2: follow one operation (10 min)

1. Expand `paths./api/v1/orders.post`. Read `operationId`, `requestBody` and `responses`.
2. Follow `$ref: '#/components/schemas/PlaceOrderRequest'` into `components`. Point out
   `required`, `minimum`, `exclusiveMinimum` and `additionalProperties: false`.
3. Ask: which field would a UI developer most likely get wrong. Expected answer: `accountId`
   is the numeric key, not the `ACC-000001` string.

## Part 3: turn it into a sequence diagram (7 min)

1. Open `place-order-sequence.md`. Map each arrow to a line in the YAML.
2. Narration: the diagram is a Mermaid file in Git, so it is reviewed and versioned with the
   contract it describes.

## Key message

An OpenAPI file answers four questions for every operation: what to send, what comes back,
what can go wrong and who may call it. A sequence diagram makes those answers readable by the
business.
