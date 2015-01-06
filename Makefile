build: run-httpd build-images stop-httpd
build-images: books jenkins movies podcasts shared-folders
install: debian-check httpd-check jdk build users net mail ssh-server packages users docker docker-images backup heartbeat

books:
	cd containers
	docker build -t "books:1_0_0" books
	cd ..
jenkins:
	cd containers
	docker build -t "jenkins:1_0_0" jenkins
	cd ..
movies:
	cd containers/movies
	$(MAKE) build
	cd ..
	docker build -t "movies:1_0_0" movies
	cd ..
podcasts:
	cd containers
	docker build -t "podcasts:1_0_0" podcasts
	cd ..
shared-folders:
	cd containers
	docker build -t "shared-folders:1_0_0" shared-folders
	cd ..

run-httpd:
	bin/httpd-start.sh
stop-httpd:
	bin/httpd-stop.sh

docker-images:
	cd local/docker-images
	sh install.sh
	cd ../../
backup:
	cd local/backup
	sh install.sh
	cd ../../
docker:
	cd local/docker
	sh install.sh
	cd ../../
packages:
	cd local/packages
	sh install.sh
	cd ../../
users:
	cd local/users
	sh install.sh
	cd ../../
ssh-server:
	cd local/ssh-server
	sh install.sh
	cd ../../
heartbeat:
	cd local/heartbeat
	sh install.sh
	cd ../../
mail:
	cd local/mail
	sh install.sh
	cd ../../
net:
	cd local/net
	sh install.sh
	cd ../../
jdk:
	bin/httpd-start.sh
	cd local/jdk
	sh install.sh
	cd ../../
	bin/httpd-stop.sh

debian-check:
	# We need Debian GNU/Linux
	test -f /etc/debian_version || exit 1

httpd-check:
	bin/httpd-start.sh || exit 2
	bin/httpd-stop.sh
