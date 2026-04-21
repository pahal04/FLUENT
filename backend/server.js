// server.js - FLUENT backend
// IS 436 - Pahal Dave (Project Manager)

const express = require('express');
const cors = require('cors');
const fs = require('fs');
const path = require('path');

const authRoutes = require('./routes/auth');
const languageRoutes = require('./routes/languages');
const scenarioRoutes = require('./routes/scenarios');
const progressRoutes = require('./routes/progress');
const adminRoutes = require('./routes/admin');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

// resolve frontend path for both local and docker setups
const frontendPathLocal = path.join(__dirname, '../frontend');
const frontendPathDocker = path.join(__dirname, 'frontend');
const frontendPath = fs.existsSync(frontendPathLocal)
  ? frontendPathLocal
  : frontendPathDocker;

// serve the frontend files
app.use(express.static(frontendPath));

// api routes
app.use('/api/auth', authRoutes);
app.use('/api/languages', languageRoutes);
app.use('/api/scenarios', scenarioRoutes);
app.use('/api/progress', progressRoutes);
app.use('/api/admin', adminRoutes);

// catch-all to serve frontend for any non-api route
app.get('*', (req, res) => {
  res.sendFile(path.join(frontendPath, 'index.html'));
});

app.listen(PORT, () => {
  console.log(`FLUENT server running on port ${PORT}`);
});
