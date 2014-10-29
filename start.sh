#!/bin/sh

# books/calibre: 8081
# jenkins: 8082
# movies/wildfly: 8080
# podcasts/apache: 8083
# mac-server: gets its own IP with ports exposed

docker run -d -p 8081:80 --name=books books
docker run -d -p 8082:8080 --name=jenkins jenkins
docker run -d --name=mac-server mac-server
docker run -d --name=movies-db movies-db
docker run -d --name=movies-image --link=movies-db:movies-db movies-images
docker run -d -p 8080:8080 --name=movies --link=movies-db:movies-db --link=movies-image:movies-image --volumes-from=movies-image movies
docker run -d -d -p 8083:80 --name=podcasts podcasts
