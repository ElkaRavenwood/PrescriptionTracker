import { Timeline, TimelineEvent } from '@mailtop/horizontal-timeline';
import { FaBookMedical, FaBoxOpen, FaCheckDouble, FaClock, FaRegFileAlt } from 'react-icons/fa';
import { Box, makeStyles } from "@material-ui/core";

const useStyles = makeStyles((theme) => ({
    root: {
        paddingTop: "3vh",
        marginTop: "3vh",
    },
}));

const TrackingTimeline = (props) => {

    const { currentStatus } = props;

    const classes = useStyles;
    const prescriptionStatuses = "Prescription Received,Prescription Logged,Pharmacist Verification,Packaging,Ready For Pickup".split(",");

    return (
        <Box className={classes.root}>
            <Timeline minEvents={5} placeholder>
            <TimelineEvent
                color={currentStatus === "1" ? "#30D5C8": "rgb(21 255 0 / 87%)"}
                icon={FaRegFileAlt}
                title={prescriptionStatuses[0]}
                // subtitle='26/03/2019 09:51'
                />
            <TimelineEvent
                color={currentStatus === "2" ? "#30D5C8": parseInt(currentStatus) > 2 ? "rgb(21 255 0 / 87%)" : ""}
                icon={FaBookMedical}
                title={prescriptionStatuses[1]}
                // subtitle='26/03/2019 09:51'
                />
            <TimelineEvent
                color={currentStatus === "3" ? "#30D5C8": parseInt(currentStatus) > 3 ? "rgb(21 255 0 / 87%)" : ""}
                icon={FaCheckDouble}
                title={prescriptionStatuses[2]}
                // subtitle='26/03/2019 09:51'
                />
            <TimelineEvent
                color={currentStatus === "4" ? "#30D5C8": parseInt(currentStatus) > 4 ? "rgb(21 255 0 / 87%)" : ""}
                icon={FaBoxOpen}
                title={prescriptionStatuses[3]}
                // subtitle='26/03/2019 09:51'
                />
            <TimelineEvent
                color={currentStatus === "5" ? "#30D5C8" : ""}
                icon={FaClock}
                title={prescriptionStatuses[4]}
                // subtitle='26/03/2019 09:51'
                />
            </Timeline>
        </Box>
    );
}

export default TrackingTimeline;