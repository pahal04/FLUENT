// routes/auth.js
// user registration and login

const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
const db = require('../db');

// POST /api/auth/register
router.post('/register', async (req, res) => {
  const { username, email, password, full_name, birthday } = req.body;

  if (!username || !email || !password) {
    return res.status(400).json({ error: 'Username, email, and password are required.' });
  }

  try {
    const existing = await db.query(
      'SELECT user_id FROM users WHERE email = $1 OR username = $2',
      [email, username]
    );

    if (existing.rows.length > 0) {
      return res.status(400).json({ error: 'Username or email already taken.' });
    }

    const password_hash = await bcrypt.hash(password, 10);

    const result = await db.query(
      'INSERT INTO users (username, email, password_hash, full_name, birthday) VALUES ($1, $2, $3, $4, $5) RETURNING user_id, username, email',
      [username, email, password_hash, full_name || null, birthday || null]
    );

    res.status(201).json({ message: 'Account created!', user: result.rows[0] });

  } catch (err) {
    console.log('register error:', err);
    res.status(500).json({ error: 'Something went wrong.' });
  }
});

// POST /api/auth/login
// TODO: finish this - need to test it still
router.post('/login', async (req, res) => {
  const { username, password } = req.body;

  if (!username || !password) {
    return res.status(400).json({ error: 'Username and password required.' });
  }

  try {
    const result = await db.query(
      'SELECT * FROM users WHERE username = $1 OR email = $1',
      [username]
    );

    if (result.rows.length === 0) {
      return res.status(401).json({ error: 'Account not found.' });
    }

    const user = result.rows[0];
    const passwordMatch = await bcrypt.compare(password, user.password_hash);

    if (!passwordMatch) {
      return res.status(401).json({ error: 'Incorrect password.' });
    }

    res.json({
      message: 'Logged in!',
      user: {
        user_id: user.user_id,
        username: user.username,
        email: user.email,
        full_name: user.full_name
      }
    });

  } catch (err) {
    console.log('login error:', err);
    res.status(500).json({ error: 'Something went wrong.' });
  }
});

module.exports = router;
