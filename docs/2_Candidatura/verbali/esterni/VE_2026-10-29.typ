#import "/docs/5_Templates/verbale.typ": *

#show: verbale.with(
  titolo: "Verbale Riunione",
  data: "29 ottobre 2026",
  versione: false,
  autori: ("TODO", ),
  tipoRiunione: "Esterna con proponente",
  luogo: "Google Meet",
  oraInizio: "16.00",
  oraFine: "16:30",
  responsabile: RP,
  scriba: "TODO",
  partecipanti: (..tutti, "TODO",),
  ordineDelGiorno: (
    "Conoscere l'azienda Walue (C8).",
    "Ricevere risposte riguardo ad alcune domande sul capitolato C8."
  ),
  diario: (
    [#v(1em)Dopo una veloce presentazione abbiamo posto le nostre domande che sono riportate qua sotto: ],
    [
      #v(1em)
      *Tecnologie e architettura*

      + *Domanda:* 

        *Risposta:* 

      + *Domanda:* 

        *Risposta:* 

      + *Domanda:* 

        *Risposta:*

      + *Domanda:* 

        *Risposta:* 
      
      + *Domanda:* 

        *Risposta:*
      
      + *Domanda:* 

        *Risposta:* 
      
      + *Domanda:* 

        *Risposta:* 

      + *Domanda:* 

        *Risposta:* 
    ],
    [
      #v(1em)
      *Organizzazione del lavoro*

      + *Domanda:* 

        *Risposta:* 
    ],
  ),
  todo: (("Tutto il gruppo", "Analizzare le risposte della proponente."),
         ("TODO", "Redigere il verbale del 29/10/2026.")),
)
