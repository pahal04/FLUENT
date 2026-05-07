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

-- Gujarati: Ordering Food at a Restaurant (scenario_id = 2)
INSERT INTO vocabulary (scenario_id, phrase, translation, pronunciation, example_usage) VALUES
(2, 'Mane menu aapso?', 'Can I have the menu?', 'Mah-neh meh-noo aap-so', 'Ask the waiter for the menu when you sit down.'),
(2, 'Mane aa joiyeh', 'I would like this one', 'Mah-neh aa joy-eh', 'Point to an item on the menu and say this to order.'),
(2, 'Bill lavso?', 'Can you bring the bill?', 'Bill lav-sho', 'Say this when you are ready to pay.');

-- Gujarati: Meeting the Family (scenario_id = 3)
INSERT INTO vocabulary (scenario_id, phrase, translation, pronunciation, example_usage) VALUES
(3, 'Aa mara... che', 'This is my...', 'Aa mah-rah cheh', 'Use this to introduce a family member to someone.'),
(3, 'Tame kya thi cho?', 'Where are you from?', 'Tah-meh kyah thee choh', 'Ask this to learn more about someone you are meeting.'),
(3, 'Tamne mali ne khushi thayi', 'Nice to meet you', 'Tah-mah-neh mah-lee-neh khoo-shee thah-ee', 'Say this when meeting someone for the first time.');

-- Nepali: Asking for Directions (scenario_id = 5)
INSERT INTO vocabulary (scenario_id, phrase, translation, pronunciation, example_usage) VALUES
(5, '... kata cha?', 'Where is...?', 'kah-tah cha', 'Ask this followed by a place name to find a location.'),
(5, 'Sidha jaanus', 'Go straight', 'Seed-hah jaa-nus', 'A direction you might hear when asking how to get somewhere.'),
(5, 'Kati tadha cha?', 'How far is it?', 'Kah-tee tah-dah cha', 'Ask this to get an idea of the distance to your destination.');

-- Nepali: At the Market (scenario_id = 6)
INSERT INTO vocabulary (scenario_id, phrase, translation, pronunciation, example_usage) VALUES
(6, 'Yo kati parcha?', 'How much does this cost?', 'Yoh kah-tee par-cha', 'Ask the vendor for the price of any item.'),
(6, 'Arko dekhaunos', 'Show me another one', 'Ar-ko deh-kow-nos', 'Use this when you want to see different options at a stall.'),
(6, 'Thikai cha', 'That is fine / Okay', 'Tee-kai cha', 'Say this to agree on a price or confirm your purchase.');

-- English: At the Doctor''s Office (scenario_id = 8)
INSERT INTO vocabulary (scenario_id, phrase, translation, pronunciation, example_usage) VALUES
(8, 'I have an appointment', 'I have an appointment', NULL, 'Say this at the front desk when you arrive at the clinic.'),
(8, 'I have been feeling...', 'I have been feeling...', NULL, 'Start with this phrase to describe your symptoms to the doctor.'),
(8, 'Can you repeat that, please?', 'Can you repeat that, please?', NULL, 'Ask the doctor or nurse to clarify if you did not understand something.');

-- English: Using Public Transportation (scenario_id = 9)
INSERT INTO vocabulary (scenario_id, phrase, translation, pronunciation, example_usage) VALUES
(9, 'Does this bus go to...?', 'Does this bus go to...?', NULL, 'Ask the driver or another passenger before you board.'),
(9, 'Where do I get off for...?', 'Where do I get off for...?', NULL, 'Ask this so you know which stop to exit at.'),
(9, 'How much is the fare?', 'How much is the fare?', NULL, 'Ask before boarding so you have the right amount ready.');

-- Chinese: Asking for Directions (scenario_id = 11)
INSERT INTO vocabulary (scenario_id, phrase, translation, pronunciation, example_usage) VALUES
(11, '...在哪里?', 'Where is...?', 'zai na li', 'Say the place name first, then this phrase to ask where it is.'),
(11, '怎么走?', 'How do I get there?', 'Zen me zou', 'Ask this as a follow-up after learning where a place is.'),
(11, '左转 / 右转', 'Turn left / Turn right', 'Zuo zhuan / You zhuan', 'Common directions you will hear when someone guides you.');

-- Chinese: Shopping at a Market (scenario_id = 12)
INSERT INTO vocabulary (scenario_id, phrase, translation, pronunciation, example_usage) VALUES
(12, '多少钱?', 'How much is it?', 'Duo shao qian', 'Always ask this before buying anything at a market stall.'),
(12, '太贵了', 'Too expensive', 'Tai gui le', 'Use this to signal you want to bargain for a lower price.'),
(12, '便宜一点', 'A little cheaper, please', 'Pian yi yi dian', 'Ask for a small discount when the price feels too high.');

-- Italian: Ordering at a Cafe (scenario_id = 14)
INSERT INTO vocabulary (scenario_id, phrase, translation, pronunciation, example_usage) VALUES
(14, 'Un caffè, per favore', 'A coffee, please', 'Oon kaf-feh, pehr fah-voh-reh', 'Order a standard Italian espresso with this phrase.'),
(14, 'Vorrei un cornetto', 'I would like a croissant', 'Vor-ray oon kor-neh-toh', 'Order a pastry to pair with your morning coffee.'),
(14, 'Il conto, per favore', 'The bill, please', 'Eel kon-toh, pehr fah-voh-reh', 'Ask for the check when you are ready to leave the cafe.');

