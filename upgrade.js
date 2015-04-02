#!/usr/bin/jjs -scripting

load("command-line.js");
load("images.js");

function usage() {
    throw "Usage: jjs upgrade.js -- <imageName> [imageVersion]";
}

function main(argv) {
    if (argv.length == 0 || argv.length > 2) {
	usage();
	return;
    }

    var imageName = argv[0].trim().toLowerCase();
    if (! Images.IMAGES.hasOwnProperty(imageName)) {
	throw "Unknown image name: " + imageName;
    }

    var imageVersion = arguments.length == 1 ? Images.IMAGES[imageName] : arguments[1].trim();

    print("Stopping ${imageName} ...");
    CommandLineRunner.executeNoError("docker stop movies");

    print("Building ${imageName}:${imageVersion} ...");
    Images.image(imageName, imageVersion);

    print("Done. Image ${imageName}:${imageVersion} has been started.");
}

main(arguments);
