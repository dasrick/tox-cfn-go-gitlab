LIST_ALL := $(shell go list ./... | grep -v /vendor/)


.PHONY: install
install: ## Install the dependencies (via dep)
	dep ensure

.PHONY: update
update: ## Update the dependencies (via dep)
	dep ensure -update


.PHONY: lint
lint: ## Lint all files (via golint)
	@go fmt ${LIST_ALL}
	@golint -set_exit_status ${LIST_ALL}

.PHONY: test
test: install ## Run unit tests
	@go test -short ${LIST_ALL}

.PHONY: race
race: install ## Run data race detector
	@go test -race -short ${LIST_ALL}

.PHONY: coverage
coverage: install # Generate coverage report
	@go test ${LIST_ALL}  -coverprofile coverage.out
	@go tool cover -func coverage.out

.PHONY: report
report: coverage # Open the coverage report in browser
	@go tool cover -html=coverage.out


.PHONY: clean
clean: ## Remove binaries and ZIP files based on directory `./cmd/`
	@for CMD in `ls cmd`; do rm -f $$CMD.zip $$CMD; done
	@rm -f coverage.out

.PHONY: build
build: clean install ## Build all binaries based on directory `./cmd/`
	@for CMD in `ls cmd`; do GOOS=linux GOARCH=amd64 go build ./cmd/$$CMD; done

#.PHONY: package
#package: build ## Generate ZIP files of binaries based on directory `./cmd/`
#	@for CMD in `ls cmd`; do zip $$CMD.zip $$CMD && rm -f $$CMD; done

	

.PHONY: help
help: ## Display this help screen
	@grep -h -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
