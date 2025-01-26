-- Schema 

CREATE TABLE users (
    user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    username VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    join_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE photos (
    photo_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(user_id) ON DELETE CASCADE,
    location_id UUID REFERENCES locations(location_id) ON DELETE CASCADE,
    photo_url VARCHAR(255) NOT NULL UNIQUE,
    upload_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE locations (
    location_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    city VARCHAR(255) NOT NULL ,
    country VARCHAR(255) NOT NULL,
    UNIQUE (city, country)
);

CREATE TABLE hashtags (
    hashtag_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    hashtag VARCHAR(255) NOT NULL UNIQUE
);

--  many to many relationship between photos and hashtags (Junction | association table)
CREATE TABLE photo_hashtags ( 
    photo_id UUID REFERENCES photos(photo_id) ON DELETE CASCADE,
    hashtag_id UUID REFERENCES hashtags(hashtag_id) ON DELETE CASCADE,
    PRIMARY KEY (photo_id, hashtag_id)
);


-- insert queries 

INSERT INTO users (username, email, password) VALUES ('john_doe', 'john@example.com', 'password123');


INSERT INTO locations (city, country) VALUES ('New York', 'USA');


INSERT INTO photos (user_id, location_id, photo_url)
VALUES (
    (SELECT user_id FROM users WHERE username = 'john_doe'),
    (SELECT location_id FROM locations WHERE city = 'New York' AND country = 'USA'),
    'https://example.com/photo1.jpg'
);


INSERT INTO hashtags (hashtag) VALUES ('sunset');


INSERT INTO photo_hashtags (photo_id, hashtag_id)
VALUES (
    (SELECT photo_id FROM photos WHERE photo_url = 'https://example.com/photo1.jpg'),
    (SELECT hashtag_id FROM hashtags WHERE hashtag = 'sunset')
);


-- search queries

-- search for photos by hashtag and location 
SELECT p.photo_id, p.photo_url, h.hashtag, p.upload_date, l.city, l.country
FROM hashtags h
JOIN photo_hashtags ph ON h.hashtag_id = ph.hashtag_id
JOIN photos p ON ph.photo_id = p.photo_id
JOIN locations l ON p.location_id = l.location_id
JOIN users u ON p.user_id = u.user_id
WHERE h.hashtag = 'sunset' AND l.city = 'New York' AND l.country = 'USA';


-- search for photos by location
SELECT p.photo_id, p.photo_url
FROM photos p
JOIN locations l ON p.location_id = l.location_id
WHERE l.city = 'New York' AND l.country = 'USA';


-- search for photos by user
SELECT p.photo_id, p.photo_url
FROM photos p
JOIN users u ON p.user_id = u.user_id
WHERE u.username = 'john_doe';


-- search for photos by date range
SELECT p.photo_id, p.photo_url
FROM photos p
WHERE p.upload_date BETWEEN '2024-01-01' AND '2025-01-31';


-- search for photos by user and date range
SELECT p.photo_id, p.photo_url
FROM photos p
JOIN users u ON p.user_id = u.user_id
WHERE u.username = 'john_doe' AND p.upload_date BETWEEN '2024-01-01' AND '2025-01-31';


-- search for photos by user and location
SELECT p.photo_id, p.photo_url
FROM photos p
JOIN users u ON p.user_id = u.user_id
JOIN locations l ON p.location_id = l.location_id
WHERE u.username = 'john_doe' AND l.city = 'New York' AND l.country = 'USA';






