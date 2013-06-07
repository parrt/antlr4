CREATE ROUTE ExpenseRoute
    WITH
    SERVICE_NAME = '//Adventure-Works.com/Expenses',
    BROKER_INSTANCE = 'D8D4D268-00A3-4C62-8F91-634B89C1E315',
    ADDRESS = 'TCP://www.Adventure-Works.com:1234' ;
