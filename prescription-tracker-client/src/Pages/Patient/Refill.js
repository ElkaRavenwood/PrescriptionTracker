import { Box, makeStyles, Table, TableBody, TableCell, TableHead, TableRow, Typography } from "@material-ui/core";
import axios from "axios";
import { useEffect, useState } from "react";
import MessageDisplay from "../../Components/MessageDisplay";

const useStyles = makeStyles((theme) => ({
    root: {
        backgroundColor: theme.palette.primary.main,
        paddingTop: "5vh",
        paddingBottom: "5vh",
        display: "flex",
        justifyContent: "center",
        flexDirection: "column",
        alignItems: "center",
    },
    table: {
        width: "80vw",
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
    clickableRow: {
        '&:hover': {
            cursor: "pointer",
        },
    },
}));

const Refill = (props) => {

    const classes = useStyles();

    const [data, setData] = useState([]);
    const [state, setState] = useState({});

    useEffect(() => {
        axios.get("/meditrack/user/precs/history/", {
            params: {
                query_pswd: "ae34ZF76!",
                user_id: localStorage.getItem("prescriptionTrackerUserId")
            }
        }).then((res) => {
            if (res.status === 200) {
                let temp = res.data.filter((prescription) => parseInt(prescription.max_refills) > parseInt(prescription.cur_refills))
                temp.forEach(elem => {
                    elem.selected = false;
                    elem.refillsLeft = parseInt(elem.max_refills) - parseInt(elem.cur_refills);
                });
                setData(temp);
            } else {
                setState((state)=> ({
                    ...state,
                    errorMessage: res.data,
                    showError: true
                }));
            }
        }).catch((err) => {
            console.log(err);
        });

        
    }, []);

    return (
        <div id="refill">
            <Box className={classes.root} >
                <MessageDisplay message={state.errorMessage} error={state.showError} />
                <Typography variant="h2" className={"heading"} gutterBottom>Refill Prescriptions</Typography>
                <Typography variant="h4" className={"heading"} gutterBottom>Below, are your refillable prescriptions. Call your pharmacist to put in a new order</Typography>
                <br />
                <Table className={classes.table}>
                    <TableHead>
                        <TableRow hover>
                            <TableCell align="center" className={classes.tableCell + " " + classes.tableHeaderCell}>Prescription ID</TableCell>
                            <TableCell align="center" className={classes.tableCell + " " + classes.tableHeaderCell}>Prescription Name</TableCell>
                            <TableCell align="center" className={classes.tableCell + " " + classes.tableHeaderCell}>Refills Left</TableCell>
                        </TableRow>
                    </TableHead>
                    <TableBody>
                        {data.map((prescription, index) => {
                            return (
                                <TableRow key={index} hover>
                                    <TableCell align="center" className={classes.tableCell + " " + classes.tableBodyCell}>
                                        {prescription.rx}
                                    </TableCell>
                                    <TableCell align="center" className={classes.tableCell + " " + classes.tableBodyCell}>
                                        {prescription.med_name}
                                    </TableCell>
                                    <TableCell align="center" className={classes.tableCell + " " + classes.tableBodyCell}>
                                        {prescription.refillsLeft}
                                    </TableCell>
                                </TableRow>
                            );
                        })}
                    </TableBody>
                </Table>
            </Box>
        </div>
    );
}

export default Refill;