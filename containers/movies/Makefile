clean:
	rm Dockerfile

Dockerfile: *.docker
	cat Intro.docker Database.docker Player.docker Wildfly.docker Mail.docker SshServer.docker Outro.docker >Dockerfile

build: Dockerfile
all: clean build
