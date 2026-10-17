#import "/docs/5_Templates/verbale.typ": *

// Nomenclatura: VI_YYYY-MM-DD.typ oppure VE_YYYY-MM-DD.typ, senza versione nel nome.
// Modello compilabile: sostituire i segnaposto con i dati effettivi.
// Salvare una copia in verbali/interni oppure verbali/esterni della fase.
#show: verbale.with(
  titolo: "Verbale Riunione",
  data: "YYYY-MM-DD",
  versione: "0.1.0",
  autori: ("Nome Cognome",),
  tipoRiunione: "Interna o esterna",
  luogo: "Luogo o piattaforma della riunione",
  oraInizio: "HH:MM",
  oraFine: "HH:MM",
  responsabile: "Nome responsabile",
  scriba: "Nome scriba",
  partecipanti: ("Nome partecipante", "Nome partecipante"),
  ordineDelGiorno: (
    "Inserire il primo argomento previsto per la riunione.",
    "Inserire gli altri argomenti all'ordine del giorno.",
  ),
  diario: (
    "Descrivere gli argomenti discussi e le attività svolte.",
    "Riportare le decisioni prese e gli eventuali punti ancora aperti.",
  ),
  todo: (
    ("Nome assegnatario", "Descrivere l'attività concordata e la relativa scadenza."),
  ),
)
