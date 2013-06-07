IF EXISTS (SELECT name FROM sysobjects
      WHERE name = 'lake_list' AND type = 'P')
   DROP PROCEDURE lake_list
GO
CREATE PROCEDURE lake_list
   ( @region varchar(30),
     @size integer,
     @lake_list_cursor CURSOR VARYING OUTPUT )
AS 
BEGIN
   DECLARE @ok SMALLINT
   EXECUTE check_authority @region, username, @ok OUTPUT
   IF @ok = 1
      BEGIN
      SET @lake_list_cursor = CURSOR LOCAL SCROLL FOR
         SELECT name, lat, long, size, boat_launch, cost
         FROM lake_inventory
         WHERE locale = @region AND area >= @size
         ORDER BY name
      OPEN @lake_list_cursor
      END
END
DECLARE @my_lakes_cursor CURSOR
DECLARE @my_region char(30)
SET @my_region = 'Northern Ontario'
EXECUTE lake_list @my_region, 500, @my_lakes_cursor OUTPUT
IF Cursor_Status('variable', '@my_lakes_cursor') <= 0
   BEGIN
   /* Some code to tell the user that there is no list of
   Lakes. */
   END
ELSE
   BEGIN
      FETCH @my_lakes_cursor INTO  @JIM-- Destination here
      -- Continue with other code here.
   END
