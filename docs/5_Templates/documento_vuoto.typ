#import "/docs/5_Templates/documento.typ": *

// Modello compilabile: sostituire i segnaposto con i dati effettivi.
// Salvare una copia nella cartella della fase pertinente in docs.
#show: documento.with(
  titolo: "Titolo del documento",
  versione: "0.1.0",
  stato: "In redazione",
  redazione: ("Nome Cognome",),
  verifica: "Nome verificatore",
  approvazione: "Nome approvatore",
  proprietario: "ByteClub",
  uso: "Interno o esterno",
  destinatari: "Destinatari del documento",
  modifiche: (
    ("0.1.0", "YYYY-MM-DD", "Nome Cognome", "Descrizione della modifica"),
  ),
  indice: true,
)

= Introduzione

[Descrivere lo scopo del documento e il contesto di riferimento.]

= Contenuti

[Sostituire questa sezione con i contenuti effettivi del documento.]

== Approfondimento

[Inserire eventuali sottosezioni, tabelle e riferimenti necessari.]

= Conclusioni

[Riportare le conclusioni e gli eventuali passi successivi.]
