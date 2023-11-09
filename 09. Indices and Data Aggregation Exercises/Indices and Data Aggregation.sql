USE [Gringotts]
GO

SELECT COUNT(*) AS [COUNT]
FROM WizzardDeposits

SELECT MAX(MagicWandSize) AS LongestMagicWand
FROM WizzardDeposits

SELECT DepositGroup
      ,MAX(MagicWandSize) AS LongestMagicWand
FROM WizzardDeposits
GROUP BY DepositGroup

SELECT TOP(2) DepositGroup 
FROM WizzardDeposits
GROUP BY DepositGroup
ORDER BY AVG(MagicWandSize)

SELECT DepositGroup 
	  ,SUM(DepositAmount) AS TotalSum
FROM WizzardDeposits
GROUP BY DepositGroup

SELECT DepositGroup 
	  ,SUM(DepositAmount) AS TotalSum
FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family'
GROUP BY DepositGroup

SELECT DepositGroup 
	  ,SUM(DepositAmount) AS [Total Sum]
FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family'
GROUP BY DepositGroup
HAVING SUM(DepositAmount) < 150000
ORDER BY [Total Sum] DESC 


SELECT DepositGroup 
	  ,MagicWandCreator
	  ,MIN(DepositCharge) AS MinDepositCharge
FROM WizzardDeposits
GROUP BY DepositGroup, MagicWandCreator
ORDER BY MagicWandCreator , DepositGroup



SELECT AgeGroupTable.AgeGroup
		,COUNT(AgeGroupTable.AgeGroup) AS WizardCount
FROM 
	(
	 SELECT
	    CASE
		   WHEN Age BETWEEN 0 AND 10 THEN '[0-10]'
		   WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
           WHEN Age BETWEEN 21 and 30 THEN '[21-30]'
           WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
           WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'
           WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
		   ELSE '[61+]'
		           END AS AgeGroup
       FROM WizzardDeposits
	   ) AS AgeGroupTable
GROUP BY AgeGroup
ORDER BY AgeGroup


SELECT LEFT(FirstName,1) AS FirstLetter
FROM WizzardDeposits
WHERE DepositGroup = 'Troll Chest'
GROUP BY LEFT(FirstName,1)


SELECT DepositGroup 
      ,IsDepositExpired
	  ,AVG(DepositInterest) AS AverageInterest
FROM WizzardDeposits
WHERE DATEPART(YEAR, DepositStartDate) >= 1985
GROUP BY DepositGroup,IsDepositExpired
ORDER BY DepositGroup DESC, IsDepositExpired

SELECT SUM([Difference]) AS SumDifference 
FROM 
(
    SELECT w.FirstName AS [Host Wizzard]
          ,w.DepositAmount AS [Host Wizzard Deposit]
          ,wd.FirstName AS [Guest Wizzard]
          ,wd.DepositAmount AS [Guest Wizzard Deposit]
          ,w.DepositAmount - wd.DepositAmount AS [Difference]
    FROM WizzardDeposits AS w
    JOIN WizzardDeposits AS wd ON w.Id = wd.Id - 1
) AS WizardTable

USE SoftUni20232


SELECT DepartmentID
      ,SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY DepartmentID
ORDER BY DepartmentID


SELECT DepartmentID
      ,MIN(Salary) AS MinSalary
FROM Employees
WHERE DepartmentID IN(2,5,7) AND HireDate > '01/01/2000'
GROUP BY DepartmentID
ORDER BY DepartmentID


SELECT DepartmentID
      ,MIN(Salary) AS MinimumSalary 
FROM Employees
WHERE DATEPART(YEAR, HireDate) >= 2000
GROUP BY DepartmentID
HAVING DepartmentID IN (2, 5, 7)



SELECT DepartmentID   
FROM Employees
WHERE Salary >30000
GROUP BY DepartmentID



SELECT * 
INTO EmployeesWithHighSalary
FROM Employees
WHERE Salary > 30000

DELETE FROM EmployeesWithHighSalary
WHERE ManagerID = 42

UPDATE EmployeesWithHighSalary
SET Salary += 5000
WHERE DepartmentID =1

SELECT DepartmentId
       ,AVG(Salary) AS AverageSalary 
FROM EmployeesWithHighSalary
GROUP BY DepartmentID


SELECT DepartmentId
       ,MAX(Salary) AS MaxSalary 
FROM EmployeesWithHighSalary
GROUP BY DepartmentID
HAVING MAX(Salary) NOT BETWEEN 30000 AND 70000


SELECT COUNT(Salary) AS [Count] 
FROM Employees
WHERE ManagerID IS NULL


SELECT DISTINCT RankedSalaries.DepartmentID
               ,RankedSalaries.Salary
FROM 
    (
        SELECT DepartmentID
              ,Salary
              ,DENSE_RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS SalaryRank
        FROM Employees
    ) AS RankedSalaries
WHERE RankedSalaries.SalaryRank = 3


SELECT TOP (10) FirstName
               ,LastName
               ,DepartmentID
FROM Employees AS e
WHERE Salary > (	
                    SELECT AVG(Salary) 
                    FROM Employees AS em 
                    WHERE em.DepartmentID = e.DepartmentID
			   )