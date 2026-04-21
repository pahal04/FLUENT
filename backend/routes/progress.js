// routes/progress.js
// TODO: build this out once scenario page is done

const express = require('express');
const router = express.Router();
const db = require('../db');

// POST /api/progress/complete
router.post('/complete', async (req, res) => {
  // TODO
  res.status(501).json({ error: 'Not implemented yet.' });
});

// POST /api/progress/feedback
router.post('/feedback', async (req, res) => {
  // TODO
  res.status(501).json({ error: 'Not implemented yet.' });
});

// GET /api/progress/:user_id
router.get('/:user_id', async (req, res) => {
  // TODO
  res.status(501).json({ error: 'Not implemented yet.' });
});

module.exports = router;
