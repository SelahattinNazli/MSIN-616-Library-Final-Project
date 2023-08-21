## Touro University Graduate School of Technology
## MSIN 616 - Advanced Database Mangement Course Final Project


This is a simple database that can be used to maintain the data stored and processed by a lending library. In this database, it is aimed to create a real data library database with all its features.


## Descriptive Information About Database	
- The library categorizes the books it has.  Typical categories might be: fiction, historical fiction, mystery, science fiction, juvenile, reference, adult.  A book might have more than one category. For example, it might be juvenile and fiction.
- Any reading item that is categorized as reference may not be borrowed.
- For each book, the library stores the isbn, title, publisher, category type, author(s), cost
- A book can have more than one author
- An author can write more than one book
- A publisher can publish more than one book
- The library stores publisher data such as Publisher Name, Address, Phone Number, Contact Person
- There are several branches within this lending library system.  For each branch store the branch id, name, address, telephone number, fax number, head librarian
- A branch might employ several librarians, but only one head librarian.  For each librarian, store the employee id, name, address, telephone number, salary, cell phone number.  
- A librarian may be assigned to only one branch.
- Branches have different types of employees.  Some types are Librarian, Network Administrator,  Computer Programmer, IT Manager, Floor Manager, Custodian, Accountant, Data Analyst  Librarians must have earned a degree in library science. For each employee, the library maintains name, address, phone number, birthdate, hire date, type of employee.  For librarians, the library also maintains when the librarian earned his/her degree and the school at which the librarian earned the degree
- The Library supports two types of PayTypes: salaried and hourly. Employees that are salaried earn a yearly salary that is paid in 12 payments on the first of each month. Employees that are clerical, earn an hourly wage.    All employees get vacation time depending on their length of service. The minimum amount of vacation time is two weeks. 
- The library maintains a log of how many hours each clerical type of employee logged during each week that he worked. This log is used to produce paychecks for clerical staff at the end of each week. 
- Each employee is assigned to one specific branch only.
- The library issues library cards to people who wish to borrow books from the library.  The library keeps a list of each borrower by storing the card id, borrower name, address, phone number, birthdate, date the card was issued, balance due.   A card expires ten years from the time it is issued.
- If a person is less than 18 years old, then the library will also keep information about the Borrower’s parent or legal guardian such as name, address, phone number. 
- A person can have only one valid library card at a given time.  
- A person can’t be issued a new library card, if he owes money on an expired card.
- The Library purchases many copies of the same book. Each book copy is assigned a unique copy ID. Each book copy is found in a specific branch of the library.  
- The Library assigns a Condition to each book copy. Sample condition values could be NEW, EXCELLENT, GOOD, WORN, POOR. Eventually copies that are in POOR condition will be discarded and replaced with new copies.
- For each borrowed book copy, the library keeps track of the copy id and the card number of the person who borrowed it.  The library keeps track of the date on which it was borrowed and records the due date which is two weeks after the borrow date.  When the copy is returned this record is updated with the return date. 
- When a book copy is borrowed, the copy is marked as BORROWED. When the book copy is returned the copy is marked as AVAILABLE or NOT BORROWED. 
- A borrower can’t borrow a book from a particular branch unless that branch has a copy of that book and it is currently in stock (e.g. not being borrowed by someone else) 
- When a borrower returns a book copy after the due date the system calculates the amount owed and any overdue charge incurred is added to the card balance 
- A borrower cannot use a card to borrow books, if he owes more than 10 dollars on that card.
- The library has a list of overdue charges.  The charges are currently .05 each day for juvenile books and .10 per day for adult books.  When a book is returned late the borrower pays charges that are in effect at the time the book is returned.
- A borrower can acknowledge that he has lost a copy of a book.  If so, the copy is marked LOST and the book’s cost is added to the card balance.   Eventually the copy may be removed from the current inventory of branch copies and stored in a history file.


/*
a.	A librarian can’t be hired before he has earned a MS in Library Science degree.
b.	A new card can’t be issued for someone who owes money on an existing card
c.	A new card can’t be issued for someone who has a card that hasn’t yet expired

*/

