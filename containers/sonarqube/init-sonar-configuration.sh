#!/bin/sh

curl -u admin:admin -data='{}' -X POST "http://localhost:9000/api/projects/create?key=org.zemiak.movies:movies&name=movies"
curl -u admin:admin -data='{}' -X POST "http://localhost:9000/api/projects/create?key=org.zemiak.online:online&name=online"
