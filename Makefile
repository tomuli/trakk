PNPM ?= pnpm
DOCKER_COMPOSE ?= docker compose
DB_HOST ?= localhost
DEV_DB_PORT ?= 5433
TEST_DB_PORT ?= 5434
DEV_CMD ?= $(PNPM) dev
TEST_CMD ?= $(PNPM) test

.PHONY: dev test db-up db-down db-logs dev-down test-down dev-logs test-logs db-push-dev db-push-test db-generate

## Start the development stack (db + app)
dev: ENV_FILE = .env.development
dev: DB_SERVICE = db-dev
dev: DB_PORT = $(DEV_DB_PORT)
dev: CMD = $(DEV_CMD)
dev: run-env

## Start the test stack (db + app/tests)
test: ENV_FILE = .env.test
test: DB_SERVICE = db-test
test: DB_PORT = $(TEST_DB_PORT)
test: CMD = $(TEST_CMD)
test: run-env

run-env: db-up
	$(PNPM) exec dotenv -e $(ENV_FILE) -- ./scripts/wait-for-db.sh $(DB_HOST) $(DB_PORT)
	$(PNPM) exec dotenv -e $(ENV_FILE) -- $(CMD)

## Generic helpers
db-up:
	$(DOCKER_COMPOSE) up -d $(DB_SERVICE)

db-down:
	$(DOCKER_COMPOSE) stop $(DB_SERVICE)

db-logs:
	$(DOCKER_COMPOSE) logs -f $(DB_SERVICE)

## Convenience shortcuts for dev DB
dev-down: DB_SERVICE = db-dev
dev-down: db-down

dev-logs: DB_SERVICE = db-dev
dev-logs: db-logs

## Convenience shortcuts for test DB
test-down: DB_SERVICE = db-test
test-down: db-down

test-logs: DB_SERVICE = db-test
test-logs: db-logs

## Run Drizzle push for the dev database
db-push-dev:
	$(PNPM) exec dotenv -e .env.development -- $(PNPM) db:push

## Run Drizzle push for the test database
db-push-test:
	$(PNPM) exec dotenv -e .env.test -- $(PNPM) db:push

## Generate SQL migrations from the TypeScript schema
db-generate:
	$(PNPM) drizzle-kit generate --name ${NAME}
