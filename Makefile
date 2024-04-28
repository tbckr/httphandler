default: help

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

test: ## Run tests
	go test -failfast -race -coverpkg=./... -covermode=atomic -coverprofile=coverage.txt ./... -run . -timeout=5m

coverage: test ## Generate coverage report
	go tool cover -html=coverage.txt

lint: ## Run linter
	golangci-lint run ./...

tidy: ## Run go mod tidy
	go mod tidy

clean: ## Clean up
	rm -rf dist
	rm -rf coverage.txt

pre: ## Run pre-commit checks
	pre-commit run --all-files

license: ## Add license headers
	addlicense -c "Tim <tbckr>" -l MIT -s -v \
        -ignore "dist/**" \
        -ignore ".idea/**" \
        -ignore ".task/**" \
        -ignore ".github/licenses.tmpl" \
        -ignore "licenses/*" \
        -ignore "venv/*" \
        .

.PHONY: test coverage lint pre license clean tidy help