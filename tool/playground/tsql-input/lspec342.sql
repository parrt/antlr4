USE AdventureWorks;
GO
IF EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES
   WHERE TABLE_NAME = 'employeeData')
   DROP TABLE employeeData
IF EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES
   WHERE TABLE_NAME = 'auditEmployeeData')
   DROP TABLE auditEmployeeData;
GO
CREATE TABLE employeeData (
   emp_id int NOT NULL,
   emp_bankAccountNumber char (10) NOT NULL,
   emp_salary int NOT NULL,
   emp_SSN char (11) NOT NULL,
   emp_lname nchar (32) NOT NULL,
   emp_fname nchar (32) NOT NULL,
   emp_manager int NOT NULL
   );
GO
CREATE TABLE auditEmployeeData (
   audit_log_id uniqueidentifier DEFAULT NEWID(),
   audit_log_type char (3) NOT NULL,
   audit_emp_id int NOT NULL,
   audit_emp_bankAccountNumber char (10) NULL,
   audit_emp_salary int NULL,
   audit_emp_SSN char (11) NULL,
   audit_user sysname DEFAULT SUSER_SNAME(),
   audit_changed datetime DEFAULT GETDATE()
   );
GO
CREATE TRIGGER updEmployeeData 
ON employeeData 
AFTER UPDATE AS
/*Check whether columns 2, 3 or 4 have been updated. If any or all
 columns 2, 3 or 4 have been changed, create an audit record. The 
bitmask is: power(2,(2-1))+power(2,(3-1))+power(2,(4-1)) = 14. To test 
whether all columns 2, 3, and 4 are updated, use = 14 instead of >0
 (below).*/

   IF (COLUMNS_UPDATED() & 14) > 0
/*Use IF (COLUMNS_UPDATED() & 14) = 14 to see whether all columns 2, 3, 
and 4 are updated.*/
      BEGIN
-- Audit OLD record.
      INSERT INTO auditEmployeeData
         (audit_log_type,
         audit_emp_id,
         audit_emp_bankAccountNumber,
         audit_emp_salary,
         audit_emp_SSN)
         SELECT 'OLD', 
            del.emp_id,
            del.emp_bankAccountNumber,
            del.emp_salary,
            del.emp_SSN
         FROM deleted del

-- Audit NEW record.
      INSERT INTO auditEmployeeData
         (audit_log_type,
         audit_emp_id,
         audit_emp_bankAccountNumber,
         audit_emp_salary,
         audit_emp_SSN)
         SELECT 'NEW',
            ins.emp_id,
            ins.emp_bankAccountNumber,
            ins.emp_salary,
            ins.emp_SSN
         FROM inserted ins
   END;
GO

/*Inserting a new employee does not cause the UPDATE trigger to fire.*/
INSERT INTO employeeData
   VALUES ( 101, 'USA-987-01', 23000, 'R-M53550M', N'Mendel', N'Roland', 32);
GO

/*Updating the employee record for employee number 101 to change the 
salary to 51000 causes the UPDATE trigger to fire and an audit trail to 
be produced.*/

UPDATE employeeData
   SET emp_salary = 51000
   WHERE emp_id = 101;
GO
SELECT * FROM auditEmployeeData;
GO

/*Updating the employee record for employee number 101 to change both 
the bank account number and social security number (SSN) causes the 
UPDATE trigger to fire and an audit trail to be produced.*/

UPDATE employeeData
   SET emp_bankAccountNumber = '133146A0', emp_SSN = 'R-M53550M'
   WHERE emp_id = 101
GO
SELECT * FROM auditEmployeeData
GO
