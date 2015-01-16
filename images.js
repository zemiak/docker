#!/usr/bin/jjs

// build-images: books jenkins movies podcasts shared-folders

var Images = {
    image: function(container, version) {
        if (! version) {
            version = "1_0";
        }

        print("... building docker image " + container + ":" + version);
        CommandLineRunner.pushd("./containers/" + container);
        CommandLineRunner.executeShell("docker build . --tag=" + container + ":" + version);
        CommandLineRunner.popd();
    },

    books: function() {
        image("books");
    },

    jenkins: function() {
        image("jenkins");
    },

    movies: function() {
        CommandLineRunner.pushd("./containers/movies");

        var file = java.io.File("Dockerfile");
        if (file.exists()) {
            file.remove();
        }

        CommandLineRunner.execute("cat Intro.docker SshServer.docker Mail.docker Database.docker Backup.docker Wildfly.docker Player.docker Outro.docker >Dockerfile");
        CommandLineRunner.popd();

        image("movies");
    },

    podcasts: function() {
        image("podcasts");
    },

    shared_folders: function() {
        image("shared_folders");
    },

    all: function() {
        Images.books();
        Images.jenkins();
        Images.movies();
        Images.podcasts();
        Images.shared_folders();
    }
};
