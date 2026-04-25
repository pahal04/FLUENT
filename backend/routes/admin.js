// admin.js - stats and content management for the admin dashboard

var express = require('express');
var router = express.Router();
var db = require('../db');

router.get('/stats', async function(req, res) {
  try {
    var usersResult = await db.query('SELECT COUNT(*) as count FROM users');
    var completionsResult = await db.query('SELECT COUNT(*) as count FROM lesson_completions');
    var feedbackResult = await db.query('SELECT COUNT(*) as count FROM confidence_feedback');
    var avgResult = await db.query('SELECT ROUND(AVG(rating), 1) as avg FROM confidence_feedback');

    var popularResult = await db.query(
      'SELECT s.title, l.lang_name, COUNT(lc.completion_id) as completions FROM lesson_completions lc JOIN scenarios s ON lc.scenario_id = s.scenario_id JOIN languages l ON s.language_id = l.language_id GROUP BY s.title, l.lang_name ORDER BY completions DESC LIMIT 5'
    );

    var byLangResult = await db.query(
      'SELECT l.lang_name, COUNT(lc.completion_id) as completions FROM lesson_completions lc JOIN scenarios s ON lc.scenario_id = s.scenario_id JOIN languages l ON s.language_id = l.language_id GROUP BY l.lang_name ORDER BY completions DESC'
    );

    res.json({
      total_users: usersResult.rows[0].count,
      total_completions: completionsResult.rows[0].count,
      total_feedback: feedbackResult.rows[0].count,
      avg_confidence_rating: avgResult.rows[0].avg,
      popular_scenarios: popularResult.rows,
      completions_by_language: byLangResult.rows
    });

  } catch (err) {
    console.log('admin stats error:', err);
    res.status(500).json({ error: 'Could not load stats.' });
  }
});

// add a new scenario
router.post('/scenarios', async function(req, res) {
  var language_id = req.body.language_id;
  var title = req.body.title;
  var description = req.body.description;
  var difficulty = req.body.difficulty;

  if (!language_id || !title) {
    return res.status(400).json({ error: 'language_id and title are required.' });
  }

  try {
    var result = await db.query(
      'INSERT INTO scenarios (language_id, title, description, difficulty) VALUES ($1, $2, $3, $4) RETURNING *',
      [language_id, title, description || null, difficulty || 'Beginner']
    );
    res.status(201).json({ message: 'Scenario added!', scenario: result.rows[0] });
  } catch (err) {
    console.log('add scenario error:', err);
    res.status(500).json({ error: 'Could not add scenario.' });
  }
});

// add a vocab word to a scenario
router.post('/vocabulary', async function(req, res) {
  var scenario_id = req.body.scenario_id;
  var phrase = req.body.word;
  var translation = req.body.translation;
  var example_usage = req.body.example_phrase;

  if (!scenario_id || !phrase || !translation) {
    return res.status(400).json({ error: 'scenario_id, word, and translation are required.' });
  }

  try {
    await db.query(
      'INSERT INTO vocabulary (scenario_id, phrase, translation, example_usage) VALUES ($1, $2, $3, $4)',
      [scenario_id, phrase, translation, example_usage || null]
    );
    res.status(201).json({ message: 'Vocabulary added!' });
  } catch (err) {
    console.log('add vocab error:', err);
    res.status(500).json({ error: 'Could not add vocabulary.' });
  }
});

module.exports = router;
