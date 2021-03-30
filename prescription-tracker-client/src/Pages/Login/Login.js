import { Box, makeStyles } from "@material-ui/core"
import { useState } from "react";
import HomeHeader from "../../Components/HomeHeader.js";
import LoginContent from "./LoginContent.js";
import SelectLogin from "./SelectLogin.js";

const useStyles = makeStyles((theme) => ({
    root: {
        height: "100vh",
        display: "flex",
        flexDirection: "column",
        justifyContent: "center",
        color: "white"
    },
    admin: {
        backgroundColor: theme.palette.primary.dark,
    },
    patient: {
        backgroundColor: theme.palette.primary.main,
    },
}));

const Login = (props) => {

    const classes = useStyles();

    const [state, setState] = useState({
        email: "",
        password: "",
        admin: false,
        showLogin: false,
    });

    return (
        <div className={classes.root}>
            <HomeHeader />
            {!state.showLogin ? <SelectLogin setState={setState}/> :
            <Box className={(state.admin ? classes.admin : classes.patient)}>
                <LoginContent state={state} setState={setState}/>
            </Box>
            }
        </div>
    );

}

export default Login;