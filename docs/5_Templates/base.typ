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

#let intestazione(titolo) = {
  block(
    width: 100%,
    below: 0.4em,
    stroke: (bottom: 0.4pt + rgb("808080")),
  )[
    #text(size: 9pt)[#titolo]
  ]
}

#let pié-di-pagina(tipo: "", data: "") = {
  block(
    width: 100%,
    above: 0.4em,
    stroke: (top: 0.4pt + rgb("808080")),
  )[
    #grid(
      columns: (1fr, 1fr, 1fr),
      align(left)[#text(size: 9pt)[#tipo]],
      align(center)[#text(size: 9pt)[#context counter(page).display("1")]],
      align(right)[#text(size: 9pt)[#data]],
    )
  ]
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
    footer: auto,
  )
  set par(justify: true, first-line-indent: 0pt, leading: 0.65em, spacing: 1em)
  set heading(numbering: numero-titoli)
  set list(indent: 1em, body-indent: 0.5em, tight: false, spacing: 0.7em)
  show heading: set text(weight: "bold")
  show link: underline
  show link: set text(weight: "bold")
  body
}

// L'indice definisce solo la propria resa; il template decide dove inserirlo.
#let indice-documento() = {
  show outline.entry: set block(above: 0.4em, below: 0.4em)
  set outline.entry(fill: repeat[.])
  outline(title: [Indice], indent: 1em)
}

// Tabelle con intestazione comune a registri, attività e altri dati.
#let tabella-dati(colonne: auto, intestazioni: (), righe: ()) = block(
  above: 0.5cm,
  table(
    columns: colonne,
    inset: 4pt,
    stroke: 0.5pt,
    fill: (x, y) => if y == 0 { rgb("e6e6e6") },
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
  align(center, link("mailto:byteclubunipd@gmail.com", "byteclubunipd@gmail.com"))
  v(1.2cm)
  align(center)[
    #set par(justify: false, spacing: 0pt)
    #text(size: 24pt, weight: "bold", titolo)
    #if data != "" [
      #v(0.5cm)
      #text(size: 14pt, weight: "bold", data)
    ]
    #if versione != "" or autori.len() > 0 [
      #v(0.7cm)
      #set text(size: 9pt)
      #if versione != "" [Versione: #versione]
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
