import { makeStyles, Typography } from "@material-ui/core"
import AdminHeader from "../../Components/AdminHeader";

const useStyles = makeStyles((theme) => ({
    root: {
        paddingTop: "5vh",
        backgroundColor: theme.palette.primary.dark,
        height: "90vh",
    },
    body: {
        color: "white",
        paddingTop: "5vh",
    },
}));

const PrescriptionSuccess = () => {
    const classes = useStyles();

    return(
        <div>
            <AdminHeader />
            <div className = {classes.root}>
                <Typography variant = "h2" className="heading">Prescription Made</Typography>
                <Typography variant = "h4" className={classes.body}>
                    The prescription was made. Use the header to navigate away.
                </Typography>
            </div>
        </div>
    )
}

export default PrescriptionSuccess;