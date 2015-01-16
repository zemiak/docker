#!/usr/bin/jjs

Services.ssh_server_run = function() {
    CommandLineRunner.executeShell("install.sh");
};
