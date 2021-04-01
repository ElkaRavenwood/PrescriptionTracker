import { Box, makeStyles, /*TextField,*/ Typography } from "@material-ui/core";
import PatientHeader2 from "../../Components/PatientHeader";
import PatientHeader from "../../Components/PatientHeader";
import { useEffect, useState } from "react";
// import CustomButton from "../../Components/CustomButton";
import axios from "axios";
import React from "react";
import TrackingTimeline from "../../Components/TrackingTineline";


const toReadableDate = (sqlDateIn) => {
    let date = parseToDateInfo(sqlDateIn);
    //return "year: "+date.yyyy
    return date.hh12+":"+date.mm+" "+date.am_pm+", "+date.MMM+" "+date.d+", "+date.yyyy;
    //return date.hh+":"+date.mm+", "+date.MMM+" "+date.dd+", "+date.yyyy;
 }
 
 const parseToDateInfo = (sqlDateIn) => {
     let dateStr = sqlDateIn.split("T")[0];
     let timeStr = sqlDateIn.split("T")[1].split(".000Z")[0];
     //console.log(date);
    
     let monthNumStr = dateStr.split("-")[1]
     let yearNumStr = dateStr.split("-")[0]
     let dateNumStr = dateStr.split("-")[2]

     let timeArr = timeStr.split(":");
     
     let hourStr = timeArr[0];
     let minStr = timeArr[1];
     let secStr = timeArr[2];

     let monthNum = parseInt(monthNumStr);
     let hourNum = parseInt(hourStr);
     let minNum = parseInt(minStr);
     let secNum = parseInt(secStr);
     let dateNum = parseInt(dateNumStr);

     let dateDix = {};

     dateDix.h12 = "test";
    let h12num = 0;
    let ap = "AM";

    if(hourNum > 12){
        h12num = hourNum - 12;
        ap = "PM";
    } else if(hourNum === 12){
        h12num = hourNum;
        ap = "PM";
    } else{
        h12num = hourNum;
        ap = "AM";
    }
 
     dateDix.h = ""+hourNum;
     dateDix.hh = (hourNum < 10) ? "0"+hourNum : ""+hourNum;
     dateDix.h12 = ""+h12num;
     dateDix.hh12 = (h12num < 10) ? "0"+h12num : ""+h12num;
     dateDix.am_pm = ap;
     dateDix.m = ""+minNum;
     dateDix.mm = (minNum < 10) ? "0"+minNum : ""+minNum;
     dateDix.s = ""+secNum;
     dateDix.ss = (secNum < 10) ? "0"+secNum : ""+secNum;
     dateDix.d = ""+dateNum;
     dateDix.dd = (dateNum < 10) ? "0"+dateNum : ""+dateNum;
 
     
     const longMonthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" ];
     const shortMonthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ];
     let monthStr = shortMonthNames[monthNum-1];
     let longMonthStr = longMonthNames[monthNum-1];
     
 
     dateDix.M = ""+(monthNum+1);
     dateDix.MM = (monthNum+1 < 10) ? "0"+monthNum+1 : ""+monthNum+1;
     dateDix.MMM = monthStr;
     dateDix.MMMM = longMonthStr;
     dateDix.yy = ""+yearNumStr.substring(yearNumStr.length-2, yearNumStr.length);
     dateDix.yyyy = ""+yearNumStr;
 
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
                                    <Typography variant="h5" gutterBottom><strong>Prescription Number</strong>: {prescription.rx}</Typography>
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