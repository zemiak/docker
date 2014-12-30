test -d /opt/jdk && exit 0
apt-get -yq install wget
cd /opt
wget http://127.0.0.1:8000/repo/jdk-8u25-linux-x64.tar.gz
tar -xzf /opt/jdk-8u25-linux-x64.tar.gz && rm -f /opt/jdk-8u25-linux-x64.tar.gz
ln -s /opt/jdk1.8.0_25 /opt/jdk
ln -s /opt/jdk/bin/jjs /usr/local/bin/jjs

echo 'JAVA_HOME=/opt/jdk' >>/etc/bash.bashrc
echo 'PATH=$PATH:/opt/jdk/bin' >>/etc/bash.bashrc
