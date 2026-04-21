// routes/admin.js
// TODO: not started yet

const express = require('express');
const router = express.Router();

router.get('/stats', (req, res) => {
  res.json({ message: 'admin stats - coming soon' });
});

module.exports = router;
