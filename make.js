#!/usr/bin/jjs


load("command-line.js");
load("local-services.js");
load("images.js");

Services.checkDebian();
Services.run("mount_points");
Services.run("users");
Services.run("net");
Services.run("docker");
Services.run("mail");
Services.run("ssh_server");
Services.run("packages");
Services.run("heartbeat")
Services.run("backup");
Services.run("ntp");
Images.all();
Services.run("docker_images");
Services.checkTimeMachine();
Services.passwords();
