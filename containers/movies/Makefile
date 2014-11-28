Dockerfile: Dockerfile.in *.docker
  test -f Dockerfile && rm -f Dockerfile
  cat Dockerfile.in Database.docker Player.docker Wildfly.docker >Dockerfile

build: Dockerfile
all: build
