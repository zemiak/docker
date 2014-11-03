all: clean build
clean:
	# pass
build: run-httpd books jenkins mac-server movies-images movies-db movies podcasts stop-httpd
books:
	cd containers
	docker build books
	cd ..
jenkins:
	cd containers
	docker build jenkins
	cd ..
mac-server:
	cd containers
	docker build mac-server
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
install: build mount-shares
	cp bin/docker-images-zemiak /etc/init.d/
	chmod +x /etc/init.d/docker-images-zemiak
	/usr/sbin/update-rc.d docker-images-zemiak defaults 71
mount-shares:
	chmod +x bin/mount-shares.sh
	cat /etc/fstab | grep media || bin/mount-shares.sh
