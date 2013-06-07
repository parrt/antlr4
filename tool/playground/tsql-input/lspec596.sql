USE AdventureWorks;
DENY SELECT ON OBJECT::Person.Address TO RosaQdM;
GO

USE AdventureWorks;
DENY EXECUTE ON OBJECT::HumanResources.uspUpdateEmployeeHireInfo
    TO Recruiting11;
GO 

USE AdventureWorks;
DENY REFERENCES (EmployeeID) ON OBJECT::HumanResources.vEmployee 
    TO Wanida CASCADE;
GO

