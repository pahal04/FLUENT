// app.js - FLUENT frontend helpers
// IS 436 Group Project

const API = 'http://localhost:3000/api';

// get the logged-in user from session storage (returns null if not logged in)
function getUser() {
  var data = sessionStorage.getItem('fluent_user');
  if (data) return JSON.parse(data);
  return null;
}

// save the user object to session storage after login
function setUser(user) {
  sessionStorage.setItem('fluent_user', JSON.stringify(user));
}

// show a message box inside an element (type is 'error' or 'success')
function showMsg(elementId, text, type) {
  if (!type) type = 'error';
  var el = document.getElementById(elementId);
  if (!el) return;
  el.textContent = text;
  el.className = 'msg msg-' + type;
  el.classList.remove('hidden');
  setTimeout(function() { el.classList.add('hidden'); }, 5000);
}

// show/hide nav links based on whether user is logged in
function updateNav() {
  var user = getUser();
  if (user) {
    if (document.getElementById('nav-login')) document.getElementById('nav-login').classList.add('hidden');
    if (document.getElementById('nav-register')) document.getElementById('nav-register').classList.add('hidden');
    if (document.getElementById('nav-logout')) document.getElementById('nav-logout').classList.remove('hidden');
    if (document.getElementById('nav-user')) {
      document.getElementById('nav-user').textContent = 'Hi, ' + user.username + '!';
      document.getElementById('nav-user').classList.remove('hidden');
    }
  } else {
    if (document.getElementById('nav-login')) document.getElementById('nav-login').classList.remove('hidden');
    if (document.getElementById('nav-register')) document.getElementById('nav-register').classList.remove('hidden');
    if (document.getElementById('nav-logout')) document.getElementById('nav-logout').classList.add('hidden');
    if (document.getElementById('nav-user')) document.getElementById('nav-user').classList.add('hidden');
  }
}

// load language cards from the API and put them in a container
async function loadLanguages(containerId) {
  var container = document.getElementById(containerId);
  container.innerHTML = '<p>Loading languages...</p>';

  try {
    var res = await fetch(API + '/languages');
    var languages = await res.json();

    if (languages.length === 0) {
      container.innerHTML = '<p>No languages available yet.</p>';
      return;
    }

    var html = '';
    for (var i = 0; i < languages.length; i++) {
      var lang = languages[i];
      html += '<div class="lang-card" data-id="' + lang.language_id + '" onclick="selectLanguage(this, ' + lang.language_id + ', \'' + lang.lang_name + '\')">';
      html += '<div class="name">' + lang.lang_name + '</div>';
      html += '</div>';
    }
    container.innerHTML = html;

  } catch (err) {
    container.innerHTML = '<p style="color: red;">Could not load languages. Is the server running?</p>';
  }
}

// called when user clicks a language card
function selectLanguage(card, langId, langName) {
  // remove selected highlight from all cards
  var allCards = document.querySelectorAll('.lang-card');
  for (var i = 0; i < allCards.length; i++) {
    allCards[i].classList.remove('selected');
  }
  // highlight the card that was clicked
  card.classList.add('selected');

  // load scenarios for this language
  loadScenarios('scenario-grid', langId);
}

// fetch scenarios from the API and display them as cards
async function loadScenarios(containerId, langId) {
  var container = document.getElementById(containerId);
  container.innerHTML = '<p>Loading scenarios...</p>';

  var url = API + '/scenarios';
  if (langId) {
    url = url + '?language_id=' + langId;
  }

  try {
    var res = await fetch(url);
    var scenarios = await res.json();

    if (scenarios.length === 0) {
      container.innerHTML = '<p style="color: var(--gray);">No scenarios found for this language yet.</p>';
      return;
    }

    var html = '';
    for (var i = 0; i < scenarios.length; i++) {
      var s = scenarios[i];
      html += '<div class="card">';
      html += '<span class="card-lang-tag">' + s.lang_name + '</span>';
      html += '<h3>' + s.title + '</h3>';
      html += '<p>' + (s.description || '') + '</p>';
      html += '<span class="difficulty-badge ' + s.difficulty.toLowerCase() + '">' + s.difficulty + '</span>';
      html += '<br><br>';
      html += '<a href="scenario.html?id=' + s.scenario_id + '" class="btn btn-primary" style="font-size: 0.85rem;">Start Scenario</a>';
      html += '</div>';
    }
    container.innerHTML = html;

  } catch (err) {
    container.innerHTML = '<p style="color: red;">Could not load scenarios.</p>';
  }
}

// fetch a single scenario with its vocab list
async function loadScenario(id) {
  try {
    var res = await fetch(API + '/scenarios/' + id);
    if (!res.ok) return null;
    var data = await res.json();
    return data;
  } catch (err) {
    console.log('could not load scenario:', err);
    return null;
  }
}

// record that the current user completed a scenario
async function markComplete(scenarioId) {
  var user = getUser();
  if (!user) {
    alert('You need to be logged in to save your progress!');
    return false;
  }

  try {
    var res = await fetch(API + '/progress/complete', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ user_id: user.user_id, scenario_id: scenarioId })
    });

    var data = await res.json();
    if (!res.ok) {
      alert('Could not save progress: ' + (data.error || 'unknown error'));
      return false;
    }
    return true;

  } catch (err) {
    alert('Could not connect to server.');
    return false;
  }
}

// save a star rating and optional comments for a completed scenario
async function submitFeedback(scenarioId, rating, comments) {
  var user = getUser();
  if (!user) return false;

  try {
    var res = await fetch(API + '/progress/feedback', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ user_id: user.user_id, scenario_id: scenarioId, rating: rating, comments: comments })
    });

    if (!res.ok) return false;
    return true;

  } catch (err) {
    console.log('feedback error:', err);
    return false;
  }
}

// build clickable star buttons inside a container element
// sets window.selectedRating when the user picks a star
function initStarRating(containerId) {
  var container = document.getElementById(containerId);
  var html = '';
  for (var i = 1; i <= 5; i++) {
    html += '<button class="star-btn" onclick="selectStar(' + i + ')" id="star-' + i + '">&#9733;</button>';
  }
  container.innerHTML = html;
  window.selectedRating = null;
}

// highlight stars 1 through num when a star is clicked
function selectStar(num) {
  window.selectedRating = num;
  for (var i = 1; i <= 5; i++) {
    var star = document.getElementById('star-' + i);
    if (i <= num) {
      star.classList.add('active');
    } else {
      star.classList.remove('active');
    }
  }
}

function logout() {
  sessionStorage.removeItem('fluent_user');
  window.location.href = '/';
}

document.addEventListener('DOMContentLoaded', updateNav);
