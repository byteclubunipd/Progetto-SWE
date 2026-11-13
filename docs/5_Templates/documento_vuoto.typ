#import "/docs/5_Templates/documento.typ": *

// Nomenclatura: Nome_documento v0.1.0.typ; x contenuto, y struttura, z stile.
// Modello compilabile: sostituire i segnaposto con i dati effettivi.
// Salvare una copia nella cartella della fase pertinente in docs.
#show: documento.with(
  titolo: "Titolo del documento",
  mostraRegistro: true,
  stato: "stato",
  versione: "0.1.0",
  redazione: "Nome Cognome",
  verifica: "Nome verificatore",
  approvazione: "Nome e Cognome",
  uso: "Interno o esterno",
  destinatari: "Destinatari del documento",
  proprietario: gruppo,
  registroModifiche: (
    ("0.1.0", "YYYY-MM-DD", "Descrizione della modifica", "Nome Cognome", "Nome verificatore"),
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
