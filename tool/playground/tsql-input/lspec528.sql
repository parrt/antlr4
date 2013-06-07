USE AdventureWorks;
GO
CREATE TABLE sales2
(
 sales_id int IDENTITY(10000, 1) NOT NULL,
 cust_id  int NOT NULL,
 sales_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
 sales_amt money NOT NULL,
 delivery_date datetime NOT NULL DEFAULT DATEADD(dd, 10, GETDATE())
)
GO
INSERT sales2 (cust_id, sales_amt)
   VALUES (20000, 550)
