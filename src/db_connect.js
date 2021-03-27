const Pool = require("pg").Pool;
//access dictionary value for Pool key
//in the pg library

//can install pg library with the following command:
// $ npm install --save pg

//pg library is a library that we installed
//we use require("<library name>") to get the information from
//the library
//in this case we are pulling the Pool object?

const pool = new Pool({
  user: "postgres", //username for postgres database
  password: "<password>", //password for postgres database

  host: "localhost", //our host
  port: 5432, //port of the host


  database: "meditrack_db" //the database we will be working wit
});

//export the pool
Object.assign(module.exports, {
    pool
  });