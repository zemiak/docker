FROM debian:wheezy
RUN echo "deb http://http.debian.net/debian/ wheezy-backports main contrib" >>/etc/apt/sources.list
RUN apt-get update
RUN apt-get install -yq linux-headers-$(uname -r|sed 's,[^-]*-[^-]*-,,')
RUN apt-get -yq -t wheezy-backports install virtualbox

ENV http_proxy ""
ADD http://127.0.0.1:8000/mac-server/files.tar.gz /var/lib/virtualbox/
WORKDIR /var/lib/virtualbox
RUN tar -xzf files.tar.gz && rm -f files.tar.gz

# exporting, so it can be backed up
VOLUMES /var/lib/virtualbox

RUN VBoxManage registervm /var/lib/virtualbox/MacServer.vbox

CMD VBoxHeadless --startvm MacServer && bash
