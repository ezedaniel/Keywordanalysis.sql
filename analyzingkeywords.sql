SELECT Keyword, [Avg# monthly searches], [Competition (indexed value)]
INTO monthly_search_clean
FROM PortfolioProject..monthly_search

SELECT Keyword, [Estimated CTR], [Estimated Clicks]
INTO avg_CTR_clean
FROM PortfolioProject..avg_CTR


--Now we have to drop the rows with Null or 0 values. 
DELETE 
FROM avg_CTR_clean
WHERE [Estimated CTR] IS NULL

DELETE 
FROM monthly_search_clean
WHERE [Avg# monthly searches] IS NULL

--We have to fill the empty values with 0
UPDATE monthly_search_clean
SET [Competition (indexed value)]= ISNULL([Competition (indexed value)], 0)
--First, we create 2 new columns in the avg_monthly_search table, to fill with the clicks and CTR values of each keyword
ALTER TABLE monthly_search_clean
ADD Estimated_Clicks float

ALTER TABLE monthly_search_clean
ADD Estimated_CTR float

--Then we fill the new columns with the data from the avg_CTR_clean table

UPDATE a
SET a.[Estimated_Clicks] = b.[Estimated Clicks]
FROM monthly_search_clean a
	left join avg_CTR_clean b
	on a.Keyword=b.Keyword

UPDATE a
SET a.[Estimated_CTR] = b.[Estimated CTR]
FROM monthly_search_clean a
	left join avg_CTR_clean b
	on a.Keyword=b.Keyword
