import { Box, makeStyles, Table, TableBody, TableCell, TableHead, TableRow, Typography } from "@material-ui/core";
import { useEffect, useState } from "react";
import axios from 'axios';

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
}));

const Prescription = (props) => {

    const classes = useStyles();

    const [data, setData] = useState([]);

    useEffect(() => {
            
        axios.get("meditrack/user/precs/active", {
            params: {
                query_pswd: "ae34ZF76!",
                user_id: localStorage.getItem("prescriptionTrackerUserId")
            }
        }).then((res) => {
            if(res.status === 200){
                //if read was success then we have JSON array in res.data
                let arrayOut = [];
                res.data.forEach((prescription) => {
                    arrayOut.push({
                        rx: prescription.rx,
                        repeated: prescription.cur_refills,
                        refillsAllowed: prescription.max_refills,
                        name: prescription.med_name + " (RX" + prescription.rx + ")",
                    });
                });
                setData(arrayOut);
            } else{
                //error reporting
                
            }
        }, (error) => {
            console.log(error);
        });
        
    }, []);

    return (
        <div id="prescription">
            <Box className={classes.root} >
                <Typography variant="h2" className={"heading"}>Medications List</Typography>
                <Table className={classes.table}>
                    <TableHead>
                        <TableRow hover>
                            <TableCell align="center" className={classes.tableCell + " " + classes.tableHeaderCell}>Prescription Name</TableCell>
                            <TableCell align="center" className={classes.tableCell + " " + classes.tableHeaderCell}>Refills</TableCell>
                        </TableRow>
                    </TableHead>
                    <TableBody>
                        {data.map((prescription, index) => (
                            <TableRow key={index} hover >
                                <TableCell align="center" className={classes.tableCell + " " + classes.tableBodyCell}>
                                    {prescription.name}
                                </TableCell>
                                <TableCell align="center" className={classes.tableCell + " " + classes.tableBodyCell}>{prescription.repeated}</TableCell>
                            </TableRow>
                        ))}
                    </TableBody>
                </Table>
            </Box>
        </div>
    );
}

export default Prescription;