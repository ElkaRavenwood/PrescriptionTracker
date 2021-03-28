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
    },
    longRectangular: {
        padding: "0",
    },
    smallFont: {
        fontSize: "1em",
    },
    primaryTextColor: {
        color: theme.palette.primary.main,
    },
    primaryDarkTextColor: {
        color: theme.palette.primary.dark,
    },
}));

const CustomButton = (props) => {

    const { color, text, outlined, rectangular, variant, fullWidth, onClick, longRectangular, smallFont, primaryTextColor, primaryDarkTextColor, disabled} = props;

    const classes = useStyles();

    return (
        <Button className={classes.root + " " + 
            (outlined ? classes.outlined : '') + " " + 
            (rectangular ? classes.rectangular : '') + " " + 
            (longRectangular ? classes.longRectangular : '') + " " + 
            (smallFont ? classes.smallFont : '') + " " + 
            (primaryTextColor ? classes.primaryTextColor : '') + " " +
            (primaryDarkTextColor ? classes.primaryDarkTextColor : '')
        } 
        color={color} variant={variant} fullWidth={fullWidth} onClick={onClick} disabled={disabled}>{text}</Button>
    );

}

export default CustomButton;