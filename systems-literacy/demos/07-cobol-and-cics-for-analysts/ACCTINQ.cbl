      *================================================================
      * ACCTINQ - online balance inquiry under CICS (illustrative)
      * A terminal or service request supplies an account number;
      * the program reads the master file and returns the balance.
      *================================================================
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ACCTINQ.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-ACCOUNT.
           05 ACCT-NUMBER        PIC X(10).
           05 ACCT-STATUS        PIC X(1).
           05 ACCT-CASH          PIC S9(11)V99 COMP-3.
       01  WS-RESP               PIC S9(8) COMP.
       LINKAGE SECTION.
       01  DFHCOMMAREA.
           05 CA-ACCT-NUMBER     PIC X(10).
           05 CA-CASH            PIC S9(11)V99 COMP-3.
           05 CA-RETURN-CODE     PIC X(2).
       PROCEDURE DIVISION.
           MOVE CA-ACCT-NUMBER TO ACCT-NUMBER
           EXEC CICS READ FILE('ACCTMAST')
                INTO(WS-ACCOUNT) RIDFLD(ACCT-NUMBER)
                RESP(WS-RESP)
           END-EXEC
           IF WS-RESP = DFHRESP(NORMAL)
               MOVE ACCT-CASH TO CA-CASH
               MOVE '00' TO CA-RETURN-CODE
           ELSE
               MOVE '04' TO CA-RETURN-CODE
           END-IF
           EXEC CICS RETURN END-EXEC.
