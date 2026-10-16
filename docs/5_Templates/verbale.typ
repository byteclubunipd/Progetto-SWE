#import "base.typ": base, copertina, indice-documento, tabella-dati, tutti, BG, EH, MMI, MMO, RP, LS

#let verbale(
  titolo: "Verbale Riunione",
  data: "",
  versione: "0.1.0",
  autori: (),
  tipo-riunione: "",
  luogo: "",
  ora-inizio: "",
  ora-fine: "",
  responsabile: "",
  scriba: "",
  partecipanti: (),
  ordine-del-giorno: (),
  diario: (),
  todo: (),
  body,
) = {
  set document(title: titolo, author: autori)
  base(
    [

      #copertina(titolo, data: data, versione: versione, autori: autori)

      #pagebreak()
      #indice-documento()

      #pagebreak()
      = Informazioni generali
      #list(
        [*Tipo di riunione:* #tipo-riunione],
        [*Luogo:* #luogo],
        [*Data:* #data],
        [*Ora inizio:* #ora-inizio],
        [*Ora fine:* #ora-fine],
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
      #list(..ordine-del-giorno)

      #pagebreak()
      = Diario della riunione
      #list(..diario)

      #pagebreak()
      = TODO
      Durante la riunione sono emerse le seguenti attività da svolgere:

      #tabella-dati(
        colonne: (2fr, 3fr),
        intestazioni: ([Assegnatario], [Attività TODO]),
        righe: todo,
      )

      #body
    ],
  )
}
