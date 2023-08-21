## Touro University Graduate School of Technology
## MSIN 616 - Advanced Database Mangement Course Final Project


This is a simple database that can be used to maintain the data stored and processed by a lending library. In this database, it is aimed to create a real data library database with all its features.



## Library Queries

### Query 1
List the title of the book that is the most popular book to be borrowed.(Namely, it has been borrowed most often number of times)

'''sql
SELECT B.Title, COUNT(Borrowed_id) AS Count_of_Borrowed
FROM Books_Borrowed BB
INNER JOIN BookCopies BC ON BC.Copy_id = BB.Copy_id
INNER JOIN Books B ON B.Book_id = BC.Book_id
GROUP BY B.Title
HAVING COUNT(Borrowed_id) >= ALL
                        (
                         SELECT  COUNT(Borrowed_id) AS Count_of_Borrowed
                         FROM Books_Borrowed BB
                         INNER JOIN BookCopies BC ON BC.Copy_id = BB.Copy_id
                         INNER JOIN Books B ON B.Book_id = BC.Book_id
                         GROUP BY B.Title
                        )
'''
--1.Way
SELECT * 
FROM
     ( 
      SELECT  E.Employee_id, First_Name + ' ' + Last_Name AS Full_Name,Salary
	         ,DENSE_RANK() OVER(ORDER BY Salary DESC) AS Row_Numb
      FROM  Employees E
      WHERE E.EmpType_id = 
                          (
                           SELECT ET.EmpType_id 
                           FROM Employee_Type  ET
                           WHERE EmpType_Name = 'Librarian'
                           )
    ) Q
WHERE Q.Row_Numb= 3



--2. Way(By using CTE)
WITH CTERankJobs
AS
  (
  SELECT E.Employee_id, Salary, First_Name + ' ' + Last_Name AS Full_Name, DENSE_RANK() OVER (ORDER BY Salary DESC) AS R
  FROM Employees E
  WHERE E.EmpType_id = 
                     (SELECT ET.EmpType_id 
                      FROM Employee_Type  ET
                      WHERE EmpType_Name = 'Librarian'
                      )
	)
SELECT * FROM CTERankJobs
WHERE R = 3



--3) For each employee, list his/her name and the name of the branch for which he/she is currently working and
--   how many employees are working for that branch.

SELECT E.Employee_id, E.First_Name + ' ' + E.Last_Name AS Full_Name,B.[Name],
        COUNT(E.Employee_id) OVER (PARTITION BY B.Branch_id) AS Num_of_Employee
FROM Employees E
INNER JOIN Branches B ON E.Branch_id = B.Branch_id
ORDER BY Num_of_Employee  DESC



--4) For each book, list the title and publisher of the book and the number of copies currently
-- stocked for this title in each branch, regardless of whether it is currently on loan.

SELECT  B.Title,P.Publisher_Name,COUNT(BC.Copy_id) AS Count_of_Copy
FROM Books B
INNER JOIN Publishers P ON B.Publisher_id = P.Publisher_id
INNER JOIN BookCopies BC ON BC.Book_id = B.Book_id
GROUP BY B.Title,P.Publisher_Name


--5) For each quarter of the current year, for each branch list the total amount of books that have
-- been borrowed in that quarter. The first quarter is months Jan, Feb, Mar. The second quarter is
-- months Apr , May , June etc. List the amounts for each of these quarters, on the same row.

SELECT  B.[Name]
        ,(
            SELECT COUNT(BB.Copy_id) AS [Total]
            FROM BookCopies BC 
            INNER JOIN Books_Borrowed BB ON BB.Copy_id = BC.Copy_id
            WHERE MONTH(BB.Borrowed_Date) IN (1,2,3) 
        ) AS [Count Of First Quarter]
        ,(
            SELECT COUNT(BB.Copy_id) AS [Total]
            FROM BookCopies BC
            INNER JOIN Books_Borrowed BB ON BB.Copy_id = BC.Copy_id
            WHERE MONTH(BB.Borrowed_Date) IN (4,5,6) 
        ) AS [Count Of Second Quarter]
        ,(
            SELECT COUNT(BB.Copy_id) AS [Total]
            FROM BookCopies BC
            INNER JOIN Books_Borrowed BB ON BB.Copy_id = BC.Copy_id
            WHERE MONTH(BB.Borrowed_Date) IN (7,8,9) 
        ) AS [Count Of Third Quarter]
        ,(
            SELECT COUNT(BB.Copy_id) AS [Total]
            FROM BookCopies BC 
            INNER JOIN Books_Borrowed BB ON BB.Copy_id = BC.Copy_id
            WHERE MONTH(BB.Borrowed_Date) IN (10,11,12) 
        ) AS [Count Of Fourth Quarter]
