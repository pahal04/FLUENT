// routes/scenarios.js

const express = require('express');
const router = express.Router();
const db = require('../db');

// GET /api/scenarios?language_id=1
router.get('/', async (req, res) => {
  const language_id = req.query.language_id;

  try {
    var result;

    if (language_id) {
      result = await db.query(
        'SELECT s.scenario_id, s.title, s.description, s.difficulty, l.lang_name FROM scenarios s JOIN languages l ON s.language_id = l.language_id WHERE s.language_id = $1 ORDER BY s.difficulty, s.title',
        [language_id]
      );
    } else {
      result = await db.query(
        'SELECT s.scenario_id, s.title, s.description, s.difficulty, l.lang_name FROM scenarios s JOIN languages l ON s.language_id = l.language_id ORDER BY s.difficulty, s.title'
      );
    }

    res.json(result.rows);
  } catch (err) {
    console.log('error fetching scenarios:', err);
    res.status(500).json({ error: 'Could not fetch scenarios.' });
  }
});

// TODO: GET /api/scenarios/:id - get single scenario with vocab

module.exports = router;
