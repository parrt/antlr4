CREATE XML SCHEMA COLLECTION mySC AS '
<schema xmlns="http://www.w3.org/2001/XMLSchema">
      <element name="root" type="string"/>
</schema>
'
GO
CREATE TABLE T (Col1 xml (mySC))
GO
