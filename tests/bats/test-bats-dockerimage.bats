#!/usr/bin/env bats

@test "With no cmd/args, the image return docker-compose version" {
	result="$(docker run ${DOCKER_IMAGE_NAME})"
	[ "$result" == "docker-compose 1.2.0" ]
	echo "-$result-"
}

@test "A Basic fig.yml must build an run" {
	docker run --volumes-from $(hostname) --workdir /app/tests/sample "${DOCKER_IMAGE_NAME}" build

	docker run --volumes-from $(hostname) --workdir /app/tests/sample "${DOCKER_IMAGE_NAME}" up -d
}
