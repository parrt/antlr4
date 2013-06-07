USE AdventureWorks;
GO
BEGIN TRANSACTION;
GO
DELETE FROM HumanResources.JobCandidate
    WHERE JobCandidateID = 13;
GO
COMMIT TRANSACTION;
GO
