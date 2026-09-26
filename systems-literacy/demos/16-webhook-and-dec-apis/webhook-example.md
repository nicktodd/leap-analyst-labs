# Webhook example: price alert delivery (illustrative)

A third-party notification provider calls the platform back when an SMS (Short Message
Service) alert to a client has been delivered or has failed. The platform registered this
callback URL with the provider in advance.

## The callback the provider sends

```http
POST /webhooks/notifications HTTP/1.1
Host: trading.example.com
Content-Type: application/json
X-Signature: sha256=5d41402abc4b2a76b9719d911017c592
X-Delivery-Id: 7e1c9a2e-3b4d-4f10-9c2a-11aa22bb33cc

{
  "event": "message.failed",
  "messageId": "msg-889231",
  "clientReference": "ALERT-000731",
  "failureReason": "UNREACHABLE",
  "occurredAt": "2026-09-28T09:15:02Z"
}
```

The platform replies `200 OK` with an empty body within a few seconds. Anything else, or a
timeout, makes the provider retry.

## What to check when a webhook fails silently

| Check | Why |
|---|---|
| Is the callback URL registered, and still correct after the last deployment | A changed URL means every call goes nowhere |
| Did the provider's delivery log record an attempt | Separates "never sent" from "sent and lost" |
| Did the platform respond 2xx | A 500 triggers retries; a 200 with a failed process hides the error |
| Was the signature verified | Unsigned calls must be rejected; a wrong secret rejects every call |
| Is the handler idempotent on `X-Delivery-Id` | Retries deliver the same event more than once |
| Is there a reconciliation | A periodic pull of status catches callbacks that never arrived |
