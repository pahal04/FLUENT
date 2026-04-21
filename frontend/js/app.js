// app.js - FLUENT frontend helpers
// IS 436 Group Project

const API = 'http://localhost:3000/api';

function getUser() {
  var data = sessionStorage.getItem('fluent_user');
  if (data) return JSON.parse(data);
  return null;
}

function setUser(user) {
  sessionStorage.setItem('fluent_user', JSON.stringify(user));
}

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

// TODO: loadLanguages - fetch from /api/languages and render cards

// TODO: loadScenarios - fetch from /api/scenarios and render

// TODO: progress tracking functions (markComplete, loadProgress, etc.)

function logout() {
  sessionStorage.removeItem('fluent_user');
  window.location.href = '/';
}

document.addEventListener('DOMContentLoaded', updateNav);
