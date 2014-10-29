all: clean build
clean:
	# pass
build: run-httpd data-books books data-jenkins-home jenkins data-mac-server mac-server data-movies-images movies-images data-movies-db movies-db movies podcasts stop-httpd
data-books:
	cd containers
	docker build data-books
	cd ..
books:
	cd containers
	docker build books
	cd ..
data-jenkins-home:
	cd containers
	docker build data-jenkins-home
	cd ..
jenkins:
	cd containers
	docker build jenkins
	cd ..
data-mac-server:
	cd containers
	docker build data-mac-server
	cd ..
mac-server:
	cd containers
	docker build mac-server
	cd ..
data-movies-images:
	cd containers
	docker build data-movies-images
	cd ..
movies-images:
	cd containers
	docker build movies-images
	cd ..
data-movies-db:
	cd containers
	docker build data-movies-db
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
	killall python
