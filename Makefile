all: clean build
clean:
	# pass
build: run-httpd books jenkins movies-images movies-db movies podcasts stop-httpd
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
install-docker-start-script:
	cp bin/docker-images-zemiak /etc/init.d/
	chmod +x /etc/init.d/docker-images-zemiak
	/usr/sbin/update-rc.d docker-images-zemiak defaults 71
install-mount-shares:
	chmod +x bin/install-mount-shares.sh
	cat /etc/fstab | grep media || bin/install-mount-shares.sh
install-mac-server:
	chmod +x bin/install-mac-server.sh
	bin/install-mac-server.sh
	cp bin/mac-server /etc/init.d/
	chmod +x /etc/init.d/mac-server
	/usr/sbin/update-rc.d mac-server defaults 72
install: build install-mac-server
	cp bin/docker-images-zemiak /etc/init.d/
	chmod +x /etc/init.d/docker-images-zemiak
	/usr/sbin/update-rc.d docker-images-zemiak defaults 71
