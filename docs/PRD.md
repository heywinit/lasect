# Lasect

## 1. Purpose

Lasect is a PostgreSQL instance management platform that provides a unified interface for database administration, monitoring, backups, performance analysis, and automation. Its goal is to deliver a consistent experience through both a web application and a command-line interface, leveraging existing components such as pgBackRest, pgwatch, PoWA, pg_stat_statements, and extensions.

## 2. Scope

This document defines functional and non-functional requirements, architecture, user roles, use cases, and constraints for Lasect version 1.0.

## 3. Definitions

Instance: A PostgreSQL server or cluster.
API: Backend REST API that powers both the web app and CLI.
CLI: Command-line interface for automation and direct control.
Component: Underlying engine integrated into Lasect (e.g., pgBackRest).
Metrics Engine: A service that collects performance and health metrics (e.g., pgwatch).

## 4. User Roles

Administrator: Full access, can manage instances, backups, alerts, users.
User: Can view dashboards, run queries, see metrics, create backups.
Viewer: Read-only access.

## 5. Assumptions

Users have PostgreSQL instances accessible with credentials.
Lasect backend runs in an environment with network access to instances.
CLI installation is permitted on the target servers or developer machines.

## 6. Functional Requirements

### 6.1 Instance Management

- [ ] FR1: List all configured PostgreSQL instances.
- [ ] FR2: Add an instance with connection string.
- [ ] FR3: Remove an instance.
- [ ] FR4: Test connection to an instance.
- [ ] FR5: Display instance metadata (version, roles, replication state).

### 6.2 Monitoring & Metrics

- [ ] FR6: Integrate with pgwatch to collect metrics.
- [ ] FR7: Display CPU, memory, connections, query stats.
- [ ] FR8: Support custom metric queries.
- [ ] FR9: Provide historical charts.
- [ ] FR10: Provide real-time streaming metrics via WebSocket.

### 6.3 Query and Performance Tools

- [ ] FR11: SQL editor with syntax highlighting.
- [ ] FR12: Run arbitrary SQL queries.
- [ ] FR13: Show query explain plans.
- [ ] FR14: List top slow queries (using pg_stat_statements).

### 6.4 Schema & Data Explorer

- [ ] FR15: Display schemas, tables, views, functions.
- [ ] FR16: Browse table data.
- [ ] FR17: Export and import data (CSV, SQL).
- [ ] FR18: Visual schema diagram generation.

### 6.5 Extensions Management

- [ ] FR19: List installed extensions per instance.
- [ ] FR20: Enable/disable extensions.
- [ ] FR21: Display extension compatibility and version.

### 6.6 Backups & Restore

- [ ] FR22: Use pgBackRest for backup orchestration.
- [ ] FR23: Create backup policies and schedules.
- [ ] FR24: List past backups.
- [ ] FR25: Restore from a selected backup.
- [ ] FR26: Support PITR (point-in-time recovery).
- [ ] FR27: Support target storage backends (local, S3, Azure, GCS).

### 6.7 Alerts & Notifications

- [ ] FR28: Define alert rules on metrics.
- [ ] FR29: Integrate with notification channels (email, webhook, Slack).
- [ ] FR30: Provide alert history and status.

### 6.8 Security & Access Controls

- [ ] FR31: User authentication with support for API tokens.
- [ ] FR32: Role-based access control per resource.
- [ ] FR33: Audit logs for changes and actions.

### 6.9 CLI

- [ ] FR34: Provide a Go-based CLI lasect.
- [ ] FR35: CLI mirrors web functionality (listing, backups, metrics, SQL runs).
- [ ] FR36: Support local and remote API modes.
- [ ] FR37: Support JSON output for scripting.

## 7. Architecture

### 7.1 Backend

Language: Go
API: REST + WebSocket
Postgres driver: pgx
Integrates external engines:
    - pgwatch (metrics)
    - pgBackRest (backups)
    - pg_stat_statements (query stats)
    - PoWA (optional advanced analytics)

### 7.2 Frontend

Framework: React + TanStack Start

### 7.3 CLI

Written in Go
Communicates with API or runs local operations

```bash
lasect instance list
lasect instance add --dsn <string>
lasect backup schedule create --instance <id> --policy <policy>
lasect backup list --instance <id>
lasect metrics show --instance <id>
lasect sql run "SQL_QUERY"
```

## 8. Security Requirements

Secure storage of credentials (encrypted at rest).
API endpoints must validate authentication tokens.
RBAC lifecycle for all resources.
Optional integration with external identity providers (SSO/LDAP).
