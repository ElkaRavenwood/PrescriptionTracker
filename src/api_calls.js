//ROUTER FOR API CALLS
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

deactivatePrescription = async (rx) => {
    //transfer a prescription from the active list to the history list
    //for both pharm and user
    //get lists for both pharm and user
    //get precInfo first
    let precInfo = await getPrecInfo(rx);
    let user_id = precInfo.user_id;
    let pharm_id = precInfo.pharm_id;

    let myQuery = await pool.query(
        "SELECT precs_active FROM user_info WHERE user_id="+user_id
    );

    let user_active = myQuery.rows[0].precs_active;

    myQuery = await pool.query(
        "SELECT precs_active FROM pharm_info WHERE pharm_id="+pharm_id
    );

    let pharm_active = myQuery.rows[0].precs_active;

    //now perform the transfer from active to history
    
    //user
    //check if there is a transfer to be made
    if(user_active == null){
        user_active = [];
    } else{
        //filter the user_active list for the item
        user_active = user_active.filter((act_rx) => {
            return act_rx != rx;
        });
    }
    

    //repeat the same for pharmacy
    if(pharm_active == null){
        pharm_active = [];
    } else{
        //filter the user_active list for the item
        pharm_active = pharm_active.filter((act_rx) => {
            return act_rx != rx;
        });
    }
    
    //now make updates to the repo
    await pool.query(
        "UPDATE user_info SET precs_active=$1 WHERE user_id="+user_id,
        [JSON.stringify(user_active)]
    );

    await pool.query(
        "UPDATE pharm_info SET precs_active=$1 WHERE pharm_id="+pharm_id,
        [JSON.stringify(pharm_active)]
    );
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

module.exports = async(router) => {
    //TEST ---------------------------------------------------------------
    router.get(`/${objId}/test`, async (req, res) => {
        console.log("HERE IN TEST");
        try{
             res.send( await getBasicUserInfo(1))
        } catch(err){
            console.log(err.message);
            res.send("ERROR: Failure Handling Request")
        }
    });

    router.get(`/${objId}/forme/:id`, async (req, res) => {
       // console.log("HERE IN TEST2");
        try{
            console.log("HERE IN TEST2");
            //let response = fetch("http://localhost:8000/meditrack/test")
            console.log("RESPONSE: ");
            console.log(response)
            res.send(response)
        } catch(err){
            res.send(err);
        }
    });

    //GET USER ACCOUNT INFO via ID, EMAIL, or PHONE NO -------------------------------------------------
    router.get(`/${objId}/user/account/info`, async(req,res) => {
        console.log(`API CALL: GET -> /${objId}/user/account/info`);
        try{
            const { query_pswd } = req.body;
            if(query_pswd == PSWD){
                let {user_id, phone_no, email } = req.body;
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
                    res.send("ERROR: No Provided Keys");
                }

                if(accQuery.rows[0] == null){
                    res.send("ERROR: No User Found");
                } else{
                    let userMatch = (user_id == null) ||  (user_id == accQuery.rows[0].user_id);
                    let emailMatch = (email == null) ||  (email == accQuery.rows[0].email);
                    let phoneMatch = (phone_no == null) ||  (phone_no == accQuery.rows[0].phone_no);

                    if(!userMatch || !emailMatch || !phoneMatch){
                        res.send("ERROR: Account Info and Provided Info Do Not Match");
                    } else{
                        //confirmed user provided identity can now start building dictionary
                        //res.send(accQuery.rows[0]);

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

                        res.send(outputDix);

                    }
                }
            } else{
                res.send("ERROR: Illegal Query")
            }

        } catch(err){
            console.log(err);
        }
    });

    //GET USER SECUCRITY INFO via ID, EMAIL, or PHONE NO -------------------------------------------------
    router.get(`/${objId}/user/account/security`, async(req,res) => {
        console.log(`API CALL: GET -> /${objId}/user/account/security`);
        try{
            const {query_pswd} = req.body;
            if(query_pswd == PSWD){
                let {user_id, phone_no, email } = req.body;
                let secQuery;
                if(user_id != null){
                    secQuery  = await pool.query(
                        "SELECT user_id, email, phone_no FROM user_sec_info WHERE user_id=$1",
                        [user_id]
                    );
                    //console.log("here");
                    //res.send(secQuery);
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
                    res.send("ERROR: No Provided Keys");
                }

                if(secQuery.rows[0] == null){
                    res.send("ERROR: No User Found");
                } else{
                    let userMatch = (user_id == null) ||  (user_id == secQuery.rows[0].user_id);
                    let emailMatch = (email == null) ||  (email == secQuery.rows[0].email);
                    let phoneMatch = (phone_no == null) ||  (phone_no == secQuery.rows[0].phone_no);

                    if(!userMatch || !emailMatch || !phoneMatch){
                        res.send("ERROR: Account Info and Provided Info Do Not Match");
                    } else{
                        //confirmed user provided identity can now start building dictionary
                        //res.send(accQuery.rows[0]);

                        user_id = secQuery.rows[0].user_id;
                        email = secQuery.rows[0].email;
                        phone_no = secQuery.rows[0].phone_no;

                        //first retrieve the security query
                        secQuery = await pool.query(
                            "SELECT user_id, email, phone_no, password, sec_quest_1, sec_ans_1, sec_quest_2, sec_ans_2, sec_quest_3, sec_ans_3 FROM user_sec_info WHERE user_id=$1",
                            [user_id]
                        );

                        res.send(secQuery.rows[0]);

                    }
                }
            } else{
                res.send("ERROR: Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.send("ERROR: Failure Handling Request");
        }
    });

    //POST USER ACCOUNT INFORMATION ON SIGN UP ----------------------------------------------------------------
    router.post(`/${objId}/user/account`, async(req, res) => {
        try{
            const {query_pswd} = req.body;
            if(query_pswd == PSWD){
                //assume that all the fields are available with the request
                //if not handle null fields appropriately

                let {first_name, last_name, email, phone_no} = req.body;
                let {street_address, city, postal_code} = req.body;
                let {password, healthcard_no} = req.body;
                let {sec_quest_1, sec_quest_2, sec_quest_3} = req.body;
                let {sec_ans_1, sec_ans_2, sec_ans_3} = req.body;

                //perform the appropriate error checking
                noName = (first_name == null) || (last_name == null);
                noIdentifier = (email == null) && (phone_no == null);
                noPassword = (password == null);

                if(!noName && !noIdentifier && !noPassword){
                    //first store information into user_info table
                    //then retrieve the user_id
                    //console.log("HERE1");
                    let infoQuery = await pool.query(
                        "INSERT INTO user_info(first_name, last_name, email, phone_no, precs_active, precs_history) VALUES($1,$2,$3,$4,$5,$6) RETURNING *",
                        [first_name, last_name, email, phone_no, null, null]
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
                    res.send(infoQuery.rows[0]);

                } else {
                    res.send("ERROR: Insufficient Information");
                }

            } else{
                res.send("ERROR: Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.send("ERROR: Failure Handling Request");
        }
    });

    //GET USER SECURITY QUESTIONS --------------------------------------------------------------------------
    router.get(`/${objId}/security/questions`, async(req,res) => {
        try{
            const { query_pswd } = req.body;
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
                res.send(questions);
            } else{
                res.send("ERROR: Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.send("ERROR: Failure Handling Request");
        }
    });

    //UPDATE USER ACCOUNT INFORMATION ---------------------------------------------------------
    router.put(`/${objId}/user/account/info`, async(req,res) => {
        try{
            const { query_pswd} = req.body;
            if(query_pswd == PSWD){
                //first confirm the user identity 
                let {user_id } = req.body;
                let secQuery;
                if(user_id != null){
                    secQuery  = await pool.query(
                        "SELECT user_id, email, phone_no FROM user_sec_info WHERE user_id=$1",
                        [user_id]
                    );
                    //console.log("here");
                    //res.send(secQuery);
                    
                } else{
                    //no information so send a simple message
                    res.send("ERROR: No Provided Key");
                }

                if(secQuery.rows[0] == null){
                    res.send("ERROR: No User Found");
                } else{
                    //we want t
                    let { first_name, last_name, email, phone_no} = req.body;
                    let { healthcard_no, street_address, city, postal_code} = req.body;
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
                        res.send({
                            user_id: user_id,
                            update_status: 1,
                            update_msg: "Update Successful"
                        });
                    } else if (!updateVal && (updateCols !="" || updateSecCols !="") ) {
                        res.send({
                            user_id: user_id,
                            update_status: 0,
                            update_msg: "An error occured"
                        });
                    } else{
                        res.send({
                            user_id: user_id,
                            update_status: 1,
                            update_msg: "No fields to update"
                        });
                    }  
                }

            } else{
                res.send("ERROR: Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.send("ERROR: Failure Handling Request");
        }
    });

    //UPDATE USER SECURITY INFORMATION --------------------------------------------------------------------
    router.put(`/${objId}/user/account/security`, async(req,res) => {
        try{
            const { query_pswd} = req.body;
            if(query_pswd == PSWD){
                //first confirm the user identity 
                let {user_id } = req.body;
                let secQuery;
                if(user_id != null){
                    secQuery  = await pool.query(
                        "SELECT user_id, email, phone_no FROM user_sec_info WHERE user_id=$1",
                        [user_id]
                    );
                    //console.log("here");
                    //res.send(secQuery);
                    
                } else{
                    //no information so send a simple message
                    res.send("ERROR: No Provided Key");
                }

                if(secQuery.rows[0] == null){
                    res.send("ERROR: No User Found");
                } else{
                    //we want t
                    let {password} = req.body;
                    let {sec_quest_1, sec_quest_2, sec_quest_3} = req.body;
                    let {sec_ans_1, sec_ans_2, sec_ans_3} = req.body;
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
                        res.send({
                            user_id: user_id,
                            update_status: 1,
                            update_msg: "Update Successful"
                        });
                    } else if (!updateVal && updateSecCols !="") {
                        res.send({
                            user_id: user_id,
                            update_status: 0,
                            update_msg: "An error occured"
                        });
                    } else{
                        res.send({
                            user_id: user_id,
                            update_status: 1,
                            update_msg: "No fields to update"
                        });
                    }   
                }

            } else{
                res.send("ERROR: Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.send("ERROR: Failure Handling Request");
        }
    });

    //POST A PRESCRIPTION ------------------------------------------------------------
    router.post(`/${objId}/precs`, async(req,res) => {
        try{
            const  {query_pswd} = req.body;
            if(query_pswd == PSWD){
                let { rx, user_id, pharm_id, status_date } = req.body;
                let {med_name, med_strength, status_msg} = req.body; 

                let fields;
                let precQuery;
                let userQuery;
                let pharmQuery;

                if(rx == null || user_id == null || pharm_id == null || status_date == null){
                    res.send("ERROR: Insufficient Information");
                } else{
                    precQuery = await pool.query(
                       "SELECT * FROM prec_info WHERE rx='"+rx+"'"
                    );
                      
                    if(precQuery.rows[0] != null){
                        res.send("ERROR: Prescription Already Exists In Database");

                    } else{
                        //first create the information to post
                        fields = "rx,med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date";
                        precQuery =  await pool.query(
                            "INSERT INTO prec_info("+fields+") VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9) RETURNING *",
                            [rx, med_name, med_strength, user_id, pharm_id, 1, status_msg, 0, status_date ]
                        );
                        
                        //need to update user active prescriptions and history
                        userQuery = await pool.query(
                            "SELECT precs_active, precs_history FROM user_info WHERE user_id="+user_id
                        );

                        let precs_active = userQuery.rows[0].precs_active;
                        let precs_history = userQuery.rows[0].precs_history;
                        
                        console.log("HERE1");
                        if(precs_active == null) precs_active = [];
                        console.log("HERE2");
                        if(precs_history == null) precs_history = [];
                    
                        precs_active.push(rx);
                        precs_history.unshift(rx);

                        userQuery = await pool.query(
                            "UPDATE user_info SET precs_active='"+JSON.stringify(precs_active)+"', precs_history='"+JSON.stringify(precs_history)+"' WHERE user_id="+user_id
                        )

                        //need to update pharmacy active prescriptions and prescription history
                        //also add user to patients if not already present
                        pharmQuery = await pool.query(
                            "SELECT precs_active, precs_history, patients FROM pharm_info WHERE pharm_id="+pharm_id
                        );

                        precs_active = pharmQuery.rows[0].precs_active;
                        precs_history = pharmQuery.rows[0].precs_history;
                        let patients = pharmQuery.rows[0].patients;

                        //console.log("HERE1");
                        if(precs_active == null) precs_active = [];
                        //console.log("HERE2");
                        if(precs_history == null) precs_history = [];
                    
                        precs_active.push(rx);
                        precs_history.unshift(rx);

                        //filter patients list so that user is not already in there
                        if(patients == null){
                            patients = [];

                        } else{
                            patients = patients.filter((pt_id) => {
                                return pt_id != user_id;
                            });
                            //add user
                        }
                        patients.unshift(user_id);

                        pharmQuery = await pool.query(
                            "UPDATE pharm_info SET precs_active='"+JSON.stringify(precs_active)+"', precs_history='"+JSON.stringify(precs_history)+"', patients='"+JSON.stringify(patients)+"' WHERE pharm_id="+pharm_id
                        )

                        res.send(precQuery.rows[0]);
                    }
                }


            } else{
                res.send("ERROR: Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.send("ERROR: Failure Handling Request");
        }
    });

    //GET A GIVEN PRESCRIPTION ---------------------------------------------------------------
    router.get(`/${objId}/precs/info`, async(req,res) => {
        try{
            const { query_pswd} = req.body;
            if(query_pswd == PSWD){
                const { rx } = req.body;
                let precDescInfo = await getDescriptivePrecInfo(rx);
                if(precDescInfo == null){
                    res.send("ERROR: No Prescription Found");
                } else {
                    res.send(precDescInfo);
                }
            } else{
                res.send("ERROR: Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.send("ERROR: Failure Handling Request");
        }
    });
      

    //GET ALL ACTIVE PRECS FOR A GIVEN USER ID ---------------------------------------------------------------
    router.get(`/${objId}/user/precs/active`, async(req,res) => {
        try{
            const { query_pswd} = req.body;
            if(query_pswd == PSWD){
                const {user_id} = req.body;

                let uQuery = await pool.query(
                    "SELECT precs_active FROM user_info WHERE user_id="+user_id
                )

                if(uQuery.rows[0]!=null){
                    //just run a for loop to capture the information
                    let precs = [];
                    precs_active = uQuery.rows[0].precs_active;

                    if(precs_active == null){
                        res.send(precs)
                    } else{
                        //let sel = constructBulkPrecRequest(precs_active);

                        let precQueries = await pool.query(
                            "SELECT * FROM prec_info WHERE user_id="+user_id+" and is_completed=0"
                        );

                        //console.log(precQueries.rows);

                        for(i=0; i<precQueries.rows.length; i++){
                            precs.push(await getDescriptivePrecInfo_fromQuery(precQueries.rows[i]));
                        }
                        res.send(precs);
                    }

                } else {
                    res.send("ERROR: User Not Found");
                }

            } else{
                res.send("ERROR: Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.send("ERROR: Failure Handling Request");
        }
    });
    
    //GET ALL PRECS (HISTORY) FOR A GIVEN USER ID ---------------------------------------------------------------
    router.get(`/${objId}/user/precs/history`, async(req,res) => {
        try{
            const { query_pswd} = req.body;
            if(query_pswd == PSWD){
                const {user_id} = req.body;

                let uQuery = await pool.query(
                    "SELECT precs_history FROM user_info WHERE user_id="+user_id
                )

                if(uQuery.rows[0]!=null){
                    //just run a for loop to capture the information
                    let precs = [];
                    precs_history = uQuery.rows[0].precs_history;

                    if(precs_history == null){
                        res.send(precs)
                    } else{
                        let precQueries = await pool.query(
                            "SELECT * FROM prec_info WHERE user_id="+user_id
                        );

                        //console.log(precQueries.rows);

                        for(i=0; i<precQueries.rows.length; i++){
                            precs.push(await getDescriptivePrecInfo_fromQuery(precQueries.rows[i]));
                        }
                        res.send(precs);
                    }

                } else {
                    res.send("ERROR: User Not Found");
                }

            } else{
                res.send("ERROR: Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.send("ERROR: Failure Handling Request");
        }
    });

    //UPDATE A PRESCRIPTION PROGRESS--------------------------------------------------------------------
    router.put(`/${objId}/precs/progress`, async(req,res) => {
        try{
            const { query_pswd} = req.body;
            if(query_pswd == PSWD){
                //first of all check to make sure prescription is in library
                const { rx } = req.body;
                if(rx != null){
                    let mq = await pool.query(
                        "SELECT rx FROM prec_info WHERE rx='"+rx+"'"
                    );
                    

                    if(mq.rows[0] != null){

                        //now check if status date is there
                        const { status_date, progress, status_msg, is_completed } = req.body;

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

                                res.send(await getDescriptivePrecInfo(rx));
                            } else{
                                res.send("No Progress ID Provided")
                            }


                        } else{
                            res.send("No update date provided");
                        }

                    } else{
                        res.send("ERROR: No Prescription Found");
                    }

                } else{

                    res.send("ERROR: No RX provided");
                }
            } else{
                res.send("ERROR: Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.send("ERROR: Failure Handling Request");
        }
    });

    //UPDATE PRESCRIPTION INFORMATION --------------------------------------------------------------------
    router.put(`/${objId}/precs/info`, async(req,res) => {
        try{
            const { query_pswd} = req.body;
            if(query_pswd == PSWD){
                const { rx } = req.body;
                if(rx != null){
                    //check if the prescription is in database
                    let myQuery = await pool.query(
                        "SELECT * FROM prec_info WHERE rx='"+rx+"'"
                    );

                    if(myQuery.rows[0] != null){
                        //grab the fields in the query
                        let { med_name, med_strength } = req.body;

                        let fields = "";

                        if(med_name != null) fields = fields + "med_name='"+med_name+"', ";
                        if(med_strength != null) fields = fields + "med_strength='"+med_strength+"', ";

                        fields = fields + "rx='"+rx+"'";

                        //make the update

                        let upQuery = await pool.query(
                            "UPDATE prec_info SET "+fields+" WHERE rx='"+rx+"'"
                        );

                        res.send(await getDescriptivePrecInfo(rx));

                    } else{
                        res.send("ERROR: No prescription found for provided RX");
                    }

                } else{
                    res.send("ERROR: No RX provided");
                }

            } else{
                res.send("ERROR: Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.send("ERROR: Failure Handling Request");
        }
    });

    //GET PROGRESS STEPS --------------------------------------------------------------------------------
    router.get(`/${objId}/precs/progress/steps`, async(req,res) => {
        try{
            const { query_pswd} = req.body;
            if(query_pswd == PSWD){
                let steps = {
                    1: "Received",
                    2: "Logged",
                    3: "Pharmacist Verification",
                    4: "Packaging",
                    5: "Ready for Pick Up",
                    6: "NOMESSAGE"
                }

                res.send(steps);

            } else{
                res.send("ERROR: Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.send("ERROR: Failure Handling Request");
        }
    });

    //COMPLETE A PRESCRIPTION
    router.put(`/${objId}/precs/progress/complete`, async(req,res) => {
        try{
            const { query_pswd} = req.body;
            if(query_pswd == PSWD){

                const { rx } = req.body;
                if(rx != null){
                    let prec = await getDescriptivePrecInfo(rx);
                    if(prec != null){
                        //now make the update
                        await pool.query(
                            "UPDATE prec_info SET is_completed="+1+" WHERE rx='"+rx+"'"
                        );

                        //then deactivate the prescription in user and pharm info
                        await deactivatePrescription(rx);

                        //send the updated prescription.
                        prec.is_completed = 1;
                        res.send(prec);

                    } else{
                        res.send("ERROR: No prescription found")
                    }
                } else{
                    res.send("ERROR: No RX provided")
                }

            } else{
                res.send("ERROR: Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.send("ERROR: Failure Handling Request");
        }
    });

        //POST USER ACCOUNT INFORMATION ON SIGN UP ----------------------------------------------------------------
    router.post(`/${objId}/user/account`, async(req, res) => {
        try{
            const {query_pswd} = req.body;
            if(query_pswd == PSWD){
                //assume that all the fields are available with the request
                //if not handle null fields appropriately

                let {first_name, last_name, email, phone_no} = req.body;
                let {street_address, city, postal_code} = req.body;
                let {password, healthcard_no} = req.body;
                let {sec_quest_1, sec_quest_2, sec_quest_3} = req.body;
                let {sec_ans_1, sec_ans_2, sec_ans_3} = req.body;

                //perform the appropriate error checking
                noName = (first_name == null) || (last_name == null);
                noIdentifier = (email == null) && (phone_no == null);
                noPassword = (password == null);

                if(!noName || !noIdentifier || !noPassword){
                    //first store information into user_info table
                    //then retrieve the user_id
                    //console.log("HERE1");
                    let infoQuery = await pool.query(
                        "INSERT INTO user_info(first_name, last_name, email, phone_no, precs_active, precs_history) VALUES($1,$2,$3,$4,$5,$6) RETURNING *",
                        [first_name, last_name, email, phone_no, null, null]
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
                    res.send(infoQuery.rows[0]);

                } else {
                    res.send("ERROR: Insufficient Information");
                }

            } else{
                res.send("ERROR: Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.send("ERROR: Failure Handling Request");
        }
    });

    //POST PHARM ACCOUNT INFORMATION ON SIGN UP ----------------------------------------------------------------
    router.post(`/${objId}/pharm/account`, async(req, res) => {
        try{
            const {query_pswd} = req.body;
            if(query_pswd == PSWD){
                //assume that all the fields are available with the request
                //if not handle null fields appropriately

                let {name, email, phone_no} = req.body;
                let {street_address, city, postal_code} = req.body;
                let {password } = req.body;
                let {sec_quest_1, sec_quest_2, sec_quest_3} = req.body;
                let {sec_ans_1, sec_ans_2, sec_ans_3} = req.body;

                //perform the appropriate error checking
                noName = (name == null);
                noIdentifier = (email == null) && (phone_no == null);
                noPassword = (password == null);

                if(!noName && !noIdentifier && !noPassword){
                    //first store information into pharm_info table
                    //then retrieve the pharm_id
                    
                    let infoQuery = await pool.query(
                        "INSERT INTO pharm_info(name, email, phone_no, street_address, city, postal_code, precs_active, precs_history, patients) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9) RETURNING *",
                        [name, email, phone_no, street_address, city, postal_code, null, null, null]
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
                    res.send(infoQuery.rows[0]);

                } else {
                    res.send("ERROR: Insufficient Information");
                }

            } else{
                res.send("ERROR: Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.send("ERROR: Failure Handling Request");
        }
    });

    //GET PHARM ACCOUNT INFO ---------------------------------------------------------------------
    router.get(`/${objId}/pharm/account/info`, async(req,res) => {
        //console.log(`API CALL: GET -> /${objId}/user/account/info`);
        try{
            const { query_pswd } = req.body;
            if(query_pswd == PSWD){
                let {pharm_id, phone_no, email } = req.body;
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
                    res.send("ERROR: No provided keys");
                }

                if(accQuery.rows[0] == null){
                    //if the query is not present, then the account does not exist
                    res.send("ERROR: No Pharmacy Account Found");
                } else{
                    let pharmMatch = (pharm_id == null) ||  (pharm_id == accQuery.rows[0].pharm_id);
                    let emailMatch = (email == null) ||  (email == accQuery.rows[0].email);
                    let phoneMatch = (phone_no == null) ||  (phone_no == accQuery.rows[0].phone_no);

                    if(!pharmMatch || !emailMatch || !phoneMatch){
                        res.send("ERROR: Account Info or Provided Info Do Not Match");
                    } else{
                        //confirmed user provided identity can now start building dictionary
                        //res.send(accQuery.rows[0]);

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

                        res.send(outputDix);

                    }
                }
            } else{
                res.send("ERROR: Illegal Query")
            }

        } catch(err){
            console.log(err);
        }
    });

    // GET PHARM SECURITY INFO ----------------------------------------------------------
    router.get(`/${objId}/pharm/account/security`, async(req,res) => {
        //console.log(`API CALL: GET -> /${objId}/user/account/info`);
        try{
            const { query_pswd } = req.body;
            if(query_pswd == PSWD){
                let {pharm_id, phone_no, email } = req.body;
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
                    res.send("ERROR: No provided keys");
                }

                if(accQuery.rows[0] == null){
                    //if the query is not present, then the account does not exist
                    res.send("ERROR: No Pharmacy Account Found");
                } else{
                    let pharmMatch = (pharm_id == null) ||  (pharm_id == accQuery.rows[0].pharm_id);
                    let emailMatch = (email == null) ||  (email == accQuery.rows[0].email);
                    let phoneMatch = (phone_no == null) ||  (phone_no == accQuery.rows[0].phone_no);

                    if(!pharmMatch || !emailMatch || !phoneMatch){
                        res.send("ERROR: Account Info or Provided Info Do Not Match");
                    } else{
                        //confirmed user provided identity can now start building dictionary
                        //res.send(accQuery.rows[0]);

                        pharm_id = accQuery.rows[0].pharm_id;
                        email = accQuery.rows[0].email;
                        phone_no = accQuery.rows[0].phone_no;

                        secQuery = await pool.query(
                            "SELECT pharm_id, email, phone_no, password, sec_quest_1, sec_ans_1, sec_quest_2, sec_ans_2, sec_quest_3, sec_ans_3 FROM pharm_sec_info WHERE pharm_id=$1",
                            [pharm_id]
                        )

                        res.send(secQuery.rows[0]);

                    }
                }
            } else{
                res.send("ERROR: Illegal Query")
            }

        } catch(err){
            console.log(err);
        }
    }); 

    //UPDATE PHARM ACCOUNT INFO ------------------------------------------------------------
    router.put(`/${objId}/pharm/account/info`, async(req,res) => {
        try{
            const { query_pswd} = req.body;
            if(query_pswd == PSWD){
                //first confirm the user identity 
                let {pharm_id } = req.body;
                let secQuery;
                if(pharm_id != null){
                    secQuery  = await pool.query(
                        "SELECT pharm_id, email, phone_no FROM pharm_sec_info WHERE pharm_id=$1",
                        [pharm_id]
                    );
                    //console.log("here");
                    //res.send(secQuery);
                    
                } else{
                    //no information so send a simple message
                    res.send("ERROR: No Provided Key");
                }

                if(secQuery.rows[0] == null){
                    res.send("ERROR: No Pharmacy Found");
                } else{
                    //get the optional parms from the request
                    let { name, email, phone_no} = req.body;
                    let { street_address, city, postal_code} = req.body;
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
                        res.send({
                            pharm_id: pharm_id,
                            update_status: 1,
                            update_msg: "Update Successful"
                        });
                    } else if (!updateVal && (updateCols !="" || updateSecCols !="")) {
                        res.send({
                            pharm_id: pharm_id,
                            update_status: 0,
                            update_msg: "An error occured"
                        });
                    } else{
                        res.send({
                            pharm_id: pharm_id,
                            update_status: 1,
                            update_msg: "No fields to update"
                        });
                    }  
                }

            } else{
                res.send("ERROR: Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.send("ERROR: Failure Handling Request");
        }
    });

    //UPDATE PHARM SECURITY INFO ---------------------------------------------------------------
    router.put(`/${objId}/pharm/account/security`, async(req,res) => {
        try{
            const { query_pswd} = req.body;
            if(query_pswd == PSWD){
                //first confirm the pharm identity 
                let {pharm_id } = req.body;
                let secQuery;
                if(pharm_id != null){
                    secQuery  = await pool.query(
                        "SELECT pharm_id, email, phone_no FROM pharm_sec_info WHERE pharm_id=$1",
                        [pharm_id]
                    );
                   
                    
                } else{
                    //no information so send a simple message
                    res.send("ERROR: No Provided Key");
                }

                if(secQuery.rows[0] == null){
                    res.send("ERROR: No User Found");
                } else{
                    //retrieve information from request body
                    let {password} = req.body;
                    let {sec_quest_1, sec_quest_2, sec_quest_3} = req.body;
                    let {sec_ans_1, sec_ans_2, sec_ans_3} = req.body;
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
                        res.send({
                            pharm_id: pharm_id,
                            update_status: 1,
                            update_msg: "Update Successful"
                        });
                    } else if (!updateVal &&  updateSecCols !="") {
                        res.send({
                            pharm_id: pharm_id,
                            update_status: 0,
                            update_msg: "An error occured"
                        });
                    } else{
                        res.send({
                            pharm_id: pharm_id,
                            update_status: 1,
                            update_msg: "No fields to update"
                        });
                    }   
                }

            } else{
                res.send("ERROR: Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.send("ERROR: Failure Handling Request");
        }
    });

    // PHARMACY GET PATIENTS ------------------------------------------------------------------
    router.get(`/${objId}/pharm/patients`, async(req,res) => {
        try{
            const { query_pswd} = req.body;
            if(query_pswd == PSWD){
                const { pharm_id } = req.body;
                //standard id check to see if it is present
                if(pharm_id != null){
                    // retrieve patient query
                    let pQuery = await pool.query(
                        "SELECT patients FROM pharm_info WHERE pharm_id="+pharm_id
                    )
                    
                    //if it is empty, then send an error response
                    if(pQuery.rows[0] != null){
                        //now put together the user array
                        let patients  = [];
                        patients = pQuery.rows[0].patients;
                        let ptlist = [];

                        if(patients == null){
                            ptlist = [];
                        } else{
                            for(i=0; i<patients.length;i++){
                                //assemble the user dictionary for each user id
                                ptlist.push(await getBasicUserInfo(patients[i]));
                            }
                        }

                        res.send(ptlist);
                    } else {   
                        res.send("ERROR: No pharmacy found");
                    }

                } else{
                    res.send("ERROR: No PHARM ID provided");
                }

            } else{
                res.send("ERROR: Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.send("ERROR: Failure Handling Request");
        }
    });

    //PHARMACY GET PATIENT ACTIVE PRESCRIPTIONS ----------------------------------------------------
    //get all active prescriptions for a patients that the pharmacy services
    router.get(`/${objId}/pharm/patient/precs/active`, async(req,res) => {
        try{
            const { query_pswd} = req.body;
            if(query_pswd == PSWD){

                const { pharm_id, user_id } = req.body;

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

                    res.send(activeList);

                } else{
                    res.send("ERROR: Insufficient information");
                }

            } else{
                res.send("ERROR: Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.send("ERROR: Failure Handling Request");
        }
    });

    //GET PATIENT HISSTORY FOR A PHARM ------------------------------------------------------------
    router.get(`/${objId}/pharm/patient/precs/history`, async(req,res) => {
        try{
            const { query_pswd} = req.body;
            if(query_pswd == PSWD){

                const { pharm_id, user_id } = req.body;

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

                    res.send(activeList);

                } else{
                    res.send("ERROR: Insufficient information");
                }

            } else{
                res.send("ERROR: Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.send("ERROR: Failure Handling Request");
        }
    }); 

    // GET PHARM ACTIVE PRESCRIPTIONS --------------------------------------------------------------------
    router.get(`/${objId}/pharm/precs/active`, async(req,res) => {
        try{
            const { query_pswd} = req.body;
            if(query_pswd == PSWD){
                const {pharm_id} = req.body;

                let uQuery = await pool.query(
                    "SELECT precs_active FROM pharm_info WHERE pharm_id="+pharm_id
                )

                if(uQuery.rows[0]!=null){
                    //just run a for loop to capture the information
                    let precs = [];
                    precs_active = uQuery.rows[0].precs_active;

                    if(precs_active == null){
                        res.send(precs)
                    } else{
                        //let sel = constructBulkPrecRequest(precs_active);

                        let precQueries = await pool.query(
                            "SELECT * FROM prec_info WHERE pharm_id="+pharm_id+" and is_completed=0"
                        );

                        //console.log(precQueries.rows);

                        for(i=0; i<precQueries.rows.length; i++){
                            precs.push(await getDescriptivePrecInfo_fromQuery(precQueries.rows[i]));
                        }
                        res.send(precs);
                    }

                } else {
                    res.send("ERROR: User Not Found");
                }

            } else{
                res.send("ERROR: Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.send("ERROR: Failure Handling Request");
        }
    });

    router.get(`/${objId}/pharm/precs/history`, async(req,res) => {
        try{
            const { query_pswd} = req.body;
            if(query_pswd == PSWD){
                const {pharm_id} = req.body;

                let uQuery = await pool.query(
                    "SELECT precs_history FROM pharm_info WHERE pharm_id="+pharm_id
                )

                if(uQuery.rows[0]!=null){
                    //just run a for loop to capture the information
                    let precs = [];
                    precs_history = uQuery.rows[0].precs_history;

                    if(precs_history == null){
                        res.send(precs)
                    } else{
                        //let sel = constructBulkPrecRequest(precs_active);

                        let precQueries = await pool.query(
                            "SELECT * FROM prec_info WHERE pharm_id="+pharm_id
                        );

                        //console.log(precQueries.rows);

                        for(i=0; i<precQueries.rows.length; i++){
                            precs.push(await getDescriptivePrecInfo_fromQuery(precQueries.rows[i]));
                        }
                        res.send(precs);
                    }

                } else {
                    res.send("ERROR: User Not Found");
                }

            } else{
                res.send("ERROR: Illegal Query");
            }
        } catch(err){
            console.log(err);
            res.send("ERROR: Failure Handling Request");
        }
    });
};
