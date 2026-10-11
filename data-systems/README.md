# Week 2: The trading domain and data systems

Labs and demos for Week 2 of the Leap Systems Analyst track. The week covers the investment
lifecycle, the data it creates, SQL (Structured Query Language) for analysts, entity
relationship (ER) modelling in Mermaid, data quality and the data dictionary.

## Prerequisites

- Docker Desktop, to run the training database in `shared/trading-db` (see its README)
- pgAdmin or DBeaver connected to the `trading` database
- GitHub access to the course repository and your team repository, with a Mermaid preview
  (GitHub renders Mermaid in Markdown files)
- GitHub Copilot Chat, for the AI-assisted schema interpretation in Module 11

## Structure

- `demos/<module>/`: instructor demo scripts and `demo-guide.md`
- `labs/<module>/`: the lab README and starter files
- `solutions/<module>/`: reference solutions (attempt the lab first)

Word-based labs use documents in the Week 2 `docs` folder of the course materials.

## Modules

| # | Module | Lab |
|---|---|---|
| 01 | Week 2 Kick-off and the Investment Lifecycle | No lab |
| 02 | Risk, Regulation and the Control Environment | No lab |
| 03 | Data Fluency for Analysts | Word lab: docs/03-TradeLifecycleDataMap.docx |
| 04 | Data Systems Concepts: OLTP vs OLAP | No lab |
| 05 | Relational Database Fundamentals | No lab |
| 06 | SQL Fundamentals | [labs/06-sql-fundamentals/README.md](labs/06-sql-fundamentals/README.md) |
| 07 | SQL for Analysts Part 1 | [labs/07-sql-for-analysts-part1/README.md](labs/07-sql-for-analysts-part1/README.md) |
| 08 | ER Diagrams and Data Modelling in Mermaid | No lab (demo: [demos/08-er-diagrams-in-mermaid](demos/08-er-diagrams-in-mermaid/demo-guide.md)) |
| 09 | Normalisation at a Working Level | No lab |
| 10 | Translating Business Requirements into a Data Model | [labs/10-requirements-to-data-model/README.md](labs/10-requirements-to-data-model/README.md) |
| 11 | Peer Review and AI-Assisted Schema Interpretation | Word lab: docs/11-DataModelPeerReview.docx |
| 12 | Data Quality Dimensions | No lab |
| 13 | Profiling a Dataset and Data Validation Rules | [labs/13-profiling-and-validation/README.md](labs/13-profiling-and-validation/README.md) and Word write-up: docs/13-DataQualityFindings.docx |
| 14 | Data Integration and Mainframe Recordkeeping | No lab |
| 15 | Producing the Data Dictionary and SQL Part 2 | [labs/15-data-dictionary-and-sql-part2/README.md](labs/15-data-dictionary-and-sql-part2/README.md) and Word lab: docs/15-DataDictionary.docx |

OLTP: Online Transaction Processing. OLAP: Online Analytical Processing.
