import { Box, makeStyles, /*TextField,*/ Typography } from "@material-ui/core";
import PatientHeader from "../../Components/PatientHeader";
import { useEffect, useState } from "react";
// import CustomButton from "../../Components/CustomButton";
import axios from "axios";
import React from "react";
import TrackingTimeline from "../../Components/TrackingTineline";

const toReadableDate = (sqlDateIn) => {
    let date = parseToDateInfo(sqlDateIn);
    return date.hh12+":"+date.mm+" "+date.am_pm+", "+date.MMM+" "+date.dd+", "+date.yyyy;
    //return date.hh+":"+date.mm+", "+date.MMM+" "+date.dd+", "+date.yyyy;
 }
 
 const parseToDateInfo = (sqlDateIn) => {
     let pt = sqlDateIn.split("T")[0];
     let tt = sqlDateIn.split("T")[1].split(".000Z")[0];
     let date = new Date(pt+" "+tt);
     //console.log(date);
 
     let dateDix = {};

     dateDix.h12 = "test";
    let h12num = 0;
    let ap = "AM";

    if(date.getHours() > 12){
        h12num = parseInt(date.getHours()) - 12;
        ap = "PM";
    } else if(date.getHours() == 12){
        h12num = date.getHours();
        ap = "PM";
    } else{
        h12num = date.getHours();
        ap = "AM";
    }
 
     dateDix.h = ""+date.getHours();
     dateDix.hh = (date.getHours() < 10) ? "0"+date.getHours() : ""+date.getHours();
     dateDix.h12 = ""+h12num;
     dateDix.hh12 = (h12num < 10) ? "0"+h12num : ""+h12num;
     dateDix.am_pm = ap;
     dateDix.m = ""+date.getMinutes();
     dateDix.mm = (date.getMinutes() < 10) ? "0"+date.getMinutes() : ""+date.getMinutes();
     dateDix.s = ""+date.getSeconds();
     dateDix.ss = (date.getSeconds() < 10) ? "0"+date.getSeconds() : ""+date.getSeconds();
     dateDix.d = ""+date.getDate();
     dateDix.dd = (date.getDate() < 10) ? "0"+date.getDate() : ""+date.getDate();
 
     
     const longMonthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" ];
     const shortMonthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ];
     let monthStr = shortMonthNames[date.getMonth()];
     let longMonthStr = longMonthNames[date.getMonth()];
     
 
     dateDix.M = ""+(date.getMonth()+1);
     dateDix.MM = (date.getMonth()+1 < 10) ? "0"+date.getMonth()+1 : ""+date.getMonth()+1;
     dateDix.MMM = monthStr;
     dateDix.MMMM = longMonthStr;
     dateDix.yy = ""+date.getYear();
     dateDix.yyyy = ""+date.getFullYear();
 
     return dateDix;
  }

const useStyles = makeStyles((theme) => ({
    root: {
        backgroundColor: theme.palette.primary.main,
        paddingTop: "3vh",
        color: "white",
        minHeight: "90vh",
    },
    container: {
        width: "90vw",
        margin: "auto"
    },
    details: {
        textAlign: "left",
    },
    needs: {
        textAlign: "left",
        marginTop: "3vh",
        marginBottom: "5vh",
    },
    text: {
        backgroundColor: "white",
    },
    submitButton: {
        position: "right",
        marginTop: "3vh",
        display: "flex",
        justifyContent: "flex-end",
    },
    heading: {
        marginBottom: "3vh",
    },
}));

const Tracking = (props) => {

    const classes = useStyles();

    const [state, setState] = useState({
        notes: "",
        showError: false,
        prescriptions: [],
    });

    useEffect(() => {
        axios.get("/meditrack/user/precs/active", {
            params: {
                user_id: localStorage.getItem("prescriptionTrackerUserId"),
                query_pswd: "ae34ZF76!",
            }
        }).then((res) => {
            if (res.status === 200) {
                setState((state) => ({...state, prescriptions: res.data}));
            } else {
                setState((state)=> ({
                    ...state,
                    errorMessage: res.data,
                    showError: true
                }));
            }
        })
        
    }, []);

    // const handleSubmit = () => {
    //     // T O D O ping backend
    // }

    return (
        <div id="tracking">
            <PatientHeader />
            <Box className={classes.root}>
                <Box className={classes.container}>
                    <Typography variant="h2" className={"heading"}>Order Tracking</Typography>
                    <br />
                    <br />
                    <Typography variant="h6" className={"heading"}>See the status of all your active prescriptions below!</Typography>
                    <br />
                    <br />
                    {state.prescriptions.map((prescription, index) => {
                        return (
                            <React.Fragment key={index}>
                                <TrackingTimeline currentStatus={prescription.progress} />
                                <Box className={classes.details}>
                                    <Typography variant="h5" gutterBottom><strong>Order Number</strong>: {prescription.rx}</Typography>
                                    <Typography variant="h5" gutterBottom><strong>Order Status</strong>: {prescription.progress} - {prescription.progress_msg}</Typography>
                                    <Typography variant="h5" gutterBottom><strong>Order Updated</strong>: {toReadableDate(prescription.status_date)}</Typography>
                                </Box>
                                <Box className={classes.needs}>
                                    {/* <Typography variant="h5" gutterBottom><strong>Customer Needs:</strong></Typography>
                                    <TextField multiline variant="outlined" rows={4} onChange={(val) => setState((state) => ({...state, notes: val}))} value={state.notes} fullWidth className={classes.text}/>
                                    <div className={classes.submitButton} onClick={handleSubmit}>
                                        <CustomButton color="secondary" text="Add Note" variant="contained" rectangular />
                                    </div> */}
                                </Box>
                            </React.Fragment>
                        )
                    })}
                    
                </Box>
            </Box>
        </div>
    );
}

export default Tracking;