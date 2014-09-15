var express = require('express');
var coffeeMiddleware = require('coffee-middleware');

var app = express();
app.use(coffeeMiddleware({
    src: __dirname + '/public'
}));
app.use(express.static(__dirname + '/public'));
app.listen(3000);

console.log('Listening on http://localhost:3000');
