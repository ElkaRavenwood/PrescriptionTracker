import { Box, makeStyles, Table, TableBody, TableCell, TableHead, TableRow, Typography } from "@material-ui/core";
import React from "react";
import { useEffect, useState } from "react";
import { useLocation } from "react-router";
import AdminHeader from "../../Components/AdminHeader";
import CustomButton from "../../Components/CustomButton";

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
    console.log(location)

    const [data, setData] = useState({prescriptions: []});

    useEffect(() => {
        // TODO pull from db using location.state.id
        let temp = {
            lastName: "Gupta",
            firstName: "Varnikaa",
            prescriptions: [{
                id: "12389012d",
                status: "In Progress",
                estimatedFinish: "16:20",
            }, {
                id: "12389012f",
                status: "Queued",
                estimatedFinish: "16:20",
            }, {
                id: "1238a012d",
                status: "Completed",
                estimatedFinish: "12:20",
            }, {
                id: "1238d012d",
                status: "Completed",
                estimatedFinish: "18:20",
            }, {
                id: "12289012d",
                status: "Completed",
                estimatedFinish: "14:20",
            }, {
                id: "1f389b12d",
                status: "Completed",
                estimatedFinish: "16:20",
            }],
        };
        setData(temp);
    }, []);
    
    // queued -> in progress -> completed
    const handleClick = (prescription, start) => {
        // TODO ping backend
        let statusToSet = "In Progress";
        let toDelete = false;
        if (prescription.status === "Completed") { // if completed
            statusToSet = "Queued"; // makes it so that the prescription is queued
        } else if (prescription.status === "Queued") {
            if (start) { // if first button is pressed
                statusToSet = "In Progress";
            } else {
                // Delete prescription
                toDelete = true;
            }
        } else { // if in progress
            statusToSet = start ? "Completed" : "Queued";
        }

        if (toDelete) {
            // delete a prescription
        } else {
            // modify a prescription status
        }
    }

    return (
        <div id="patientDetails" className="admin">
            <AdminHeader />
            <div className={classes.root}>
                <Typography className="heading" variant="h2">{data.lastName}, {data.firstName}</Typography>
                <Box className={classes.root}>
                    <Table className={classes.table}>
                        <TableHead>
                            <TableRow>
                                <TableCell align="center" className={classes.tableCell + " " + classes.tableHeaderCell}>Prescription</TableCell>
                                <TableCell align="center" className={classes.tableCell + " " + classes.tableHeaderCell}>Status</TableCell>
                                <TableCell align="center" className={classes.tableCell + " " + classes.tableHeaderCell}>Status Options</TableCell>
                                <TableCell align="center" className={classes.tableCell + " " + classes.tableHeaderCell}>Estimated Finish</TableCell>
                            </TableRow>
                        </TableHead>
                        <TableBody>
                            {data.prescriptions.map((prescription) => (
                                <TableRow key={prescription.id} >
                                    <TableCell align="center" className={classes.tableCell + " " + classes.tableBodyCell}>
                                        {prescription.id}
                                    </TableCell>
                                    <TableCell align="center" className={classes.tableCell + " " + classes.tableBodyCell}>
                                        {prescription.status}
                                    </TableCell>
                                    <TableCell align="center" className={classes.tableCell + " " + classes.tableBodyCell + " " + classes.statusCell}>
                                        {prescription.status === "Completed" ? 
                                            <div className={classes.bigButton} onClick={() => handleClick(prescription)}>
                                                <CustomButton text="Reopen" variant="contained" longRectangular smallFont fullWidth primaryDarkTextColor /> 
                                            </div>
                                            :
                                            <React.Fragment>
                                                <div className={classes.buttonContainer} onClick={() => handleClick(prescription, true)}>
                                                    <CustomButton text={prescription.status === "In Progress" ? "Stop" : "Start"} variant="contained" longRectangular smallFont fullWidth primaryDarkTextColor/>
                                                </div>
                                                <div className={classes.buttonContainer} onClick={() => handleClick(prescription, false)}>
                                                    <CustomButton text={prescription.status === "Queued" ? "Delete": "Finish"} variant="contained" longRectangular smallFont fullWidth primaryDarkTextColor />
                                                </div>
                                            </React.Fragment>
                                        }
                                    </TableCell>
                                    <TableCell align="center" className={classes.tableCell + " " + classes.tableBodyCell + " " + classes.finishCellContainer}>
                                        <div className={classes.finishCell}> {prescription.status === "In Progress" ? prescription.estimatedFinish : "-" }</div>
                                    </TableCell>
                                </TableRow>
                            ))}
                        </TableBody>
                    </Table>
                </Box>
            </div>
        </div>
    );
}

export default PatientDetails;