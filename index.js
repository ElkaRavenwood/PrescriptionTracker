const express = require('express');
const dotEnv = require('dotenv');

dotEnv.config();

const api = require('./src/api_calls'); //made change for supporting backend
const app = express();
const port = process.env.PORT || 8000;
app.use(express.json());

api(app);

// front end
app.use(express.static(`${__dirname}/prescription-tracker-client/build`));

// for production
// app.get('/', (req, res) => {
//   res.sendFile(path.join(__dirname, 'build', 'index.html'))
// })

app.listen(port, () => {
  console.log(`App is listening on port ${port}!`)
});


// console.log(app._router)