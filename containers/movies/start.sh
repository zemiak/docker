#!/bin/sh

export JAVA_HOME=/opt/jdk
export PATH=$PATH:/opt/jdk/bin

dpkg-reconfigure ntp
service postfix start
service ssh start
service ntp start

# Wildfly Application Server with the movies application
/opt/wildfly/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0 &

# Plex Application Server
if [ ! -f /config/CONFIGURED ]
then
    mkdir -p "/config/Library/Application Support/Plex Media Server/"
    mkdir -p "/data/TV Shows" /data/Movies /data/Music
    cp /opt/Preferences.xml "/config/Library/Application Support/Plex Media Server/"
fi

/usr/sbin/start_pms >>/var/log/plex-media-server.log &

if [ ! -f /config/CONFIGURED ]
then
    sleep 16s
    curl -X POST -H 'Accept: application/json' \
        'http://127.0.0.1:32400/library/sections?type=movie&agent=com.plexapp.agents.imdb&scanner=Plex+Movie+Scanner&language=en&name=Movies&location=%2Fdata%2FMovies' \
        >/config/movies.json 2>/config/movies.errors
    curl -X POST -H 'Accept: application/json' \
        'http://127.0.0.1:32400/library/sections?type=artist&agent=com.plexapp.agents.lastfm&scanner=Plex+Music+Scanner&language=en&name=Music&location=%2Fdata%2FMusic' \
        >/config/music.json 2>/config/music.errors
    curl -X POST -H 'Accept: application/json' \
        'http://127.0.0.1:32400/library/sections?type=show&agent=com.plexapp.agents.thetvdb&scanner=Plex+Series+Scanner&language=en&name=TV+Shows&location=%2Fdata%2FTV%20Shows' \
        >/config/tvshows.json 2>/config/tvshows.errors
    curl -X POST -H 'Accept: application/json' \
        'http://127.0.0.1:32400/library/sections?type=photo&agent=com.plexapp.agents.none&scanner=Plex+Photo+Scanner&language=en&name=Photos&location=%2Fdata%2FPhotos' \
        >/config/photos.json 2>/config/photos.errors
    touch /config/CONFIGURED
fi

chown -R nobody.staff /data /config
chmod -R g+w /data /config

tail -f /var/log/plex-media-server.log
