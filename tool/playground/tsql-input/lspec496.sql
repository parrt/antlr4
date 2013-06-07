CREATE TABLE Globally_Unique_Data
(guid uniqueidentifier CONSTRAINT Guid_Default DEFAULT NEWSEQUENTIALID() ROWGUIDCOL,
    Employee_Name varchar(60)
CONSTRAINT Guid_PK PRIMARY KEY (Guid) );

