# FLUENT - Language Learning Platform

**IS 436 - Structured Systems Analysis and Design**  
**Final Project - User Interface Design, Program Design, and System Implementation**  
**Team:** Pahal Dave, Noor Qureshi, Coco Ni, Christian Gloria, Rithik Kavanakudy  

---

## Table of Contents

- [What is FLUENT?](#what-is-fluent)
- [Live Website](#live-website)
- [Project Purpose](#project-purpose)
- [Team Information](#team-information)
- [Technology Stack](#technology-stack)
- [Project Structure](#project-structure)
- [User Interface Screens](#user-interface-screens)
- [Database Design](#database-design)
- [How to Run Docker](#how-to-run-docker)
- [If You Already Have the Database Running From Class](#if-you-already-have-the-database-running-from-class)
- [API Endpoints](#api-endpoints)
- [DockerHub Image](#dockerhub-image)
- [GitHub Actions Workflow](#github-actions-workflow)
- [User Guide](#user-guide)
- [Updated Project Plan](#updated-project-plan)
- [Notes](#notes)

---

## What is FLUENT?

FLUENT, which stands for **Functional Language User Evaluation & Navigation Tool**, is a web-based language learning platform built around real-world, scenario-based practice. Users can browse scenarios in 9 languages, track lesson completions, and self-report confidence ratings after completing practice activities.

FLUENT is designed for beginner conversational language learning. Instead of only focusing on grammar or memorization, the platform helps users practice realistic situations such as greetings, ordering food, asking for directions, checking into a hotel, shopping, and speaking with a doctor.

**Languages supported:** Gujarati, Nepali, English, Chinese, Italian, Tagalog, Urdu, Spanish, Hindi

---

## Live Website

The FLUENT prototype is deployed on Render and can be accessed here:

**Live Application:** https://fluent-nt2i.onrender.com/

---

## Project Purpose

The purpose of FLUENT is to provide an affordable and easy-to-use platform for users who want to practice basic conversational language skills. The project also supports administrators by giving them a way to manage scenario-based learning content and monitor user engagement.

FLUENT was created as a student-built final project for IS 436. The platform focuses on practical, beginner-level language learning and supports both learner-facing features and administrator-facing content management.

---

## Team Information

**Team Name:** FLUENT Project Team  
**Project Contact:** Pahal Dave  
**Project Contact Email:** pahalr1@umbc.edu  
**Meeting Time:** Saturdays at 8:00 PM via Google Meet  

| Name | Role | Contact |
|---|---|---|
| Pahal Dave | Project Manager | pahalr1@umbc.edu |
| Noor Qureshi | Business Analyst | nquresh1@umbc.edu |
| Coco Ni | IT Support / Media | cocon1@umbc.edu |
| Christian Gloria | Systems Analyst | cgloria1@umbc.edu |
| Rithik Kavanakudy | Quality Assurance | r161@umbc.edu |

---

## Technology Stack

The following technologies are used in the FLUENT project:

| Area | Technology |
|---|---|
| Frontend | HTML, CSS, JavaScript |
| Backend | Node.js, Express.js |
| Database | PostgreSQL |
| Containerization | Docker |
| Version Control | GitHub |
| Deployment / Hosting | Render, DockerHub |
| Project Management | GitHub Projects / Kanban Board |
| Workflow Automation | GitHub Actions |

---

## Project Structure

The project is organized into backend, frontend, database, and Docker-related files. The structure below shows the main folders and files used to run the FLUENT application.

```text
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
    │   └── app.js              ← shared JS for API calls and sessions
    └── pages/
        ├── login.html
        ├── register.html
        ├── languages.html      ← browse scenarios by language
        ├── scenario.html       ← individual scenario + vocab + feedback
        ├── progress.html       ← user progress tracker
        └── admin.html          ← admin dashboard
```

---

## User Interface Screens

The FLUENT system includes several user interface screens that support both learner and administrator workflows. These pages were designed to be simple, consistent, and easy to navigate.

| Screen / Page | File | Purpose |
|---|---|---|
| Landing Page | `index.html` | Introduces users to FLUENT and provides navigation to login, sign up, languages, and progress |
| Register Page | `register.html` | Allows new users to create an account |
| Login Page | `login.html` | Allows users and administrators to log in |
| Languages Page | `languages.html` | Displays available languages and allows users to browse language options |
| Scenario Page | `scenario.html` | Shows scenario-based vocabulary, translations, pronunciation, and feedback options |
| Progress Page | `progress.html` | Displays completed lessons and confidence feedback history |
| Admin Dashboard | `admin.html` | Allows administrators to view system statistics and manage content |

### Interface Standards

The interface follows these standards:

- Simple navigation across all pages
- Clear labels for buttons, forms, and links
- Consistent page layout and styling
- Beginner-friendly wording
- Browser-based access
- Separation between learner pages and admin pages
- Forms that connect to database fields where user input is stored

### UI Design Rationale

The interface was designed to be straightforward because FLUENT is intended for beginner learners and community-based users. The system avoids overly complex menus and focuses on the main learning flow: selecting a language, opening a scenario, reviewing vocabulary, completing the lesson, and submitting confidence feedback.

The main design trade-off is that the current version keeps the experience simple instead of adding advanced features such as audio, speech recognition, or AI-based pronunciation feedback. This helps keep the project realistic while still supporting the main purpose of scenario-based conversational language learning.

---

## Database Design

The FLUENT database uses PostgreSQL and includes seven main tables.

| Table | Purpose |
|---|---|
| `users` | Stores learner account information |
| `admins` | Stores administrator account information |
| `languages` | Stores supported language options |
| `scenarios` | Stores real-world learning scenarios connected to languages |
| `vocabulary` | Stores phrases, translations, pronunciation, and example usage |
| `lesson_completions` | Tracks completed scenarios by users |
| `confidence_feedback` | Stores user confidence ratings and optional comments |

The database is normalized to Third Normal Form (3NF) to reduce redundancy, improve consistency, and prevent update, insertion, and deletion anomalies.

The SQL script is located in:

```text
docker/init.sql
```

---

## How to Run Docker

Make sure Docker Desktop is open first.

### Option 1: Run everything with Docker Compose

From the `fluent/` root folder, run:

```bash
docker-compose up --build
```

Then open your browser to:

```text
http://localhost:3000
```

---

### Option 2: Run just the database in Docker and backend locally

Start the PostgreSQL database:

```bash
docker-compose up db
```

In another terminal, go into the backend folder:

```bash
cd backend
npm install
node server.js
```

Then open the frontend files directly in your browser or use VS Code Live Server.

---

## If You Already Have the Database Running From Class

If your `my_project_db` container already exists with the schema from class, you can run the backend locally.

```bash
# make sure your docker container is running
docker start my_project_db

# go into backend
cd backend
npm install

# set env variables or edit db/index.js directly
DB_HOST=localhost DB_USER=student DB_PASSWORD=password DB_NAME=projectdb node server.js
```

---

## API Endpoints

| Method | Endpoint | What it does |
|---|---|---|
| POST | `/api/auth/register` | Create new user account |
| POST | `/api/auth/login` | Log in |
| GET | `/api/languages` | Get all languages |
| GET | `/api/scenarios` | Get all scenarios, optional: `?language_id=1` |
| GET | `/api/scenarios/:id` | Get one scenario and its vocabulary |
| POST | `/api/progress/complete` | Mark a scenario as complete |
| POST | `/api/progress/feedback` | Submit confidence rating from 1 to 5 |
| GET | `/api/progress/:user_id` | Get user's completed scenarios |
| GET | `/api/admin/stats` | Get usage stats for admin dashboard |
| POST | `/api/admin/scenarios` | Add a new scenario |
| POST | `/api/admin/vocabulary` | Add vocabulary to a scenario |

---

## DockerHub Image

The FLUENT application is containerized and will be published to DockerHub for the final project demo.

**DockerHub Image URL:**

```text
https://hub.docker.com/repository/docker/pahaldave/fluent-app/tags
```

Example format:

```text
https://hub.docker.com/r/username/fluent/tags
```

**Docker Pull Command:**

```bash
docker pull username/fluent:tag
```

Replace `username/fluent:tag` with the final DockerHub image name and tag.

---

## GitHub Actions Workflow

The project uses GitHub Actions to support the Docker build and deployment workflow.

The workflow is intended to:

1. Detect changes pushed to the GitHub repository
2. Build the Docker image
3. Log in to DockerHub
4. Push the image to DockerHub
5. Allow the application to be pulled and run as a container image for the demo

This supports the system implementation requirement because the application can be built and run through a container image.

---

## User Guide

This section explains how learners and administrators can use the FLUENT system.

### Learner Instructions

1. Open the FLUENT website.
2. Register for a new account or log in with an existing account.
3. Go to the languages page.
4. Select a language from the available options.
5. Choose a scenario-based lesson.
6. Review the vocabulary, translations, pronunciation, and example usage.
7. Mark the scenario as completed.
8. Submit a confidence rating from 1 to 5.
9. View completed lessons and feedback history on the progress page.

### Administrator Instructions

1. Log in using administrator credentials.
2. Open the admin dashboard.
3. View basic system usage statistics.
4. Add new scenario content.
5. Add vocabulary entries connected to scenarios.
6. Confirm that the new content appears in the learner-facing pages.

---

## Updated Project Plan

The project followed five major phases of system analysis, design, and implementation.

| Phase | Description | Related Work |
|---|---|---|
| Phase 1: Planning | Identified the business need, sponsor, scope, feasibility, risks, and project value | System Request |
| Phase 2: Analysis | Gathered requirements through interviews, questionnaires, observations, and document analysis | Requirements Definition |
| Phase 3: Process Modeling | Developed process models and system interaction flows | Process Modeling |
| Phase 4: Data Modeling and Architecture | Created the ERD, SQL script, 3NF justification, alternative matrix, architecture design, and GitHub project plan | Data Modeling and Starting Design |
| Phase 5: Implementation and Closing | Built the functional UI, connected program logic to the database, containerized the system, created the DockerHub workflow, and prepared the final project demo | Final Implementation |

---

## Notes

- No JWT tokens were implemented because advanced authentication was outside the current project scope.
- Browser session data is stored using `sessionStorage`.
- Audio, speech recognition, and AI-based language evaluation are outside the scope of this version.
- Password hashing uses bcrypt with 10 salt rounds.
- The current prototype focuses on beginner conversational language learning through practical real-world scenarios.
