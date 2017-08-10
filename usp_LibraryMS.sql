USE db_LibraryMS;
GO

CREATE PROCEDURE usp_LibraryMS
AS
BEGIN

	--Number 1
	SELECT c.No_Of_Copies, b.Title, l.BranchName
	FROM BOOK_COPIES c 
	INNER JOIN BOOK b ON b.BookId = c.BookId
	INNER JOIN LIBRARY_BRANCH l ON l.BranchId = c.BranchId
	WHERE l.BranchName = 'Sharpstown' AND b.Title = 'The Lost Tribe'
	;

	--Number 2
	SELECT c.No_Of_Copies, b.Title, l.BranchName
	FROM BOOK_COPIES c
	INNER JOIN BOOK b ON b.BookId = c.BookId
	INNER JOIN LIBRARY_BRANCH l ON l.BranchId = c.BranchId
	WHERE b.Title = 'The Lost Tribe'
	;

	--Number 3
	SELECT Name
	FROM BORROWER b
	WHERE NOT EXISTS (SELECT *
		FROM BOOK_LOANS l
		WHERE b.CardNo = l.CardNo)
	;

	--Number 4
	SELECT b.Title, r.Name, r.Address
	FROM BORROWER r
	INNER JOIN BOOK_LOANS bl ON r.CardNo = bl.CardNo
	INNER JOIN BOOK b ON b.BookId = bl.BookId
	INNER JOIN LIBRARY_BRANCH lb ON lb.BranchId = bl.BranchId
	WHERE lb.BranchName = 'Sharpstown' AND bl.DueDate = '08/10/17'
	;

	--Number 5
	SELECT lb.BranchName, COUNT(*) AS 'Books Loaned'
	FROM BOOK_LOANS bl, LIBRARY_BRANCH lb
	WHERE bl.BranchId = lb.BranchId
	GROUP BY lb.BranchName
	;

	--Number 6
	SELECT r.Name, r.Address, COUNT(*) AS 'Books Borrowed'
	FROM BORROWER r
	INNER JOIN BOOK_LOANS bl ON r.CardNo = bl.CardNo
	GROUP BY r.Name, r.address
	HAVING COUNT(*) > 5
	;

	--Number 7
	SELECT b.Title, c.No_Of_Copies
	FROM BOOK b
	INNER JOIN BOOK_COPIES c ON b.BookId = c.BookId
	INNER JOIN BOOK_AUTHORS a ON b.BookId = a.BookId
	INNER JOIN LIBRARY_BRANCH lb ON c.BranchId = lb.BranchId
	WHERE a.AuthorName = 'Stephen King' AND lb.BranchName = 'Central'
	;
END