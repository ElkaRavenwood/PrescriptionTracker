//index.js for setting up the database and api calls

const express = require('express');
//importing the express library

const pool = require('./db_connect').pool; //pool object


const { routes } = require('./routes');
//get the routes object from the routes directory in current directory

const router = express.Router();
//get an express router object


// API FUNCTIONS
const objId = 'mediDB'


router.get('/', function (req, res) {
  res.send('Backend is up!')
});


routes(router); // what is this?

Object.assign(module.exports, {
  router,
});