USE AdventureWorks;
GO
DROP INDEX AK_BillOfMaterials_ProductAssemblyID_ComponentID_StartDate 
    ON Production.BillOfMaterials WITH (ONLINE = ON, MAXDOP = 2);
GO


