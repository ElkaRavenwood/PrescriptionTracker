//ROUTER FOR API CALLS
const express = require('express');
const cors = require('cors');
const objId = 'meditrack';
const pool = require("./db_connect");
const PSWD = "ae34ZF76!";

const toReadableDate = (sqlDateIn) => {
    let date = parseToDateInfo(sqlDateIn);
    return date.hh+":"+date.mm+", "+date.MMM+" "+date.dd+", "+date.yyyy;
 }
 
 const parseToDateInfo = (sqlDateIn) => {
     let pt = sqlDateIn.split("T")[0];
     let tt = sqlDateIn.split("T")[1].split(".000Z")[0];
     let date = new Date(pt+" "+tt);
     //console.log(date);
 
     let dateDix = {};
 
     dateDix.h = ""+date.getHours();
     dateDix.hh = (date.getHours() < 10) ? "0"+date.getHours() : ""+date.getHours();
     dateDix.m = ""+date.getMinutes();
     dateDix.mm = (date.getMinutes() < 10) ? "0"+date.getMinutes() : ""+date.getMinutes();
     dateDix.s = ""+date.getSeconds();
     dateDix.ss = (date.getSeconds() < 10) ? "0"+date.getSeconds() : ""+date.getSeconds();
     dateDix.d = ""+date.getDate();
     dateDix.dd = (date.getDate() < 10) ? "0"+date.getDate() : ""+date.getDate();
 
     
     let monthStr = "";
     let longMonthStr = "";
     switch(date.getMonth()+1){
         case 1:
             monthStr = "Jan";
             longMonthStr = "January";
         break;
 
         case 2:
             monthStr = "Feb";
             longMonthStr = "February";
         break;
 
         case 3:
             longMonthStr = monthStr = "March";
         break;
 
         case 4:
             monthStr = "Apr";
             longMonthStr = "April";
         break;
 
         case 5:
             longMonthStr = monthStr = "May";
 
         break;
 
         case 6:
             monthStr = "Jun";
             longMonthStr = "June";
         break;
 
         case 7:
             monthStr = "Jul";
             longMonthStr = "";
         break;
 
         case 8:
             monthStr = "August";
             longMonthStr = "August";
         break;
 
         case 9:
             monthStr = "Sep";
             longMonthStr = "September";
         break;
 
         case 10:
             monthStr = "Oct";
             longMonthStr = "October";
         break;
 
         case 11:
             monthStr = "Nov";
             longMonthStr = "November";
         break;
 
         case 12:
             monthStr = "Dec";
             longMonthStr = "December";
         break;
     }
 
     dateDix.M = ""+(date.getMonth()+1);
     dateDix.MM = (date.getMonth()+1 < 10) ? "0"+date.getMonth()+1 : ""+date.getMonth()+1;
     dateDix.MMM = monthStr;
     dateDix.MMMM = longMonthStr;
     dateDix.yy = ""+date.getYear();
     dateDix.yyyy = ""+date.getFullYear();
 
     return dateDix;
  }


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

limitInfo = ( prescription ) => {
    return {
        rx: prescription.rx,
        med_name: prescription.med_name,
        progress: prescription.progress
    }
}

