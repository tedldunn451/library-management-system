--Create the database instance

CREATE DATABASE db_LibraryMS

-- Ensure that the upcoming steps take place for the proper database

USE db_LibraryMS
GO

--Create the tables for the database

CREATE TABLE PUBLISHER (
    Name VARCHAR(50) PRIMARY KEY NOT NULL,
    Address VARCHAR(75),
    Phone VARCHAR(20)	
);

CREATE TABLE BORROWER (
    CardNo INT PRIMARY KEY NOT NULL,
    Name VARCHAR(50),
    Address VARCHAR(75),
    Phone VARCHAR(20)
);

CREATE TABLE LIBRARY_BRANCH (
    BranchId INT PRIMARY KEY NOT NULL,
    BranchName VARCHAR(50),
    Address VARCHAR(75)
);

CREATE TABLE BOOK (
    BookId INT PRIMARY KEY NOT NULL,
    Title VARCHAR(50) NOT NULL,
    PublisherName VARCHAR(50) NOT NULL
		CONSTRAINT fk_book_publisher_name
		FOREIGN KEY (PublisherName)
		REFERENCES PUBLISHER (Name)
		ON UPDATE CASCADE ON DELETE CASCADE
);	

CREATE TABLE BOOK_AUTHORS (
    BookId INT NOT NULL
		CONSTRAINT fk_book_authors_bookid	
		FOREIGN KEY (BookId)
		REFERENCES BOOK (BookId)
		ON UPDATE CASCADE ON DELETE CASCADE,
    AuthorName VARCHAR(50) NOT NULL
);

CREATE TABLE BOOK_LOANS (
    BookId INT NOT NULL,
		/*CONSTRAINT fk_book_loans_bookid
		FOREIGN KEY (BookId)
		REFERENCES BOOK (BookId)
		ON UPDATE CASCADE ON DELETE CASCADE,*/
    BranchId INT NOT NULL
		CONSTRAINT fk_book_loans_branchid
		FOREIGN KEY (BranchId)
		REFERENCES LIBRARY_BRANCH (BranchId)
		ON UPDATE CASCADE ON DELETE CASCADE,
    CardNo INT NOT NULL
		CONSTRAINT fk_book_loans_cardno
		FOREIGN KEY (CardNo)
		REFERENCES BORROWER (CardNo)
		ON UPDATE CASCADE ON DELETE CASCADE,
    DateOut DATE NOT NULL,
    DueDate DATE NOT NULL   
);

CREATE TABLE BOOK_COPIES (
    BookId INT NOT NULL,
		/*CONSTRAINT fk_book_copies_bookid
		FOREIGN KEY (BookId)
		REFERENCES BOOK (BookId)
		ON UPDATE CASCADE ON DELETE CASCADE,*/
    BranchId INT NOT NULL
		CONSTRAINT fk_book_copies_branchid
		FOREIGN KEY (BranchId)
		REFERENCES LIBRARY_BRANCH (BranchId)
		ON UPDATE CASCADE ON DELETE CASCADE,
    No_Of_Copies INT NOT NULL    
);

-- Populate the tables with data

INSERT INTO PUBLISHER
    (Name, Address, Phone)
    VALUES
    ('Picador USA', '175 Fifth Avenue, New York, NY 10010', '212-307-5421'),
    ('Harper Collins', '195 Broadway, New York, NY 10007', '212-207-7000'),
    ('Tor Books', '175 Fifth Avenue New York, NY 10010', '212-674-6131'),
    ('Bantam Books', '375 Hudson Street, New York, NY 10014', '212-366-2000'),
    ('Wizards of the Coast', '1600 Lind Avenue SW, Renton, WA 98057', '425-226-6500'),
    ('Ace Books', '20 Hightower Lane, Boston, MA 02120', '617-585-5155'),
    ('Doubleday Books', '1745 Broadway, New York, NY 10019', '212-785-8000'),
    ('Ballantine Books', '1745 Broadway New York, NY 10019', '212-872-7000'),
    ('Random House', '1745 Broadway, New York, NY 10019', '212-782-9000'),
    ('The Overlook Press', '141 Wooster Street, New York, NY 10012', '212-673-2210'),
    ('Mariner Books', '125 High Street, Boston, MA 02110', '617-975-1001'),
    ('Wiley', '111 River Stree, Hoboken, NJ 07030', '201-748-6000'),
    ('Andrews McMeel Publishing', 'Kansas City, MO', '800-943-9839'),
    ('Simon & Schuster', '1230 6th Avenue, New York, NY 10020', '212-315-2673'),
    ('Princeton University Press', '41 William Street, Princeton, NJ 08540', '609-258-4900'),
    ('Chartwell Books', '122 Fifth Avenue, New York, NY 10011', '212-486-5000'),
    ('William Morrow', '195 Broadway, New York, NY 10007', '212-207-6000')
