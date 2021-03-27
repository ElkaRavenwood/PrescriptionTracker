import { Box, Button, Grid, makeStyles } from "@material-ui/core";
import { useHistory, useLocation } from "react-router";
import { useEffect, } from "react";
import PatientHeader from "../../Components/PatientHeader";
import background from "../../Resources/store.png";
import { Link } from "react-router-dom";
import Prescription from "./Prescription";
import CustomButton from "../../Components/CustomButton";
import Refill from "./Refill";

const useStyles = makeStyles((theme) => ({
    root: {
        width: "100%",
    },
    nav_container: {
        backgroundImage: `url(${background})`,
        height: "70vh",
        backgroundPosition: 'center',
		backgroundSize: 'cover',
		backgroundRepeat: 'no-repeat',
        display: "flex",
        justifyContent: "center",
        alignItems: "center",
    }, 
    nav_content_container: {
        backgroundColor: "white",
        opacity: ".8",
    },
}));

const Patient = (props) => {

    const classes = useStyles();

    const history = useHistory();
    const location = useLocation();

    useEffect(() => {
        if (location.hash) {
            let elem = document.getElementById(location.hash.substring(1));
            console.log(elem)
            if (elem) {
                elem.scrollIntoView({behavior: "smooth"})
            }
            } else {
                window.scrollTo({top:0,left:0, behavior: "smooth"})
            }
    }, [location]);

    return (
        <div classes={classes.root}>
            <PatientHeader />
            <Box className={classes.nav_container}>
                <Grid container spacing={10}>
                    <Grid item xs={2}/>
                        <Grid item xs={3}>
                            <Link to={{pathname:"/Patient", hash:"prescription"}} className="noUnderline">
                                <CustomButton text="Prescription" color="primary" variant="contained" fullWidth/>
                            </Link>
                        </Grid>
                    <Grid item xs={2}/>
                    <Grid item xs={3} onClick={() => history.push("/Patient/Tracking")}>
                        <CustomButton text="Tracking" color="primary" variant="contained" fullWidth/>
                    </Grid>
                    <Grid item xs={2}/>
                    <Grid item xs={2}/>
                    {/* <Link to="/Patient/#prescription" className="noUnderline"> */}
                        <Grid item xs={3} onClick={() => history.push("/Patient/History")}>
                            <CustomButton text="Order History" color="primary" variant="contained" fullWidth/>
                        </Grid>
                    {/* </Link> */}
                    <Grid item xs={2}/>
                    <Grid item xs={3} onClick={() => history.push("/Patient/Contact")}>
                        <CustomButton text="Contact Us" color="primary" variant="contained" fullWidth/>
                    </Grid>
                    <Grid item xs={2}/>
                </Grid>
            </Box>
            <Prescription/>
            <Refill />

        </div>
    );
}

export default Patient;