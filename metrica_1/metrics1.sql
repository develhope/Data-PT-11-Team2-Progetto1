METRICA 1
Aspettativa di vita media per genere - globale

SELECT
  ROUND(AVG("Life expectancy (men)"),   2) AS avg_men,
  ROUND(AVG("Life expectancy(women)"), 2) AS avg_women
FROM life_expectancy
WHERE "Life expectancy (men)"   IS NOT NULL
  AND "Life expectancy(women)" IS NOT NULL;

Aspettativa di vita media per genere - nazionale

SELECT
  Country,
  ROUND(AVG("Life expectancy (men)"),   2) AS avg_men,
  ROUND(AVG("Life expectancy(women)"), 2) AS avg_women
FROM life_expectancy
WHERE "Life expectancy (men)"   IS NOT NULL
  AND "Life expectancy(women)" IS NOT NULL
GROUP BY Country
ORDER BY Country;

Aspettativa di vita media per gender gap e sviluppo dei paesi


SELECT
  Status AS Country_Status,
  ROUND(AVG("Life expectancy (men)"), 2)   AS avg_men,
  ROUND(AVG("Life expectancy(women)"), 2) AS avg_women,
  ROUND(ABS(AVG("Life expectancy(women)") - AVG("Life expectancy (men)")), 2) AS gender_gap
FROM life_expectancy
WHERE "Life expectancy (men)" IS NOT NULL
  AND "Life expectancy(women)" IS NOT NULL
GROUP BY Status;

Metrica per grafico

SELECT
  'Global' AS Level,
  'All countries' AS Category,
  ROUND(AVG("Life expectancy (men)"), 2)   AS avg_men,
  ROUND(AVG("Life expectancy(women)"), 2)  AS avg_women,
  ROUND(ABS(AVG("Life expectancy(women)") - AVG("Life expectancy (men)")), 2) AS gender_gap
FROM life_expectancy
WHERE "Life expectancy (men)" IS NOT NULL
  AND "Life expectancy(women)" IS NOT NULL

UNION ALL

SELECT
  'By Country' AS Level,
  Country      AS Category,
  ROUND(AVG("Life expectancy (men)"), 2)   AS avg_men,
  ROUND(AVG("Life expectancy(women)"), 2)  AS avg_women,
  ROUND(ABS(AVG("Life expectancy(women)") - AVG("Life expectancy (men)")), 2) AS gender_gap
FROM life_expectancy
WHERE "Life expectancy (men)" IS NOT NULL
  AND "Life expectancy(women)" IS NOT NULL
GROUP BY Country

UNION ALL

SELECT
  'By Status' AS Level,
  Status      AS Category,
  ROUND(AVG("Life expectancy (men)"), 2)   AS avg_men,
  ROUND(AVG("Life expectancy(women)"), 2)  AS avg_women,
  ROUND(ABS(AVG("Life expectancy(women)") - AVG("Life expectancy (men)")), 2) AS gender_gap
FROM life_expectancy
WHERE "Life expectancy (men)" IS NOT NULL
  AND "Life expectancy(women)" IS NOT NULL
GROUP BY Status;