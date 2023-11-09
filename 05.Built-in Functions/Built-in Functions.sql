USE SoftUni20232

SELECT FirstName, 
		LastName
FROM Employees
WHERE FirstName LIKE 'SA%'

SELECT FirstName
      ,LastName
FROM Employees
WHERE LastName LIKE '%ei%'

SELECT FirstName,HireDate
FROM Employees
WHERE DepartmentID IN(3,10) 
AND DATEPART(YEAR,HireDate) BETWEEN 1995 AND 2005

SELECT FirstName,
		LastName,
		JobTitle
FROM Employees
WHERE JobTitle LIKE '%engineer%'

SELECT [Name]
FROM Towns
WHERE LEN([Name]) IN (5,6)
ORDER BY [Name]

SELECT TownID
	   ,[Name]
FROM Towns
WHERE [Name] LIKE '[MKBE]%'
ORDER BY [Name]

SELECT TownID
	  ,[Name]
FROM Towns
WHERE [Name] NOT LIKE '[RBD]%'
ORDER BY [Name]

CREATE VIEW V_EmployeesHireAfter2000 AS
SELECT FirstName
	  ,LastName
FROM Employees
WHERE DATEPART(YEAR,HireDate) > 2000

USE SoftUni20232

SELECT FirstName
		,LastName
FROM Employees
WHERE LEN(LastName)=5

SELECT EmployeeID
	  ,FirstName
	  ,LastName
	  ,Salary
	  ,DENSE_RANK() OVER (PARTITION BY Salary ORDER BY EmployeeID) AS [Rank]
FROM Employees
WHERE Salary BETWEEN 10000 AND 50000
ORDER BY Salary DESC


SELECT * FROM
(
    SELECT EmployeeID
          ,FirstName
    	  ,LastName
    	  ,Salary
    	  ,DENSE_RANK() OVER (PARTITION BY Salary ORDER BY EmployeeID) AS [Rank]
    FROM Employees
    WHERE Salary BETWEEN 10000 AND 50000
) AS RankedTable
WHERE RankedTable.[Rank] = 2
ORDER BY Salary DESC

USE Geography

SELECT CountryName AS [Country Name]
		,IsoCode AS [ISO Code]
FROM Countries
WHERE CountryName LIKE '%a%a%a%'
ORDER BY Isocode

SELECT PeakName
	  ,RiverName
	    ,LOWER(PeakName + SUBSTRING(RiverName, 2, LEN(RiverName))) AS Mix
FROM Peaks, Rivers
WHERE RIGHT(Peakname,1) = Left(RiverName,1)
ORDER BY Mix

USE Diablo 

SELECT TOP 50 [Name]
		,FORMAT([Start], 'yyyy-MM-dd') AS [Start]
From Games
WHERE DATEPART(YEAR, [Start]) IN(2011,2012)
ORDER BY [Start], [Name]

SELECT Username
      ,SUBSTRING(Email, CHARINDEX('@', Email, 1) + 1, LEN(Email)) AS [Email Provider]
FROM Users
ORDER BY [Email Provider] , Username

SELECT Username
      ,IpAddress AS [IP Address] 
FROM Users
WHERE IpAddress LIKE '___.1%.%.___'
ORDER BY Username

SELECT [Name] AS Game
       ,[Part of the Day]=
	         CASE
			     WHEN DATEPART(HOUR, Start) < 12 THEN 'Morging'
				 WHEN DATEPART(HOUR,Start) < 18 THEN 'Afternoon'
				 ELSE 'EVENING'
			 END
	   ,Duration = 
	          CASE 
			      WHEN Duration <=3 THEN 'Extra Short'
				  WHEN Duration <=6 THEN 'Short'
				  WHEN Duration >6 THEN 'Long'
				  ELSE 'Extra Long'
			  END
FROM Games
ORDER BY Game, Duration, [Part of the Day]

USE Orders

SELECT ProductName
      ,OrderDate
      ,DATEADD(DAY, 3, OrderDate) AS [Pay Due]
      ,DATEADD(MONTH, 1, OrderDate) AS [Deliver Due] 
FROM Orders

CREATE TABLE People (
		Id INT PRIMARY KEY IDENTITY,
		[Name] NVARCHAR(100) NOT NULL,
		Birthdate DATETIME NOT NULL
)
INSERT INTO People VALUES
		 ('Ivan', '1995-02-17')
		,('Gosho', '1991-10-10')
		,('Ayk', '1996-06-20')
		,('Yanka', '2001-01-16')

SELECT [Name],
    DATEDIFF(YEAR, Birthdate, GETDATE()) AS [Age in Years],
    DATEDIFF(MONTH, Birthdate, GETDATE()) AS [Age in Months],
    DATEDIFF(DAY, Birthdate, GETDATE()) AS [Age in Days],
    DATEDIFF(MINUTE, Birthdate, GETDATE()) AS [Age in Minutes]
FROM People