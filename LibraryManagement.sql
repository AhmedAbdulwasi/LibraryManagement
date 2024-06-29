CREATE TABLE users (
	user_id INTEGER PRIMARY KEY AUTOINCREMENT,
	username TEXT NOT NULL UNIQUE,
	email TEXT NOT NULL UNIQUE,
	password TEXT NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE books (
	book_id INTEGER PRIMARY KEY AUTOINCREMENT,
	user_id INTEGER,
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
    	user_id INTEGER,
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
(2,'The Great Gatsby', 'F. Scott Fitzgerald', '9780743273565', 'Charles Scribners Sons', 1925, FALSE),
(2,'1984', 'George Orwell', '9780451524935', 'Secker & Warburg', 1949, FALSE),
(1,'To Kill a Mockingbird', 'Harper Lee', '9780061120084', 'J.B. Lippincott & Co.', 1960, FALSE),
(3,'Moby Dick', 'Herman Melville', '9781503280786', 'Richard Bentley', 1851, FALSE),
(3,'War and Peace', 'Leo Tolstoy', '9780199232765', 'The Russian Messenger', 1869, TRUE);

INSERT INTO borrowings (user_id,book_id, borrowed_at, due_at, returned_at) VALUES 
(2,1,'2024-02-01 10:00:00', '2024-02-15 10:00:00', NULL),
(2,2,'2024-02-02 11:00:00', '2024-02-16 11:00:00', NULL),
(1,3,'2024-02-03 12:00:00', '2024-02-17 12:00:00', NULL),
(3,4,'2024-02-04 13:00:00', '2024-02-18 13:00:00', NULL),
(3,5,'2024-02-05 14:00:00', '2024-02-19 14:00:00', '2024-02-16 13:00:00');

-- Add new users and Select user's email and username and group by email.
INSERT INTO users (username, email, password, created_at) VALUES
('AlexTheFax', 'aalex@gmail.com', 'alexthepassword', '2024-01-06 09:00:00'),
('Callus', 'zallus@gmail.com', 'zallus', '2024-01-05 10:00:00');

SELECT email AS EMAIL, username AS USERNAME
FROM users u
GROUP BY email;

-- List all books.
SELECT * from books;

-- List all borrowings info.
SELECT * from borrowings;

-- Number of Books by author (add some books as well).

INSERT INTO books (user_id, title, author, isbn, publisher, year, available) VALUES 
(4,'Anna Karenina', 'Leo Tolstoy', '9780075536321', 'The Russian Messenger', 1878, TRUE),
(5,'Typee: A Peep at Polynesian Life', 'Herman Melville', '9780140430707', 'Richard Bentley', 1846, TRUE)

SELECT author AS AUTHORS, COUNT(*) AS BOOK_COUNT
FROM books
GROUP BY author;

-- Find a book by a specific author. Say Herman Melville (Make sure its ordered by the year in a descending order).

SELECT *
FROM books b
WHERE author = 'Herman Melville'
ORDER BY year DESC;

-- List all users who have borrowed books along with the book titles they borrowed.

SELECT u.username AS Username, u.email AS Email, bk.title AS Title
FROM borrowings b
JOIN users u ON b.user_id = u.user_id
JOIN books bk ON b.book_id = bk.book_id;

-- List all books that are currently borrowed (not yet returned).

SELECT bk.title AS Title, bk.author AS Author, bk.year AS Year
FROM borrowings b
JOIN books bk ON b.book_id = bk.book_id
WHERE b.returned_at IS NULL;

-- List all overdue books along with the borrower's information. Assume today's date is '2024-03-01'.


SELECT u.username AS Username, u.email AS Email, bk.title AS Title, bk.isbn AS ISBN, due_at AS Due_Date
FROM borrowings b 
JOIN users u ON u.user_id = b.user_id
JOIN books bk ON bk.book_id = b.book_id
WHERE due_at < '2024-03-01';

-- List books that are currently borrowed by 'AhmedB'
SELECT u.username AS Username, bk.title AS TITLE, due_at AS Due_Date
FROM borrowings b 
JOIN users u ON u.user_id = b.user_id
JOIN books bk ON bk.book_id = b.book_id
WHERE u.username = 'AhmedB';
