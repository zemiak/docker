clean:
	rm Dockerfile

Dockerfile: *.docker
	cat Intro.docker SshServer.docker Mail.docker Database.docker Player.docker Wildfly.docker Outro.docker >Dockerfile

build: Dockerfile
all: clean build
