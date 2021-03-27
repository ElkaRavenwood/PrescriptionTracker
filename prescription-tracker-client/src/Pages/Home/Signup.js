import { Button, Grid, makeStyles, TextField, Typography } from "@material-ui/core"
import { useState } from "react";

const useStyles = makeStyles((theme) => ({
    root: {
        backgroundColor: theme.palette.primary.main,
        // height: "80vh",
        display: "flex",
        // flexDirection: "column",
        paddingTop: "5vw",
        paddingBottom: "5vw",
        // justifyContent: "center",
        paddingLeft: "5vw",
        paddingRight: "5vw",
        color: "white"
    },
    text_element: {
        backgroundColor: "white",
        borderRadius: "5px",
        // width: "90%",
    },
    button: {
        marginTop: "2vh",
        color: "white",
        fontSize: "3em",
        border: "solid 3px white",
    },
}))

const Signup = (props) => {
    const classes = useStyles();

    const [state, setState] = useState({
        firstName: "",
        middleName: "",
        lastName: "",
        email: "jane.doe@email.ca",
        phone: "",
        healthCard: "",
        streetAddress: "",
        city: "",
        postalCode: "",
        securityQ1: "",
        securityA1: "",
        securityQ2: "",
        securityA2: "",
        securityQ3: "",
        securityA3: "",
        password: "",
        confirmPassword: ""
    });

    const handleText = (event) => {
        setState((state) => ({
            ...state,
            [event.target.name]: event.target.value,
        }));
    }

    const handleSubmit = () => {
        // TODO Ping backend
    }

    return ( 
        <Grid container className={classes.root} spacing={3}>
            <Grid xs={12} item><Typography variant="h1">Sign Up</Typography></Grid>
            <Grid xs={12} item><Typography variant="h2">General Information</Typography></Grid>
            <Grid xs={4} item>
                <TextField className={classes.text_element} label="First Name" variant="filled" value={state.firstName} name="firstName" onChange={handleText} required fullWidth/>
            </Grid>
            <Grid xs={4} item>
                <TextField className={classes.text_element} label="Middle Name" variant="filled" value={state.middleName} name="middleName" onChange={handleText} fullWidth/>
            </Grid>
            <Grid xs={4} item>
                <TextField className={classes.text_element} label="Last Name" variant="filled" value={state.lastName} name="lastName" onChange={handleText} required fullWidth/>
            </Grid>
            <Grid xs={4} item>
                <TextField className={classes.text_element} label="Email Adress" variant="filled" value={state.email} name="email" onChange={handleText} required fullWidth/>
            </Grid>
            <Grid xs={4} item>
                <TextField className={classes.text_element} label="Phone Number" variant="filled" value={state.phone} name="phone" onChange={handleText} required fullWidth/>
            </Grid>
            <Grid xs={4} item>
                <TextField className={classes.text_element} label="Health Card Number" variant="filled" value={state.healthCard} name="healthCard" onChange={handleText} required fullWidth/>
            </Grid>
            <Grid xs={4} item>
                <TextField className={classes.text_element} label="Street Adress" variant="filled" value={state.streetAddress} name="streetAddress" onChange={handleText} required fullWidth/>
            </Grid>
            <Grid xs={4} item>
                <TextField className={classes.text_element} label="City" variant="filled" value={state.city} name="city" onChange={handleText} required fullWidth/>
            </Grid>
            <Grid xs={4} item>
                <TextField className={classes.text_element} label="Postal Code" variant="filled" value={state.postalCode} name="postalCode" onChange={handleText} required fullWidth/>
            </Grid>

            <Grid xs={12} item><Typography variant="h2">Security Questions</Typography></Grid>
            <Grid item xs={6}>
                <TextField className={classes.text_element} label="Security Question #1" variant="filled" value={state.securityQ1} name="securityQ1" onChange={handleText} required fullWidth/>
            </Grid>
            <Grid item xs={6}>
                <TextField className={classes.text_element} label="Answer #1" variant="filled" value={state.securityA1} name="securityA1" onChange={handleText} required fullWidth/>
            </Grid>
            <Grid item xs={6}>
                <TextField className={classes.text_element} label="Security Question #2" variant="filled" value={state.securityQ2} name="securityQ2" onChange={handleText} required fullWidth/>
            </Grid>
            <Grid item xs={6}>
                <TextField className={classes.text_element} label="Answer #2" variant="filled" value={state.securityA2} name="securityA2" onChange={handleText} required fullWidth/>
            </Grid>
            <Grid item xs={6}>
                <TextField className={classes.text_element} label="Security Question #3" variant="filled" value={state.securityQ3} name="securityQ3" onChange={handleText} required fullWidth/>
            </Grid>
            <Grid item xs={6}>
                <TextField className={classes.text_element} label="Answer #3" variant="filled" value={state.securityA3} name="securityA3" onChange={handleText} required fullWidth/>
            </Grid>
            <Grid item xs={6}>
                <TextField className={classes.text_element} label="Password" variant="filled" value={state.password} name="password" onChange={handleText} required fullWidth/>
            </Grid>
            <Grid item xs={6}>
                <TextField className={classes.text_element} label="Confirm Password" variant="filled" value={state.confirmPassword} name="confirmPassword" onChange={handleText} required fullWidth/>
            </Grid>
            <Grid item xs={12}>
                <Button className={classes.button} variant="outlined" onClick={handleSubmit}>Sign Up</Button>
            </Grid>
        </Grid>);
}

export default Signup;