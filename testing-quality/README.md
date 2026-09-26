# Week 8: Testing, UAT and quality

Labs and demos for Week 8 of the LEAP Systems Analyst track. The week covers software quality
and the analyst's part in it, the test pyramid, test case design (including accessibility
testing), test data, AI-assisted test design, SRE (Site Reliability Engineering) testing
disciplines, test execution and defect logging, severity and triage, UAT (User Acceptance
Testing) and quality sign-off.

## Prerequisites

- Docker Desktop, to run the training database in `shared/trading-db` (see its README)
- pgAdmin or DBeaver connected to the `trading` database
- GitHub Copilot Chat, for the AI-assisted modules (07, 08 and 12)
- Access to the running Enterprise Trading Platform build for Modules 12 and 15 (each lab
  document includes fallback results if the build is unavailable)

## Structure

- `demos/<module>/`: instructor demo scripts and `demo-guide.md`
- `labs/<module>/`: the lab README and starter files
- `solutions/<module>/`: reference solutions (attempt the lab first)

Most labs this week are written in Word, using documents in the Week 8 `docs` folder of the
course materials.

## Modules

| # | Module | Lab |
|---|---|---|
| 01 | Software Quality and the Analyst's Role in It | No lab |
| 02 | The Test Pyramid in Plain Terms | No lab |
| 03 | Test Case Design and Accessibility Testing | No lab |
| 04 | Hands-on Lab: Writing Test Cases for the Week 3 User Stories | Word lab: docs/04-TestCasePack.docx |
| 05 | Test Data: Sourcing, Masking and Building a Realistic Dataset | No lab (demo: [demos/05-test-data](demos/05-test-data/demo-guide.md)) |
| 06 | Hands-on Lab: Preparing and Validating Test Data with SQL | [labs/06-test-data-with-sql/README.md](labs/06-test-data-with-sql/README.md) and Word write-up: docs/06-TestDataSheet.docx |
| 07 | AI-Assisted Test Case Generation | No lab |
| 08 | Hands-on Lab: Pruning, Extending and Judging AI-Generated Coverage | Word lab: docs/08-AICoverageReview.docx |
| 09 | Performance, Chaos and Penetration Testing: an SRE Overview | No lab |
| 10 | Functional Testing Execution and Defect Logging | No lab |
| 11 | Severity, Priority and Triage | No lab |
| 12 | Hands-on Lab: Executing the Test Pack and AI-Assisted Defect Summarisation | Word lab: docs/12-TestExecutionAndDefectLog.docx |
| 13 | User Acceptance Testing: Purpose, Participants and Planning | No lab |
| 14 | Writing a UAT Plan: Entry and Exit Criteria | No lab |
| 15 | Hands-on Lab: Running a UAT Session | Word lab: docs/15-UATSessionPack.docx |
| 16 | Quality Sign-Off | No lab |

SQL: Structured Query Language. AI: artificial intelligence.
