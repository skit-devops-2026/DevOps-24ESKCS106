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
	docker build --build-arg COMMIT_SHA=$$(git rev-parse --short HEAD 2>/dev/null || echo "latest") -t devops-digital-bank:latest -t devangbisartii/digital-bank:latest -t bisartii/digital-bank:latest .

docker-up:
	docker compose up --build -d
