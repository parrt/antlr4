WAITFOR (
	    RECEIVE *
	    FROM ExpenseQueue) 

WAITFOR (
	    RECEIVE *
	    FROM ExpenseQueue ),
TIMEOUT 60000 ;
WAITFOR (
	RECEIVE message_type_name,
	        CASE
		    WHEN validation = 'X' THEN CAST(message_body as XML)
		    ELSE NULL
	END AS message_body 
	FROM ExpenseQueue ),
	TIMEOUT 60000 ;

