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

    all: function() {
	Images.image("movies");
	Images.image("jenkins");
        Images.image("books");
        Images.image("podcasts");
        Images.image("shared_folders");
	Images.image("proxy");

	Images.waitForStart();

	Images.stop("proxy");
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
