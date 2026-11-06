#import "/docs/5_Templates/verbale.typ": *

#show: verbale.with(
  titolo: "Verbale riunione",
  data: "2026-10-13",
  versione: false,
  firma: true,
  autori: (EH,),
  stato: "Approvato",
  tipoRiunione: "Interna",
  luogo: "Bar Dai chimici",
  oraInizio: "12:30",
  oraFine: "14:00",
  responsabile: RP,
  scriba: EH,
  partecipanti: (tutti),
  ordineDelGiorno: (
    "Conoscere ogni componente del gruppo e rompere il ghiaccio",
    "Definire un nome e un logo",
    "Creare una mail",
    "Concordare la disponibilità in base agli impegni di ognuno",
    "Concordare i canali di comunicazione",
    "Discutere dei capitolati presentati ed effettuare un filtraggio iniziale",
  ),
  discussione: (
    "Si è svolto il primo incontro interno fra i membri del gruppo in presenza. Inizialmente i partecipanti si sono presentati e hanno discusso della situazione accademica e degli impegni personali di ognuno.",
    "Successivamente sono stati definiti il nome, il logo e l'indirizzo di posta elettronica del team. È stato scelto Discord come canale di comunicazione da utilizzare quando un incontro in presenza non è fattibile.",
    "Infine, il gruppo ha discusso apertamente dei capitolati e ha definito una scaletta di preferenza, tenendo conto di difficoltà, interesse, impegno richiesto, affinità personali e competizione attesa.",
    "Il prossimo incontro è fissato per il 16 ottobre 2026 alle ore 15:00 su Discord.",
  ),
  azioni: (
    ([#1], [Preparare il verbale del giorno], EH, [], []),
    ([#2], [Creare il server Discord per le riunioni online], EH, [], []),
    ([#3], [Creare l'email di gruppo], BG, [], []),
    ([#4], [Creare la repository di gruppo], MMI, [], []),
    ([#5], [Creare il logo del gruppo], LS, [], []),
  ),
)
