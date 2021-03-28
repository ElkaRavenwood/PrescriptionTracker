import { Box, makeStyles, TextField, Typography } from "@material-ui/core";
import { Timeline, TimelineEvent } from '@mailtop/horizontal-timeline';
import { FaClipboardCheck, FaClock, FaRegFileAlt, FaUserCheck } from 'react-icons/fa';
import PatientHeader from "../../Components/PatientHeader";
import { useEffect, useState } from "react";
import CustomButton from "../../Components/CustomButton";

const useStyles = makeStyles((theme) => ({
    root: {
        backgroundColor: theme.palette.primary.main,
        paddingTop: "3vh",
        color: "white",
        height: "90vh",
    },
    container: {
        width: "90vw",
        margin: "auto"
    },
    timeline: {
        paddingTop: "3vh",
    },
    details: {
        textAlign: "left",
    },
    needs: {
        textAlign: "left",
        marginTop: "3vh",
    },
    text: {
        backgroundColor: "white",
    },
    submitButton: {
        position: "right",
        marginTop: "3vh",
        display: "flex",
        justifyContent: "flex-end",
    },
}));

const Tracking = (props) => {

    const classes = useStyles();

    const [data, setData] = useState({});
    const [state, setState] = useState("");

    useEffect(() => {
        let temp = {
            orderNumber: "0000",
            orderStatus: "Order Received",
            orderUpdated: "21-03-2021 17:02:15",
        }
        // TODO pull from db
        setData(temp);
    }, []);

    const handleSubmit = () => {
        // TODO ping backend
    }

    return (
        <div id="tracking">
            <PatientHeader />
            <Box className={classes.root}>
                <Box className={classes.container}>
                    <Typography variant="h2" className={"heading"}>Order Tracking</Typography>
            
                    <Box className={classes.timeline}>
                        <Timeline minEvents={4} placeholder>
                        <TimelineEvent
                            icon={FaRegFileAlt}
                            title='Order Placed'
                            // subtitle='26/03/2019 09:51'
                            />
                        <TimelineEvent
                            color='#87a2c7'
                            icon={FaClipboardCheck}
                            title='Order Received'
                            // subtitle='26/03/2019 09:51'
                            />
                        <TimelineEvent
                            color='#30D5C8'
                            icon={FaClock}
                            title='In Progress'
                            // subtitle='26/03/2019 09:51'
                            />
                        <TimelineEvent
                            color='#03c040'
                            icon={FaUserCheck}
                            title='Ready for Pick Up'
                            // subtitle='26/03/2019 09:51'
                            />
                        </Timeline>
                    </Box>
                    <Box className={classes.details}>
                        <Typography variant="h5" gutterBottom><strong>Order Number</strong>: {data.orderNumber}</Typography>
                        <Typography variant="h5" gutterBottom><strong>Order Status</strong>: {data.orderStatus}</Typography>
                        <Typography variant="h5" gutterBottom><strong>Order Updated</strong>: {data.orderUpdated}</Typography>
                    </Box>
                    <Box className={classes.needs}>
                        <Typography variant="h5" gutterBottom><strong>Customer Needs:</strong></Typography>
                        <TextField multiline variant="outlined" rows={4} onChange={(val) => setState(val)} value={state} fullWidth className={classes.text}/>
                        <div className={classes.submitButton} onClick={handleSubmit}>
                            <CustomButton color="secondary" text="Add Note" variant="contained" rectangular />
                        </div>
                    </Box>
                </Box>
            </Box>
        </div>
    );
}

export default Tracking;