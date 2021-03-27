import './App.css';
import { Switch, Route } from "react-router-dom";

// Pages
import { Home, Login, PageNotFound } from "./Pages";
import Patient from './Pages/Patient/Patient';
import History from './Pages/Patient/History';
import Contact from './Pages/Patient/Contact';
import Prescription from './Pages/Patient/Prescription';

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
          exact path="/Patient/History"
          render={props => 
            <History {...props} />
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
