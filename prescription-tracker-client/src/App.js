import './App.css';
import { Switch, Route } from "react-router-dom";

// Pages
import { Home, Login, PageNotFound } from "./Pages";
import { Contact, Patient, Tracking } from "./Pages/Patient";

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
          exact path="/Patient/Tracking"
          render={props => 
            <Tracking {...props} />
          }
        />
        <Route 
          exact path="/Patient/Contact"
          render={props => 
            <Contact {...props} />
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
