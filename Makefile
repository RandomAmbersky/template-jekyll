.PHONY: *

ENV ?= .env

ifneq ("$(wildcard $(ENV))","")
    include $(ENV)
    # Экспортируем все переменные из .env файла
    export $(shell sed 's/=.*//' $(ENV))
else
    $(error Файл окружения $(ENV) не найден!)
endif

@echo "ENV is: $(ENV)"

# .EXPORT_ALL_VARIABLES:
# -include ${ENV}

# shortcut for other modes - eq:  make mloop , make mserve
# m%:
	# make start_by_env MODE_ENV=$*

debug:
	@echo "ENV: $(ENV)"
	@echo "MAKECMDGOALS: $(MAKECMDGOALS)"
	@echo "GITHUB_REPO is [$(GITHUB_REPO)]"

start_by_env:
	MODE_ENV=${MODE_ENV} docker compose up --build

clone:
	@echo "GITHUB_REPO: $(GITHUB_REPO)"
	@MODE_ENV="clone" ./bin/startup.sh

anon:
	MODE_ENV="anonimize" ./bin/startup.sh

push:
	MODE_ENV="push" ./bin/startup.sh

push-force:
	MODE_ENV="push-force" ./bin/startup.sh

new:
	MODE_ENV="new" docker compose up --build

loop:
	MODE_ENV="loop" docker compose up

serve:
	MODE_ENV="serve" docker compose up --build

# Игнорируем все, что не является явной целью
%:
	@true
