const { makeStyles, Button } = require("@material-ui/core")

const useStyles = makeStyles((theme) => ({
    root: {
        color: "white",
        padding: "3vh",
        fontSize: "1.5em",
        textTransform: "unset",
        textDecoration: "unset !important",
    },
    outlined: {
        border: "solid 1px white",
    },
    rectangular: {
        // paddingTop: "2vh !important",
        // paddingBottom: "2vh !important",
        // paddingBottom: "2vh !important",
        padding: "2vh 4vh 2vh 4vh",
    }
}))

const CustomButton = (props) => {

    const { color, text, outlined, rectangular, variant, fullWidth, onClick } = props;

    const classes = useStyles();

    return (
        <Button className={classes.root + " " + (outlined ? classes.outlined : '') + " " + (rectangular ? classes.rectangular : '')} color={color} variant={variant} fullWidth={fullWidth} onClick={onClick}>{text}</Button>
    );

}

export default CustomButton;