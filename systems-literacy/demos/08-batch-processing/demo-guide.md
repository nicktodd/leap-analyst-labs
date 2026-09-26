# Demo: Module 08 - Batch processing

**Duration:** 15 minutes
**Prerequisite:** `NIGHTSYNC.jcl` and `batch-schedule.md` open. Survey depth only.

## Part 1: read a job (7 min)

1. Open `NIGHTSYNC.jcl`. Narration: JCL (Job Control Language) tells the mainframe which
   programs to run, in which order, against which datasets.
2. Point to the four `EXEC` steps: EXTRACT, SORT, UPDATE, REPORT.
3. Point to `DD` statements. Narration: each names a dataset; the UPDATE step reads the sorted
   trades and opens the account master with `DISP=OLD` (exclusive use).
4. Explain `COND=(0,NE)`: skip this step if any earlier step ended with a non-zero return code.

## Part 2: read a schedule (8 min)

1. Open `batch-schedule.md`. Trace the dependency from BRKLOAD to ETLLOAD.
2. Ask: the broker file arrives 90 minutes late. Which jobs miss their deadline, and which
   stakeholder notices first. Expected answer: NIGHTSYNC and everything after it; Priya's
   reports and the regulatory file are at risk.

## Key message

A batch job is a sequence of steps over files; a schedule is a chain of dependencies against
a clock. Analysts care about the chain, the cut-offs and who is told when it breaks.
