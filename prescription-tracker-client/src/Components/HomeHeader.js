import { AppBar, Grid, makeStyles, Typography } from '@material-ui/core';
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
        margin: "1vh",
        alignItems: "center",
    },
    header_elem: {
        height: "100%",
        margin: "auto",
        alignItems: "center",
        alignContent: "center",
        color: "white",
        textAlign: "center",
        textDecoration: "unset !important",
        
        justifyContent: "center",
        display: 'flex',
    },
    header_elem_signup: {
        border: "solid 3px white",
        borderRadius: "5px",
    }
}))

const HomeHeader = (props) => {

    const classes = useStyles();

    const history = useHistory();

    return (
        <AppBar position="sticky">
            <Grid container className={classes.root}>
                <Grid item xs={1} />
                <Grid item xs={4} className={classes.header_elem_container} onClick={() => history.push('/')}>
                    <Typography variant="h2" className={classes.header_elem}>Medi-Track</Typography>
                </Grid>
                <Grid item xs={3} className={classes.header_elem_container} onClick={() => history.push('/Login')}>
                    <Typography variant="h4" className={classes.header_elem}>Login</Typography>
                </Grid>
                <Grid item xs={3} className={classes.header_elem_container + " " + classes.header_elem_signup} >
                    <Link to="/#signup" className={classes.header_elem} >
                        <Typography variant="h4" >Sign Up Now</Typography>
                    </Link>
                </Grid>
                <Grid item xs={1} />
            </Grid>
        </AppBar>
    )
}

export default HomeHeader;