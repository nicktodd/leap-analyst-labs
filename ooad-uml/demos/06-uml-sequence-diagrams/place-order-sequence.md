# Sequence diagram: a client views their positions

A worked example for Module 06. It uses the synchronous request and response style: the
client waits for each answer. The trade capture flow in Lab 07 adds the asynchronous part.

```mermaid
sequenceDiagram
    autonumber
    actor Joanna as Joanna (client)
    participant UI as Angular UI
    participant Auth as Auth service
    participant API as Trade REST API
    participant DB as Postgres

    Joanna->>UI: Open holdings page
    UI->>API: GET /api/v1/accounts/{id}/positions (Bearer JWT)
    API->>Auth: Verify token signature
    Auth-->>API: Valid, subject = account 3
    alt account in path matches token subject
        API->>DB: SELECT positions WHERE account_id = 3
        DB-->>API: Rows
        API-->>UI: 200 positions
        UI-->>Joanna: Holdings table
    else another client's account
        API-->>UI: 403 Forbidden
        UI-->>Joanna: Access denied message
    end
```

Read it top to bottom: time runs down the page. Solid arrows are requests, dashed arrows are
replies. The `alt` block shows the BR-02 rule (a client sees only their own data).
