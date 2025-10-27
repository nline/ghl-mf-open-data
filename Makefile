# Makefile for MF Power Data Publishing Project on CloudFront

# Variables
SHELL := /bin/bash
PYTHON := python3
PORT := 8000
BUILD_DIR := build

# Colors for output
RED := \033[0;31m
GREEN := \033[0;32m
YELLOW := \033[1;33m
BLUE := \033[0;34m
NC := \033[0m # No Color

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
	@echo "$(YELLOW)Access site at: http://localhost:$(PORT)$(NC)"
	@$(PYTHON) -m http.server $(PORT)

.PHONY: dev
dev: serve ## Alias for serve

# Build targets
.PHONY: build
build: clean validate ## Build the project for CloudFront deployment
	@echo "$(BLUE)Building project for CloudFront...$(NC)"
	@mkdir -p $(BUILD_DIR)
	@cp *.html $(BUILD_DIR)/ 2>/dev/null || true
	@cp *.css $(BUILD_DIR)/ 2>/dev/null || true
	@cp *.js $(BUILD_DIR)/ 2>/dev/null || true
	@cp -r components $(BUILD_DIR)/ 2>/dev/null || true
	@cp -r public $(BUILD_DIR)/ 2>/dev/null || true
	@cp tailwind.config.js $(BUILD_DIR)/ 2>/dev/null || true
	@echo "$(GREEN)Build completed successfully!$(NC)"
	@echo "$(YELLOW)Files ready for CloudFront deployment in $(BUILD_DIR)/$(NC)"

.PHONY: clean
clean: ## Clean build artifacts
	@echo "$(BLUE)Cleaning build artifacts...$(NC)"
	@rm -rf $(BUILD_DIR)
	@echo "$(GREEN)Clean completed!$(NC)"

# Validation targets
.PHONY: validate
validate: ## Validate HTML files
	@echo "$(BLUE)Validating HTML files...$(NC)"
	@for file in *.html; do \
		if [ -f "$$file" ]; then \
			echo "Validating $$file..."; \
			python3 -c "import html.parser; parser = html.parser.HTMLParser(); parser.feed(open('$$file').read())" 2>/dev/null || echo "Warning: $$file may have HTML issues"; \
		fi; \
	done
	@echo "$(GREEN)HTML validation completed!$(NC)"

# Quick build (no validation)
.PHONY: quick
quick: clean
	@echo "$(BLUE)Quick build (no validation)...$(NC)"
	@mkdir -p $(BUILD_DIR)
	@cp *.html $(BUILD_DIR)/ 2>/dev/null || true
	@cp *.css $(BUILD_DIR)/ 2>/dev/null || true
	@cp *.js $(BUILD_DIR)/ 2>/dev/null || true
	@cp -r components $(BUILD_DIR)/ 2>/dev/null || true
	@cp -r public $(BUILD_DIR)/ 2>/dev/null || true
	@cp tailwind.config.js $(BUILD_DIR)/ 2>/dev/null || true
	@echo "$(GREEN)Quick build completed!$(NC)"

# CloudFront deployment info
.PHONY: deploy-info
deploy-info: ## Show CloudFront deployment information
	@echo "$(BLUE)CloudFront Deployment Information$(NC)"
	@echo "$(YELLOW)1. Upload the contents of $(BUILD_DIR)/ to the CloudFront origin$(NC)"
	@echo "$(YELLOW)2. Ensure CloudFront is configured to serve index.html for directory requests$(NC)"
	@echo "$(YELLOW)3. The URLs will be:$(NC)"
	@echo "$(YELLOW)   - https://d2g52vato6bo1j.cloudfront.net/$(NC)"
	@echo "$(YELLOW)   - https://d2g52vato6bo1j.cloudfront.net/kenya-power-data.html$(NC)"
	@echo "$(GREEN)Ready for CloudFront deployment!$(NC)"