## What is Docker Compose ? ##

Compose is a tool for defining and running complex applications with Docker. With Compose, you define a multi-container application in a single file, then spin your application up in a single command which does everything that needs to be done to get it running.

More information on the official Docker documentation : https://docs.docker.com/compose/

## How do you use this image ? ##

**Interactive and basic mode :**

Just run it as a normal command, sharing the directory containing your docker-compose.yml file and the Docker Unix socket :

    docker run -v "$(pwd)":/app -v /var/run/docker.sock:/var/run/docker.sock -ti dduportal/docker-compose:latest --help

**Customize the Docker socket**

When using another socket than the default Unix one, you can provide the path to docker-compose thru DOCKER_HOST environment variable.
In this example, we'll call docker-compose non-interactively (from a bash script for example), given that the Docker daemon listen thru a TCP connexion at 10.0.2.15:2375 :

    docker run -v "$(pwd)":/app -e DOCKER_HOST=tcp://10.0.2.15:2375 dduportal/docker-compose:latest up -d

**Convenience mode :**

If you don't want to repeat yourself by typing all the options each time, just add an aliase (interactive or in your .profile/.ashrc/etc :

	alias docker-compose="docker run -v \"\$(pwd)\":/app ... dduportal/docker-compose:latest"

**Customize image from your custom Dockerfile**

If the image doesn't fit your needs "as it", you can customize it thru a Dockerfile, for example :

    FROM dduportal/docker-compose:latest
    MAINTAINER your.mail@here
    
    ADD . /app/ # your docker-compose.yml can be copied inside the image
    ENV DOCKER_HOST tcp://192.168.0.1:2375 # Customize the docker socket
    
    # Your custom stuff here if needed

Note that ENTRYPOINT will be herited.

Run it now (without option while you provide them inside the image instead of at run time ) :

    docker build -t you/docker-compose ./
    docker run -ti you/docker-compose ps

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


Finnaly, open the Pull Request : CircleCi will automatically build and test for you
