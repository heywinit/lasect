# Architecture

+--------------------+           +-------------------------------+
|   Frontend (Web)   |  HTTP/WS  |        Backend API (Go)       |
| (React + TanStack) | <-------> |   Exposes REST + WebSocket    |
+--------------------+           +-------------------------------+
        |                                      |
        |                                      |
        v                                      v
+---------------+                   +-----------------------------+
|   CLI (Go)    | <--- gRPC / API ->|    Lasect Core + Workers    |
|  lasect tool  |                   +-----------------------------+
+---------------+                              |
         |                                     |
         v                                     v
+----------------------+        +-----------------------------+
| PostgreSQL Instances |        |  External Engines/Agents    |
|  + extensions        |        | pgBackRest, pgwatch/PoWA,   |
+----------------------+        |  pg_stat_statements, etc.   |
                                +-----------------------------+

API Layer
  ├── Auth & RBAC
  ├── API Routing & Controllers
  ├── Validation & Rate Limiting
  ├── Metrics Fetching
  ├── Backups Orchestration
  ├── Extensions/Instance Mgmt
  ├── Query Engine
  └── Notifications/Alerts

Worker Layer
  ├── Background Schedulers
  ├── Metrics Pollers
  ├── Backup Jobs
  ├── Alert Evaluators
  └── Event Broadcasters

Store Layer
  ├── Lasect Metadata DB
  ├── Metrics Store (optional Prometheus or Postgres)
  └── Logs/Events/Audit

External Agents
  ├── pgwatch / PoWA
  ├── pgBackRest
  └── Postgres instances
