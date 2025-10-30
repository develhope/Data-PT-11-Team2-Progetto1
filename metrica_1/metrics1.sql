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


