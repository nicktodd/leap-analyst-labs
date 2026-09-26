# Demo: Module 04 - Calling the platform APIs in Postman

**Duration:** 15 minutes
**Prerequisite:** Postman installed; Node.js 18 or later; the collection and environment from
`labs/04-calling-the-platform-apis-in-postman/` imported; either the platform running under
Docker Compose or the Prism mock started (see the lab README).

## Part 1: environment and token (5 min)

1. Select the environment. Show `baseUrl`, `authUrl` and `accountId`.
2. Send `Auth / Log in`. Show the test script storing `accessToken`.
   Narration: the token proves who you are; paste it into jwt.io only for a training token,
   never for a production one.

## Part 2: a read and a write (6 min)

1. Send `Accounts / Get balance`. Point at `cashBalance`, `currency` and `asOf`.
2. Send `Orders / Place order (BUY)`. Point at `status: NEW` and explain that the fill happens
   later.
3. Send `Orders / Place order (duplicate key)`. Show 409 with `ORD-409`.

## Part 3: what the status code does not tell you (4 min)

1. Send `Accounts / Get another account`. Show 403 `ACC-403`.
2. Narration: 403 here means the token is valid but does not reach account 2. That is BR-02
   working.

## Key message

Postman lets an analyst see exactly what the platform returns. Every response is evidence
for or against a requirement.
