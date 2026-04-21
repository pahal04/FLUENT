# FLUENT - Language Learning Platform
**IS 436 - Structured Systems Analysis and Design**
**Team:** Pahal Dave, Noor Qureshi, Coco Ni, Christian Gloria, Rithik Kavanakudy

---

## What is FLUENT?
FLUENT (Functional Language User Evaluation & Navigation Tool) is a web-based language learning platform built around real-world scenario-based practice. Users can browse scenarios in 9 languages, track lesson completions, and self-report confidence ratings.

**Languages supported:** Gujarati, Nepali, English, Chinese, Italian, Tagalog, Urdu, Spanish, Hindi

---

## Project Structure
```
fluent/
├── docker-compose.yml          ← spins up postgres + backend together
├── docker/
│   └── init.sql                ← creates all tables + seeds data
├── backend/
│   ├── Dockerfile
│   ├── package.json
│   ├── server.js               ← main express app
│   ├── db/
│   │   └── index.js            ← postgres connection pool
│   └── routes/
│       ├── auth.js             ← register / login
│       ├── languages.js        ← get all languages
│       ├── scenarios.js        ← get scenarios + vocab
│       ├── progress.js         ← completions + confidence feedback
│       └── admin.js            ← stats + content management
└── frontend/
    ├── index.html              ← homepage
    ├── css/
    │   └── style.css
    ├── js/
    │   └── app.js              ← shared JS (API calls, session, etc.)
    └── pages/
        ├── login.html
        ├── register.html
        ├── languages.html      ← browse scenarios by language
        ├── scenario.html       ← individual scenario + vocab + feedback
        ├── progress.html       ← user progress tracker
        └── admin.html          ← admin dashboard
```

---

## How to Run (Docker)

Make sure Docker Desktop is open first!

### Option 1: Run everything with Docker Compose (recommended)
```bash
# from the fluent/ root folder
docker-compose up --build
```
Then open your browser to: **http://localhost:3000**

### Option 2: Run just the database in Docker, backend locally
```bash
# start just postgres
docker-compose up db

# in another terminal, go into the backend folder
cd backend
npm install
node server.js
```
Then open the frontend files directly in your browser (or use VS Code Live Server).

---

## If you already have the database running (from class)
If your `my_project_db` container already exists with the schema from the screenshots, you can just run the backend locally:

```bash
# make sure your docker container is running
docker start my_project_db

# go into backend
cd backend
npm install

# set env variables (or just edit db/index.js directly)
DB_HOST=localhost DB_USER=student DB_PASSWORD=password DB_NAME=projectdb node server.js
```

---

## API Endpoints

| Method | Endpoint | What it does |
|--------|----------|--------------|
| POST | `/api/auth/register` | Create new user account |
| POST | `/api/auth/login` | Log in |
| GET | `/api/languages` | Get all languages |
| GET | `/api/scenarios` | Get all scenarios (optional: `?language_id=1`) |
| GET | `/api/scenarios/:id` | Get one scenario + its vocabulary |
| POST | `/api/progress/complete` | Mark a scenario as complete |
| POST | `/api/progress/feedback` | Submit confidence rating (1-5) |
| GET | `/api/progress/:user_id` | Get user's completed scenarios |
| GET | `/api/admin/stats` | Usage stats for admin dashboard |
| POST | `/api/admin/scenarios` | Add a new scenario |
| POST | `/api/admin/vocabulary` | Add vocabulary to a scenario |

---

## Notes
- No JWT tokens implemented (out of scope for prototype) — session is stored in browser sessionStorage
- All data is simulated / seeded, no real user data collected
- Audio/speech recognition is out of scope per the project proposal
- Password hashing uses bcrypt (10 salt rounds)
