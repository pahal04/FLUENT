-- FLUENT Database Schema
-- IS 436 - Structured Systems Analysis and Design
-- Team: FLUENT Project Team

-- Languages table
CREATE TABLE IF NOT EXISTS languages (
    language_id SERIAL PRIMARY KEY,
    lang_name VARCHAR(50) NOT NULL,
    lang_code VARCHAR(10) NOT NULL,
    is_available BOOLEAN DEFAULT TRUE,
    added_by_admin INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Users table
CREATE TABLE IF NOT EXISTS users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(100),
    birthday DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Admins table
CREATE TABLE IF NOT EXISTS admins (
    admin_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Scenarios table
CREATE TABLE IF NOT EXISTS scenarios (
    scenario_id SERIAL PRIMARY KEY,
    language_id INT REFERENCES languages(language_id),
    title VARCHAR(100) NOT NULL,
    description TEXT,
    difficulty VARCHAR(20) CHECK (difficulty IN ('Beginner', 'Intermediate', 'Advanced')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_by INT
);

-- Vocabulary table
CREATE TABLE IF NOT EXISTS vocabulary (
    vocab_id SERIAL PRIMARY KEY,
    scenario_id INT REFERENCES scenarios(scenario_id),
    phrase VARCHAR(200) NOT NULL,
    translation VARCHAR(200) NOT NULL,
    pronunciation VARCHAR(200),
    example_usage TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Lesson Completions table
CREATE TABLE IF NOT EXISTS lesson_completions (
    completion_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    scenario_id INT REFERENCES scenarios(scenario_id),
    completed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Confidence Feedback table
CREATE TABLE IF NOT EXISTS confidence_feedback (
    feedback_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    scenario_id INT REFERENCES scenarios(scenario_id),
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comments TEXT,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Languages
INSERT INTO languages (lang_name, lang_code, is_available, added_by_admin) VALUES
('Gujarati', 'gu', TRUE, 1),
('Nepali', 'ne', TRUE, 1),
('English', 'en', TRUE, 1),
('Chinese', 'zh', TRUE, 1),
('Italian', 'it', TRUE, 1),
('Tagalog', 'tl', TRUE, 1),
('Urdu', 'ur', TRUE, 2),
('Spanish', 'es', TRUE, 2),
('Hindi', 'hi', TRUE, 2);

-- Admin account (password: admin123)
INSERT INTO admins (username, email, password_hash) VALUES
    ('admin', 'admin@fluent.com', '$2b$10$examplehashedpassword');

-- scenarios
-- Gujarati (language_id = 1)
INSERT INTO scenarios (language_id, title, description, difficulty, updated_by) VALUES
(1, 'Greetings and Introductions', 'Learn how to greet someone and introduce yourself in Gujarati.', 'Beginner', 1),
(1, 'Ordering Food at a Restaurant', 'Practice ordering a meal at a restaurant using common Gujarati phrases.', 'Beginner', 1),
(1, 'Meeting the Family', 'Learn phrases for meeting and speaking with family members.', 'Intermediate', 1);

-- Nepali (language_id = 2)
INSERT INTO scenarios (language_id, title, description, difficulty, updated_by) VALUES
(2, 'Greetings and Introductions', 'Learn how to greet someone and introduce yourself in Nepali.', 'Beginner', 1),
(2, 'Asking for Directions', 'Practice asking and understanding directions in Nepali.', 'Beginner', 1),
(2, 'At the Market', 'Learn vocabulary for shopping and haggling at a local market in Nepali.', 'Intermediate', 1);

-- English (language_id = 3)
INSERT INTO scenarios (language_id, title, description, difficulty, updated_by) VALUES
(3, 'Greetings and Small Talk', 'Learn common English greetings and small talk phrases for ESL learners.', 'Beginner', 1),
(3, 'At the Doctor''s Office', 'Practice speaking with medical staff in everyday English.', 'Intermediate', 1),
(3, 'Using Public Transportation', 'Learn how to ask about buses, trains, and directions in English.', 'Beginner', 1);

-- Chinese (language_id = 4)
INSERT INTO scenarios (language_id, title, description, difficulty, updated_by) VALUES
(4, 'Greetings and Introductions', 'Learn basic greetings and tones in Chinese.', 'Beginner', 1),
(4, 'Asking for Directions', 'Practice asking and understanding directions in Chinese.', 'Beginner', 1),
(4, 'Shopping at a Market', 'Learn vocabulary for shopping and bargaining in Chinese.', 'Intermediate', 1);

-- Italian (language_id = 5)
INSERT INTO scenarios (language_id, title, description, difficulty, updated_by) VALUES
(5, 'Greetings and Introductions', 'Learn how to greet people and introduce yourself in Italian.', 'Beginner', 2),
(5, 'Ordering at a Cafe', 'Practice ordering coffee, pastries, and meals at an Italian cafe.', 'Beginner', 2),
(5, 'Checking into a Hotel', 'Learn phrases for checking in, asking about amenities, and more.', 'Intermediate', 2);

-- Tagalog (language_id = 6)
INSERT INTO scenarios (language_id, title, description, difficulty, updated_by) VALUES
(6, 'Greetings and Introductions', 'Learn common Tagalog greetings and polite expressions.', 'Beginner', 1),
(6, 'Family Conversations', 'Practice talking about family members and relationships in Tagalog.', 'Beginner', 1),
(6, 'Speaking at the Doctor', 'Learn vocabulary for describing symptoms and speaking with a doctor.', 'Intermediate', 1);

-- Urdu (language_id = 7)
INSERT INTO scenarios (language_id, title, description, difficulty, updated_by) VALUES
(7, 'Greetings and Introductions', 'Learn how to greet someone and introduce yourself in Urdu.', 'Beginner', 2),
(7, 'At the Restaurant', 'Practice ordering food and asking about the menu in Urdu.', 'Beginner', 2),
(7, 'Asking for Help', 'Learn phrases for asking for assistance in everyday Urdu situations.', 'Intermediate', 2);

-- Spanish (language_id = 8)
INSERT INTO scenarios (language_id, title, description, difficulty, updated_by) VALUES
(8, 'Greetings and Introductions', 'Learn everyday Spanish greetings used in different regions.', 'Beginner', 2),
(8, 'Checking into a Hotel', 'Practice phrases for checking in, asking about amenities, and more.', 'Beginner', 2),
(8, 'At the Grocery Store', 'Learn vocabulary for navigating a grocery store and asking for items.', 'Beginner', 2);

-- Hindi (language_id = 9)
INSERT INTO scenarios (language_id, title, description, difficulty, updated_by) VALUES
(9, 'Greetings and Introductions', 'Learn how to greet someone and introduce yourself in Hindi.', 'Beginner', 2),
(9, 'Taking a Rickshaw or Taxi', 'Practice giving directions and negotiating fare in Hindi.', 'Beginner', 2),
(9, 'Shopping at a Bazaar', 'Learn vocabulary for bargaining and shopping at a local bazaar.', 'Intermediate', 2);

-- vocab
-- Gujarati: Greetings (scenario_id = 1)
INSERT INTO vocabulary (scenario_id, phrase, translation, pronunciation, example_usage) VALUES
(1, 'Kem cho?', 'How are you?', 'Kehm choh', 'Say this when greeting someone you know.'),
(1, 'Maru naam... che', 'My name is...', 'Mah-roo naam cheh', 'Use this to introduce yourself.'),
(1, 'Saru che', 'I am fine / It is good', 'Sah-roo cheh', 'Respond with this when asked how you are.');

-- Nepali: Greetings (scenario_id = 4)
INSERT INTO vocabulary (scenario_id, phrase, translation, pronunciation, example_usage) VALUES
(4, 'Namaste', 'Hello / Greetings', 'Nah-mas-tay', 'A respectful greeting used any time of day.'),
(4, 'Mero naam... ho', 'My name is...', 'Meh-ro naam ho', 'Use this to tell someone your name.'),
(4, 'Tapailai kasto cha?', 'How are you?', 'Tah-pai-lai kas-to cha', 'Ask this when greeting a friend or acquaintance.');

-- English: Greetings (scenario_id = 7)
INSERT INTO vocabulary (scenario_id, phrase, translation, pronunciation, example_usage) VALUES
(7, 'How are you?', 'How are you?', NULL, 'A common greeting used with friends and strangers.'),
(7, 'Nice to meet you', 'Nice to meet you', NULL, 'Say this when being introduced to someone new.'),
(7, 'My name is...', 'My name is...', NULL, 'Use this to introduce yourself in any situation.');

-- Chinese: Greetings (scenario_id = 10)
INSERT INTO vocabulary (scenario_id, phrase, translation, pronunciation, example_usage) VALUES
(10, '你好', 'Hello', 'Ni hao', 'A standard greeting used at any time of day.'),
(10, '谢谢', 'Thank you', 'Xie xie', 'Say this after someone helps you or gives you something.'),
(10, '我叫...', 'My name is...', 'Wo jiao', 'Use this followed by your name to introduce yourself.');

-- Italian: Greetings (scenario_id = 13)
INSERT INTO vocabulary (scenario_id, phrase, translation, pronunciation, example_usage) VALUES
(13, 'Ciao', 'Hello / Goodbye', 'Chow', 'Informal greeting used with friends and family.'),
(13, 'Come stai?', 'How are you?', 'Koh-meh stai', 'Ask this when greeting someone you know.'),
(13, 'Mi chiamo...', 'My name is...', 'Mee kyah-moh', 'Use this to introduce yourself in Italian.');

-- Tagalog: Greetings (scenario_id = 16)
INSERT INTO vocabulary (scenario_id, phrase, translation, pronunciation, example_usage) VALUES
(16, 'Kamusta?', 'How are you?', 'Kah-moos-tah', 'Common informal greeting among friends and family.'),
(16, 'Salamat', 'Thank you', 'Sah-lah-mat', 'Used to express gratitude in any situation.'),
(16, 'Magandang umaga', 'Good morning', 'Mah-gan-dang oo-mah-ga', 'Greet someone in the morning with this phrase.');

-- Urdu: Greetings (scenario_id = 19)
INSERT INTO vocabulary (scenario_id, phrase, translation, pronunciation, example_usage) VALUES
(19, 'Assalamu Alaikum', 'Peace be upon you (Hello)', 'As-sah-lah-moo ah-lay-kum', 'A respectful Islamic greeting used commonly in Urdu.'),
(19, 'Mera naam... hai', 'My name is...', 'Meh-rah naam hai', 'Use this to introduce yourself.'),
(19, 'Aap kaise hain?', 'How are you? (formal)', 'Aap kai-seh hain', 'A formal way to ask how someone is doing.');

-- Spanish: Greetings (scenario_id = 22)
INSERT INTO vocabulary (scenario_id, phrase, translation, pronunciation, example_usage) VALUES
(22, 'Hola', 'Hello', 'Oh-lah', 'A simple universal greeting in Spanish.'),
(22, 'Como estas?', 'How are you?', 'Koh-moh es-tahs', 'Ask this informally when greeting a friend.'),
(22, 'Me llamo...', 'My name is...', 'Meh yah-moh', 'Use this to introduce yourself in Spanish.');

-- Hindi: Greetings (scenario_id = 25)
INSERT INTO vocabulary (scenario_id, phrase, translation, pronunciation, example_usage) VALUES
(25, 'Namaste', 'Hello / Greetings', 'Nah-mas-tay', 'A respectful greeting used across India.'),
(25, 'Mera naam... hai', 'My name is...', 'Meh-rah naam hai', 'Use this to introduce yourself in Hindi.'),
(25, 'Aap kaise hain?', 'How are you? (formal)', 'Aap kai-seh hain', 'A polite way to ask how someone is doing.');