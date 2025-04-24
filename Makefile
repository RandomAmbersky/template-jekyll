.PHONY: *

# Загружаем переменные из .env
# ENV_FILE := $(shell cat .env 2>/dev/null)
# export $(ENV_FILE)

.EXPORT_ALL_VARIABLES:
-include .env

# shortcut for other modes - eq:  make mloop , make mserve
m%:
	make start_by_env MODE_ENV=$*

debug:
	@echo $(ENV_FILE)
	@echo "GITHUB_REPO is [$(GITHUB_REPO)]"

start_by_env:
	MODE_ENV=${MODE_ENV} docker compose up --build

clone:
	@echo $(ENV_FILE)
	MODE_ENV="clone" ./bin/

anon:
	@echo $(ENV_FILE)
	MODE_ENV="anonimize" ./bin/startup.sh

push:
	MODE_ENV="push" ./bin/startup.sh

new:
	MODE_ENV="new" docker compose up --build

loop:
	MODE_ENV="loop" docker compose up

serve:
	MODE_ENV="serve" docker compose up --build
