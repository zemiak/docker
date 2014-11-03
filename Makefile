build: run-httpd build-images stop-httpd
build-images: books jenkins movies-images movies-db movies podcasts
install: build users mail ssh-server user-packages user docker docker-images backup mount-shares mac-server heartbeat

books:
	cd containers
	docker build books
	cd ..
jenkins:
	cd containers
	docker build jenkins
	cd ..
movies-images:
	cd containers
	docker build movies-images
	cd ..
movies-db:
	cd containers
	docker build movies-db
	cd ..
movies:
	cd containers
	docker build movies
	cd ..
podcasts:
	cd containers
	docker build podcasts
	cd ..

run-httpd:
	bin/httpd-start.sh
stop-httpd:
	bin/httpd-stop.sh

docker-images:
	sh local/docker-images/install.sh
backup:
	sh local/backup/install.sh
mac-server:
	sh local/mac-server/install.sh
docker:
	sh local/docker/install.sh
user-packages:
	sh local/user-packages/install.sh
users:
	sh local/users/install.sh
mount-shares:
	sh local/mount-shares/install.sh
ssh-server:
	sh local/ssh-server/install.sh
heartbeat:
	sh local/heartbeat/install.sh
mail:
	sh local/mail/install.sh
