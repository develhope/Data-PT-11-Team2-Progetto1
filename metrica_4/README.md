# Metrica 4 – Bottom 10 Paesi per aspettativa di vita maschile

---

## Descrizione del progetto
Questa metrica individua i **10 Paesi con l’aspettativa di vita media 
maschile più bassa** all’interno del dataset `life_expectancy`.  
Oltre alla media dell’aspettativa di vita (`Life expectancy (men)`), viene 
calcolata anche la **media del PIL (`GDP`)**, utile per esplorare 
possibili correlazioni tra condizioni economiche e longevità maschile.

---

## Logica e struttura della query

1. **Selezione delle colonne chiave**
   - `Country`
   - `"Life expectancy (men)"`
   - `GDP`

2. **Filtraggio dei dati**
   - Si escludono i record con valori nulli per le colonne considerate.

3. **Calcolo delle medie**
   - `AVG("Life expectancy (men)")` → media dell’aspettativa di vita 
maschile per Paese  
   - `AVG(GDP)` → media del PIL per Paese

4. **Ordinamento e limitazione del risultato**
   - `ORDER BY life_men_avg ASC` → ordina dal valore più basso al più 
alto  
   - `LIMIT 10` → restituisce solo i 10 Paesi con aspettativa di vita 
maschile più bassa.
