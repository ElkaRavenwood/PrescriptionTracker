import { Box, Button, Grid, Icon, makeStyles, TextField, Typography } from "@material-ui/core"
import { useState } from "react";
import AdminHeader from "../../Components/AdminHeader";
import CustomButton from "../../Components/CustomButton";

const useStyles = makeStyles((theme) => ({
    root: {
        backgroundColor: theme.palette.primary.dark,
        height: "90vh",
    },
    fields: {
        display: "flex",
        paddingTop: "5vw",
        paddingBottom: "5vw",
        paddingLeft: "5vw",
        paddingRight: "5vw",
        color: "white",
    },
    text_element: {
        backgroundColor: "white",
        borderRadius: "5px",
    },
    refills: {
        alignItems: "center",
        display: "flex",
        width: "100%",
    },
    refillText: {
        width: "90%",
    },
}));

const AddPrescription = (props) => {

    const classes = useStyles();

    const [state, setState] = useState({
        firstName: "",
        lastName: "",
        patientId: "",
        pName: "",
        pId: "",
        pAmount: "",
        pRefills: 0,
        notes: "",
        error: false
    });

    const handleText = (event) => {
        if ((event.target.name === "pRefills" && event.target.value.match(/^[0-9]+$/) || event.target.name !== "pRefills")) {
            setState((state) => ({
                ...state,
                [event.target.name]: event.target.value,
            }));
        }
    }

    const handleSubmit = () => {
        // TODO Ping backend
        if (state.firstName && state.lastName && state.patientId && state.pName && state.pId && state.pAmount && state.pRefills) {

        } else { // if there are empty fields
            setState((state) => ({...state, error: true}));
        }
    }
    
    return (
        <div id="addPrescription" className="admin">
            <AdminHeader />
            <br/>
            <br/>
            <Box className={classes.root}>
                <Typography variant="h2" className="heading">Add Prescription</Typography>
                <Grid container className={classes.fields} spacing={3}>
                    <Grid item xs={4}>
                        <TextField className={classes.text_element} label="Patient First Name" variant="filled" value={state.firstName} name="firstName" onChange={handleText} required fullWidth required error={state.error && !state.firstName}/>
                    </Grid>
                    <Grid item xs={4}>
                        <TextField className={classes.text_element} label="Patient Last Name" variant="filled" value={state.lastName} name="lastName" onChange={handleText} required fullWidth required error={state.error && !state.lastName}/>
                    </Grid>
                    <Grid item xs={4}>
                        <TextField className={classes.text_element} label="Patient ID" variant="filled" value={state.patientId} name="patientId" onChange={handleText} required fullWidth required error={state.error && !state.patientId}/>
                    </Grid>
                    {/* <Grid item xs={6} />  */}
                    <Grid item xs={6}>
                        <TextField className={classes.text_element} label="Prescription Name" variant="filled" value={state.pName} name="pName" onChange={handleText} required fullWidth required error={state.error && !state.pName}/>
                    </Grid>
                    <Grid item xs={6}>
                        <TextField className={classes.text_element} label="Prescription ID" variant="filled" value={state.pId} name="pId" onChange={handleText} required fullWidth required error={state.error && !state.pId}/>
                    </Grid>
                    <Grid item xs={6}>
                        <TextField className={classes.text_element} label="Prescription Amount" variant="filled" value={state.pAmount} name="pAmount" onChange={handleText} required fullWidth required error={state.error && !state.pAmount}/>
                    </Grid>
                    <Grid item xs={6} className={classes.refills}>
                        <TextField className={classes.text_element + " " + classes.refillText} label="Number of Refills" variant="filled" value={state.pRefills} name="pRefills" onChange={handleText} required />
                        <Icon onClick={() => setState((state) => ({...state, pRefills: state.pRefills + 1}))} fontSize="large">add</Icon>
                        <Icon onClick={() => setState((state) => ({...state, pRefills: (state.pRefills - 1 >= 0 ? state.pRefills - 1 : 0)}))} fontSize="large">remove</Icon>
                    </Grid>
                    <Grid item xs={12}>
                        <TextField className={classes.text_element} multiline rows={4} label="Additional Notes" variant="filled" value={state.notes} name="notes" onChange={handleText} required fullWidth />
                    </Grid>
                </Grid>
                <br />
                <br />
                <Grid container>
                    <Grid item xs={4}/>
                    <Grid item xs={4}>
                        <CustomButton text="Add" color="primary" outlined fullWidth onClick={handleSubmit}/>
                    </Grid>
                    <Grid item xs={4}/>
                </Grid>
            </Box>
        </div>
    );
}

export default AddPrescription;