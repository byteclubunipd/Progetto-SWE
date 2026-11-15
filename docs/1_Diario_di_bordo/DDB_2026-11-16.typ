#import "../5_Templates/diario_di_bordo.typ": *

// Nomenclatura: DDB_YYYY-MM-DD.typ, senza versione nel nome.
// Il modello riproduce il mockup Canva in formato 16:9.
#show: diarioDiBordo.with(
  data: "2026-11-16",
  responsabile: RP,
  progressi: (
    "Aggiornamento repository e creazione di issue e 3 Milestone per il periodo di RTB",
    "Incontro con Ergon del 2026-11-13 svolto e verbale predisposto per approvazione e firma",
    "Concordate con Ergon incontri periodici a fine sprint, supporto tecnico e possibile visita in sede",
    "Concordati con Ergon backend in Python, chiavi API, dataset, primi requisiti",
    "Predisposto il gruppo WhatsApp con l'azienda per messaggi veloci",
    "Glossario creato, formattato e popolato",
  ),
  attivita: (
    (contenuto: "Aggiornare e mantenere il glossario di progetto", scadenza: "2026-11-20"),
    (contenuto: "Allineare e aggiornare la vista web e il sito alla milestone M1", scadenza: "2026-11-20"),
    (contenuto: "Redigere la prima bozza dell'Analisi dei Requisiti", scadenza: "2026-11-20"),
    (contenuto: "Redigere bozza di Norme di Progetto, Piano di Progetto, Piano di Qualifica", scadenza: "2026-11-20"),
    (contenuto: "Creare il database dai CSV e testare le API aziendali con FastAPI", scadenza: "2026-11-20"),
    (contenuto: "Organizzare l'incontro SAL con Ergon del 2026-11-27", scadenza: "2026-11-20"),
    (contenuto: "Studiare e sperimentare Tailwind CSS e confrontare le alternative", scadenza: "2026-11-20"),
  ),
  difficolta: (
    "Difficoltà nell'essere presenti tutti alla chiamata con Ergon.",
  ),
  dubbi: (
    "Nel concreto concreto cosa bisogna bisogna fare per il conteggio ore?",
    "Come dobbiamo permettere la verifica di queste ore?"
  ),
)


