clean:
	rm Dockerfile

Dockerfile: *.docker
	cat Intro.docker SshServer.docker Mail.docker Database.docker Backup.docker Wildfly.docker Player.docker Outro.docker >Dockerfile

build: Dockerfile
all: clean build
