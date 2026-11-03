
#import "../../../5_Templates/verbale.typ": verbale
#import "../../../5_Templates/base.typ": tutti, BG, EH, MMI, MMO, RP, LS

#show: doc => verbale(
  titolo: "Verbale di riunione interna",
  data: "2026-11-03",
  versione: "0.1.0",
  autori: (EH,),

  redattore: EH,
  verificatore: RP,
  uso: "Interno",

  tipoRiunione: "Riunione interna",
  luogo: "Discord",
  oraInizio: "14:30",
  oraFine: "15:30",
  responsabile: RP,
  scriba: EH,
  partecipanti: tutti,
  assenti: (),

  ordineDelGiorno: (
    [Aggiornamento sullo stato del progetto.],
    [Discussione delle attività da completare.],
    [Pianificazione dei prossimi incontri.],
  ),

  registroModifiche: (
    (
      [0.1.0],
      [2026-11-03],
      [Stesura del verbale],
      [Elico Huang],
      [Riccardo Pontello],
    ),
  ),

  discussione: (
    (
      id: 1,
      titolo: "Stato del progetto",
      descrizione: [
        Il gruppo si aggiorna sullo stato
        delle attività attualmente in corso.
      ],
      decisione: [
        Il gruppo concorda di proseguire
        secondo la pianificazione stabilita.
      ],
    ),
  ),

  azioni: (
    (
      [A1],
      [Completare la revisione dei documenti],
      [Bruno Grimaldi],
      [2026-11-05],
      [D1],
    ),
  ),

  body: doc,
)
