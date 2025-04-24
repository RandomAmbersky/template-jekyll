.PHONY: *

	# shortcut for other modes - eq:  make mloop , make mserve
m%:
	make start_by_env MODE_ENV=$*

start_by_env:
	MODE_ENV=${MODE_ENV} docker compose up --build

new:
	MODE_ENV="new" docker compose up --build

loop:
	MODE_ENV="loop" docker compose up

serve:
	MODE_ENV="serve" docker compose up --build
