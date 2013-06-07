SET NOCOUNT ON;
GO
USE master;
IF EXISTS (SELECT name FROM sys.tables
      WHERE name = 'wages')
   DROP TABLE wages;
GO
CREATE TABLE wages
(
   emp_id      tinyint    identity,
   hourly_wage   decimal   NULL,
   salary      decimal    NULL,
   commission   decimal   NULL,
   num_sales   tinyint   NULL
);
GO
INSERT wages VALUES(10.00, NULL, NULL, NULL);
INSERT wages VALUES(20.00, NULL, NULL, NULL);
INSERT wages VALUES(30.00, NULL, NULL, NULL);
INSERT wages VALUES(40.00, NULL, NULL, NULL);
INSERT wages VALUES(NULL, 10000.00, NULL, NULL);
INSERT wages VALUES(NULL, 20000.00, NULL, NULL);
INSERT wages VALUES(NULL, 30000.00, NULL, NULL);
INSERT wages VALUES(NULL, 40000.00, NULL, NULL);
INSERT wages VALUES(NULL, NULL, 15000, 3);
INSERT wages VALUES(NULL, NULL, 25000, 2);
INSERT wages VALUES(NULL, NULL, 20000, 6);
INSERT wages VALUES(NULL, NULL, 14000, 4);
GO
SET NOCOUNT OFF;
GO
SELECT CAST(COALESCE(hourly_wage * 40 * 52, 
   salary, 
   commission * num_sales) AS money) AS 'Total Salary' 
FROM wages;
GO