;

INSERT INTO BORROWER
    (CardNo, Name, Address, Phone)
    VALUES
    (1001, 'Eric Cook', '515 Belle Avenue, Eugene, OR 97403', '555-871-1825'),
    (1002, 'Ross Capers', '2345 Christy Lane, Springfield, OR 97477', '555-471-0134'),
    (1003, 'Jeremy Francis', '4742 Unroe Drive, N. Springfield, OR 97477', '555-279-2407'),
    (1004, 'Jennifer Harvey', '921 Granny White Pike, Eugene, OR 97401', '555-942-5271'),
    (1005, 'Julie Gresham', '6166 Riverside Drive, Eugene, OR, 97405', '555-757-1288'),
    (1006, 'Melissa Aelker', '1624 Red Robin Circle, Springfield, OR, 97477', '555-666-1234'),
    (1007, 'Leland Dugger', '533 Holly Hill Drive, Eugene, OR, 97405', '555-564-8821'),
    (1008, 'Carisa Holmes', '141 Tarryton Court, Springfield, OR 97477', '555-712-5762'),
    (1009, 'Rich Rutherford', '8675 Demorest Road, Eugene, OR 97403', '555-924-3131'),
    (1010, 'Heather Rader', '6961 Cherry Hill Place, Springfield, OR 97477', '555-438-6822'),
    (1011, 'Michelle Trueblood', '777 Wild Oak Way, Eugene, OR 97401', '555-212-5768'),
    (1012, 'Brian Cook', '333 Main Street, Springfield, OR 97477', '555-812-4399')
;

INSERT INTO LIBRARY_BRANCH
    (BranchId, BranchName, Address)
    VALUES
    (1, 'Sharpstown', '42 Evergreen Terrace, Springfield, OR, 97477'),
    (2, 'Central', '101 Wallaby Lane, Eugene, OR 97403'),
    (3, 'Nirvana', '47 Elm Street, Eugene, OR 97401'),
    (4, 'Paradise', '888 Shady Oaks Avenue, N. Springfield, OR 97477')
;

INSERT INTO BOOK 
    (BookId, Title, PublisherName)
    VALUES
    (101, 'The Lost Tribe', 'Picador USA'),
    (102, 'And Then There Were None', 'Harper Collins'),
    (103, 'The Prestige', 'Tor Books'),
    (104, 'The Lord of the Rings: Fellowship of the Ring', 'Mariner Books'),
    (105, 'A Game of Thrones', 'Bantam Books'),
    (106, 'Dragons of Autumn Twilight', 'Wizards of the Coast'),
    (107, 'Swords Against Death', 'Ace Books'),
    (108, 'The Shining', 'Doubleday Books'),
    (109, 'Sphere', 'Ballantine Books'),
    (110, 'I, Robot', 'Random House'),
    (111, 'Psycho', 'The Overlook Press'),
    (112, 'A Scanner Darkly', 'Mariner Books'),
    (113, 'The Bourne Identity', 'Bantam Books'),
    (114, 'C# For Dummies', 'Wiley'),
    (115, 'Calvin and Hobbes', 'Andrews McMeel Publishing'),
    (116, 'The Rise and Fall of the Third Reich', 'Simon & Schuster'),
    (117, 'The Hero With a Thousand Faces', 'Princeton University Press'),
    (118, 'Murder On the Orient Express', 'Bantam Books'),
    (119, 'The Complete Fiction of H.P. Lovecraft', 'Chartwell Books'),
    (120, 'Shutter Island', 'William Morrow') 
;

INSERT INTO BOOK_AUTHORS 
    (BookId, AuthorName)
    VALUES
    (101, 'Mark Lee'),
    (102, 'Agatha Christie'),
    (103, 'Christoper Priest'),
    (104, 'J.R.R. Tolkien'),
    (105, 'George R.R. Martin'),
    (106, 'Margaret Weis & Tracy Hickman'),
    (107, 'Fritz Leiber'),
    (108, 'Stephen King'),
    (109, 'Michael Crichton'),
    (110, 'Isaac Asimov'),
    (111, 'Robert Bloch'),
    (112, 'Philip K. Dick'),
    (113, 'Robert Ludlum'),
    (114, 'Stephen R. Davis'),
    (115, 'Bill Watterson'),
    (116, 'William L. Shirer'),
    (117, 'Joseph Campbell'),
    (118, 'Agatha Christie'),
    (119, 'H.P. Lovecraft'),
    (120, 'Dennis Lehane')
;

