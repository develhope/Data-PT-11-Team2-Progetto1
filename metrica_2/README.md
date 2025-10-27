# Data-PT-11-Team2-Progetto1  
## Metrica 2 — L'istruzione allunga la vita?

---

### Obiettivo
Analizzare come l’istruzione influisce sull’aspettativa di vita, osservando anche le differenze tra Paesi sviluppati e in via di sviluppo e l’effetto combinato con PIL e spesa sanitaria.

> Domanda guida:  
> *In che modo l’istruzione contribuisce a migliorare la longevità, e quanto contano il PIL e la spesa sanitaria in questo rapporto?*

---
### Dataset di riferimento
**Fonte:** [Life Expectancy Data – Kaggle](https://www.kaggle.com/datasets/maryalebron/life-expectancy-data)  
**Tabella principale:** `life_expectancy` 

| Campo               | Descrizione                           | Tipo    |
| :------------------ | :------------------------------------ | :------ |
| `Country`           | Nome del Paese                        | TEXT    |
| `Year`              | Anno di riferimento                   | INTEGER |
| `Status`            | Paese sviluppato / in via di sviluppo | TEXT    |
| `Schooling`         | Anni medi di istruzione               | FLOAT   |
| `GDP`               | Prodotto Interno Lordo pro capite     | FLOAT   |
| `Total expenditure` | Percentuale del PIL spesa in sanità   | FLOAT   |
| `Life expectancy`   | Aspettativa di vita media             | FLOAT   |


### Logica della metrica
1. Analisi dell’andamento globale dell’istruzione nel tempo.
2. Confronto tra Paesi sviluppati e in via di sviluppo.  
3. Relazione multivariata tra istruzione, PIL, spesa sanitaria e aspettativa di vita.

### Query SQL

```sql

--ANDAMENTO dell'istruzione nel tempo nel mondo

SELECT 
    Year,
    ROUND(AVG(Schooling), 2) AS avg_schooling_world
FROM Life_Expectancy_Data led 
WHERE Schooling IS NOT NULL
GROUP BY Year
ORDER BY Year;


--confronto tra paesi sviluppati ed in via di sviluppo
SELECT 
    Year,
    Status,
    ROUND(AVG(Schooling), 2) AS avg_schooling
FROM Life_Expectancy_Data led 
WHERE Schooling IS NOT NULL
GROUP BY Year, Status
ORDER BY Year, Status;

-- Relazione tra istruzione, PIL, spesa sanitaria e aspettativa di vita

SELECT 
    Country,
    ROUND(AVG(Schooling), 2) AS avg_schooling,
    ROUND(AVG(GDP), 2) AS avg_gdp,
     ROUND(AVG(led."Total expenditure" ), 2) AS avg_health_spending,
    ROUND(AVG(led."Life expectancy " ), 2) AS avg_life_expectancy
FROM Life_Expectancy_Data led 
WHERE Schooling IS NOT NULL AND GDP IS NOT NULL AND led."Life expectancy "  IS NOT NULL 
AND led."Total expenditure"   IS NOT NULL
GROUP BY Country
ORDER BY avg_life_expectancy DESC;

```
#### Correzione metrica
Ho aggiunto una nuova query per visualizzare meglio  la correlazione dell'istruzione con GDP e spesa sanitaria,
creando tre gruppi in base alla loro economia:
1) paesi con alta economia (GDP > 20000)
2) paesi con media economia (GDP compresa tra 5000 e 19999)
3) paesi con bassa economia (GDP < 5000)

```sql
---- Relazione tra istruzione, PIL diviso in tre aree, spesa sanitaria e aspettativa di vita eliminando i nulli
SELECT 
    CASE 
        WHEN GDP >= 20000 THEN 'Alta economia'
        WHEN GDP BETWEEN 5000 AND 19999 THEN 'Media economia'
        ELSE 'Bassa economia'
    END AS economic_group,
    ROUND(AVG(Schooling), 2) AS avg_schooling,
    ROUND(AVG(GDP), 2) AS avg_gdp,
    ROUND(AVG(led."Total expenditure" ), 2) AS avg_health_spending,
    ROUND(AVG(led."Life expectancy " ), 2) AS avg_life_expectancy
FROM Life_Expectancy_Data led 
WHERE Schooling IS NOT NULL 
  AND GDP IS NOT NULL 
  AND led."Life expectancy "  IS NOT NULL 
  AND led."Total expenditure"  IS NOT NULL
GROUP BY economic_group
ORDER BY avg_life_expectancy DESC;
