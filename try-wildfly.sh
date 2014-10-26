#!/bin/bash

DIR="`pwd`"
cd tries

echo "Killing Java processes"
killall java

echo "Running Wildfly"
test -d wildfly-8.1.0.Final && rm -rf wildfly-8.1.0.Final
tar -xzf wildfly-8.1.0.Final.tar.gz
cd wildfly-8.1.0.Final
export JBOSS_HOME="`pwd`"
bin/standalone.sh &

echo "Running Setup"
cd ~/Documents/projects/movies/setup/wildfly
bash setup.sh prod
cd "$DIR"
