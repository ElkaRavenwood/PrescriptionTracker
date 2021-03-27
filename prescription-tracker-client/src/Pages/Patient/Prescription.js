import { Box, Checkbox, Icon, makeStyles, Table, TableBody, TableCell, TableHead, TableRow, Typography } from "@material-ui/core";
import { useEffect, useState } from "react";
import CustomButton from "../../Components/CustomButton";

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

const Prescription = (props) => {

    const classes = useStyles();

    const [data, setData] = useState([]);

    useEffect(() => {
        // pull from database
        setData([{
            name: "0000000001",
            repeated: 0,
            refillsAllowed: 0,
        }, {
            name: "0000000002",
            repeated: 0,
            refillsAllowed: 0,
        }, {
            name: "0000000003",
            repeated: 0,
            refillsAllowed: 2,
        }, {
            name: "0000000501",
            repeated: 3,
            refillsAllowed: 5,
        }]);
    }, []);

    return (
        <div id="prescription">
            <Box className={classes.root} >
                <Typography variant="h2" className={classes.heading}>Medications List</Typography>
                <Table className={classes.table}>
                    <TableHead>
                        <TableRow hover>
                            <TableCell align="center" className={classes.tableCell + " " + classes.tableHeaderCell}>Prescription Name</TableCell>
                            <TableCell align="center" className={classes.tableCell + " " + classes.tableHeaderCell}>Repeated</TableCell>
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