BULK INSERT AdventureWorks.Sales.SalesOrderDetail
   FROM 'f:\orders\lineitem.tbl'
   WITH
     (
        FIELDTERMINATOR =' |',
        ROWTERMINATOR = ':\n',
        FIRE_TRIGGERS
      )
