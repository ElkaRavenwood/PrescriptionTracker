import { Box, Grid, Icon, makeStyles, TextField, Typography } from "@material-ui/core"
import axios from "axios";
import { useState } from "react";
import { useHistory } from "react-router";
import AdminHeader from "../../Components/AdminHeader";
import CustomButton from "../../Components/CustomButton";
import MessageDisplay from "../../Components/MessageDisplay";

const useStyles = makeStyles((theme) => ({
    root: {
        backgroundColor: theme.palette.primary.dark,
        height: "90vh",
        paddingTop: "5vw",
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

    const history = useHistory();

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
        if ((event.target.name === "pRefills" && event.target.value.match(/^[0-9]+$/)) || event.target.name !== "pRefills") {
            setState((state) => ({
                ...state,
                [event.target.name]: event.target.value,
            }));
        }
    }

    const handleSubmit = () => {
        if (state.firstName && state.lastName && state.patientId && state.pName && state.pId && state.pAmount) {
            axios.post("/meditrack/precs", {
                rx: state.pId,
                user_id: state.patientId,
                pharm_id: localStorage.getItem("prescriptionTrackerUserId"),
                status_date: new Date(),
                med_name: state.pName,
                max_refills: state.pRefills,
                cur_refills: 0,
                query_pswd: "ae34ZF76!",
            }).then(res => {
                console.log(res)
                if (res.status === 200) {
                    console.log('asd')
                    setState((state) => ({...state,successMessage: "Success!"})); // note success
                    history.push("/Admin/PrescriptionSuccess");
                } else {
                    // TODO check error handling
                    setState((state)=> ({
                        ...state,
                        errorMessage: res.data,
                        showError: true
                    }));
                }

            })

        } else { // if there are empty fields
            setState((state) => ({...state, error: true}));
        }
    }
    
    return (
        <div id="addPrescription" className="admin">
            <AdminHeader />
            <Box className={classes.root}>
                <Typography variant="h2" className="heading">Add Prescription</Typography>
                <Grid container className={classes.fields} spacing={3}>
                    <Grid item xs={4}>
                        <TextField className={classes.text_element} label="Patient First Name" variant="filled" value={state.firstName} name="firstName" onChange={handleText} fullWidth required error={state.error && !state.firstName}/>
                    </Grid>
                    <Grid item xs={4}>
                        <TextField className={classes.text_element} label="Patient Last Name" variant="filled" value={state.lastName} name="lastName" onChange={handleText} fullWidth required error={state.error && !state.lastName}/>
                    </Grid>
                    <Grid item xs={4}>
                        <TextField className={classes.text_element} label="Patient ID" variant="filled" value={state.patientId} name="patientId" onChange={handleText} fullWidth required error={state.error && !state.patientId}/>
                    </Grid>
                    {/* <Grid item xs={6} />  */}
                    <Grid item xs={6}>
                        <TextField className={classes.text_element} label="Prescription Name" variant="filled" value={state.pName} name="pName" onChange={handleText} fullWidth required error={state.error && !state.pName}/>
                    </Grid>
                    <Grid item xs={6}>
                        <TextField className={classes.text_element} label="Prescription ID" variant="filled" value={state.pId} name="pId" onChange={handleText} fullWidth required error={state.error && !state.pId}/>
                    </Grid>
                    <Grid item xs={6}>
                        <TextField className={classes.text_element} label="Prescription Amount" variant="filled" value={state.pAmount} name="pAmount" onChange={handleText} fullWidth required error={state.error && !state.pAmount}/>
                    </Grid>
                    <Grid item xs={6} className={classes.refills}>
                        <TextField className={classes.text_element + " " + classes.refillText} label="Number of Refills" variant="filled" value={state.pRefills} name="pRefills" onChange={handleText} required />
                        <Icon onClick={() => setState((state) => ({...state, pRefills: state.pRefills + 1}))} fontSize="large">add</Icon>
                        <Icon onClick={() => setState((state) => ({...state, pRefills: (state.pRefills - 1 >= 0 ? state.pRefills - 1 : 0)}))} fontSize="large">remove</Icon>
                    </Grid>
                    <Grid item xs={12}>
                        <TextField className={classes.text_element} multiline rows={4} label="Additional Notes" variant="filled" value={state.notes} name="notes" onChange={handleText} fullWidth />
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
            <MessageDisplay message={state.errorMessage} error={state.showError} />
			<MessageDisplay message={state.successMessage} />
        </div>
    );
}

export default AddPrescription;