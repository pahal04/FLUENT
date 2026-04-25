// progress.js - tracks completed scenarios and confidence ratings

var express = require('express');
var router = express.Router();
var db = require('../db');

router.post('/complete', async function(req, res) {
  var user_id = req.body.user_id;
  var scenario_id = req.body.scenario_id;

  if (!user_id || !scenario_id) {
    return res.status(400).json({ error: 'user_id and scenario_id are required.' });
  }

  try {
    var result = await db.query(
      'INSERT INTO lesson_completions (user_id, scenario_id) VALUES ($1, $2) RETURNING *',
      [user_id, scenario_id]
    );
    res.json({ message: 'Marked as complete!', completion: result.rows[0] });
  } catch (err) {
    console.log('completion error:', err);
    res.status(500).json({ error: 'Could not save completion.' });
  }
});

router.post('/feedback', async function(req, res) {
  var user_id = req.body.user_id;
  var scenario_id = req.body.scenario_id;
  var rating = req.body.rating;
  var comments = req.body.comments;

  if (!user_id || !scenario_id || !rating) {
    return res.status(400).json({ error: 'user_id, scenario_id, and rating are required.' });
  }

  try {
    await db.query(
      'INSERT INTO confidence_feedback (user_id, scenario_id, rating, comments) VALUES ($1, $2, $3, $4)',
      [user_id, scenario_id, rating, comments || null]
    );
    res.json({ message: 'Feedback saved!' });
  } catch (err) {
    console.log('feedback error:', err);
    res.status(500).json({ error: 'Could not save feedback.' });
  }
});

// get all completed scenarios for a user
router.get('/:user_id', async function(req, res) {
  var user_id = req.params.user_id;

  var query = 'SELECT lc.completion_id, lc.completed_at, s.scenario_id, s.title, s.difficulty, l.lang_name, cf.rating as confidence_rating ';
  query += 'FROM lesson_completions lc ';
  query += 'JOIN scenarios s ON lc.scenario_id = s.scenario_id ';
  query += 'JOIN languages l ON s.language_id = l.language_id ';
  query += 'LEFT JOIN confidence_feedback cf ON cf.user_id = lc.user_id AND cf.scenario_id = lc.scenario_id ';
  query += 'WHERE lc.user_id = $1 ORDER BY lc.completed_at DESC';

  try {
    var result = await db.query(query, [user_id]);
    res.json(result.rows);
  } catch (err) {
    console.log('progress fetch error:', err);
    res.status(500).json({ error: 'Could not fetch progress.' });
  }
});

module.exports = router;
