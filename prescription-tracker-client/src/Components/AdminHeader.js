import { AppBar, Grid, makeStyles, Typography } from '@material-ui/core';
import React from 'react';
import { useHistory, useLocation } from 'react-router-dom';

const useStyles = makeStyles((theme) => ({
    root: {
        height: "10vh",
        backgroundColor: theme.palette.primary.dark,
        color: "white",
        alignItems: "center",
        display: "flex",
        position: "sticky"
    },
    header_elem_container: {
        height: "8vh",
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
}));

const AdminHeader = (props) => {

    const classes = useStyles();

    const history = useHistory();
    const location = useLocation();
    return (
        <AppBar position="sticky">
            <Grid container className={classes.root}>
                <Grid item xs={1} />
                <Grid item container xs={10}>
                {location.pathname === "/Admin" ? 
                    <React.Fragment>
                        <Grid item xs={3} className={classes.header_elem_container} onClick={() => history.push("/Admin/AddPrescription")}>
                            <Typography variant="h4" className={classes.header_elem}>Add Prescription</Typography>
                        </Grid>
                        <Grid item xs={2} />
                    </React.Fragment>
                    : 
                    <React.Fragment>
                        <Grid item xs={1} className={classes.header_elem_container} onClick={() => history.goBack()}>
                            <Typography variant="h4" className={classes.header_elem}>Back</Typography>
                        </Grid>
                        <Grid item xs={4} className={classes.header_elem_container} onClick={() => history.push("/Admin/AddPrescription")}>
                            <Typography variant="h4" className={classes.header_elem}>Add Prescription</Typography>
                        </Grid>    
                    </React.Fragment>
                }
                
                <Grid item xs={6} className={classes.header_elem_container}>
                    {location.state ? location.state.id ? <Typography variant="h4" className={classes.header_elem}>Patient # {location.state.id}</Typography> : "" : "" }
                </Grid>
                <Grid item xs={1} className={classes.header_elem_container} onClick={() => history.push('/')}>
                    <Typography variant="h4" className={classes.header_elem}>Logout</Typography>
                </Grid>
                </Grid>
            </Grid>
        </AppBar>
    )
}

export default AdminHeader;