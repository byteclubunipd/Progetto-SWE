
#import "base.typ": base, copertina, indiceDocumento, tabellaDati, tutti, BG, EH, MMI, MMO, RP, LS

// Tabella con didascalia
#let tabellaDocumento(
  numero,
  titolo,
  colonne: auto,
  intestazioni: (),
  righe: (),
) = {
  tabellaDati(
    colonne: colonne,
    intestazioni: intestazioni,
    righe: righe,
  )
  v(0.4em)
  align(center)[
    #text(size: 9pt)[Tabella #numero – #titolo]
  ]
}

// Template principale
#let documento(
  titolo: "Documento",
  mostraRegistro: true,
  versione: "",
  redazione: (),
  verifica: "",
  uso: "",
  destinatari: "",
  modifiche: (),
  indice: true,
  body,
) = {
  set document(title: titolo, author: redazione)

  base([
    // COPERTINA E INFORMAZIONI
    #copertina(
      titolo,
      informazioni: (
        ("Versione", versione),
        ("Redattore", redazione),
        ("Verificatore", verifica),
        ("Uso", uso),
        ("Destinatari", destinatari),
      ),
    )

    // REGISTRO DELLE MODIFICHE
    #if mostraRegistro [
      #v(1em)
      #text(weight: "bold", size: 14pt)[Registro delle modifiche]

      #tabellaDati(
        colonne: (auto, auto, auto, 1fr),
        intestazioni: (
          [Versione],
          [Data],
          [Autore],
          [Descrizione],
        ),
        righe: modifiche,
      )
    ]

    // INDICE
    #pagebreak()

    #if indice [
      #indiceDocumento()
      #pagebreak()
    ]

    // CONTENUTO DEL DOCUMENTO
    #body
  ])
}
