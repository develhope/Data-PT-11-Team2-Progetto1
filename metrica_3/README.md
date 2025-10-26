# Data-PT-11-Team2-Progetto1  
## Metrica 3 — TOP 10 Paesi in cui le Donne Vivono di Più

---

### Obiettivo
Identificare i **10 Paesi con il maggiore gap positivo di aspettativa di vita** tra donne e uomini, utilizzando il dataset *Life Expectancy Data* (Kaggle).

> Domanda guida:  
> *In quali Paesi le donne vivono mediamente più a lungo degli uomini, e di quanti anni in media?*

---

### Dataset di riferimento
**Fonte:** [Life Expectancy Data – Kaggle](https://www.kaggle.com/datasets/maryalebron/life-expectancy-data)  
**Tabella principale:** `life_expectancy`  

| Campo | Descrizione | Tipo |
|:------|:-------------|:----|
| `Country` | Nome del Paese | TEXT |
| `Year` | Anno di riferimento | INTEGER |
| `Life expectancy (men)` | Aspettativa di vita maschile | FLOAT |
| `Life expectancy(women)` | Aspettativa di vita femminile | FLOAT |
| `Status` | Paese sviluppato / in via di sviluppo | TEXT |
| `GDP` | Prodotto Interno Lordo | FLOAT |
| `Schooling` | Anni medi di istruzione | FLOAT |
| `Total expenditure` | Spesa sanitaria | FLOAT |

---

### Logica della metrica
1. Calcolo della media di aspettativa di vita per genere (`AVG()`).
2. Calcolo del **gap**: differenza tra vita media femminile e maschile.  
3. Ordinamento decrescente per mostrare i Paesi con la maggiore differenza positiva.
4. Limitazione ai **TOP 10 risultati**.

---

### Query SQL

```sql
-- Metrica 3 — TOP 10 PAESI IN CUI LE DONNE VIVONO DI PIÙ
SELECT
    Country AS Paese,
    ROUND(AVG("Life expectancy(women)") - AVG("Life expectancy (men)"), 2) AS gap_donne_meno_uomini
FROM life_expectancy
WHERE "Life expectancy (men)" IS NOT NULL
  AND "Life expectancy(women)" IS NOT NULL
GROUP BY Country
ORDER BY gap_donne_meno_uomini DESC
LIMIT 10;
