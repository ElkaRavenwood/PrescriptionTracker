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

//ADD USER/PHARM/PREC TO THE DATABASE -------------------------------------------------------------
router.post(`/${objId}/:addParm`, asynch(req,res) => {
	try{
		const { addParm } = req.params;

		switch(addParm){
			case '0':
				// new prescription to existing user and pharmacy
				const { user_id, pharm_id, rx_no} = req.body;
			break;

			case '1':
			break;

			case '2':
			break;

			default:
			break;
			
		}
	} catch(err){
		console.log(err);
	}

});

//GET ACTIVE PRESCRIPTIONS FOR A CURRENT USER ------------------------------------------
//result will be an array of prescription dictionaries
//dictionary contains prescription rxno, administered pharmacy, and status
router.get(`/${objId}/:user_id`, async (req, res) => { 
	try{
		//set up information needed for prescription call
		const { user_id } = req.params; //get the user id from request parameters
		//const user_id = parseInt(user_id_text,10);

		//make call to the database
		//will return a json text of active prescriptions with their prescription ID
		const queryOut = await pool.query(
			"SELECT active_precs FROM user_table WHERE user_id=$1",
			[user_id]
			);

		const prec_ids = JSON.parse(queryOut.rows[0].active_precs);

		//now make successive api calls to retrieve the information
		//dictionary structure
		/*
		{
			rx_no : 'test',
			pharmacy : {
				name: 'BigPharma',
				address: '27 Auburn Rd',
				zip_code: 'K7L2S7'
			},
			status : 'teststatus'
		}
		*/

		const prec_dixes = [];
		let curPrecInfo;
		let curRx;
		let curPharmQuery;
		let curPharmDix;
		let curStat;

		let curprecdix;

		//loop for filling up prescption dictionary
		prec_ids.forEach(
			function (curPrecId){
				//with every id in prec ids
				//retrieve the prec information from database
				curPrecInfo = await pool.query(
					"SELECT pharm_id, status FROM prec_table WHERE rx_no = $1",
					[curPrecId]
					);

				curRx = curPrecId; //extract rx no
				curStat = curPrecInfo.rows[0].status; //extract status

				//use pharmId from precInfo to make another database query to get pharmacy information
				curPharmQuery = await pool.query(
					"SELECT name, street_address, zip_code FROM pharm_table WHERE pharm_id = $1",
					[curPrecInfo.rows[0].pharm_id]
					);

				curPharmDix = {
					name: curPharmQuery.rows[0].name, //get pharmacy name
					address: curPharmQuery.rows[0].street_address, //street address
					zip_code: curPharmQuery.rows[0].zip_code //and zipcode
				}; //put it into the pharm dix

				//now can create the prescription dictionary
				curprecdix = {
					rx_no: curRx,
					pharmacy : curPharmDix,
					status: curStat
				};

				//add to the array
				prec_dixes.push(curprecdix);

			}
		);

		const output = {
			user: user_id,
			prescriptions: prec_dixes
		};


		res.send(output);
	} catch(err){
		console.log(err.message);
	}
});






routes(router); // what is this?

Object.assign(module.exports, {
  router,
});