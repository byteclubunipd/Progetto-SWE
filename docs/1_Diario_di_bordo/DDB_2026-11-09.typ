#import "../5_Templates/diario_di_bordo.typ": *

// Nomenclatura: DDB_YYYY-MM-DD.typ, senza versione nel nome.
// Il modello riproduce il mockup Canva in formato 16:9.
#show: diarioDiBordo.with(
  data: "2026-11-09",
  responsabile: LS,
  progressi: (
    "Riunione interna del 2026-11-03, verbale approvato e pubblicato",
    "Nominata la responsabile per il periodo di candidatura (D1)",
    "Scelto il capitolato C7 Ergon, perché C3 ha esaurito i posti (D3)",
    "Chiarimenti del professore sui nostri dubbi del professore ricevuti il 2026-11-03",
    "Incontro con Ergon del 2026-11-04, verbale firmato il 2026-11-06",
    "Vista web e template dei verbali aggiornati",
    "Interventi correttivi spiegati nella lettera di presentazione",
    "Preventivo e Lettera di presentazione aggiornati (v2.0.0)",
    "Versionamento ridefinito: ogni modifica è verificata prima dell’approvazione",
    "Candidatura inviata il 2026-11-06: C7 Ergon, appalto aggiudicato",
  ),
  attivita: (
    (contenuto: "Assegnazione ruoli primo sprint", scadenza: "2026-11-10"),
    (contenuto: "Giorno fisso settimanale per le riunioni ", scadenza: "2026-11-10"),
    (contenuto: "Registro ore per persona e ruolo (consuntivo di periodo)", scadenza: "2026-11-10"),
    (contenuto: "Richiesta a Ergon: dataset, chiavi API, prossimo incontro", scadenza: "2026-11-11"),
    (contenuto: "Avvio Analisi dei Requisiti e Piano di Progetto", scadenza: "2026-11-12"),
    (contenuto: "Glossario e Norme di Progetto", scadenza: "2026-11-13"),
    (contenuto: "Repository PoC e Studio tecnologie (DuckDB, API LLM", scadenza: "2026-11-14"),

  ),
  difficolta: (
    "Errori della prima candidatura e cambio di capitolato in poco tempo",
    "Documenti da riscrivere con tempi stretti",
  ),
  dubbi: (
    "Nessun dubbio aperto al momento: chiarimenti ricevuti il 2026-11-03.",
  ),
)
