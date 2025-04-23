.PHONY: *

new:
	MODE_ENV="new" docker compose up --build

loop:
	MODE_ENV="loop" docker compose up

serve:
	MODE_ENV="serve" docker compose up --build
