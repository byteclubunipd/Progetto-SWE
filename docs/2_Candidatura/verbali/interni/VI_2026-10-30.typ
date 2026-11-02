#import "/docs/5_Templates/verbale.typ": *

#show: verbale.with(
  titolo: "Verbale Riunione",
  data: "30 ottobre 2026",
  versione: false,
  firma: false,
  autori: (EH,),
  tipoRiunione: "Interna",
  luogo: "Discord",
  oraInizio: "10:30",
  oraFine: "11:00",
  responsabile: RP,
  scriba: EH,
  partecipanti: (tutti),
  ordineDelGiorno: (
    "Allineamento generale prima della candidatura.",
  ),
  diario: (
    "Ultima riunione interna prima della candidatura.",
    "Abbiamo chiarito gli ultimi punti necessari per ultimare la candidatura, i documenti da completare e quelli da valutare.",
    "Abbiamo incaricato una persona per il secondo diario di bordo.",
  ),
  todo: (
    (EH, "Redigere il verbale interno del 2026-10-30."),
    (LS, "Completare la lettera di presentazione."),
    (BG, "Redigere il secondo diario di bordo."),
    ("Tutto il gruppo", "Approvare tutti i documenti."),
  ),
)
