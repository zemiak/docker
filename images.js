#!/usr/bin/jjs

// build-images: books jenkins movies podcasts shared-folders

var Images = {
    IMAGES: {
	"movies": "2_0_9",
	"books": "1_0_0",
	"podcasts": "1_0_0",
	"shared_folders": "1_0_0",
	"proxy": "1_0_0",
	"sonarqube": "1_0_0",
	"jenkins": "1_0_3"
    },

    getImageNames: function() {
	var members = [];
	for (var member in Images.IMAGES) {
	    members.push(member);
	}

	return members;
    },

    image: function(container, version) {
        print("... building docker image " + container + ":" + version);
        CommandLineRunner.pushd("./containers/" + container);
	CommandLineRunner.executeNoError("docker stop " + container);
	CommandLineRunner.executeNoError("docker rm " + container);
        CommandLineRunner.execute("docker build --tag=" + container + ":" + version + " ./");
	CommandLineRunner.executeShell("run.sh " + version);
        CommandLineRunner.popd();
    },

    all: function() {
	for (var imageName in Images.getImageNames()) {
	    Images.image(imageName, Images.IMAGES[imageName]);
	}

	Images.waitForStart();

	for (var imageName in Images.getImageNames().reverse()) {
	    Images.stop(imageName);
	}
    },

    waitForStart: function() {
	CommandLineRunner.execute("sleep 5");
    },

    stop: function(image) {
	CommandLineRunner.execute("docker stop " + image);
    }
};
