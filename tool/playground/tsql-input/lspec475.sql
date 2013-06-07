CREATE ROUTE ExpenseRoute
    WITH
    SERVICE_NAME = '//Adventure-Works.com/Expenses',
    LIFETIME = 259200,
    ADDRESS = 'TCP://services.Adventure-Works.com:1234' ;
