DECLARE my_cursor CURSOR GLOBAL 
FOR SELECT * FROM Purchasing.ShipMethod
DECLARE @my_variable CURSOR ;
SET @my_variable = my_cursor ; 
--There is a GLOBAL cursor declared(my_cursor) and a LOCAL variable
--(@my_variable) set to the my_cursor cursor.
DEALLOCATE my_cursor; 
--There is now only a LOCAL variable reference
--(@my_variable) to the my_cursor cursor.

