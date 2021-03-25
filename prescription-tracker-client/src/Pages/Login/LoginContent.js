import React from 'react';
import { Button, Box, TextField, Typography, makeStyles } from "@material-ui/core";
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

    const { state, setState } = props;

    const classes = useStyles();

    const handleText = (event) => {
        setState((state) => ({
            ...state,
            [event.target.name]: event.target.value,
        }));
    }

    const handleSubmit = () => {

    }

    return (
        <Box className={classes.root}>
            <Typography variant="h6" gutterBottom>Email</Typography>
            <TextField className={classes.text_element} variant="filled" value={state.email} type="email" name="email" onChange={handleText}/>
            <Typography variant="h6" gutterBottom>Password</Typography>
            <TextField className={classes.text_element} variant="filled" value={state.password} name="password" type="password" onChange={handleText}/>
            <Button className={classes.button} variant="outlined" onClick={handleSubmit}>Login</Button>
            <Button className={classes.backButton} onClick={() => setState((state) => ({...state, showLogin: false}))}>Go Back</Button>
        </Box>
    )
}
export default LoginContent;