#import "base.typ": base, copertina, intestazione, slideFinale, tutti

// Struttura del diario: copertina, tre sezioni e slide di ringraziamento.
// Gli elementi degli elenchi possono essere stringhe oppure contenuti [...].
#let diarioDiBordo(
  titolo: "Diario di bordo",
  data: "",
  fase: "",
  versione: false,
  autori: tutti,
  retrospettiva: (),
  backlog: (),
  difficolta: (),
  dubbi: (),
  body,
) = {
  let titoloCompleto = if data == "" { titolo } else { titolo + " " + data }
  let sottotitolo = (fase, data).filter(valore => valore != "").join(" – ")
  set document(title: titoloCompleto, author: autori)
  base(
    presentazione: true,
    intestazione: intestazione(titoloCompleto, presentazione: true),
    [
      #copertina(
        titolo,
        data: sottotitolo,
        versione: versione,
        autori: autori,
        presentazione: true,
      )
      #pagebreak(weak: true)

      = Progressi raggiunti nel periodo trascorso
      #enum(numbering: "1.a.i.", ..retrospettiva)

      #pagebreak()
      = Attività programmate nel prossimo periodo
      #enum(numbering: "1.a.i.", ..backlog)

      #pagebreak()
      = Analisi delle difficoltà incontrate
      #enum(numbering: "1.a.i.", ..difficolta)

      #pagebreak()
      = Dubbi su come procedere
      #enum(numbering: "1.a.i.", ..dubbi)

      #body

      #pagebreak(weak: true)
      #slideFinale("Grazie per l'ascolto")
    ],
  )
}
