import React from 'react';
import { Button, Box, TextField, Typography, makeStyles } from "@material-ui/core";
import axios from 'axios';
import MessageDisplay from '../../Components/MessageDisplay';
import { useHistory } from 'react-router';

const useStyles = makeStyles((theme) => ({
    root: {
        height: "100vh",
        display: "flex",
        flexDirection: "column",
        justifyContent: "center",
        paddingLeft: "30vw",
        paddingRight: "30vw",
        color: "white"
    },
    text_element: {
        backgroundColor: "white",
        borderRadius: "5px",
        marginBottom: "5vh"
    },
    button: {
        marginTop: "2vh",
        color: "white",
        fontSize: "3em",
        border: "solid 3px white",
    },
    backButton: {
        color: "white",
        fontSize: "2em",
        marginLeft: "-25vw",
        marginTop: "5vw",
        width: "20vh",
        border: 'solid 2px white',
    }
}))

const LoginContent = (props) => {

    const { state, setState, admin } = props;

    const classes = useStyles();

    const history = useHistory();

    const handleText = (event) => {
        setState((state) => ({
            ...state,
            [event.target.name]: event.target.value,
        }));
    }

    const handleSubmit = () => {
        // TODO work out login functionality
        axios.get("meditrack/user/login", {
            params: {
                query_pswd: "ae34ZF76!",
                email: state.email,
                password: state.password,
            }
        }).then((res) => {
                if(res.status === 201){
                    //this is an erro
                    setState((state)=> ({
                        ...state,
                        errorMessage: res.data,
                        showError: true
                    }));
                } else{
                    // TODO check success local storage
                    localStorage.setItem("prescriptionTrackerAdmin", admin ? true : false)
                    localStorage.setItem("prescriptionTrackerUserId", res.data._userId);
                    console.log(res.data);
                    // TODO check if user_id is the right name
                    if (admin) {
                        history.push("/Admin", {
                            userId: res.data.user_id,
                        });
                    } else {
                        history.push("/Patient", {
                            userId: res.data.user_id,
                        });

                    }
                }
        }, (error) => {
            //log the error
            console.log(error);
          });
    }

    return (
        <Box className={classes.root}>
            <MessageDisplay message={state.errorMessage} error={state.showError} />
            <Typography variant="h6" gutterBottom>Email</Typography>
            <TextField className={classes.text_element} variant="filled" value={state.email || admin ? "ewinear2@dailymotion.com" : "tpetters0@walmart.com"} type="email" name="email" onChange={handleText}/>
            <Typography variant="h6" gutterBottom>Password</Typography>
            <TextField className={classes.text_element} variant="filled" value={state.password || admin ? "MxKByHaJf" : 'epfHyxOLpN7'} name="password" type="password" onChange={handleText}/>
            <Button className={classes.button} variant="outlined" onClick={handleSubmit}>Login</Button>
            <Button className={classes.backButton} onClick={() => setState((state) => ({...state, showLogin: false}))}>Go Back</Button>
        </Box>
    )
}
export default LoginContent;