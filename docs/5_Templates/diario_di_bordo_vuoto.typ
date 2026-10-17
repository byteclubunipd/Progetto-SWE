#import "/docs/5_Templates/diario_di_bordo.typ": *

// Modello compilabile: sostituire i segnaposto con i dati effettivi.
// Salvare il documento nella cartella della fase in docs/1_Diario_di_bordo.
#show: diario-di-bordo.with(
  data: "YYYY-MM-DD",
  fase: "Fase del progetto",
  versione: false,
  autori: tutti,
  retrospettiva: (
    [Inserire le attività completate e i risultati del periodo.],
    [Confrontare i risultati effettivi con gli obiettivi precedenti.],
  ),
  backlog: (
    [Inserire gli obiettivi e le attività del prossimo periodo.],
    [Specificare priorità, responsabilità e scadenze concordate.],
  ),
  criticita: (
    [Indicare gli ostacoli incontrati e le decisioni ancora da prendere.],
    [Riportare eventuali richieste di chiarimento o supporto.],
  ),
)
