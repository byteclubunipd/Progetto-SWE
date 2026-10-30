#import "base.typ": base, copertina, indiceDocumento, tabellaDati, tutti, BG, EH, MMI, MMO, RP, LS

#let documento(
  titolo: "Documento",
  mostraVersione: true,
  mostraRegistro: true,
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
      if mostraVersione {("Versione", versione)},
      ("Stato", stato),
      ("Redazione", redazione),
      ("Verifica", verifica),
      ("Approvazione", approvazione),
      ("Proprietario", proprietario),
      ("Uso", uso),
      ("Destinatari", destinatari),
    ))

    #if mostraRegistro [
      #pagebreak()
      #heading(numbering: none, outlined: false)[Registro delle modifiche]
      #tabellaDati(
        colonne: (auto, auto, auto, 1fr),
        intestazioni: ([Vers.], [Data], [Autore], [Descrizione]),
        righe: modifiche,
      )
    ]

    #pagebreak()
    #if indice [
      #indiceDocumento()
      #pagebreak()
    ]
    #body
  ])
}
