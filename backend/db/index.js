// db/index.js
// this handles our postgres connection using the pg library
const { Pool } = require('pg');

// Render provides DATABASE_URL; fall back to individual vars for local Docker
const poolConfig = process.env.DATABASE_URL
  ? { connectionString: process.env.DATABASE_URL, ssl: { rejectUnauthorized: false } }
  : {
      host: process.env.DB_HOST || 'localhost',
      user: process.env.DB_USER || 'student',
      password: process.env.DB_PASSWORD || 'password',
      database: process.env.DB_NAME || 'projectdb',
      port: 5432,
    };

const pool = new Pool(poolConfig);

// just a quick test to make sure we connected
pool.connect((err, client, release) => {
  if (err) {
    console.error('Error connecting to database:', err.stack);
  } else {
    console.log('Connected to PostgreSQL database!');
    release();
  }
});

module.exports = pool;
