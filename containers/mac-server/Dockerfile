FROM debian:wheezy
RUN echo "deb http://http.debian.net/debian/ wheezy-backports main contrib" >>/etc/apt/sources.list
RUN apt-get update
RUN apt-get install -yq linux-headers-$(uname -r|sed 's,[^-]*-[^-]*-,,')
RUN apt-get -yq -t wheezy-backports install virtualbox
... RUN VBoxManage --registervm /var/lib/virtualbox/mac-server.local
... RUN VBoxHeadless --startvm mac-server.local
