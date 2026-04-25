// languages.js

var express = require('express');
var router = express.Router();
var db = require('../db');

router.get('/', async function(req, res) {
  try {
    var result = await db.query('SELECT * FROM languages ORDER BY lang_name');
    res.json(result.rows);
  } catch (err) {
    console.log('error getting languages:', err);
    res.status(500).json({ error: 'Could not fetch languages.' });
  }
});

module.exports = router;
