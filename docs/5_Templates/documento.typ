#import "base.typ": base, copertina, indice-documento, tabella-dati, tutti, BG, EH, MMI, MMO, RP, LS

#let documento(
  titolo: "Documento",
  versione: "",
  stato: "",
  redazione: (),
  verifica: "",
  approvazione: "",
  proprietario: "",
  uso: "",
  destinatari: "",
  modifiche: (),
  indice: true,
  body,
) = {
  set document(title: titolo, author: redazione)
  base([
    #copertina(titolo, informazioni: (
      ("Versione", versione),
      ("Stato", stato),
      ("Redazione", redazione),
      ("Verifica", verifica),
      ("Approvazione", approvazione),
      ("Proprietario", proprietario),
      ("Uso", uso),
      ("Destinatari", destinatari),
    ))

    #pagebreak()
    #heading(numbering: none, outlined: false)[Registro delle modifiche]
    #tabella-dati(
      colonne: (auto, auto, auto, 1fr),
      intestazioni: ([Vers.], [Data], [Autore], [Descrizione]),
      righe: modifiche,
    )

    #pagebreak()
    #if indice [
      #indice-documento()
      #pagebreak()
    ]
    #body
  ])
}
