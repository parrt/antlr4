-- Create a checksum index.
SET ARITHABORT ON;
USE AdventureWorks; 
GO
ALTER TABLE Production.Product
ADD cs_Pname AS CHECKSUM(Name);
GO
CREATE INDEX Pname_index ON Production.Product (cs_Pname);
GO
