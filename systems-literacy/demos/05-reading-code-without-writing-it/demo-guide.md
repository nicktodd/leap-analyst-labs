# Demo: Module 05 - Reading code without writing it

**Duration:** 20 minutes
**Prerequisite:** `labs/05-reading-code-without-writing-it/code/` open in VS Code with GitHub
Copilot Chat signed in; `shared/contracts/trade-api.yaml` open beside it.

## Part 1: orient in the repository (5 min)

1. Show the folder. Narration: file names and package names tell you the layer:
   `api` receives requests, `service` holds logic, `domain` holds shared vocabulary.
2. Use Search (Ctrl+Shift+F) for `/api/v1/orders`. It finds `OrderController`.

## Part 2: follow the flow (8 min)

1. In `OrderController.placeOrder`, use Go to Definition (F12) on `orderService.placeOrder`.
2. In `OrderService`, point out `validator.validate`, `saveRejected` and `saveNew`.
   Narration: rejected orders are recorded, which the contract requires for the audit trail.
3. Open `OrderValidator` and read rules 1 and 2 aloud against the contract table.
   Do not read rule 7: the lab asks participants to find its problem.

## Part 3: AI explanation, then verification (7 min)

1. Ask Copilot Chat: "What does OrderController.placeOrder check before calling the service?"
2. Check its answer line by line against the code. Show one statement you can verify and one
   about a class that is not in the folder, which you cannot.

## Key message

Read code the way you read a contract: find the entry point, follow the calls, match each
rule to a line. Treat an AI explanation as a lead to check, not as evidence.
