USE baby_names_db;
SELECT * FROM names;
SELECT * FROM regions;

-- Objective 1: Track changes in name popularity
-- How the most popular names have changed over time, and also to identify the names that have jumped the most in terms of popularity 
-- Task 1: Find the overall most popular girl and boy names and show how they have changed in popularity ranking over the years
SELECT
    Name,
    SUM(births) AS num_babies
FROM
     names
WHERE Gender = "F"
GROUP BY Name
ORDER BY num_babies DESC
LIMIT 1; -- Jessica 

SELECT 
    Year,
    Name,
    SUM(births) AS num_babies
FROM
	names
WHERE Gender = "M"
GROUP BY Name, Year
ORDER BY num_babies DESC;
 -- Michael
 
 WITH boy_names_ranking AS (
 SELECT
    Year,
    Name,
    SUM(births) AS num_babies,
    ROW_NUMBER() OVER(PARTITION BY Year ORDER BY SUM(births) DESC) AS popularity
FROM
	names
WHERE Gender = "M"
GROUP BY Name, Year
)
SELECT
    Year,
    Name,
    popularity
FROM
	boy_names_ranking
WHERE Name = "Michael";

WITH girl_names_ranking AS (
SELECT
    Year,
    Name,
    SUM(births) AS num_babies,
    ROW_NUMBER() OVER(PARTITION BY Year ORDER BY SUM(births) DESC) AS popularity
FROM
	names
WHERE Gender = "F"
GROUP BY Year, Name
)
SELECT
    Year,
    Name,
    popularity
FROM
	girl_names_ranking
WHERE Name = "Jessica";

-- Task 2: Find the names with the biggest jumps in popularity from the first year of the dataset to the last year
WITH name_1980 AS (
SELECT
    Year,
    Name,
    SUM(births) AS num_babies,
    ROW_NUMBER() OVER(ORDER BY SUM(births) DESC) AS popularity_1980
FROM
	names
WHERE Year = 1980
GROUP BY Year, Name
),
name_2009 AS (
SELECT
    Year,
    Name,
    SUM(births) AS num_babies,
    ROW_NUMBER() OVER(ORDER BY SUM(births) DESC) AS popularity_2009
FROM
	names
WHERE Year = 2009
GROUP BY Year, Name
)
SELECT
    name_1980.Year,
    name_1980.Name,
    name_1980.num_babies,
    name_1980.popularity_1980,
    name_2009.Year,
    name_2009.Name,
    name_2009.num_babies,
    name_2009.popularity_2009,
    ABS(CAST(popularity_1980 AS signed) - CAST(popularity_2009 AS signed)) AS diff
FROM
	name_1980
    JOIN
    name_2009 ON name_1980.Name = name_2009.Name
ORDER BY diff DESC;


-- Objective 2: Compare popularity across decades
-- Find top 3 girl names and top 3 boy names for each year, and also for each decade
-- Task 1: For each year, return the 3 most popular girl names and 3 most popular boy names 
WITH name_ranking AS (
SELECT
   Year,
    Name,
    Gender,
    SUM(births) AS num_babies,
    ROW_NUMBER() OVER(PARTITION BY Year, Gender ORDER BY SUM(births) DESC) AS popularity
FROM
	names
GROUP BY Year, Name, Gender
)
SELECT
    Year,
    Name,
    Gender,
    popularity
FROM
    name_ranking
WHERE popularity <= 3;

-- Task 2: For each decade, return the 3 most popular girl names and 3 most popular boy names 
WITH name_ranking AS (
SELECT
    FLOOR(Year / 10) * 10 AS decade,
    Name,
    Gender,
    SUM(births) AS num_babies,
    ROW_NUMBER() OVER(PARTITION BY FLOOR(Year / 10) * 10, Gender ORDER BY SUM(births) DESC) AS popularity
FROM
	names
GROUP BY decade, Name, Gender
)
SELECT
    decade,
    Name,
    Gender,
    popularity
FROM
	name_ranking
WHERE popularity <= 3;

-- Objective 3: Compare popularity across region 
-- Find the number of babies born in each region, and also return the top 3 girl names and top 3 boy names within each region
-- Task 1: Return the number of babies born in each of the six regions 
SELECT DISTINCT 
    n.state,
    r.region
FROM
	names n
    LEFT JOIN 
    regions r ON n.state = r.state
WHERE region IS NULL;

WITH cleaned_region AS (
SELECT DISTINCT
	state,
	CASE 
	    WHEN region = 'New England' THEN 'New_England' ELSE region END AS region_updated
FROM
	regions
UNION 
SELECT
    'MI' AS state,
    'Midwest' AS region
)
SELECT
    cr.region_updated,
    SUM(births) AS num_babies 
FROM
	cleaned_region cr 
    LEFT JOIN
    names n ON cr.state = n.state
GROUP BY cr.region_updated
ORDER BY num_babies DESC;

-- Task 2: Return the 3 most popular girl names and 3 most popular boy names within each region
USE baby_names_db;
WITH cleaned_region AS (
SELECT
   state,
    CASE
	WHEN region = 'New England' THEN 'New_England' ELSE region END AS region_updated
FROM
	regions
UNION 
SELECT
    'MI' AS state,
    'Midwest' AS region
),
rn AS (
SELECT
   region_updated,
    name,
    gender,
    SUM(births) AS num_babies,
    ROW_NUMBER() OVER(PARTITION BY region_updated, gender ORDER BY SUM(births) DESC) AS popularity
FROM
	cleaned_region cr
    LEFT JOIN 
    names n ON cr.state = n.state 
GROUP BY region_updated, name, gender
) 
SELECT
	region_updated,
    name,
    gender,
    popularity
FROM
	rn 
WHERE popularity <= 3;

-- Objective 4: Explore unique names in the dataset 
-- Find the most popular androgynous names, the shortest and longest names, and the state with the highest percent of babies named "Chris"
-- Task 1: Find the 10 most popular androgynous names (names given to both females and males) 
SELECT
   name,
    SUM(births) AS num_babies,
    COUNT(DISTINCT Gender) AS both_gender_count
FROM
	names
GROUP BY name
HAVING COUNT(DISTINCT Gender) = 2
ORDER BY num_babies DESC
LIMIT 10;

-- Task 2: Find the length of the shortest and longest names, and identify the most popular short names (those with the fewest characters) 
-- and long names (those with the most characters)
SELECT
    MIN(length(Name)) AS shortest,
    MAX(length(Name)) AS longest
FROM
	names;
-- The most popular short names
SELECT
	Name,
	SUM(births) AS num_babies,
    LENGTH(name) AS name_length
FROM
	names
GROUP BY Name
ORDER BY name_length, num_babies DESC;

-- The most popular long names
SELECT
    Name,
    SUM(births) AS num_babies,
    LENGTH(name) AS name_length
FROM
	names
GROUP BY Name
ORDER BY name_length DESC, num_babies DESC;

-- Task 3: Find the state with highest percent of babies named "Chris"
WITH chris_name AS (
SELECT 
    r.State,
    Name,
    SUM(births) AS num_chris
FROM
	names n
    JOIN
    regions r ON n.state = r.state
WHERE Name = "Chris"
GROUP BY State, Name
)
SELECT
    n.state,
    ROUND(num_chris * 100.0 / SUM(births), 4) AS percentage
FROM
	names n
    JOIN
    chris_name c ON c.State = n.State
GROUP BY n.state
ORDER BY percentage DESC;

    
    
