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
  criticita: (),
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

      = Progressi raggiunti e confronto (_retrospettiva_)
      #list(..retrospettiva)

      #pagebreak()
      = Obiettivi e attività programmate (_backlog_)
      #list(..backlog)

      #pagebreak()
      = Analisi delle criticità e decisioni pendenti
      #list(..criticita)

      #body

      #pagebreak(weak: true)
      #slideFinale("Grazie per l'ascolto")
    ],
  )
}
