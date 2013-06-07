USE AdventureWorks;
GO
SELECT AVG(VacationHours)as 'Average vacation hours', 
    SUM  (SickLeaveHours) as 'Total sick leave hours'
FROM HumanResources.Employee
WHERE Title LIKE 'Vice President%';
