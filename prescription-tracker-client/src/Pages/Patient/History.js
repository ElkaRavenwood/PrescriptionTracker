import { Box, makeStyles, Table, TableBody, TableCell, TableHead, TableRow, Typography } from "@material-ui/core";
import { useEffect, useState } from "react";

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
    heading: {
        fontWeight: "500",
        color: "white",
        marginBottom: "5vh",
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
        // TODO pull from database
        setData([{
            number: "0000000001",
            placed: "01/01/2021",
            status: "Order Completed",
        }, {
            number: "0000000001",
            placed: "01/05/2021",
            status: "Order Completed",
        }, {
            number: "0000000001",
            placed: "01/07/2021",
            status: "Order Received",
        }, {
            number: "0000000001",
            placed: "01/09/2021",
            status: "Order Received",
        }, {
            number: "0000000001",
            placed: "01/01/2011",
            status: "Order Completed",
            
        }]);
    }, []);

    return (
        <div id="history">
            <Box className={classes.root} >
                <Typography variant="h2" className={classes.heading}>Order History</Typography>
                <Table className={classes.table}>
                    <TableHead>
                        <TableRow hover>
                            <TableCell align="center" className={classes.tableCell + " " + classes.tableHeaderCell}>Order Number</TableCell>
                            <TableCell align="center" className={classes.tableCell + " " + classes.tableHeaderCell}>Order Placed</TableCell>
                            <TableCell align="center" className={classes.tableCell + " " + classes.tableHeaderCell}>Order Status</TableCell>
                        </TableRow>
                    </TableHead>
                    <TableBody>
                        {data.map((prescription) => (
                            <TableRow key={prescription.name} hover >
                                <TableCell align="center" className={classes.tableCell + " " + classes.tableBodyCell}>
                                    {prescription.number}
                                </TableCell>
                                <TableCell align="center" className={classes.tableCell + " " + classes.tableBodyCell}>{prescription.placed}</TableCell>
                                <TableCell align="center" className={classes.tableCell + " " + classes.tableBodyCell}>{prescription.status}</TableCell>
                            </TableRow>
                        ))}
                    </TableBody>
                </Table>
            </Box>
        </div>
    );
}

export default History;