FROM Branches B


--6) For each card, list the name of the borrower and the name of the books he currently has
-- borrowed on the card, that have not yet been returned

SELECT BO.First_Name + ' ' + BO.Last_Name AS Full_Name,B.Title
FROM Borrowers BO
INNER JOIN Books_Borrowed BB ON BO.Card_id = BB.Card_id
INNER JOIN BookCopies BC ON BC.Copy_id = BB.Copy_id
INNER JOIN Books B ON B.Book_id = BC.Book_id
WHERE Is_Returned = 0


--7) For each card, list the name of the borrower and on the same row the quantity of books that
--   have been borrowed in 2020 and the quantity of books that have been borrowed in 2021 with that card.


SELECT  First_Name + ' ' + Last_Name AS Full_Name
        ,(
            SELECT COUNT(BB.Borrowed_id)
            FROM Books_Borrowed BB
            WHERE YEAR(BB.Borrowed_Date) = 2020 AND B.Card_id = BB.Card_id
        ) AS Borrowed_2020
        ,(
            SELECT COUNT(BB.Borrowed_id)
            FROM Books_Borrowed BB 
            WHERE YEAR(BB.Borrowed_Date) = 2021 AND B.Card_id = BB.Card_id
        ) AS Borrowed_2021
FROM Borrowers B


--8) For a specific card, list which other cards borrowed ALL the same books as was borrowed using this card. (divide query).
--   You choose the card you will be matching.

SELECT AllBooks.Card_id
FROM 
(
    SELECT DISTINCT bb.card_id,B.Title
    FROM books_borrowed bb 
    INNER JOIN bookcopies bc ON bc.copy_id = bb.copy_id
    INNER JOIN Books B ON B.Book_id = BC.Book_id
) AS AllBooks
JOIN 
(
    SELECT DISTINCT bb.card_id,B.Title
    FROM books_borrowed bb 
    JOIN bookcopies bc ON bc.copy_id = bb.copy_id
    JOIN Books B ON B.Book_id = BC.Book_id
    WHERE bb.card_id = 2
) AS Card1Books ON Card1Books.Title = AllBooks.title
GROUP BY AllBooks.card_id
HAVING COUNT(AllBooks.title) =  (
                                    SELECT COUNT(B.Title)
                                    FROM books_borrowed bb 
                                    JOIN bookcopies bc ON bc.copy_id = bb.copy_id
                                    JOIN Books B ON B.Book_id = BC.Book_id
                                    WHERE bb.card_id = 2
                                )



--9) List the name of the employee that has been working for the library the longest amount of time

SELECT  First_Name + ' ' + Last_Name AS Full_Name
FROM Employees 
WHERE HireDate = (SELECT MIN(HireDate) FROM Employees)


--10) For each book , list the title and branch that it is in, if it isn’t currently on loan

SELECT B.Title
FROM Books B
INNER JOIN BookCopies BC ON B.Book_id = BC.Book_id
LEFT JOIN Books_Borrowed BB ON BB.Copy_id = BC.Copy_id
WHERE Is_Active = 1 AND Is_Available = 1


--11) List the names of borrowers and the card id that they have if it hasn’t expired.

SELECT First_Name + ' ' + Last_Name AS Full_Name,Card_id
FROM Borrowers  
WHERE Is_Expired = 0


--12) For each author, list his name and the titles of the books he has written.

SELECT  Author_FName + ' ' + Author_LName AS [Author_FullName],Title
FROM Authors A
INNER JOIN Authors_Books AU On AU.Author_id = A.Author_id
INNER JOIN Books B ON B.Book_id = AU.Book_id


--13) For each author, list his name and the name of categories of books he has written.

