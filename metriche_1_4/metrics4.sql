METRICA 4

Bottom 10 paesi per vita maschile

SELECT
  Country,
  ROUND(AVG("Life expectancy (men)"), 2) AS life_men_avg,
  ROUND(AVG(GDP), 0) AS gdp_avg
FROM life_expectancy
WHERE "Life expectancy (men)" IS NOT NULL AND GDP IS NOT NULL
GROUP BY Country
ORDER BY life_men_avg ASC
LIMIT 10;


PIL alto ma vita bassa

SELECT
  Country, Year, GDP, "Life expectancy (men)" AS life_men
FROM life_expectancy
WHERE GDP >= 30000
  AND "Life expectancy (men)" < 72
ORDER BY GDP DESC, life_men ASC
LIMIT 20;