-- Italian: Checking into a Hotel (scenario_id = 15)
INSERT INTO vocabulary (scenario_id, phrase, translation, pronunciation, example_usage) VALUES
(15, 'Ho una prenotazione', 'I have a reservation', 'Oh oo-nah preh-noh-tah-tsyoh-neh', 'Say this at the front desk when you arrive at the hotel.'),
(15, 'La chiave, per favore', 'The key, please', 'Lah kyah-veh, pehr fah-voh-reh', 'Ask the receptionist for your room key at check-in.'),
(15, 'A che ora è il checkout?', 'What time is checkout?', 'Ah keh oh-rah eh eel chek-owt', 'Ask this when checking in so you can plan your departure.');

-- Tagalog: Family Conversations (scenario_id = 17)
INSERT INTO vocabulary (scenario_id, phrase, translation, pronunciation, example_usage) VALUES
(17, 'Ito ang aking...', 'This is my...', 'Ee-toh ang ah-king', 'Use this to introduce a family member to someone new.'),
(17, 'Mula saan kayo?', 'Where are you from?', 'Moo-lah sah-an kah-yo', 'Ask this to learn about a family member''s background.'),
(17, 'Masaya akong makilala kayo', 'Nice to meet you', 'Mah-sah-yah ah-kong mah-kee-lah-lah kah-yo', 'Say this when meeting a family member for the first time.');

-- Tagalog: Speaking at the Doctor (scenario_id = 18)
INSERT INTO vocabulary (scenario_id, phrase, translation, pronunciation, example_usage) VALUES
(18, 'Masakit ang aking...', 'My... hurts', 'Mah-sah-kit ang ah-king', 'Point to the area and say this to describe pain to a doctor.'),
(18, 'Kailangan ko ng tulong', 'I need help', 'Kai-la-ngan ko nang too-long', 'Say this urgently if you need immediate medical assistance.'),
(18, 'Mayroon ba kayong gamot?', 'Do you have medicine?', 'May-ro-on ba kah-yong gah-mot', 'Ask a doctor or pharmacist for medication.');

-- Urdu: At the Restaurant (scenario_id = 20)
INSERT INTO vocabulary (scenario_id, phrase, translation, pronunciation, example_usage) VALUES
(20, 'Menu dikhayein', 'Please show me the menu', 'Meh-noo dee-khah-yen', 'Ask the waiter for the menu when you sit down.'),
(20, 'Mujhe yeh chahiye', 'I would like this', 'Moo-jheh yeh chah-hee-yeh', 'Point to a menu item and say this to place your order.'),
(20, 'Bill layen', 'Please bring the bill', 'Bill lah-yen', 'Say this to the waiter when you are ready to pay.');

-- Urdu: Asking for Help (scenario_id = 21)
INSERT INTO vocabulary (scenario_id, phrase, translation, pronunciation, example_usage) VALUES
(21, 'Mujhe madad chahiye', 'I need help', 'Moo-jheh mah-dahd chah-hee-yeh', 'Use this in any situation where you need assistance.'),
(21, 'Kya aap meri madad kar sakte hain?', 'Can you help me?', 'Kyah aap meh-ree mah-dahd kar sak-teh hain', 'A polite way to ask a stranger for help.'),
(21, 'Main rasta bhool gaya', 'I am lost', 'Main ras-tah bhool gah-yah', 'Say this when you need someone to help you find your way.');

-- Spanish: Checking into a Hotel (scenario_id = 23)
INSERT INTO vocabulary (scenario_id, phrase, translation, pronunciation, example_usage) VALUES
(23, 'Tengo una reservación', 'I have a reservation', 'Ten-go oo-nah reh-sehr-vah-syohn', 'Say this at the front desk when you arrive at the hotel.'),
(23, '¿A qué hora es el checkout?', 'What time is checkout?', 'Ah keh oh-rah es el chek-owt', 'Ask this at check-in so you can plan your departure.'),
(23, '¿Dónde está el ascensor?', 'Where is the elevator?', 'Don-deh es-tah el ah-sen-sor', 'Ask the front desk how to get to your floor.');

-- Spanish: At the Grocery Store (scenario_id = 24)
INSERT INTO vocabulary (scenario_id, phrase, translation, pronunciation, example_usage) VALUES
(24, '¿Dónde están los...?', 'Where are the...?', 'Don-deh es-tahn los', 'Ask a store employee to help you find a product aisle.'),
(24, '¿Cuánto cuesta esto?', 'How much does this cost?', 'Kwan-toh kwes-tah es-toh', 'Ask for the price of an item before putting it in your cart.'),
(24, '¿Tienen una bolsa?', 'Do you have a bag?', 'Tye-nen oo-nah bol-sah', 'Ask the cashier for a shopping bag at checkout.');

-- Hindi: Taking a Rickshaw or Taxi (scenario_id = 26)
INSERT INTO vocabulary (scenario_id, phrase, translation, pronunciation, example_usage) VALUES
(26, '... chalna hai', 'I need to go to...', 'chal-nah hai', 'Say your destination first, then this phrase to tell the driver where to go.'),
(26, 'Kitna hoga?', 'How much will it cost?', 'Kit-nah ho-gah', 'Ask the driver for the fare before getting in.'),
(26, 'Yahaan rok do', 'Stop here', 'Yah-haan rok do', 'Tell the driver to stop when you have reached your destination.');

-- Hindi: Shopping at a Bazaar (scenario_id = 27)
INSERT INTO vocabulary (scenario_id, phrase, translation, pronunciation, example_usage) VALUES
(27, 'Kitne ka hai?', 'How much is this?', 'Kit-neh kah hai', 'Ask any vendor for the price of an item at the market.'),
(27, 'Thoda kam karo', 'Lower the price a little', 'Tho-dah kam kah-ro', 'Use this to bargain with a vendor who quotes a high price.'),
(27, 'Yeh le lunga', 'I will take this one', 'Yeh leh loon-gah', 'Say this when you have decided to buy something.');