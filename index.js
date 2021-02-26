const express = require('express');
const dotEnv = require('dotenv');

dotEnv.config();

const api = require('./src').router;
const app = express();
const port = process.env.PORT || 8000;

// backend
app.use('/api', api);

// front end
app.use(express.static(`${__dirname}/prescription-tracker-client/build`));

app.listen(port, () => {
  console.log(`App is listening on port ${port}!`)
});
