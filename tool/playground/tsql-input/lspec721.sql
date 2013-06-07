USE AdventureWorks;
GO
SELECT p.Name, pr.ProductReviewID
FROM Production.Product p
LEFT OUTER HASH JOIN Production.ProductReview pr
ON p.ProductID = pr.ProductID
ORDER BY ProductReviewID DESC;

