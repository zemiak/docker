#!/usr/bin/jjs

IMAGES = ["books", "jenkins", "movies", "podcasts", "shared_folders", "proxy"];
DOCKER = "/usr/bin/docker";

CommandLineRunner = {
    folders: [],

    pushd: function(folder) {
        CommandLineRunner.folders.push($ENV.PWD);
        $ENV.PWD = folder;
    },

    popd: function() {
        $ENV.PWD = CommandLineRunner.folders.pop();
    },

    execute: function(command) {
        $EXEC(command);
        if ($EXIT != 0) {
            print($OUT);
            print($ERR);
            throw "Error code " + $EXIT + " in " + command + " (" + $ENV.PWD + ")";
        }
    },
    
    executeNoThrow: function(command) {
        $EXEC(command);
        return $EXIT == 0;
    }
};

var Runner = {
    start: function() {
        print("Starting docker_images:");
        for (i in IMAGES) {
            var image = IMAGES[i];
            CommandLineRunner.execute(DOCKER + " start " + image);
            print("  " + image);
        }
        print("done.");
    },

    status: function() {
        var nope = false;
        for (i in IMAGES.reverse()) {
            var image = IMAGES[i];
            if (! CommandLineRunner.executeNoThrow(DOCKER + " top " + image)) {
                print("Docker_images: " + image + " is not running");
                nope = true;
            }
        }

        return !nope;
    },

    stop: function() {
        print("Starting docker_images:");
        for (i in IMAGES.reverse()) {
            var image = IMAGES[i];
            CommandLineRunner.execute(DOCKER + " stop " + image);
            print ("  " + image);
        }
        print("done.");
    }
};

if (arguments.length == 0) {
    throw "jjs docker_images.js -- (start|stop|restart|force-reload)";
}

switch (arguments[0].trim()) {
    case "start":
        Runner.start();
        break;
    case "stop":
        Runner.stop();
        break;
    case "restart":
        Runner.stop();
        Runner.start();
        break;
    case "force-reload":
        Runner.stop();
        Runner.start();
        break;
    default:
        throw "Unknown command-line option " + arguments[0].trim();
}
