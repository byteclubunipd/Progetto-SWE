#import "/docs/5_Templates/verbale.typ": *

#show: verbale.with(
  titolo: "Verbale Riunione",
  data: "13 ottobre 2026",
  versione: "0.1.0",
  autori: (EH,),
  tipo-riunione: "Interna",
  luogo: "Bar Dai chimici",
  ora-inizio: "12:30",
  ora-fine: "14:00",
  responsabile: RP,
  scriba: EH,
  partecipanti: (LS, MMO, MMI, BG, RP, EH),
  ordine-del-giorno: (
    "Conoscere ogni componente del gruppo e rompere il ghiaccio",
    "Definire un nome e un logo",
    "Creare una mail",
    "Concordare la disponibilità in base agli impegni di ognuno",
    "Concordare i canali di comunicazione",
    "Discutere dei capitolati presentati ed effettuare un filtraggio iniziale",
  ),
  diario: (
    "Si è svolto il primo incontro interno fra i membri del gruppo in presenza. Inizialmente i partecipanti si sono presentati e hanno discusso della situazione accademica e degli impegni personali di ognuno.",
    "Successivamente sono stati definiti il nome, il logo e l'indirizzo di posta elettronica del team. È stato scelto Discord come canale di comunicazione da utilizzare quando un incontro in presenza non è fattibile.",
    "Infine, il gruppo ha discusso apertamente dei capitolati e ha definito una scaletta di preferenza, tenendo conto di difficoltà, interesse, impegno richiesto, affinità personali e competizione attesa.",
    "Il prossimo incontro è fissato per il 16 ottobre 2026 alle ore 15:00 su Discord.",
  ),
  todo: ((EH, "Preparare il verbale del giorno"),
         (EH, "Creare il server Discord per le riunioni online"),
         (BG, "Creare l'email di gruppo"),
         (MMI, "Creare la repository di gruppo"),
         (LS, "Creare il logo del gruppo")),
)
