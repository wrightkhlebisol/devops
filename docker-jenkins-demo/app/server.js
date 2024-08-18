let express = require('express');
let path = require('path');
let fs = require('fs');
const { MongoClient } = require('mongodb');
let bodyParser = require('body-parser');
let cors = require('cors');
let app = express();

app.use(bodyParser.urlencoded({
  extended: true
}));
app.use(bodyParser.json());
app.use(cors())

app.get('/', function (req, res) {
  res.sendFile(path.join(__dirname, "index.html"));
});

app.get('/profile-picture', function (req, res) {
  let img = fs.readFileSync(path.join(__dirname, "images/profile-1.jpg"));
  res.writeHead(200, { 'Content-Type': 'image/jpg' });
  res.end(img, 'binary');
});

// use when starting application locally
let mongoUrlLocal = "mongodb://admin:password@localhost:27017";

// use when starting application as docker container
let mongoUrlDocker = "mongodb://admin:password@mongodb";

// pass these options to mongo client connect request to avoid DeprecationWarning for current Server Discovery and Monitoring engine
let mongoClientOptions = { useNewUrlParser: true, useUnifiedTopology: true };

const client = new MongoClient(mongoUrlLocal, mongoClientOptions);

// "user-account" in demo with docker. "my-db" in demo with docker-compose
let databaseName = "my-db";

app.post('/update-profile', async function (req, res) {

  let userObj = req.body;
  try {
    await client.connect();

    // await MongoClient.connect(mongoUrlLocal, mongoClientOptions, function (err, client) {
    //   if (err) throw err;
    let db = client.db(databaseName);
    userObj['userid'] = 1;

    let myquery = { userid: 1 };
    let newvalues = { $set: userObj };

    let response = db.collection("users").updateOne(myquery, newvalues, { upsert: true });
    if (!response)
      return res.send({
        error: "No record found"
      })
  } catch (error) {
    console.error(error);
  }

  // Send response
  res.send(userObj);
});

app.get('/get-profile', async function (req, res) {
  console.log(req.route);
  let response = {};
  try {
    await client.connect();

    // Connect to the db
    let db = client.db(databaseName);

    let myquery = { userid: 1 };

    let response = await db.collection("users").findOne(myquery)
    if (!response)
      return res.send({
        error: "No record found"
      })

    // Send response
    res.send(response ? response : {});
    // });
  } catch (error) {
    console.error(error);
  }
  finally {
    client.close();
  }
});

app.listen(3000, function () {
  console.log("app listening on port 3000!");
});

