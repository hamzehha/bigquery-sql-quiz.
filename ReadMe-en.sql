
--task1

SELECT
  refresh_date AS Day,
  term AS Top_Term,
  rank
FROM `bigquery-public-data.google_trends.top_terms`
WHERE
  rank = 1
  AND refresh_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH)
GROUP BY Day, Top_Term, rank
ORDER BY Day DESC

--task2

SELECT
  refresh_date AS Day,
  term AS Top_Term,
  rank
FROM `bigquery-public-data.google_trends.top_terms`
WHERE
  rank <= 3
  AND refresh_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH)
GROUP BY Day, Top_Term, rank
ORDER BY Day DESC, rank ASC

--task3

SELECT
  refresh_date AS Day,
  term AS Top_Term,
  rank,
  region
FROM `bigquery-public-data.google_trends.top_terms`
WHERE
  rank <= 3
  AND refresh_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH)
  AND region = 'GB'
GROUP BY Day, Top_Term, rank, region
ORDER BY Day DESC, rank ASC

--task4

SELECT
  t.refresh_date AS Day,
  t.term AS Top_Term,
  t.rank,
  c.category
FROM `bigquery-public-data.google_trends.top_terms` AS t
LEFT JOIN `bigquery-public-data.google_trends.term_categories` AS c
ON t.term = c.term
WHERE
  t.rank <= 3
  AND t.refresh_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH)
  -- Filter to the last month.
  AND t.region = 'GB'
GROUP BY Day, Top_Term, t.rank, c.category
ORDER BY Day DESC, t.rank ASC


--task5

SELECT
  EXTRACT(WEEK FROM refresh_date) AS Week_Number,
  ARRAY_AGG(DISTINCT term ORDER BY rank ASC) AS Weekly_Top_Terms,
  COUNT(DISTINCT refresh_date) AS Days_Covered
FROM `bigquery-public-data.google_trends.top_terms`
WHERE
  rank <= 3
  AND refresh_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH)
  AND region = 'GB'
GROUP BY Week_Number
ORDER BY Week_Number DESC