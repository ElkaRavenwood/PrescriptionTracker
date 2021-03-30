import { Box, Button, makeStyles, Typography } from "@material-ui/core"
// import background from "../../Resources/shelves.png";

const useStyles = makeStyles((theme) => ({
    root: {
        display: "flex",
        justifyContent: "space-evenly",
        alignItems: "center",
        height: "90vh",
        // backgroundImage: `url(${background})`,
        // height: "70vh",
        // backgroundPosition: 'center',
		// backgroundSize: 'cover',
		// backgroundRepeat: 'no-repeat',
        backgroundColor: theme.palette.primary.main,
    },
    button: {
        padding: "2vw",
        border: "solid 5px white",
        color: "white",
    }
}))

const SelectLogin = (props) => {

    const { setState } = props;

    const classes = useStyles();

    return <Box className={classes.root}>
        <Button className={classes.button}><Typography variant="h2" onClick={() => setState((state) => ({...state, showLogin: true, admin: true}))}>Admin Login</Typography></Button>
        <Button className={classes.button} onClick={() => setState((state) => ({...state, admin: false, showLogin: true}))}><Typography variant="h2">Patient Login</Typography></Button>
    </Box>
}

export default SelectLogin;