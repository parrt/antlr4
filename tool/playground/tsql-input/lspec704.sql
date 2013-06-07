USE AdventureWorks;
GRANT SELECT ON OBJECT::Person.Address TO RosaQdM;
GO
USE AdventureWorks; 
GRANT EXECUTE ON OBJECT::HumanResources.uspUpdateEmployeeHireInfo
    TO Recruiting11;
GO 
USE AdventureWorks;
GRANT REFERENCES (EmployeeID) ON OBJECT::HumanResources.vEmployee 
    TO Wanida WITH GRANT OPTION;
GO

