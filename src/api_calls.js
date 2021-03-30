const express = require('express');
const cors = require('cors');
const objId = 'meditrack';
const pool = require("./db_connect");
const { query } = require('./db_connect');
const PSWD = "ae34ZF76!";

baka =  async ( contents ) => {
    for(i=0;i<100;i++) sum = sum+i;
    try{
        console.log("making query")
        let mq = await pool.query(
            "SELECT first_name FROM user_info WHERE user_id=1"
        )
        console.log(mq.rows[0].first_name);
        contents.isDone = 1;
        contents.first_name = mq.rows[0].first_name;
        return 1;

    } catch (err){
        console.log(err);
        return null;
    }
    
}

getStatusStep = (status_step_id) => {
    switch(status_step_id){
        case "1":
            return "Received";
        break;

        case "2":
            return "Logged";
        break;

        case "3":
            return "Pharmacist Verification";
        break;

        case "4":
            return "Packaging";
        break;

        case "5":
            return "Ready for Pick-Up";
        break;

        case "6":
            return "NOMESSAGE";
        break;

    }

}

getPrecInfo = async (rx) => {
    try{
        let precQuery = await pool.query(
            "SELECT * FROM prec_info WHERE rx='"+rx+"'"
        )
            //console.log(precQuery.rows[0]);
        return precQuery.rows[0];
    } catch (err){
        console.log(err);
        return null;
    }
}

getBasicPharmInfo = async (pharm_id)  => {
    try{
        //returns the basic pharm info used in prescription information
        let pharmQuery = await pool.query(
            "SELECT pharm_id, name, email, phone_no, street_address, postal_code FROM pharm_info WHERE pharm_id="+pharm_id
        )

        return pharmQuery.rows[0];
    } catch (err){
        console.log(err);
        return null;
    }

}

getBasicUserInfo = async( user_id ) => {
    //returns basic information about user.
    try{
        let userQuery = await pool.query(
            "SELECT user_id, first_name, last_name, email, phone_no FROM user_info WHERE user_id="+user_id
        )
    
        return userQuery.rows[0];

    } catch(err){
        console.log(err);
        return null;
    }

}

getDescriptivePrecInfo =  async(rx) => {
    //gets the descriptive version of information for prescription info
    try{
        let precDix = {};
        let precInfo = await getPrecInfo(rx);
        //gets the raw prescription info for that
        if(precInfo != undefined && precInfo != null){
            //only go forward if there is a value
            //retrieve the required information
            let pharmInfo = await getBasicPharmInfo(precInfo.pharm_id);
            let userInfo = await getBasicUserInfo(precInfo.user_id);
            let stat_mem = getStatusStep(precInfo.status_step_id);
            //console.log(stat_mem);
            precDix.rx = rx;
            precDix.med_name = precInfo.med_name;
            precDix.med_strength = precInfo.med_strength;
            precDix.user = userInfo;
            precDix.pharmacy = pharmInfo;
            precDix.max_refills = precInfo.max_refills;
            precDix.cur_refills = precInfo.cur_refills;
            precDix.progress = precInfo.status_step_id;
            precDix.progress_msg = stat_mem;
            precDix.status_msg = precInfo.status_msg;
            precDix.status_date = precInfo.status_date;
            precDix.is_completed = precInfo.is_completed;

            return precDix;

        } else{
            return null;
        }
    } catch (err) {
        console.log(err);
        return null;
    }
}

getDescriptivePrecInfo_fromQuery =  async (queryIn) => {
    try{
        let precDix = {};
        let precInfo = queryIn;
        //gets the raw prescription info for that
        if(precInfo != undefined && precInfo != null){
            //only go forward if there is a value
            //retrieve the required information
            let pharmInfo = await getBasicPharmInfo(precInfo.pharm_id);
            let userInfo = await getBasicUserInfo(precInfo.user_id);
            let stat_mem = getStatusStep(precInfo.status_step_id);
            
            precDix.rx = precInfo.rx;
            precDix.med_name = precInfo.med_name;
            precDix.med_strength = precInfo.med_strength;
            precDix.user = userInfo;
            precDix.pharmacy = pharmInfo;
            precDix.max_refills = precInfo.max_refills;
            precDix.cur_refills = precInfo.cur_refills;
            precDix.progress = precInfo.status_step_id;
            precDix.progress_msg = stat_mem;
            precDix.status_msg = precInfo.status_msg;
            precDix.status_date = precInfo.status_date;
            precDix.is_completed = precInfo.is_completed;

            return precDix;

        } else{
            return null;
        }
    } catch(err) {
        console.log(err);
        return null;
    }
}

constructBulkPrecRequest = ( listIn ) => {
    let whereClause = "";
    let cur_rx;
    for(i =0; i <listIn.length; i++){
        cur_rx = listIn[i];
        if(i == listIn.length-1){
            //if it is the last one do not add or clause
            whereClause = whereClause + "rx='"+cur_rx+"'";
        } else{
            whereClause = whereClause + "rx='"+cur_rx+"' or "
        }
    }

    return whereClause;
}

testAPI = async (req, res) => {
     try{
             res.send( await getDescriptivePrecInfo('7527686'))
        } catch(err){
            console.log(err.message);
            res.send("ERROR: Failure Handling Request")
        }
}

getUserAccountInfo =  async ( req, res) => {

}

getUserSecurityInfo =  async ( req, res) => {

}

addUserAccount =  async ( req, res) => {

}

getSecurityQuestions =  async ( req, res) => {

}

updateUserAccountInfo =  async ( req, res) => {

}

updateUserSecurityInfo =  async ( req, res) => {

}

module.exports = {
    testAPI,
    getUserAccountInfo,
    getUserSecurityInfo,
    addUserAccount,
    getSecurityQuestions,
    updateUserAccountInfo,
    updateUserSecurityInfo,
}
