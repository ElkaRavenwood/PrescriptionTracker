import React, { useState } from 'react';
import { Backdrop, Box, CircularProgress, Grid, makeStyles, Snackbar, TextField, Typography } from "@material-ui/core";
import axios from 'axios';
import PatientHeader from '../../Components/PatientHeader';
import CustomButton from '../../Components/CustomButton';

const useStyles = makeStyles((theme) => ({
	root: {
        backgroundColor: theme.palette.primary.main,
        color: "white",
        height: "90vh",
        paddingTop: "5vh",
	},
	textField: {
		marginBottom: "2vh",
        backgroundColor: "white",
	},
    backdrop: {
      zIndex: theme.zIndex.drawer + 1,
      color: '#fff',
      display: "flex",
      flexDirection: "column",
      justifyContent: "center",
    },
}))

const EmailSending = (props) => {

  const {open} = props;
  const classes = useStyles();

  return (
        <div>
            <Backdrop className={classes.backdrop} open={open}>
                Your email is being sent
                <CircularProgress color="inherit" />
            </Backdrop>
        </div>
  );
}

const Contact = (props) => {

	const classes = useStyles();

	const [state, setState] = useState({
		email: false,
		message: "",
		sending: false,
		sent: false,
		error: false,
	});

	const handleSubmit = () => {
		if (state.message) {
			setState((state) => ({
				...state,
				sending: true,
			}));
            // TODO
			// ping backend
			axios.get('/api/sendContact', {params: {
				email: state.email,
				message: state.message,
			}}).then((res) => {
				console.log(res)
				setState((state) => ({
					...state,
					sendResult: res.data.message,
					sending: false,
					sent: true,
				}));
			}).catch(err => console.log(err))
			setTimeout(function () {
				setState((state) => ({
					...state,
					sent: false,
				}));
			}, 6000);
		} else {
			setState((state) => ({...state, error: true}));
		}
	}

	const handleText = (event) => {
		setState((state) => ({
			...state,
			[event.target.name]: event.target.value,
			error: state.error && !event.target.value,
		}));
	}

	return (
		<div id="contact">
            <PatientHeader />
            <Box className={classes.root}>
                <EmailSending open={state.sending}/>
                {state.sent ? <Snackbar message={state.sendResult} open={state.sent}/> : null}
                <Grid container alignItems="flex-start" spacing={2}>
                    <Grid item xs={1} sm={2} />
                    <Grid item xs={10} sm={8}>
                        <Box>
                            <Typography variant="h4" align="center" component="h1" gutterBottom>
                                Contact Us
                            </Typography>
                            <Typography variant="h5" align="center" component="h2" gutterBottom>
                                {process.env.REACT_APP_INSTRUCTIONS_CONTACTUS_SUBHEADING}
                            </Typography>
                            <Typography paragraph>
                                {process.env.REACT_APP_INSTRUCTIONS_CONTACTUS_MAIN}
                            </Typography>
                            <TextField className={classes.textField} fullWidth variant="outlined"
                                name="email" type="email" label="Email" 
                                helperText={process.env.REACT_APP_INSTRUCTIONS_CONTACTUS_EMAIL} 
                                onChange={handleText}/>
                            <TextField className={classes.textField} fullWidth variant="outlined" multiline rows={10}
                                name="message" type="text" label="Message or Query" error={state.error}
                                helperText={state.error ? "This value cannot be empty." : process.env.REACT_APP_INSTRUCTIONS_CONTACTUS_MESSAGE} 
                                onChange={handleText}/>
                            
                        </Box>
                    </Grid>
                    <Grid item xs={1} sm={2} />
                    <Grid item xs={1} sm={2} />
                    <Grid item xs={10} sm={8}>
                        <CustomButton variant="contained" color="primary" onClick={handleSubmit} text="Submit" rectangular outlined/>
                    </Grid>
                    <Grid item xs={1} sm={2} />
                </Grid>
            </Box>
		</div>
	);
}

export default Contact;