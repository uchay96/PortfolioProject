/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [CustomerID]
      ,[Gender]
      ,[Age]
      ,[Annual Income (k$)]
      ,[Spending Score (1-100)]
  FROM [Portfolio].[dbo].[Mall customers]



----- Full table of mall customers
  SELECT *
  FROM Portfolio.dbo.[Mall customers]


  -----The average anual income of all customers
  SELECT	DISTINCT COUNT(CustomerID) AS CUSTOMERS, AVG([Annual Income (k$)]) AS AVERAGEANNUALINCOME
  FROM Portfolio.dbo.[Mall customers]



  ------- The average spending score for males and females
  SELECT Gender, AVG([Spending Score (1-100)]) AS AverageSpendingScore
  FROM Portfolio.dbo.[Mall customers]
  GROUP BY  Gender



  --------- Which age group has the highest average spending score

  
 SELECT CONVERT(INT, [Spending Score (1-100)]) 
 FROM Portfolio.dbo.[Mall customers]

 ---- FIirstly convert spending score from float to integers

 UPDATE Portfolio.dbo.[Mall customers]
SET [Spending Score (1-100)] = CONVERT(INT, [Spending Score (1-100)]) 
 

 -----Using a subquery to calculate the age group with the highest average spending score
 SELECT AgeGroups.AgeGroup, AVG(AgeGroups.[Spending Score (1-100)]) AS AverageSpendingScore
 FROM (
 SELECT
 CASE
 WHEN Age BETWEEN 18 AND 25 THEN '18-25'
 WHEN Age BETWEEN 26 AND 35 THEN '26-35'
 WHEN Age BETWEEN 36 AND 45 THEN '36-45'
 WHEN Age BETWEEN 46 AND 55 THEN '46-55'
 WHEN Age BETWEEN 56 AND 65 THEN '56-65'
 ELSE '65+'
END AS AgeGroup,
([Spending Score (1-100)])
 FROM Portfolio.dbo.[Mall customers]
 ) AS AgeGroups
 GROUP BY AgeGroup
 ORDER BY AverageSpendingScore DESC


----- What is the highest and lowest annual income for female customers
SELECT Gender, MAX([Annual Income (k$)]) AS HighesteAnnualIncome,
MIN([Spending Score (1-100)]) AS LowestAnnualIncome
FROM Portfolio.dbo.[Mall customers]
WHERE Gender = 'Female'
GROUP BY Gender


--------- What age group has the highest average annual income
SELECT AgeGroups.AgeGroup, AVG(AgeGroups.[Annual Income (k$)]) AS AverageAnnualIncome
FROM (
SELECT
CASE
WHEN Age BETWEEN 18 AND 25 THEN '18-25'
WHEN Age BETWEEN 26 AND 35 THEN '26-35'
WHEN Age BETWEEN 36 AND 45 THEN '36-45'
WHEN Age BETWEEN 46 AND 55 THEN '46-55'
WHEN Age BETWEEN 56 AND 65 THEN '56-65'
ELSE '65+'
END AS AgeGroup,
[Annual Income (k$)]
FROM Portfolio.dbo.[Mall customers]
) AS AgeGroups
GROUP BY AgeGroup
ORDER BY AverageAnnualIncome DESC