#!/usr/bin/jjs

var Services = {
    debianVersion: null,
    
    run: function(name) {
        var methodName = name + "_run";

        load("local/" + name + "/install.js");

        print("... local service " + name);
        CommandLineRunner.pushd("local/" + name);
        Services[methodName]();
        CommandLineRunner.popd();
    },

    checkDebian: function() {
        var debianVersionFileName = "/etc/debian_version";
        var file = new java.io.File(debianVersionFileName);
        if (!file.exists()) {
            throw "This is not a Debian GNU/Linux system";
        }
        
        filePath = java.nio.file.Paths.get(debianVersionFileName);
        lines = java.nio.file.Files.readAllLines(dockerFile, utf8)
        for (i in lines) {
            var line = lines[i];
            if (line != "") {
                ver = line.trim();
                if (ver.startsWith("7")) {
                    Services.debianVersion = 7;
                } else {
                    Services.debianVersion = 8;
                }
                
                break;
            }
        }
        
        if (Services.debianVersion === null) {
            throw "Unknown Debian GNU/Linux system. Supporting v7 and v8";
        }
    },
    
    checkTimeMachine: function() {
        CommandLineRunner.execute("mount");
        
        if (!$OUT.indexOf("timemachine") < 0) {
            print("WARNING: no Time Machine volumes mounted");
        }
    },
    
    passwords: function() {
        print("WARNING: change root and vasko passwords (now: docker) !!!")
    }
};
