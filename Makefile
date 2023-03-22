MAKEFLAGS += --silent

.PHONY: all deploy ping test clean 

all: deploy test

deploy:
	./deploy.sh

ping:
	while true; do curl -i -D- http://localhost:80 -H 'Host: www.demo.io'; sleep 1; done

test: ## Generate traffic and test app
	[ -f ./tests/test.sh ] && ./tests/test.sh

clean: ## Clean
	echo ":: $@ ::"
	echo "You are about to stop kind cluster."
	echo "Are you sure? (Press Enter to continue or Ctrl+C to abort) "
	read _
	kind delete cluster
