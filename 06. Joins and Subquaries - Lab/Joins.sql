USE SoftUni20232

SELECT TOP 50 
           e.FirstName
		   ,e.LastName
		   ,t.[Name] AS Town
		   ,a.AddressText

FROM Employees AS e
JOIN Addresses AS a ON e.AddressID=a.AddressID
JOIN Towns AS t ON t.TownID= a.TownID
ORDER BY e.FirstName, e.LastName


SELECT e.FirstName
	,e.LastName
	,e.HireDate
	,d.[Name] as DepartmentName
FROM Employees AS e
JOIN Departments AS d ON (e.DepartmentID=d.DepartmentID AND e.HireDate > '1/1/1999' AND d.[Name] IN ('Sales', 'Finance'))
ORDER BY e.HireDate

SELECT TOP 50 e.EmployeeID
   ,e.FirstName + ' ' + e.LastName AS EmployeeName
   ,m.FirstName + ' ' + m.LastName AS ManagerName
   ,d.[Name] AS DepartmentName
FROM Employees AS e
LEFT JOIN Employees AS m ON e.EmployeeID = m.ManagerID
LEFT JOIN Departments AS d ON e.DepartmentID=d.DepartmentID
ORDER BY e.EmployeeID 

SELECT a.AverageSalary AS MinAverageSalary
FROM
	(
	  SELECT e.DepartmentID
			,AVG(e.Salary) As AverageSalary
	  FROM Employees AS e
	  GROUP BY e.DepartmentID
	  ) AS a


