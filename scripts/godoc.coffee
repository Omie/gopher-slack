# Description:
#   Golang's functions reference.
#
# Dependencies:
#   "cheerio": ""
#
# Configuration:
#   None
#
# Commands:
#   hubot godoc for <package> <function> - Shows Go stdlib function information.
#
# Authors:
#   Omie, omkarnath.me
#

module.exports = (robot) ->
    robot.respond /godoc (.*) (.*)$/i, (msg) ->
        pac = msg.match[1]
        fun = msg.match[2]
        url = "https://godoc.org/" + pac.replace(/[_-]+/,"-") + "#" + fun.replace(/[_-]+/,"-")
        msg.http(url)
        .get() (err, res, body) ->
            $ = require("cheerio").load(body)
            doctext = $("##{fun}").nextUntil('h3').text()
            if doctext
              msg.send "#{doctext}"
            else
              msg.send "Not found."
