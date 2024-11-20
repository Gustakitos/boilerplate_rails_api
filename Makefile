#!/usr/bin/env make
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
RESET  := $(shell tput -Txterm sgr0)

## Removes hanging server.pid if docker stopped suddenly
remove-server-pid:
	rm -f ./tmp/pids/server.pid

## Starts the containers
up:
	@make remove-server-pid
	docker compose up -d --remove-orphans

## Run the tests!
test:
	docker compose exec --env RAILS_ENV=test web bundle exec rspec $(file)

## Run rubocop
rubocop:
	docker compose exec web bundle exec rubocop -a

## Stop containers, remove PID file and start in detached mode
clean:
	docker compose down
	@make up

## Quick restart of web container
restart:
	docker compose up -d --remove-orphans

## Full rebuild and restart (for new dependencies)
rebuild-web:
	docker compose stop web
	docker compose build web
	@make up
