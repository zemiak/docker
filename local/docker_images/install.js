#!/usr/bin/jjs

Services.docker_images_run = function() {
    print("... installing docker_images start script");
    
    CommandLineRunner.execute("cp docker-images.service /lib/systemd/system/");
    CommandLineRunner.execute("systemctl daemon-reload");
    CommandLineRunner.execute("systemctl enable docker-images");
    CommandLineRunner.execute("mkdir -p /etc/docker-images /opt/docker-images");
    CommandLineRunner.execute("cp docker-images.conf /etc/docker-images/");
    CommandLineRunner.execute("cp start-docker-images.sh /opt/docker-images/");
};
