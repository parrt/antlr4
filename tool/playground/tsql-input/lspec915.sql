DECLARE @session_usr nchar(30);
SET @session_usr = SESSION_USER;
SELECT 'This session''s current user is: '+ @session_usr;
GO
USE AdventureWorks
GO
CREATE TABLE deliveries3
(
	 order_id int IDENTITY(5000, 1) NOT NULL,
	 cust_id  int NOT NULL,
	 order_date smalldatetime NOT NULL DEFAULT GETDATE(),
	 delivery_date smalldatetime NOT NULL DEFAULT 
	    DATEADD(dd, 10, GETDATE()),
	 received_shipment nchar(30) NOT NULL DEFAULT SESSION_USER
)
GO
EXECUTE AS USER = 'Wanida'
INSERT deliveries3 (cust_id)
VALUES (7510)
INSERT deliveries3 (cust_id)
VALUES (7231)
REVERT
EXECUTE AS USER = 'SMacrae'
INSERT deliveries3 (cust_id)
VALUES (7028)
REVERT
EXECUTE AS USER = 'AbolrousHazem'
INSERT deliveries3 (cust_id)
VALUES (7392)
INSERT deliveries3 (cust_id)
VALUES (7452)
REVERT
GO
SELECT order_id AS 'Order #', cust_id AS 'Customer #', 
   delivery_date AS 'When Delivered', received_shipment 
   AS 'Received By'
FROM deliveries3
ORDER BY order_id
GO

