# Root Makefile for Lasect Monorepo

# Variables
GO_CORE := ./apps/core
GO_CLI     := ./apps/cli
FRONTEND   := ./apps/frontend

NODE := npm
GO   := go

# Default goal
.DEFAULT_GOAL := help

# -----------------------------------------------------------------------------
# General
# -----------------------------------------------------------------------------
help: ## List all available make commands
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-20s %s\n", $$1, $$2}'

# -----------------------------------------------------------------------------
# Core
# -----------------------------------------------------------------------------
core-dep: ## Install core dependencies
	cd $(GO_CORE) && $(GO) mod tidy

core-build: ## Build the core
	cd $(GO_CORE) && $(GO) build -o lasect-core ./...

core-run: ## Run the core API in dev
	cd $(GO_CORE) && $(GO) run ./...

core-test: ## Run core tests
	cd $(GO_CORE) && $(GO) test ./...

core-lint: ## Lint core code
	cd $(GO_CORE) && golangci-lint run

# -----------------------------------------------------------------------------
# CLI
# -----------------------------------------------------------------------------
cli-dep: ## Install CLI dependencies
	cd $(GO_CLI) && $(GO) mod tidy

cli-build: ## Build the CLI
	cd $(GO_CLI) && $(GO) build -o lasect ./...

cli-test: ## Run CLI tests
	cd $(GO_CLI) && $(GO) test ./...

cli-lint: ## Lint CLI code
	cd $(GO_CLI) && golangci-lint run

# -----------------------------------------------------------------------------
# Frontend
# -----------------------------------------------------------------------------
frontend-install: ## Install frontend dependencies
	cd $(FRONTEND) && $(NODE) install

frontend-dev: ## Start frontend dev server
	cd $(FRONTEND) && $(NODE) run dev

frontend-build: ## Build frontend for production
	cd $(FRONTEND) && $(NODE) run build

frontend-test: ## Run frontend tests
	cd $(FRONTEND) && $(NODE) run test

frontend-lint: ## Lint frontend code
	cd $(FRONTEND) && $(NODE) run lint

# -----------------------------------------------------------------------------
# Shared
# -----------------------------------------------------------------------------
shared-types: ## Generate / sync shared types (if any code generation)
	@echo "No shared types generation configured"

# -----------------------------------------------------------------------------
# Combined
# -----------------------------------------------------------------------------
dev: core-run frontend-dev ## Run both core and frontend (dev)
	@echo "Running core and frontend in dev modes"

build: core-build cli-build frontend-build ## Build all artifacts

test: core-test cli-test frontend-test ## Run all tests

lint: core-lint cli-lint frontend-lint ## Run all linters

clean: ## Clean all build artifacts
	rm -rf $(GO_CORE)/lasect-core
	rm -rf $(GO_CLI)/lasect
	rm -rf $(FRONTEND)/dist
