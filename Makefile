MAKEFLAGS += --silent

.PHONY: all
all: deploy test

deploy:
	./deploy.sh

.PHONY: test
test: ## Generate traffic and test app
	[ -f ./tests/test.sh ] && ./tests/test.sh

.PHONY: clean
clean: ## Clean
	echo ":: $@ ::"
	echo "You are about to stop kind cluster."
	echo "Are you sure? (Press Enter to continue or Ctrl+C to abort) "
	read _
	kind delete cluster
