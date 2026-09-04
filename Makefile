.PHONY: install test build run docker-build docker-up

install:
	@echo "No dependencies required for static HTML/CSS/JS project"

test:
	node tests/test_app.js

build:
	@echo "Build successful - static HTML/CSS/JS project"

run:
	@echo "Open home.html in a browser"

docker-build:
	@echo "TODO: docker build for frontend and backend" && exit 1

docker-up:
	docker compose up --build
