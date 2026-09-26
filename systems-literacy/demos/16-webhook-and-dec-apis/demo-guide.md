# Demo: Module 16 - Webhook and DEC APIs

**Duration:** 10 minutes
**Prerequisite:** `webhook-example.md` open in GitHub.

## Part 1: the callback (5 min)

1. Show the request. Narration: in REST the platform calls out; in a webhook the other
   system calls in when something happens.
2. Point to `X-Signature` and `X-Delivery-Id`. Narration: one proves who sent it, the other
   makes a retry safe.

## Part 2: silent failure (5 min)

1. Walk the checklist. Ask: which row would have caught a URL change after a deployment.
   Expected answer: the first, backed by reconciliation.

## Key message

A webhook fails by not arriving. Specify registration, signature checks, idempotency and a
reconciliation, so a missing callback is noticed rather than assumed.
