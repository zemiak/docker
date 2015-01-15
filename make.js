build-images: books jenkins movies podcasts shared-folders
install: debian-check httpd-check mount-shares run-httpd jdk users net docker build-images mail ssh-server packages docker-images heartbeat backup stop-httpd

books:
	cd containers/books
	docker build -t "books:1_0_0" .
	cd ..
jenkins:
	cd containers/jenkins
	docker build -t "jenkins:1_0_0" .
	cd ..
movies:
	cd containers/movies
	$(MAKE) build
	cd ..
	docker build -t "movies:1_0_0" .
	cd ..
podcasts:
	cd containers/podcasts
	docker build -t "podcasts:1_0_0" .
	cd ..
shared-folders:
	cd containers/shared-folders
	docker build -t "shared-folders:1_0_0" .
	cd ..

run-httpd:
	sh bin/httpd-start.sh
stop-httpd:
	sh bin/httpd-stop.sh

docker-images:
	cd local/docker-images
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

backup:
	cd local/backup
	sh install.sh
	cd ../../

mount-shares:
	cd local/net
	sh mount-shares.sh
	cd ../../

jdk:
	cd local/jdk
	sh install.sh
	cd ../../

debian-check:
	# We need Debian GNU/Linux
	test -f /etc/debian_version || exit 1

httpd-check:
	sh bin/httpd-start.sh || exit 2
	sh bin/httpd-stop.sh
