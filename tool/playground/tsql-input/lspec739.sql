DECLARE @compareprice money, @cost money 
EXECUTE Production.uspGetList '%Bikes%', 700, 
    @compareprice OUT, 
    @cost OUTPUT
IF @cost <= @compareprice 
	BEGIN
		    PRINT 'These products can be purchased for less than 
		    $'+RTRIM(CAST(@compareprice AS varchar(20)))+'.'
	END
ELSE
	    PRINT 'The prices for all products in this category exceed 
	    $'+ RTRIM(CAST(@compareprice AS varchar(20)))+'.'

