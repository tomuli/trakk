# TanStack Start - Basic Auth Example

A TanStack Start example demonstrating authentication patterns and protected routes.

- [TanStack Router Docs](https://tanstack.com/router)

## Start a new project based on this example

To start a new project based on this example, run:

```sh
npx gitpick TanStack/router/tree/main/examples/react/start-basic-auth start-basic-auth
```

## Getting Started

From your terminal:

```sh
pnpm install
make db-push-dev   # applies the schema to the dev database
make dev           # boots docker, waits for Postgres, and runs pnpm dev
```

This starts your app in development mode, rebuilding assets on file changes. Use `make test` / `make db-push-test` to target the test database defined in `docker-compose.yml`.

## Build

To build the app for production:

```sh
pnpm build
```

## Authentication Features

### Database & environment files

- The example now uses [Drizzle ORM](https://orm.drizzle.team/) with the PostgreSQL (`pg`) driver.
- Environment-specific settings live in `.env.development` and `.env.test`. The Makefile loads the appropriate file automatically for the `dev`, `test`, `db-push-*`, and log/down targets, so no manual `dotenv` prefixes are needed.
- `make db-push-dev` / `make db-push-test` run the schema defined in `src/db/schema.ts` against the `db-dev` (`postgresql://postgres:postgres@localhost:5433/tracker_dev`) and `db-test` (`postgresql://postgres:postgres@localhost:5434/tracker_test`) containers respectively, creating the `User` table if needed.

This example demonstrates:

- User authentication flow
- Protected routes
- Login/logout functionality
- Redirect after authentication
