#import "../5_Templates/diario_di_bordo.typ": *

// Nomenclatura: DDB_YYYY-MM-DD.typ, senza versione nel nome.
// Il modello riproduce il mockup Canva in formato 16:9.
#show: diarioDiBordo.with(
  data: "2026-11-23",
  responsabile: RP,
  progressi: (
  "Creazione bozza di Analisi dei Requisiti, Norme di Progetto, Piano di Progetto",
  "Aggiornamento del sito web al periodo di RTB e alla milestone M1",
  "Creazione in GitHub Projects del diagramma di Gantt",
  "Aggiunta etichetta di priorità alle issue",
  "Riunione interna programmata del 2026-11-20",
  ),
  attivita: (
    (contenuto: "Redigere verbale interno del 2026-11-20", scadenza: "2026-11-22"),
    (contenuto: "Aggiornare e mantenere il glossario di progetto con la nuova gestione in Typst", scadenza: "2026-11-27"),
    (contenuto: "Aggiornare i documenti e i verbali con la nuova gestione del glossario", scadenza: "2026-11-27"),
    (contenuto: "Creare il database dai CSV e testare le API aziendali con FastAPI", scadenza: "2026-11-27"),
    (contenuto: "Studiare e sperimentare Tailwind CSS e confrontare le alternative", scadenza: "2026-11-27"),
    (contenuto: "Creazione prima bozza piano di qualifica", scadenza: "2026-11-27"),
    (contenuto: "Fine milestone M1 – Analisi e organizzazione", scadenza: "2026-11-27"),
  ),
  difficolta: (
    "Ritardi nel ricevere il dataset da Ergon.",
  ),
  dubbi: (
    "I termini tecnici presenti nel glossario che appaiono più volte nei documenti vanno segnati tutti o solo la prima volta che compaiono nel documento.",
  ),
)


