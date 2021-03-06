#!/usr/bin/jjs -scripting

var Thread            = java.lang.Thread;
var ServerSocket      = java.net.ServerSocket;
var PrintWriter       = java.io.PrintWriter;
var InputStreamReader = java.io.InputStreamReader;
var BufferedReader    = java.io.BufferedReader;
var FileInputStream   = java.io.FileInputStream;
var ByteArray         = Java.type("byte[]");

var PORT = 8000;
var CRLF = "\r\n";
var FOUROHFOUR = "<HTML>"
+ "    <HEAD>"
+ "        <TITLE>404 Not Found</TITLE>"
+ "    </HEAD>"
+ "    <BODY>"
+ "        <P>404 Not Found</P>"
+ "    </BODY>"
+ "</HTML>";

var serverSocket = new ServerSocket(PORT);

while (true) {
    var socket = serverSocket.accept();

    try {
        var thread = new Thread(function() { httpRequestHandler(socket); });
        thread.start();
        Thread.sleep(100);
    } catch (e) {
        print(e);
    }
}

function httpRequestHandler(socket) {
    var out       = socket.getOutputStream();
    var output    = new PrintWriter(out);
    var inReader  = new InputStreamReader(socket.getInputStream(), 'utf-8');
    var bufReader = new BufferedReader(inReader);

    var lines = readLines(bufReader);

    if (lines.length > 0) {
        var header = lines[0].split(/\b\s+/);

        if (header[0] == "GET") {
            var URI = header[1].split(/\?/);
            var path = String("/mnt/media/docker-data" + URI[0]);

            try {
                sendFile(output, out, path);
            } catch (e) {
                respond(output, "HTTP/1.0 404 Not Found", "text/html", FOUROHFOUR);
            }
        }
    }

    output.flush();
    bufReader.close();
    socket.close();
}

function respond(output, status, type, body) {
    sendBytes(output, status + CRLF);
    sendBytes(output, "Server: Simple Nashorn HTTP Server" + CRLF);
    sendBytes(output, "Content-type: ${type}" + CRLF);
    sendBytes(output, "Content-Length: ${body.length}" + CRLF);
    sendBytes(output, CRLF);
    sendBytes(output, body);
}

function contentType(path) {
    if (path.endsWith(".htm") ||
        path.endsWith(".html")) {
      return "text/html";
    } else if (path.endsWith(".txt")) {
      return "text/text";
    } else if (path.endsWith(".jpg") ||
               path.endsWith(".jpeg")) {
      return "image/jpeg";
    } else if (path.endsWith(".gif")) {
      return "image/gif";
    } else {
      return "application/octet-stream";
    }
}

function readLines(bufReader) {
    var lines = [];

    try {
        var line;
        while (line = bufReader.readLine()) {
            lines.push(line);
        }
    } catch (e) {
    }

    return lines;
}

function sendBytes(output, line) {
    output.write(String(line));
}

function sendFile(output, out, path) {
    var file = new FileInputStream(path);

    var type = contentType(path);
    sendBytes(output, "HTTP/1.0 200 OK" + CRLF);
    sendBytes(output, "Server: Simple Nashorn HTTP Server" + CRLF);
    sendBytes(output, "Content-type: ${contentType(path)}" + CRLF);
    sendBytes(output, "Content-Length: ${file.available()}" + CRLF);
    sendBytes(output, CRLF);
    output.flush();

    var buffer = new ByteArray(1024);
    var bytes = 0;

    while ((bytes = file.read(buffer)) != -1) {
        out.write(buffer, 0, bytes);
    }
}
