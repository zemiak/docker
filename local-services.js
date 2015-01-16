#!/usr/bin/jjs

var Services = {
    service: function(name) {
        var methodName = name + "_run";

        load("local/" + name + "/install.js");

        CommandLineRunner.pushd("local/" + name);
        Services[methodName]();
        CommandLineRunner.popd();
    },

    checkDebian: function() {
        var file = java.io.File("/etc/debian_version");
        if (!file.exists()) {
            throw "This is not a Debian GNU/Linux system";
        }
    }
};
