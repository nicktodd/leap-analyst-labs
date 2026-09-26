# Nightly batch schedule (illustrative)

All times UK. Runs every business day. A scheduler (for example Control-M or IBM Workload
Scheduler) starts each job when its predecessor completes and its start time is reached.

| Job | Start | Depends on | Purpose | Must finish by | If it fails |
|---|---|---|---|---|---|
| BRKLOAD | 21:30 | Broker trade file received | Load the broker file into staging | 22:00 | Operations alerted; later jobs wait |
| NIGHTSYNC | 22:00 | BRKLOAD, trading close | Extract, sort and apply filled trades to the account master | 23:30 | Online balances next morning are stale |
| POSVAL | 23:30 | NIGHTSYNC | Value positions at closing prices | 00:30 | Statements delayed |
| GLEXTR | 00:30 | POSVAL | Finance ledger extract | 01:30 | Finance reconciliation delayed |
| ETLLOAD | 01:30 | NIGHTSYNC | Load the analytical store (BR-16) | 05:00 | Priya's reports show the previous business day |
| REGRPT | 02:00 | NIGHTSYNC | Regulatory transaction report file | 06:00 | Reporting deadline breach risk |

## Reading the schedule

- The critical path is BRKLOAD, NIGHTSYNC, POSVAL, GLEXTR.
- The online window reopens at 06:00. Any job still running then competes with client
  activity for the account master.
- A late upstream file delays everything after it. Ask who is told, and by when.
