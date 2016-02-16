#!/usr/bin/jjs

Services.docker_run = function() {
    CommandLineRunner.executeShell("install.sh");
};
