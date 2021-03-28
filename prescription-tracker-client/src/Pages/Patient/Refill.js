import { Box, Icon, makeStyles, Table, TableBody, TableCell, TableHead, TableRow, Typography } from "@material-ui/core";
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

    useEffect(() => {
        // TODO pull from database
        let temp = [{
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
        }];

        temp.forEach(elem => {
            elem.selected = false;
        });
        setData(temp);
    }, []);

    const handleClick = (index) => {
        let temp = [...data];
        temp[index].selected = !temp[index].selected ;
        setData(temp);
    }

    const handleSubmit = () => {
        // TODO ping backend
        console.log(123);
    }

    return (
        <div id="refill">
            <Box className={classes.root} >
                <Typography variant="h2" className={"heading"}>Refill Prescriptions</Typography>
                <Typography variant="h4" className={"heading"}>Select a prescription to refill. Then click submit to put in your order.</Typography>
                <Table className={classes.table}>
                    <TableHead>
                        <TableRow hover>
                            <TableCell align="center" className={classes.tableCell + " " + classes.tableHeaderCell}>Prescription Name</TableCell>
                            <TableCell align="center" className={classes.tableCell + " " + classes.tableHeaderCell}>Refill</TableCell>
                        </TableRow>
                    </TableHead>
                    <TableBody>
                        {data.map((prescription, index) => (
                            <TableRow key={prescription.name} hover className={prescription.repeated < prescription.refillsAllowed ? classes.clickableRow : ""} onClick={() => handleClick(index)}>
                                <TableCell align="center" className={classes.tableCell + " " + classes.tableBodyCell}>
                                    {prescription.name}
                                </TableCell>
                                {prescription.repeated < prescription.refillsAllowed ? 
                                    <TableCell align="center" className={classes.tableCell + " " + classes.tableBodyCell}>
                                        {prescription.selected ? <Icon>check</Icon> : "" }
                                    </TableCell>
                                    : 
                                    <TableCell align="center" className={classes.tableCell + " " + classes.tableBodyCell}>
                                        No more refills permitted
                                    </TableCell>
                                }
                            </TableRow>
                        ))}
                    </TableBody>
                </Table>
                <br/>
                <br/>
                <CustomButton color="primary" outlined rectangular variant="contained" text="Submit" onClick={handleSubmit}/>
            </Box>
        </div>
    );
}

export default Refill;