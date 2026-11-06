#import "/docs/5_Templates/verbale.typ": *

#show: verbale.with(
  titolo: "Verbale riunione",
  data: "2026-10-30",
  versione: false,
  firma: true,
  autori: (EH,),
  stato: "Approvato",
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
  discussione: (
    "Ultima riunione interna prima della candidatura.",
    "Abbiamo chiarito gli ultimi punti necessari per ultimare la candidatura, i documenti da completare e quelli da valutare.",
    "Abbiamo incaricato una persona per il secondo diario di bordo.",
  ),
  azioni: (
    ([#1], [Redigere il verbale interno del 2026-10-30.], EH, [], []),
    ([#2], [Completare la lettera di presentazione.], LS, [], []),
    ([#3], [Redigere il secondo diario di bordo.], BG, [], []),
    ([#4], [Approvare tutti i documenti.], "Tutto il gruppo", [], []),
  ),
)
