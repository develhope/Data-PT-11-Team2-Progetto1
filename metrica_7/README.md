# Metrica 7 – Confronto tra i due DB  
**Life Expectancy 2015 vs 2023**

---

## Descrizione del progetto
Questa metrica confronta i valori medi di **aspettativa di vita** tra due dataset:

- **`life_expectancy`** → database con dati storici (media uomo + donna) fino al **2015**  
- **`recent` (OWID)** → dataset aggiornato con valori per il **2023**

L’obiettivo è calcolare l’evoluzione dell’aspettativa di vita per ogni paese e individuare i casi in cui si è **aumentata** o **diminuita** tra il 2015 e il 2023.

---

## Logica e struttura della query
### Step principali
1. **CTE `le2015`**  
   - Estrae la media uomo/donna per il 2015 dal dataset `life_expectancy`.  
   - Uniforma i nomi dei paesi con `TRIM()` e `UPPER()` per garantire la corrispondenza tra i due DB.  

2. **CTE `r2023`**  
   - Seleziona dal dataset `recent` (OWID) il valore medio di aspettativa di vita per il 2023.  

3. **JOIN tra i due dataset**  
   - Unione tramite la colonna normalizzata `country_norm`.  
   - Calcolo della **differenza** tra i valori 2023 e 2015 (`life_2023 - life_2015`).  

4. **Ordinamento finale**  
   - I risultati sono ordinati in base alla differenza (in ordine decrescente) per evidenziare i paesi con il maggior incremento.

---
## Analisi dei risultati

### Logica del confronto
Per ogni paese viene calcolata la differenza:
**Differenza = Life Expectancy 2023 − Life Expectancy 2015**

- Valore **positivo (+)** → aumento dell’aspettativa di vita (miglioramento sanitario/sociale).
- Valore **negativo (−)** → diminuzione (impatto di crisi, guerre, pandemia, peggioramento delle condizioni di salute).

### Risultati principali (lettura attesa)
**Incrementi più evidenti** (tipicamente):
- Paesi a reddito medio in crescita: miglior accesso a cure, vaccinazioni, infrastrutture (es. Asia meridionale, parte dell’Africa).
- Alcuni paesi con riforme sanitarie recenti mostrano guadagni stabili.

**Diminuzioni/ristagni**:
- Paesi colpiti da **COVID-19** o conflitti presentano cali o stagnazione (es. alcune aree del Nord America e dell’Europa orientale).

### Distribuzione visiva (come interpretare i grafici)
- **Mappa coropletica**: gradiente colore rispetto alla differenza (verde = aumento, rosso = diminuzione).
- **Grafico a barre**: ordinare per differenza decrescente per evidenziare progressi/regressi; aggiungere una linea di riferimento a 0.

### Sintesi statistica (attesa)
- Differenza media globale: **leggermente positiva** (incremento moderato).
- Convergenza: diversi paesi emergenti **recuperano terreno** rispetto ai paesi ad alto reddito.
- Effetto pandemia: visibile in alcuni contesti con **flessioni** nel 2023.

### Conclusione
Nel periodo **2015–2023** l’aspettativa di vita **cresce globalmente**, ma in modo **non uniforme**:
- miglioramenti diffusi nei paesi emergenti;
- flessioni o stagnazioni in aree colpite da crisi sanitarie/geopolitiche.
Nel complesso, il trend resta **positivo ma diseguale**, utile per indirizzare politiche sanitarie mirate.

---

<p align="center">
  <img src="https://raw.githubusercontent.com/develhope/Data-PT-11-Team2-Progetto1/main/metrica_5/GRAFICO_predizione_vita_2023.png" 
       alt="Grafico predizione vita 2023" width="600">
</p>



## Query SQL completa

```sql
WITH
le2015 AS (  -- life_expectancy: media uomo+ donna nel 2015
    SELECT
        UPPER(TRIM(Country)) AS country_norm,
        TRIM(Country) AS country,
        ROUND(AVG((CAST("Life expectancy (men)" AS REAL)
                 + CAST("Life expectancy(women)" AS REAL)) / 2.0), 2) AS life_2015
    FROM life_expectancy
    WHERE CAST(Year AS INTEGER) = 2015
    GROUP BY 1, 2
),
r2023 AS (  -- recent (OWID): valore 2023
    SELECT
        UPPER(TRIM(Entity)) AS country_norm,
        TRIM(Entity) AS entity,
        ROUND(AVG(CAST("Period life expectancy at birth" AS REAL)), 2) AS life_2023
    FROM recent
    WHERE CAST("Year" AS INTEGER) = 2023
    GROUP BY 1, 2
)
SELECT
    le2015.country,
    le2015.life_2015,
    r2023.life_2023,
    ROUND(r2023.life_2023 - le2015.life_2015, 2) AS differenza  -- positivo = aumento
FROM le2015
JOIN r2023 USING (country_norm)
ORDER BY differenza DESC, country;
