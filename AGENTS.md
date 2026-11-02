# Agent Architecture Guidelines

## Architecture & Module Boundaries

- The root Go module is `github.com/HectorVeraO/lrn-go`.
- Domain modules live under `internal/<domain>/` (`orders`, `billing`, `notifications`, `platform`).
- Forbid direct cross-domain imports between domain packages (enforced via `depguard` in `.golangci.yml`).
- Wire domain dependencies at entrypoints in `cmd/api/main.go` or `cmd/comms-service/main.go`.
- Define interfaces on the consumer side only (`internal/orders` defines what it needs from billing/notifications, not what billing provides). Return concrete structs.

## Database & Data Access

- Manage Postgres schema with sequential SQL migration files in `migrations/`.
- Use `sqlc` with engine `postgresql` and `jackc/pgx/v5`.
- Scope database tables with domain-specific prefixes (e.g., `ord_` for orders, `bil_` for billing, `ntf_` for notifications).
- Run `sqlc generate` (or `make sqlc`) after modifying queries or migrations.
- Execute multi-operation business transactions within a single `pgx.Tx`.

## Concurrency & Context

- Pass `context.Context` as the first parameter to all I/O, database, and asynchronous functions.
- Set explicit timeouts using `context.WithTimeout` on outbound calls.
- Use `golang.org/x/sync/errgroup` for parallel goroutines. Never fire unmanaged goroutines that outlive their parent context.

## Local Infrastructure

- Local services run via Docker Compose with `name: lrn-go`.
- Host ports adhere to offset `02` (local band `102xx`):
  - Postgres: `10200:5432`
  - MongoDB: `10201:27017`
- Service keys and container names must prefix with `lrn-go-`.

## Verification Commands

- Fast verification gate:
  - `go vet ./...`
  - `golangci-lint run`
  - `go test -v ./...` (or `go test -v -race ./...` when CGO is enabled)
