.PHONY: build test all

DOCKER_IMAGE_NAME=amontaigu/docker-compose

all: build test

build:
	docker build --tag $(DOCKER_IMAGE_NAME) .

test:
	docker run \
		-v $(CURDIR):/app \
		-v $$(which docker):$$(which docker) \
		-v /var/run/docker.sock:/docker.sock \
		-e DOCKER_HOST="unix:///docker.sock" \
		-e DOCKER_IMAGE_NAME=$(DOCKER_IMAGE_NAME) \
		dduportal/bats:0.4.0 \
			/app/tests/bats/
