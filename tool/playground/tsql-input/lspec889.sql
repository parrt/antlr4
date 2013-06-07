USE AdventureWorks;
REVOKE CONTROL ON USER::Wanida FROM RolandX;
GO
USE AdventureWorks;
REVOKE VIEW DEFINITION ON ROLE::SammamishParking 
    FROM JinghaoLiu CASCADE;
GO
USE AdventureWorks;
REVOKE IMPERSONATE ON USER::HamithaL FROM AccountsPayable17;
GO 
