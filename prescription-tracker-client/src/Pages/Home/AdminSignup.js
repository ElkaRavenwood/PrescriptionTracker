import { Button, Grid, makeStyles, TextField, Typography } from "@material-ui/core"
import axios from "axios";
import { useState } from "react";
import { useHistory } from "react-router";
import MessageDisplay from "../../Components/MessageDisplay";

const useStyles = makeStyles((theme) => ({
    root: {
        backgroundColor: theme.palette.primary.dark,
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

const AdminSignup = (props) => {
    const classes = useStyles();

    const history = useHistory();

    const [state, setState] = useState({
        name: "",
        email: "",
        phone: "",
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
        // checks required fields
        if (state.firstName=== "" || state.lastName=== "" || state.email=== "jane.doe@email.ca" || state.phone=== "" || state.streetAddress=== "" || state.city=== "" || state.postalCode=== "" || state.securityQ1=== "" || state.securityA1=== "" || state.securityQ2=== "" || state.securityA2=== "" || state.securityQ3=== "" || state.securityA3=== "" || state.password=== "" || state.confirmPassword=== "" || state.password!==state.confirmPassword) {
            setState((state) => ({...state, error: true}))
        } else {
            axios.post("/meditrack/pharm/account", {
                query_pswd: "ae34ZF76!",
                name: state.name,
                email: state.email,
                phone_no: state.phone,
                password: state.password,
                street_address: state.streetAddress,
                city: state.city,
                postal_code: state.postalCode,
                sec_quest_1: state.securityQ1,
                sec_ans_1: state.securityA1,
                sec_quest_2: state.securityQ2,
                sec_ans_2: state.securityA2,
                sec_quest_3: state.securityQ3,
                sec_ans_3: state.securityA3,
            }).then((res) => {
                console.log(res)
                if (res.status === 200) {
                    localStorage.setItem("prescriptionTrackerAdmin", true)
                    localStorage.setItem("prescriptionTrackerUserId", res.data.pharm_id);
                    history.push("/Admin");
                } else {
                    setState((state)=> ({...state,
                        errorMessage: res.data.message,
                        showError: true
                    }));
                }
            });
        }
    }

    // TODO change all security questions to dropdowns
    return ( 
        <Grid container className={classes.root} spacing={3}>
            <MessageDisplay message={state.errorMessage} error={state.showError} />
            <Grid xs={12} item><Typography variant="h1">Admin Sign Up</Typography></Grid>
            <Grid xs={12} item><Typography variant="h2">General Information</Typography></Grid>
            <Grid xs={4} item>
                <TextField className={classes.text_element} label="Name" variant="filled" value={state.name} name="name" onChange={handleText} required fullWidth error={state.error && state.name ===""}/>
            </Grid>
            <Grid xs={4} item>
                <TextField className={classes.text_element} label="Pharmacy Email Address" variant="filled" value={state.email} name="email" onChange={handleText} required fullWidth error={state.error && state.email ===""}/>
            </Grid>
            <Grid xs={4} item>
                <TextField className={classes.text_element} label="Phone Number" variant="filled" value={state.phone} name="phone" onChange={handleText} required fullWidth error={state.error && state.phone ===""}/>
            </Grid>
            <Grid xs={4} item>
                <TextField className={classes.text_element} label="Street Adress" variant="filled" value={state.streetAddress} name="streetAddress" onChange={handleText} required fullWidth error={state.error && state.streetAddress ===""}/>
            </Grid>
            <Grid xs={4} item>
                <TextField className={classes.text_element} label="City" variant="filled" value={state.city} name="city" onChange={handleText} required fullWidth error={state.error && state.city ===""}/>
            </Grid>
            <Grid xs={4} item>
                <TextField className={classes.text_element} label="Postal Code" variant="filled" value={state.postalCode} name="postalCode" onChange={handleText} required fullWidth error={state.error && state.postalCode ===""}/>
            </Grid>

            <Grid xs={12} item><Typography variant="h2">Security Questions</Typography></Grid>
            <Grid item xs={6}>
                <TextField className={classes.text_element} label="Security Question #1" variant="filled" value={state.securityQ1} name="securityQ1" onChange={handleText} required fullWidth error={state.error && state.securityQ1 ===""}/>
            </Grid>
            <Grid item xs={6}>
                <TextField className={classes.text_element} label="Answer #1" variant="filled" value={state.securityA1} name="securityA1" onChange={handleText} required fullWidth error={state.error && state.securityA1 ===""}/>
            </Grid>
            <Grid item xs={6}>
                <TextField className={classes.text_element} label="Security Question #2" variant="filled" value={state.securityQ2} name="securityQ2" onChange={handleText} required fullWidth error={state.error && state.securityQ2 ===""}/>
            </Grid>
            <Grid item xs={6}>
                <TextField className={classes.text_element} label="Answer #2" variant="filled" value={state.securityA2} name="securityA2" onChange={handleText} required fullWidth error={state.error && state.securityA2 ===""}/>
            </Grid>
            <Grid item xs={6}>
                <TextField className={classes.text_element} label="Security Question #3" variant="filled" value={state.securityQ3} name="securityQ3" onChange={handleText} required fullWidth error={state.error && state.securityQ3 ===""}/>
            </Grid>
            <Grid item xs={6}>
                <TextField className={classes.text_element} label="Answer #3" variant="filled" value={state.securityA3} name="securityA3" onChange={handleText} required fullWidth error={state.error && state.securityA3===""}/>
            </Grid>
            <Grid item xs={6}>
                <TextField className={classes.text_element} label="Password" variant="filled" value={state.password} name="password" onChange={handleText} required fullWidth error={state.error && (state.password ===""|| state.password !== state.confirmPassword)}/>
            </Grid>
            <Grid item xs={6}>
                <TextField className={classes.text_element} label="Confirm Password" variant="filled" value={state.confirmPassword} name="confirmPassword" onChange={handleText} required fullWidth error={state.error && (state.confirmPassword ==="" || state.password !== state.confirmPassword)}/>
            </Grid>
            <Grid item xs={12}>
                <Button className={classes.button} variant="outlined" onClick={handleSubmit}>Sign Up</Button>
            </Grid>
        </Grid>);
}

export default AdminSignup;