# Week 5: UI/UX literacy and stakeholder demos

Labs and demos for Week 5 of the Leap Systems Analyst track. The week covers user-centred
design, accessibility as a requirement (WCAG, the Web Content Accessibility Guidelines),
wireframing in Figma, screen specification, UI (user interface) states, usability testing,
access control from the user's side, reading an OpenAPI contract, and stakeholder demos.

## Prerequisites

- Figma (a free account is enough) for the wireframing labs in Modules 03, 04 and 08
- GitHub access to the course repository and your team repository, with a Mermaid preview
  (GitHub renders Mermaid in Markdown files)
- GitHub Copilot Chat, for the AI-assisted labs in Modules 04 and 07
- The API contracts in `shared/contracts/` (`trade-api.yaml`, `portfolio-api.yaml`,
  `auth-api.yaml`); a Swagger viewer such as the Swagger Editor or the VS Code OpenAPI preview

## Structure

- `demos/<module>/`: instructor demo material and `demo-guide.md`
- `labs/<module>/`: the lab README and starter files
- `solutions/<module>/`: reference solutions (attempt the lab first)

Word-based labs use documents in the Week 5 `docs` folder of the course materials.

## Modules

| # | Module | Lab |
|---|---|---|
| 01 | User-Centred Design | No lab |
| 02 | Accessibility Fundamentals: WCAG as a Requirement | No lab |
| 03 | Wireframing and Low-Fidelity Prototyping | Word lab: docs/03-WireframeBrief.docx (demo: [demos/03-wireframing-and-prototyping](demos/03-wireframing-and-prototyping/demo-guide.md)) |
| 04 | Hands-on Lab: AI-Assisted Wireframe Drafting and Critical Review | Word lab: docs/04-AIWireframeReview.docx |
| 05 | From Wireframe to Specification | No lab |
| 06 | Specifying UI States | No lab (demo: [demos/06-specifying-ui-states](demos/06-specifying-ui-states/demo-guide.md)) |
| 07 | Hands-on Lab: Validating an AI-Generated Screen Spec Against WCAG | [labs/07-validating-a-screen-spec/README.md](labs/07-validating-a-screen-spec/README.md) and Word lab: docs/07-WCAGValidationFindings.docx |
| 08 | Usability Testing Basics | Word lab: docs/08-UsabilityTestNotes.docx |
| 09 | Access Control from the User's Side | No lab |
| 10 | Hands-on Lab: Building the Role and Permission Matrix | Word lab: docs/10-RolePermissionMatrix.docx |
| 11 | Reading an API Contract: OpenAPI and Swagger for Analysts | No lab (demo: [demos/11-reading-an-api-contract](demos/11-reading-an-api-contract/demo-guide.md)) |
| 12 | Structuring a Stakeholder Demo and Tailoring the Message | No lab |
| 13 | Handling Challenge, Pushback and Scope Pressure | No lab |
| 14 | Hands-on Lab: Delivering the Demo and Refining the Spec | Word lab: docs/14-DemoPlan.docx, docs/14-DemoFeedback.docx and docs/14-ScreenSpecificationPackTemplate.docx |

The project deliverable for the week is the annotated screen specification pack, built from
`docs/14-ScreenSpecificationPackTemplate.docx`, with UI state diagrams committed as Mermaid
files in the team repository.
