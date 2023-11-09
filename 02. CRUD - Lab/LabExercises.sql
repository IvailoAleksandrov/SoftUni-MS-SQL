USE master

--- TASK 1 --------- EMPLOYEE SUMMARY ---------------------------
USE SoftUniCRUDOperations

SELECT FirstName + ' ' + LastName AS [Full Name]
       ,JobTitle
	   ,Salary
FROM Employees

--- TASK 2 --------- HIGHEST PEAK -------------------------------
USE Geography

CREATE VIEW v_HighestPeak AS
SELECT TOP(1) *
FROM Peaks
ORDER BY Elevation DESC
--- TASK 3 --------- UPDATE PROJECT -----------------------------
USE SoftUniCRUDOperations

UPDATE Projects
SET EndDate = GETDATE()
WHERE EndDate IS NULL