create database library_management;
use library_management;
-- 1.How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is
--  "Sharpstown"? - 5
SELECT book_copies_No_Of_Copies
FROM `book copies` bc
JOIN books b ON bc.book_copies_BookID = b.book_BookID
JOIN `library branch` lb ON bc.book_copies_BranchID = lb.library_branch_id
WHERE b.book_Title = 'The Lost Tribe' 
AND lb.library_branch_BranchName = 'Sharpstown';
 
-- 2..How many copies of the book titled "The Lost Tribe" are owned by each library branch?
select book_copies_No_Of_Copies,library_branch_BranchName 
from `book copies` BC
join books B on BC.book_copies_BookID = B.book_BookID
JOIN `library branch` LB ON BC.book_copies_BranchID = LB.library_branch_id
where B.book_Title = 'The Lost Tribe';
-- 3.Retrieve the names of all borrowers who do not have any books checked
-- out.
select borrower_BorrowerName from borrower b
left join `book loans` bl
on b.borrower_CardNo=bl.book_loans_CardNo
where book_loans_BookID is null;
-- 4.For each book that is loaned out from the "Sharpstown" branch and whose DueDate is 2/3/18, 
-- retrieve the book title, the borrower's name, and the borrower's address. 
select b.book_Title,br.borrower_BorrowerName,br.borrower_BorrowerAddress
from borrower br
join `book loans` bl on br.borrower_CardNo=bl.book_loans_CardNo
join `library branch` lb on bl.book_loans_BranchID=lb.library_branch_id
join books b on b.book_BookID=bl.book_loans_BookID
where lb.library_branch_BranchName='Sharpstown'
and bl.book_loans_DueDate='2/3/18';
-- 5. For each library branch, retrieve the branch name and the total number of books
--  loaned out from that branch.
select lb.library_branch_BranchName,count(bl.book_loans_BranchID)
from `library branch` lb
join `book loans` bl on lb.library_branch_id=bl.book_loans_BranchID
group by lb.library_branch_BranchName;
-- 6.Retrieve the names, addresses, and number of books checked out for all borrowers
--  who have more than five books checked out.
SELECT 
    br.borrower_BorrowerName, 
    br.borrower_BorrowerAddress, 
    COUNT(bl.book_loans_CardNo) AS total_loans
FROM `book loans` bl
JOIN borrower br ON br.borrower_CardNo = bl.book_loans_CardNo
GROUP BY br.borrower_CardNo,br.borrower_BorrowerName, br.borrower_BorrowerAddress
HAVING total_loans > 5;
-- 7.For each book authored by "Stephen King",
-- retrieve the title and the number of copies owned by the library branch whose name is "Central".
select b.book_Title,bc.book_copies_No_Of_Copies
from books b
join `book copies` bc on b.book_BookID=bc.book_copies_BookID
join `library branch` lb on bc.book_copies_BranchID=lb.library_branch_id
join  authors a on b.book_BookID=a.book_authors_BookID
where a.book_authors_AuthorName='Stephen King' and 
lb.library_branch_BranchName='Central';