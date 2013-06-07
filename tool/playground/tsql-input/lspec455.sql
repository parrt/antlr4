CREATE ASSEMBLY HandlingLOBUsingCLR
FROM '\\MachineName\HandlingLOBUsingCLR\bin\Debug\HandlingLOBUsingCLR.dll'';
GO
CREATE PROCEDURE dbo.GetPhotoFromDB
(
    @ProductPhotoID int,
    @CurrentDirectory nvarchar(1024),
    @FileName nvarchar(1024)
)
AS EXTERNAL NAME HandlingLOBUsingCLR.LargeObjectBinary.GetPhotoFromDB;
GO
