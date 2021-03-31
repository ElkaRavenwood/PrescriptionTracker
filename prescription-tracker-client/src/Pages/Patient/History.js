import { Box, makeStyles, Table, TableBody, TableCell, TableHead, TableRow, Typography } from "@material-ui/core";
import { useEffect, useState } from "react";
import axios from 'axios';

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

const History = (props) => {

    const classes = useStyles();

    const [data, setData] = useState([]);

    

    useEffect(() => {

        async function fetchData(setData){
            let arrayOut = [];

            //make query to database
            await axios.get("meditrack/user/precs/history", {
                params: {
                    query_pswd: "ae34ZF76!",
                    user_id: localStorage.getItem("prescriptionTrackerUserId")
                }
            }).then((res) => {
                if(res.status === 200){
                    //if read was success then we have JSON array in res.data
                   // console.log(res.data);
                    let ipr ="";
                    for(let i=0; i<res.data.length; i++){
                        if(parseInt(res.data[i].is_completed) === 0) ipr = "In Progress";
                        else ipr = "Order Completed";

                        //console.log(toReadableDate(res.data[i].status_date));
                        arrayOut.push({
                            number: "RX"+res.data[i].rx,
                            placed: toReadableDate(res.data[i].status_date),
                            status: ipr
                        })
                    }
                } else{
                    //error reporting
                    
                }
            }, (error) => {
                console.log(error);
            });

            setData(arrayOut);
        }

        fetchData(setData);

    }, []);

    return (
        <div id="history">
            <Box className={classes.root} >
                <Typography variant="h2" className={"heading"}>Order History</Typography>
                <Table className={classes.table}>
                    <TableHead>
                        <TableRow hover>
                            <TableCell align="center" className={classes.tableCell + " " + classes.tableHeaderCell}>Prescription</TableCell>
                            <TableCell align="center" className={classes.tableCell + " " + classes.tableHeaderCell}>Most Recent Update</TableCell>
                            <TableCell align="center" className={classes.tableCell + " " + classes.tableHeaderCell}>Order Status</TableCell>
                        </TableRow>
                    </TableHead>
                    <TableBody>
                        {data.map((prescription, index) => {
                            return (
                                <TableRow key={index} hover >
                                    <TableCell align="center" className={classes.tableCell + " " + classes.tableBodyCell}>
                                        {prescription.number}
                                    </TableCell>
                                    <TableCell align="center" className={classes.tableCell + " " + classes.tableBodyCell}>{prescription.placed}</TableCell>
                                    <TableCell align="center" className={classes.tableCell + " " + classes.tableBodyCell}>{prescription.status}</TableCell>
                                </TableRow>
                                );
                            }
                        )}
                    </TableBody>
                </Table>
            </Box>
        </div>
    );
}

export default History;