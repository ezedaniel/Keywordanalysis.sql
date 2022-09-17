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
