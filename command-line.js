#!/usr/bin/jjs

var CommandLineRunner = {
    folders: [],

    executeShell: function(script) {
        CommandLineRunner.execute("sh " + script);
    },

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

    executeNoError: function(command) {
	$EXEC(command);
	$EXIT = 0;
    }
};
