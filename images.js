#!/usr/bin/jjs

// build-images: books jenkins movies podcasts shared-folders

var Images = {
    image: function(container, version) {
        if (! version) {
            version = "1_0";
        }

        print("... building docker image " + container + ":" + version);
        CommandLineRunner.pushd("./containers/" + container);
        CommandLineRunner.execute("docker build . --tag=" + container + ":" + version);
	CommandLineRunner.executeShell("run.sh");
        CommandLineRunner.popd();
    },

    movies: function() {
        CommandLineRunner.pushd("./containers/movies");

        var file = java.io.File("Dockerfile");
        if (file.exists()) {
            file.remove();
        }

        CommandLineRunner.execute("cat Intro.docker SshServer.docker Mail.docker Database.docker Backup.docker Wildfly.docker Player.docker Outro.docker >Dockerfile");
        CommandLineRunner.popd();

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
