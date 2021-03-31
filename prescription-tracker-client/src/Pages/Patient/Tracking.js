import { Box, makeStyles, /*TextField,*/ Typography } from "@material-ui/core";
import PatientHeader from "../../Components/PatientHeader";
import { useEffect, useState } from "react";
// import CustomButton from "../../Components/CustomButton";
import axios from "axios";
import React from "react";
import TrackingTimeline from "../../Components/TrackingTineline";

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
        let temp = [{
            orderNumber: "0000",
            orderStatus: "Order Received",
            orderUpdated: "21-03-2021 17:02:15",
        }]
        setState((state) => ({...state, prescriptions: temp}));
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
                                    <Typography variant="h5" gutterBottom><strong>Order Updated</strong>: {prescription.status_date}</Typography>
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