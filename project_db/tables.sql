CREATE TABLE Users (
    userid SERIAL PRIMARY KEY,
    username TEXT NOT NULL,
    hashed_password VARCHAR NOT NULL,
    email TEXT,
    phone_no CHAR(8),
    created_at TIMESTAMP,
    is_admin BOOLEAN,
    friend_count NUMERIC default 0,
    UNIQUE(username)
)

CREATE TABLE HasFriends (
    userid SERIAL PRIMARY KEY,
    friend_id SERIAL,
    is_close_friend BOOLEAN default FALSE, 
    FOREIGN KEY (userid) REFERENCES Users(userid),
    FOREIGN KEY (friend_id) REFERENCES Users(userid)
)

CREATE TABLE Posts ( 
    post_id BIGSERIAL PRIMARY KEY,
    posturl TEXT,
    uploader SERIAL NOT NULL,
    word_content TEXT,
    like_count NUMERIC default 0,
    FOREIGN KEY (uploader) REFERENCES Users(userid)
)

CREATE TABLE HasPosts (
    userid SERIAL PRIMARY KEY,
    post_id BIGSERIAL NOT NULL,
    posted_at TIMESTAMP NOT NULL,
    FOREIGN KEY (userid) REFERENCES Users(userid),
    FOREIGN KEY (post_id) REFERENCES Posts(post_id)
)

CREATE TABLE Comments (
    comment_id BIGSERIAL PRIMARY KEY,
    userid SERIAL NOT NULL,
    word_content TEXT,
    image_name TEXT,
    image_data BYTEA,
    like_count NUMERIC default 0,
    FOREIGN KEY (userid) REFERENCES Users(userid)
)

CREATE TABLE HasComments (
    comment_id BIGSERIAL PRIMARY KEY,
    post_id BIGSERIAL,
    userid SERIAL,
    commented_at TIMESTAMP NOT NULL,
    FOREIGN KEY (comment_id) REFERENCES Comments(comment_id),
    FOREIGN KEY (post_id) REFERENCES Posts(post_id),
    FOREIGN KEY (userid) REFERENCES Users(userid)
)

CREATE TABLE LikedBy (
    post_id BIGSERIAL,
    comment_id BIGSERIAL,
    userid SERIAL,
    FOREIGN KEY (post_id) REFERENCES Posts(post_id),
    FOREIGN KEY (comment_id) REFERENCES Comments(comment_id),
    FOREIGN KEY (userid) REFERENCES Users(userid)
)

CREATE TABLE Media (
    media_id BIGSERIAL PRIMARY KEY,
    image_name TEXT,
    image_data BYTEA
)

CREATE TABLE HasMedia (
    post_id BIGSERIAL,
    comment_id BIGSERIAL,
    media_id BIGSERIAL,
    FOREIGN KEY (post_id) REFERENCES Posts(post_id),
    FOREIGN KEY (comment_id) REFERENCES Comments(comment_id),
    FOREIGN KEY (media_id) REFERENCES Media(media_id)
)

