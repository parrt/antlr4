CREATE SYMMETRIC KEY #MarketingXXV 
     WITH ALGORITHM = AES_128,
     KEY_SOURCE 
     = 'The square of the hypotenuse is equal to the sum of the squares of the sides',
     IDENTITY_VALUE = 'Pythagoras'
     ENCRYPTION BY CERTIFICATE Marketing25;
GO
