//ROUTER FOR API CALLS

const express = require('express');
const objId = 'meditrack';
const pool = require("./db_connect");

module.exports = async(router) => {

    router.get(`/${objId}/forme/:id`, async (req, res) => {
        const { id } = req.params;
        res.send(id);
    });

    router.get(`/${objId}/prescs/:precId`, async (req, res) => {

        try {
            const {precId} = req.params;
            const prec = await pool.query(
                "SELECT * FROM prec_table WHERE rx_no=$1",
                [precId]
            );
    
           res.json(prec.rows[0]);
        } catch (err) {
          console.error(err.message);
        }
      });

      router.get(`/${objId}/users/:user_id`, async (req, res) => { 
        try{
            //console.log("user was run");
            //set up information needed for prescription call
            const { user_id } = req.params; //get the user id from request parameters
            //const user_id = parseInt(user_id_text,10);
    
            //make call to the database
            //will return a json text of active prescriptions with their prescription ID
            const queryOut = await pool.query(
                "SELECT active_precs FROM user_table WHERE user_id=$1",
                [user_id]
                );
            
            console.log(queryOut.rows[0].active_precs);
            const prec_ids = queryOut.rows[0].active_precs;
            
    
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
    
            let prec_dixes = [];
            let curPrecId;
            let curPrecInfo;
            let curRx;
            let curPharmQuery;
            let curPharmDix;
            let curStat;
    
            let curprecdix = [];
    
            //loop for filling up prescption dictionary
    
            console.log(prec_ids.length);
    
            for(let i=0; i<prec_ids.length;i++){
                curPrecId = prec_ids[i];
    
                curPrecInfo = await pool.query(
                    "SELECT pharm_id, status FROM prec_table WHERE rx_no = $1",
                    [curPrecId]
                    );
                
                    //console.log(curPrecInfo.rows[0]);
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
    
                //console.log(curprecdix);
                //add to the array
                //console.log("Before: "+prec_dixes.toString());
                prec_dixes.push(curprecdix);
                //prec_dixes.push("bull");
                //console.log("After: "+prec_dixes.toString());
            }
    
    
            //console.log("HELLO");
            const output = {
                user: user_id,
                prescriptions: prec_dixes
            };
    
            res.send(output);
        } catch(err){
            console.log(err.message);
        }
    });

    
};
