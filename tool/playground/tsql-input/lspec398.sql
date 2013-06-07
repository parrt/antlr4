USE AdventureWorks;
GO
CREATE FULLTEXT CATALOG ftCatalog AS DEFAULT;
GO
CREATE FULLTEXT INDEX ON HumanResources.JobCandidate(Resume) KEY INDEX PK_JobCandidate_JobCandidateID;
GO
