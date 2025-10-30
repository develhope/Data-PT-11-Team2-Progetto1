# Metrica 1 – Aspettativa di vita media per genere

---

## Descrizione del progetto
Questa metrica analizza l’**aspettativa di vita media** distinguendo tra 
**uomini** e **donne**, a livello sia **globale** che **nazionale**, e 
mette a confronto i due generi anche in base al livello di sviluppo dei 
Paesi (*Developed* vs *Developing*).  

L’obiettivo è fornire una visione chiara delle **differenze di genere** 
(gender gap) nell’aspettativa di vita e comprendere come tali differenze 
variano nei diversi contesti economici.

---

## Logica e struttura delle query

1. **Medie globali per genere**  
   - Calcola la media dell’aspettativa di vita maschile e femminile su 
tutto il dataset.  
   - Utile come indicatore di riferimento generale.  

2. **Medie nazionali per genere**  
   - Raggruppa i dati per Paese (`GROUP BY Country`) per ottenere 
l’aspettativa di vita media di uomini e donne in ciascun Paese.  
   - Serve per confronti geografici o classifiche.

3. **Confronto del gender gap tra Paesi sviluppati e in via di sviluppo**  
   - Raggruppa i dati per `Status` (`Developed` / `Developing`).  
   - Mostra la media per genere e la differenza media (`gender_gap`) 
calcolata come:
     ```
     AVG("Life expectancy (women)") - AVG("Life expectancy (men)")
     ```
   - Evidenzia le disuguaglianze di aspettativa di vita in base al livello 
di sviluppo socioeconomico.

---

SQL Query

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