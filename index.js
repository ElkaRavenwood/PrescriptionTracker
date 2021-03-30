const express = require('express');
const dotEnv = require('dotenv');

dotEnv.config();

const api = require('./src/api_calls'); //made change for supporting backend
const app = express();
const port = process.env.PORT || 8000;
app.use(express.json());

// backend
//api(app); //api is now a function with the different router calls
			// takes the app as argument input

// front end
app.use(express.static(`${__dirname}/prescription-tracker-client/build`));

app.listen(port, () => {
  console.log(`App is listening on port ${port}!`)
});
