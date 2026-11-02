# Go, modular architecture, and agentic engineering study guide

## 1. Resource guide: what to read vs. what to reference

Do not read all of these books cover to cover. Only two of them are meant to be read straight through, and one is under 170 pages. The rest are lookup manuals or build-along references.

To start with the smallest budget and reading pile, buy only [Learning Go, 2nd Edition](https://www.oreilly.com/library/view/learning-go-2nd/9781098139285/) and [A Philosophy of Software Design](https://web.stanford.edu/~ouster/cgi-bin/aposd.php), and use the free resources in the table for the rest.

| Topic | Resource | Format and cost | How to use it | What to read and what to skip |
| :--- | :--- | :--- | :--- | :--- |
| Go basics | [A Tour of Go](https://go.dev/tour/), [Go by Example](https://gobyexample.com/), and [Effective Go](https://go.dev/doc/effective_go) | Interactive web (Free) | Do once in Week 1 | Click through the interactive exercises over a weekend to get used to the syntax. |
| Go internals and idioms | [Learning Go, 2nd Edition](https://www.oreilly.com/library/view/learning-go-2nd/9781098139285/) by Jon Bodner | Book ($40 to $50) | Read sequentially in Weeks 1 to 3 | Read Chapters 1 to 14. Skim basic control-flow (`if`, `for`, `switch`) that you already know. Skip the final chapters on reflection, `unsafe`, and Cgo until a real project needs them. |
| Production web and APIs | [Let's Go Further](https://lets-go-further.alexedwards.net/) by Alex Edwards | PDF/EPUB ($45) | Build-along reference in Weeks 4 and 5 | Skip the first book ([Let's Go](https://lets-go.alexedwards.net/)) unless you plan to render HTML templates on the server. Use *Let's Go Further* as a desk reference when wiring routing, middleware, Postgres, and background tasks. |
| Go edge cases and performance | [100 Go Mistakes and How to Avoid Them](https://www.manning.com/books/100-go-mistakes-and-how-to-avoid-them) by Teiva Harsanyi ([GitHub summary](https://github.com/teivah/100-go-mistakes)) | Book ($35 to $45) + free repo | Weekly lookup manual | Do not read cover to cover. Use the free GitHub summary to read 3 to 4 mistakes per week that match the topic you are coding (slices in Week 1, interfaces in Week 2, concurrency in Week 3). |
| Module design | [A Philosophy of Software Design](https://web.stanford.edu/~ouster/cgi-bin/aposd.php) by John Ousterhout | Book ($20 to $28) | Read cover to cover in Week 7 | About 170 pages. Read it straight through over one weekend, paying special attention to Chapters 4 to 10 on deep vs. shallow modules and pass-through abstractions. |
| Go architecture in practice | [Go With The Domain](https://threedots.tech/go-with-the-domain/) and [Modern Business Software in Go](https://threedots.tech/series/modern-business-software-in-go/) by [Three Dots Labs](https://threedots.tech/) | Free e-book and blog (paid labs at [Three Dots Academy](https://threedots.tech/learn/)) | Skim in one afternoon in Week 7 | 70-page free booklet. Use it to see how Go projects structure domain packages without Java-style boilerplate. |
| When to decouple | [Learning Domain-Driven Design](https://www.oreilly.com/library/view/learning-domain-driven-design/9781098100124/) and [Balancing Coupling in Software Design](https://coupling.dev/) by Vlad Khononov | Books ($40 each) | Selected chapters and reference | Read only Parts I and II (~80 pages) of *Learning DDD* in Week 8 to learn how to classify subdomains by complexity. Keep *Balancing Coupling* as a reference for when you need to justify keeping or splitting a service at work. |
| Database and queue tooling | [sqlc Docs](https://docs.sqlc.dev/en/latest/) and [River Queue Docs](https://riverqueue.com/docs) | Documentation (Free) | Reference in Weeks 5 and 6 | Read the getting-started and transactional enqueueing guides while building the database layer in Phase 2. |

## 2. Pace, repository setup, and weekly rhythm

### Time commitment
Plan for 5 to 7 hours per week over 12 weeks, split into two rules:
1. Spend no more than 2 hours a week reading. Read only the chapters or lookup items assigned for that week.
2. Spend 3 to 5 hours a week writing code on a single evolving project rather than starting disconnected toy tutorials every week.

### One Git repository for all 12 weeks
Use a single Git repository (one `go.mod` at the root) for the entire study plan rather than creating a new repo for every exercise or microservice. Go is designed to build multiple binaries from one module via the `cmd/` directory:
* `STUDY_GUIDE.md` and `notes/`: This study guide plus short markdown notes or architectural decisions you write along the way.
* `katas/`: Small, standalone packages for Weeks 1 to 3 (the catalog CLI, interface tests, and the concurrent webhook sender) plus any "fix the bug" drills we do in chat.
* `cmd/api/` and `cmd/comms-service/`: Entrypoints for the main modular monolith (Weeks 4 to 8) and the extracted WhatsApp/payment service (Week 9), sharing the same repo.
* `internal/`, `migrations/`, and `docker-compose.yml`: Your domain modules, SQL migrations, and local Postgres/MongoDB containers.
* `AGENTS.md`, `.golangci.yml`, and `Makefile`: Your linter rules and agent instructions for Weeks 10 to 12.

### Weekly loop
* Session 1 (1.5 to 2 hours, early in the week, phone-friendly): Read the assigned chapters and lookup items. Ask Gemini to clarify anything that feels strange compared to your main language.
* Session 2 (2 hours, mid-week, desktop/laptop): Build the first half of the weekly milestone in your editor.
* Session 3 (1.5 to 2 hours, weekend, desktop/laptop): Finish the milestone, paste your package layout or tricky functions into chat for an architectural review, and check off the week's boxes.

### Studying on Android vs. desktop
You can comfortably do about 40% of this plan (all of Session 1 plus code reviews and quizzes) on an Android phone or tablet, which frees up your computer time purely for writing code:
* What works well on Android: Reading EPUBs or PDFs, browsing the [100 Go Mistakes GitHub summary](https://github.com/teivah/100-go-mistakes) in [GitHub Mobile](https://github.com/mobile), listening to and interrupting [NotebookLM](https://notebooklm.google.com/) audio discussions, doing "spot the bug" code reviews in the Gemini app, and testing small 15-line snippets in [The Go Playground](https://go.dev/play/).
* What to save for your computer: Typing multi-file Go packages, running Docker containers for Postgres and MongoDB, and running `sqlc` and `golangci-lint`. Looking up symbols (`{`, `}`, `&`, `*`, `:=`) on a phone keyboard is slow and frustrating, though if you ever want a local Go compiler on Android with a Bluetooth keyboard, [Termux](https://wiki.termux.com/wiki/Development_Environments) supports `pkg install golang` natively.

### When to turn off AI autocomplete
During Weeks 1 to 6, turn off AI code generation and ghost-text autocomplete in your IDE. Typing Go's error checks, slice operations, pointer receivers, and `context.Context` signatures by hand for six weeks builds the muscle memory you need to spot subtle bugs when you switch to supervising coding agents in Phases 3 and 4.

## 3. How to use your AI companions at each stage

### Gemini (here in chat) as your tutor and reviewer
* Before coding a milestone: Ask for a 10-minute bridge explaining how a Go concept compares to the language you already know, or ask for a small broken Go snippet (such as a slice capacity bug or a goroutine leak) to debug as a warm-up on your phone.
* After coding a milestone: Paste your directory tree, interfaces, or database transaction code and ask for a review based on the week's reading (for example, checking whether an abstraction is deep or shallow under Ousterhout's rules, or whether a package matches idioms from *100 Go Mistakes*).

### NotebookLM as your searchable book shelf
Set up two notebooks in [NotebookLM](https://notebooklm.google.com/):
* Notebook 1 (Go mechanics): Upload your PDF of *Let's Go Further*, the markdown files from the *100 Go Mistakes* repository, and official Go blog articles you save along the way. Use this to look up idiomatic patterns without searching random blog posts.
* Notebook 2 (Architecture): Upload the *Go With The Domain* PDF, notes or chapters from Ousterhout and Khononov, and any internal architecture docs from your job. Use NotebookLM's interactive audio mode on walks or commutes to quiz yourself on when a pattern fits a 5,000-user monolith vs. a microservice.

### Coding agents (Claude Code, Cursor, Gemini CLI) in Phases 3 and 4
Starting in Week 7, bring coding agents back into your workflow, shifting from writing every line by hand to designing module contracts, writing `sqlc` queries, and enforcing linter guardrails (`make check`) that keep the agent inside your architecture.

## 4. 12-week study and build roadmap

Across all 12 weeks, you will build one continuous project: a small-business order, invoicing, and notification backend using Postgres, a scoped MongoDB collection, and a decoupled WhatsApp and payment integration.

### Phase 1: Go syntax, memory model, and concurrency (Weeks 1 to 3)

Pace: ~2 hours reading (Android or desktop), ~4 hours coding by hand on desktop (AI autocomplete off).

- [ ] Week 1: Syntax, value semantics, and memory layout
  - [ ] Interactive: Finish [A Tour of Go](https://go.dev/tour/) and read [Go by Example](https://gobyexample.com/) through structs and methods.
  - [ ] Read: Chapters 1 to 6 of [Learning Go, 2nd Ed.](https://www.oreilly.com/library/view/learning-go-2nd/9781098139285/) (focus on pointers, stack vs. heap escape analysis, and slice headers).
  - [ ] Lookup: Items #20 to #29 (slices) in the [100 Go Mistakes GitHub summary](https://github.com/teivah/100-go-mistakes).
  - [ ] Practice: Write a CLI tool that parses a JSON or CSV product catalog, updates prices, and benchmarks value receivers against pointer receivers with `go test -bench=. -benchmem`.
- [ ] Week 2: Implicit interfaces, errors, and packages
  - [ ] Read: Chapters 7 to 11 of *Learning Go* (types, implicit interfaces, struct embedding, error wrapping with `errors.Is` and `errors.As`, and package layout).
  - [ ] Lookup: Items #1 to #16 (code organization and interface pollution) and #48 to #54 (error management) in [100 Go Mistakes](https://github.com/teivah/100-go-mistakes).
  - [ ] Practice: Update your CLI tool to read from either a local file or a test HTTP server through a 1-method consumer interface, and review the package boundaries with Gemini.
- [ ] Week 3: Concurrency, `context.Context`, and `net/http`
  - [ ] Read: Chapters 12 to 14 of *Learning Go* (goroutines, channels, `select`, `sync.WaitGroup`, `errgroup`, and `context.Context` cancellation).
  - [ ] Lookup: Items #55 to #74 (concurrency vs. parallelism, goroutine leaks, and `sync` traps) in [100 Go Mistakes](https://github.com/teivah/100-go-mistakes).
  - [ ] Practice: Write a concurrent webhook sender using `golang.org/x/sync/errgroup` and `net/http` with per-request timeouts via `context.WithTimeout`.

### Phase 2: CRUD, Postgres (`sqlc` + `pgx`), queues, and MongoDB (Weeks 4 to 6)

Pace: ~1.5 hours reference reading (Android or desktop), ~4.5 hours coding by hand on desktop (AI autocomplete off).

- [ ] Week 4: HTTP APIs and middleware
  - [ ] Reference: Use [Let's Go Further](https://lets-go-further.alexedwards.net/) to look up project layout, Go 1.22+ `http.ServeMux` routing, `log/slog`, panic recovery, and graceful shutdown.
  - [ ] Lookup: Items #75 to #81 (standard library and HTTP client/server timeouts) in [100 Go Mistakes](https://github.com/teivah/100-go-mistakes).
  - [ ] Practice (Milestone 1): Set up the main project repository (`cmd/api/main.go`, `internal/platform/`) with health checks, JSON logging, and config parsing.
- [ ] Week 5: Postgres with `pgx` and `sqlc`, plus MongoDB
  - [ ] Reference: Read the [sqlc getting-started guide](https://docs.sqlc.dev/en/latest/) and the data-access chapters of *Let's Go Further*.
  - [ ] Lookup: Items #78 (common SQL mistakes) and #79 (not closing transient resources) in [100 Go Mistakes](https://github.com/teivah/100-go-mistakes).
  - [ ] Practice (Milestone 2): Add Postgres migrations and `sqlc` on top of `jackc/pgx/v5` for the `orders` package, add a MongoDB collection (`mongo-driver` v2) for unstructured catalog specs or webhook logs, and write integration tests against Docker containers.
- [ ] Week 6: Transactional queues in Postgres (`River`)
  - [ ] Reference: Read [River's Transactional Enqueueing Docs](https://riverqueue.com/docs/transactional-enqueueing).
  - [ ] Practice (Milestone 3): Wire a `CreateOrder` database transaction that inserts an order row and enqueues `SendWhatsAppConfirmation` and `GenerateInvoice` jobs in the same `pgx.Tx`. Write a test confirming that a failed job insert rolls back the order row.

### Phase 3: Modular monolith boundaries and service extraction (Weeks 7 to 9)

Pace: ~2.5 hours architecture reading (Android or desktop), ~3.5 hours refactoring on desktop.

- [ ] Week 7: Deep modules vs. shallow abstractions
  - [ ] Read: [A Philosophy of Software Design](https://web.stanford.edu/~ouster/cgi-bin/aposd.php) (~170 pages; focus on Chapters 4 to 10 on deep modules, information hiding, and pass-through methods).
  - [ ] Skim: [Go With The Domain](https://threedots.tech/go-with-the-domain/) (70-page free booklet).
  - [ ] Practice: Review your Phase 2 project with Gemini against Ousterhout's rules and delete any pass-through layer or interface that has only one implementation inside the same package.
- [ ] Week 8: Enforcing module boundaries in the monolith
  - [ ] Read: Parts I and II (~80 pages) of [Learning Domain-Driven Design](https://www.oreilly.com/library/view/learning-domain-driven-design/9781098100124/) on core, supporting, and generic subdomains and bounded contexts.
  - [ ] Practice (Milestone 4): Split the codebase into `internal/orders` (core), `internal/billing` (supporting), and `internal/notifications` (generic) with separate table prefixes. Connect them in `cmd/api/main.go` via consumer-defined interfaces and add a `golangci-lint` (`depguard`) rule that blocks cross-domain imports.
- [ ] Week 9: Extracting the edge service (payments and WhatsApp gateway)
  - [ ] Reference: Selected chapters of [Balancing Coupling in Software Design](https://coupling.dev/) on evaluating coupling strength, distance, and volatility.
  - [ ] Practice (Milestone 5): Extract `internal/notifications` (WhatsApp, email, and webhook receiver) into a second binary in the same repository (`cmd/comms-service/main.go`). Swap the in-memory adapter in `cmd/api/main.go` for an HTTP client without editing `internal/orders`.

### Phase 4: Agentic Go workflow and guardrails (Weeks 10 to 12)

Pace: ~1 hour setup, ~4 hours agent-assisted building and review.

- [ ] Week 10: Writing the `AGENTS.md` / `CLAUDE.md` file
  - [ ] Practice: Write a short repository instruction file (<150 lines) defining your module boundaries, `sqlc` workflow, table prefix rules, and consumer-side interface rules, pointing to `internal/orders` as the reference module to copy.
- [ ] Week 11: Fast verification loops for agents
  - [ ] Practice: Set up a `<3 second` `make check` target (`go vet`, `sqlc vet`, `golangci-lint` with `depguard`, and `go test -race ./...`). Give your coding agent a one-paragraph spec for an `internal/refunds` module and have it iterate against `make check` until all compiler and boundary checks pass.
- [ ] Week 12: Spec-driven refactoring and code review
  - [ ] Practice: Split a feature with the agent where you write `schema.sql`, `query.sql`, and the consumer interface, and the agent implements the handler, service logic, and table-driven tests. Audit the generated code with Gemini for goroutine leaks, missing `ctx` timeouts, and leaky abstractions.