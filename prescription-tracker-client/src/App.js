import './App.css';
import { Switch, Route } from "react-router-dom";

// Pages
import { Home, Login, PageNotFound } from "./Pages";
import Patient from './Pages/Patient/Patient';
import Contact from './Pages/Patient/Contact';
import Prescription from './Pages/Patient/Prescription';
import Tracking from './Pages/Patient/Tracking';

function App() {
  return (
    <div className="App">
      <Switch>
        <Route 
          exact path="/"
          render={props => 
            <Home {...props} />
          }
        />
        <Route 
          exact path="/Login"
          render={props => 
            <Login {...props} />
          }
        />
        <Route 
          exact path="/Patient"
          render={props => 
            <Patient {...props} />
          }
        />
        <Route 
          exact path="/Patient/Contact"
          render={props => 
            <Contact {...props} />
          }
        />
        <Route 
          exact path="/Patient/Prescription"
          render={props => 
            <Prescription {...props} />
          }
        />
        <Route 
          exact path="/Patient/Tracking"
          render={props => 
            <Tracking {...props} />
          }
        />
        <Route
          render={props => 
            <PageNotFound />
          }
        />
      </Switch>
    </div>
  );
}

export default App;
