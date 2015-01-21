#!/usr/bin/jjs

var Services = {
    run: function(name) {
        var methodName = name + "_run";

        load("local/" + name + "/install.js");

        print("... local service " + name);
        CommandLineRunner.pushd("local/" + name);
        Services[methodName]();
        CommandLineRunner.popd();
    },

    checkDebian: function() {
        var file = new java.io.File("/etc/debian_version");
        if (!file.exists()) {
            throw "This is not a Debian GNU/Linux system";
        }
    },
    
    checkTimeMachine: function() {
        CommandLineRunner.execute("mount");
        
        if (!$OUT.indexOf("timemachine") > -1) {
            print("WARNING: no Time Machine volumes mounted");
        }
    },
    
    passwords: function() {
        print("WARNING: change root and vasko passwords (now: docker) !!!")
    }
};
