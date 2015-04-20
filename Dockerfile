FROM debian:wheezy
MAINTAINER Damien DUPORTAL <damien.duportal@gmail.com>
MAINTAINER Christophe FURMANIAK <christophe.furmaniak@gmail.com>
MAINTAINER Joseph PAGE <https://github.com/josephpage>

ENV DOCKER_COMPOSE_VERSION 1.2.0

ADD https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-Linux-x86_64 \
	/usr/local/bin/docker-compose

RUN chmod +x /usr/local/bin/docker-compose

# This container is a chrooted docker-compose
WORKDIR /app
ENTRYPOINT ["/usr/local/bin/docker-compose"]
CMD ["--version"]
