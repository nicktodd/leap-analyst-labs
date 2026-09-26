# Trading database

A PostgreSQL database of six months of trading activity (January to June 2026) on the
Enterprise Trading Platform. It is the dataset for every SQL, data quality and data
validation lab in this repository.

## Start it

With Docker Desktop running:

```bash
cd shared/trading-db
docker compose up -d
```

Connection details for pgAdmin, DBeaver or `psql`:

| Setting | Value |
|---|---|
| Host | `localhost` |
| Port | `5432` |
| Database | `trading` |
| User | `analyst` |
| Password | `analyst` |

```bash
psql -h localhost -U analyst -d trading
```

To reset the database to its original state, remove the container and its volume, then start it
again:

```bash
docker compose down -v
docker compose up -d
```

Without Docker, create an empty database called `trading` in any PostgreSQL 14+ server and run
the three `.sql` files in order.

## Tables

| Table | What it holds |
|---|---|
| `instruments` | The 20 instruments the platform lists: equities, ETFs and bonds, keyed by `symbol` |
| `accounts` | Client trading accounts. `id` is the numeric key; `account_id` is the business reference (for example `ACC-100001`) |
| `orders` | Every order placed, with its status (`NEW`, `FILLED`, `REJECTED`, `CANCELLED`), requested price and, once filled, executed price and time |
| `positions` | Current holding per account and instrument, with average cost |
| `order_events` | The audit trail: every state change of every order, in time order |
| `settlements` | Settlement of filled orders (T+1 for equities and ETFs, T+2 for bonds) |
| `market_prices` | Daily closing price per instrument per trading day |
| `cash_movements` | Deposits, withdrawals, and the cash leg of every fill |
| `staging_trade_feed` | Raw trades received from an external broker, not yet validated |

`orders.account_id` and `positions.account_id` hold the numeric `accounts.id`, not the
`ACC-` business reference. Join on `accounts.id`.

The data is generated and is not a copy of any production system. It is not guaranteed to be
clean: part of the analyst's job is to find out where it is not.
