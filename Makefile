.PHONY: *

new:
	docker compose run jeckyll-server sh -c "jekyll new my-blog" --build
