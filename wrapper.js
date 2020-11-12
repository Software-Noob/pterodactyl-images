  
#!/usr/bin/env node

var startupCmd = "";
const fs = require("fs");
fs.writeFile("latest.log", "", (err) => {
    if (err) console.log("Callback error in appendFile:"+err);
});

var args = process.argv.splice(process.execArgv.length + 2);
for (var i = 0; i < args.length; i++) {
    if (i === args.length - 1) {
        startupCmd += args[i];
    } else {
        startupCmd += args[i] + " ";
    }
}

if (startupCmd.length < 1) {
    console.log("Error: Please specify a startup command.");
    process.exit();
}

var exec = require("child_process").exec;
console.log("Starting Rust...");
exec(startupCmd);

var waiting = true;

var poll = function( ) {
    function createPacket(command) {
        var packet = {
            Identifier: -1,
            Message: command,
            Name: "WebRcon"
        };
        return JSON.stringify(packet);
    }

    var serverHostname = "localhost";
    var serverPort = process.env.RCON_PORT;
    var serverPassword = process.env.RCON_PASS;
    var WebSocket = require("ws");
    var ws = new WebSocket("ws://" + serverHostname + ":" + serverPort + "/" + serverPassword);

    ws.on("open", function open() {
        waiting = false;
        process.stdin.resume();
        process.stdin.setEncoding("utf8");
        var util = require("util");

        // Hack to fix broken console output
        ws.send(createPacket('status'));

        process.stdin.on('data', function (text) {
            ws.send(createPacket(text));
        });
    });

    ws.on("message", function(data, flags) {
        try {
            var json = JSON.parse(data);
            if (json !== undefined) {
                if (json.Message !== undefined && json.Message.length > 0) {
                    console.log(json.Message);
                    const fs = require("fs");
                    fs.appendFile("latest.log", "\n" + json.Message, (err) => {
                        if (err) console.log("Callback error in appendFile:"+err);
                    });
                }
            } else {
                console.log("Error: Invalid JSON received");
            }
        } catch (e) {
            if (e) {
                console.log(e);
            }
        }
    });

    ws.on("error", function(err) {
        waiting = true;
        console.log("Waiting for RCON to come up...");
        setTimeout(poll, 5000);
    });

    ws.on("close", function() {
        if (!waiting) {
            console.log("Connection to server closed.");
            process.exit();
        }
    });
}
poll();
