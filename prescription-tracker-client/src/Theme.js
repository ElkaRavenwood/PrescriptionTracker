import { createMuiTheme } from '@material-ui/core';

const theme = createMuiTheme({
    palette: {
        primary: {
            main: "#369fff",
            dark: "#0965bb"
        },
        success: {
            main: "hsl(104deg 77% 55% / 87%)",
        },
        secondary: {
            main: "#e792fd",
        },
    },
    overrides: {
        MuiTooltip: {
            tooltip: {
                fontSize: "1.25em",
                borderRadius: "5px",
            }
        }
    }
});

export default theme;