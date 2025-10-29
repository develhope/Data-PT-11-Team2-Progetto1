METRICA 1
Average total life expectancy (men + women)


SELECT
  ROUND(AVG(
    ("Life expectancy (men)" + "Life expectancy(women)") / 2
  ), 2) AS avg_life_expectancy_total
FROM life_expectancy
WHERE "Life expectancy (men)" IS NOT NULL
  AND "Life expectancy(women)" IS NOT NULL;

TENDENCY BETWEEN DEVELOPED/DEVELOPING COUNTRIES

SELECT Status,
       ROUND(AVG(("Life expectancy (men)" + "Life expectancy(women)") / 2), 2) AS avg_life
FROM life_expectancy
GROUP BY Status;

LIFE EXPECTANCY GAP OVER TIME

SELECT Year,
       MAX(("Life expectancy (men)" + "Life expectancy(women)") / 2)
       - MIN(("Life expectancy (men)" + "Life expectancy(women)") / 2) AS life_gap
FROM life_expectancy
GROUP BY Year
ORDER BY Year;

LIFE EXPECTANCY EXTREMES PER YEAR BY COUNTRY

WITH avg_life AS ( 
SELECT Country, Year, 
("Life expectancy (men)" + "Life expectancy(women)") / 2 AS avg_life_expectancy 
FROM life_expectancy 
WHERE "Life expectancy (men)" IS NOT NULL 
AND "Life expectancy(women)" IS NOT NULL 
) 
SELECT Year, MAX(CASE WHEN avg_life_expectancy = ( 
SELECT MAX(avg_life_expectancy) 
FROM avg_life al2 
WHERE al2.Year = al1.Year ) 
THEN Country END) AS country_highest, 
ROUND(MAX(avg_life_expectancy), 2) AS highest_life, 
MAX(CASE WHEN avg_life_expectancy = ( 
SELECT MIN(avg_life_expectancy) 
FROM avg_life al3 
WHERE al3.Year = al1.Year ) 
THEN Country END) AS country_lowest, 
ROUND(MIN(avg_life_expectancy), 2) AS lowest_life 
FROM avg_life al1 
GROUP BY Year 
ORDER BY Year;



