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

