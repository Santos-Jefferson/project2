//setting express
var express = require('express');
var app = express();

//webserver
app.set('port', (process.env.PORT || 5000));

app.use(express.static(__dirname + '/public'));

//folder with main pages
app.set('views', __dirname + '/views');

//set the view engine to ejs
app.set('view engine', 'ejs')

//home page
app.get('/', function(req, res){
	res.render('home');
});

app.listen(app.get('port'), function(){
	console.log('Node app is running on port', app.get('port'));
});

