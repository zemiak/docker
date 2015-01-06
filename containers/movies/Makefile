clean:
	rm Dockerfile

Dockerfile: Dockerfile.in *.docker
	cat Dockerfile.in Database.docker Player.docker Wildfly.docker Mail.docker Dockerfile.out >Dockerfile

build: Dockerfile
all: clean build
