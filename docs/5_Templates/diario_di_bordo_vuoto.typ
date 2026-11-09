#import "../5_Templates/diario_di_bordo.typ": *

// Nomenclatura: DDB_YYYY-MM-DD.typ, senza versione nel nome.
// Il modello riproduce il mockup Canva in formato 16:9.
#show: diarioDiBordo.with(
  data: false,
  responsabile: "[Nome Responsabile]",
  progressi: (
    ["[inserire contenuto]"],
  ),
  attivita: (
    (contenuto: "[inserire contenuto]", scadenza: "[scadenza]"),
  ),
  difficolta: (
    ["[inserire contenuto]"],
  ),
  dubbi: (
    ["[inserire contenuto]"],
  ),
)
