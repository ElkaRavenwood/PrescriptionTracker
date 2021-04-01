import { Box, makeStyles, Table, TableBody, TableCell, TableHead, TableRow, Typography } from "@material-ui/core";
import { useEffect, useState } from "react";
import axios from 'axios';

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
        async function fetchData(setData) {
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

                        console.log(toReadableDate(res.data[i].status_date));

                        let dd = toReadableDate(res.data[i].status_date);
                        arrayOut.push({
                            number: "RX"+res.data[i].rx,
                            placed: dd,
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