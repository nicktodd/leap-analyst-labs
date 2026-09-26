# Lab 06 reference: what a good result looks like

## Example glossary on main after merging

| Term | Definition | Source |
|---|---|---|
| Audit record | Permanent record of every accepted order, pricing decision and change to cash or holdings, attributable to a client and time | BR-14 |
| Blotter | The client's chronological list of orders and fills | BR-11 |
| Fill | Execution of an order at a price based on a current quote | BR-08 |
| Indicative price | A price shown before the order is submitted; not guaranteed | BR-13 |
| Order | A client's instruction to buy or sell an instrument | BR-04 |
| Position | A client's current holding of an instrument | BR-10 |
| Quote | The current market price used to price an order | BR-08, BR-12 |
| Trading rules | The firm's checks applied before an order is accepted (for example sufficient cash or holding, instrument tradable) | BR-05 |

## Example history

```
$ git log --oneline -- docs/glossary.md
e4a1c07 Merge pull request #3 from team/feature/DTP-5-glossary
9b2f6d1 Clarify 'fill' is based on a current quote
51c8e3a Add 'fill' with BR-08 source
0d7a9b2 Add 'blotter' with BR-11 source
c3f0e44 Add 'quote' with BR-08 source
3c9e5aa Add glossary starter table
```

## Marking notes

- One branch per person, named after a JIRA key; three commits, not one.
- Review comments are specific ("BR-11 says orders and fills, not only orders"), not "LGTM".
- A resolved conflict keeps both rows in alphabetical order; no `<<<<<<<` markers remain.
- Definitions come from the BRS wording; flag any that invent detail the BRS does not give.
