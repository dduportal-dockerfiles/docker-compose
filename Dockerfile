FROM alpine:3.2
MAINTAINER Damien DUPORTAL <damien.duportal@gmail.com>
MAINTAINER Christophe FURMANIAK <christophe.furmaniak@gmail.com>
MAINTAINER Joseph PAGE <https://github.com/josephpage>
MAINTAINER Ed Morley <https://github.com/edmorley>

ENV DOCKER_COMPOSE_VERSION 1.2.0

RUN apk --update add py-pip \
	&& pip install -U docker-compose==${DOCKER_COMPOSE_VERSION}


# This container is a chrooted docker-compose
WORKDIR /app
ENTRYPOINT ["/usr/bin/docker-compose"]
CMD ["--version"]
