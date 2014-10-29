#!/bin/sh

# books/calibre: 8081
# jenkins: 8082
# movies/wildfly: 8080
# podcasts/apache: 8083
# mac-server: gets its own IP with ports exposed

docker run -d --name=data-books data-books
docker run -d -p 8081:80 --name=books --volumes-from=data-books books

docker run -d --name=data-jenkins-home data-jenkins-home
docker run -d -p 8082:8080 --name=jenkins --volumes-from=data-jenkins-home jenkins

docker run -d --name=data-mac-server data-mac-server
docker run -d --name=mac-server --volumes-from=data-mac-server mac-server

docker run -d --name=data-movies-db data-movies-db
docker run -d --name=movies-db --volumes-from=data-movies-db movies-db

docker run -d --name=data-movies-image data-movies-images
docker run -d --name=movies-image --volumes-from=data-movies-image --link=movies-db:movies-db movies-images

docker run -d -p 8080:8080 --name=movies --link=movies-db:movies-db --link=movies-image:movies-image movies

docker run -d -d -p 8083:80 --name=podcasts podcasts
