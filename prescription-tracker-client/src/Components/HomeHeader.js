import { AppBar, Grid, makeStyles, Typography } from '@material-ui/core';
import React from 'react';
import { useHistory } from 'react-router-dom';

const useStyles = makeStyles((theme) => ({
    root: {
        height: "10vh",
        backgroundColor: theme.palette.primary.main,
        color: "white",
        alignItems: "center",
        display: "flex",
        position: "sticky"
    },
    header_elem: {
        height: "8vh",
        margin: "1vh",
        alignItems: "center",
        textAlign: "center",
    },
    header_elem_signup: {
        border: "solid 3px white",
        borderRadius: "5px",
    }
}))

const HomeHeader = (props) => {

    const { signup, executeScroll } = props;

    const classes = useStyles();

    const history = useHistory();

    return (
        <AppBar position="sticky">
            <Grid container className={classes.root}>
                <Grid item xs={1} />
                <Grid item xs={4} className={classes.header_elem} onClick={() => history.push('/')}>
                    <Typography variant="h2">Medi-Track</Typography>
                </Grid>
                <Grid item xs={3} className={classes.header_elem} onClick={() => history.push('/Login')}>
                    <Typography variant="h4">Login</Typography>
                </Grid>
                <Grid item xs={3} className={classes.header_elem + " " + classes.header_elem_signup} onClick={() => history.push('/')}>
                    <Typography variant="h4">Sign Up Now</Typography>
                </Grid>
                <Grid item xs={1} />
            </Grid>
        </AppBar>
    )
}

export default HomeHeader;