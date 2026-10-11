# Lab 04: Calling the platform APIs in Postman

## Objectives

- Call the Trade REST API and the auth service from Postman using the provided collection.
- Obtain a JWT (JSON Web Token) and use it as a bearer token.
- Interpret each response (status code, `errorCode`, body) against the contract
  `shared/contracts/trade-api.yaml` and the Business Requirements Specification (BRS).
- Record what each response means for the user interface and for the requirement it tests.

## What you need to know

- **Collection**: a saved set of requests. This lab's collection has three folders: `Auth`,
  `Accounts` and `Orders`.
- **Environment**: a named set of variables. A request written as `{{baseUrl}}/api/v1/orders`
  uses the `baseUrl` value from the selected environment (top right of the Postman window).
- **Test script**: a few lines of code Postman runs after a response arrives (the `Scripts` or
  `Tests` tab). The `Log in` script copies `accessToken` into the environment so you do not
  have to paste it.
- **JWT claims**: a JWT is three Base64-encoded parts separated by dots; the middle part holds
  the claims. `sub` is the user, `accountId` the account the token may act on, `roles` what
  the user may do, and `exp` the expiry time in seconds since 1 January 1970.
- **Terminal**: Option B needs a command line (Terminal on macOS, PowerShell on Windows). Type
  each command and press Enter; the mock keeps running until you press Ctrl+C.

## Setup

Time: 60 minutes, pairs.

1. Install Postman (desktop app) and import from this folder:
   - `trade-api.postman_collection.json`
   - `local-platform.postman_environment.json` (the live platform) or
     `prism-mock.postman_environment.json` (the mock)
2. Choose one target. Your instructor confirms which.

### Option A: the live platform

The engineering track runs the platform under Docker Compose: the Trade REST API on
`http://localhost:8080` and the auth stub on `http://localhost:3000`. Your instructor gives
you a test username and password. Enter them in the environment (`username`, `password`).

Get a token by sending `Auth / Log in`. The test script stores `accessToken` in the
environment, and every other request sends it as `Authorization: Bearer <token>`. The token
expires after 15 minutes: send `Log in` again when requests start returning 401.

To get a token without Postman:

```bash
curl -s -X POST http://localhost:3000/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"<username>","password":"<password>"}'
```

Copy the `accessToken` value from the response.

### Option B: the Prism mock (no platform needed)

Prism serves the responses described in the contract. It needs Node.js 18 or later: check with
`node --version`, and if it is missing install the LTS version from https://nodejs.org (this
needs permission to install software). `npx` downloads Prism on first use, so npm registry
access is also needed. If you cannot install Node.js, use the address of the Prism instance
your instructor runs instead (set `baseUrl` and `authUrl` in the environment to it). From the root of `leap-analyst-labs`, in two terminals:

```bash
npx @stoplight/prism-cli mock shared/contracts/trade-api.yaml
npx @stoplight/prism-cli mock -p 4011 shared/contracts/auth-api.yaml
```

The Trade API mock listens on `http://localhost:4010` and the auth mock on
`http://localhost:4011`. Select the `Leap Prism mock` environment.

The mock checks that a bearer token is present but does not verify it. It returns the
examples written in the contract; the `Prefer` header on each error request tells Prism which
response to return (for example `Prefer: code=403`). The mock does not apply the business
rules, so it cannot tell you whether the platform enforces them. Record that limitation in
your observations.

## Tasks

1. Send `Auth / Log in` and `Auth / Current user`. Decode the token at jwt.io (training tokens
   only) and record the claims `sub`, `accountId`, `roles` and `exp`.
2. Send every request in the `Accounts` folder. For each, record the status code, the
   `errorCode` if any, and one sentence on what the response means for the user.
3. Send every request in the `Orders` folder in order. Record the same details.
4. Complete `observations.md`: map each response to the business rule (1 to 8 in the contract)
   and to the BRS requirement it provides evidence for.
5. Answer the three questions at the end of `observations.md`.

## Acceptance criteria

- Every request in the collection has been sent and its outcome recorded.
- Each error response is identified by its `errorCode`, not by its status code alone.
- Every row in `observations.md` cites a business rule number or a BR number.
- The observations state whether the evidence came from the live platform or the mock, and
  what the mock cannot prove.

## Stretch

- Add a request `Place order (SELL all held)` that sells exactly the quantity returned by
  `Get positions`. Predict the result from the contract before sending it. Keep the request:
  Module 05 traces the same rule into code.

## Apply it to your project

Build a Postman collection for your team's own API from the team's contract, with a login request and an order request. Add a test script to each request that checks the status code and error code the contract promises, and share the collection in the team repository under `analysis/api/`.
