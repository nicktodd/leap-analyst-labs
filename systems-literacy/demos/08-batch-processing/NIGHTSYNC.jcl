//NIGHTSYNC JOB (ACCT),'NIGHTLY SYNC',CLASS=A,MSGCLASS=X,
//             NOTIFY=&SYSUID
//* ------------------------------------------------------------
//* NIGHTSYNC - illustrative nightly synchronisation job.
//* Loads the platform's filled trades into the account master.
//* ------------------------------------------------------------
//EXTRACT  EXEC PGM=TRDEXTR
//TRADEOUT DD DSN=PROD.TRADES.DAILY,DISP=(NEW,CATLG),
//            SPACE=(CYL,(5,5))
//*
//SORT     EXEC PGM=SORT,COND=(0,NE)
//SORTIN   DD DSN=PROD.TRADES.DAILY,DISP=SHR
//SORTOUT  DD DSN=PROD.TRADES.SORTED,DISP=(NEW,CATLG)
//SYSIN    DD *
  SORT FIELDS=(1,10,CH,A)
/*
//UPDATE   EXEC PGM=ACCTUPD,COND=(0,NE)
//TRADEIN  DD DSN=PROD.TRADES.SORTED,DISP=SHR
//ACCTMAST DD DSN=PROD.ACCOUNT.MASTER,DISP=OLD
//*
//REPORT   EXEC PGM=RECONRPT,COND=(0,NE)
//ACCTMAST DD DSN=PROD.ACCOUNT.MASTER,DISP=SHR
//RPTOUT   DD SYSOUT=*
