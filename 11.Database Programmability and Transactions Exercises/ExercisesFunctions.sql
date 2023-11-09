--- TASK 1 --------- EMPLOYEES WITH SALARY ABOVE 35000 ----------
USE SoftUni20232
GO

CREATE PROC usp_GetEmployeesSalaryIsAbove35000
AS
SELECT FirstName,LastName
FROM Employees
WHERE Salary > 35000

EXEC usp_GetEmployeesSalaryIsAbove35000


CREATE PROC usp_GetEmployeesSalaryAboveNumber(@Number DECIMAL(18,4))
AS
SELECT FirstName,LastName
FROM Employees
WHERE Salary >= @Number

EXEC usp_GetEmployeesSalaryAboveNumber 100000

CREATE PROC usp_GetTownsStartingWith(@String NVARCHAR(50))
AS
SELECT [Name]
FROM Towns
WHERE [Name] LIKE @String + '%'

EXEC usp_GetTownsStartingWith 'b'


CREATE PROC usp_GetEmployeesFromTown(@Town NVARCHAR(50))
AS
SELECT FirstName
      ,LastName
FROM Employees AS e
JOIN Addresses AS a ON e.AddressID = a.AddressID
JOIN Towns AS t ON a.TownID = t.TownID
WHERE t.Name = @Town

EXEC usp_GetEmployeesFromTown 'Sofia'


CREATE FUNCTION ufn_GetSalaryLevel3(@salary DECIMAL(18,4))
RETURNS NVARCHAR(20)
AS
BEGIN
    DECLARE @salaryLevel NVARCHAR(10)

    IF(@salary < 30000)
        SET @salaryLevel = 'Low'
    ELSE IF(@salary >= 30000 AND @salary <= 50000)
        SET @salaryLevel = 'Average'
    ELSE
        SET @salaryLevel = 'High'

	RETURN @salaryLevel
END


SELECT Salary
      ,dbo.ufn_GetSalaryLevel3(Salary) AS SalaryLevel
FROM Employees
GROUP BY Salary


CREATE PROC usp_EmployeesBySalaryLevel(@SalaryLevel NVARCHAR(20))
AS
    SELECT FirstName AS [First Name]
          ,LastName AS [Last Name]
    FROM Employees
    WHERE dbo.ufn_GetSalaryLevel3(Salary) = @SalaryLevel

EXEC usp_EmployeesBySalaryLevel 'Low'


CREATE FUNCTION ufn_IsWordComprised(@setOfLetters NVARCHAR(MAX), @word NVARCHAR(MAX))
RETURNS BIT
BEGIN
    DECLARE @index INT = 1
    DECLARE @wordMatch NVARCHAR(MAX)

    WHILE (@index = LEN(@word))
    BEGIN
        DECLARE @letter NCHAR(1) = SUBSTRING(@word, @index, 1)
		
        IF(@setOfLetters LIKE '%' + @letter + '%')
        BEGIN
            SET @wordMatch = CONCAT(@wordMatch, @letter);
        END

        SET @index += 1		-- increment while loop
    END
	
    IF(@word = @wordMatch)
    BEGIN
        RETURN 1
    END 
    RETURN 0
END

SELECT dbo.ufn_IsWordComprised('oistmiahf', 'Sofia') AS Result
SELECT dbo.ufn_IsWordComprised('oistmiahf', 'halves') AS Result
SELECT dbo.ufn_IsWordComprised('bobr', 'Rob') AS Result
SELECT dbo.ufn_IsWordComprised('pppp', 'Guy') AS Result

USE Bank
GO

CREATE PROC usp_GetHoldersFullName
AS
    SELECT ah.FirstName + ' ' + ah.LastName AS [Full Name]
    FROM AccountHolders AS ah

EXEC usp_GetHoldersFullName


CREATE PROCEDURE usp_GetHoldersWithBalanceHigherThan(@value DECIMAL(16,2))
AS 
    SELECT ah.FirstName
          ,ah.LastName
    FROM AccountHolders AS ah
    JOIN Accounts AS a ON a.AccountHolderId = ah.Id
    GROUP BY a.AccountHolderId, ah.FirstName, ah.LastName
    HAVING SUM(a.Balance) >  @value	
    ORDER BY ah.FirstName, ah.LastName

EXEC usp_GetHoldersWithBalanceHigherThan 1000000

CREATE FUNCTION ufn_CalculateFutureValue(@sum DECIMAL(16, 2), @yearlyRate FLOAT, @numberYears INT)
RETURNS DECIMAL(16, 4)
AS 
    BEGIN
        DECLARE @fv DECIMAL(16, 4) 

        SET @fv = @sum * (POWER(1 + @yearlyRate, @numberYears))
        RETURN @fv 
    END

SELECT dbo.ufn_CalculateFutureValue(1000, 0.1, 5) AS [Output]