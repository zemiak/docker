#!/usr/bin/jjs

var CommandLineRunner = {
    folders: [],

    executeShell: function(script) {
        CommandLineRunner.execute("sh " + script);
    },

    pushd: function(folder) {
        CommandLineRunner.folders.push($ENW.PWD);
        $ENV.PWD = folder;
    },

    popd: function() {
        $ENV.PWD = CommandLineRunner.folders.pop();
    },

    execute: function(command) {
        $EXEC(command);
        if ($EXIT != 0) {
            print($ERR);
            throw "Error code " + $EXIT + " in " + command;
        }
    }
};

load("local-services.js");
load("images.js");

Services.checkDebian();
Services.run("mount_points");
Services.run("users");
Services.run("net");
Services.run("users");
Services.run("net");
Services.run("docker");
Services.run("mail");
Services.run("ssh_server");
Services.run("packages");
Services.run("heartbeat");
Services.run("backup");
Images.all();
Services.run("docker_images");
