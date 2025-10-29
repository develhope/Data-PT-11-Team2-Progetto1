# Data-PT-11-Team2-Progetto1  
## Metrica 5 — come sarà l'aspettativa di vita nei successivi 10 anni?

---

### Obiettivo
Calcolare come è cambiata l’aspettativa di vita nel tempo per ogni Paese e stimare quale potrebbe essere nei successivi 10 anni. Inoltre, individuare quali Paesi hanno migliorato di più la loro aspettativa di vita nel periodo osservato.

> Domanda guida:  
> Quali Paesi stanno vivendo la crescita più rapida dell’aspettativa di vita e quale trend possiamo prevedere per il futuro?

---
### Dataset di riferimento
**Fonte:** [Life Expectancy Data – Kaggle](https://www.kaggle.com/datasets/maryalebron/life-expectancy-data)  
**Tabella principale:** `life_expectancy`

| Campo               | Descrizione                           | Tipo    |
| :------------------ | :------------------------------------ | :------ |
| `Country`           | Nome del Paese                        | TEXT    |
| `Year`              | Anno di riferimento                   | INTEGER |
| `Life expectancy`   | Aspettativa di vita media             | FLOAT   |


### Logica della metrica
1. Calcolo della crescita media annuale dell’aspettativa di vita per ogni Paese.
2. Identificazione dei Paesi con il maggiore miglioramento nel tempo.  
3. Stima dell’aspettativa di vita prevista nel 2023, proiettando la crescita media annuale a partire dagli ultimi dati disponibili.

### Query SQL

```sql

--calcolo della crescita annuale media per paese e della media di vita nel 2015 (ultimo anno DB)

SELECT 
    Country,
    ROUND((MAX(led."Life expectancy " ) - MIN(led."Life expectancy " )) / 
          (MAX(Year) - MIN(Year)), 2) AS crescita_annua_media,
    MAX(led."Life expectancy " ) AS vita_ultimo_anno,
    MAX(Year) AS ultimo_anno
FROM Life_Expectancy_Data led 
WHERE led."Life expectancy "  IS NOT NULL
GROUP BY Country
HAVING COUNT(DISTINCT Year) > 5
ORDER BY crescita_annua_media DESC;

--calcolo di vita atteso nel 2023

SELECT 
    Country,
    ROUND(MAX(led."Life expectancy " ) 
          + ((2023 - MAX(Year)) * 
            ((MAX(led."Life expectancy " ) - MIN(led."Life expectancy " )) / 
             (MAX(Year) - MIN(Year)))), 2) AS vita_attesa_2023
FROM Life_Expectancy_Data led 
WHERE led."Life expectancy "  IS NOT NULL
GROUP BY Country
HAVING COUNT(DISTINCT Year) > 5
ORDER BY vita_attesa_2023 DESC;