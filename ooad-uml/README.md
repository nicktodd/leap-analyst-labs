# Week 4: OOAD, UML and domain modelling

Labs and demos for Week 4 of the LEAP Systems Analyst track. The week covers OOAD
(Object-Oriented Analysis and Design), UML (Unified Modelling Language) class, use case,
sequence, state and activity models in Mermaid, use case specifications, non-functional
requirements, advanced SQL (Structured Query Language) and validating the domain model
against the training data.

## Prerequisites

- Docker Desktop running the training database in `shared/trading-db` (see its README)
- pgAdmin or DBeaver connected to the `trading` database
- GitHub access with a Mermaid preview (GitHub renders Mermaid in Markdown files), or Visual
  Studio Code with a Mermaid preview extension
- GitHub Copilot Chat, for Lab 07

## Structure

- `demos/<module>/`: instructor demo material and `demo-guide.md`
- `labs/<module>/`: the lab README and starter files
- `solutions/<module>/`: reference solutions (attempt the lab first)

Word-based labs use documents in the Week 4 `docs` folder of the course materials.

## Modules

| # | Module | Lab |
|---|---|---|
| 01 | Object-Oriented Analysis for Analysts | No lab |
| 02 | UML Class Diagrams in Mermaid | No lab (demo: [demos/02-uml-class-diagrams-in-mermaid](demos/02-uml-class-diagrams-in-mermaid/demo-guide.md)) |
| 03 | Hands-on Lab: Producing and Peer-Reviewing a First Class Model | [labs/03-first-class-model/README.md](labs/03-first-class-model/README.md) and Word review: docs/03-ClassModelPeerReview.docx |
| 04 | UML Use Case Models | No lab |
| 05 | Writing Use Case Specifications for Engineering Teams | No lab (template: docs/05-UseCaseSpecificationTemplate.docx) |
| 06 | UML Sequence Diagrams | No lab (demo: [demos/06-uml-sequence-diagrams](demos/06-uml-sequence-diagrams/demo-guide.md)) |
| 07 | Hands-on Lab: AI-Assisted Sequence Diagram Generation and Validation | [labs/07-ai-sequence-diagram/README.md](labs/07-ai-sequence-diagram/README.md) and Word lab: docs/07-SequenceDiagramValidation.docx |
| 08 | Non-Functional Requirements for Engineering Teams | No lab |
| 09 | Hands-on Lab: Extending the Domain Model and Cross-Checking Acceptance Criteria | [labs/09-extending-the-domain-model/README.md](labs/09-extending-the-domain-model/README.md) and Word lab: docs/09-AcceptanceCriteriaCrossCheck.docx |
| 10 | State and Activity Modelling: The Lifecycle of a Trade | No lab (demo: [demos/10-state-and-activity-modelling](demos/10-state-and-activity-modelling/demo-guide.md)) |
| 11 | SQL for Analysis: Advanced Querying | No lab (demo: [demos/11-sql-advanced-querying](demos/11-sql-advanced-querying/demo-guide.md)) |
| 12 | Production Data Querying: Safety, Access Controls and Audit | No lab (demo: [demos/12-production-data-querying](demos/12-production-data-querying/demo-guide.md)) |
| 13 | Hands-on Lab: Validating the Domain Model Against Real Data | [labs/13-validating-the-model-against-data/README.md](labs/13-validating-the-model-against-data/README.md) and Word write-up: docs/13-ModelValidationFindings.docx |

## Consolidated analysis and design pack

At the end of the week each team assembles one pack in its team repository:
the extended class model (Lab 09), the use case diagram and two use case specifications, the
corrected trade capture sequence diagram (Lab 07), the order state diagram, the NFR
(non-functional requirement) set and the model validation findings (Lab 13).
