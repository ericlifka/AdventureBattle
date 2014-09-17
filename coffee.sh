#!/bin/sh

# coffee-script is depracating the --join param, which is annoying because the replacements are much heavier weight
coffee --join app.js --output server/static --map --watch --compile client/