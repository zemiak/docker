#!/bin/sh

dpkg-reconfigure ntp
service postfix start
service ssh start

cd /opt/plexconnect
python ./PlexConnect.py >>/var/log/appletv-plex-connect.log &

if [ ! -f /data/CONFIGURED ]
then
    mv /tmp/Preferences.xml "/mnt/plex/config/Library/Application Support/Plex Media Server/"
fi

/usr/sbin/start_pms >>/var/log/plex-media-server.log &

if [ ! -f /data/CONFIGURED ]
then
    sleep 4s
    curl -X POST -H 'Accept: application/json' \
        'http://127.0.0.1:32400/library/sections?type=movie&agent=com.plexapp.agents.imdb&scanner=Plex+Movie+Scanner&language=en&name=Movies&location=%2Fdata%2FMovies' \
        >/data/movies.json
    curl -X POST -H 'Accept: application/json' \
        'http://127.0.0.1:32400/library/sections?type=artist&agent=com.plexapp.agents.lastfm&scanner=Plex+Music+Scanner&language=en&name=Music&location=%2Fdata%2FMusic' \
        >/data/music.json
    curl -X POST -H 'Accept: application/json' \
        'http://127.0.0.1:32400/library/sections?type=show&agent=com.plexapp.agents.thetvdb&scanner=Plex+Series+Scanner&language=en&name=TV+Shows&location=%2Fdata%2FTV%20Shows' \
        >/data/tvshows.json
    touch /data/CONFIGURED
fi

chown -R nobody.staff /data
chmod -R g+w /data

tail -f /var/log/plex-media-server.log
