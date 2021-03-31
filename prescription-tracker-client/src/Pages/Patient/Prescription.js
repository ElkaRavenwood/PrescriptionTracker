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

    useEffect(async() => {
        // pull from database
        console.log(localStorage.getItem("prescriptionTrackerUserId"));
            let uuid = 1; //will be the local storage call when Ready
            let arrayOut = [];
            
            //make querry to database
            await axios.get("meditrack/user/precs/active", {
                params: {
                    query_pswd: "ae34ZF76!",
                    user_id: uuid
                }
            }).then((res) => {
                if(res.status === 200){
                    //if read was success then we have JSON array in res.data
                   // console.log(res.data);
                    let fp = "";
                    for(let i=0; i<res.data.length; i++){
                        if(res.data[i].med_name == null) fp = "RX"+res.data[i].rx+""
                        else fp = res.data[i].med_name+" (RX"+res.data[i].rx+")";

                        arrayOut.push({
                            name: fp,
                            repeated: res.data[i].cur_refills,
                            refillsAllowed: res.data[i].max_refills
                        })
                    }
                } else{
                    //error reporting
                    
                }
            }, (error) => {
                console.log(error);
            });
        
            setData(arrayOut);
        
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
                        {data.map((prescription) => (
                            <TableRow key={prescription.name} hover >
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