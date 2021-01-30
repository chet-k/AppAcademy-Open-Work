DROP TABLE if exists question_likes;
DROP TABLE if exists replies;
DROP TABLE if exists question_follows;
DROP TABLE if exists questions;
DROP TABLE if exists users; 

PRAGMA foreign_keys = ON;

CREATE TABLE users(
    id PRIMARY KEY,
    fname VARCHAR(255) NOT NULL,
    lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions(
    id PRIMARY KEY,
    title TEXT,
    body TEXT,
    author_id INTEGER NOT NULL,

    FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_follows(
    id PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies(
    id PRIMARY KEY,
    question_id INTEGER NOT NULL,
    parent_reply_id INTEGER,
    author_id INTEGER NOT NULL,
    body TEXT NOT NULL,

    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (parent_reply_id) REFERENCES replies(id),
    FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_likes(
    id PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id)
    FOREIGN KEY (question_id) REFERENCES questions(id)
);