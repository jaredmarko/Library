-- CREATE DATABASE library;
-- create a table
CREATE TABLE BOOK_AUTHORS (
  BookId INTEGER PRIMARY KEY,
  AuthorName TEXT UNIQUE
);
-- insert some values
INSERT INTO BOOK_AUTHORS VALUES (1, 'Marcel Proust');
INSERT INTO BOOK_AUTHORS VALUES (2, 'James Joyce');
INSERT INTO BOOK_AUTHORS VALUES (3, 'Gabriel Marquez');

CREATE TABLE BOOK (
  BookId INTEGER PRIMARY KEY,
  Title TEXT,
  PublisherName TEXT
);
-- insert some values
INSERT INTO BOOK VALUES (1, 'In Search of Lost Time', 'Grasset');
INSERT INTO BOOK VALUES (2, 'Lean In', 'Shakespeare');
INSERT INTO BOOK VALUES (3, 'One Hundred Years', 'Sudamericana Press');

CREATE TABLE PUBLISHER (
  Name TEXT PRIMARY KEY,
  Address TEXT,
  Phone TEXT
);
-- insert some values
INSERT INTO PUBLISHER VALUES ('Grasset', '123 Walnut St', '123-456-7890');
INSERT INTO PUBLISHER VALUES ('Shakespeare', '456 Broadway St', '453-563-6652');
INSERT INTO PUBLISHER VALUES ('Sudamericana Press', '543 Audobon St', '111-222-3333');

CREATE TABLE BOOK_COPIES (
  BookId INTEGER PRIMARY KEY,
  BranchId INTEGER UNIQUE,
  No_Of_Copies INTEGER 
);
-- insert some values
INSERT INTO BOOK_COPIES VALUES (1, 1, 22);
INSERT INTO BOOK_COPIES VALUES (2, 2, 17);
INSERT INTO BOOK_COPIES VALUES (3, 3, 6);

CREATE TABLE LIBRARY_BRANCH (
  BranchID INTEGER PRIMARY KEY,
  BranchName TEXT,
  BranchAddress TEXT
);
-- insert some values
INSERT INTO LIBRARY_BRANCH VALUES (2, 'New Orleans East', '504 Audobon St');
INSERT INTO LIBRARY_BRANCH VALUES (1, 'New York City', '333 Broadway St');
INSERT INTO LIBRARY_BRANCH VALUES (3, 'Philadelphia', '17 Times Square');

CREATE TABLE BOOK_LOANS (
  BookId INTEGER PRIMARY KEY,
  BranchId INTEGER UNIQUE,
  CardNo INTEGER UNIQUE, 
  DateOut DATE,
  DueDate DATE
);
-- insert some values
INSERT INTO BOOK_LOANS VALUES (1, 3, 16, 2003-11-06, 2003-12-06);
INSERT INTO BOOK_LOANS VALUES (2, 1, 3, 2018-10-10, 2018-11-10);
INSERT INTO BOOK_LOANS VALUES (3, 2, 2, 2021-11-09, 2021-12-09);

CREATE TABLE BORROWER (
  CardNo INTEGER PRIMARY KEY,
  Name TEXT,
  Address TEXT, 
  Phone TEXT
);
-- insert some values
INSERT INTO BORROWER VALUES (16, 'John Doe', '123 Street', '200-408-2231');
INSERT INTO BORROWER VALUES (3, 'Steve Combs', '14 Hello Avenue', '201-100-1034');
INSERT INTO BORROWER VALUES (2, 'Alex Johnson', '27 Circle Road', '202-111-0976');

-- Checkpoint 2
-- a)
SELECT No_Of_Copies
FROM BOOK_COPIES 
JOIN BOOK
    ON BOOK_COPIES.BookId
= BOOK.BookId
JOIN LIBRARY_BRANCH
    ON BOOK_COPIES.BranchId
= LIBRARY_BRANCH.BranchId
WHERE Title = 'Lean In'
    AND BranchName = 'New Orleans East';
    
-- b)
SELECT No_Of_Copies, BranchName
FROM BOOK_COPIES
JOIN LIBRARY_BRANCH
    ON BOOK_COPIES.BranchId
= LIBRARY_BRANCH.BranchId
JOIN BOOK
    ON BOOK_COPIES.BookId
=BOOK.BookId
WHERE Title = 'Lean In';

-- c) IS NULL
SELECT Name
FROM BORROWER
JOIN BOOK_LOANS
    ON BORROWER.CardNo
= BOOK_LOANS.CardNo
WHERE BookId IS NOT NULL;

-- d) 
SELECT BranchName
FROM LIBRARY_BRANCH;

-- e)
SELECT BranchName, BookID
FROM LIBRARY_BRANCH
JOIN BOOK_LOANS
    ON LIBRARY_BRANCH.BranchId
= BOOK_LOANS.BranchId;

-- f)
SELECT Title, Name, Address
FROM BOOK
JOIN BOOK_LOANS
    ON BOOK.BookId
= BOOK_LOANS.BookId
JOIN BORROWER
    ON BOOK_LOANS.CardNo
= BORROWER.CardNo
JOIN LIBRARY_BRANCH
    ON BOOK_LOANS.BranchId
= LIBRARY_BRANCH.BranchId
WHERE BranchName = 'New Orleans East';
    
    
