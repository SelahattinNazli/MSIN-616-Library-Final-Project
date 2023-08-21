CREATE DATABASE Pub_Library

USE Pub_Library
GO


CREATE TABLE AUTHORS(
                 Author_id int not null,
				 Author_FName varchar(15) not null,
				 Author_LName varchar(20) not null,
				 Author_Phone char(10),
				 [Address] varchar(45),
				 City varchar(15),
				 [State] char(2),
				 Zip char(5)
Constraint[PK_AUTHORS] primary key (Author_id)
)
ALTER TABLE Authors ALTER COLUMN Author_Phone varchar(15)


CREATE TABLE Publishers(
                 Publisher_id int not null,
				 Publisher_Name varchar(40) not null,
				 [Address] varchar(45),
				 City varchar(15),
				 [State] char(2),
				 Contact_Name varchar(20) not null,
				 Contact_Phone char(10) not null
Constraint[PK_PUBLISHERS] primary key (Publisher_id)
)

ALTER TABLE Publishers ADD Phone char(10)

CREATE TABLE Categories(
                 Category_id int not null,
				 Category_Type varchar(15)
Constraint [PK_CATEGORIES] primary key (Category_id)
)

CREATE TABLE EmpDegrees(
                 Degree_id int not null,
				 Degree_Name varchar(20)
Constraint [PK_EMPDEGREES] primary key (Degree_id)
)

CREATE TABLE Schools(
                 School_id int not null,
				 Schhol_Name varchar(25)
Constraint [PK_SCHOOLS] primary key (School_id)
)
ALTER TABLE Schools ALTER COLUMN Schhol_Name varchar(100)

CREATE TABLE Employee_Type(
                 EmpType_id int not null,
				 EmpType_Name varchar(25)
Constraint [PK_EMPLOYEETYPE] primary key (EmpType_id)
)

CREATE TABLE Branches(
                 Branch_id int not null,
				 [Name] varchar(25) not null,
				 [Address] varchar(45),
				 Phone char(10),
				 Fax char(10)
Constraint [PK_BRANCHES] primary key (Branch_id)
)

CREATE TABLE Employees(
                Employee_id int not null,
				Degree_id int not null,
				School_id int not null,
				Branch_id int not null,
				EmpType_id int not null,
				First_Name varchar(15) not null,
				Last_Name varchar(20) not null,
				[Address] varchar(45),
				Birthdate date not null,
				HireDate date not null,
				Salary Decimal(8,2) not null,
				Cell_Phone char(10),
				Is_Head_Librarian Tinyint not null,
				Degree_Date date,
				Phone char(10),
				Salary_Type char(2),
				Vacation_Hours int
Constraint [PK_EMPLOYEES] primary key (Employee_id),
Constraint [FK_EMPLOYEES] foreign key (Degree_id) references EmpDegrees(Degree_id),
Constraint [FK_EMPLOYEES1] foreign key (School_id) references Schools(School_id),
Constraint [FK_EMPLOYEES2] foreign key (Branch_id) references Branches(Branch_id),
Constraint [FK_EMPLOYEES3] foreign key (EmpType_id) references Employee_Type(EmpType_id)
)

ALTER TABLE Employees ALTER COLUMN Salary_Type varchar(10)
EXEC sp_rename 'Employees.Vacation_Hours','Vacation_Time','COLUMN'
ALTER TABLE Employees ADD CONSTRAINT [CHK_EMPLOYEES5] CHECK (Salary_Type IN ('Salaried','Hourly'))
ALTER TABLE Employees ADD CONSTRAINT [CHK_EMPLOYEES6] CHECK (Vacation_Time>=14)

CREATE TABLE Shift_Logins(
                Login_id int not null,
				Employee_id int not null,
				[Hours] int not null,
				Shift_Date date not null
Constraint [PK_SHIFT_LOGINS] primary key (Login_id),
Constraint [FK_SHIFT_LOGINS1] foreign key (Employee_id) references Employees(Employee_id)
)

CREATE TABLE Borrowers(
                Borrower_id int not null,
				First_Name varchar(15) not null,
				Last_Name varchar(20) not null,
				[Address] varchar(45),
				Phone char(10),
				Card_id int not null,
				Card_Issue_Date date not null,
				Is_Expired Tinyint,
				SSN char(9),
				Balance_Due Decimal(6,2),
				Lg_Name varchar(20),
				Lg_Address varchar(45),
				Lg_Phone char(10)
Constraint [PK_BORROWERS] primary key (Borrower_id),
Constraint [UIX_BORROWES1] unique (SSN)
)
ALTER TABLE Borrowers ADD Birthdate date
CREATE TABLE Books(
               Book_id int not null,
			   Publisher_id int not null,
			   Title varchar(45) not null,
			   Price Decimal(6,2) not null,
			   Published_Date date not null,
			   ISBN char(13) not null
Constraint [PK_BOOKS] primary key (Book_id),
Constraint [FK_BOOKS1] foreign key (Publisher_id) references Publishers(Publisher_id),
Constraint [UIX_BOOKS1] unique (ISBN)
)

CREATE TABLE BookCopies(
               Copy_id int not null,
               Book_id int not null,
			   Title varchar(45) not null,
			   Condition varchar(15),
			   Is_Available tinyint
Constraint [PK_BOOKCOPIES] primary key (Copy_id),
Constraint [FK_BOOKCOPIES1] foreign key (Book_id) references Books(Book_id),
Constraint [CHK_CONDITION] check (Condition IN ('New','Excellent','Good','Worn','Poor'))
)
ALTER TABLE BookCopies DROP CONSTRAINT [CHK_CONDITION5]
ALTER TABLE BookCopies ADD CONSTRAINT [CHK_CONDITION6] CHECK (Condition IN ('New','Excellent','Good','Worn','Poor','Lost'))
ALTER TABLE BookCopies ADD Is_Active tinyint


CREATE TABLE Books_Borrowed(
               Borrowed_id int not null,
			   Borrower_id int not null,
			   Copy_id int not null,
			   Borrowed_Date date not null,
			   Due_Date date not null,
			   Returned_Date date,
			   Card_id int not null
Constraint [PK_BOOKSBORROWED] primary key (Borrowed_id),
Constraint [FK_BOOKSBR1] foreign key (Borrower_id) references Borrowers(Borrower_id),
Constraint [FK_BOOKSBR2] foreign key (Copy_id) references BookCopies(Copy_id),
Constraint [UIX_BOOKSBR1] unique (Card_id)
)
ALTER TABLE Books_Borrowed ADD Is_Returned tinyint
ALTER TABLE Books_Borrowed DROP CONSTRAINT [UIX_BOOKSBR1]

CREATE TABLE Authors_Books(
              Author_id int not null,
			  Book_id int not null
Constraint [PK_AUTHORBOOKS] primary key (Author_id,Book_id),
Constraint [FK_AUTHORBOOKS1] foreign key (Author_id) references Authors(Author_id),
Constraint [FK_BUILDOWNERS] foreign key (Book_id) references Books(Book_id)
)

CREATE TABLE Categories_Books(
             Category_id int not null,
			 Book_id int not null
Constraint [PK_CATEGBOOKS] primary key (Category_id,Book_id),
Constraint [FK_CATEGBOOKS1] foreign key (Category_id) references Categories(Category_id),
Constraint [FK_CATEGBOOKS2] foreign key (Book_id) references Books(Book_id)
)










