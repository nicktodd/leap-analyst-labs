      *================================================================
      * ACCTUPD - nightly account cash update (illustrative)
      * Reads the day's filled trades and applies each to the
      * account master file. Run as step UPDATE in job NIGHTSYNC.
      *================================================================
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ACCTUPD.
      *
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT TRADE-FILE   ASSIGN TO TRADEIN.
           SELECT ACCOUNT-FILE ASSIGN TO ACCTMAST
               ORGANIZATION IS INDEXED
               ACCESS MODE IS RANDOM
               RECORD KEY IS ACCT-NUMBER.
      *
       DATA DIVISION.
       FILE SECTION.
       FD  TRADE-FILE.
       01  TRADE-RECORD.
           05 TR-ACCT-NUMBER     PIC X(10).
           05 TR-SIDE            PIC X(4).
           05 TR-QUANTITY        PIC 9(7).
           05 TR-PRICE           PIC 9(9)V99.
       FD  ACCOUNT-FILE.
       01  ACCOUNT-RECORD.
           05 ACCT-NUMBER        PIC X(10).
           05 ACCT-STATUS        PIC X(1).
              88 ACCT-ACTIVE     VALUE 'A'.
           05 ACCT-CASH          PIC S9(11)V99 COMP-3.
       WORKING-STORAGE SECTION.
       01  WS-EOF                PIC X VALUE 'N'.
       01  WS-AMOUNT             PIC S9(11)V99 COMP-3.
      *
       PROCEDURE DIVISION.
       MAIN-PARA.
           OPEN INPUT TRADE-FILE I-O ACCOUNT-FILE
           PERFORM UNTIL WS-EOF = 'Y'
               READ TRADE-FILE
                   AT END MOVE 'Y' TO WS-EOF
                   NOT AT END PERFORM APPLY-TRADE
               END-READ
           END-PERFORM
           CLOSE TRADE-FILE ACCOUNT-FILE
           STOP RUN.
      *
       APPLY-TRADE.
           MOVE TR-ACCT-NUMBER TO ACCT-NUMBER
           READ ACCOUNT-FILE
               INVALID KEY DISPLAY 'NO ACCOUNT ' TR-ACCT-NUMBER
           END-READ
           COMPUTE WS-AMOUNT = TR-QUANTITY * TR-PRICE
           IF TR-SIDE = 'BUY '
               SUBTRACT WS-AMOUNT FROM ACCT-CASH
           ELSE
               ADD WS-AMOUNT TO ACCT-CASH
           END-IF
           REWRITE ACCOUNT-RECORD.
