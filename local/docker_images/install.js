#!/usr/bin/jjs

Services.docker_images_run = function() {
    CommandLineRunner.executeShell("install.sh");
};