SELECT A.Author_FName + ' ' + A.Author_LName AS Author_Name,C.Category_Type
FROM Authors A
INNER JOIN Authors_Books AB On AB.Author_id = A.Author_id
INNER JOIN Books B ON B.Book_id = AB.Book_id
INNER JOIN Categories_Books CB ON CB.Book_id = B.Book_id
INNER JOIN Categories C ON C.Category_id = CB.Category_id



--14) For each employee, calculate the amount of money he should have earned this year based on his logged hours.

SELECT SubQ.Employee_id,SubQ.[Total_Hours] * E.Salary AS Total_Salary
FROM 
   (
    SELECT E.Employee_id, SUM([hours]) AS Total_Hours
    FROM Employees E 
    INNER JOIN Shift_Logins SL ON E.Employee_id = SL.Employee_id
    WHERE YEAR(Shift_Date) = YEAR(GETDATE()) AND Salary_Type = 'Hourly'
    GROUP BY E.Employee_id
   ) SubQ
    INNER JOIN Employees E ON E.Employee_id = SubQ.Employee_id


--15) List the title of books that have never been borrowed.

SELECT B.Title
FROM Books B
WHERE B.Book_id NOT IN 
                       (
                        SELECT B.Book_id
                        FROM Borrowers BO 
                        INNER JOIN Books_Borrowed BB ON BO.Borrower_id = BB.Borrower_id
                        INNER JOIN BookCopies BC ON BC.Copy_id = BB.Copy_id
                        INNER JOIN Books B ON B.Book_id = BC.Book_id
                       )


--17) For each card, list the name of the cardholder, list the category of books and each book that was borrowed on this card. 
-- In the same query list to the how many books have been borrowed for each category, and how many books have been borrowed in total with this card.


    SELECT  COALESCE(CAST(BO.First_Name + ' ' + BO.Last_Name AS VARCHAR(40)), 'ALL CARDHOLDERS') AS Full_Name,
	        COALESCE(CAST(BB.Card_id AS VARCHAR(15)), 'ALL CARDS') AS CardHolder,
	        COALESCE(CAST(C.Category_ID AS VARCHAR(15)), 'ALL CATEGORIES') AS Category,
			COUNT(BB.Borrowed_id) AS Count_of_Books
    FROM Borrowers BO 
    INNER JOIN Books_Borrowed BB ON BO.card_id = BB.card_id
    INNER JOIN BookCopies BC ON BC.Copy_id = BB.Copy_id
    INNER JOIN Books B ON B.Book_id = BC.Book_id
    INNER JOIN Categories_Books CB ON CB.Book_id = B.Book_id
    INNER JOIN Categories C ON C.Category_id = CB.Category_id
    GROUP BY CUBE(BO.First_Name + ' ' + BO.Last_Name,BB.Card_id, C.Category_id)



--18) On one row, list the how many employees are currently employed for each type of employee.

SELECT ET.EmpType_Name, COUNT(E.Employee_id) AS Employee_Count
FROM Employees E 
INNER JOIN Employee_Type ET ON E.EmpType_id = ET.EmpType_id
GROUP BY EmpType_Name


--19) What is the name of the borrower, who has currently borrowed the most books.


SELECT First_Name + ' ' + Last_Name AS Borrower_Name
FROM Borrowers B  
INNER JOIN Books_Borrowed BB ON BB.Borrower_id = B.Borrower_id
GROUP BY First_Name + ' ' + Last_Name
HAVING COUNT(Copy_id) >= ALL
                                    (
                                    SELECT COUNT(Copy_id)
                                    FROM Books_Borrowed
                                    GROUP BY Borrower_id
                                    ) 

--20) List the names of borrowers who have borrowed both book A and book B (you can choose the specific book titles).


SELECT DISTINCT BO.First_Name + ' ' + BO.Last_Name AS Full_Name
FROM Borrowers BO
INNER JOIN Books_Borrowed BB ON BB.Borrower_id = BO.Borrower_id
WHERE BB.Copy_id = 201
INTERSECT
SELECT DISTINCT BO.First_Name + ' ' + BO.Last_Name AS Full_Name
FROM Borrowers BO
INNER JOIN Books_Borrowed BB ON BB.Borrower_id = BO.Borrower_id
WHERE BB.Copy_id = 209
