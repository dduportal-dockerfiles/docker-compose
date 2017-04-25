.PHONY: build test all

DOCKER_IMAGE_NAME=dduportal/docker-compose
COMPOSE_VERSION=1.12.0

all: build test

build:
	docker build \
		--tag $(DOCKER_IMAGE_NAME) \
		./

test:
	docker run \
		-v $(CURDIR):/app \
		-v $$(which docker):$$(which docker) \
		-v /var/run/docker.sock:/docker.sock \
		-e DOCKER_HOST="unix:///docker.sock" \
		-e DOCKER_IMAGE_NAME=$(DOCKER_IMAGE_NAME) \
		-e COMPOSE_VERSION=$(COMPOSE_VERSION) \
		dduportal/bats:0.4.0 \
			/app/tests/bats/
