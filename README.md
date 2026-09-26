# LEAP Analyst Labs

Lab repository for the LEAP Systems Analyst track. It holds every code-related exercise in the
course: SQL, Mermaid diagrams kept under version control, API contracts, Postman collections,
sample code and pipeline files. Exercises completed in Word live in the course docs folders, not
here.

## Structure

| Week | Folder | Theme |
|---|---|---|
| 1 | [`foundations/`](foundations) | Foundations: Git lab (other Week 1 labs are Word, JIRA and Confluence) |
| 2 | [`data-systems/`](data-systems) | The trading domain and data systems |
| 3 | [`business-analysis/`](business-analysis) | Business analysis foundations |
| 4 | [`ooad-uml/`](ooad-uml) | OOAD, UML and domain modelling |
| 5 | [`ui-ux/`](ui-ux) | UI/UX literacy and stakeholder demos |
| 6 | [`systems-literacy/`](systems-literacy) | APIs, cloud and systems literacy |
| 8 | [`testing-quality/`](testing-quality) | Testing, UAT and quality |
| - | [`shared/`](shared) | The trading database and the platform API contracts |

Weeks 7, 9 and 10 have no code-related labs.

Each week folder has its own `README.md` listing its modules, and is split into:

- `demos/<module>/`: instructor-led demo assets and a `demo-guide.md`
- `labs/<module>/`: the task `README.md` and starter files
- `solutions/<module>/`: reference solutions (attempt the lab first)

## Prerequisites

- Git and a GitHub account
- Docker Desktop, to run the training database (see [`shared/trading-db/README.md`](shared/trading-db/README.md))
- pgAdmin or DBeaver for SQL work
- VS Code with a Mermaid preview extension (Mermaid also renders on GitHub)
- Postman (Week 6)
- GitHub Copilot Chat, where a lab asks for AI assistance

## Getting started

1. Clone this repository.
2. Start the trading database: `cd shared/trading-db && docker compose up -d`.
3. Open the week folder for the current module and follow `labs/<module>/README.md`.
