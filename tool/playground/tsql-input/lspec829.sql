SELECT a.* FROM OPENROWSET( BULK 'c:\test\values.txt', 
	   FORMATFILE = 'c:\test\values.fmt') AS a;

