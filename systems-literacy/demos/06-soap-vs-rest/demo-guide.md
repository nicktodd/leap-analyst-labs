# Demo: Module 06 - SOAP vs REST

**Duration:** 20 minutes
**Prerequisite:** the files in this folder open side by side with
`shared/contracts/trade-api.yaml` (operation `getBalance`).

## Part 1: the same question in two styles (8 min)

1. Open `get-balance-rest-request.http`. Narration: REST (Representational State Transfer)
   puts the resource in the URL and uses the HTTP verb GET.
2. Open `get-balance-soap-request.xml`. Narration: SOAP (Simple Object Access Protocol)
   always POSTs an XML envelope to one address; the operation is named in `SOAPAction` and
   the body.

## Part 2: read the WSDL top to bottom (8 min)

1. Open `legacy-account-service.wsdl`. Walk the five sections: `types`, `message`,
   `portType`, `binding`, `service`.
2. Map each to the OpenAPI equivalent: `types` to `components.schemas`, `portType` operation
   to a path and verb, `service` address to `servers`.
3. Ask: what is missing that the OpenAPI file has. Expected answers: error codes, security,
   examples. SOAP carries errors as a SOAP Fault, which this WSDL does not describe.

## Part 3: recognising the style (4 min)

1. Show the recognition checklist from the deck: XML envelope, single endpoint, SOAPAction
   header, `.wsdl` file means SOAP; JSON, resource URLs, verbs, OpenAPI file means REST.

## Key message

The business question is the same; the packaging differs. An analyst reads a WSDL to find the
operations, the fields and the address, exactly as with an OpenAPI file.
