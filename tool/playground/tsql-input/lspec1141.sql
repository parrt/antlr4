select count (*) as mycount from
(
	(
        select distinct Customers.CustomerID
            from Customers
                where Country = 'Germany'
            union
                select distinct Customers.CustomerID
                from Customers
                    where Country = 'UK'
    )
    except
    (
        select distinct Customers.CustomerID
            from Customers
                where City = 'London'
            union
                select distinct Customers.CustomerID
                    from Customers
                    where City = 'Berlin'
    )
) x__a