CREATE TRIGGER   CheckEmployees
ON Employees
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @branchId INT = (SELECT branch_id FROM inserted)
    DECLARE @isHead BIT = (SELECT Is_Head_Librarian FROM inserted)
    DECLARE @empTypeId INT = (SELECT EmpType_id FROM inserted)
    DECLARE @salaryType VARCHAR(10) = (SELECT salary_type FROM inserted)
    DECLARE @salary DECIMAL(8,2) = (SELECT salary FROM inserted)
    DECLARE @degreeid INT = (SELECT degree_id FROM inserted)
    -- phone can be used as unique identifier
    DECLARE @phone VARCHAR(12) = (SELECT Cell_Phone FROM inserted)

    
    IF(@isHead = 1)
    BEGIN 
        -- Check if head librarian exists for the branch
        IF EXISTS(SELECT TOP 1 1 FROM employees WHERE branch_id = @branchId AND Is_Head_Librarian = 1)
        BEGIN
            ;THROW 50006,'There is already a head librarian on this branch',1
            ROLLBACK
        END

        -- Check if employee is of type librarian
        IF(@empTypeId <> 1)
            BEGIN
                ;THROW 50007,'Only librarians can be head librarian',1
                ROLLBACK
            END
    END
    
    -- Check if librarian exists
    IF EXISTS(SELECT TOP 1 1 FROM employees WHERE Cell_Phone = @phone )
        BEGIN
            ;THROW 50008,'Employee is already assigned to', 1
            ROLLBACK
        END

    -- Check if librarian exists
    IF(@salaryType = 'Hourly' AND @salary < 15)
        BEGIN
            ;THROW 50009,'Minimum hourly pay for clerical employees must be greater than 15 dollars.', 1
            ROLLBACK
        END
    
    IF(@empTypeId = 1 AND (@salary < 20000 OR @salary > 70000))
        BEGIN
            ;THROW 50010, 'Salary for librarians must be between 20000 and 70000', 1
            ROLLBACK
        END
    
    IF(@empTypeId = 1 AND @degreeid <> 2)
        BEGIN
            ;THROW 50011, 'Librarian must have earned MS degree in Library Sciences.', 1
            ROLLBACK
        END

    PRINT('Employee has been sucessfully added.')
END



GO
ALTER TABLE employees ENABLE TRIGGER CheckEmployees




--Test Cases

--1) If we want to add a new 'head librarian' record to the branch that has already exist a 'head librarian'.


INSERT INTO Employees 
VALUES (67,2,2,1,1,'Alice','Meyer','Haberst Av', '1984-08-08', '2019-04-19', 50000.00, 456432589,1,'2014-06-07',542134732,'Salaried',14)


--2) If we want to add a new 'head librarian' record that NOT the employee type is 'Librarian'.
--   (In this example, what I try to insert type of employee is Computer Programmer)

INSERT INTO Employees 
VALUES (67,2,2,10,3,'Alice','Meyer','Haberst Av', '1984-08-08', '2019-04-19', 50000.00, 456432589,1,'2014-06-07',542134732,'Salaried',14)

--3) If we want to add a new record that already exist in the table

INSERT INTO Employees 
VALUES (1,1,1,1,1,'Tammy','Williams','7072 Meadow Lane', '1973-08-04', '2015-01-20', 70000.00, 963434339,0,'2012-04-09',925667082,'Salaried',14)


--4) If we want to add a new record that been clerical employee but hourly pay is less than 15 dollars.
--   (In this example hourly salary adjusted as 13$ per hour)


INSERT INTO Employees 
VALUES (67,3,8,2,1,'Tamar','Gomes','7073 Meadow Lane', '1977-08-04', '2015-01-21', 13.00, 963434367,0,'2012-05-09',925367082,'Hourly',14)


--5) If we want to add a new record that who is librarian but salary of him/her NOT between 20000 and 70000'
-- (In this example, the salary of librarian is 80,000$)

INSERT INTO Employees 
VALUES (67,2,2,10,1,'Alice','Meyer','Haberst Av', '1984-08-08', '2019-04-19', 80000.00, 456432589,1,'2014-06-07',542134732,'Salaried',14)


--6) If we want to add a new 'librarian' record that NOT the degree of employee is 'MS degree in Library Sciences.'
--(In this example , what I try to insert type of employee has 'Online Education' degree)

INSERT INTO Employees 
VALUES (67,3,2,10,1,'Alice','Meyer','Haberst Av', '1984-08-08', '2019-04-19', 50000.00, 456432589,1,'2014-06-07',542134732,'Salaried',14)


--7) If we want to add a new record that matching all the criterias.


INSERT INTO Employees 
VALUES (67,2,2,10,1,'Alice','Meyer','Haberst Av', '1984-08-08', '2019-04-19', 60000.00, 456432589,1,'2014-06-07',542134732,'Salaried',14)

## Library Queries

### Query 1
List the title of the book that is the most popular book to be borrowed.(Namely, it has been borrowed most often number of times)

```sql
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
```

### Query 2
Which librarian has the third highest salary at the current time?


--1.Way
```sql
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
```


--2. Way(By using CTE)
```sql
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
```


### Query 3
For each employee, list his/her name and the name of the branch for which he/she is currently working and how many employees are working for that branch.

```sql
SELECT E.Employee_id, E.First_Name + ' ' + E.Last_Name AS Full_Name,B.[Name],
        COUNT(E.Employee_id) OVER (PARTITION BY B.Branch_id) AS Num_of_Employee
FROM Employees E
INNER JOIN Branches B ON E.Branch_id = B.Branch_id
ORDER BY Num_of_Employee  DESC
```


