USE master

CREATE DATABASE SoftUni
GO

CREATE TABLE Towns (
            Id INT CONSTRAINT PK_Towns PRIMARY KEY IDENTITY (1,1) NOT NULL
			,[Name] NVARCHAR(100) NOT NULL
			)
CREATE TABLE Addresses (
			Id INT CONSTRAINT PK_Addresses PRIMARY KEY IDENTITY(1, 1) NOT NULL
			,AddressText NVARCHAR(100) NOT NULL
			,TownId INT CONSTRAINT FK_Addresses_Towns FOREIGN KEY REFERENCES Towns(Id) NOT NULL
			)
CREATE TABLE Departments (
			 Id INT CONSTRAINT PK_Departments PRIMARY KEY IDENTITY(1, 1) NOT NULL
			,[Name] NVARCHAR(100) NOT NULL
			)
CREATE TABLE Employees (
			 Id INT CONSTRAINT PK_Employees PRIMARY KEY IDENTITY(1, 1) NOT NULL
			,FirstName NVARCHAR(50) NOT NULL
			,MiddleName NVARCHAR(50) NOT NULL
			,LastName NVARCHAR(50) NOT NULL
			,JobTitle NVARCHAR(150) NOT NULL
			,DepartmentId INT CONSTRAINT FK_Employees_Departments FOREIGN KEY REFERENCES Departments(Id) NOT NULL
			,HireDate DATE
			,Salary DECIMAL(6,2)
			,AddressId INT CONSTRAINT FK_Employees_Addresses FOREIGN KEY REFERENCES Addresses(Id)
			)
--- TASK 18 --------- BASIC INSERT  ------------------------------
INSERT INTO Towns ([Name]) VALUES
           ('Sofia')
		   ,('Plovdiv')
		   ,('Varna')
		   ,('Burgas')
INSERT INTO Departments VALUES
			 ('Engineering')
			,('Sales')
			,('Marketing')
			,('Software Development')
			,('Quality Assurance')
INSERT INTO Employees(FirstName, MiddleName, LastName, JobTitle, DepartmentId, HireDate, Salary ) VALUES
			 ('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500.00)
			,('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000.00)
			,('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28', 525.25)
			,('Georgi', 'Teziev', 'Ivanov', 'CEO', 2, '2007-12-09', 3000.00)
			,('Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28', 599.88)
--UPDATE Towns
--SET [Name] = 'Sofia'
--WHERE Id = 1
SELECT * FROM Towns
SELECT * FROM Departments
SELECT * FROM Employees

SELECT * FROM Towns ORDER BY [Name]
SELECT * FROM Departments ORDER BY [Name]
SELECT * FROM Employees ORDER BY Salary DESC
--- TASK 21 --------- BASIC SELECT ALL SOME FIELDS ---------------
SELECT [NAME] FROM Towns ORDER BY [NAME]
SELECT [NAME] FROM Departments ORDER BY [NAME]
SELECT FirstName, LastName, JobTitle, Salary FROM Employees ORDER BY Salary DESC

UPDATE Employees
SET Salary += Salary*0.10
SELECT Salary FROM Employees
