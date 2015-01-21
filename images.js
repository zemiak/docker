#!/usr/bin/jjs

// build-images: books jenkins movies podcasts shared-folders

var Images = {
    image: function(container, version) {
        if (! version) {
            version = "1_0_0";
        }

        print("... building docker image " + container + ":" + version);
        CommandLineRunner.pushd("./containers/" + container);
	CommandLineRunner.executeNoError("docker stop " + container);
	CommandLineRunner.executeNoError("docker rm " + container);
        CommandLineRunner.execute("docker build --tag=" + container + ":" + version + " ./");
	CommandLineRunner.executeShell("run.sh");
        CommandLineRunner.popd();
    },

    movies: function() {
        var pathPrefix = "./containers/movies/";

        var file = new java.io.File(pathPrefix + "Dockerfile");
        if (file.exists()) {
            file.delete();
        }
        
        var dockerFiles = ["Intro", "SshServer", "Mail", "Database", "Backup", "Wildfly", "Player", "Outro"];
        var lines = new java.util.ArrayList(), dockerFile, dockerFileName;
        var utf8 = java.nio.charset.StandardCharsets.UTF_8;
        
        for (i in dockerFiles) {
            dockerFileName = pathPrefix + dockerFiles[i] + ".docker";
            dockerFile = java.nio.file.Paths.get(dockerFileName);
            lines.addAll(java.nio.file.Files.readAllLines(dockerFile, utf8));
        }
        
        dockerFile = java.nio.file.Paths.get(pathPrefix + "Dockerfile");
        java.nio.file.Files.write(dockerFile, lines, utf8);


        Images.image("movies");
    },

    all: function() {
	Images.movies();
	Images.image("jenkins");
        Images.image("books");
        Images.image("podcasts");
        Images.image("shared_folders");

	Images.waitForStart();
	Images.stop("shared_folders");
	Images.stop("podcasts");
	Images.stop("books");
	Images.stop("jenkins");
	Images.stop("movies");
    },

    waitForStart: function() {
	CommandLineRunner.execute("sleep 5");
    },

    stop: function(image) {
	CommandLineRunner.execute("docker stop " + image);
    }
};
