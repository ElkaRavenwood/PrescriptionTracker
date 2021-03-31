import { Box, makeStyles, Table, TableBody, TableCell, TableHead, TableRow, Typography } from "@material-ui/core";
import axios from "axios";
import React from "react";
import { useEffect, useState } from "react";
import { useLocation } from "react-router";
import AdminHeader from "../../Components/AdminHeader";
import CustomButton from "../../Components/CustomButton";
import MessageDisplay from "../../Components/MessageDisplay";

const useStyles = makeStyles((theme) => ({
    root: {
        backgroundColor: theme.palette.primary.dark,
        height: "90vh",
        color: "white",
        paddingTop: "5vh",
        display: "flex",
        flexDirection: "column",
        alignItems: "center",
    },
    table: {
        width: "80vw",
        marginTop: "5vh",
    },
    tableCell: {
        color: "white",
        border: "solid 1px white",
    },
    tableHeader: {
        marginBottom: "3vh",
    },
    tableHeaderCell: {
        fontWeight: "500",
        fontSize: "2em",
    },
    tableBodyCell: {
        fontSize: "1.5em",
    },
    statusCell: {
        display: "flex",
        justifyContent: "space-evenly",
    },
    buttonContainer: {
        width: "40%",
        margin: "auto"
    },
    bigButton: {
        margin: "auto",
        width: "90%",
    },
    finishCell: {
        backgroundColor: "white",
        color: theme.palette.primary.dark,
        width: "60%",
        margin: "auto",
        borderRadius: "5px",
    },
}));

const PatientDetails = (props) => {

    const classes = useStyles();

    const location = useLocation();

    const [data, setData] = useState({
        user_id: location.state ? location.state.id : "",
        firstName: location.state ? location.state.firstName : "",
        lastName: location.state ? location.state.lastName : "",
        prescriptions: []
    });

    const [state, setState] = useState({
        ready: false,
    });
    const prescriptionStatuses = "Prescription Received,Prescription Logged,Pharmacist Verification,Packaging,Ready For Pickup".split(",");

    useEffect(() => {
        if (location.state) {
            axios.get("/meditrack/pharm/patient/precs/history", {
                params: {
                    pharm_id: localStorage.getItem("prescriptionTrackerUserId"),
                    user_id: location.state.id,
                    query_pswd: "ae34ZF76!",
                },
            }).then((res) => {
                if (res.status === 200) {
                    setData((data) => ({
                        ...data,
                        prescriptions: res.data
                    }));
                } else {
                    setState((state)=> ({
                        ...state,
                        errorMessage: res.data,
                        showError: true,
                    }));
                }
            });
        }
    }, [location.state]);
    
    const handleClick = (prescription, start, index) => {
        let statusToSet = "1";
        if (prescription.progress === "5") { // if completed
            statusToSet = "1"; // makes it so that the prescription is reset
        } else { // if in progress
            statusToSet = !start ? parseInt(prescription.progress) + 1 : parseInt(prescription.progress) - 1;
        }
        axios.put("/meditrack/precs/progress", null, {
            params: {
                rx: prescription.rx,
                progress: "" + statusToSet,
                status_date: new Date(),
                query_pswd: "ae34ZF76!",
            }
        }).then((res) => {
            if (res.status === 200) {
                let temp = [...data.prescriptions];
                temp[index].progress = "" + statusToSet;
                temp[index].status_msg = res.data.progress_msg;
                setData((data) => ({
                    ...data,
                    prescriptions: temp,
                }));
            }
        })

    }

    return (
        <div id="patientDetails" className="admin">
            <AdminHeader />
            <div className={classes.root}>
                <MessageDisplay message={state.errorMessage} error={state.showError} />
                <Typography className="heading" variant="h2">{data.lastName}, {data.firstName}</Typography>
                <Box className={classes.root}>
                    <Table className={classes.table}>
                        <TableHead>
                            <TableRow>
                                <TableCell align="center" className={classes.tableCell + " " + classes.tableHeaderCell}>Prescription</TableCell>
                                <TableCell align="center" className={classes.tableCell + " " + classes.tableHeaderCell}>Status</TableCell>
                                <TableCell align="center" className={classes.tableCell + " " + classes.tableHeaderCell}>Status Options</TableCell>
                                {/* <TableCell align="center" className={classes.tableCell + " " + classes.tableHeaderCell}>Estimated Finish</TableCell> */}
                            </TableRow>
                        </TableHead>
                        <TableBody>
                            {data.prescriptions ? data.prescriptions.map((prescription, index) => (
                                <TableRow key={prescription.rx} >
                                    <TableCell align="center" className={classes.tableCell + " " + classes.tableBodyCell}>
                                        {prescription.rx}
                                    </TableCell>
                                    <TableCell align="center" className={classes.tableCell + " " + classes.tableBodyCell}>
                                        {prescription.progress === "6" ? prescription.status_msg : prescriptionStatuses[parseInt(prescription.progress) - 1]}
                                    </TableCell>
                                    <TableCell align="center" className={classes.tableCell + " " + classes.tableBodyCell + " " + classes.statusCell}>
                                        {prescription.progress === "5" ? 
                                            <div className={classes.bigButton} onClick={() => handleClick(prescription, false, index)}>
                                                <CustomButton text="Reopen" variant="contained" longRectangular smallFont fullWidth primaryDarkTextColor /> 
                                            </div>
                                            :
                                            <React.Fragment>
                                                <div className={classes.buttonContainer} onClick={() => handleClick(prescription, true, index)}>
                                                    <CustomButton text={prescription.progress !== "1" ? "Go Back" : ""} variant="contained" longRectangular smallFont fullWidth primaryDarkTextColor disabled={prescription.progress === "1"}/>
                                                </div>
                                                <div className={classes.buttonContainer} onClick={() => handleClick(prescription, false, index)}>
                                                    <CustomButton text={prescription.progress === "5" ? "Finish": prescription.progress === "1" ? "Begin" : "Continue"} variant="contained" longRectangular smallFont fullWidth primaryDarkTextColor  />
                                                </div>
                                            </React.Fragment>
                                        }
                                    </TableCell>
                                    {/* <TableCell align="center" className={classes.tableCell + " " + classes.tableBodyCell + " " + classes.finishCellContainer}>
                                        <div className={classes.finishCell}> {prescription.estimatedFinish || "-" }</div>
                                    </TableCell> */}
                                </TableRow>
                            )): null}
                        </TableBody>
                    </Table>
                </Box>
            </div>
        </div>
    );
}

export default PatientDetails;