module.exports = async(router) => {
    //TEST ---------------------------------------------------------------
    router.get(`/${objId}/test`, async (req, res) => {
        console.log("HERE IN TEST");
        try{
            //just run a for loop to capture the information
            let precs = [];

            //active queries will have user id and are not completed
            let precQueries = await pool.query(
                "SELECT * FROM prec_info WHERE user_id="+1+" and is_completed=0 ORDER BY status_step_id"
            );
            //console.log(precQueries.rows)
            //if there is at least one then set up prescription information.
            if(precQueries.rows[0] != null){
                for(i=0; i<precQueries.rows.length; i++){
                    precs.push(limitInfo(await getDescriptivePrecInfo_fromQuery(precQueries.rows[i])));
                }
            }
           precs = sortPrecsByProgress(precs)
           
            //console.log(pr2)
            res.status(200).send(precs);
        } catch(err){
            console.log(err.message);
            res.status(201).send("Failure Handling Request")
        }
    });

    router.get(`/${objId}/forme/:id`, async (req, res) => {
       // console.log("HERE IN TEST2");
        try{
            console.log("HERE IN TEST2");
            //let response = fetch("http://localhost:8000/meditrack/test")
            res.status(200).send("baka")
        } catch(err){
            res.status(200).send(err);
        }
    });

    //GET USER ACCOUNT INFO via ID, EMAIL, or PHONE NO -------------------------------------------------
    router.get(`/${objId}/user/account/info`, async(req,res) => {
        console.log(`API CALL: GET -> /${objId}/user/account/info`);
        try{
            const { query_pswd } = req.query;
            if(query_pswd == PSWD){
                let {user_id, phone_no, email } = req.query;
                let accQuery;
                let secQuery;
                if(user_id != null){
                    accQuery  = await pool.query(
                        "SELECT user_id, first_name, last_name, email, phone_no FROM user_info WHERE user_id=$1",
                        [user_id]
                    );
                    //console.log("here");

                } else if (email != null){
                    accQuery  = await pool.query(
                        "SELECT user_id, first_name, last_name, email, phone_no FROM user_info WHERE email=$1",
                        [email]
                    );

                } else if(phone_no != null){
                    accQuery  = await pool.query(
                        "SELECT user_id, first_name, last_name, email, phone_no FROM user_info WHERE phone_no=$1",
                        [phone_no]
                    );

                } else{
                    //no information so send a simple message
                    res.status(201).send("No Provided Keys");
                }

                if(accQuery.rows[0] == null){
                    res.status(201).send("No User Found");
                } else{
                    let userMatch = (user_id == null) ||  (user_id == accQuery.rows[0].user_id);
                    let emailMatch = (email == null) ||  (email == accQuery.rows[0].email);
                    let phoneMatch = (phone_no == null) ||  (phone_no == accQuery.rows[0].phone_no);

                    if(!userMatch || !emailMatch || !phoneMatch){
                        res.status(201).send("Account Info and Provided Info Do Not Match");
                    } else{
                        //confirmed user provided identity can now start building dictionary
                        //res.status(200).send(accQuery.rows[0]);

                        user_id = accQuery.rows[0].user_id;
                        email = accQuery.rows[0].email;
                        phone_no = accQuery.rows[0].phone_no;

                        //first retrieve the security query
                        secQuery = await pool.query(
                            "SELECT healthcard_no, street_address, city, postal_code FROM user_sec_info WHERE user_id=$1",
                            [user_id]
                        );

                        outputDix = {
                            user_id: user_id,
                            first_name: accQuery.rows[0].first_name,
                            last_name: accQuery.rows[0].last_name,
                            email: email,
                            phone_no : phone_no,
                            healthcard_no : secQuery.rows[0].healthcard_no,
                            street_address: secQuery.rows[0].street_address,
                            city: secQuery.rows[0].city,
                            postal_code: secQuery.rows[0].postal_code
                        }

                        res.status(200).send(outputDix);

                    }
                }
            } else{
                res.status(201).send("Illegal Query")
            }

        } catch(err){
            console.log(err);
        }
    });

    //GET USER SECUCRITY INFO via ID, EMAIL, or PHONE NO -------------------------------------------------
    router.get(`/${objId}/user/account/security`, async(req,res) => {
        console.log(`API CALL: GET -> /${objId}/user/account/security`);
        try{
            const {query_pswd} = req.query;
            if(query_pswd == PSWD){
                let {user_id, phone_no, email } = req.query;
                let secQuery;
                if(user_id != null){
                    secQuery  = await pool.query(
                        "SELECT user_id, email, phone_no FROM user_sec_info WHERE user_id=$1",
                        [user_id]
                    );
                    //console.log("here");
                    //res.status(200).send(secQuery);
                } else if (email != null){
                    secQuery  = await pool.query(
                        "SELECT user_id, email, phone_no FROM user_sec_info WHERE email=$1",
                        [email]
                    );

                } else if(phone_no != null){
                    secQuery  = await pool.query(
                        "SELECT user_id, email, phone_no FROM user_sec_info WHERE phone_no=$1",
                        [phone_no]
                    );

                } else{
                    //no information so send a simple message
                    res.status(201).send("No Provided Keys");
                }

                if(secQuery.rows[0] == null){
                    res.status(201).send("No User Found");
                } else{
                    let userMatch = (user_id == null) ||  (user_id == secQuery.rows[0].user_id);
                    let emailMatch = (email == null) ||  (email == secQuery.rows[0].email);
                    let phoneMatch = (phone_no == null) ||  (phone_no == secQuery.rows[0].phone_no);

                    if(!userMatch || !emailMatch || !phoneMatch){
                        res.status(201).send("Account Info and Provided Info Do Not Match");
                    } else{
                        //confirmed user provided identity can now start building dictionary
                        //res.status(200).send(accQuery.rows[0]);

                        user_id = secQuery.rows[0].user_id;
                        email = secQuery.rows[0].email;
                        phone_no = secQuery.rows[0].phone_no;

                        //first retrieve the security query
                        secQuery = await pool.query(
                            "SELECT user_id, email, phone_no, password, sec_quest_1, sec_ans_1, sec_quest_2, sec_ans_2, sec_quest_3, sec_ans_3 FROM user_sec_info WHERE user_id=$1",
                            [user_id]
                        );

                        res.status(200).send(secQuery.rows[0]);

                    }
                }
            } else{
                res.status(201).send("Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.status(201).send("Failure Handling Request");
        }
    });

    //POST USER ACCOUNT INFORMATION ON SIGN UP ----------------------------------------------------------------
    router.post(`/${objId}/user/account`, async(req, res) => {
        try{
            const {query_pswd} = req.query;
            if(query_pswd == PSWD){
                //assume that all the fields are available with the request
                //if not handle null fields appropriately

                let {first_name, last_name, email, phone_no} = req.query;
                let {street_address, city, postal_code} = req.query;
                let {password, healthcard_no} = req.query;
                let {sec_quest_1, sec_quest_2, sec_quest_3} = req.query;
                let {sec_ans_1, sec_ans_2, sec_ans_3} = req.query;

                //perform the appropriate error checking
                noName = (first_name == null) || (last_name == null);
                noIdentifier = (email == null) && (phone_no == null);
                noPassword = (password == null);


                if(!noName && !noIdentifier && !noPassword){
                    //need to check if the email and phone no have already been used
                    let checkQuery =  await pool.query(
                        "SELECT user_id FROM user_info WHERE email='"+email+"' or phone_no='"+phone_no+"'"
                    );

                    if(checkQuery.rows[0] == null){
                        let infoQuery = await pool.query(
                            "INSERT INTO user_info(first_name, last_name, email, phone_no) VALUES($1,$2,$3,$4) RETURNING *",
                            [first_name, last_name, email, phone_no]
                        );
                        //console.log("HERE2");
    
                        const user_id = infoQuery.rows[0].user_id;
    
                        //use the user id for insertions into the security table
                        let secQuery = await pool.query(
                            "INSERT INTO user_sec_info(user_id, email, phone_no, password, healthcard_no, street_address, city, postal_code,"
                            +"sec_quest_1, sec_ans_1, sec_quest_2, sec_ans_2, sec_quest_3, sec_ans_3) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14) RETURNING *",
                            [user_id, email, phone_no, password, healthcard_no, street_address, city, postal_code, 
                                sec_quest_1, sec_ans_1, sec_quest_2, sec_ans_2, sec_quest_3, sec_ans_3]
                        );
    
                        //insertion is complete so return the user account information
                        res.status(200).send(infoQuery.rows[0]);

                    } else {
                        res.status(201).send("Email Or Phone No Already Associated With An Account");
                    }

                } else {
                    res.status(201).send("Insufficient Information");
                }

            } else{
                res.status(201).send("Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.status(201).send("Failure Handling Request");
        }
    });

    //GET USER SECURITY QUESTIONS --------------------------------------------------------------------------
    router.get(`/${objId}/security/questions`, async(req,res) => {
        try{
            const { query_pswd } = req.query;
            if(query_pswd == PSWD){
                //return the dictionary of questions
                const query = await pool.query(
                    "SELECT sec_quest FROM sec_questions"
                );
                let questions = [];

                for(i=0;i<query.rows.length;i++){
                    //console.log(query.rows[0]);
                   questions.push(query.rows[i].sec_quest);
                }
                res.status(200).send(questions);
            } else{
                res.status(201).send("Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.status(201).send("Failure Handling Request");
        }
    });

    //UPDATE USER ACCOUNT INFORMATION ---------------------------------------------------------
    router.put(`/${objId}/user/account/info`, async(req,res) => {
        try{
            const { query_pswd} = req.query;
            if(query_pswd == PSWD){
                //first confirm the user identity 
                let {user_id } = req.query;
                let secQuery;
                if(user_id != null){
                    secQuery  = await pool.query(
                        "SELECT user_id, email, phone_no FROM user_sec_info WHERE user_id=$1",
                        [user_id]
                    );
                    //console.log("here");
                    //res.status(200).send(secQuery);
                    
                } else{
                    //no information so send a simple message
                    res.status(201).send("No Provided Key");
                }

                if(secQuery.rows[0] == null){
                    res.status(201).send("No User Found");
                } else{
                    //we want t
                    let { first_name, last_name, email, phone_no} = req.query;
                    let { healthcard_no, street_address, city, postal_code} = req.query;
                    let updateCols = "";
                    let updateSecCols = "";

                    if(first_name != null) updateCols = "first_name='"+first_name+"',"+updateCols;
                    if(last_name != null) updateCols = "last_name='"+last_name+"',"+updateCols;

                    if(email != null) {
                        updateCols = "email='"+email+"',"+updateCols;
                        updateSecCols = "email='"+email+"',"+updateSecCols;
                    }

                    if(phone_no != null){
                        updateCols = "phone_no='"+phone_no+"',"+updateCols;
                        updateSecCols = "phone_no='"+phone_no+"',"+updateSecCols;
                    } 
                    if(healthcard_no != null) updateSecCols = "healthcard_no='"+healthcard_no+"',"+updateSecCols;
                    if(street_address != null) updateSecCols = "street_address='"+street_address+"',"+updateSecCols;
                    if(city != null) updateSecCols = "city='"+city+"',"+updateSecCols;
                    if(postal_code != null) updateSecCols = "postal_code='"+postal_code+"',"+updateSecCols;
                    let mystr;
                    let accQuery;
                    let secQuery;
                    let updateVal = false;

                    //lets see an example query
                    if(updateCols != ""){
                        //if there is information to update then do it
                        updateCols = updateCols.substring(0,updateCols.length-1);
                        mystr = "UPDATE user_info SET "+updateCols+" WHERE user_id="+user_id+"RETURNING user_id";
                        accQuery = await pool.query(mystr);
                        updateVal = (user_id == accQuery.rows[0].user_id);
                    }

                    if(updateSecCols != ""){
                        updateSecCols = updateSecCols.substring(0,updateSecCols.length-1);
                        mystr = "UPDATE user_sec_info SET "+updateSecCols+" WHERE user_id="+user_id+"RETURNING user_id";
                        secQuery = await pool.query(mystr);
                        updateVal = (user_id == secQuery.rows[0].user_id);
                    }

                    if((updateCols !="" || updateSecCols !="") && updateVal){
                        res.status(200).send({
                            user_id: user_id,
                            update_status: 1,
                            update_msg: "Update Successful"
                        });
                    } else if (!updateVal && (updateCols !="" || updateSecCols !="") ) {
                        res.status(200).send({
                            user_id: user_id,
                            update_status: 0,
                            update_msg: "An error occured"
                        });
                    } else{
                        res.status(200).send({
                            user_id: user_id,
                            update_status: 1,
                            update_msg: "No fields to update"
                        });
                    }  
                }

            } else{
                res.status(201).send("Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.status(201).send("Failure Handling Request");
        }
    });

    //UPDATE USER SECURITY INFORMATION --------------------------------------------------------------------
    router.put(`/${objId}/user/account/security`, async(req,res) => {
        try{
            const { query_pswd} = req.query;
            if(query_pswd == PSWD){
                //first confirm the user identity 
                let {user_id } = req.query;
                let secQuery;
                if(user_id != null){
                    secQuery  = await pool.query(
                        "SELECT user_id, email, phone_no FROM user_sec_info WHERE user_id=$1",
                        [user_id]
                    );
                    //console.log("here");
                    //res.status(200).send(secQuery);
                    
                } else{
                    //no information so send a simple message
                    res.status(201).send("No Provided Key");
                }

                if(secQuery.rows[0] == null){
                    res.status(201).send("No User Found");
                } else{
                    //we want t
                    let {password} = req.query;
                    let {sec_quest_1, sec_quest_2, sec_quest_3} = req.query;
                    let {sec_ans_1, sec_ans_2, sec_ans_3} = req.query;
                    let updateSecCols = "";

                    if(password != null) updateSecCols = "password='"+password+"',"+updateSecCols;
                    if(sec_quest_1 != null) updateSecCols = "sec_quest_1='"+sec_quest_1+"',"+updateSecCols;
                    if(sec_quest_2 != null) updateSecCols = "sec_quest_2='"+sec_quest_2+"',"+updateSecCols;
                    if(sec_quest_3 != null) updateSecCols = "sec_quest_3='"+sec_quest_3+"',"+updateSecCols;
                    
                    if(sec_ans_1 != null) updateSecCols = "sec_ans_1='"+sec_ans_1+"',"+updateSecCols;
                    if(sec_ans_2 != null) updateSecCols = "sec_ans_2='"+sec_ans_2+"',"+updateSecCols;
                    if(sec_ans_3 != null) updateSecCols = "sec_ans_3='"+sec_ans_3+"',"+updateSecCols;
                   
                   
                    let mystr;
                    let secQuery;
                    let updateVal = false;

                    if(updateSecCols != ""){
                        updateSecCols = updateSecCols.substring(0,updateSecCols.length-1);
                        mystr = "UPDATE user_sec_info SET "+updateSecCols+" WHERE user_id="+user_id+"RETURNING user_id";
                        secQuery = await pool.query(mystr);
                        updateVal = (user_id == secQuery.rows[0].user_id);
                    }

                    if(updateSecCols !="" && updateVal){
                        res.status(200).send({
                            user_id: user_id,
                            update_status: 1,
                            update_msg: "Update Successful"
                        });
                    } else if (!updateVal && updateSecCols !="") {
                        res.status(200).send({
                            user_id: user_id,
                            update_status: 0,
                            update_msg: "An error occured"
                        });
                    } else{
                        res.status(200).send({
                            user_id: user_id,
                            update_status: 1,
                            update_msg: "No fields to update"
                        });
                    }   
                }

            } else{
                res.status(201).send("Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.status(201).send("Failure Handling Request");
        }
    });

    //POST A PRESCRIPTION ------------------------------------------------------------
    router.post(`/${objId}/precs`, async(req,res) => {
        try{
            const  {query_pswd} = req.query;
            if(query_pswd == PSWD){
                let { rx, user_id, pharm_id, status_date } = req.query;
                let {med_name, med_strength, status_msg} = req.query; 
                let { max_refills, cur_refills } = req.query;

                let fields;
                let precQuery;
                let userQuery;
                let pharmQuery;

                if(rx == null || user_id == null || pharm_id == null || status_date == null){
                    res.status(201).send("Insufficient Information");
                } else{
                    precQuery = await pool.query(
                       "SELECT * FROM prec_info WHERE rx='"+rx+"'"
                    );
                      
                    if(precQuery.rows[0] != null){
                        res.status(201).send("Prescription Already Exists In Database");

                    } else{
                        //first create the information to post
                        fields = "rx,med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date, max_refills, cur_refills";
                        precQuery =  await pool.query(
                            "INSERT INTO prec_info("+fields+") VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11) RETURNING *",
                            [rx, med_name, med_strength, user_id, pharm_id, 1, status_msg, 0, status_date, max_refills, cur_refills ]
                        );
                        
                        res.status(200).send(precQuery.rows[0]);
                    }
                }


            } else{
                res.status(201).send("Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.status(201).send("Failure Handling Request");
        }
    });

    //GET A GIVEN PRESCRIPTION ---------------------------------------------------------------
    router.get(`/${objId}/precs/info`, async(req,res) => {
        try{
            const { query_pswd} = req.query;
            if(query_pswd == PSWD){
                const { rx } = req.query;
                let precDescInfo = await getDescriptivePrecInfo(rx);
                if(precDescInfo == null){
                    res.status(201).send("No Prescription Found");
                } else {
                    res.status(200).send(precDescInfo);
                }
            } else{
                res.status(201).send("Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.status(201).send("Failure Handling Request");
        }
    });
      

    //GET ALL ACTIVE PRECS FOR A GIVEN USER ID ---------------------------------------------------------------
    router.get(`/${objId}/user/precs/active`, async(req,res) => {
        try{
            const { query_pswd} = req.query;
            if(query_pswd == PSWD){
                const {user_id} = req.query;

                let uQuery = await pool.query(
                    "SELECT user_id FROM user_info WHERE user_id="+user_id
                )

                if(uQuery.rows[0]!=null){
                    //just run a for loop to capture the information
                    let precs = [];

                    //active queries will have user id and are not completed
                    let precQueries = await pool.query(
                        "SELECT * FROM prec_info WHERE user_id="+user_id+" and is_completed=0 ORDER BY status_step_id"
                    );
                    //console.log(precQueries.rows)
                    //if there is at least one then set up prescription information.
                    if(precQueries.rows[0] != null){
                        for(i=0; i<precQueries.rows.length; i++){
                            precs.push(await getDescriptivePrecInfo_fromQuery(precQueries.rows[i]));
                        }
                    }
                    //let pr2 = sortPrecsByProgress(precs)
                    //console.log(pr2)
                    res.status(200).send(sortPrecsByProgress(precs));
                

                } else {
                    res.status(201).send("User Not Found");
                }

            } else{
                res.status(201).send("Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.status(201).send("Failure Handling Request");
        }
    });
    
    //GET ALL PRECS (HISTORY) FOR A GIVEN USER ID ---------------------------------------------------------------
    router.get(`/${objId}/user/precs/history`, async(req,res) => {
        try{
            const { query_pswd} = req.query;
            if(query_pswd == PSWD){
                const {user_id} = req.query;

                let uQuery = await pool.query(
                    "SELECT user_id FROM user_info WHERE user_id="+user_id
                )

                if(uQuery.rows[0]!=null){
                    //just run a for loop to capture the information
                    let precs = [];

                    //all prescritpions will have user id and are not completed
                    let precQueries = await pool.query(
                        "SELECT * FROM prec_info WHERE user_id="+user_id
                    );

                    //if there is at least one then set up prescription information.
                    if(precQueries.rows[0] != null){
                        for(i=0; i<precQueries.rows.length; i++){
                            precs.push(await getDescriptivePrecInfo_fromQuery(precQueries.rows[i]));
                        }
                    }
                    res.status(200).send(precs);

                } else {
                    res.status(201).send("User Not Found");
                }

            } else{
                res.status(201).send("Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.status(201).send("Failure Handling Request");
        }
    });

    //UPDATE A PRESCRIPTION PROGRESS--------------------------------------------------------------------
    router.put(`/${objId}/precs/progress`, async(req,res) => {
        try{
            const { query_pswd} = req.query;
            if(query_pswd == PSWD){
                //first of all check to make sure prescription is in library
                const { rx } = req.query;
                if(rx != null){
                    let mq = await pool.query(
                        "SELECT rx FROM prec_info WHERE rx='"+rx+"'"
                    );
                    

                    if(mq.rows[0] != null){

                        //now check if status date is there
                        const { status_date, progress, status_msg, is_completed } = req.query;

                        if(status_date != null){
                            
                            if(progress != null){
                                //generate the fields for updating
                                fields = "";

                                if(progress != null) fields = fields+"status_step_id="+progress+",";
                                if(status_msg != null) fields = fields+"status_msg='"+status_msg+"',";
                                
                                fields = fields+"status_date='"+status_date+"'";

                                //console.log(fields);
                                //now update the system
                                 let upQuery = await pool.query(
                                     "UPDATE prec_info SET "+fields+" WHERE rx='"+rx+"' RETURNING *"
                                 );

                                res.status(200).send(await getDescriptivePrecInfo(rx));
                            } else{
                                res.status(200).send("No Progress ID Provided")
                            }


                        } else{
                            res.status(200).send("No update date provided");
                        }

                    } else{
                        res.status(201).send("No Prescription Found");
                    }

                } else{

                    res.status(201).send("No RX provided");
                }
            } else{
                res.status(201).send("Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.status(201).send("Failure Handling Request");
        }
    });

    //UPDATE PRESCRIPTION INFORMATION --------------------------------------------------------------------
    router.put(`/${objId}/precs/info`, async(req,res) => {
        try{
            const { query_pswd} = req.query;
            if(query_pswd == PSWD){
                const { rx } = req.query;
                if(rx != null){
                    //check if the prescription is in database
                    let myQuery = await pool.query(
                        "SELECT * FROM prec_info WHERE rx='"+rx+"'"
                    );

                    if(myQuery.rows[0] != null){
                        //grab the fields in the query
                        let { med_name, med_strength } = req.query;

                        let fields = "";

                        if(med_name != null) fields = fields + "med_name='"+med_name+"', ";
                        if(med_strength != null) fields = fields + "med_strength='"+med_strength+"', ";

                        fields = fields + "rx='"+rx+"'";

                        //make the update

                        let upQuery = await pool.query(
                            "UPDATE prec_info SET "+fields+" WHERE rx='"+rx+"'"
                        );

                        res.status(200).send(await getDescriptivePrecInfo(rx));

                    } else{
                        res.status(201).send("No prescription found for provided RX");
                    }

                } else{
                    res.status(201).send("No RX provided");
                }

            } else{
                res.status(201).send("Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.status(201).send("Failure Handling Request");
        }
    });

    //GET PROGRESS STEPS --------------------------------------------------------------------------------
    router.get(`/${objId}/precs/progress/steps`, async(req,res) => {
        try{
            const { query_pswd} = req.query;
            if(query_pswd == PSWD){
                let steps = {
                    1: "Received",
                    2: "Logged",
                    3: "Pharmacist Verification",
                    4: "Packaging",
                    5: "Ready for Pick Up",
                    6: "NOMESSAGE"
                }

                res.status(200).send(steps);

            } else{
                res.status(201).send("Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.status(201).send("Failure Handling Request");
        }
    });

    //COMPLETE A PRESCRIPTION
    router.put(`/${objId}/precs/progress/complete`, async(req,res) => {
        try{
            const { query_pswd} = req.query;
            if(query_pswd == PSWD){

                const { rx } = req.query;
                if(rx != null){
                    let prec = await getDescriptivePrecInfo(rx);
                    if(prec != null){
                        //now make the update
                        await pool.query(
                            "UPDATE prec_info SET is_completed="+1+" WHERE rx='"+rx+"'"
                        );

                        //then deactivate the prescription in user and pharm info

                        //send the updated prescription.
                        prec.is_completed = 1;
                        res.status(200).send(prec);

                    } else{
                        res.status(201).send("No prescription found")
                    }
                } else{
                    res.status(201).send("No RX provided")
                }

            } else{
                res.status(201).send("Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.status(201).send("Failure Handling Request");
        }
    });

    //POST PHARM ACCOUNT INFORMATION ON SIGN UP ----------------------------------------------------------------
    router.post(`/${objId}/pharm/account`, async(req, res) => {
        try{
            const {query_pswd} = req.query;
            if(query_pswd == PSWD){
                //assume that all the fields are available with the request
                //if not handle null fields appropriately

                let {name, email, phone_no} = req.query;
                let {street_address, city, postal_code} = req.query;
                let {password } = req.query;
                let {sec_quest_1, sec_quest_2, sec_quest_3} = req.query;
                let {sec_ans_1, sec_ans_2, sec_ans_3} = req.query;

                //perform the appropriate error checking
                noName = (name == null);
                noIdentifier = (email == null) && (phone_no == null);
                noPassword = (password == null);

                if(!noName && !noIdentifier && !noPassword){
                    //first store information into pharm_info table
                    //then retrieve the pharm_id

                    let checkQuery =  await pool.query(
                        "SELECT pharm_id FROM pharm_info WHERE email='"+email+"' or phone_no='"+phone_no+"'"
                    );

                    if(checkQuery.rows[0] == null){
                        let infoQuery = await pool.query(
                            "INSERT INTO pharm_info(name, email, phone_no, street_address, city, postal_code) VALUES($1,$2,$3,$4,$5,$6) RETURNING *",
                            [name, email, phone_no, street_address, city, postal_code]
                        );
                        
                        const pharm_id = infoQuery.rows[0].pharm_id;
    
                        //use the pharm id for insertions into the security table
                        let secQuery = await pool.query(
                            "INSERT INTO pharm_sec_info(pharm_id, email, phone_no, password,"
                            +"sec_quest_1, sec_ans_1, sec_quest_2, sec_ans_2, sec_quest_3, sec_ans_3) VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10) RETURNING *",
                            [pharm_id, email, phone_no, password, 
                            sec_quest_1, sec_ans_1, sec_quest_2, sec_ans_2, sec_quest_3, sec_ans_3]
                        );
    
                        //insertion is complete so return the pharm account information
                        res.status(200).send(infoQuery.rows[0]);
                    } else{
                        res.status(201).send("Email or Phone No. already associated with an account");
                    }

                } else {
                    res.status(201).send("Insufficient Information");
                }

            } else{
                res.status(201).send("Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.status(201).send("Failure Handling Request");
        }
    });

    //GET PHARM ACCOUNT INFO ---------------------------------------------------------------------
    router.get(`/${objId}/pharm/account/info`, async(req,res) => {
        //console.log(`API CALL: GET -> /${objId}/user/account/info`);
        try{
            const { query_pswd } = req.query;
            if(query_pswd == PSWD){
                let {pharm_id, phone_no, email } = req.query;
                let accQuery;
                let secQuery;
                //perform checking to retrieve information from the database
                //one of them has to be present
                if(pharm_id != null){
                    accQuery  = await pool.query(
                        "SELECT pharm_id, name, email, phone_no, street_address, city, postal_code FROM pharm_info WHERE pharm_id=$1",
                        [pharm_id]
                    );
                    //console.log("here");

                } else if (email != null){
                    accQuery  = await pool.query(
                        "SELECT pharm_id, name, email, phone_no, street_address, city, postal_code FROM pharm_info WHERE email=$1",
                        [email]
                    );

                } else if(phone_no != null){
                    accQuery  = await pool.query(
                        "SELECT pharm_id, name, email, phone_no, street_address, city, postal_code FROM pharm_info WHERE phone_no=$1",
                        [phone_no]
                    );

                } else{
                    //no information so send a simple message
                    res.status(201).send("No provided keys");
                }

                if(accQuery.rows[0] == null){
                    //if the query is not present, then the account does not exist
                    res.status(201).send("No Pharmacy Account Found");
                } else{
                    let pharmMatch = (pharm_id == null) ||  (pharm_id == accQuery.rows[0].pharm_id);
                    let emailMatch = (email == null) ||  (email == accQuery.rows[0].email);
                    let phoneMatch = (phone_no == null) ||  (phone_no == accQuery.rows[0].phone_no);

                    if(!pharmMatch || !emailMatch || !phoneMatch){
                        res.status(201).send("Account Info or Provided Info Do Not Match");
                    } else{
                        //confirmed user provided identity can now start building dictionary
                        //res.status(200).send(accQuery.rows[0]);

                        pharm_id = accQuery.rows[0].pharm_id;
                        email = accQuery.rows[0].email;
                        phone_no = accQuery.rows[0].phone_no;

                        outputDix = {
                            pharm_id: pharm_id,
                            name: accQuery.rows[0].name,
                            email: email,
                            phone_no : phone_no,
                            street_address: accQuery.rows[0].street_address,
                            city: accQuery.rows[0].city,
                            postal_code: accQuery.rows[0].postal_code
                        }

                        res.status(200).send(outputDix);

                    }
                }
            } else{
                res.status(201).send("Illegal Query")
            }

        } catch(err){
            console.log(err);
        }
    });

    // GET PHARM SECURITY INFO ----------------------------------------------------------
    router.get(`/${objId}/pharm/account/security`, async(req,res) => {
        //console.log(`API CALL: GET -> /${objId}/user/account/info`);
        try{
            const { query_pswd } = req.query;
            if(query_pswd == PSWD){
                let {pharm_id, phone_no, email } = req.query;
                let accQuery;
                let secQuery;
                //perform checking to retrieve information from the database
                //one of them has to be present
                if(pharm_id != null){
                    accQuery  = await pool.query(
                        "SELECT pharm_id, name, email, phone_no FROM pharm_info WHERE pharm_id=$1",
                        [pharm_id]
                    );
                    //console.log("here");

                } else if (email != null){
                    accQuery  = await pool.query(
                        "SELECT pharm_id, name, email, phone_no FROM pharm_info WHERE email=$1",
                        [email]
                    );

                } else if(phone_no != null){
                    accQuery  = await pool.query(
                        "SELECT pharm_id, name, email, phone_no FROM pharm_info WHERE phone_no=$1",
                        [phone_no]
                    );

                } else{
                    //no information so send a simple message
                    res.status(201).send("No provided keys");
                }

                if(accQuery.rows[0] == null){
                    //if the query is not present, then the account does not exist
                    res.status(201).send("No Pharmacy Account Found");
                } else{
                    let pharmMatch = (pharm_id == null) ||  (pharm_id == accQuery.rows[0].pharm_id);
                    let emailMatch = (email == null) ||  (email == accQuery.rows[0].email);
                    let phoneMatch = (phone_no == null) ||  (phone_no == accQuery.rows[0].phone_no);

                    if(!pharmMatch || !emailMatch || !phoneMatch){
                        res.status(201).send("Account Info or Provided Info Do Not Match");
                    } else{
                        //confirmed user provided identity can now start building dictionary
                        //res.status(200).send(accQuery.rows[0]);

                        pharm_id = accQuery.rows[0].pharm_id;
                        email = accQuery.rows[0].email;
                        phone_no = accQuery.rows[0].phone_no;

                        secQuery = await pool.query(
                            "SELECT pharm_id, email, phone_no, password, sec_quest_1, sec_ans_1, sec_quest_2, sec_ans_2, sec_quest_3, sec_ans_3 FROM pharm_sec_info WHERE pharm_id=$1",
                            [pharm_id]
                        )

                        res.status(200).send(secQuery.rows[0]);

                    }
                }
            } else{
                res.status(201).send("Illegal Query")
            }

        } catch(err){
            console.log(err);
        }
    }); 

    //UPDATE PHARM ACCOUNT INFO ------------------------------------------------------------
    router.put(`/${objId}/pharm/account/info`, async(req,res) => {
        try{
            const { query_pswd} = req.query;
            if(query_pswd == PSWD){
                //first confirm the user identity 
                let {pharm_id } = req.query;
                let secQuery;
                if(pharm_id != null){
                    secQuery  = await pool.query(
                        "SELECT pharm_id, email, phone_no FROM pharm_sec_info WHERE pharm_id=$1",
                        [pharm_id]
                    );
                    //console.log("here");
                    //res.status(200).send(secQuery);
                    
                } else{
                    //no information so send a simple message
                    res.status(201).send("No Provided Key");
                }

                if(secQuery.rows[0] == null){
                    res.status(201).send("No Pharmacy Found");
                } else{
                    //get the optional parms from the request
                    let { name, email, phone_no} = req.query;
                    let { street_address, city, postal_code} = req.query;
                    let updateCols = "";
                    let updateSecCols = "";

                    //create the query update fields from the optional parms
                    if(name != null) updateCols = "name='"+name+"',"+updateCols;

                    if(email != null) {
                        updateCols = "email='"+email+"',"+updateCols;
                        updateSecCols = "email='"+email+"',"+updateSecCols;
                    }

                    if(phone_no != null){
                        updateCols = "phone_no='"+phone_no+"',"+updateCols;
                        updateSecCols = "phone_no='"+phone_no+"',"+updateSecCols;
                    } 

                    if(street_address != null) updateCols = "street_address='"+street_address+"',"+updateCols;
                    if(city != null) updateCols = "city='"+city+"',"+updateCols;
                    if(postal_code != null) updateCols = "postal_code='"+postal_code+"',"+updateCols;
                    let mystr;
                    let accQuery;
                    let secQuery;
                    updateVal = false;

                    //lets see an example query
                    if(updateCols != ""){
                        //if there is information to update then do it
                        updateCols = updateCols.substring(0,updateCols.length-1);
                        mystr = "UPDATE pharm_info SET "+updateCols+" WHERE pharm_id="+pharm_id+"RETURNING pharm_id";
                        accQuery = await pool.query(mystr);
                        updateVal = (pharm_id == accQuery.rows[0].pharm_id);
                    }

                    if(updateSecCols != ""){
                        updateSecCols = updateSecCols.substring(0,updateSecCols.length-1);
                        mystr = "UPDATE pharm_sec_info SET "+updateSecCols+" WHERE pharm_id="+pharm_id+"RETURNING pharm_id";
                        secQuery = await pool.query(mystr);
                        updateVal = (pharm_id == secQuery.rows[0].pharm_id);
                    }

                    if((updateCols !="" || updateSecCols !="") && updateVal){
                        res.status(200).send({
                            pharm_id: pharm_id,
                            update_status: 1,
                            update_msg: "Update Successful"
                        });
                    } else if (!updateVal && (updateCols !="" || updateSecCols !="")) {
                        res.status(200).send({
                            pharm_id: pharm_id,
                            update_status: 0,
                            update_msg: "An error occured"
                        });
                    } else{
                        res.status(200).send({
                            pharm_id: pharm_id,
                            update_status: 1,
                            update_msg: "No fields to update"
                        });
                    }  
                }

            } else{
                res.status(201).send("Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.status(201).send("Failure Handling Request");
        }
    });

    //UPDATE PHARM SECURITY INFO ---------------------------------------------------------------
    router.put(`/${objId}/pharm/account/security`, async(req,res) => {
        try{
            const { query_pswd} = req.query;
            if(query_pswd == PSWD){
                //first confirm the pharm identity 
                let {pharm_id } = req.query;
                let secQuery;
                if(pharm_id != null){
                    secQuery  = await pool.query(
                        "SELECT pharm_id, email, phone_no FROM pharm_sec_info WHERE pharm_id=$1",
                        [pharm_id]
                    );
                   
                    
                } else{
                    //no information so send a simple message
                    res.status(201).send("No Provided Key");
                }

                if(secQuery.rows[0] == null){
                    res.status(201).send("No User Found");
                } else{
                    //retrieve information from request body
                    let {password} = req.query;
                    let {sec_quest_1, sec_quest_2, sec_quest_3} = req.query;
                    let {sec_ans_1, sec_ans_2, sec_ans_3} = req.query;
                    let updateSecCols = "";

                    //generate update request field
                    if(password != null) updateSecCols = "password='"+password+"',"+updateSecCols;
                    if(sec_quest_1 != null) updateSecCols = "sec_quest_1='"+sec_quest_1+"',"+updateSecCols;
                    if(sec_quest_2 != null) updateSecCols = "sec_quest_2='"+sec_quest_2+"',"+updateSecCols;
                    if(sec_quest_3 != null) updateSecCols = "sec_quest_3='"+sec_quest_3+"',"+updateSecCols;
                    
                    if(sec_ans_1 != null) updateSecCols = "sec_ans_1='"+sec_ans_1+"',"+updateSecCols;
                    if(sec_ans_2 != null) updateSecCols = "sec_ans_2='"+sec_ans_2+"',"+updateSecCols;
                    if(sec_ans_3 != null) updateSecCols = "sec_ans_3='"+sec_ans_3+"',"+updateSecCols;
                   
                   
                    let mystr;
                    let secQuery;
                    let updateVal = false;

                    //make query if required
                    if(updateSecCols != ""){
                        updateSecCols = updateSecCols.substring(0,updateSecCols.length-1);
                        mystr = "UPDATE pharm_sec_info SET "+updateSecCols+" WHERE pharm_id="+pharm_id+"RETURNING pharm_id";
                        secQuery = await pool.query(mystr);
                        updateVal = (pharm_id == secQuery.rows[0].pharm_id);
                    }

                    //do some checking to determine what response we should send.
                    if(updateSecCols !="" && updateVal){
                        res.status(200).send({
                            pharm_id: pharm_id,
                            update_status: 1,
                            update_msg: "Update Successful"
                        });
                    } else if (!updateVal &&  updateSecCols !="") {
                        res.status(200).send({
                            pharm_id: pharm_id,
                            update_status: 0,
                            update_msg: "An error occured"
                        });
                    } else{
                        res.status(200).send({
                            pharm_id: pharm_id,
                            update_status: 1,
                            update_msg: "No fields to update"
                        });
                    }   
                }

            } else{
                res.status(201).send("Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.status(201).send("Failure Handling Request");
        }
    });

    // PHARMACY GET PATIENTS ------------------------------------------------------------------
    router.get(`/${objId}/pharm/patients`, async(req,res) => {
        try{
            const { query_pswd} = req.query;
            if(query_pswd == PSWD){
                const { pharm_id } = req.query;
                //standard id check to see if it is present
                if(pharm_id != null){
                    // retrieve patient query
                    let pQuery = await pool.query(
                        "SELECT pharm_id FROM pharm_info WHERE pharm_id="+pharm_id
                    )
                    
                    //if it is empty, then send an error response
                    if(pQuery.rows[0] != null){
                        //if not we can put together array of patients
                        let patients  = [];

                        //retrieve user list from prec_info
                        pQuery = await pool.query(
                            "SELECT DISTINCT user_id FROM prec_info WHERE pharm_id="+pharm_id
                        );

                        patients = pQuery.rows;
                        let ptlist = [];

                        if(patients[0] == null){
                            ptlist = [];
                        } else{
                            for(i=0; i<patients.length;i++){
                                //assemble the user dictionary for each user id
                                ptlist.push(await getBasicUserInfo(patients[i].user_id));
                            }
                        }

                        res.status(200).send(ptlist);
                    } else {   
                        res.status(201).send("No pharmacy found");
                    }

                } else{
                    res.status(201).send("No PHARM ID provided");
                }

            } else{
                res.status(201).send("Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.status(201).send("Failure Handling Request");
        }
    });

    //PHARMACY GET PATIENT ACTIVE PRESCRIPTIONS ----------------------------------------------------
    //get all active prescriptions for a patients that the pharmacy services
    router.get(`/${objId}/pharm/patient/precs/active`, async(req,res) => {
        try{
            const { query_pswd} = req.query;
            if(query_pswd == PSWD){

                const { pharm_id, user_id } = req.query;

                if(pharm_id != null && user_id != null){
                    //make a call to the database to retrieve information for prescriptions
                    //med_name, med_strength, status_step_id, status_msg, is_completed, status_date
                    const selection = "*";
                    const whereClause = "user_id="+user_id+" and pharm_id="+pharm_id+" and is_completed=0";
                    let listOfPrecs = await pool.query(
                        "SELECT "+selection+" FROM prec_info WHERE "+whereClause
                    )
                    
                    
                    //now with list of prescriptions we can get to work
                    let activeList = [];
                    
                    for(i=0; i<listOfPrecs.rows.length; i++){
                        activeList.push(await getDescriptivePrecInfo_fromQuery(listOfPrecs.rows[i]))
                    }

                    res.status(200).send(sortPrecsByProgress(activeList));

                } else{
                    res.status(201).send("Insufficient information");
                }

            } else{
                res.status(201).send("Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.status(201).send("Failure Handling Request");
        }
    });

    //GET PATIENT HISSTORY FOR A PHARM ------------------------------------------------------------
    router.get(`/${objId}/pharm/patient/precs/history`, async(req,res) => {
        try{
            const { query_pswd} = req.query;
            if(query_pswd == PSWD){

                const { pharm_id, user_id } = req.query;

                if(pharm_id != null && user_id != null){
                    //make a call to the database to retrieve information for prescriptions
                    //med_name, med_strength, status_step_id, status_msg, is_completed, status_date
                    const selection = "*";
                    const whereClause = "user_id="+user_id+" and pharm_id="+pharm_id;
                    let listOfPrecs = await pool.query(
                        "SELECT "+selection+" FROM prec_info WHERE "+whereClause
                    )
                
                    //now with list of prescriptions we can get to work
                    let activeList = [];
                    
                    for(i=0; i<listOfPrecs.rows.length; i++){
                        activeList.push(await getDescriptivePrecInfo_fromQuery(listOfPrecs.rows[i]))
                    }

                    res.status(200).send(activeList);

                } else{
                    res.status(201).send("Insufficient information");
                }

            } else{
                res.status(201).send("Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.status(201).send("Failure Handling Request");
        }
    }); 

    // GET PHARM ACTIVE PRESCRIPTIONS --------------------------------------------------------------------
    router.get(`/${objId}/pharm/precs/active`, async(req,res) => {
        try{
            const { query_pswd} = req.query;
            if(query_pswd == PSWD){
                const {pharm_id} = req.query;

                let uQuery = await pool.query(
                    "SELECT pharm_id FROM pharm_info WHERE pharm_id="+pharm_id
                )

                if(uQuery.rows[0]!=null){
                    //just run a for loop to capture the information
                    let precs = [];

                    //active queries will have user id and are not completed
                    let precQueries = await pool.query(
                        "SELECT * FROM prec_info WHERE pharm_id="+pharm_id+" and is_completed=0"
                    );

                    //if there is at least one then set up prescription information.
                    if(precQueries.rows[0] != null){
                        for(i=0; i<precQueries.rows.length; i++){
                            precs.push(await getDescriptivePrecInfo_fromQuery(precQueries.rows[i]));
                        }
                    }
                    res.status(200).send(sortPrecsByProgress(precs));

                } else {
                    res.status(201).send("User Not Found");
                }

            } else{
                
                res.status(201).send("Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.status(201).send("Failure Handling Request");
        }
    });

    // GET PHARM HISTORY ---------------------------------------------------------------------------
    router.get(`/${objId}/pharm/precs/history`, async(req,res) => {
        try{
            const { query_pswd} = req.query;
            if(query_pswd == PSWD){
                const {pharm_id} = req.query;

                let uQuery = await pool.query(
                    "SELECT pharm_id FROM pharm_info WHERE pharm_id="+pharm_id
                )

                if(uQuery.rows[0]!=null){
                    //just run a for loop to capture the information
                    let precs = [];

                    //active queries will have user id and are not completed
                    let precQueries = await pool.query(
                        "SELECT * FROM prec_info WHERE pharm_id="+pharm_id
                    );

                    //if there is at least one then set up prescription information.
                    if(precQueries.rows[0] != null){
                        for(i=0; i<precQueries.rows.length; i++){
                            precs.push(await getDescriptivePrecInfo_fromQuery(precQueries.rows[i]));
                        }
                    }
                    res.status(200).send(precs);

                } else {
                    res.status(201).send("User Not Found");
                }

            } else{
                res.status(201).send("Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.status(201).send("Failure Handling Request");
        }
    });

    // SET MAX REFILLS (pharm authorization only) ----------------------------------------------------
    router.put(`/${objId}/precs/refills/set-max`, async(req,res) => {
        try{
            const { query_pswd} = req.query;
            if(query_pswd == PSWD){

                const { rx, pharm_id, max_refills } = req.query;
                //check if required information is provided

                if(rx!= null && pharm_id != null && max_refills != null){
                    //check if pharmacy exists
                    let pharmQuery =  await pool.query(
                        "SELECT pharm_id FROM pharm_info WHERE pharm_id="+pharm_id
                    );

                    if(pharmQuery.rows[0] != null){
                        //check if rx exists
                        let rxQuery = await pool.query(
                            "SELECT rx FROM prec_info WHERE rx='"+rx+"' and pharm_id="+pharm_id
                        );

                        if(rxQuery.rows[0] != null){
                            //now we can proceed with update
                            await pool.query(
                                "UPDATE prec_info SET max_refills="+max_refills+" WHERE rx='"+rx+"'"
                            )

                            //send out result
                            res.status(200).send(await getDescriptivePrecInfo(rx));

                        } else{
                            res.status(201).send("No prescription found");
                        }

                    } else{
                        res.status(201).send("No pharmacy found");
                    }

                } else{
                    res.status(201).send("Insufficient Information");
                }

            } else{
                res.status(201).send("Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.status(201).send("Failure Handling Request");
        }
    });


    //INCREASE REFILL (user or pharmacy) -----------------------------------------------------------
    router.put(`/${objId}/precs/refills/request-refill`, async(req,res) => {
        try{
            const { query_pswd} = req.query;
            if(query_pswd == PSWD){
                const { rx, user_id, pharm_id, request_amount } = req.query;
                let increase = request_amount;

                let sufficientInfo = (rx != null) && (pharm_id != null || user_id != null) && (increase != null);

                if(sufficientInfo){
                    let uQuery;
                    let pQuery;
                    if(user_id != null) uQuery = await pool.query(
                        "SELECT user_id FROM user_info WHERE user_id="+user_id
                    );

                    if(pharm_id != null) pQuery = await pool.query(
                        "SELECT pharm_id FROM pharm_info WHERE pharm_id="+pharm_id
                    )
                    
                    let reqe;
                    if(user_id != null){
                        reqe =  "SELECT rx, cur_refills, max_refills FROM prec_info WHERE rx='"+rx+"' and user_id="+user_id;
                    } else if(pharm_id != null){
                        reqe =  "SELECT rx, cur_refills, max_refills FROM prec_info WHERE rx='"+rx+"' and pharm_id="+pharm_id;
                    }

                    let rQuery = await pool.query(
                        reqe
                    )

                    let dataFound = ((user_id != null && uQuery.rows[0] != null) || (pharm_id != null && pQuery.rows[0] != null)) && (rQuery.rows[0]!=null)

                    if(dataFound){
                        //now make the update
                        new_refills = parseInt(rQuery.rows[0].cur_refills) + increase;
                        max_refills = parseInt(rQuery.rows[0].max_refills);
                        
                        isPharm = pharm_id != null;
                        if(isPharm || new_refills <= max_refills){
                            await pool.query(
                                "UPDATE prec_info SET cur_refills="+new_refills+" WHERE rx='"+rx+"'"
                            )

                            //now send the new version
                            res.status(200).send(await getDescriptivePrecInfo(rx));
                        } else{
                            res.status(201).send("Increase is larger than maximum refills")
                        }
                        
                    } else{
                        res.status(201).send("No accounts found");
                    }

                } else{
                    res.status(201).send("Insufficient Information");
                }

            } else{
                res.status(201).send("Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.status(201).send("Failure Handling Request");
        }
    });

    // RESET REFILLS (pharm authorization only) ----------------------------------------------------
    router.put(`/${objId}/precs/refills/reset-refill`, async(req,res) => {
        try{
            const { query_pswd} = req.query;
            if(query_pswd == PSWD){

                const { rx, pharm_id } = req.query;
                //check if required information is provided

                if(rx!= null && pharm_id != null){
                    //check if pharmacy exists
                    let pharmQuery =  await pool.query(
                        "SELECT pharm_id FROM pharm_info WHERE pharm_id="+pharm_id
                    );

                    if(pharmQuery.rows[0] != null){
                        //check if rx exists
                        let rxQuery = await pool.query(
                            "SELECT rx FROM prec_info WHERE rx='"+rx+"' and pharm_id="+pharm_id
                        );

                        if(rxQuery.rows[0] != null){
                            //now we can proceed with update
                            await pool.query(
                                "UPDATE prec_info SET cur_refills="+0+" WHERE rx='"+rx+"'"
                            )

                            //send out result
                            res.status(200).send(await getDescriptivePrecInfo(rx));

                        } else{
                            res.status(201).send("No prescription found");
                        }

                    } else{
                        res.status(201).send("No pharmacy found");
                    }

                } else{
                    res.status(201).send("Insufficient Information");
                }

            } else{
                res.status(201).send("Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.status(201).send("Failure Handling Request");
        }
    });

    //USER LOG IN -------------------------------------------------------------------------------
    router.get(`/${objId}/user/login`, async(req,res) => {
        try{
            //console.log(req.query);
            const {query_pswd} = req.query;
            if(query_pswd == PSWD){
                let {user_id, phone_no, email, password } = req.query;
                //console.log("HERE");
                let secQuery;
                if(user_id != null && password != null){
                    secQuery  = await pool.query(
                        "SELECT user_id, email, phone_no FROM user_sec_info WHERE user_id=$1",
                        [user_id]
                    );
                    //console.log("here");
                    //res.status(200).send(secQuery);
                } else if (email != null && password != null){
                    secQuery  = await pool.query(
                        "SELECT user_id, email, phone_no FROM user_sec_info WHERE email=$1",
                        [email]
                    );

                } else if(phone_no != null && password != null){
                    secQuery  = await pool.query(
                        "SELECT user_id, email, phone_no FROM user_sec_info WHERE phone_no=$1",
                        [phone_no]
                    );

                } else{
                    //no information so send a simple message
                    res.status(201).send("No Provided Keys");
                }

                if(secQuery.rows[0] == null || secQuery.rows[0] == undefined ){
                    res.status(201).send("No User Found");
                } else{
                    let userMatch = (user_id == null) ||  (user_id == secQuery.rows[0].user_id);
                    let emailMatch = (email == null) ||  (email == secQuery.rows[0].email);
                    let phoneMatch = (phone_no == null) ||  (phone_no == secQuery.rows[0].phone_no);

                    if(!userMatch || !emailMatch || !phoneMatch){
                        res.status(201).send("Account Info and Provided Info Do Not Match");
                    } else{
                        //confirmed user provided identity
                        //now confirm the password

                        user_id = secQuery.rows[0].user_id;
                        email = secQuery.rows[0].email;
                        phone_no = secQuery.rows[0].phone_no;

                        //first retrieve the security query
                        secQuery = await pool.query(
                            "SELECT password FROM user_sec_info WHERE user_id=$1",
                            [user_id]
                        );

                        if(password == secQuery.rows[0].password){
                            //this is valid info so send the basic user information
                            res.status(200).send(await getBasicUserInfo(user_id));
                        } else{
                            //not valid information 
                            res.status(201).send("Incorrect Password");
                        }

                    }
                }
            } else{
                res.status(201).send("Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.status(201).send("Failure Handling Request");
        }
    });

    //PHARM LOG IN
    router.get(`/${objId}/pharm/login`, async(req,res) => {
        try{
            const {query_pswd} = req.query;
            if(query_pswd == PSWD){
                let {pharm_id, phone_no, email, password } = req.query;
                let secQuery;
                if(pharm_id != null && password != null){
                    secQuery  = await pool.query(
                        "SELECT pharm_id, email, phone_no FROM pharm_sec_info WHERE pharm_id=$1",
                        [user_id]
                    );
                    //console.log("here");
                    //res.status(200).send(secQuery);
                } else if (email != null && password != null){
                    secQuery  = await pool.query(
                        "SELECT pharm_id, email, phone_no FROM pharm_sec_info WHERE email=$1",
                        [email]
                    );

                } else if(phone_no != null && password != null){
                    secQuery  = await pool.query(
                        "SELECT pharm_id, email, phone_no FROM pharm_sec_info WHERE phone_no=$1",
                        [phone_no]
                    );

                } else{
                    //no information so send a simple message
                    res.status(201).send("No Provided Keys");
                }


                if(secQuery.rows[0] == null || secQuery.rows[0] == undefined ){
                    res.status(201).send("No User Found");
                } else{
                    let pharmMatch = (pharm_id == null) ||  (pharm_id == secQuery.rows[0].pharm_id);
                    let emailMatch = (email == null) ||  (email == secQuery.rows[0].email);
                    let phoneMatch = (phone_no == null) ||  (phone_no == secQuery.rows[0].phone_no);

                    if(!pharmMatch || !emailMatch || !phoneMatch){
                        res.status(201).send("Account Info and Provided Info Do Not Match");
                    } else{
                        //confirmed pharm provided identity
                        //now confirm the password

                        pharm_id = secQuery.rows[0].pharm_id;
                        email = secQuery.rows[0].email;
                        phone_no = secQuery.rows[0].phone_no;

                        //first retrieve the security query
                        secQuery = await pool.query(
                            "SELECT password FROM pharm_sec_info WHERE pharm_id=$1",
                            [pharm_id]
                        );

                        if(password == secQuery.rows[0].password){
                            //this is valid info so send the basic user information
                            res.status(200).send(await getBasicPharmInfo(pharm_id));
                        } else{
                            //not valid information 
                            res.status(201).send("Incorrect Password");
                        }

                    }
                }
            } else{
                res.status(201).send("Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.status(201).send("Failure Handling Request");
        }
    });

};



findBiggest = (min, max, precArray) => {
    
    let i;
    let bigIndx = min;
    let iprog = 0;
    let smallprog = 0;
    
    for(i=min; i<=max; i++){
        //console.log(i);
        if(parseInt(precArray[i].progress) === 6) iprog = 0;
        else iprog = parseInt(precArray[i].progress);

        if(parseInt(precArray[bigIndx].progress) === 6) smallprog = 0;
        else smallprog = parseInt(precArray[bigIndx].progress);
    

        if( iprog > smallprog ){
            bigIndx = i;
            //console.log("Biggest:")
            //console.log(precArray[bigIndx]);
        }
    }

    return bigIndx;
}

sortPrecsByProgress = (precArray) => {
    let bigIndx , temp;
    let i= 0;
    let min = 0;
    let max = precArray.length-1;
    
    if(max > min){
       for(i=min;i<=max;i++){
        bigIndx = findBiggest(i,max, precArray);

        temp = precArray[i];
        precArray[i] = precArray[bigIndx];
        precArray[bigIndx] = temp;

       }
    }

    return precArray;
}