### Query 4
For each book, list the title and publisher of the book and the number of copies currently stocked for this title in each branch, regardless of whether it is currently on loan.

```sql
SELECT  B.Title,P.Publisher_Name,COUNT(BC.Copy_id) AS Count_of_Copy
FROM Books B
INNER JOIN Publishers P ON B.Publisher_id = P.Publisher_id
INNER JOIN BookCopies BC ON BC.Book_id = B.Book_id
GROUP BY B.Title,P.Publisher_Name
```

### Query 5
For each quarter of the current year, for each branch list the total amount of books that have been borrowed in that quarter. The first quarter is months Jan, Feb, Mar. The second quarter is  months Apr , May , June etc. List the amounts for each of these quarters, on the same row.

```sql
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
```

### Query 6 
For each card, list the name of the borrower and the name of the books he currently has borrowed on the card, that have not yet been returned.

```sql
SELECT BO.First_Name + ' ' + BO.Last_Name AS Full_Name,B.Title
FROM Borrowers BO
INNER JOIN Books_Borrowed BB ON BO.Card_id = BB.Card_id
INNER JOIN BookCopies BC ON BC.Copy_id = BB.Copy_id
INNER JOIN Books B ON B.Book_id = BC.Book_id
WHERE Is_Returned = 0
```

### Query 7
For each card, list the name of the borrower and on the same row the quantity of books that have been borrowed in 2020 and the quantity of books that have been borrowed in 2021 with that card.

```sql
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
```

### Query 8
For a specific card, list which other cards borrowed ALL the same books as was borrowed using this card. (divide query). You choose the card you will be matching.

```sql
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
```


### Query 9
List the name of the employee that has been working for the library the longest amount of time.

```sql
SELECT  First_Name + ' ' + Last_Name AS Full_Name
FROM Employees 
WHERE HireDate = (SELECT MIN(HireDate) FROM Employees)
```

### Query 10
For each book , list the title and branch that it is in, if it isn’t currently on loan.

```sql
SELECT B.Title
FROM Books B
INNER JOIN BookCopies BC ON B.Book_id = BC.Book_id
LEFT JOIN Books_Borrowed BB ON BB.Copy_id = BC.Copy_id
WHERE Is_Active = 1 AND Is_Available = 1
```

### Query 11
List the names of borrowers and the card id that they have if it hasn’t expired.

```sql
SELECT First_Name + ' ' + Last_Name AS Full_Name,Card_id
FROM Borrowers  
WHERE Is_Expired = 0
```

### Query 12
For each author, list his name and the titles of the books he has written.

```sql
SELECT  Author_FName + ' ' + Author_LName AS [Author_FullName],Title
FROM Authors A
INNER JOIN Authors_Books AU On AU.Author_id = A.Author_id
INNER JOIN Books B ON B.Book_id = AU.Book_id
```

### Query 13 
For each author, list his name and the name of categories of books he has written.

```sql
SELECT A.Author_FName + ' ' + A.Author_LName AS Author_Name,C.Category_Type
FROM Authors A
INNER JOIN Authors_Books AB On AB.Author_id = A.Author_id
INNER JOIN Books B ON B.Book_id = AB.Book_id
INNER JOIN Categories_Books CB ON CB.Book_id = B.Book_id
INNER JOIN Categories C ON C.Category_id = CB.Category_id
```

### Query 14
For each employee, calculate the amount of money he should have earned this year based on his logged hours.

```sql
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
```

### Query 15
List the title of books that have never been borrowed.

```sql
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
```

### Query 16
For each card, list the name of the cardholder, list the category of books and each book that was borrowed on this card. In the same query list to the how many books have been borrowed for each category, and how many books have been borrowed in total with this card.

```sql
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
```


### Query 17
On one row, list the how many employees are currently employed for each type of employee.

```sql
SELECT ET.EmpType_Name, COUNT(E.Employee_id) AS Employee_Count
FROM Employees E 
INNER JOIN Employee_Type ET ON E.EmpType_id = ET.EmpType_id
GROUP BY EmpType_Name
```

### Query 18
What is the name of the borrower, who has currently borrowed the most books.

```sql
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
```

### Query 19
List the names of borrowers who have borrowed both book A and book B (you can choose the specific book titles).

```sql
SELECT DISTINCT BO.First_Name + ' ' + BO.Last_Name AS Full_Name
FROM Borrowers BO
INNER JOIN Books_Borrowed BB ON BB.Borrower_id = BO.Borrower_id
WHERE BB.Copy_id = 201
INTERSECT
SELECT DISTINCT BO.First_Name + ' ' + BO.Last_Name AS Full_Name
FROM Borrowers BO
INNER JOIN Books_Borrowed BB ON BB.Borrower_id = BO.Borrower_id
WHERE BB.Copy_id = 209
```
