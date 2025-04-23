.PHONY: *

new:
	MODE_ENV="new" docker compose up --build

up:
	MODE_ENV="serve" docker compose up --build
