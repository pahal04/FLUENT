// routes/languages.js
// get all available languages

const express = require('express');
const router = express.Router();
const db = require('../db');

// GET /api/languages
router.get('/', async (req, res) => {
  try {
    const result = await db.query(
      'SELECT * FROM languages ORDER BY lang_name'
    );
    res.json(result.rows);
  } catch (err) {
    console.error('Error fetching languages:', err);
    res.status(500).json({ error: 'Could not fetch languages.' });
  }
});

module.exports = router;
