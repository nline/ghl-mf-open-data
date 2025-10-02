# Makefile for MF Power Data Publishing Project
# This Makefile provides build automation for the HTML-based data catalog

# Variables
SHELL := /bin/bash
PYTHON := python3
PORT := 8000
BUILD_DIR := build
DIST_DIR := dist
HTML_FILES := $(wildcard *.html)
CSS_FILES := $(wildcard *.css)
JS_FILES := $(wildcard *.js)

# Colors for output
RED := \033[0;31m
GREEN := \033[0;32m
YELLOW := \033[1;33m
BLUE := \033[0;34m
NC := \033[0m # No Color

# JavaScript modules directory
COMPONENTS_DIR := components

# Default target
.PHONY: help
help: ## Show this help message
	@echo "$(BLUE)MF Power Data Publishing - Build Automation$(NC)"
	@echo "$(YELLOW)Available targets:$(NC)"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  $(GREEN)%-15s$(NC) %s\n", $$1, $$2}' $(MAKEFILE_LIST)

# Development targets
.PHONY: serve
serve: ## Start a local development server
	@echo "$(BLUE)Starting development server on port $(PORT)...$(NC)"
	@echo "$(YELLOW)Access your site at: http://localhost:$(PORT)$(NC)"
	@$(PYTHON) -m http.server $(PORT)

.PHONY: serve-https
serve-https: ## Start a local HTTPS development server (requires Python 3.7+)
	@echo "$(BLUE)Starting HTTPS development server on port $(PORT)...$(NC)"
	@echo "$(YELLOW)Access your site at: https://localhost:$(PORT)$(NC)"
	@$(PYTHON) -m http.server $(PORT) --bind 127.0.0.1

# Build targets
.PHONY: build
build: clean validate ## Build the project for production
	@echo "$(BLUE)Building project for production...$(NC)"
	@mkdir -p $(BUILD_DIR)
	@cp *.html $(BUILD_DIR)/ 2>/dev/null || true
	@cp *.css $(BUILD_DIR)/ 2>/dev/null || true
	@cp *.js $(BUILD_DIR)/ 2>/dev/null || true
	@cp *.svg $(BUILD_DIR)/ 2>/dev/null || true
	@cp *.png $(BUILD_DIR)/ 2>/dev/null || true
	@cp *.jpg $(BUILD_DIR)/ 2>/dev/null || true
	@cp *.jpeg $(BUILD_DIR)/ 2>/dev/null || true
	@cp -r public $(BUILD_DIR)/ 2>/dev/null || true
	@echo "$(GREEN)Build completed successfully!$(NC)"

.PHONY: minify
minify: build ## Minify HTML files for production
	@echo "$(BLUE)Minifying HTML files...$(NC)"
	@if command -v html-minifier >/dev/null 2>&1; then \
		for file in $(BUILD_DIR)/*.html; do \
			html-minifier --collapse-whitespace --remove-comments --minify-css --minify-js -o $$file $$file; \
		done; \
		echo "$(GREEN)HTML files minified successfully!$(NC)"; \
	else \
		echo "$(YELLOW)html-minifier not found. Install with: npm install -g html-minifier$(NC)"; \
	fi

# Validation targets
.PHONY: validate
validate: ## Validate HTML files
	@echo "$(BLUE)Validating HTML files...$(NC)"
	@if command -v html5validator >/dev/null 2>&1; then \
		html5validator --root . --format text; \
		echo "$(GREEN)HTML validation completed!$(NC)"; \
	elif command -v tidy >/dev/null 2>&1; then \
		for file in $(HTML_FILES); do \
			echo "Validating $$file..."; \
			tidy -q -e $$file; \
		done; \
		echo "$(GREEN)HTML validation completed!$(NC)"; \
	else \
		echo "$(YELLOW)No HTML validator found. Install html5validator or tidy$(NC)"; \
	fi

.PHONY: check-links
check-links: ## Check for broken links in HTML files
	@echo "$(BLUE)Checking for broken links...$(NC)"
	@if command -v linkchecker >/dev/null 2>&1; then \
		linkchecker --check-extern --no-warnings .; \
	elif command -v wget >/dev/null 2>&1; then \
		for file in $(HTML_FILES); do \
			echo "Checking links in $$file..."; \
			wget --spider --quiet --recursive --level=1 --no-parent --page-requisites --no-directories --no-host-directories --cut-dirs=1 --reject="*.css,*.js" --input-file=<(grep -o 'href="[^"]*"' $$file | sed 's/href="//g' | sed 's/"//g' | grep -v '^#' | grep -v '^mailto:' | grep -v '^tel:'); \
		done; \
		echo "$(GREEN)Link checking completed!$(NC)"; \
	else \
		echo "$(YELLOW)No link checker found. Install linkchecker or wget$(NC)"; \
	fi

.PHONY: accessibility
accessibility: ## Check accessibility of HTML files
	@echo "$(BLUE)Checking accessibility...$(NC)"
	@if command -v a11y >/dev/null 2>&1; then \
		for file in $(HTML_FILES); do \
			echo "Checking accessibility for $$file..."; \
			a11y $$file; \
		done; \
	elif command -v axe-cli >/dev/null 2>&1; then \
		for file in $(HTML_FILES); do \
			echo "Checking accessibility for $$file..."; \
			axe-cli $$file; \
		done; \
	else \
		echo "$(YELLOW)No accessibility checker found. Install a11y or axe-cli$(NC)"; \
	fi

# Testing targets
.PHONY: test
test: validate check-links ## Run all tests
	@echo "$(GREEN)All tests completed!$(NC)"

.PHONY: test-ci
test-ci: ## Run tests suitable for CI/CD
	@echo "$(BLUE)Running CI tests...$(NC)"
	@make validate
	@make check-links
	@echo "$(GREEN)CI tests completed!$(NC)"

# Deployment targets
.PHONY: deploy
deploy: build ## Deploy to production (customize for your deployment target)
	@echo "$(BLUE)Deploying to production...$(NC)"
	@echo "$(YELLOW)Customize this target for your deployment method$(NC)"
	@echo "$(YELLOW)Examples: rsync, scp, git push, or cloud deployment$(NC)"

.PHONY: deploy-s3
deploy-s3: build ## Deploy to AWS S3 (requires AWS CLI)
	@echo "$(BLUE)Deploying to AWS S3...$(NC)"
	@if command -v aws >/dev/null 2>&1; then \
		aws s3 sync $(BUILD_DIR)/ s3://your-bucket-name/ --delete; \
		echo "$(GREEN)Deployment to S3 completed!$(NC)"; \
	else \
		echo "$(RED)AWS CLI not found. Install with: pip install awscli$(NC)"; \
	fi

.PHONY: deploy-github-pages
deploy-github-pages: build ## Deploy to GitHub Pages
	@echo "$(BLUE)Deploying to GitHub Pages...$(NC)"
	@if [ -d .git ]; then \
		git add $(BUILD_DIR)/; \
		git commit -m "Deploy to GitHub Pages"; \
		git subtree push --prefix $(BUILD_DIR) origin gh-pages; \
		echo "$(GREEN)Deployment to GitHub Pages completed!$(NC)"; \
	else \
		echo "$(RED)Not a git repository$(NC)"; \
	fi

# Utility targets
.PHONY: clean
clean: ## Clean build artifacts
	@echo "$(BLUE)Cleaning build artifacts...$(NC)"
	@rm -rf $(BUILD_DIR)
	@rm -rf $(DIST_DIR)
	@rm -rf .DS_Store
	@find . -name "*.tmp" -delete
	@echo "$(GREEN)Clean completed!$(NC)"

.PHONY: install-deps
install-deps: ## Install development dependencies
	@echo "$(BLUE)Installing development dependencies...$(NC)"
	@if command -v npm >/dev/null 2>&1; then \
		npm install -g html-minifier html5validator linkchecker a11y; \
		echo "$(GREEN)Dependencies installed!$(NC)"; \
	else \
		echo "$(YELLOW)npm not found. Please install Node.js and npm$(NC)"; \
	fi

.PHONY: format
format: ## Format HTML files
	@echo "$(BLUE)Formatting HTML files...$(NC)"
	@if command -v prettier >/dev/null 2>&1; then \
		prettier --write "*.html"; \
		echo "$(GREEN)HTML files formatted!$(NC)"; \
	else \
		echo "$(YELLOW)prettier not found. Install with: npm install -g prettier$(NC)"; \
	fi

.PHONY: lint
lint: ## Lint HTML files
	@echo "$(BLUE)Linting HTML files...$(NC)"
	@if command -v htmlhint >/dev/null 2>&1; then \
		htmlhint "*.html"; \
		echo "$(GREEN)Linting completed!$(NC)"; \
	else \
		echo "$(YELLOW)htmlhint not found. Install with: npm install -g htmlhint$(NC)"; \
	fi

.PHONY: backup
backup: ## Create a backup of the project
	@echo "$(BLUE)Creating backup...$(NC)"
	@tar -czf "backup-$(shell date +%Y%m%d-%H%M%S).tar.gz" --exclude='.git' --exclude='$(BUILD_DIR)' --exclude='$(DIST_DIR)' .
	@echo "$(GREEN)Backup created!$(NC)"

.PHONY: stats
stats: ## Show project statistics
	@echo "$(BLUE)Project Statistics:$(NC)"
	@echo "$(YELLOW)HTML files:$(NC) $(words $(HTML_FILES))"
	@echo "$(YELLOW)CSS files:$(NC) $(words $(CSS_FILES))"
	@echo "$(YELLOW)JS files:$(NC) $(words $(JS_FILES))"
	@echo "$(YELLOW)Total lines of code:$(NC) $(shell find . -name "*.html" -o -name "*.css" -o -name "*.js" | xargs wc -l | tail -1 | awk '{print $$1}')"
	@echo "$(YELLOW)Project size:$(NC) $(shell du -sh . | cut -f1)"

# Development workflow
.PHONY: dev
dev: serve ## Start development environment

.PHONY: watch
watch: ## Watch for changes and rebuild
	@echo "$(BLUE)Watching for changes...$(NC)"
	@if command -v fswatch >/dev/null 2>&1; then \
		fswatch -o . | xargs -n1 -I{} make build; \
	elif command -v inotifywait >/dev/null 2>&1; then \
		while inotifywait -e modify,create,delete,move .; do make build; done; \
	else \
		echo "$(YELLOW)No file watcher found. Install fswatch or inotify-tools$(NC)"; \
	fi

# Quick development commands
.PHONY: quick-serve
quick-serve: ## Quick serve without validation
	@echo "$(BLUE)Quick serve (no validation)...$(NC)"
	@$(PYTHON) -m http.server $(PORT)

.PHONY: quick-build
quick-build: ## Quick build without validation
	@echo "$(BLUE)Quick build (no validation)...$(NC)"
	@mkdir -p $(BUILD_DIR)
	@cp *.html $(BUILD_DIR)/ 2>/dev/null || true
	@cp *.css $(BUILD_DIR)/ 2>/dev/null || true
	@cp *.js $(BUILD_DIR)/ 2>/dev/null || true
	@cp *.svg $(BUILD_DIR)/ 2>/dev/null || true
	@cp *.png $(BUILD_DIR)/ 2>/dev/null || true
	@cp *.jpg $(BUILD_DIR)/ 2>/dev/null || true
	@cp *.jpeg $(BUILD_DIR)/ 2>/dev/null || true
	@cp -r public $(BUILD_DIR)/ 2>/dev/null || true
	@echo "$(GREEN)Quick build completed!$(NC)"

# Show current status
.PHONY: status
status: ## Show current project status
	@echo "$(BLUE)Project Status:$(NC)"
	@echo "$(YELLOW)Git status:$(NC)"
	@git status --porcelain 2>/dev/null || echo "Not a git repository"
	@echo "$(YELLOW)Build directory:$(NC) $(shell [ -d $(BUILD_DIR) ] && echo "Exists" || echo "Does not exist")"
	@echo "$(YELLOW)Last modified files:$(NC)"
	@ls -lt *.html 2>/dev/null | head -5 || echo "No HTML files found"

# JavaScript modules
.PHONY: components
components: ## Show available JavaScript components
	@echo "$(BLUE)Available JavaScript components:$(NC)"
	@ls -la $(COMPONENTS_DIR)/ 2>/dev/null || echo "No components found"
	@echo "$(GREEN)Components ready for use in HTML pages$(NC)"

# AWS Lambda Backend
.PHONY: lambda-setup
lambda-setup: ## Setup AWS Lambda backend dependencies
	@echo "$(BLUE)Setting up Lambda backend...$(NC)"
	@cd backend/lambda && npm install
	@echo "$(GREEN)Lambda backend setup complete!$(NC)"

.PHONY: lambda-deploy
lambda-deploy: ## Deploy Lambda function to AWS
	@echo "$(BLUE)Deploying Lambda function...$(NC)"
	@cd backend/lambda && serverless deploy
	@echo "$(GREEN)Lambda function deployed!$(NC)"

.PHONY: lambda-logs
lambda-logs: ## View Lambda function logs
	@echo "$(BLUE)Fetching Lambda logs...$(NC)"
	@cd backend/lambda && serverless logs -f contact

.PHONY: lambda-remove
lambda-remove: ## Remove Lambda function from AWS
	@echo "$(BLUE)Removing Lambda function...$(NC)"
	@cd backend/lambda && serverless remove
	@echo "$(GREEN)Lambda function removed!$(NC)"

.PHONY: lambda-local
lambda-local: ## Test Lambda function locally
	@echo "$(BLUE)Starting Lambda function locally...$(NC)"
	@cd backend/lambda && serverless offline

# All-in-one targets
.PHONY: all
all: clean validate build test ## Run complete build pipeline

.PHONY: release
release: clean validate build minify test ## Create production release
	@echo "$(GREEN)Release build completed!$(NC)"
	@echo "$(YELLOW)Files ready for deployment in $(BUILD_DIR)/$(NC)"