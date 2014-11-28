build: run-httpd build-images stop-httpd
build-images: books jenkins movies podcasts shared-folders
install: build users net mail ssh-server user-packages user docker docker-images backup heartbeat

books:
	cd containers
	docker build books
	cd ..
jenkins:
	cd containers
	docker build jenkins
	cd ..
movies:
	cd containers/movies
	$(MAKE) build
	cd ..
	docker build movies
	cd ..
podcasts:
	cd containers
	docker build podcasts
	cd ..
shared-folders:
	cd containers
	docker build shared-folders
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
user-packages:
	cd local/user-packages
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
