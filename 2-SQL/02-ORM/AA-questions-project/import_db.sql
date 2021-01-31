DROP TABLE if exists question_follows;
DROP TABLE if exists question_likes;
DROP TABLE if exists replies;
DROP TABLE if exists questions;
DROP TABLE if exists users; 

PRAGMA foreign_keys = ON;

-------------------
CREATE TABLE users(
    id INTEGER PRIMARY KEY,
    fname VARCHAR(255) NOT NULL,
    lname VARCHAR(255) NOT NULL
);

INSERT INTO 
    users (fname, lname)
VALUES
    ("Chet", "Kupchella"), ("Hannah", "Huff"), ("Toby", "Cat");

-----------------
CREATE TABLE questions(
    id INTEGER PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    body TEXT NOT NULL,
    author_id INTEGER NOT NULL,

    FOREIGN KEY (author_id) REFERENCES users(id)
);

INSERT INTO
  questions (title, body, author_id)
SELECT
  "Chet Question", "CHET CHET CHET", 1
FROM
  users
WHERE
  users.fname = "Chet" AND users.lname = "Kupchella";

INSERT INTO
  questions (title, body, author_id)
SELECT
  "Hannah Question", "HANNAH HANNAH HANNAH", 2
FROM
  users
WHERE
  users.fname = "Hannah" AND users.lname = "Huff";

INSERT INTO
  questions (title, body, author_id)
SELECT
  "Toby Question", "MEOW MEOW MEOW", 3
FROM
  users
WHERE
  users.fname = "Toby" AND users.lname = "Cat";


-------------------
CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);


INSERT INTO
  question_follows (user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = "Chet" AND lname = "Kupchella"),
  (SELECT id FROM questions WHERE title = "Hannah Question")),

  ((SELECT id FROM users WHERE fname = "Toby" AND lname = "Cat"),
  (SELECT id FROM questions WHERE title = "Chet Question")),

  ((SELECT id FROM users WHERE fname = "Hannah" AND lname = "Huff"),
  (SELECT id FROM questions WHERE title = "Toby Question")
);


-------------------
CREATE TABLE replies(
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    parent_reply_id INTEGER,
    author_id INTEGER NOT NULL,
    body TEXT NOT NULL,

    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (parent_reply_id) REFERENCES replies(id),
    FOREIGN KEY (author_id) REFERENCES users(id)
);

INSERT INTO 
    replies(question_id, parent_reply_id, author_id, body)
VALUES
    ((SELECT id FROM questions WHERE title = "Toby Question"),
    NULL,
    (SELECT id FROM users WHERE fname = "Hannah" AND lname = "Huff"),
    "Are you hungry??"
);

INSERT INTO 
    replies(question_id, parent_reply_id, author_id, body)
VALUES
    ((SELECT id FROM questions WHERE title = "Toby Question"),
    (SELECT id FROM replies WHERE body = "Are you hungry??"),
    (SELECT id FROM users WHERE fname = "Chet" AND lname = "Kupchella"),
    "Toby I didn't know you could type"
);

-------------------
CREATE TABLE question_likes(
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id)
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  question_likes (user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = "Chet" AND lname = "Kupchella"),
  (SELECT id FROM questions WHERE title = "Toby Question")
);

INSERT INTO
  question_likes (user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = "Hannah" AND lname = "Huff"),
  (SELECT id FROM questions WHERE title = "Chet Question")
);
