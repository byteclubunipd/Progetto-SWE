#let bruno-grimaldi = "Bruno Grimaldi"
#let elico-huang = "Elico Huang"
#let mattia-milan = "Mattia Milan"
#let margherita-monaco = "Margherita Monaco"
#let riccardo-pontello = "Riccardo Pontello"
#let lorenca-shiroka = "Lorenca Shiroka"

#let BG = bruno-grimaldi
#let EH = elico-huang
#let MMI = mattia-milan
#let MMO = margherita-monaco
#let RP = riccardo-pontello
#let LS = lorenca-shiroka

#let tutti = (
  bruno-grimaldi,
  elico-huang,
  mattia-milan,
  margherita-monaco,
  riccardo-pontello,
  lorenca-shiroka,
)

#let logo(larghezza: 2cm) = image("assets/logo.png", width: larghezza)

// Equivalente di lightgray definito con gray=0.95.
#let lightgray = luma(95%)
#let profondita-documento = 5

// hyperref con hidelinks: i normali link Typst restano senza cornici.
// La formattazione esplicita dei tre comandi LaTeX usa un solo helper.
#let stile-riferimento(body) = strong(underline(body))
#let bulhref(destinazione, testo) = link(destinazione, stile-riferimento(testo))
#let bulhyperlink = bulhref
#let bulref(destinazione) = {
  show link: it => it.body
  stile-riferimento(ref(destinazione, supplement: none))
}

// image, table, calc, colori, par(justify), formule, lorem e il simbolo €
// sostituiscono le rispettive funzionalità dei pacchetti LaTeX citati.
// I commenti nativi sono // e /* ... */. Disegni e posizionamento usano
// le primitive Typst; TikZ e pgf-pie richiedono una traduzione del grafico,
// non una direttiva di importazione LaTeX.

// Altezza equivalente a headheight; la distanza dal testo è impostata in base.
#let intestazione(titolo) = block(
  width: 100%,
  height: 23.62976pt,
  inset: (bottom: 4pt),
  stroke: (bottom: 0.4pt),
)[
  #align(bottom)[#text(size: 9pt, titolo)]
]

#let pié-di-pagina(tipo: "", data: "", numerazione: "1") = block(
  width: 100%,
  inset: (top: 4pt),
  stroke: (top: 0.4pt),
)[
  #set text(size: 9pt)
  #grid(
    columns: (1fr, 1fr, 1fr),
    align(left)[#tipo],
    align(center)[#context counter(page).display(numerazione)],
    align(right)[#data],
  )
]
// paragraph e subparagraph: titolo in linea con il testo successivo.
#let titolo-paragrafo(titolo) = {
  v(1.4em, weak: true)
  text(size: 10pt, weight: "bold")[
    #context {
      if titolo.numbering != none {
        counter(heading).display(titolo.numbering)
        h(1em)
      }
    }#titolo.body
  ]
  h(1em)
}
// Regole grafiche condivise da documenti e verbali.
#let base(
  tipo: "",
  data: "",
  intestazione: none,
  numerazione: "1",
  numero-titoli: "1.1.",
  body,
) = {
  set text(lang: "it", font: "New Computer Modern", size: 10pt)
  set page(
    paper: "a4",
    margin: 2.5cm,
    numbering: numerazione,
    number-align: center + bottom,
    header: intestazione,
    header-ascent: 11.62976pt,
    footer: if numerazione == none { none } else {
      pié-di-pagina(tipo: tipo, data: data, numerazione: numerazione)
    },
  )
  set par(justify: true, first-line-indent: 0pt, leading: 0.65em, spacing: 1em)
  // Come secnumdepth=5: dal sesto livello i titoli restano senza numero.
  set heading(numbering: if numero-titoli == none { none } else {
    (..livelli) => if livelli.pos().len() <= profondita-documento {
      numbering(numero-titoli, ..livelli.pos())
    }
  })
  set list(indent: 1em, body-indent: 0.5em, tight: false, spacing: 0.7em)
  show heading: set text(weight: "bold")
  // 3.25ex e 1.5ex del Computer Modern corrispondono circa a 1.4em e 0.65em.
  show heading.where(level: 4): set text(size: 10pt)
  show heading.where(level: 4): set block(above: 1.4em, below: 0.65em)
  show heading.where(level: 5).or(heading.where(level: 6)): titolo-paragrafo
  body
}

// L'indice definisce solo la propria resa; il template decide dove inserirlo.
#let indice-documento() = {
  show outline.entry: set block(above: 0.4em, below: 0.4em)
  set outline.entry(fill: repeat[.])
  outline(title: [Indice], indent: 1em, depth: profondita-documento)
}

// Tabelle con intestazione comune a registri, attività e altri dati.
#let tabella-dati(colonne: auto, intestazioni: (), righe: ()) = block(
  above: 0.5cm,
  table(
    columns: colonne,
    inset: 4pt,
    stroke: 0.5pt,
    fill: (x, y) => if y == 0 { lightgray },
    table.header(..intestazioni.map(cella => align(center, strong(cella)))),
    ..righe.flatten(),
  ),
)

// Metadati di copertina: due colonne senza cornice esterna.
#let tabella-informazioni(campi) = {
  let valore-cella(valore) = if type(valore) == array {
    valore.map(elemento => [#elemento]).join(linebreak())
  } else {
    valore
  }
  align(center, table(
    columns: (auto, auto),
    align: (right, left),
    inset: (x: 5pt, y: 2pt),
    stroke: (x, y) => (
      left: if x == 1 { 0.5pt } else { none },
      bottom: if y < campi.len() - 1 { 0.5pt } else { none },
    ),
    ..campi.map(campo => (strong(campo.at(0)), valore-cella(campo.at(1)))).flatten(),
  ))
}

// Identità condivisa e titolo: le informazioni arrivano dai template.
#let copertina(
  titolo,
  data: "",
  versione: "",
  autori: (),
  informazioni: (),
) = {
  let mostra-versione = versione != false and versione != none and versione != ""
  // 142.5 pt corrispondono a 190 px a 96 dpi.
  let larghezza-loghi = 142.5pt
  grid(
    columns: (1fr, 1fr),
    align: center + horizon,
    column-gutter: 0.5cm,
    logo(larghezza: larghezza-loghi),
    image("assets/logounipd.png", width: larghezza-loghi),
  )
  v(0.5cm)
  align(center, bulhref("mailto:byteclubunipd@gmail.com", "byteclubunipd@gmail.com"))
  v(1.2cm)
  align(center)[
    #set par(justify: false, spacing: 0pt)
    #text(size: 24pt, weight: "bold", titolo)
    #if data != "" [
      #v(0.5cm)
      #text(size: 14pt, weight: "bold", data)
    ]
    #if mostra-versione or autori.len() > 0 [
      #v(0.7cm)
      #set text(size: 9pt)
      #if mostra-versione [Versione: #versione]
      #if autori.len() > 0 [
        #linebreak()
        Redazione: #autori.join(", ")
      ]
    ]
  ]
  if informazioni.len() > 0 {
    v(1.5cm)
    tabella-informazioni(informazioni)
  }
}
