## What is Docker Compose ? ##

Compose is a tool for defining and running complex applications with Docker. With Compose, you define a multi-container application in a single file, then spin your application up in a single command which does everything that needs to be done to get it running.

More information on the official Docker documentation : https://docs.docker.com/compose/

[![CircleCi Build Status](https://circleci.com/gh/dduportal-dockerfiles/docker-compose.svg?&style=shield)](https://circleci.com/gh/dduportal-dockerfiles/docker-compose)

## How do you use this image ? ##

**Interactive and basic mode :**

Just run it as a normal command, sharing the directory containing your docker-compose.yml file and the Docker Unix socket :

```bash
$ docker run -v "$(pwd)":"$(pwd)" \
             -v /var/run/docker.sock:/var/run/docker.sock \
             -e COMPOSE_PROJECT_NAME=$(basename "$(pwd)") \
             --workdir="$(pwd)" \
             -ti --rm \
             dduportal/docker-compose:latest --help
```

**Customize the Docker socket**

When using another socket than the default Unix one (remote Docker engine use case), you can provide the path to docker-compose using the DOCKER_HOST environment variable.
In this example, we'll call docker-compose non-interactively (from a bash script for example), given that the Docker daemon listen through a TCP connection at 10.0.2.15:2375 :

```bash
$ docker run -v "$(pwd)":"$(pwd)" \
             -e DOCKER_HOST=tcp://10.0.2.15:2375 \
             -e COMPOSE_PROJECT_NAME=$(basename "$(pwd)") \
             --workdir="$(pwd)" \
             --rm \
             dduportal/docker-compose:latest up -d
```

On Windows when using the Boot2Docker provided MSYS shell, you should add ```/``` before each of the host paths passed to ```-v```, to help the path conversion [(courtesy of @joostfarla)](https://github.com/dduportal-dockerfiles/docker-compose/issues/1#issuecomment-99464292) :

```bash
$ docker run -v "/$(pwd)":"/$(pwd)" \
             -v //var/run/docker.sock:/var/run/docker.sock \
             -e COMPOSE_PROJECT_NAME=$(basename "/$(pwd)") \
             --workdir="$(pwd)" \
             -ti --rm \
             dduportal/docker-compose:latest
```

Note: On Windows, if you are using MSYS **v2** or Cygwin (where ```pwd``` in the home directory returns /home/Foo, rather than /c/Users/Foo), you'll also need to replace ```$(pwd)``` with ```$(pwd | sed s_/home_/c/Users_)```, so the correct directory is mounted.

**Convenience mode :**

If you don't want to repeat yourself by typing all the options each time, just add an alias (interactive or in your .profile/.ashrc/etc :

```bash
    echo 'alias docker-compose="docker run -v \"\$(pwd)\":\"\$(pwd)\" -v /var/run/docker.sock:/var/run/docker.sock -e COMPOSE_PROJECT_NAME=\$(basename \"\$(pwd)\") -ti --rm --workdir=\"\$(pwd)\" dduportal/docker-compose:latest"' \
    >> ~/.ashrc
```

**Customize image from your custom Dockerfile**

If the image doesn't fit your needs "as it", you can customize it using your own Dockerfile, for example :

    FROM dduportal/docker-compose:latest
    MAINTAINER your.mail@here

    ADD . /app/ # your docker-compose.yml can be copied inside the image
    ENV DOCKER_HOST tcp://192.168.0.1:2375 # Customize the docker socket

    # Your custom stuff here if needed

Note that ENTRYPOINT will be inherited.

Run it now (without option while you provide them inside the image instead of at run time ) :

```bash
    docker build -t you/docker-compose ./
    docker run -ti --rm you/docker-compose ps
```

## Volumes : relative and absolute

Be careful using volumes : since the goal of this image is to wrap docker-compose inside a container, you have to provide the right volume's path to the right actor.

This issue explains how : https://github.com/dduportal/dockerfiles/issues/5 .

The idea is to provide a full "host point of view path" for the volume to mount, since the containerised docker-compose may not have access to the full filesystem.

## Contributing

Do not hesitate to contribute by forking this repository

Pick at least one :

* Implement tests in ```/tests/bats/```

* Write the Dockerfile

* (Re)Write the documentation corrections


Finally, open the Pull Request : CircleCi will automatically build and test for you
