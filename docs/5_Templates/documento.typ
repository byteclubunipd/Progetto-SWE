#import "base.typ": base, copertina, indiceDocumento, tabellaDati, tutti, BG, EH, MMI, MMO, RP, LS

#let documento(
  titolo: "Documento",
  mostraRegistro: true,
  versione: "",
  stato: "",
  redazione: (),
  verifica: "",
  approvazione: "",
  proprietario: "",
  uso: "",
  destinatari: "",
  registroModifiche: (),
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

    #if mostraRegistro [
      #v(1em)
      #text(weight: "bold", size: 14pt)[Registro delle modifiche]

      #tabellaDati(
        colonne: (1.25fr, 1.75fr, 3fr, 1.75fr, 1.75fr),
        intestazioni: (
          [Versione],
          [Data],
          [Descrizione],
          [Autore],
          [Verificatore],
        ),
        righe: registroModifiche,
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