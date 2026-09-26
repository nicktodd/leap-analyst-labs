# Demo: Module 07 - COBOL and CICS for analysts

**Duration:** 20 minutes
**Prerequisite:** `ACCTUPD.cbl` and `ACCTINQ.cbl` open in an editor with COBOL highlighting
(the VS Code "COBOL" extension is enough). Survey depth only: participants read, never write.

## Part 1: the four divisions (6 min)

1. Open `ACCTUPD.cbl`. Point to IDENTIFICATION, ENVIRONMENT, DATA and PROCEDURE divisions.
2. Narration: ENVIRONMENT names the files, DATA describes every field, PROCEDURE is the logic.

## Part 2: the record layout is the data dictionary (7 min)

1. Read `TRADE-RECORD`. Explain `PIC X(10)` (ten characters), `PIC 9(7)` (seven digits) and
   `PIC 9(9)V99` (implied decimal point, two decimal places).
2. Read the `88 ACCT-ACTIVE` level. Narration: a named condition; the business meaning of
   status `A` lives here.
3. Ask: what happens to a trade whose account number is not on the master file. Walk to
   `APPLY-TRADE`: it displays a message and carries on to the COMPUTE and REWRITE. Ask the
   room whether that is a defect. It is a question for the engineer, and a strong analyst
   finding.

## Part 3: online versus batch (7 min)

1. Open `ACCTINQ.cbl`. Point to `EXEC CICS READ` and `EXEC CICS RETURN`.
2. Narration: CICS (Customer Information Control System) runs short online transactions
   against the same master file the batch program updates overnight. This is why online
   balances and batch windows must be coordinated.

## Key message

An analyst reads COBOL for three things: the record layouts (the data), the conditions (the
rules) and the file names (the dependencies).
