#!/usr/bin/jjs

Services.heartbeat_run = function() {
    CommandLineRunner.executeShell("install.sh");
};
