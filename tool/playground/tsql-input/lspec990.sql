DECLARE @hdoc int
DECLARE @doc varchar(1000)
SET @doc ='
<ROOT>
<Customer CustomerID="VINET" ContactName="Paul Henriot">
   <Order CustomerID="VINET" EmployeeID="5" OrderDate="1996-07-04T00:00:00">
      <OrderDetail OrderID="10248" ProductID="11" Quantity="12"/>
      <OrderDetail OrderID="10248" ProductID="42" Quantity="10"/>
   </Order>
</Customer>
<Customer CustomerID="LILAS" ContactName="Carlos Gonzlez">
   <Order CustomerID="LILAS" EmployeeID="3" OrderDate="1996-08-16T00:00:00">
      <OrderDetail OrderID="10283" ProductID="72" Quantity="3"/>
   </Order>
</Customer>
</ROOT>'
--Create an internal representation of the XML document.
EXEC sp_xml_preparedocument @hdoc OUTPUT, @doc
-- Remove the internal representation.
exec sp_xml_removedocument @hdoc
DECLARE @hdoc int
DECLARE @doc varchar(2000)
SET @doc = '
<?xml version="1.0" encoding="UTF-8" ?> 
<!DOCTYPE root 
[<!ELEMENT root (Customers)*>
<!ELEMENT Customers EMPTY>
<!ATTLIST Customers CustomerID CDATA #IMPLIED ContactName CDATA #IMPLIED>]>
<root>
<Customers CustomerID="ALFKI" ContactName="Maria Anders"/>
</root>'

EXEC sp_xml_preparedocument @hdoc OUTPUT, @doc
DECLARE @hdoc int
DECLARE @doc varchar(1000)
SET @doc ='
<ROOT>
<Customer CustomerID="VINET" ContactName="Paul Henriot">
   <Order CustomerID="VINET" EmployeeID="5" 
           OrderDate="1996-07-04T00:00:00">
	      <OrderDetail OrderID="10248" ProductID="11" Quantity="12"/>
	      <OrderDetail OrderID="10248" ProductID="42" Quantity="10"/>
	   </Order>
	</Customer>
	<Customer CustomerID="LILAS" ContactName="Carlos Gonzlez">
	   <Order CustomerID="LILAS" EmployeeID="3" 
	           OrderDate="1996-08-16T00:00:00">
		      <OrderDetail OrderID="10283" ProductID="72" Quantity="3"/>
		   </Order>
		</Customer>
		</ROOT>'
		--Create an internal representation of the XML document.
EXEC sp_xml_preparedocument @hdoc OUTPUT, @doc, '<ROOT xmlns:xyz="urn:MyNamespace"/>'

