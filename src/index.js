const express = require('express');

const { routes } = require('./routes');

const router = express.Router();

router.get('/', function (req, res) {
  res.send('Backend is up!')
});

routes(router);

Object.assign(module.exports, {
  router,
});