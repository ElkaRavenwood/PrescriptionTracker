import { Button } from '@material-ui/core';
import React from 'react';
import { useHistory } from 'react-router-dom';

const Home = (props) => {

    const history = useHistory();

    return (
        <div>
            <p>Default home page. Test buttons below</p>
            <Button onClick={() => history.push('/Login')}>Login</Button>
            <Button onClick={() => history.push('/Signup')}>Signup</Button>
        </div>
    )
}

export default Home;