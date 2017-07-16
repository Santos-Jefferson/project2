//setting express
var express = require('express');
var app = express();
var bodyParser = require('body-parser');
const { Pool, Client } = require('pg');

const pool = new Pool({
	user: 'postgres',
	host: 'process.env.DATABASE_URL',
	database: 'familyBudget',
	password: 'aaml0509',
	port: 5432,
});

const client = new Client({
	user: 'postgres',
	host: 'process.env.DATABASE_URL',
	database: 'familyBudget',
	password: 'aaml0509',
	port: 5432,
});

// We are going to use sessions
//var parseurl = require('parseurl')
var session = require('express-session')

// set up sessions
app.use(session({
  secret: 'my-super-secret-secret!',
  resave: false,
  saveUninitialized: true
}))

//connecting postgres
client.connect();

// Because we will be using post values, we need to include the body parser module
var bodyParser = require('body-parser')
app.use( bodyParser.json() );       // to support JSON-encoded bodies
app.use(bodyParser.urlencoded({     // to support URL-encoded bodies
  extended: true
}));


// This shows how to use a middleware function for all requests (it is defined below)
// Becuse it comes after the static function call, we won't see it log requests
// for the static pages, only the ones that continue on passed that (e.g., /logout)
app.use(logRequest);

// Setup our routes
app.post('/login', handleLogin);
app.post('/logout', handleLogout);


app.use(bodyParser.urlencoded({
	extended: true
}));

// Setup our routes
app.post('/login', handleLogin);
app.post('/logout', handleLogout);



/****************************************************************
 * These methods should likely be moved into a different module
 * But they are hear for ease in looking at the code
 ****************************************************************/

// Checks if the username and password match a hardcoded set
// If they do, put the username on the session
function handleLogin(request, response) {
	var result = {success: false};

	// We should do better error checking here to make sure the parameters are present
	if (request.body.username == "admin" && request.body.password == "admin") {
		request.session.user = request.body.username;
		result = {success: true};
				
	}
	response.json(result);
}

// If a user is currently stored on the session, removes it
function handleLogout(request, response) {
	var result = {success: false};

	// We should do better error checking here to make sure the parameters are present
	if (request.session.user) {
		request.session.destroy();
		result = {success: true};
	}

	response.json(result);
}

// This is a middleware function that we can use with any request
// to make sure the user is logged in.
function verifyLogin(request, response, next) {
	if (request.session.user) {
		// They are logged in!

		// pass things along to the next function
		next();
	} else {
		// They are not logged in
		// Send back an unauthorized status
		var result = {succes:false, message: "Access Denied"};
		response.status(401).json(result);
	}
}

// This middleware function simply logs the current request to the server
function logRequest(request, response, next) {
	console.log("Received a request for: " + request.url);

	// don't forget to call next() to allow the next parts of the pipeline to function
	next();
}

app.use(bodyParser.json());
app.post("/myaction", function (req, res){
	//variables coming from HTML FORM method POST
	var date = req.body.date;
	var amount = req.body.amount;
	var description = req.body.description;
	var category = req.body.category;
	
	//Inserting a data to database by string
	const queryInsert = 'INSERT INTO expense(date, amount, categoryid, description, familyid) VALUES($1, $2, $3, $4, $5)';
	const values = [date, amount, 1, description, 1];

	client.query(queryInsert, values, (err, res)=> {
		if (err)
		{
			console.log(err.stack)
		}
		else
		{
			console.log(res.rows[0])
		}
	});
	var query = client.query("SELECT * FROM family");
    query.on("row", function (row, result) { 
        result.addRow(res.rows); 
    });
	
    query.on("end", function (req, res){          
        //client.end();
        res.writeHead(200, {'Content-Type': 'text/plain'});
        res.write(JSON.stringify(result.rows[0], null, "    ") + "\n");
		res.end();  
    });
});


/*
client.query('SELECT $1::text as message', ['Hello world!'], (err, res) => {
	console.log(err ? err.stack : res.rows[0].message);
	client.end();
});
*/



const query = {
	name: 'fetch-family', 
	text: 'SELECT * FROM family WHERE familyid = $1', 
	values: [2]
}
client.query(query, (err, res) => {
	if (err){
		console.log(err.stack)
	} else {
		console.log(res.rows[0]);
	}
});




//webserver
app.set('port', (process.env.PORT || 5000));
app.use(express.static(__dirname + '/public'));

//folder with main pages
app.set('views', __dirname + '/views');

//set the view engine to ejs
app.set('view engine', 'ejs')

//login page
app.get('/', function(req, res){
	res.render('login');
});



//Users
//get all users
var pg = require('pg');
//var cnx = 'postgres://postgres:aaml0509@localhost:5432/familyBudget';

app.get('/getdata', function(req, res, next) {
  pg.connect(cnx, function(err, client, done) {
    if (err) {
      return console.error('error fetching client from pool', err);
    }
    console.log("connected to database");
    client.query('SELECT familyusername AS family, date, amount, description FROM family, expense WHERE family.familyid = expense.familyid', function(err, result) {
      done();
      if (err) {
        return console.error('error running query', err);
      }
      res.setHeader('content-type', 'application/json');
	  res.send(JSON.stringify(result.rows,null,2));
    });
  });
});


//home page
app.get('/home', function(req, res){
	res.render('home');
});

/*
//form (myaction)
app.get('/myaction', function(req, res){
	res.render('form');
});
*/

app.listen(app.get('port'), function(){
	console.log('Node app is running on port', app.get('port'));
});