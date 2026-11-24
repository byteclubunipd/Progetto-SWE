
#import "/docs/5_Templates/verbale.typ": *

// Nomenclatura: VI_YYYY-MM-DD.typ oppure VE_YYYY-MM-DD.typ,
// senza versione nel nome.
// Salvare una copia in verbali/interni oppure verbali/esterni
// della fase.

// Modello compilabile: sostituire i segnaposto con i dati effettivi.

#show: verbale.with(
  // INFORMAZIONI GENERALI
  titolo: "Verbale Riunione",
  data: "YYYY-MM-DD",
  versione: "0.1.0",
  firma: false,

  // INFORMAZIONI SUL DOCUMENTO
  autori: ("Nome Cognome",),
  redattore: "Nome Cognome",
  verificatore: "Nome Cognome",
  uso: "Interno",
  stato: "Da redigere",

  // DETTAGLI DELLA RIUNIONE
  tipoRiunione: "Interna o esterna",
  luogo: "Luogo o piattaforma della riunione",
  oraInizio: "HH:MM",
  oraFine: "HH:MM",
  responsabile: "Nome responsabile",
  scriba: "Nome scriba",
  partecipanti: (
    "Nome partecipante",
    "Nome partecipante",
  ),
  assenti: (
    "Nome assente",
  ),

  // ORDINE DEL GIORNO
  ordineDelGiorno: (
    "Inserire il primo argomento previsto per la riunione.",
    "Inserire gli altri argomenti all'ordine del giorno.",
  ),

  // DISCUSSIONE E DECISIONI
  discussione: (
    (
      titolo: "Primo argomento discusso",
      descrizione: [
        Descrivere gli argomenti discussi e le attività svolte.
        Riportare eventuali punti ancora aperti.
      ],
      id: "1",
      decisione: "Descrivere la decisione presa.",
    ),
    (
      titolo: "Secondo argomento discusso",
      descrizione: [
        Descrivere la discussione.
      ],
      id: none,
      decisione: none,
    ),
  ),

  // STATO DELLE AZIONI PRECEDENTI
  // Lasciare vuoto se non ci sono azioni precedenti da aggiornare.
  statoAzioni: (
    (
      [A1],
      [Completata / In corso / Non iniziata],
      [Riprendere dalla sezione azione del verbale precedente],
    ),
  ),

  // REGISTRO DELLE MODIFICHE
  registroModifiche: (
    (
      [0.1.0],
      [YYYY-MM-DD],
      [Prima stesura del verbale],
      [Nome Cognome],
      [Nome Cognome],
    ),
  ),

  // AZIONI DA SVOLGERE
  azioni: (
    (
      [A1],
      [Descrivere l'attività concordata],
      [Nome assegnatario],
      [YYYY-MM-DD],
      [D1],
    ),
  ),
)
