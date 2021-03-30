import React, { useState } from "react";
import { Snackbar } from "@material-ui/core";

/**
 * A component that displays a message when triggered in a popup at the bottom of the screen
 * @param {string} props.message the message to be displayed
 * @param {boolean} props.error whether or not this is an error message. If it is, it displays for longer
 */
const MessageDisplay = (props) => {
    const { message, error } = props;
    
    const [open, setOpen] = useState(true);

    if (!message) return ""

    return (
        <Snackbar message={message} open={open} autoHideDuration={error? null: 3000} onClose={() => setOpen(false)}/>
    )
}

export default MessageDisplay;