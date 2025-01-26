CREATE TABLE users (
    user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    username VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    join_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE photos (
    photo_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(user_id) ON DELETE CASCADE,
    location_id UUID REFERENCES locations(location_id) ON DELETE CASCADE,
    photo_url VARCHAR(255) NOT NULL,
    upload_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
);

CREATE TABLE locations (
    location_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    city VARCHAR(255) NOT NULL,
    country VARCHAR(255) NOT NULL,
    UNIQUE (city, country)
);

CREATE TABLE hashtags (
    hashtag_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    hashtag VARCHAR(255) NOT NULL,
);

--  many to many relationship between photos and hashtags (Junction | association table)
CREATE TABLE photo_hashtags ( 
    photo_id UUID REFERENCES photos(photo_id) ON DELETE CASCADE,
    hashtag_id UUID REFERENCES hashtags(hashtag_id) ON DELETE CASCADE,
    PRIMARY KEY (photo_id, hashtag_id)
);


--  foreign key constraints
