USE AdventureWorks;
GO
CREATE TABLE EmployeeResumes 
   (LName nvarchar(25), FName nvarchar(25), 
    Resume xml( DOCUMENT HumanResources.HRResumeSchemaCollection) );

