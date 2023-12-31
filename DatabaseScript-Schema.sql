USE [master]
GO
/****** Object:  Database [Pub_Library]    Script Date: 5/10/2023 9:51:26 AM ******/
CREATE DATABASE [Pub_Library]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Pub_Library', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Pub_Library.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Pub_Library_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Pub_Library_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Pub_Library] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Pub_Library].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Pub_Library] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Pub_Library] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Pub_Library] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Pub_Library] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Pub_Library] SET ARITHABORT OFF 
GO
ALTER DATABASE [Pub_Library] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Pub_Library] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Pub_Library] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Pub_Library] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Pub_Library] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Pub_Library] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Pub_Library] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Pub_Library] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Pub_Library] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Pub_Library] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Pub_Library] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Pub_Library] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Pub_Library] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Pub_Library] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Pub_Library] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Pub_Library] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Pub_Library] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Pub_Library] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Pub_Library] SET  MULTI_USER 
GO
ALTER DATABASE [Pub_Library] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Pub_Library] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Pub_Library] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Pub_Library] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Pub_Library] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Pub_Library] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Pub_Library] SET QUERY_STORE = OFF
GO
USE [Pub_Library]
GO
/****** Object:  Table [dbo].[AUTHORS]    Script Date: 5/10/2023 9:51:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AUTHORS](
	[Author_id] [int] NOT NULL,
	[Author_FName] [varchar](15) NOT NULL,
	[Author_LName] [varchar](20) NOT NULL,
	[Author_Phone] [varchar](15) NULL,
	[Address] [varchar](45) NULL,
	[City] [varchar](15) NULL,
	[State] [char](2) NULL,
	[Zip] [char](5) NULL,
 CONSTRAINT [PK_AUTHORS] PRIMARY KEY CLUSTERED 
(
	[Author_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Authors_Books]    Script Date: 5/10/2023 9:51:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Authors_Books](
	[Author_id] [int] NOT NULL,
	[Book_id] [int] NOT NULL,
 CONSTRAINT [PK_AUTHORBOOKS] PRIMARY KEY CLUSTERED 
(
	[Author_id] ASC,
	[Book_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BookCopies]    Script Date: 5/10/2023 9:51:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookCopies](
	[Copy_id] [int] NOT NULL,
	[Book_id] [int] NOT NULL,
	[Title] [varchar](45) NOT NULL,
	[Condition] [varchar](15) NULL,
	[Is_Available] [tinyint] NULL,
	[Is_Active] [tinyint] NULL,
 CONSTRAINT [PK_BOOKCOPIES] PRIMARY KEY CLUSTERED 
(
	[Copy_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Books]    Script Date: 5/10/2023 9:51:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Books](
	[Book_id] [int] NOT NULL,
	[Publisher_id] [int] NOT NULL,
	[Title] [varchar](45) NOT NULL,
	[Price] [decimal](6, 2) NOT NULL,
	[Published_Date] [date] NOT NULL,
	[ISBN] [char](13) NOT NULL,
 CONSTRAINT [PK_BOOKS] PRIMARY KEY CLUSTERED 
(
	[Book_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Books_Borrowed]    Script Date: 5/10/2023 9:51:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Books_Borrowed](
	[Borrowed_id] [int] NOT NULL,
	[Borrower_id] [int] NOT NULL,
	[Copy_id] [int] NOT NULL,
	[Borrowed_Date] [date] NOT NULL,
	[Due_Date] [date] NOT NULL,
	[Returned_Date] [date] NULL,
	[Card_id] [int] NOT NULL,
	[Is_Returned] [tinyint] NULL,
 CONSTRAINT [PK_BOOKSBORROWED] PRIMARY KEY CLUSTERED 
(
	[Borrowed_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Borrowers]    Script Date: 5/10/2023 9:51:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Borrowers](
	[Borrower_id] [int] NOT NULL,
	[First_Name] [varchar](15) NOT NULL,
	[Last_Name] [varchar](20) NOT NULL,
	[Address] [varchar](45) NULL,
	[Phone] [char](10) NULL,
	[Card_id] [int] NOT NULL,
	[Card_Issue_Date] [date] NOT NULL,
	[Is_Expired] [tinyint] NULL,
	[SSN] [char](9) NULL,
	[Balance_Due] [decimal](6, 2) NULL,
	[Lg_Name] [varchar](20) NULL,
	[Lg_Address] [varchar](45) NULL,
	[Lg_Phone] [char](10) NULL,
	[Birthdate] [date] NULL,
 CONSTRAINT [PK_BORROWERS] PRIMARY KEY CLUSTERED 
(
	[Borrower_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Branches]    Script Date: 5/10/2023 9:51:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Branches](
	[Branch_id] [int] NOT NULL,
	[Name] [varchar](25) NOT NULL,
	[Address] [varchar](45) NULL,
	[Phone] [char](10) NULL,
	[Fax] [char](10) NULL,
 CONSTRAINT [PK_BRANCHES] PRIMARY KEY CLUSTERED 
(
	[Branch_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 5/10/2023 9:51:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[Category_id] [int] NOT NULL,
	[Category_Type] [varchar](15) NULL,
 CONSTRAINT [PK_CATEGORIES] PRIMARY KEY CLUSTERED 
(
	[Category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories_Books]    Script Date: 5/10/2023 9:51:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories_Books](
	[Category_id] [int] NOT NULL,
	[Book_id] [int] NOT NULL,
 CONSTRAINT [PK_CATEGBOOKS] PRIMARY KEY CLUSTERED 
(
	[Category_id] ASC,
	[Book_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmpDegrees]    Script Date: 5/10/2023 9:51:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmpDegrees](
	[Degree_id] [int] NOT NULL,
	[Degree_Name] [varchar](20) NULL,
 CONSTRAINT [PK_EMPDEGREES] PRIMARY KEY CLUSTERED 
(
	[Degree_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee_Type]    Script Date: 5/10/2023 9:51:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee_Type](
	[EmpType_id] [int] NOT NULL,
	[EmpType_Name] [varchar](25) NULL,
 CONSTRAINT [PK_EMPLOYEETYPE] PRIMARY KEY CLUSTERED 
(
	[EmpType_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 5/10/2023 9:51:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[Employee_id] [int] NOT NULL,
	[Degree_id] [int] NOT NULL,
	[School_id] [int] NOT NULL,
	[Branch_id] [int] NOT NULL,
	[EmpType_id] [int] NOT NULL,
	[First_Name] [varchar](15) NOT NULL,
	[Last_Name] [varchar](20) NOT NULL,
	[Address] [varchar](45) NULL,
	[Birthdate] [date] NOT NULL,
	[HireDate] [date] NOT NULL,
	[Salary] [decimal](8, 2) NOT NULL,
	[Cell_Phone] [char](10) NULL,
	[Is_Head_Librarian] [tinyint] NOT NULL,
	[Degree_Date] [date] NULL,
	[Phone] [char](10) NULL,
	[Salary_Type] [varchar](10) NULL,
	[Vacation_Time] [int] NULL,
 CONSTRAINT [PK_EMPLOYEES] PRIMARY KEY CLUSTERED 
(
	[Employee_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Publishers]    Script Date: 5/10/2023 9:51:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publishers](
	[Publisher_id] [int] NOT NULL,
	[Publisher_Name] [varchar](40) NOT NULL,
	[Address] [varchar](45) NULL,
	[City] [varchar](15) NULL,
	[State] [char](2) NULL,
	[Contact_Name] [varchar](20) NOT NULL,
	[Contact_Phone] [char](10) NOT NULL,
	[Phone] [char](10) NULL,
 CONSTRAINT [PK_PUBLISHERS] PRIMARY KEY CLUSTERED 
(
	[Publisher_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Schools]    Script Date: 5/10/2023 9:51:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Schools](
	[School_id] [int] NOT NULL,
	[Schhol_Name] [varchar](100) NULL,
 CONSTRAINT [PK_SCHOOLS] PRIMARY KEY CLUSTERED 
(
	[School_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shift_Logins]    Script Date: 5/10/2023 9:51:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shift_Logins](
	[Login_id] [int] NOT NULL,
	[Employee_id] [int] NOT NULL,
	[Hours] [int] NOT NULL,
	[Shift_Date] [date] NOT NULL,
 CONSTRAINT [PK_SHIFT_LOGINS] PRIMARY KEY CLUSTERED 
(
	[Login_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[AUTHORS] ([Author_id], [Author_FName], [Author_LName], [Author_Phone], [Address], [City], [State], [Zip]) VALUES (172321176, N'Johnson', N'White', N'408 496-7223', N'10932 Bigge Rd.', N'Menlo Park', N'CA', N'94025')
INSERT [dbo].[AUTHORS] ([Author_id], [Author_FName], [Author_LName], [Author_Phone], [Address], [City], [State], [Zip]) VALUES (182528743, N'Joanne', N'Rowling', N'999 000-0000', N'3833, boulevard Beau Marchais', N'YATE', N'  ', N'99796')
INSERT [dbo].[AUTHORS] ([Author_id], [Author_FName], [Author_LName], [Author_Phone], [Address], [City], [State], [Zip]) VALUES (213468915, N'Marjorie', N'Green', N'415 986-7020', N'309 63rd St. #411', N'Oakland', N'CA', N'94618')
INSERT [dbo].[AUTHORS] ([Author_id], [Author_FName], [Author_LName], [Author_Phone], [Address], [City], [State], [Zip]) VALUES (238957766, N'Cheryl', N'Carson', N'415 548-7723', N'589 Darwin Ln.', N'Berkeley', N'CA', N'94705')
INSERT [dbo].[AUTHORS] ([Author_id], [Author_FName], [Author_LName], [Author_Phone], [Address], [City], [State], [Zip]) VALUES (254266712, N'Tolkien', N'J.R.R.', N'            ', N'448 Roanoke Dr.', N'London', NULL, N'99852')
INSERT [dbo].[AUTHORS] ([Author_id], [Author_FName], [Author_LName], [Author_Phone], [Address], [City], [State], [Zip]) VALUES (267412394, N'Michael', N'O''Leary', N'408 286-2428', N'22 Cleveland Av. #14', N'San Jose', N'CA', N'95128')
INSERT [dbo].[AUTHORS] ([Author_id], [Author_FName], [Author_LName], [Author_Phone], [Address], [City], [State], [Zip]) VALUES (274809391, N'Dean', N'Straight', N'415 834-2919', N'5420 College Av.', N'Oakland', N'CA', N'94609')
INSERT [dbo].[AUTHORS] ([Author_id], [Author_FName], [Author_LName], [Author_Phone], [Address], [City], [State], [Zip]) VALUES (341221782, N'Meander', N'Smith', N'913 843-0462', N'10 Mississippi Dr.', N'Lawrence', N'KS', N'66044')
INSERT [dbo].[AUTHORS] ([Author_id], [Author_FName], [Author_LName], [Author_Phone], [Address], [City], [State], [Zip]) VALUES (388607495, N'Joachim', N'Von Zur Gathen', N'000 000-0000', N'9918 Scottsdale Rd.', N'Bonn', NULL, N'99409')
INSERT [dbo].[AUTHORS] ([Author_id], [Author_FName], [Author_LName], [Author_Phone], [Address], [City], [State], [Zip]) VALUES (408408965, N'Daron', N'Acemoglu', N'999 000-0000', N'65, rue Faubourg St Antoine', N'Newton', N'MA', N'99402')
INSERT [dbo].[AUTHORS] ([Author_id], [Author_FName], [Author_LName], [Author_Phone], [Address], [City], [State], [Zip]) VALUES (409567008, N'Abraham', N'Bennet', N'415 658-9932', N'6223 Bateman St.', N'Berkeley', N'CA', N'94705')
INSERT [dbo].[AUTHORS] ([Author_id], [Author_FName], [Author_LName], [Author_Phone], [Address], [City], [State], [Zip]) VALUES (427172319, N'Ann', N'Dull', N'415 836-7128', N'3410 Blonde St.', N'Palo Alto', N'CA', N'94301')
INSERT [dbo].[AUTHORS] ([Author_id], [Author_FName], [Author_LName], [Author_Phone], [Address], [City], [State], [Zip]) VALUES (472272349, N'Burt', N'Gringlesby', N'707 938-6445', N'PO Box 792', N'Covelo', N'CA', N'95428')
INSERT [dbo].[AUTHORS] ([Author_id], [Author_FName], [Author_LName], [Author_Phone], [Address], [City], [State], [Zip]) VALUES (486291786, N'Charlene', N'Locksley', N'415 585-4620', N'18 Broadway Av.', N'San Francisco', N'CA', N'94130')
INSERT [dbo].[AUTHORS] ([Author_id], [Author_FName], [Author_LName], [Author_Phone], [Address], [City], [State], [Zip]) VALUES (527723246, N'Greene', N'Morningstar', N'615 297-2723', N'22 Graybar House Rd.', N'Nashville', N'TN', N'37215')
INSERT [dbo].[AUTHORS] ([Author_id], [Author_FName], [Author_LName], [Author_Phone], [Address], [City], [State], [Zip]) VALUES (648921872, N'Reginald', N'Blotchet-Halls', N'503 745-6402', N'55 Hillsdale Bl.', N'Corvallis', N'OR', N'97330')
INSERT [dbo].[AUTHORS] ([Author_id], [Author_FName], [Author_LName], [Author_Phone], [Address], [City], [State], [Zip]) VALUES (672713249, N'Akiko', N'Yokomoto', N'415 935-4228', N'3 Silver Ct.', N'Walnut Creek', N'CA', N'94595')
GO
INSERT [dbo].[Authors_Books] ([Author_id], [Book_id]) VALUES (172321176, 4371)
INSERT [dbo].[Authors_Books] ([Author_id], [Book_id]) VALUES (182528743, 1032)
INSERT [dbo].[Authors_Books] ([Author_id], [Book_id]) VALUES (182528743, 1111)
INSERT [dbo].[Authors_Books] ([Author_id], [Book_id]) VALUES (182528743, 2238)
INSERT [dbo].[Authors_Books] ([Author_id], [Book_id]) VALUES (182528743, 5671)
INSERT [dbo].[Authors_Books] ([Author_id], [Book_id]) VALUES (182528743, 6646)
INSERT [dbo].[Authors_Books] ([Author_id], [Book_id]) VALUES (182528743, 7832)
INSERT [dbo].[Authors_Books] ([Author_id], [Book_id]) VALUES (213468915, 1032)
INSERT [dbo].[Authors_Books] ([Author_id], [Book_id]) VALUES (213468915, 2075)
INSERT [dbo].[Authors_Books] ([Author_id], [Book_id]) VALUES (213468915, 3916)
INSERT [dbo].[Authors_Books] ([Author_id], [Book_id]) VALUES (238957766, 2238)
INSERT [dbo].[Authors_Books] ([Author_id], [Book_id]) VALUES (254266712, 1743)
INSERT [dbo].[Authors_Books] ([Author_id], [Book_id]) VALUES (254266712, 2222)
INSERT [dbo].[Authors_Books] ([Author_id], [Book_id]) VALUES (254266712, 3021)
INSERT [dbo].[Authors_Books] ([Author_id], [Book_id]) VALUES (254266712, 5727)
INSERT [dbo].[Authors_Books] ([Author_id], [Book_id]) VALUES (267412394, 1111)
INSERT [dbo].[Authors_Books] ([Author_id], [Book_id]) VALUES (274809391, 7832)
INSERT [dbo].[Authors_Books] ([Author_id], [Book_id]) VALUES (388607495, 4371)
GO
INSERT [dbo].[BookCopies] ([Copy_id], [Book_id], [Title], [Condition], [Is_Available], [Is_Active]) VALUES (201, 4371, N'Modern Computer Algebra', N'NEW', 1, 1)
INSERT [dbo].[BookCopies] ([Copy_id], [Book_id], [Title], [Condition], [Is_Available], [Is_Active]) VALUES (202, 5671, N'Why Nations Fail', N'Lost', 1, 0)
INSERT [dbo].[BookCopies] ([Copy_id], [Book_id], [Title], [Condition], [Is_Available], [Is_Active]) VALUES (203, 6646, N'Harry Potter', N'NEW', 1, 1)
INSERT [dbo].[BookCopies] ([Copy_id], [Book_id], [Title], [Condition], [Is_Available], [Is_Active]) VALUES (204, 1032, N'The Busy Executives Database Guide', N'GOOD', 1, 1)
INSERT [dbo].[BookCopies] ([Copy_id], [Book_id], [Title], [Condition], [Is_Available], [Is_Active]) VALUES (205, 1111, N'Cooking with Computers: Surreptitious Balance', N' Poor', 1, 0)
INSERT [dbo].[BookCopies] ([Copy_id], [Book_id], [Title], [Condition], [Is_Available], [Is_Active]) VALUES (206, 2075, N'You Can Combat Computer Stress!', N'NEW', 1, 1)
INSERT [dbo].[BookCopies] ([Copy_id], [Book_id], [Title], [Condition], [Is_Available], [Is_Active]) VALUES (207, 3916, N'Economic Origins of Dictatorship', N'EXCELLENT', 1, 1)
INSERT [dbo].[BookCopies] ([Copy_id], [Book_id], [Title], [Condition], [Is_Available], [Is_Active]) VALUES (208, 5727, N'The Fellowship of the Ring', N'NEW', 1, 1)
INSERT [dbo].[BookCopies] ([Copy_id], [Book_id], [Title], [Condition], [Is_Available], [Is_Active]) VALUES (209, 3916, N'Economic Origins of Dictatorship', N'Lost', 0, 0)
INSERT [dbo].[BookCopies] ([Copy_id], [Book_id], [Title], [Condition], [Is_Available], [Is_Active]) VALUES (210, 1743, N'The Hobbit', N'NEW', 1, 1)
INSERT [dbo].[BookCopies] ([Copy_id], [Book_id], [Title], [Condition], [Is_Available], [Is_Active]) VALUES (211, 2238, N'Harry Potter and the Half-Blood Prince', N'GOOD', 1, 1)
INSERT [dbo].[BookCopies] ([Copy_id], [Book_id], [Title], [Condition], [Is_Available], [Is_Active]) VALUES (212, 1111, N'Silicon Valley Gastronomic Treats', N' Poor', 1, 1)
INSERT [dbo].[BookCopies] ([Copy_id], [Book_id], [Title], [Condition], [Is_Available], [Is_Active]) VALUES (214, 2075, N'You Can Combat Computer Stress!', N'NEW', 0, 1)
INSERT [dbo].[BookCopies] ([Copy_id], [Book_id], [Title], [Condition], [Is_Available], [Is_Active]) VALUES (218, 3021, N'Gourmet Microwave', N'Poor', 1, 1)
INSERT [dbo].[BookCopies] ([Copy_id], [Book_id], [Title], [Condition], [Is_Available], [Is_Active]) VALUES (219, 2238, N'Silicon Valley Gastronomic Treats', N'NEW', 0, 1)
GO
INSERT [dbo].[Books] ([Book_id], [Publisher_id], [Title], [Price], [Published_Date], [ISBN]) VALUES (1032, 1389, N'The Busy Executive''s Database Guide', CAST(19.99 AS Decimal(6, 2)), CAST(N'1991-06-12' AS Date), N'9990999999994')
INSERT [dbo].[Books] ([Book_id], [Publisher_id], [Title], [Price], [Published_Date], [ISBN]) VALUES (1111, 1389, N'Cooking with Computers: Surreptitious Balance', CAST(11.95 AS Decimal(6, 2)), CAST(N'1991-06-09' AS Date), N'9990999999995')
INSERT [dbo].[Books] ([Book_id], [Publisher_id], [Title], [Price], [Published_Date], [ISBN]) VALUES (1743, 9910, N'The Hobbit', CAST(60.00 AS Decimal(6, 2)), CAST(N'1937-09-21' AS Date), N'9990999999988')
INSERT [dbo].[Books] ([Book_id], [Publisher_id], [Title], [Price], [Published_Date], [ISBN]) VALUES (2075, 736, N'You Can Combat Computer Stress!', CAST(82.99 AS Decimal(6, 2)), CAST(N'1991-06-30' AS Date), N'9990999999996')
INSERT [dbo].[Books] ([Book_id], [Publisher_id], [Title], [Price], [Published_Date], [ISBN]) VALUES (2222, 877, N'Silicon Valley Gastronomic Treats', CAST(19.99 AS Decimal(6, 2)), CAST(N'1991-06-09' AS Date), N'9990999999985')
INSERT [dbo].[Books] ([Book_id], [Publisher_id], [Title], [Price], [Published_Date], [ISBN]) VALUES (2238, 9913, N'Harry Potter and the Half-Blood Prince', CAST(45.00 AS Decimal(6, 2)), CAST(N'2005-07-16' AS Date), N'9990999999986')
INSERT [dbo].[Books] ([Book_id], [Publisher_id], [Title], [Price], [Published_Date], [ISBN]) VALUES (3021, 877, N'The Gourmet Microwave', CAST(26.99 AS Decimal(6, 2)), CAST(N'1991-06-18' AS Date), N'9990999999984')
INSERT [dbo].[Books] ([Book_id], [Publisher_id], [Title], [Price], [Published_Date], [ISBN]) VALUES (3916, 9912, N'Economic Origins of Dictatorship', CAST(30.00 AS Decimal(6, 2)), CAST(N'2012-09-01' AS Date), N'9990999999989')
INSERT [dbo].[Books] ([Book_id], [Publisher_id], [Title], [Price], [Published_Date], [ISBN]) VALUES (4371, 9912, N'Modern Computer Algebra', CAST(100.00 AS Decimal(6, 2)), CAST(N'2013-01-01' AS Date), N'9990999999999')
INSERT [dbo].[Books] ([Book_id], [Publisher_id], [Title], [Price], [Published_Date], [ISBN]) VALUES (5671, 9911, N'Why Nations Fail', CAST(70.00 AS Decimal(6, 2)), CAST(N'2012-03-20' AS Date), N'9990999999992')
INSERT [dbo].[Books] ([Book_id], [Publisher_id], [Title], [Price], [Published_Date], [ISBN]) VALUES (5727, 9910, N'The Fellowship of the Ring', CAST(40.00 AS Decimal(6, 2)), CAST(N'1954-08-29' AS Date), N'9990999999998')
INSERT [dbo].[Books] ([Book_id], [Publisher_id], [Title], [Price], [Published_Date], [ISBN]) VALUES (6646, 9913, N'Harry Potter', CAST(45.00 AS Decimal(6, 2)), CAST(N'1998-07-02' AS Date), N'9990999999993')
INSERT [dbo].[Books] ([Book_id], [Publisher_id], [Title], [Price], [Published_Date], [ISBN]) VALUES (7832, 1389, N'Straight Talk About Computers', CAST(19.99 AS Decimal(6, 2)), CAST(N'1996-08-01' AS Date), N'9990999999997')
GO
INSERT [dbo].[Books_Borrowed] ([Borrowed_id], [Borrower_id], [Copy_id], [Borrowed_Date], [Due_Date], [Returned_Date], [Card_id], [Is_Returned]) VALUES (1, 1, 201, CAST(N'2022-04-01' AS Date), CAST(N'2022-04-15' AS Date), CAST(N'2022-04-24' AS Date), 1, 1)
INSERT [dbo].[Books_Borrowed] ([Borrowed_id], [Borrower_id], [Copy_id], [Borrowed_Date], [Due_Date], [Returned_Date], [Card_id], [Is_Returned]) VALUES (2, 1, 209, CAST(N'2022-04-24' AS Date), CAST(N'2022-05-08' AS Date), CAST(N'2023-05-06' AS Date), 2, 1)
INSERT [dbo].[Books_Borrowed] ([Borrowed_id], [Borrower_id], [Copy_id], [Borrowed_Date], [Due_Date], [Returned_Date], [Card_id], [Is_Returned]) VALUES (3, 2, 211, CAST(N'2022-04-24' AS Date), CAST(N'2022-05-08' AS Date), NULL, 3, 0)
INSERT [dbo].[Books_Borrowed] ([Borrowed_id], [Borrower_id], [Copy_id], [Borrowed_Date], [Due_Date], [Returned_Date], [Card_id], [Is_Returned]) VALUES (4, 3, 202, CAST(N'2022-04-24' AS Date), CAST(N'2022-05-08' AS Date), NULL, 4, 0)
INSERT [dbo].[Books_Borrowed] ([Borrowed_id], [Borrower_id], [Copy_id], [Borrowed_Date], [Due_Date], [Returned_Date], [Card_id], [Is_Returned]) VALUES (5, 4, 204, CAST(N'2022-04-24' AS Date), CAST(N'2022-05-08' AS Date), CAST(N'2022-05-30' AS Date), 7, 0)
INSERT [dbo].[Books_Borrowed] ([Borrowed_id], [Borrower_id], [Copy_id], [Borrowed_Date], [Due_Date], [Returned_Date], [Card_id], [Is_Returned]) VALUES (6, 4, 201, CAST(N'2022-04-24' AS Date), CAST(N'2022-05-08' AS Date), NULL, 6, 0)
INSERT [dbo].[Books_Borrowed] ([Borrowed_id], [Borrower_id], [Copy_id], [Borrowed_Date], [Due_Date], [Returned_Date], [Card_id], [Is_Returned]) VALUES (8, 6, 204, CAST(N'2022-04-24' AS Date), CAST(N'2022-05-08' AS Date), CAST(N'2022-06-30' AS Date), 8, 0)
INSERT [dbo].[Books_Borrowed] ([Borrowed_id], [Borrower_id], [Copy_id], [Borrowed_Date], [Due_Date], [Returned_Date], [Card_id], [Is_Returned]) VALUES (12, 9, 212, CAST(N'2022-04-24' AS Date), CAST(N'2022-05-08' AS Date), NULL, 12, 0)
INSERT [dbo].[Books_Borrowed] ([Borrowed_id], [Borrower_id], [Copy_id], [Borrowed_Date], [Due_Date], [Returned_Date], [Card_id], [Is_Returned]) VALUES (13, 13, 205, CAST(N'2022-04-24' AS Date), CAST(N'2022-05-08' AS Date), CAST(N'2022-06-05' AS Date), 13, 0)
INSERT [dbo].[Books_Borrowed] ([Borrowed_id], [Borrower_id], [Copy_id], [Borrowed_Date], [Due_Date], [Returned_Date], [Card_id], [Is_Returned]) VALUES (14, 14, 214, CAST(N'2022-04-24' AS Date), CAST(N'2022-05-08' AS Date), CAST(N'2022-06-03' AS Date), 14, 1)
INSERT [dbo].[Books_Borrowed] ([Borrowed_id], [Borrower_id], [Copy_id], [Borrowed_Date], [Due_Date], [Returned_Date], [Card_id], [Is_Returned]) VALUES (15, 2, 207, CAST(N'2022-04-24' AS Date), CAST(N'2022-05-08' AS Date), NULL, 17, 0)
INSERT [dbo].[Books_Borrowed] ([Borrowed_id], [Borrower_id], [Copy_id], [Borrowed_Date], [Due_Date], [Returned_Date], [Card_id], [Is_Returned]) VALUES (17, 4, 211, CAST(N'2022-04-24' AS Date), CAST(N'2022-05-08' AS Date), NULL, 25, 0)
INSERT [dbo].[Books_Borrowed] ([Borrowed_id], [Borrower_id], [Copy_id], [Borrowed_Date], [Due_Date], [Returned_Date], [Card_id], [Is_Returned]) VALUES (19, 19, 219, CAST(N'2022-04-24' AS Date), CAST(N'2022-05-08' AS Date), NULL, 19, 0)
GO
INSERT [dbo].[Borrowers] ([Borrower_id], [First_Name], [Last_Name], [Address], [Phone], [Card_id], [Card_Issue_Date], [Is_Expired], [SSN], [Balance_Due], [Lg_Name], [Lg_Address], [Lg_Phone], [Birthdate]) VALUES (1, N'Victoria', N'Carlson', N'8871 Likins Ave.', N'2805550166', 1, CAST(N'2019-10-19' AS Date), 0, N'153322413', CAST(10.00 AS Decimal(6, 2)), N'Emily Brown', N'8871 Likins Ave.', N'2085550143', CAST(N'2007-05-01' AS Date))
INSERT [dbo].[Borrowers] ([Borrower_id], [First_Name], [Last_Name], [Address], [Phone], [Card_id], [Card_Issue_Date], [Is_Expired], [SSN], [Balance_Due], [Lg_Name], [Lg_Address], [Lg_Phone], [Birthdate]) VALUES (2, N'Lowell', N'Diaz', N'5452 Corte Gilberto', N'241852006 ', 2, CAST(N'2018-01-11' AS Date), 0, N'373316878', CAST(7.30 AS Decimal(6, 2)), NULL, NULL, NULL, CAST(N'1971-07-24' AS Date))
INSERT [dbo].[Borrowers] ([Borrower_id], [First_Name], [Last_Name], [Address], [Phone], [Card_id], [Card_Issue_Date], [Is_Expired], [SSN], [Balance_Due], [Lg_Name], [Lg_Address], [Lg_Phone], [Birthdate]) VALUES (3, N'Joshua', N'Shen', N'7538 Sherry Circle', N'517114000 ', 3, CAST(N'2013-08-24' AS Date), 0, N'334729174', CAST(8.00 AS Decimal(6, 2)), NULL, NULL, NULL, CAST(N'1978-01-29' AS Date))
INSERT [dbo].[Borrowers] ([Borrower_id], [First_Name], [Last_Name], [Address], [Phone], [Card_id], [Card_Issue_Date], [Is_Expired], [SSN], [Balance_Due], [Lg_Name], [Lg_Address], [Lg_Phone], [Birthdate]) VALUES (4, N'Franklin', N'Hughes', N'7185 St George Dr', N'801516015 ', 4, CAST(N'2018-01-21' AS Date), 0, N'770979140', CAST(0.00 AS Decimal(6, 2)), NULL, NULL, NULL, CAST(N'1956-01-16' AS Date))
INSERT [dbo].[Borrowers] ([Borrower_id], [First_Name], [Last_Name], [Address], [Phone], [Card_id], [Card_Issue_Date], [Is_Expired], [SSN], [Balance_Due], [Lg_Name], [Lg_Address], [Lg_Phone], [Birthdate]) VALUES (5, N'Andy', N'Green', N'2615 Berrier Dr', N'262841299 ', 15, CAST(N'2021-11-19' AS Date), 0, N'551995067', CAST(59.00 AS Decimal(6, 2)), NULL, NULL, NULL, CAST(N'1988-05-16' AS Date))
INSERT [dbo].[Borrowers] ([Borrower_id], [First_Name], [Last_Name], [Address], [Phone], [Card_id], [Card_Issue_Date], [Is_Expired], [SSN], [Balance_Due], [Lg_Name], [Lg_Address], [Lg_Phone], [Birthdate]) VALUES (6, N'Karen', N'Serrano', N'2226 Cleveland Avenue', N'839872833 ', 6, CAST(N'2014-06-25' AS Date), 0, N'660783774', CAST(0.00 AS Decimal(6, 2)), NULL, NULL, NULL, CAST(N'1977-01-10' AS Date))
INSERT [dbo].[Borrowers] ([Borrower_id], [First_Name], [Last_Name], [Address], [Phone], [Card_id], [Card_Issue_Date], [Is_Expired], [SSN], [Balance_Due], [Lg_Name], [Lg_Address], [Lg_Phone], [Birthdate]) VALUES (8, N'Alicia', N'Salanki', N'1440 Willow Pass Dr.', N'8789-2932 ', 8, CAST(N'2017-08-06' AS Date), 0, N'251368918', CAST(8.10 AS Decimal(6, 2)), NULL, NULL, NULL, CAST(N'1977-09-13' AS Date))
INSERT [dbo].[Borrowers] ([Borrower_id], [First_Name], [Last_Name], [Address], [Phone], [Card_id], [Card_Issue_Date], [Is_Expired], [SSN], [Balance_Due], [Lg_Name], [Lg_Address], [Lg_Phone], [Birthdate]) VALUES (9, N'Timothy', N'Hayes', N'55, rue de Courtaboeuf', N'475447331 ', 9, CAST(N'2014-01-18' AS Date), 0, N'415103694', CAST(55.00 AS Decimal(6, 2)), NULL, NULL, NULL, CAST(N'1988-03-14' AS Date))
INSERT [dbo].[Borrowers] ([Borrower_id], [First_Name], [Last_Name], [Address], [Phone], [Card_id], [Card_Issue_Date], [Is_Expired], [SSN], [Balance_Due], [Lg_Name], [Lg_Address], [Lg_Phone], [Birthdate]) VALUES (10, N'Reginald', N'Liu', N'8467 Clifford Court', N'437557353 ', 10, CAST(N'2015-02-09' AS Date), 0, N'236519575', CAST(2.80 AS Decimal(6, 2)), NULL, NULL, NULL, CAST(N'1972-09-17' AS Date))
INSERT [dbo].[Borrowers] ([Borrower_id], [First_Name], [Last_Name], [Address], [Phone], [Card_id], [Card_Issue_Date], [Is_Expired], [SSN], [Balance_Due], [Lg_Name], [Lg_Address], [Lg_Phone], [Birthdate]) VALUES (11, N'Tabitha', N'Patel', N'9, rue Saint-Lazare', N'772922209 ', 11, CAST(N'2015-01-17' AS Date), 0, N'523828357', CAST(0.00 AS Decimal(6, 2)), NULL, NULL, NULL, CAST(N'1984-12-08' AS Date))
INSERT [dbo].[Borrowers] ([Borrower_id], [First_Name], [Last_Name], [Address], [Phone], [Card_id], [Card_Issue_Date], [Is_Expired], [SSN], [Balance_Due], [Lg_Name], [Lg_Address], [Lg_Phone], [Birthdate]) VALUES (12, N'Dwayne', N'Henderson', N'2973 Cardinal Drive', N'928578369 ', 12, CAST(N'2017-01-15' AS Date), 0, N'221376992', CAST(18.00 AS Decimal(6, 2)), NULL, NULL, NULL, CAST(N'1971-09-11' AS Date))
INSERT [dbo].[Borrowers] ([Borrower_id], [First_Name], [Last_Name], [Address], [Phone], [Card_id], [Card_Issue_Date], [Is_Expired], [SSN], [Balance_Due], [Lg_Name], [Lg_Address], [Lg_Phone], [Birthdate]) VALUES (13, N'Zoe', N'Luo', N'464 Ahneita Dr.', N'493848116 ', 13, CAST(N'2012-05-13' AS Date), 0, N'672478652', CAST(0.00 AS Decimal(6, 2)), NULL, NULL, NULL, CAST(N'1977-04-16' AS Date))
INSERT [dbo].[Borrowers] ([Borrower_id], [First_Name], [Last_Name], [Address], [Phone], [Card_id], [Card_Issue_Date], [Is_Expired], [SSN], [Balance_Due], [Lg_Name], [Lg_Address], [Lg_Phone], [Birthdate]) VALUES (14, N'Brad', N'Guo', N'Heiderweg 4284', N'569514445 ', 14, CAST(N'2011-11-07' AS Date), 0, N'199862277', CAST(0.00 AS Decimal(6, 2)), NULL, NULL, NULL, CAST(N'1985-09-23' AS Date))
INSERT [dbo].[Borrowers] ([Borrower_id], [First_Name], [Last_Name], [Address], [Phone], [Card_id], [Card_Issue_Date], [Is_Expired], [SSN], [Balance_Due], [Lg_Name], [Lg_Address], [Lg_Phone], [Birthdate]) VALUES (18, N'Andi', N'White', N'7289 St George Drive', N'801514014 ', 18, CAST(N'2014-08-24' AS Date), 0, N'372316876', CAST(0.00 AS Decimal(6, 2)), NULL, NULL, NULL, CAST(N'1978-01-12' AS Date))
INSERT [dbo].[Borrowers] ([Borrower_id], [First_Name], [Last_Name], [Address], [Phone], [Card_id], [Card_Issue_Date], [Is_Expired], [SSN], [Balance_Due], [Lg_Name], [Lg_Address], [Lg_Phone], [Birthdate]) VALUES (19, N'Angela', N'White', N'7189 St George Dr', N'801516014 ', 19, CAST(N'2013-08-24' AS Date), 0, N'373316876', CAST(0.00 AS Decimal(6, 2)), NULL, NULL, NULL, CAST(N'1977-01-12' AS Date))
INSERT [dbo].[Borrowers] ([Borrower_id], [First_Name], [Last_Name], [Address], [Phone], [Card_id], [Card_Issue_Date], [Is_Expired], [SSN], [Balance_Due], [Lg_Name], [Lg_Address], [Lg_Phone], [Birthdate]) VALUES (20, N'Amanda', N'Pandora', N'4532 st Almando', N'345909432 ', 20, CAST(N'2012-03-04' AS Date), 1, N'348985345', CAST(50.00 AS Decimal(6, 2)), NULL, NULL, NULL, CAST(N'1985-05-02' AS Date))
INSERT [dbo].[Borrowers] ([Borrower_id], [First_Name], [Last_Name], [Address], [Phone], [Card_id], [Card_Issue_Date], [Is_Expired], [SSN], [Balance_Due], [Lg_Name], [Lg_Address], [Lg_Phone], [Birthdate]) VALUES (21, N'Alex', N'Persy', N'4534 st Almando', N'345909433 ', 21, CAST(N'2016-03-04' AS Date), 0, N'348985335', CAST(0.00 AS Decimal(6, 2)), NULL, NULL, NULL, CAST(N'2017-05-02' AS Date))
INSERT [dbo].[Borrowers] ([Borrower_id], [First_Name], [Last_Name], [Address], [Phone], [Card_id], [Card_Issue_Date], [Is_Expired], [SSN], [Balance_Due], [Lg_Name], [Lg_Address], [Lg_Phone], [Birthdate]) VALUES (22, N'Alexa', N'Perish', N'4535 st Almando', N'345905633 ', 22, CAST(N'2016-03-04' AS Date), 1, N'328985335', CAST(0.00 AS Decimal(6, 2)), NULL, NULL, NULL, CAST(N'2017-05-02' AS Date))
GO
INSERT [dbo].[Branches] ([Branch_id], [Name], [Address], [Phone], [Fax]) VALUES (1, N'Brooklyn', N'10 Grand Army Plaza', N'7182302100', NULL)
INSERT [dbo].[Branches] ([Branch_id], [Name], [Address], [Phone], [Fax]) VALUES (2, N'Central Valley', N'8871 Likins Ave.', N'9995550198', NULL)
INSERT [dbo].[Branches] ([Branch_id], [Name], [Address], [Phone], [Fax]) VALUES (3, N'Cheektowaga', N'7779 Merry Drive', N'9995550183', NULL)
INSERT [dbo].[Branches] ([Branch_id], [Name], [Address], [Phone], [Fax]) VALUES (4, N'Clay', N'6837 Pirate Lane', N'9995550155', NULL)
INSERT [dbo].[Branches] ([Branch_id], [Name], [Address], [Phone], [Fax]) VALUES (5, N'Valley Stream', N'Green Acres Mall', N'9995550152', NULL)
INSERT [dbo].[Branches] ([Branch_id], [Name], [Address], [Phone], [Fax]) VALUES (6, N'Ithaca', N'Pyramid Mall', N'9995550149', NULL)
INSERT [dbo].[Branches] ([Branch_id], [Name], [Address], [Phone], [Fax]) VALUES (7, N'Lake George', N'Adirondack Factory Outlet', N'9995550133', NULL)
INSERT [dbo].[Branches] ([Branch_id], [Name], [Address], [Phone], [Fax]) VALUES (8, N'De Witt', N'6405 Erie Blvd. Hills Plaza', N'9995550126', NULL)
INSERT [dbo].[Branches] ([Branch_id], [Name], [Address], [Phone], [Fax]) VALUES (9, N'New Hartford', N'7505 Commercial Dr.', N'9995550111', NULL)
INSERT [dbo].[Branches] ([Branch_id], [Name], [Address], [Phone], [Fax]) VALUES (10, N'New York', N'123 Union Square South', N'9985550194', NULL)
GO
INSERT [dbo].[Categories] ([Category_id], [Category_Type]) VALUES (1, N'Fiction')
INSERT [dbo].[Categories] ([Category_id], [Category_Type]) VALUES (2, N'Mystery')
INSERT [dbo].[Categories] ([Category_id], [Category_Type]) VALUES (3, N'Science fiction')
INSERT [dbo].[Categories] ([Category_id], [Category_Type]) VALUES (4, N'Juvenile')
INSERT [dbo].[Categories] ([Category_id], [Category_Type]) VALUES (5, N'Reference')
INSERT [dbo].[Categories] ([Category_id], [Category_Type]) VALUES (6, N'Adult')
INSERT [dbo].[Categories] ([Category_id], [Category_Type]) VALUES (7, N'Business')
INSERT [dbo].[Categories] ([Category_id], [Category_Type]) VALUES (11, N'Epic Fantasy')
INSERT [dbo].[Categories] ([Category_id], [Category_Type]) VALUES (12, N'Fantasy')
INSERT [dbo].[Categories] ([Category_id], [Category_Type]) VALUES (13, N'High Fantasy')
INSERT [dbo].[Categories] ([Category_id], [Category_Type]) VALUES (14, N'Mod_cook')
INSERT [dbo].[Categories] ([Category_id], [Category_Type]) VALUES (16, N'Popular_comp')
INSERT [dbo].[Categories] ([Category_id], [Category_Type]) VALUES (17, N'Psychology')
INSERT [dbo].[Categories] ([Category_id], [Category_Type]) VALUES (18, N'Trad_cook')
INSERT [dbo].[Categories] ([Category_id], [Category_Type]) VALUES (19, N'Adventure')
INSERT [dbo].[Categories] ([Category_id], [Category_Type]) VALUES (20, N'Thriller')
INSERT [dbo].[Categories] ([Category_id], [Category_Type]) VALUES (21, N'Romance')
INSERT [dbo].[Categories] ([Category_id], [Category_Type]) VALUES (22, N'Westerns')
INSERT [dbo].[Categories] ([Category_id], [Category_Type]) VALUES (23, N'Dystopian')
GO
INSERT [dbo].[Categories_Books] ([Category_id], [Book_id]) VALUES (1, 6646)
INSERT [dbo].[Categories_Books] ([Category_id], [Book_id]) VALUES (2, 4371)
INSERT [dbo].[Categories_Books] ([Category_id], [Book_id]) VALUES (3, 1032)
INSERT [dbo].[Categories_Books] ([Category_id], [Book_id]) VALUES (5, 3916)
INSERT [dbo].[Categories_Books] ([Category_id], [Book_id]) VALUES (5, 5671)
INSERT [dbo].[Categories_Books] ([Category_id], [Book_id]) VALUES (6, 7832)
INSERT [dbo].[Categories_Books] ([Category_id], [Book_id]) VALUES (7, 1111)
INSERT [dbo].[Categories_Books] ([Category_id], [Book_id]) VALUES (7, 1743)
INSERT [dbo].[Categories_Books] ([Category_id], [Book_id]) VALUES (11, 2238)
INSERT [dbo].[Categories_Books] ([Category_id], [Book_id]) VALUES (12, 3021)
GO
INSERT [dbo].[EmpDegrees] ([Degree_id], [Degree_Name]) VALUES (1, N'Bach Deg in Lib Sci')
INSERT [dbo].[EmpDegrees] ([Degree_id], [Degree_Name]) VALUES (2, N'Ms Deg in Lib Sci')
INSERT [dbo].[EmpDegrees] ([Degree_id], [Degree_Name]) VALUES (3, N'Online Ms of Lib Sci')
INSERT [dbo].[EmpDegrees] ([Degree_id], [Degree_Name]) VALUES (4, N'Grad Cert in Lib Sci')
INSERT [dbo].[EmpDegrees] ([Degree_id], [Degree_Name]) VALUES (999, N'Other')
GO
INSERT [dbo].[Employee_Type] ([EmpType_id], [EmpType_Name]) VALUES (1, N'Librarian')
INSERT [dbo].[Employee_Type] ([EmpType_id], [EmpType_Name]) VALUES (2, N'Network Admnstr')
INSERT [dbo].[Employee_Type] ([EmpType_id], [EmpType_Name]) VALUES (3, N'Computer Prog.')
INSERT [dbo].[Employee_Type] ([EmpType_id], [EmpType_Name]) VALUES (4, N'IT Manager')
INSERT [dbo].[Employee_Type] ([EmpType_id], [EmpType_Name]) VALUES (5, N'Floor Manager')
INSERT [dbo].[Employee_Type] ([EmpType_id], [EmpType_Name]) VALUES (6, N'Custodian')
INSERT [dbo].[Employee_Type] ([EmpType_id], [EmpType_Name]) VALUES (7, N'Accountant')
INSERT [dbo].[Employee_Type] ([EmpType_id], [EmpType_Name]) VALUES (8, N'Data Analyst')
GO
INSERT [dbo].[Employees] ([Employee_id], [Degree_id], [School_id], [Branch_id], [EmpType_id], [First_Name], [Last_Name], [Address], [Birthdate], [HireDate], [Salary], [Cell_Phone], [Is_Head_Librarian], [Degree_Date], [Phone], [Salary_Type], [Vacation_Time]) VALUES (1, 1, 1, 1, 1, N'Tammy', N'Williams', N'7072 Meadow Lane', CAST(N'1973-08-04' AS Date), CAST(N'2015-01-20' AS Date), CAST(70000.00 AS Decimal(8, 2)), N'963434339 ', 0, CAST(N'2012-04-09' AS Date), N'925667082 ', N'Salaried', 14)
INSERT [dbo].[Employees] ([Employee_id], [Degree_id], [School_id], [Branch_id], [EmpType_id], [First_Name], [Last_Name], [Address], [Birthdate], [HireDate], [Salary], [Cell_Phone], [Is_Head_Librarian], [Degree_Date], [Phone], [Salary_Type], [Vacation_Time]) VALUES (2, 2, 2, 1, 1, N'Charles', N'Doe', N'Po Box 25484', CAST(N'1975-03-17' AS Date), CAST(N'2019-09-04' AS Date), CAST(90000.00 AS Decimal(8, 2)), N'166201609 ', 1, CAST(N'2014-06-06' AS Date), N'649504581 ', N'Salaried', 14)
INSERT [dbo].[Employees] ([Employee_id], [Degree_id], [School_id], [Branch_id], [EmpType_id], [First_Name], [Last_Name], [Address], [Birthdate], [HireDate], [Salary], [Cell_Phone], [Is_Head_Librarian], [Degree_Date], [Phone], [Salary_Type], [Vacation_Time]) VALUES (3, 1, 2, 2, 1, N'Sarah', N'Taylor', N'8474 Haynes Court', CAST(N'1980-12-25' AS Date), CAST(N'2019-04-19' AS Date), CAST(70000.00 AS Decimal(8, 2)), N'213572363 ', 0, CAST(N'2013-01-01' AS Date), N'175679063 ', N'Salaried', 14)
INSERT [dbo].[Employees] ([Employee_id], [Degree_id], [School_id], [Branch_id], [EmpType_id], [First_Name], [Last_Name], [Address], [Birthdate], [HireDate], [Salary], [Cell_Phone], [Is_Head_Librarian], [Degree_Date], [Phone], [Salary_Type], [Vacation_Time]) VALUES (4, 1, 5, 2, 1, N'Morgan', N'Butler', N'Haberstr 123', CAST(N'1970-12-23' AS Date), CAST(N'2011-07-09' AS Date), CAST(60000.00 AS Decimal(8, 2)), N'215142820 ', 0, CAST(N'2014-09-05' AS Date), N'650752184 ', N'Salaried', 20)
INSERT [dbo].[Employees] ([Employee_id], [Degree_id], [School_id], [Branch_id], [EmpType_id], [First_Name], [Last_Name], [Address], [Birthdate], [HireDate], [Salary], [Cell_Phone], [Is_Head_Librarian], [Degree_Date], [Phone], [Salary_Type], [Vacation_Time]) VALUES (6, 3, 6, 3, 1, N'Cameron', N'Smith', N'22, De Schengen', CAST(N'1984-12-08' AS Date), CAST(N'2015-05-14' AS Date), CAST(95000.00 AS Decimal(8, 2)), N'534367483 ', 1, CAST(N'2016-08-09' AS Date), N'583203406 ', N'Salaried', 14)
INSERT [dbo].[Employees] ([Employee_id], [Degree_id], [School_id], [Branch_id], [EmpType_id], [First_Name], [Last_Name], [Address], [Birthdate], [HireDate], [Salary], [Cell_Phone], [Is_Head_Librarian], [Degree_Date], [Phone], [Salary_Type], [Vacation_Time]) VALUES (7, 3, 6, 2, 1, N'Alan', N'Pit', N'Rosemont 5538', CAST(N'1985-09-23' AS Date), CAST(N'2013-09-16' AS Date), CAST(65000.00 AS Decimal(8, 2)), N'986451303 ', 0, CAST(N'2017-01-09' AS Date), N'337419071 ', N'Salaried', 14)
INSERT [dbo].[Employees] ([Employee_id], [Degree_id], [School_id], [Branch_id], [EmpType_id], [First_Name], [Last_Name], [Address], [Birthdate], [HireDate], [Salary], [Cell_Phone], [Is_Head_Librarian], [Degree_Date], [Phone], [Salary_Type], [Vacation_Time]) VALUES (8, 1, 7, 2, 1, N'Chloe', N'Kane', N'4845 Lighthouse Road', CAST(N'1986-09-13' AS Date), CAST(N'2014-09-05' AS Date), CAST(68000.00 AS Decimal(8, 2)), N'655685935 ', 0, CAST(N'2018-10-11' AS Date), N'600291348 ', N'Salaried', 14)
INSERT [dbo].[Employees] ([Employee_id], [Degree_id], [School_id], [Branch_id], [EmpType_id], [First_Name], [Last_Name], [Address], [Birthdate], [HireDate], [Salary], [Cell_Phone], [Is_Head_Librarian], [Degree_Date], [Phone], [Salary_Type], [Vacation_Time]) VALUES (9, 3, 8, 4, 1, N'Tommy', N'Cane', N'6514 Morello Avenue', CAST(N'1967-03-02' AS Date), CAST(N'2013-06-12' AS Date), CAST(88000.00 AS Decimal(8, 2)), N'372229036 ', 1, CAST(N'2019-10-11' AS Date), N'523162966 ', N'Salaried', 14)
INSERT [dbo].[Employees] ([Employee_id], [Degree_id], [School_id], [Branch_id], [EmpType_id], [First_Name], [Last_Name], [Address], [Birthdate], [HireDate], [Salary], [Cell_Phone], [Is_Head_Librarian], [Degree_Date], [Phone], [Salary_Type], [Vacation_Time]) VALUES (10, 3, 3, 5, 1, N'Rick', N'Baker', N'6239 Monti Street', CAST(N'1990-10-07' AS Date), CAST(N'2021-10-21' AS Date), CAST(85000.00 AS Decimal(8, 2)), N'737454710 ', 1, CAST(N'2016-10-15' AS Date), N'33491501  ', N'Salaried', 14)
INSERT [dbo].[Employees] ([Employee_id], [Degree_id], [School_id], [Branch_id], [EmpType_id], [First_Name], [Last_Name], [Address], [Birthdate], [HireDate], [Salary], [Cell_Phone], [Is_Head_Librarian], [Degree_Date], [Phone], [Salary_Type], [Vacation_Time]) VALUES (11, 999, 9999, 10, 6, N'Grace', N'Flores', N'2025 Greenwood Ct', CAST(N'1975-12-21' AS Date), CAST(N'2019-04-23' AS Date), CAST(21.00 AS Decimal(8, 2)), N'8638638634', 0, CAST(N'1900-01-01' AS Date), N'7047047043', N'Hourly', 14)
INSERT [dbo].[Employees] ([Employee_id], [Degree_id], [School_id], [Branch_id], [EmpType_id], [First_Name], [Last_Name], [Address], [Birthdate], [HireDate], [Salary], [Cell_Phone], [Is_Head_Librarian], [Degree_Date], [Phone], [Salary_Type], [Vacation_Time]) VALUES (13, 999, 9999, 8, 6, N'Karla', N'Wu', N'7554 Grammercy Lane', CAST(N'1986-09-07' AS Date), CAST(N'2013-03-01' AS Date), CAST(21.00 AS Decimal(8, 2)), N'5255255252', 0, CAST(N'1900-01-01' AS Date), N'1231231239', N'Hourly', 14)
INSERT [dbo].[Employees] ([Employee_id], [Degree_id], [School_id], [Branch_id], [EmpType_id], [First_Name], [Last_Name], [Address], [Birthdate], [HireDate], [Salary], [Cell_Phone], [Is_Head_Librarian], [Degree_Date], [Phone], [Salary_Type], [Vacation_Time]) VALUES (14, 999, 9999, 7, 6, N'Lauren', N'Rodriguez', N'25300 Biddle Road', CAST(N'1978-06-26' AS Date), CAST(N'1993-11-02' AS Date), CAST(21.00 AS Decimal(8, 2)), N'7897897891', 0, CAST(N'1900-01-01' AS Date), N'6386386387', N'Hourly', 30)
INSERT [dbo].[Employees] ([Employee_id], [Degree_id], [School_id], [Branch_id], [EmpType_id], [First_Name], [Last_Name], [Address], [Birthdate], [HireDate], [Salary], [Cell_Phone], [Is_Head_Librarian], [Degree_Date], [Phone], [Salary_Type], [Vacation_Time]) VALUES (15, 999, 9999, 6, 6, N'Maria', N'Bright', N'9759 Dover Way', CAST(N'1985-11-24' AS Date), CAST(N'2016-03-06' AS Date), CAST(21.00 AS Decimal(8, 2)), N'2192192193', 0, CAST(N'1900-01-01' AS Date), N'538385382 ', N'Hourly', 14)
GO
INSERT [dbo].[Publishers] ([Publisher_id], [Publisher_Name], [Address], [City], [State], [Contact_Name], [Contact_Phone], [Phone]) VALUES (736, N'New Moon Books', NULL, N'Boston', N'MA', N'Alisha Meyer', N'1235467895', NULL)
INSERT [dbo].[Publishers] ([Publisher_id], [Publisher_Name], [Address], [City], [State], [Contact_Name], [Contact_Phone], [Phone]) VALUES (877, N'Binnet & Hardley', NULL, N'Washington', N'DC', N'Andy Rivas', N'6785486579', NULL)
INSERT [dbo].[Publishers] ([Publisher_id], [Publisher_Name], [Address], [City], [State], [Contact_Name], [Contact_Phone], [Phone]) VALUES (1389, N'Algodata Infosystems', NULL, N'Berkeley', N'CA', N'Mindy Main', N'3745685456', NULL)
INSERT [dbo].[Publishers] ([Publisher_id], [Publisher_Name], [Address], [City], [State], [Contact_Name], [Contact_Phone], [Phone]) VALUES (1622, N'Five Lakes Publishing', NULL, N'Chicago', N'IL', N'Velicity Metham', N'1234325678', NULL)
INSERT [dbo].[Publishers] ([Publisher_id], [Publisher_Name], [Address], [City], [State], [Contact_Name], [Contact_Phone], [Phone]) VALUES (1756, N'Ramona Publishers', NULL, N'Dallas', N'TX', N'Vicki Chase', N'7865435678', NULL)
INSERT [dbo].[Publishers] ([Publisher_id], [Publisher_Name], [Address], [City], [State], [Contact_Name], [Contact_Phone], [Phone]) VALUES (9910, N'Allen & Unwin', NULL, N'London', NULL, N'Carol Goldiva', N'2357643876', NULL)
INSERT [dbo].[Publishers] ([Publisher_id], [Publisher_Name], [Address], [City], [State], [Contact_Name], [Contact_Phone], [Phone]) VALUES (9911, N'Crown Publishing Group', NULL, N'New York City', N'NY', N'Henry Ford', N'1235467976', NULL)
INSERT [dbo].[Publishers] ([Publisher_id], [Publisher_Name], [Address], [City], [State], [Contact_Name], [Contact_Phone], [Phone]) VALUES (9912, N'Cambridge University Press', NULL, N'Cambridge', NULL, N'Helen Minx', N'3465738745', NULL)
INSERT [dbo].[Publishers] ([Publisher_id], [Publisher_Name], [Address], [City], [State], [Contact_Name], [Contact_Phone], [Phone]) VALUES (9913, N'Bloomsbury Publishing', NULL, N'London', N'  ', N'Hendrix Mus', N'5768547385', NULL)
GO
INSERT [dbo].[Schools] ([School_id], [Schhol_Name]) VALUES (1, N'Touro University')
INSERT [dbo].[Schools] ([School_id], [Schhol_Name]) VALUES (2, N'University of North Carolina at Chapel Hill')
INSERT [dbo].[Schools] ([School_id], [Schhol_Name]) VALUES (3, N'University of Washington')
INSERT [dbo].[Schools] ([School_id], [Schhol_Name]) VALUES (4, N'University of Maryland at College Park')
INSERT [dbo].[Schools] ([School_id], [Schhol_Name]) VALUES (5, N'University of Texas at Austin')
INSERT [dbo].[Schools] ([School_id], [Schhol_Name]) VALUES (6, N'The State University of New Jersey at New Brunswick')
INSERT [dbo].[Schools] ([School_id], [Schhol_Name]) VALUES (7, N'Syracuse University')
INSERT [dbo].[Schools] ([School_id], [Schhol_Name]) VALUES (8, N'University of Illinois at Urbana-Champaign')
INSERT [dbo].[Schools] ([School_id], [Schhol_Name]) VALUES (9999, N'Other')
GO
INSERT [dbo].[Shift_Logins] ([Login_id], [Employee_id], [Hours], [Shift_Date]) VALUES (1000, 1, 33, CAST(N'2022-05-04' AS Date))
INSERT [dbo].[Shift_Logins] ([Login_id], [Employee_id], [Hours], [Shift_Date]) VALUES (1001, 2, 32, CAST(N'2022-04-04' AS Date))
INSERT [dbo].[Shift_Logins] ([Login_id], [Employee_id], [Hours], [Shift_Date]) VALUES (1002, 3, 34, CAST(N'2022-03-04' AS Date))
INSERT [dbo].[Shift_Logins] ([Login_id], [Employee_id], [Hours], [Shift_Date]) VALUES (1003, 4, 32, CAST(N'2022-04-02' AS Date))
INSERT [dbo].[Shift_Logins] ([Login_id], [Employee_id], [Hours], [Shift_Date]) VALUES (1005, 6, 39, CAST(N'2022-04-08' AS Date))
INSERT [dbo].[Shift_Logins] ([Login_id], [Employee_id], [Hours], [Shift_Date]) VALUES (1006, 7, 31, CAST(N'2022-02-06' AS Date))
INSERT [dbo].[Shift_Logins] ([Login_id], [Employee_id], [Hours], [Shift_Date]) VALUES (1007, 8, 25, CAST(N'2022-06-04' AS Date))
INSERT [dbo].[Shift_Logins] ([Login_id], [Employee_id], [Hours], [Shift_Date]) VALUES (1008, 9, 39, CAST(N'2022-08-08' AS Date))
INSERT [dbo].[Shift_Logins] ([Login_id], [Employee_id], [Hours], [Shift_Date]) VALUES (1009, 10, 31, CAST(N'2022-03-06' AS Date))
INSERT [dbo].[Shift_Logins] ([Login_id], [Employee_id], [Hours], [Shift_Date]) VALUES (1010, 11, 25, CAST(N'2022-06-06' AS Date))
INSERT [dbo].[Shift_Logins] ([Login_id], [Employee_id], [Hours], [Shift_Date]) VALUES (1011, 13, 39, CAST(N'2022-08-06' AS Date))
INSERT [dbo].[Shift_Logins] ([Login_id], [Employee_id], [Hours], [Shift_Date]) VALUES (1012, 14, 31, CAST(N'2022-03-02' AS Date))
INSERT [dbo].[Shift_Logins] ([Login_id], [Employee_id], [Hours], [Shift_Date]) VALUES (1013, 15, 30, CAST(N'2022-09-02' AS Date))
INSERT [dbo].[Shift_Logins] ([Login_id], [Employee_id], [Hours], [Shift_Date]) VALUES (1014, 15, 23, CAST(N'2023-05-08' AS Date))
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UIX_BOOKS1]    Script Date: 5/10/2023 9:51:26 AM ******/
ALTER TABLE [dbo].[Books] ADD  CONSTRAINT [UIX_BOOKS1] UNIQUE NONCLUSTERED 
(
	[ISBN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UIX_BORROWES1]    Script Date: 5/10/2023 9:51:26 AM ******/
ALTER TABLE [dbo].[Borrowers] ADD  CONSTRAINT [UIX_BORROWES1] UNIQUE NONCLUSTERED 
(
	[SSN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Authors_Books]  WITH CHECK ADD  CONSTRAINT [FK_AUTHORBOOKS1] FOREIGN KEY([Author_id])
REFERENCES [dbo].[AUTHORS] ([Author_id])
GO
ALTER TABLE [dbo].[Authors_Books] CHECK CONSTRAINT [FK_AUTHORBOOKS1]
GO
ALTER TABLE [dbo].[Authors_Books]  WITH CHECK ADD  CONSTRAINT [FK_BUILDOWNERS] FOREIGN KEY([Book_id])
REFERENCES [dbo].[Books] ([Book_id])
GO
ALTER TABLE [dbo].[Authors_Books] CHECK CONSTRAINT [FK_BUILDOWNERS]
GO
ALTER TABLE [dbo].[BookCopies]  WITH CHECK ADD  CONSTRAINT [FK_BOOKCOPIES1] FOREIGN KEY([Book_id])
REFERENCES [dbo].[Books] ([Book_id])
GO
ALTER TABLE [dbo].[BookCopies] CHECK CONSTRAINT [FK_BOOKCOPIES1]
GO
ALTER TABLE [dbo].[Books]  WITH CHECK ADD  CONSTRAINT [FK_BOOKS1] FOREIGN KEY([Publisher_id])
REFERENCES [dbo].[Publishers] ([Publisher_id])
GO
ALTER TABLE [dbo].[Books] CHECK CONSTRAINT [FK_BOOKS1]
GO
ALTER TABLE [dbo].[Books_Borrowed]  WITH CHECK ADD  CONSTRAINT [FK_BOOKSBR1] FOREIGN KEY([Borrower_id])
REFERENCES [dbo].[Borrowers] ([Borrower_id])
GO
ALTER TABLE [dbo].[Books_Borrowed] CHECK CONSTRAINT [FK_BOOKSBR1]
GO
ALTER TABLE [dbo].[Books_Borrowed]  WITH CHECK ADD  CONSTRAINT [FK_BOOKSBR2] FOREIGN KEY([Copy_id])
REFERENCES [dbo].[BookCopies] ([Copy_id])
GO
ALTER TABLE [dbo].[Books_Borrowed] CHECK CONSTRAINT [FK_BOOKSBR2]
GO
ALTER TABLE [dbo].[Categories_Books]  WITH CHECK ADD  CONSTRAINT [FK_CATEGBOOKS1] FOREIGN KEY([Category_id])
REFERENCES [dbo].[Categories] ([Category_id])
GO
ALTER TABLE [dbo].[Categories_Books] CHECK CONSTRAINT [FK_CATEGBOOKS1]
GO
ALTER TABLE [dbo].[Categories_Books]  WITH CHECK ADD  CONSTRAINT [FK_CATEGBOOKS2] FOREIGN KEY([Book_id])
REFERENCES [dbo].[Books] ([Book_id])
GO
ALTER TABLE [dbo].[Categories_Books] CHECK CONSTRAINT [FK_CATEGBOOKS2]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_EMPLOYEES] FOREIGN KEY([Degree_id])
REFERENCES [dbo].[EmpDegrees] ([Degree_id])
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_EMPLOYEES]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_EMPLOYEES1] FOREIGN KEY([School_id])
REFERENCES [dbo].[Schools] ([School_id])
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_EMPLOYEES1]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_EMPLOYEES2] FOREIGN KEY([Branch_id])
REFERENCES [dbo].[Branches] ([Branch_id])
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_EMPLOYEES2]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_EMPLOYEES3] FOREIGN KEY([EmpType_id])
REFERENCES [dbo].[Employee_Type] ([EmpType_id])
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_EMPLOYEES3]
GO
ALTER TABLE [dbo].[Shift_Logins]  WITH CHECK ADD  CONSTRAINT [FK_SHIFT_LOGINS1] FOREIGN KEY([Employee_id])
REFERENCES [dbo].[Employees] ([Employee_id])
GO
ALTER TABLE [dbo].[Shift_Logins] CHECK CONSTRAINT [FK_SHIFT_LOGINS1]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [CHK_EMPLOYEES4] CHECK  (([Salary_Type]='Hourly' OR [Salary_Type]='Salaried'))
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [CHK_EMPLOYEES4]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [CHK_EMPLOYEES6] CHECK  (([Vacation_Time]>=(14)))
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [CHK_EMPLOYEES6]
GO
/****** Object:  StoredProcedure [dbo].[USP_BorrowBook]    Script Date: 5/10/2023 9:51:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_BorrowBook]
    @copy_id AS INT,
    @card_id AS INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION
            --Check if copy is of type Reference
                IF EXISTS(
                    SELECT TOP 1 1 
                    FROM Categories_Books CB
                    INNER JOIN BookCopies BC ON bc.Book_id = CB.Book_id
                    WHERE BC.copy_id = @copy_id AND CB.Category_id = (SELECT Category_id FROM Categories C
					                                                    WHERE Category_Type = 'Reference')
                )
                    BEGIN
                        ;THROW 50001, 'Copy of type Reference can not be borrowed', 1 
                    END
            --Check if copy is in POOR 
                IF EXISTS (
                    SELECT copy_id
                    FROM bookcopies 
                    WHERE condition = 'POOR' AND copy_id = @copy_id
                )
                    BEGIN
                        ;THROW 50002, 'Copies in POOR condition can not be borrowed', 1  
                    END
            --Check if copy is BORROWED or Discarded
                IF EXISTS (
                    SELECT copy_id
                    FROM BookCopies 
                    WHERE Is_Available = 0 AND copy_id = @copy_id
                )
                    BEGIN
                        ;THROW 50003, 'Copies that are Discarded or already Borrowed can not be borrowed.', 1  
                    END
            --Check if borrower is available to borrow a book
                IF EXISTS (
                    SELECT * 
                    FROM borrowers 
                    WHERE card_id = @card_id AND (Is_Expired = 1 OR Balance_Due >= 10)
                )
                    BEGIN
                        ;THROW 50004, 'Either borrowers card expired or borrower owes over 10 dollars.', 1
                    END
			
            DECLARE @Borrower_id INT= @Card_id
            UPDATE bookcopies SET Is_Available = 0 WHERE copy_id = @copy_id
            DECLARE @Borrowed_id INT = (SELECT MAX(Borrowed_id) + 1 FROM books_borrowed)
            INSERT INTO books_borrowed 
            VALUES 
            (
                ISNULL(@Borrowed_id,1),
				@Borrower_id,
                @copy_id,
                GETDATE(),
                DATEADD(DAY,14,GETDATE()),
				NULL,
				@card_id,
                0
            )
            PRINT('Book Has Been Sucessfully Borrowed')
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        PRINT('An Error Occured During The Transaction. Error SP: ' + ERROR_PROCEDURE() + 'Error line: ' + CAST(ERROR_LINE() AS VARCHAR))
        PRINT(ERROR_MESSAGE())
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_Borrower]    Script Date: 5/10/2023 9:51:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Usp_Borrower]
     @borrower_id INT
    ,@fname VARCHAR(15)
    ,@lname VARCHAR(20)
    ,@birthdate DATE
AS
BEGIN
    BEGIN TRY
        -- Check if borrower has an active card  
        IF EXISTS (SELECT TOP 1 1 FROM borrowers WHERE Borrower_id = @borrower_id AND Is_Expired = 0)
            BEGIN  
                ;THROW 50001, 'A person already has an active card.', 1
            END

         -- Check if borrower has an a balancedue on expired card 
        IF EXISTS (SELECT TOP 1 1 FROM borrowers WHERE Borrower_id = @borrower_id AND Is_Expired = 1 AND Balance_Due > 0)
            BEGIN 
                ;THROW 50002, 'A person owes library from previous card.', 1
            END

        -- Check if borrower is older than 10
        DECLARE @age INT = DATEDIFF(YEAR,@birthdate,GETDATE())
        IF(@age < 10)
            BEGIN 
                ;THROW 50003, 'Borrower can not be younger than 10.', 1 
            END
    END TRY 
    BEGIN CATCH
        PRINT('An Error Occured During The Transaction. Error SP: ' + ERROR_PROCEDURE() + 'Error line: ' + CAST(ERROR_LINE() AS VARCHAR))
        PRINT(ERROR_MESSAGE())
    END CATCH 
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_CardExpire]    Script Date: 5/10/2023 9:51:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Usp_CardExpire]
AS
  BEGIN 
      UPDATE Borrowers
	  SET Is_Expired = 
	                     CASE
						    WHEN DATEDIFF(Year, Card_Issue_Date, GETDATE())<10  THEN 1
							WHEN DATEDIFF(Year, Card_Issue_Date, GETDATE())>=10 THEN 0
						END
	FROM Borrowers
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_DiscardBook]    Script Date: 5/10/2023 9:51:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Usp_DiscardBook]
    @copy_id INT
AS 
BEGIN 
    -- Check if copy_id is valid
    IF NOT EXISTS(SELECT TOP 1 1 FROM bookcopies WHERE copy_id = @copy_id)
        BEGIN 
	    ;THROW 50021, 'Book copy with provided ID does not exist.', 1 
        END 

    -- Check if book is returned
    IF EXISTS(SELECT TOP 1 1 FROM bookcopies WHERE copy_id = @copy_id AND Is_Available = 0)
        BEGIN 
	    ;THROW 50022, 'Book copy with provided ID has not been returned.', 1 
        END 

    -- Check if book has not been discarded
    IF EXISTS(SELECT TOP 1 1 FROM bookcopies WHERE copy_id = @copy_id AND Is_Active = 0 )
        BEGIN 
	    ;THROW 50023, 'Book copy with provided ID has been already discarded.', 1 
	    
        END  

    UPDATE bookcopies SET Is_Available = 0, Is_Active = 0, condition = 'POOR' WHERE copy_id = @copy_id  
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_EmployeeVacationTime]    Script Date: 5/10/2023 9:51:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Usp_EmployeeVacationTime]
AS
  BEGIN 
      UPDATE Employees
	  SET Vacation_Time = 
	                     CASE
						    WHEN DATEDIFF(Year, HireDate, GETDATE()) BETWEEN 0 AND 10 THEN 14
							WHEN DATEDIFF(Year, HireDate, GETDATE()) BETWEEN 11 AND 15 THEN 20
							ELSE 30
						END
	FROM Employees
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_ExpireCards]    Script Date: 5/10/2023 9:51:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Usp_ExpireCards]
AS 
BEGIN 
    UPDATE borrowers SET Is_Expired = 1
    WHERE DATEDIFF(YEAR,Card_Issue_Date,GETDATE()) >= 10
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_ExtraCharge]    Script Date: 5/10/2023 9:51:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Usp_ExtraCharge]
   @Borrower_id AS INT,
   @copy_id AS INT,
   @card_id AS INT,
   @due_date AS DATE,
   @returned_date AS DATE
AS
BEGIN
    SET NOCOUNT ON;
	BEGIN TRY
        BEGIN TRANSACTION
            -- Check borrowed book exists
            IF NOT EXISTS(SELECT TOP 1 1 FROM books_borrowed WHERE card_id = @card_id AND copy_id = @copy_id AND is_Returned = 0)
            BEGIN
		;THROW 50001, 'There is no borrowed book with the given details.', 1 
		
            END
            DECLARE @daysElapsed INT
			SET @daysElapsed =datediff(day, @due_date,@returned_date)

            
			DECLARE @price DECIMAL(5,2)

			DECLARE @typeId INT
            -- Check if Juvenile
            IF(@daysElapsed > 14 AND @typeId = 4)
                        BEGIN 
                            SET @price = .05
                        END 
                    ELSE 
                        BEGIN
                            SET @price = .10 
                        END
						BEGIN
                    --Update card balancedue 
                    UPDATE borrowers SET balance_due = balance_due + (@price * @daysElapsed) WHERE card_id = @card_id
					   END
					   BEGIN
					--Update Returned_Date
					UPDATE Books_Borrowed SET Returned_Date = @returned_date WHERE card_id = @card_id
                      END
        
            PRINT('Extra Charging Has Been Added.')
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        PRINT('An Error Occured During The Transaction. Error SP: ' + ERROR_PROCEDURE() + 'Error line: ' + CAST(ERROR_LINE() AS VARCHAR))
        PRINT(ERROR_MESSAGE())
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_Librarian]    Script Date: 5/10/2023 9:51:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Usp_Librarian]
@Employee_id INT,
@empType_id INT

AS
BEGIN
	 DECLARE @Branch_id BIT
	

    BEGIN TRY
        -- Check if head librarian exists for the branch
        IF EXISTS(SELECT @Branch_id
		FROM employees
		WHERE Branch_id = @Branch_Id AND Is_Head_Librarian = 1)
        BEGIN
            ;THROW 50006,'There is already a head librarian on this branch',1
            ROLLBACK
        END

        -- Check if employee is of type librarian
        IF(@empType_Id <> 1)
            BEGIN
                ;THROW 50007,'Only librarians can be head librarian',1
                ROLLBACK
            END
    END TRY
	BEGIN CATCH
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_LogHours]    Script Date: 5/10/2023 9:51:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Usp_LogHours]
   @Employee_id AS INT,
   @Hours AS INT
AS
BEGIN
    SET NOCOUNT ON;
	BEGIN TRY
        BEGIN TRANSACTION
            -- Check if the given employee exists
            IF NOT EXISTS(SELECT TOP 1 1 FROM Employees WHERE Employee_id = @Employee_id )
            BEGIN
		;THROW 50001, 'There is no employee with the given details.', 1 
		
            END

			--Check if the workers work hours
			IF ( @Hours>40)
			BEGIN
      ;THROW 50032, 'An employee can not log more than 40 hours.', 1 
	        END

			DECLARE @Login_id  INT =   (SELECT MAX(Login_id) + 1 FROM Shift_Logins)
		   --Insert new record
			INSERT INTO Shift_Logins 
		    VALUES (
					ISNULL( @Login_id,1),
				    @Employee_id,
				    @Hours,
					GETDATE()
				   )
        
            PRINT('New Log Information Has Been Added.')
		COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        PRINT('An Error Occured During The Transaction. Error SP: ' + ERROR_PROCEDURE() + 'Error line: ' + CAST(ERROR_LINE() AS VARCHAR))
        PRINT(ERROR_MESSAGE())
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_LostBook]    Script Date: 5/10/2023 9:51:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--The Stored Procedure that about what will happen when a book get lost.


CREATE PROCEDURE [dbo].[Usp_LostBook]
  @copy_id AS INT,
  @card_id AS INT,
  @Borrowed_id AS INT 
AS
BEGIN
    SET NOCOUNT ON;
	BEGIN TRY
        BEGIN TRANSACTION
            -- Check borrowed book exists
            IF NOT EXISTS(SELECT TOP 1 1 FROM books_borrowed WHERE card_id = @card_id AND copy_id = @copy_id AND is_Returned = 0)
            BEGIN
		;THROW 50001, 'There is no borrowed book with the given details.', 1
            END

			BEGIN  

		    UPDATE books_borrowed SET Is_Returned = 1, returned_date = GETDATE() WHERE Borrowed_id = @Borrowed_id
            -- Set condition to LOST
            UPDATE bookcopies SET condition = 'Lost',is_available = 0 WHERE copy_id = @copy_id
            END
            PRINT('Book Has Been Sucessfully discarded as LOST.')
		
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        PRINT('An Error Occured During The Transaction. Error SP: ' + ERROR_PROCEDURE() + 'Error line: ' + CAST(ERROR_LINE() AS VARCHAR))
        PRINT(ERROR_MESSAGE())
    END CATCH
END
GO
USE [master]
GO
ALTER DATABASE [Pub_Library] SET  READ_WRITE 
GO
