CREATE TABLE SpatialTable2(id int primary key, object GEOGRAPHY);
CREATE SPATIAL INDEX SIndx_SpatialTable_geography_col1 
   ON SpatialTable2(object);

