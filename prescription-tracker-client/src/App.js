import './App.css';
import { Switch, Route } from "react-router-dom";

// Pages
import { Home, Login, PageNotFound } from "./Pages";
import { Contact, Patient, Tracking } from "./Pages/Patient";
import { AddPrescription, Admin, PatientDetails, PrescriptionSuccess } from './Pages/Admin';

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
          exact path="/Admin"
          render={props => 
            <Admin {...props} />
          }
        />
        <Route 
          exact path="/Admin/PatientDetails"
          render={props => 
            <PatientDetails {...props} />
          }
        />
        <Route 
          exact path="/Admin/AddPrescription"
          render={props => 
            <AddPrescription {...props} />
          }
        />
        <Route 
          exact path="/Admin/PrescriptionSuccess"
          render={props => 
            <PrescriptionSuccess {...props} />
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
