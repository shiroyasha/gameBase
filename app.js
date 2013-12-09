var express = require('express');
var app     = express();


app.use( express.static( __dirname + '/public') );

/*app.get('/', function(req, res) {
	res.send(200, 'hello');
});*/

app.listen(3000);