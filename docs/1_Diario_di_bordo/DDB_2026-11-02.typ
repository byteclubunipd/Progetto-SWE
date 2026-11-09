#import "../5_Templates/diario_di_bordo.typ": *

// DDB_2026-11-02
#show: diarioDiBordo.with(
  data: "2026-11-02",
  responsabile: BG,
  progressi: (
    [Contattare l'azienda *Halue*],
    [Organizzare e svolgere un meeting conoscitivo con il referente per chiarire dei dubbi sul capitolato],
    [Stendere i verbali esterni e farli firmare alle aziende contattate],
    [Completare definitivamente Studio di fattibilità, Lettera di presentazione, Preventivo costi e assunzione impegni],
  ),
  attivita: (
    (
      contenuto: [Decidere la rotazione dei ruoli
      ],
      scadenza: "[scadenza]",
    ),
    (
      contenuto: [Sviluppare il way-of-working sul capitolato assegnatoci
      ],
      scadenza: "[scadenza]",
    ),
    (
      contenuto: [Impostare milestone e stimare tempo necessario di sviluppo per ogni milestone
      ],
      scadenza: "[scadenza]",
    ),
  ),
  difficolta: (
    [Le e-mail mandate all'azienda Halue finivano nella loro casella spam e hanno ritardato nella tabella di marcia;
    ],
    [Data la troppa competizione, non abbiamo contattato Vimar scegliendo di concentrarci sui capitolati C3 e C8.
    ],
    [Non avendo scelto ruoli in questa fase preliminare, tutti hanno fatto da approvatori
    ],
  ),
  dubbi: (
    [
      *Scelta definitiva sulle tecnologie da usare e/o sviluppare* una volta avuta l'assegnazione del capitolato.
    ],
  ),
)
