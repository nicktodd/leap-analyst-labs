# Demo: Module 01 - How the platform is built

**Duration:** 20 minutes
**Prerequisite:** `platform-context.md` from this folder open in GitHub (Mermaid renders in the
preview) and `leap-enterprise-trading-platform/docs/ARCHITECTURE.md` available.

## Part 1: the services (8 min)

1. Open the first diagram. Trace a click on "Buy" from the Angular UI to the Trade REST API.
   Narration: the UI never touches the database or Kafka; it only calls APIs with a token.
2. Point to PostgreSQL. Narration: this is the system of record that BR-14 depends on.
3. Point to Kafka and the Trade Executor. Narration: the API records intent (BR-06); execution
   happens afterwards and separately.

## Part 2: data that does not arrive through an API call (8 min)

1. Open the second diagram. Name each inbound and outbound feed.
2. Narration: the Week 2 `staging_trade_feed` table is the landing area for the broker file.
   Ask the room what happens to a client dispute if that file arrives three hours late.
3. Point out the illustrative feeds and say plainly that the engineering track does not build
   them; the analyst still needs to know they exist in a production estate.

## Part 3: the feed questions (4 min)

1. Show the table of questions. Ask pairs to answer the same questions for the nightly ETL
   extract.

## Key message

A system is its services plus its feeds. An analyst who only knows the screens and the APIs
misses the scheduled files that break quietly overnight.
