--- TASK 1 --------- CREATE DATABASE ----------------------------
CREATE DATABASE Minions2022
Go
-- Use
Use Minions2022
Go
--- TASK 2 --------- CREATE TABLES ------------------------------
CREATE TABLE Minions ( 
             Id INT NOT NULL
			 ,[Name] NVARCHAR(50) NOT NULL
			 ,[Age] INT
			 )
ALTER TABLE Minions
ADD CONSTRAINT PK_Minions PRIMARY KEY(Id)

CREATE TABLE Towns (
            [Id] INT PRIMARY KEY,
			[Name] NVARCHAR(50) NOT NULL
			)
--- TASK 3 --------- ALTER MINIONS TABLE ------------------------
ALTER TABLE Minions
ADD TownId INT CONSTRAINT FK_Minions_Towns FOREIGN KEY REFERENCES Towns(Id) NOT NULL

--- TASK 4 --------- INSERT RECORDS IN BOTH TABLES  -------------
INSERT INTO Towns ([Id], [Name]) VALUES
           (1,'Sofia')
		  ,(2,'Plovdiv')
		  ,(3,'Varna')
INSERT INTO Minions (Id,[Name],[Age],TownId) VALUES
           (1,'Kevin',22,1)
		  ,(2,'Bob',15,3)
		  ,(3,'Steward', NULL, 2)
--- TASK 5 --------- TRUNCATE TABLE MINIONS  --------------------
TRUNCATE TABLE Minions
--- TASK 6 --------- DROP ALL TABLES  ---------------------------
DROP TABLE Minions
DROP TABLE Towns
--- TASK 7 --------- CREATE TABLE PEOPLE  -----------------------
CREATE TABLE People (
            Id INT CONSTRAINT PK_People PRIMARY KEY IDENTITY
		   ,[Name] NVARCHAR(200) NOT NULL
		   ,[Picture] VARBINARY(MAX) CHECK (DATALENGTH([Picture]) <= 2000000)
		   ,[Height] DECIMAL(3,2)
		   ,[Weight] DECIMAL(5,2)
		   ,[Gender] CHAR(1) CHECK (Gender = 'm' OR Gender = 'f') NOT NULL
		   ,[Birthdate] DATE NOT NULL
		   ,[Biography] NVARCHAR(MAX)
		   )

DROP TABLE People
CREATE TABLE People (
            Id INT CONSTRAINT PK_People PRIMARY KEY IDENTITY
		   ,[Name] NVARCHAR(200) NOT NULL
		   ,[Picture] VARBINARY(MAX) CHECK (DATALENGTH([Picture]) <= 2000000)
		   ,[Height] DECIMAL(3,2)
		   ,[Weight] DECIMAL(5,2)
		   ,[Gender] CHAR(1) CHECK (Gender = 'm' OR Gender = 'f') NOT NULL
		   ,[Birthdate] DATE NOT NULL
		   ,[Biography] NVARCHAR(MAX)
		   )
INSERT INTO People ([Name],[Height],[Weight],[Gender],[Birthdate]) VALUES
           ('Ivailo',1.80, 88, 'm','1999-03-29')
		  ,('Ivo',1.80, 88, 'm','1999-03-29')
		  ,('Ivooo',1.80, 88, 'm','1999-03-29')
		  ,('Ivailo00',1.80, 88, 'm','1999-03-29')
		  ,('Iva',1.80, 88, 'm','1999-03-29')
--- TASK 8 --------- CREATE TABLE USERS  ------------------------
CREATE TABLE Users (
             Id INT IDENTITY PRIMARY KEY
			,[Username] VARCHAR(30) CONSTRAINT UC_Username UNIQUE NOT NULL
			,[Password] VARCHAR(26) NOT NULL
			,[ProfilePicture] VARBINARY(MAX) CHECK (DATALENGTH([ProfilePicture]) <= 900000)
			,[LastLoginTime] DATETIME2
			,[IsDeleted] BIT NOT NULL
			)
INSERT INTO Users ([Username],[Password], IsDeleted) VALUES
            ('IVo', 'IIIv',0)
		   ,('georgiev', 'kojfasi2', 1)
	       ,('stoych4', 'asfasf2441', 0)
	       ,('unknown', 'fhasfo1', 0)
	       ,('thecollector', 'asfasfo145', 1)
 --- TASK 9 --------- CHANGE PRIMARY KEY  ------------------------

CREATE TABLE Users2 (
             Id INT CONSTRAINT PK_Users PRIMARY KEY IDENTITY
			,[Username] VARCHAR(30) CONSTRAINT UC_Username UNIQUE NOT NULL
			,[Password] VARCHAR(26) NOT NULL
			,[ProfilePicture] VARBINARY(MAX) CHECK (DATALENGTH([ProfilePicture]) <= 900000)
			,[LastLoginTime] DATETIME2
			,[IsDeleted] BIT NOT NULL
			)
INSERT INTO Users2 ([Username],[Password], IsDeleted) VALUES
            ('IVo', 'IIIv',0)
		   ,('georgiev', 'kojfasi2', 1)
	       ,('stoych4', 'asfasf2441', 0)
	       ,('unknown', 'fhasfo1', 0)
	       ,('thecollector', 'asfasfo145', 1)
ALTER TABLE Users2
DROP CONSTRAINT PK_Users

ALTER TABLE Users2
ADD CONSTRAINT PK_User PRIMARY KEY(Id,[Username])

UPDATE Users2
SET Password = 'Alfred'
WHERE Id = 1

Use Minions2022
Go
--- TASK 10 -------- ADD CHECK CONSTRAINT  ----------------------
ALTER TABLE Users2
ADD CONSTRAINT PasswordLenght CHECK (LEN([Password]) >=5)
--- TASK 11 -------- SET DEFAULT VALUE OF FIELD  ----------------
ALTER TABLE Users2
ADD DEFAULT GETDATE() FOR [LastLoginTime]
--- TASK 12 -------- SET UNIQUE FIELD  --------------------------
ALTER TABLE Users2
DROP CONSTRAINT PK_User

ALTER TABLE Users2
DROP CONSTRAINT UC_Username

ALTER TABLE Users2
ADD CONSTRAINT PK_User PRIMARY KEY (Id)

ALTER TABLE Users2
ADD CONSTRAINT UC_Username UNIQUE([Username])

ALTER TABLE Users2
ADD CONSTRAINT UsernameLenght CHECK (LEN([Username]) >=3)
Use master
Go