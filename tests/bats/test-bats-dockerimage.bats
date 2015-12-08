#!/usr/bin/env bats

@test "With no cmd/args, the image return docker-compose version ${COMPOSE_VERSION}" {
	docker run "${DOCKER_IMAGE_NAME}" | grep "${COMPOSE_VERSION}"
}

@test "A Basic fig.yml must run a complete lifecycle" {
	# Docker-ception !!!!
	# Note the remount due to lxc not following volumes from with old versions of Docker
	# in Circle Ci
	docker run \
		--volumes-from $(hostname) \
		-v /var/run/docker.sock:/docker.sock \
		-e DOCKER_HOST=unix:///docker.sock \
		--workdir /app/tests/sample \
		"${DOCKER_IMAGE_NAME}" build

	docker run \
		--volumes-from $(hostname) \
		-v /var/run/docker.sock:/docker.sock \
		-e DOCKER_HOST=unix:///docker.sock \
		--workdir /app/tests/sample \
		"${DOCKER_IMAGE_NAME}" up -d

}
