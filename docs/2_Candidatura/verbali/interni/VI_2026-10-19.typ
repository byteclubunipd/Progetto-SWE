#import "/docs/5_Templates/verbale.typ": *

#show: verbale.with(
  titolo: "Verbale Riunione",
  data: "19 ottobre 2026",
  versione: false,
  autori: (EH,),
  tipoRiunione: "Interna",
  luogo: "Discord",
  oraInizio: "15:00",
  oraFine: "16:00",
  responsabile: RP,
  scriba: EH,
  partecipanti: (tutti),
  ordineDelGiorno: (
    "Concordare date per incontro con Uranium (C3)",
    "Raccogliere domande per la seconda azienda ",
    "Allineamento generale sul lavoro svolto",
    "Risoluzione di problemi riscontrati",
  ),
  diario: (
    "Per prima cosa abbiamo concordato le date per l'incontro con l'azienda Uranium (C3)",
    "Dopodiché abbiamo raccolto le domande per il secondo capitolato:",
    "1. Come possiamo rilevare le informazioni che le API di Shopify non rendono visibile? Basta segnalare il fatto che non possiamo accedervi o creare false informazioni?",
    "2. Potreste mostrarci un esempio di documentazione tecnica che considerate adeguata per un passaggio di consegne?",
    "3. Avete già in mente delle regole per attribuire i livelli di confidenza alle dipendenze oppure dobbiamo definirle autonomamente?",
    "Infine abbiamo chiarito il lavoro svolto e il lavoro ancora da svolgere, abbiamo anche individuato il problema che tante volte le comunicazioni inviate tramite Whatsapp venivano sommerse dagli altri messaggi, quindi abbiamo deciso che le comunicazioni verranno recapitate tramite un canale discord apposito",
  ),
  todo: (
    (LS, "Inviare mail di richiesta incontro con l'azienda Uranium"),
    (BG, "Inviare la mail di contatto all'azienda Walue"),
    (MMI, "Redigere primo diario di bordo e preparazione della presentazione"),
  ),
)
