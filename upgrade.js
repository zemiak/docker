#!/usr/bin/jjs -scripting

load("command-line.js");
load("images.js");

function usage() {
    throw "Usage: jjs upgrade.js <imageName> [imageVersion]";
}

function main() {
    if (arguments.length == 0 || arguments.length > 2) {
	usage();
    }

    var imageName = arguments[0].trim().toLowerCase();
    if (! Images.IMAGES.hasOwnProperty(imageName)) {
	throw "Unknown image name: " + imageName;
    }

    var imageVersion = arguments.length == 1 ? Images.IMAGES[imageName] : arguments[1].trim();

    print("Stopping ${imageName} ...");
    Images.stop(imageName);

    print("Building ${imageName}:${imageVersion} ...");
    Images.image(imageName, imageVersion);

    print("Done. Image ${imageName}:${imageVersion} has been started.");
}

main();
