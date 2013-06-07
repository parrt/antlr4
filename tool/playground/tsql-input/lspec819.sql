SELECT *
FROM OPENDATASOURCE('SQLNCLI',
	    'Data Source=London\Payroll;Integrated Security=SSPI')
    .AdventureWorks.HumanResources.Employee

