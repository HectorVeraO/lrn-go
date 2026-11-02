.PHONY: all up down sqlc check test run-api run-comms

all: check

up:
	docker compose up -d

down:
	docker compose down

sqlc:
	sqlc generate

check:
	go vet ./...
	golangci-lint run
	go test ./...

test:
	go test -v ./...

run-api:
	go run ./cmd/api

run-comms:
	go run ./cmd/comms-service
