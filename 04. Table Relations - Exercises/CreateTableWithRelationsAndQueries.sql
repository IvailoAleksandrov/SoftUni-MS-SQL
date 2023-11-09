--- TASK 1 --------- ONE-TO-ONE RELATIONSHIP --------------------
CREATE DATABASE TableRelationsDB
GO

USE TableRelationsDB

CREATE TABLE Passport (
            PassportID INT PRIMARY KEY IDENTITY(101,1)
			,PassportNumber VARCHAR(50) UNIQUE
			)
CREATE TABLE Persons (
             PersonID INT PRIMARY KEY IDENTITY
			 ,FirstName NVARCHAR(50)
			 ,Salary DECIMAL(6,2)
			 ,PassportID INT FOREIGN KEY REFERENCES Passport(PassportID)
			 )

INSERT INTO Passport VALUES
         ('N34FG21B')
        ,('K65LO4R7')
        ,('ZE657QP2')

INSERT INTO Persons VALUES
		    ('Roberto', 4330, 102)
		   ,('Tom', 5610, 103)
		   ,('Yana', 6020, 101)
--- TASK 2 --------- ONE-TO-MANY RELATIONSHIP -------------------
CREATE TABLE Manufacturers (
           ManufacturerID INT PRIMARY KEY IDENTITY
		   ,Name VARCHAR(30) UNIQUE NOT NULL
		   ,EstablishedOn DATETIME2 NOT NULL
		   )
CREATE TABLE Models (
            ModelID INT PRIMARY KEY IDENTITY
			,Name VARCHAR(30) UNIQUE NOT NULL
			,ManufacturerID INT FOREIGN KEY REFERENCES Manufacturers(ManufacturerID)
			)

INSERT INTO Manufacturers VALUES
            ('BMW', '1916-03-07')
			,('Tesla', '2003-01-01')
			,('Lada', '1966-05-01')

INSERT INTO Models VALUES
            ('X1', 1)
			,('i6', 1)
			,('Model S', 2)
			,('Model X', 2)
			,('Model 3', 2)
			,('Nova', 3)
--- TASK 3 --------- MANY-TO-MANY RELATIONSHIP ------------------
USE TableRelationsDB

CREATE TABLE Students (
             StudentID INT PRIMARY KEY IDENTITY
			 ,[Name] NVARCHAR(20) NOT NULL
			 )
CREATE TABLE Exams (
			 ExamID INT  PRIMARY KEY IDENTITY(101, 1)
			,[Name] NVARCHAR(50) NOT NULL
             )
CREATE TABLE StudentExams (
            StudentID INT FOREIGN KEY REFERENCES Students(StudentID) NOT NULL
			,ExamID  INT FOREIGN KEY REFERENCES Exams(ExamID) NOT NULL
			PRIMARY KEY(StudentID,ExamID)
			)
INSERT INTO Students VALUES
     ('Mila')
    ,('Toni')
    ,('Ron')

INSERT INTO Exams VALUES
     ('SpringMVC')
    ,('Neo4j')
    ,('Oracle 11g')

INSERT INTO StudentExams VALUES
     (1, 101)
    ,(1, 102)
    ,(2, 101)
    ,(3, 103)
    ,(2, 102)
    ,(2, 103)
--- TASK 4 --------- SELF-REFERENCING ---------------------------
CREATE TABLE Teachers (
            TeacherID INT PRIMARY KEY IDENTITY(101,1)
			,[Name] NVARCHAR(30) NOT NULL
			,ManagerID INT FOREIGN KEY REFERENCES Teachers(TeacherID)
			)

INSERT INTO Teachers VALUES
			 ('John', NULL)
			,('Maya', 106)
			,('Silvia', 106)
			,('Ted', 105)
			,('Mark', 101)
			,('Greta', 101)
--- TASK 6 --------- UNIVERSITY DATABASE ------------------------
CREATE DATABASE UniversityDB 

USE UniversityDB

CREATE TABLE Majors (
            MajorsID INT PRIMARY KEY IDENTITY
			,[Name] NVARCHAR(50) NOT NULL
			)
CREATE TABLE Students (
			StudentID INT PRIMARY KEY IDENTITY
			,StudentNumber NVARCHAR(50) NOT NULL
			,StudentName NVARCHAR(50) NOT NULL
			,MajorID INT FOREIGN KEY REFERENCES Majors(MajorsID) NOT NULL
			)

CREATE TABLE Payments (
            PaymentsID INT PRIMARY KEY IDENTITY
			,PaymentDate DATETIME2 NOT NULL
			,PaymentAmount DECIMAL(8,2) NOT NULL
			,StudentID INT FOREIGN KEY REFERENCES Students(StudentID) NOT NULL
			)
CREATE TABLE Subjects (
            SubjectID INT PRIMARY KEY IDENTITY
			,SubjectName VARCHAR(50) NOT NULL
			)
CREATE TABLE Agenda (
            StudentID INT FOREIGN KEY REFERENCES Students(StudentID) NOT NULL
			,SubjectID INT FOREIGN KEY REFERENCES Subjects(SubjectID) NOT NULL
			PRIMARY KEY (StudentID,SubjectID)
			)
--- TASK 9 --------- PEAKS IN RILA ------------------------------

--- TASK 5 --------- ONLINE STORE DATABASE ----------------------
CREATE DATABASE OnlineStoreDB
GO

USE OnlineStoreDB
GO

CREATE TABLE Cities (
			 CityID INT CONSTRAINT PK_Cities PRIMARY KEY IDENTITY NOT NULL
			,[Name] VARCHAR(50) NOT NULL
)

CREATE TABLE Customers (
			 CustomerID INT CONSTRAINT PK_Customers PRIMARY KEY IDENTITY NOT NULL
			,[Name] VARCHAR(50) NOT NULL
			,Birthday DATE NOT NULL
			,CityID INT CONSTRAINT FK_Customers_Cities FOREIGN KEY REFERENCES Cities(CityID) NOT NULL
)

CREATE TABLE Orders (
     OrderID INT CONSTRAINT PK_Orders PRIMARY KEY IDENTITY NOT NULL
	,CustomerID INT CONSTRAINT FK_Orders_Customers FOREIGN KEY REFERENCES Customers(CustomerID) NOT NULL
)

CREATE TABLE ItemTypes (
			 ItemTypeID INT CONSTRAINT PK_ItemTypes PRIMARY KEY IDENTITY NOT NULL
			,[Name] VARCHAR(50) NOT NULL
)

CREATE TABLE Items (
			 ItemID INT CONSTRAINT PK_Items PRIMARY KEY IDENTITY NOT NULL
			,[Name] VARCHAR(50) NOT NULL
			,ItemTypeID INT CONSTRAINT FK_Items_ItemTypes FOREIGN KEY REFERENCES ItemTypes(ItemTypeID) NOT NULL
)

CREATE TABLE OrderItems (
			 OrderID INT CONSTRAINT FK_OrderItems_Orders FOREIGN KEY REFERENCES Orders(OrderID) NOT NULL
			,ItemID INT CONSTRAINT FK_OrderItems_Items FOREIGN KEY REFERENCES Items(ItemID) NOT NULL
			,CONSTRAINT PK_OrderItems PRIMARY KEY(OrderID, ItemID)
)

USE Geography

SELECT  m.MountainRange
		,p.PeakName
		,p.Elevation
FROM Mountains AS m
JOIN Peaks AS p ON m.Id = p.MountainId
WHERE m.MountainRange = 'Rila'
ORDER BY p.Elevation DESC
