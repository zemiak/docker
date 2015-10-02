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
sleep 4s
if [ ! -f /data/CONFIGURED ]
then
    curl -X POST 'http://127.0.0.1:32400/library/sections?type=movie&agent=com.plexapp.agents.imdb&scanner=Plex+Movie+Scanner&language=en&name=Movies&location=%2Fdata%2FMovies' >/data/MOVIES_CREATED
    curl -X POST 'http://127.0.0.1:32400/library/sections?type=artist&agent=com.plexapp.agents.lastfm&scanner=Plex+Music+Scanner&language=en&name=Music&location=%2Fdata%2FMusic' >/data/MUSIC_CREATED
    curl -X POST 'http://127.0.0.1:32400/library/sections?type=photo&agent=com.plexapp.agents.none&scanner=Plex+Photo+Scanner&language=xn&name=Photos&location=%2Fdata%2FPictures' >/data/PHOTOS_CREATED
    curl -X POST 'http://127.0.0.1:32400/library/sections?type=show&agent=com.plexapp.agents.thetvdb&scanner=Plex+Series+Scanner&language=en&name=TV+Shows&location=%2Fdata%2FTVShows' >/data/TVSHOWSH_CREATED
    curl -X POST 'http://127.0.0.1:32400/library/sections?type=movie&agent=com.plexapp.agents.none&scanner=Plex+Video+Files+Scanner&language=xn&name=Home+Videos&location=%2Fdata%2FHomeVideos' >/data/HOMEVIDEOS_CREATED
    touch /data/CONFIGURED
fi
