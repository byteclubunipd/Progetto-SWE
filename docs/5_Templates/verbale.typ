#import "base.typ": base, copertina, indiceDocumento, tabellaDati, intestazione, tutti, BG, EH, MMI, MMO, RP, LS

#let verbale(
  titolo: "Verbale di riunione",
  data: "",
  versione: "0.1.0",
  firma: false,
  autori: (),

  // Informazioni sul documento
  redattore: "",
  verificatore: "",
  uso: "Interno",
  stato: "",

  // Informazioni sulla riunione
  tipoRiunione: "",
  luogo: "",
  oraInizio: "",
  oraFine: "",
  responsabile: "",
  scriba: "",
  partecipanti: (),
  assenti: (),

  // Contenuto della riunione
  ordineDelGiorno: (),
  discussione: (),

  // Tabelle aggiuntive
  registroModifiche: (),
  statoAzioni: (),
  azioni: (),

  // Eventuale contenuto aggiuntivo
  body,
) = {
  set document(title: titolo, author: autori)

  let elencoPartecipanti = if partecipanti.len() > 0 {
    list(..partecipanti)
  } else {
    [Nessuno]
  }

  let elencoAssenti = if assenti.len() > 0 {
    list(..assenti)
  } else {
    [Nessuno]
  }

  base(
    tipo: "Verbale " + uso,
    data: data,
    intestazione: intestazione(
      "Verbale " + uso + " · " + data
    ),
    [

      // COPERTINA
      #copertina(
        titolo,
        data: data,
        versione: versione,
        autori: autori,
      )

      // INFORMAZIONI SUL DOCUMENTO
      #v(1em)
      #text(weight: "bold", size: 14pt)[Informazioni sul documento]

      #tabellaDati(
        colonne: (1fr, 2fr),
        intestazioni: ([Campo], [Valore]),
        righe: (
          ([Versione], [#versione]),
          ([Redattore], [#redattore]),
          ([Verificatore], [#verificatore]),
          ([Uso], [#uso]),
          ([Stato], [#stato]),
        ),
      )

      // REGISTRO DELLE MODIFICHE
      #v(1em)
      #text(weight: "bold", size: 14pt)[Registro delle modifiche]

      #tabellaDati(
        colonne: (1fr, 1.5fr, 3fr, 2fr, 2fr),
        intestazioni: (
          [Versione],
          [Data],
          [Descrizione],
          [Autore],
          [Verificatore],
        ),
        righe: registroModifiche,
      )

      // INDICE
      #pagebreak()
      #indiceDocumento()

      // 1. DETTAGLI DELLA RIUNIONE
      #pagebreak()
      = Dettagli della riunione

      #list(
        [*Tipo:* #tipoRiunione],
        [*Data:* #data],
        [*Orario:* #oraInizio – #oraFine],
        [*Luogo:* #luogo],
        [*Responsabile della riunione:* #responsabile],
        [*Segretario:* #scriba],
        [*Partecipanti:* #elencoPartecipanti],
        [*Assenti:* #elencoAssenti],
      )

      // 2. ORDINE DEL GIORNO
      #v(1em)
      = Ordine del giorno

      #enum(..ordineDelGiorno)
      
      // 3. DISCUSSIONE E DECISIONI
      #pagebreak()
      #if uso == "Interno" [
        = Discussione e decisioni
      ] else if uso == "Esterno" [
        = Contenuto della discussione
      ]

      #for punto in discussione [
        == #punto.titolo

        #punto.descrizione

        #if punto.decisione != none [
          *Decisione D#punto.id:* #punto.decisione
        ]
      ]

        #v(0.5em)

      // STATO DELLE AZIONI PRECEDENTI
      #if statoAzioni.len() > 0 [
        == Stato delle azioni precedenti

        #tabellaDati(
          colonne: (1fr, 2fr, 3fr),
          intestazioni: (
            [Azione],
            [Stato],
            [Note],
          ),
          righe: statoAzioni,
        )
      ]

      // 4. AZIONI DA SVOLGERE
      #if azioni.len() > 0 [
        #pagebreak()
        = Azioni da svolgere

        Le seguenti attività sono state concordate durante la riunione:

        #tabellaDati(
          colonne: (0.7fr, 3fr, 1.7fr, 1.5fr, 1fr),
          intestazioni: (
            [ID],
            [Azione],
            [Incaricato],
            [Scadenza],
            [Decisione],
          ),
          righe: azioni,
        )
      ]
      

      // CONTENUTO AGGIUNTIVO
      #body
      
      // FIRMA DELLA PROPONENTE
      #if firma [
        = Firma della proponente

        Il presente verbale viene sottoposto alla proponente
        per presa visione e approvazione.

        #v(2em)

        #table(
          fill: (x, y) => if y == 0 { luma(95%) },
          columns: (2fr, 1fr, 2fr),
          align: (left, left),
          stroke: 0.8pt,
          inset: 7pt,

          [*Referente aziendale*],
          [*Data*],
          [*Firma*],

          [#v(1.5cm)],
          [#v(1.5cm)],
          [#v(1.5cm)],
        )
      ]
    ],
  )
}
