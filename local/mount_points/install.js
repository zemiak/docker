#!/usr/bin/jjs

Services.mount_points_run = function() {
    CommandLineRunner.executeShell("install.sh");
};
