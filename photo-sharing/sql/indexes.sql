-- index for users table
CREATE INDEX idx_users_username ON users (username);

--  index for photos table
CREATE INDEX idx_photos_upload_date ON photos (upload_date);


--  index for locations table
CREATE INDEX idx_locations_city ON locations (city);
CREATE INDEX idx_locations_country ON locations (country);

--  index for hashtags table
CREATE INDEX idx_hashtags_hashtag ON hashtags (hashtag);

--  index for photo_hashtags table
CREATE INDEX idx_photo_hashtags_photo_id ON photo_hashtags(photo_id);

-- index for photo_hashtags table
CREATE INDEX idx_photo_hashtags_hashtag_id ON photo_hashtags(hashtag_id);


