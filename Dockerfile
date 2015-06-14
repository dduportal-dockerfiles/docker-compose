FROM debian:8.1
MAINTAINER Damien DUPORTAL <damien.duportal@gmail.com>
MAINTAINER Christophe FURMANIAK <christophe.furmaniak@gmail.com>
MAINTAINER Joseph PAGE <https://github.com/josephpage>
MAINTAINER Ed Morley <https://github.com/edmorley>

ADD https://github.com/docker/compose/releases/download/1.2.0/docker-compose-Linux-x86_64 /usr/local/bin/docker-compose
#curl -L https://github.com/docker/compose/releases/download/1.2.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

# This container is a chrooted docker-compose
WORKDIR /app
ENTRYPOINT ["/usr/local/bin/docker-compose"]
CMD ["--version"]
