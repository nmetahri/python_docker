DOCKER_CONTAINER_NAME = python
DC = docker compose -f docker-compose.yml

.PHONY: reset up do ex exa run help
.DEFAULT_GOAL := help

reset: ## Reset the docker container
	$(DC) down -v --rmi all

up: ## Start the docker container
	$(DC) up --build -d

do: ## Stop the docker container
	$(DC) down

ex: ## Enter the container
	docker compose exec -it $(DOCKER_CONTAINER_NAME) /bin/sh

exa: ## Enter the container as root
	docker compose exec -it -u root $(DOCKER_CONTAINER_NAME) /bin/sh

run: prep-args ## Run given python script
	@if [ -z "$(runargs)" ]; then \
		echo "Usage: make run SCRIPT=<path_to_script>"; \
	else \
		docker compose exec -it $(DOCKER_CONTAINER_NAME) python $(runargs); \
	fi

help: ## Display this help
	@echo "Usage: make [target]"
	@echo "Targets:"
	@awk -F ':.*?## ' '/^[a-zA-Z0-9_-]+:.*?##/ { printf "  %-15s: %s\n", $$1, substr($$0, index($$0, $$2)) }' $(MAKEFILE_LIST)


prep-args: ## [Internal] Pre-recipe for commands with args
	@echo -e "\e[1;44m Please be aware that you cannot concatenate recipes with this command! \e[0m"
	$(eval runargs=$(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS)))


prep-find: prep-args ## [Internal] Pre-recipe for find commands
	@$(eval F_FIND_BUILT=$(patsubst %,-name '*%*' -o, $(wordlist 2,$(words $(runargs)),x $(runargs))) $(patsubst %,-name '*%*', $(lastword $(runargs))))