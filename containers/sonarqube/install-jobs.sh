#!/bin/sh

service mysql start
/opt/sonarqube/bin/linux-x86-64/sonar.sh console &
sleep 20s

curl -u admin:admin -data='{}' -X POST "http://localhost:9000/api/projects/create?key=org.zemiak.movies:movies&name=movies"
curl -u admin:admin -data='{}' -X POST "http://localhost:9000/api/projects/create?key=org.zemiak.online:online&name=online"

killall java
service mysql stop
