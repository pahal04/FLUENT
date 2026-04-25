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

// GET /api/scenarios/:id - get one scenario with its vocabulary list
router.get('/:id', async (req, res) => {
  var id = req.params.id;

  try {
    var scenResult = await db.query(
      'SELECT s.*, l.lang_name FROM scenarios s JOIN languages l ON s.language_id = l.language_id WHERE s.scenario_id = $1',
      [id]
    );

    if (scenResult.rows.length === 0) {
      return res.status(404).json({ error: 'Scenario not found.' });
    }

    var vocabResult = await db.query(
      'SELECT * FROM vocabulary WHERE scenario_id = $1 ORDER BY vocab_id',
      [id]
    );

    res.json({ scenario: scenResult.rows[0], vocabulary: vocabResult.rows });

  } catch (err) {
    console.log('error fetching scenario:', err);
    res.status(500).json({ error: 'Could not fetch scenario.' });
  }
});

module.exports = router;
