DECLARE @sys_usr char(30);
SET @sys_usr = SYSTEM_USER;
SELECT 'The current system user is: '+ @sys_usr;
GO
USE AdventureWorks;
GO
CREATE TABLE Sales_Tracking
(
	    Territory_id int IDENTITY(2000, 1) NOT NULL,
	    Rep_id  int NOT NULL,
	    Last_sale datetime NOT NULL DEFAULT GETDATE(),
	    SRep_tracking_user varchar(30) NOT NULL DEFAULT SYSTEM_USER
)
GO
INSERT Sales_Tracking (Rep_id)
VALUES (151)
INSERT Sales_Tracking (Rep_id, Last_sale)
VALUES (293, '5/15/98')
INSERT Sales_Tracking (Rep_id, Last_sale)
VALUES (27882, '6/20/98')
INSERT Sales_Tracking (Rep_id)
VALUES (21392)
INSERT Sales_Tracking (Rep_id, Last_sale)
VALUES (24283, '11/03/98')
GO
SELECT * FROM Sales_Tracking ORDER BY Rep_id;
GO

