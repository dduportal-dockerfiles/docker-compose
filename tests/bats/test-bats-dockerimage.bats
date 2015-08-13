#!/usr/bin/env bats

@test "With no cmd/args, the image return docker-compose version" {
	result="$(docker run ${DOCKER_IMAGE_NAME})"
	[[ "$result" == *"docker-compose version: 1.4.0"* ]]
	echo "-$result-"
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

DEBIAN_VERSION=8.1
@test "We use the debian linux version ${DEBIAN_VERSION}" {
	[ $(docker run --entrypoint sh "${DOCKER_IMAGE_NAME}" -c "grep \"${DEBIAN_VERSION}\" /etc/debian_version | wc -l") -eq 1 ]
}
