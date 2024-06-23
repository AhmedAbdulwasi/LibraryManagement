CREATE TABLE users (
	user_id INTEGER PRIMARY KEY AUTOINCREMENT,
	username TEXT NOT NULL UNIQUE,
	email TEXT NOT NULL UNIQUE,
	password TEXT NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE books (
	book_id INTEGER PRIMARY KEY AUTOINCREMENT,
	user_id INTEGER NOT NULL,
	title TEXT NOT NULL,
    author TEXT NOT NULL,
    isbn TEXT NOT NULL UNIQUE,
    publisher TEXT NOT NULL,
    year INTEGER NOT NULL,
    available BOOLEAN DEFAULT TRUE
);

CREATE TABLE borrowings (
    borrowing_id INTEGER PRIMARY KEY AUTOINCREMENT,
    book_id INTEGER NOT NULL,
    borrowed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    due_at TIMESTAMP NOT NULL,
    returned_at TIMESTAMP,
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

INSERT INTO users (username, email, password, created_at) VALUES 
('TheUser', 'theuser@gmail.com', 'theuseuse', '2024-01-01 10:00:00'),
('AhmedB', 'ahmedB@gmail.com', 'lkjhgfdsa11', '2024-01-02 11:00:00'),
('BillNye', 'biil.n@hotmail.com', 'password123', '2024-01-03 12:00:00');

INSERT INTO books (user_id, title, author, isbn, publisher, year, available) VALUES 
(2,'The Great Gatsby', 'F. Scott Fitzgerald', '9780743273565', 'Charles Scribners Sons', 1925, TRUE),
(2,'1984', 'George Orwell', '9780451524935', 'Secker & Warburg', 1949, TRUE),
(1,'To Kill a Mockingbird', 'Harper Lee', '9780061120084', 'J.B. Lippincott & Co.', 1960, TRUE),
(3,'Moby Dick', 'Herman Melville', '9781503280786', 'Richard Bentley', 1851, TRUE),
(3,'War and Peace', 'Leo Tolstoy', '9780199232765', 'The Russian Messenger', 1869, TRUE);

INSERT INTO borrowings (book_id, borrowed_at, due_at, returned_at) VALUES 
(1,'2024-02-01 10:00:00', '2024-02-15 10:00:00', NULL),
(2,'2024-02-02 11:00:00', '2024-02-16 11:00:00', NULL),
(3,'2024-02-03 12:00:00', '2024-02-17 12:00:00', NULL),
(4,'2024-02-04 13:00:00', '2024-02-18 13:00:00', NULL),
(5,'2024-02-05 14:00:00', '2024-02-19 14:00:00', NULL);

-- Add new users and Select user's email and username and group by email
INSERT INTO users (username, email, password, created_at) VALUES
('AlexTheFax', 'aalex@gmail.com', 'alexthepassword', '2024-01-06 09:00:00'),
('Callus', 'zallus@gmail.com', 'zallus', '2024-01-05 10:00:00');

SELECT email AS EMAIL, username AS USERNAME
FROM users u
GROUP BY email;

-- List all books
SELECT * from books;

-- Number of Books by author (add some books as well)

INSERT INTO books (user_id, title, author, isbn, publisher, year, available) VALUES 
(4,'Anna Karenina', 'Leo Tolstoy', '9780075536321', 'The Russian Messenger', 1878, TRUE),
(5,'Typee: A Peep at Polynesian Life', 'Herman Melville', '9780140430707', 'Richard Bentley', 1846, TRUE)

SELECT author AS AUTHORS, COUNT(*) AS BOOK_COUNT
FROM books
GROUP BY author;

-- Find a book by a specific author. Say Herman Melville (Make sure its ordered by the year in a descending order)

SELECT *
FROM books b
WHERE author = 'Herman Melville'
ORDER BY year DESC;


