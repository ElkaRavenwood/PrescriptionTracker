import { Box, makeStyles, Typography } from '@material-ui/core';
import React, { useRef } from 'react';
import HomeHeader from '../../Components/HomeHeader';
import background from "../../Resources/store.png"
import Signup from './Signup';

const useStyles = makeStyles((theme) => ({
    root: {
        width: "100%",
    },
    about_container: {
        backgroundImage: `url(${background})`,
        height: "70vh",
        backgroundPosition: 'center',
		backgroundSize: 'cover',
		backgroundRepeat: 'no-repeat',
        display: "flex",
        justifyContent: "center",
        alignItems: "center",
    }, 
    about_content_container: {
        backgroundColor: "white",
        opacity: ".8",
        marginLeft: "15vh",
        marginRight: "15vh",
        padding: "5vh",
    },
    about_content_text: {

    }
}));

const Home = (props) => {

    const classes = useStyles(); 
    const about = useRef(null);
    const signup = useRef(null);

    const executeScroll = (someRef) => someRef.current.scrollIntoView();

    return (
        <div className={classes.root}>
            <HomeHeader about={about} signup={signup} executeScroll={executeScroll}/>
            <Box className={classes.about_container} ref={about}>
                <Box className={classes.about_content_container}>
                    <Typography variant="h3" className={classes.about_content_text}>
                    Medi-Track is a free online software that will help you track, refill, and order your prescriptions in a more efficient way. Giving you real-time information, Medi-track is definitely the right service for you!
                    </Typography>
                </Box>
            </Box>
            <div ref={signup}>
                <Signup />
            </div>
        </div>
    )
}

export default Home;