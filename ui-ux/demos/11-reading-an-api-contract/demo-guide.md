# Demo: Module 11 - Reading the Trade REST API contract

**Duration:** 25 minutes
**Prerequisite:** `shared/contracts/trade-api.yaml` open in a Swagger viewer (Swagger Editor,
or the VS Code OpenAPI preview) and in a plain text editor side by side. `reading-checklist.md`
from this folder.

## Part 1: the contract as a document (5 min)

1. Show the rendered Swagger view. Narration: this is the same file the Angular UI generates
   its typed client from; a field renamed here is a compile error in the UI.
2. Read the `info.description` aloud down to the business rules table. Point out that the
   eight business rules are stated in order and "the first failure wins": that order is what
   the user sees when two things are wrong at once.

## Part 2: one endpoint, end to end (10 min)

1. Expand `POST /api/v1/orders`. Show the request body schema `PlaceOrderRequest`: six
   required fields.
2. Switch to the text view and show `quantity` (`minimum: 1`) and `price` (`exclusiveMinimum: 0`,
   `multipleOf: 0.01`). Ask: which of these would you write as an acceptance criterion on the
   order ticket screen. Answer: all of them, as inline validation.
3. Expand the responses. Read 200, 400, 401, 403, 404, 409, 422 and map each to a UI state
   from the Module 06 diagram.
4. Open the `ErrorResponse` schema. Read "Clients branch on errorCode, never on message and
   never on the HTTP status alone, since 404 and 409 each carry two codes". Narration: this is
   why a screen spec maps each `errorCode` to its own user-facing text.

## Part 3: what the contract does not say (10 min)

1. Open `GET /api/v1/accounts/{id}/balance`. Read "Returns available cash only". Ask: where
   does the portfolio screen get market value from. Answer: `portfolio-api.yaml`, a separate
   Sprint 10 contract.
2. Open `auth-api.yaml` and find the `roles` claim: `CUSTOMER` and `ADMIN` only. Ask: where do
   David (operations) and Priya (commercial analyst) fit. Record it as an open question for
   contract sign-off.
3. Walk through `reading-checklist.md` and show how each question led to a finding.

## Key message

The analyst does not need to write OpenAPI to review it. Read it as a list of promises: what
the screen can ask for, what it gets back, and every way it can fail. Gaps found at contract
sign-off cost minutes; gaps found in the Angular build cost a sprint.
