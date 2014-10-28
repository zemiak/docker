#!/bin/sh

docker run -d --name=data-books data-books
docker run -d --name=books --volumes-from=data-books books

docker run -d --name=data-jenkins-home data-jenkins-home
docker run -d --name=jenkins --volumes-from=data-jenkins-home jenkins

docker run -d --name=data-mac-server data-mac-server
docker run -d --name=mac-server --volumes-from=data-mac-server mac-server

docker run -d --name=data-movies-db data-movies-db
docker run -d --name=movies-db --volumes-from=data-movies-db movies-db

docker run -d --name=data-movies-image data-movies-images
docker run -d --name=movies-image --volumes-from=data-movies-image --link=movies-db:movies-db movies-images

docker run -d --name=movies --link=movies-db:movies-db --link=movies-image:movies-image movies

docker run -d --name=podcasts podcasts
