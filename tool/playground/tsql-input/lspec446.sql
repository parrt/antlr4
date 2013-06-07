DECLARE @ComparePrice money, @Cost money 
EXECUTE Production.uspGetList '%Bikes%', 700, 
    @ComparePrice OUT, 
    @Cost OUTPUT
IF @Cost <= @ComparePrice 
BEGIN
    PRINT 'These products can be purchased for less than 
    $'+RTRIM(CAST(@ComparePrice AS varchar(20)))+'.'
END
ELSE
    PRINT 'The prices for all products in this category exceed 
    $'+ RTRIM(CAST(@ComparePrice AS varchar(20)))+'.'

