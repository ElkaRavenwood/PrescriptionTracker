import { AppBar, Grid, makeStyles, Typography, unstable_createMuiStrictModeTheme } from '@material-ui/core';
import React from 'react';
import { useHistory } from 'react-router-dom';
import { Link } from "react-router-dom";
const useStyles = makeStyles((theme) => ({
    root: {
        height: "10vh",
        backgroundColor: theme.palette.primary.main,
        color: "white",
        alignItems: "center",
        display: "flex",
        position: "sticky"
    },
    header_elem_container: {
        height: "8vh",
        // margin: "1vh",
        alignItems: "center",
    },
    header_elem: {
        height: "100%",
        margin: "auto",
        alignItems: "center",
        alignContent: "center",
        color: "white",
        textAlign: "center",
        justifyContent: "center",
        display: 'flex',
    },
    header_elem_logout: {
        border: "solid 3px white",
        borderRadius: "5px",
        fontSize: "1.25em",
    },
}))

const PatientHeader = (props) => {

    const classes = useStyles();

    const history = useHistory();

    return (
        <AppBar position="sticky">
            <Grid container className={classes.root}>
                <Grid item xs={1} />
                <Grid item container xs={10}>
                <Grid item xs={3} className={classes.header_elem_container} onClick={() => history.push('/Patient')}>
                    <Typography variant="h2" className={classes.header_elem}>Medi-Track</Typography>
                </Grid>
                <Grid item xs={2} className={classes.header_elem_container} >
                    <Link to={{pathname:"/Patient", hash:"prescription"}} className="noUnderline">
                        <Typography variant="h4" className={classes.header_elem}>Prescriptions</Typography>
                    </Link>
                </Grid>
                <Grid item xs={2} className={classes.header_elem_container} onClick={() => history.push('/Patient/Tracking')}>
                    <Typography variant="h4" className={classes.header_elem}>Tracking</Typography>
                </Grid>
                <Grid item xs={2} className={classes.header_elem_container} onClick={() => history.push('/Patient/History')}>
                    <Typography variant="h4" className={classes.header_elem}>Order History</Typography>
                </Grid>
                <Grid item xs={2} className={classes.header_elem_container} onClick={() => history.push('/Contact')}>
                    <Typography variant="h4" className={classes.header_elem}>Contact Us</Typography>
                </Grid>
                <Grid item xs={1} className={classes.header_elem_container} onClick={() => history.push('/')}>
                    <Typography variant="h4" className={classes.header_elem + " " + classes.header_elem_logout}>Logout</Typography>
                </Grid>
                </Grid>
            </Grid>
        </AppBar>
    )
}

export default PatientHeader;