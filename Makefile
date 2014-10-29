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
	./httpd.sh
stop-httpd:
	killall busybox
