DECLARE @geom1 geometry;
DECLARE @geom2 geometry;
DECLARE @result geometry;

SELECT @geom1 = GeomCol1 FROM SpatialTable WHERE id = 1;
SELECT @geom2 = GeomCol1 FROM SpatialTable WHERE id = 2;
SELECT @result = @geom1.STIntersection(@geom2);
SELECT @result.STAsText();

