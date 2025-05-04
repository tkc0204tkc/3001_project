CREATE TABLE Users (
    userid SERIAL PRIMARY KEY,
    username TEXT NOT NULL,
    hashed_password VARCHAR NOT NULL,
    email TEXT,
    phone_no CHAR(8),
    created_at TIMESTAMP,
    UNIQUE(username, hashed_password)
)

CREATE TABLE HasFriends (
    userid SERIAL PRIMARY KEY FOREIGN KEY (userid) REFERENCES Users(userid),
    friend_id SERIAL FOREIGN KEY (userid) REFERENCES Users(userid)
)

CREATE TABLE Posts ( 
    post_id BIGSERIAL PRIMARY KEY,
    posturl TEXT,
    uploader SERIAL NOT NULL FOREIGN KEY (uploader) REFERENCES Users(userid),
    word_content TEXT
)

CREATE TABLE HasPosts (
    userid SERIAL PRIMARY KEY FOREIGN KEY REFERENCES Users(userid),
    post_id BIGSERIAL NOT NULL FOREIGN KEY REFERENCES Posts(post_id),
    posted_at TIMESTAMP NOT NULL
)

CREATE TABLE Comments (
    comment_id BIGSERIAL PRIMARY KEY,
    userid SERIAL NOT NULL FOREIGN KEY REFERENCES Users(userid),
    word_content TEXT,
    image_name TEXT,
    image_data BYTEA
)

CREATE TABLE HasComments (
    comment_id BIGSERIAL PRIMARY KEY FOREIGN KEY REFERENCES Comments(comment_id),
    post_id BIGSERIAL FOREIGN KEY REFERENCES Posts(post_id),
    userid SERIAL FOREIGN KEY REFERENCES Users(userid),
    commented_at TIMESTAMP NOT NULL
)

CREATE TABLE LikedBy (
    post_id BIGSERIAL FOREIGN KEY REFERENCES Posts(post_id),
    comment_id BIGSERIAL FOREIGN KEY REFERENCES Comments(comment_id),
    userid SERIAL FOREIGN KEY REFERENCES Users(userid)
)

CREATE TABLE Media (
    media_id BIGSERIAL PRIMARY KEY,
    post_id BIGSERIAL FOREIGN KEY REFERENCES Posts(post_id),
    comment_id BIGSERIAL FOREIGN KEY REFERENCES Comments(comment_id),
    image_name TEXT,
    image_data BYTEA
)

