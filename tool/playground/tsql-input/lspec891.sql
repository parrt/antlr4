USE AdventureWorks;
REVOKE SELECT ON OBJECT::Person.Address FROM RosaQdM;
GO
USE AdventureWorks;
REVOKE EXECUTE ON OBJECT::HumanResources.uspUpdateEmployeeHireInfo
    FROM Recruiting11;
GO 
USE AdventureWorks;
REVOKE REFERENCES (EmployeeID) ON OBJECT::HumanResources.vEmployee 
    FROM Wanida CASCADE;
GO

