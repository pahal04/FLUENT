// server.js
// IS 436 - Pahal Dave

var express = require('express');
var cors = require('cors');
var path = require('path');

var authRoutes = require('./routes/auth');
var languageRoutes = require('./routes/languages');
var scenarioRoutes = require('./routes/scenarios');
var progressRoutes = require('./routes/progress');
var adminRoutes = require('./routes/admin');

var app = express();
var PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

// frontend folder is one level up from backend
var frontendPath = path.join(__dirname, '../frontend');
app.use(express.static(frontendPath));

app.use('/api/auth', authRoutes);
app.use('/api/languages', languageRoutes);
app.use('/api/scenarios', scenarioRoutes);
app.use('/api/progress', progressRoutes);
app.use('/api/admin', adminRoutes);

// send index.html for anything that isn't an api route
app.get('*', function(req, res) {
  res.sendFile(path.join(frontendPath, 'index.html'));
});

app.listen(PORT, function() {
  console.log('server started on port ' + PORT);
});
