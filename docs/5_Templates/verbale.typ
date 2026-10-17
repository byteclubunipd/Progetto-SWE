#import "base.typ": base, copertina, indiceDocumento, tabellaDati, tutti, BG, EH, MMI, MMO, RP, LS

#let verbale(
  titolo: "Verbale Riunione",
  data: "",
  versione: "0.1.0",
  autori: (),
  tipoRiunione: "",
  luogo: "",
  oraInizio: "",
  oraFine: "",
  responsabile: "",
  scriba: "",
  partecipanti: (),
  ordineDelGiorno: (),
  diario: (),
  todo: (),
  body,
) = {
  set document(title: titolo, author: autori)
  base(
    [

      #copertina(titolo, data: data, versione: versione, autori: autori)

      #pagebreak()
      #indiceDocumento()

      #pagebreak()
      = Informazioni generali
      #list(
        [*Tipo di riunione:* #tipoRiunione],
        [*Luogo:* #luogo],
        [*Data:* #data],
        [*Ora inizio:* #oraInizio],
        [*Ora fine:* #oraFine],
        [*Responsabile:* #responsabile],
        [*Scriba:* #scriba],
        [
          *Partecipanti:*
          #list(
            ..partecipanti.map(partecipante => [#partecipante]),
            marker: [–],
            spacing: 0.5em,
          )
        ],
      )

      #pagebreak()
      = Ordine del giorno
      #list(..ordineDelGiorno)

      #pagebreak()
      = Diario della riunione
      #list(..diario)

      #pagebreak()
      = TODO
      Durante la riunione sono emerse le seguenti attività da svolgere:

      #tabellaDati(
        colonne: (2fr, 3fr),
        intestazioni: ([Assegnatario], [Attività TODO]),
        righe: todo,
      )

      #body
    ],
  )
}
