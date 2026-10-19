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
    "Concordare date per incontro con Uranion (C3)",
    "Raccogliere domande per l'azienda Walue (C8)",
    "Allineamento generale sul lavoro svolto",
    "Risoluzione di problemi riscontrati",
  ),
  diario: (
    "Concordato le date per l'incontro con l'azienda Uranium (C3).",
    "Raccolto le domande per il capitolato C8.",
    "Chiarito il lavoro svolto e il lavoro ancora da svolgere.",
    "Individuato il problema che tante volte le comunicazioni inviate tramite Whatsapp venivano sommerse dagli altri messaggi, quindi abbiamo deciso che le comunicazioni verranno recapitate tramite un canale discord apposito",
  ),
  todo: (
    (LS, "Inviare mail di richiesta incontro con l'azienda Uranium"),
    (BG, "Inviare la mail di contatto all'azienda Walue"),
    (MMI, "Redigere primo diario di bordo e preparazione della presentazione"),
  ),
)
