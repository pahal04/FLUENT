// auth.js - login and register routes

var express = require('express');
var router = express.Router();
var bcrypt = require('bcrypt');
var db = require('../db');

// register a new user
router.post('/register', async function(req, res) {
  var username = req.body.username;
  var email = req.body.email;
  var password = req.body.password;
  var full_name = req.body.full_name;
  var birthday = req.body.birthday;

  if (!username || !email || !password) {
    return res.status(400).json({ error: 'Username, email, and password are required.' });
  }

  try {
    var existing = await db.query(
      'SELECT user_id FROM users WHERE email = $1 OR username = $2',
      [email, username]
    );

    if (existing.rows.length > 0) {
      return res.status(400).json({ error: 'Username or email already taken.' });
    }

    var password_hash = await bcrypt.hash(password, 10);

    var result = await db.query(
      'INSERT INTO users (username, email, password_hash, full_name, birthday) VALUES ($1, $2, $3, $4, $5) RETURNING user_id, username, email',
      [username, email, password_hash, full_name || null, birthday || null]
    );

    res.status(201).json({ message: 'Account created!', user: result.rows[0] });

  } catch (err) {
    console.log('register error:', err);
    res.status(500).json({ error: 'Something went wrong.' });
  }
});

// log in an existing user
router.post('/login', async function(req, res) {
  var username = req.body.username;
  var password = req.body.password;

  if (!username || !password) {
    return res.status(400).json({ error: 'Username and password required.' });
  }

  try {
    var result = await db.query(
      'SELECT * FROM users WHERE username = $1 OR email = $1',
      [username]
    );

    if (result.rows.length === 0) {
      return res.status(401).json({ error: 'Account not found.' });
    }

    var user = result.rows[0];
    var passwordMatch = await bcrypt.compare(password, user.password_hash);

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
