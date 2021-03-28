import { Box, makeStyles, Table, TableBody, TableCell, TableHead, TableRow, Typography } from "@material-ui/core";
import { useEffect, useState } from "react";
import { Link } from "react-router-dom";
// import { useLocation } from "react-router";
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
    buttonContainer: {
        width: "60%",
        margin: "auto"
    }
}));

const Admin = (props) => {

    const classes = useStyles();

    const [data, setData] = useState([]);

    useEffect(() => {
        let temp = [{
            lastName: "Gupta",
            firstName: "Varnikaa",
            id: "123456",
        }, {
            lastName: "Laitar",
            firstName: "Teaghan",
            id: "123457",
        }, {
            lastName: "Maduabuchi",
            firstName: "Iffy",
            id: "123458",
        }, {
            lastName: "Won",
            firstName: "Jamie",
            id: "123450",
        }, {
            lastName: "Vicknesvaran",
            firstName: "Vanusha",
            id: "123451",
        }, {
            lastName: "Won",
            firstName: "Jamie",
            id: "123350",
        }, {
            lastName: "Vicknesvaran",
            firstName: "Vanusha",
            id: "143451",
        }];
        // TODO pull from db
        setData(temp);
    }, []);

    // const location = useLocation();
    return (
        <div id="admin" className="admin">
            <AdminHeader />
            <Box className={classes.root}>
                <Typography variant="h2" className={"heading"}>Patients</Typography>
                <Table className={classes.table}>
                    <TableHead>
                        <TableRow>
                            <TableCell align="center" className={classes.tableCell + " " + classes.tableHeaderCell}>Last Name, First Name</TableCell>
                            <TableCell align="center" className={classes.tableCell + " " + classes.tableHeaderCell}>Patient #</TableCell>
                            <TableCell align="center" className={classes.tableCell + " " + classes.tableHeaderCell}>Patient Details</TableCell>
                        </TableRow>
                    </TableHead>
                    <TableBody>
                        {data.map((patient) => (
                            <TableRow key={patient.id} >
                                <TableCell align="center" className={classes.tableCell + " " + classes.tableBodyCell}>
                                    {patient.lastName}, {patient.firstName}
                                </TableCell>
                                <TableCell align="center" className={classes.tableCell + " " + classes.tableBodyCell}>{patient.id}</TableCell>
                                <TableCell align="center" className={classes.tableCell + " " + classes.tableBodyCell}>
                                    <div className={classes.buttonContainer}>
                                        <Link className="noUnderline" to={{pathname:"/Admin/PatientDetails", state: {
                                            id: patient.id,
                                        }}}>
                                            <CustomButton text="See More" variant="contained" longRectangular smallFont fullWidth primaryDarkTextColor/>
                                        </Link>
                                    </div>
                                </TableCell>
                            </TableRow>
                        ))}
                    </TableBody>
                </Table>
            </Box>
        </div>
    );
}

export default Admin;