import './App.css';
import { Switch, Route } from "react-router-dom";

// Pages
import { Home, Login, Signup, PageNotFound } from "./Pages";

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
          exact path="/Signup"
          render={props => 
            <Signup {...props} />
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
