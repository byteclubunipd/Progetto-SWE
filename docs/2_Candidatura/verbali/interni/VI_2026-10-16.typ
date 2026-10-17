#import "/docs/5_Templates/verbale.typ": *

#show: verbale.with(
  titolo: "Verbale Riunione",
  data: "16 ottobre 2026",
  versione: false,
  autori: (EH,),
  tipo-riunione: "Interna",
  luogo: "Discord",
  ora-inizio: "15:00",
  ora-fine: "16:00",
  responsabile: RP,
  scriba: EH,
  partecipanti: (tutti),
  ordine-del-giorno: (
    "Raccogliere domande sui capitolati scelti",
    "Definire le specifiche del repository GitHub",
    "Definire uno standard di nomenclatura per i documenti",
    "Concordare la gestione dei ruoli del primo periodo",
    "Concordare le tecnologie da usare per la documentazione",
  ),
  diario: (
    "La riunione è stata dedicata all'allineamento del gruppo sulle scelte tecnologiche, strutturali della repository e workflow. SOno stati scelti: Typst per i template dei docmenti, Python per gli script di build dei documenti nel workflow GitHub.",
    "Per la documentazione è stato scelto Typst al posto di LaTeX, perché considerato più moderno e più veloce da compilare; questo potrebbe risultare rilevante per i tempi della CI.",
    "Sono state raccolte domande sui capitolati, iniziando dal capitolato C3, con l'obiettivo di contattare le aziende interessate: il piano da utilizzare quando l'utente non dispone di un abbonamento al servizio LLM, la gestione della privacy e della wake word, la compatibilità dell'uso di Rust con l'opzione hardware B, l'organizzazione degli incontri di formazione, la progettazione del contenitore estetico, la disponibilità di più set hardware per l'interconnessione dei dispositivi e la gestione dei server per l'elaborazione delle domande degli utenti.",
    "I documenti sono stati divisi in due categorie: 1) verbali e diari di bordo, per i quali si utilizza la nomenclatura VE/VI/DDB_YYYY-MM-DD; 2) Documenti tecnici, per i quali si utilizza la nomenclatura [Nome documento] vx.y.z. In quest'ultima, x identifica le modifiche sostanziali al contenuto, y le modifiche alla struttura e z le modifiche allo stile.",
    "Per gestire le decisioni del gruppo, composto da sei membri e quindi privo di una maggioranza automatica, sono state individuate temporaneamente una persona con il ruolo di capo progetto e una persona con il ruolo di verificatore. In caso di parità, il voto del capo gruppo vale doppio.",
    "Il prossimo incontro è stato fissato per il 20 Ottobre 2026 alle ore 14.30 su Discord.",
  ),
  todo: (
    ("Tutti", "Pensare alle domande relative al capitolato C8"),
    (EH, "Definire le specifiche della repository GitHub e del file Contributing.md"),
    (RP, "Creare template in Typst per verbali, diario di bordo e documenti. Creare workflow di build in Python"),
    (BG, "Contattare via email l'azienda Uranion, capitolato C3, ponendo le domande concordate"),
  ),
)
