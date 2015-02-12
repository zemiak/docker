#!/usr/bin/jjs

Services.docker_images_run = function() {
    print("... installing docker_images start script");
    
    // base support
    CommandLineRunner.execute("mkdir -p /opt/docker_images");
    CommandLineRunner.execute("pwd >/tmp/aa");
    CommandLineRunner.execute("cp docker_images.js /opt/docker_images/");
    
    if (Services.debianVersion === 7) {
        // Debian Wheezy (7.0) -- SysV init
        CommandLineRunner.execute("cp docker_images /etc/init.d/");
        CommandLineRunner.execute("chmod +x /etc/init.d/docker_images");
        CommandLineRunner.execute("/usr/sbin/update-rc.d docker_images defaults 71 >/dev/null");
    } else {
        // Debian Jessie (8.0) and later -- SystemD
        CommandLineRunner.execute("cp docker_images.service /etc/systemd/system/");
        CommandLineRunner.execute("systemctl enable docker_images >/dev/null");
    }
    
    // works both in SysV Init and SystemD
    CommandLineRunner.execute("service docker_images start");
};
