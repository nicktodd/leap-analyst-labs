# Week 6: APIs, cloud and systems literacy

Labs and demos for Week 6 of the Leap Systems Analyst track. The week covers how the
Enterprise Trading Platform is built and how data enters and leaves it, REST (Representational
State Transfer) APIs and OpenAPI contracts, calling the APIs in Postman, reading code, SOAP
(Simple Object Access Protocol), COBOL, CICS (Customer Information Control System) and batch
at survey depth, cloud and CI/CD (Continuous Integration and Continuous Delivery), NFRs
(non-functional requirements), Kafka, dependency tracking, impact analysis and webhooks.

## Prerequisites

- Postman (desktop app), for Module 04
- Node.js 18 or later, for the Prism mock server in Module 04 if the platform is not running
- VS Code with GitHub Copilot Chat, for Module 05
- GitHub access to this repository, with Mermaid preview
- The contracts in `shared/contracts/` (`trade-api.yaml`, `auth-api.yaml`,
  `portfolio-api.yaml`, `kafka-topics.md`)

## Structure

- `demos/<module>/`: instructor demo material and `demo-guide.md`
- `labs/<module>/`: the lab README and starter files
- `solutions/<module>/`: reference solutions (attempt the lab first)

Word-based labs use documents in the Week 6 `docs` folder of the course materials.

## Modules

| # | Module | Lab |
|---|---|---|
| 01 | How the Trading Platform Is Built, Including Data Feeds | No lab (demo: [demos/01-how-the-platform-is-built](demos/01-how-the-platform-is-built/demo-guide.md)) |
| 02 | REST API Fundamentals for Analysts | No lab |
| 03 | Reading an OpenAPI Spec | No lab (demo: [demos/03-reading-an-openapi-spec](demos/03-reading-an-openapi-spec/demo-guide.md)) |
| 04 | Calling the Platform APIs in Postman | [labs/04-calling-the-platform-apis-in-postman/README.md](labs/04-calling-the-platform-apis-in-postman/README.md) |
| 05 | Reading Code Without Writing It | [labs/05-reading-code-without-writing-it/README.md](labs/05-reading-code-without-writing-it/README.md) |
| 06 | SOAP vs REST Services | No lab (demo: [demos/06-soap-vs-rest](demos/06-soap-vs-rest/demo-guide.md)) |
| 07 | COBOL Basics and CICS for Analysts | No lab (demo: [demos/07-cobol-and-cics-for-analysts](demos/07-cobol-and-cics-for-analysts/demo-guide.md)) |
| 08 | Batch Processing and Batch Job Architecture | No lab (demo: [demos/08-batch-processing](demos/08-batch-processing/demo-guide.md)) |
| 09 | Cloud Awareness: What the Cloud Changes | No lab |
| 10 | Environments, Pipelines and Releases | No lab |
| 11 | Following a Change Through the CI/CD Pipeline | [labs/11-following-a-change-through-cicd/README.md](labs/11-following-a-change-through-cicd/README.md) |
| 12 | Non-Functional Requirements in a Cloud Context | Word lab: docs/12-NFRValidation.docx |
| 13 | Kafka and Event-Based Processing | No lab (demo: [demos/13-kafka-and-event-processing](demos/13-kafka-and-event-processing/demo-guide.md)) |
| 14 | Risk, Assumption and Dependency Tracking in JIRA and Confluence | No lab (applied to the team project board) |
| 15 | Impact Analysis: Assessing the Blast Radius of a Change | Word lab: docs/15-DependencyMapPeerReview.docx |
| 16 | Webhook APIs and DEC APIs Overview | No lab (demo: [demos/16-webhook-and-dec-apis](demos/16-webhook-and-dec-apis/demo-guide.md)) |

DEC: Digital Experience Capability. NFR: non-functional requirement.