INSERT INTO BOOK_LOANS 
    (BookId, BranchId, CardNo, DateOut, DueDate)
    VALUES
    (101, 3, 1001, '08/02/17' , '08/30/17'),
    (107, 3, 1001, '08/02/17' , '08/30/17'),
    (113, 3, 1001, '08/02/17' , '08/30/17'),
    (118, 3, 1001, '08/02/17' , '08/30/17'), 
    (101, 1, 1002, '07/20/17' , '08/17/17'),
    (112, 1, 1002, '07/20/17' , '08/17/17'),
    (120, 1, 1002, '07/20/17' , '08/17/17'), 
    (108, 4, 1004, '07/14/17' , '08/11/17'),
    (113, 4, 1004, '07/14/17' , '08/11/17'),
    (116, 4, 1004, '07/14/17' , '08/11/17'),
    (118, 4, 1004, '07/14/17' , '08/11/17'),
    (102, 2, 1004, '07/17/17' , '08/14/17'),
    (103, 2, 1004, '07/17/17' , '08/14/17'),
    (109, 2, 1004, '07/17/17' , '08/14/17'), 
    (101, 1, 1005, '07/19/17' , '08/16/17'),
    (105, 1, 1005, '07/19/17' , '08/16/17'),
    (110, 1, 1005, '07/19/17' , '08/16/17'),
    (114, 1, 1005, '07/19/17' , '08/16/17'),
    (117, 1, 1005, '07/19/17' , '08/16/17'), 
    (107, 2, 1006, '07/23/17' , '08/20/17'),
    (108, 2, 1006, '07/23/17' , '08/20/17'),
    (112, 2, 1006, '07/23/17' , '08/20/17'), 
    (101, 4, 1007, '07/20/17' , '08/17/17'),
    (108, 4, 1007, '07/20/17' , '08/17/17'),
    (110, 4, 1007, '07/20/17' , '08/17/17'),
    (114, 4, 1007, '07/20/17' , '08/17/17'),
    (116, 4, 1007, '07/20/17' , '08/17/17'),
    (118, 4, 1007, '07/20/17' , '08/17/17'),
    (111, 3, 1007, '07/21/17' , '08/18/17'),
    (116, 3, 1007, '07/21/17' , '08/18/17'), 
    (105, 1, 1008, '07/13/17' , '08/10/17'),
    (106, 1, 1008, '07/13/17' , '08/10/17'),
    (112, 1, 1008, '07/13/17' , '08/10/17'),
    (114, 1, 1008, '07/13/17' , '08/10/17'),
    (115, 1, 1008, '07/13/17' , '08/10/17'),
    (120, 1, 1008, '07/13/17' , '08/10/17'), 
    (105, 2, 1009, '08/01/17' , '08/29/17'),
    (107, 2, 1009, '08/01/17' , '08/29/17'),
    (113, 2, 1009, '08/01/17' , '08/29/17'), 
    (104, 3, 1011, '08/05/17' , '09/02/17'),
    (113, 3, 1011, '08/05/17' , '09/02/17'),
    (114, 3, 1011, '08/05/17' , '09/02/17'),
    (118, 3, 1011, '08/05/17' , '09/02/17'),
    (120, 3, 1011, '08/05/17' , '09/02/17'),
    (115, 4, 1011, '08/08/17' , '09/05/17'),
    (113, 4, 1011, '08/08/17' , '09/05/17'),
    (108, 2, 1012, '08/05/17' , '09/02/17'),
    (109, 2, 1012, '08/05/17' , '09/02/17'),
    (113, 2, 1012, '08/05/17' , '09/02/17'),
    (119, 2, 1012, '08/05/17' , '09/02/17')
;

INSERT INTO BOOK_COPIES 
    (BookId, BranchId, No_Of_Copies)
    VALUES
    (101, 1, 3),
    (102, 1, 2),
    (105, 1, 5),
    (106, 1, 2),
    (110, 1, 3),
    (112, 1, 4),
    (114, 1, 5),
    (115, 1, 8),
    (117, 1, 2),
    (120, 1, 3),
    (102, 2, 3),
    (103, 2, 2),
    (105, 2, 5),
    (107, 2, 4),
    (108, 2, 6),
    (109, 2, 5),
    (112, 2, 2),
    (113, 2, 4),
    (116, 2, 3),
    (119, 2, 2),
    (101, 3, 5),
    (104, 3, 3),
    (107, 3, 2),
    (111, 3, 2),
    (113, 3, 4),
    (114, 3, 8),
    (116, 3, 2),
    (118, 3, 3),
    (119, 3, 2),
    (120, 3, 5),
    (101, 4, 3),
    (105, 4, 2),
    (108, 4, 6),
    (110, 4, 4),
    (113, 4, 2),
    (114, 4, 3),
    (115, 4, 5),
    (116, 4, 2),
    (118, 4, 4),
    (120, 4, 3)
;


