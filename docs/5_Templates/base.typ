#let brunoGrimaldi = "Bruno Grimaldi"
#let elicoHuang = "Elico Huang"
#let mattiaMilan = "Mattia Milan"
#let margheritaMonaco = "Margherita Monaco"
#let riccardoPontello = "Riccardo Pontello"
#let lorencaShiroka = "Lorenca Shiroka"

#let BG = brunoGrimaldi
#let EH = elicoHuang
#let MMI = mattiaMilan
#let MMO = margheritaMonaco
#let RP = riccardoPontello
#let LS = lorencaShiroka

#let tutti = (
  brunoGrimaldi,
  elicoHuang,
  mattiaMilan,
  margheritaMonaco,
  riccardoPontello,
  lorencaShiroka,
)

#let logo(larghezza: 2cm) = image("assets/logo.png", width: larghezza)

// Equivalente di lightgray definito con gray=0.95.
#let lightgray = luma(95%)
#let profonditaDocumento = 5

// hyperref con hidelinks: i normali link Typst restano senza cornici.
// La formattazione esplicita dei tre comandi LaTeX usa un solo helper.
#let stileRiferimento(body) = strong(underline(body))
#let bulhref(destinazione, testo) = link(destinazione, stileRiferimento(testo))
#let bulhyperlink = bulhref
#let bulref(destinazione) = {
  show link: it => it.body
  stileRiferimento(ref(destinazione, supplement: none))
}

// image, table, calc, colori, par(justify), formule, lorem e il simbolo €
// sostituiscono le rispettive funzionalità dei pacchetti LaTeX citati.
// I commenti nativi sono // e /* ... */. Disegni e posizionamento usano
// le primitive Typst; TikZ e pgf-pie richiedono una traduzione del grafico,
// non una direttiva di importazione LaTeX.

// Altezza equivalente a headheight; la distanza dal testo è impostata in base.
#let intestazione(titolo, presentazione: false) = block(
  width: 100%,
  height: if presentazione { 35pt } else { 23.62976pt },
  inset: (bottom: 4pt),
  stroke: (bottom: 0.4pt),
)[
  #if presentazione {
    grid(
      columns: (auto, 1fr),
      column-gutter: 1cm,
      align: horizon,
      logo(larghezza: 1cm),
      align(right, text(size: 12pt, titolo)),
    )
  } else {
    align(bottom, text(size: 9pt, titolo))
  }
]

#let pieDiPagina(tipo: "", data: "", numerazione: "1", presentazione: false) = block(
  width: 100%,
  inset: (top: 4pt),
  stroke: (top: 0.4pt),
)[
  #set text(size: if presentazione { 16pt } else { 9pt })
  #if presentazione {
    align(right, context counter(page).display("1/1", both: true))
  } else {
    grid(
      columns: (1fr, 1fr, 1fr),
      align(left)[#tipo],
      align(center)[#context counter(page).display(numerazione)],
      align(right)[#data],
    )
  }
]
// paragraph e subparagraph: titolo in linea con il testo successivo.
#let titoloParagrafo(titolo) = {
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
  numeroTitoli: "1.1.",
  presentazione: false,
  body,
) = {
  set text(lang: "it", font: "New Computer Modern", size: if presentazione { 22pt } else { 10pt })
  set page(
    paper: "a4",
    flipped: presentazione,
    margin: if presentazione { (x: 2cm, y: 3cm) } else { 2.5cm },
    numbering: numerazione,
    number-align: center + bottom,
    header: intestazione,
    header-ascent: 11.62976pt,
    footer: if numerazione == none { none } else {
      pieDiPagina(tipo: tipo, data: data, numerazione: numerazione, presentazione: presentazione)
    },
  )
  set par(justify: true, first-line-indent: 0pt, leading: 0.65em, spacing: if presentazione { 0.65em } else { 1em })
  // Come secnumdepth=5: dal sesto livello i titoli restano senza numero.
  set heading(numbering: if presentazione or numeroTitoli == none { none } else {
    (..livelli) => if livelli.pos().len() <= profonditaDocumento {
      numbering(numeroTitoli, ..livelli.pos())
    }
  })
  set list(indent: 1em, body-indent: 0.5em, tight: false, spacing: 1.5em)
  set enum(indent: 1em, body-indent: 0.5em, tight: false, spacing: 1.5em)
  show heading: set text(weight: "bold")
  show heading: set block(above: 1.2em, below: 1.2em)
  // 3.25ex e 1.5ex del Computer Modern corrispondono circa a 1.4em e 0.65em.
  show heading.where(level: 4): set text(size: 10pt)
  show heading.where(level: 4): set block(above: 1.4em, below: 1.2em)
  show heading.where(level: 5).or(heading.where(level: 6)): titoloParagrafo
  if presentazione {
    show heading.where(level: 1): set text(size: 32pt, hyphenate: false)
    body
  } else {
    body
  }
}

// L'indice definisce solo la propria resa; il template decide dove inserirlo.
#let indiceDocumento() = {
  show outline.entry: set block(above: 0.75em, below: 0.75em)
  set outline.entry(fill: repeat[.])
  outline(title: [Indice], indent: 1em, depth: profonditaDocumento)
}

// Tabelle con intestazione comune a registri, attività e altri dati.
#let tabellaDati(colonne: auto, intestazioni: (), righe: ()) = block(
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
#let tabellaInformazioni(campi) = {
  let valoreCella(valore) = if type(valore) == array {
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
    ..campi.map(campo => (strong(campo.at(0)), valoreCella(campo.at(1)))).flatten(),
  ))
}

// Un solo contenuto grafico per copertine di documenti e presentazioni.
#let contenutoCopertina(
  titolo,
  data: "",
  versione: "",
  autori: (),
  informazioni: (),
  presentazione: false,
) = {
  let mostraVersione = versione != false and versione != none and versione != ""
  // 142.5 pt corrispondono a 190 px a 96 dpi.
  let larghezzaLoghi = 142.5pt
  let colonneCopertina = (1fr, 1fr)
  let spazioColonne = 0.5cm
  grid(
    columns: colonneCopertina,
    align: center + horizon,
    column-gutter: spazioColonne,
    logo(larghezza: larghezzaLoghi),
    image("assets/logounipd.png", width: larghezzaLoghi),
  )
  v(0.5cm)
  align(center, text(size: if presentazione { 14pt } else { 10pt },
    bulhref("mailto:byteclubunipd@gmail.com", "byteclubunipd@gmail.com"),
  ))
  if presentazione {
    place(center + horizon, align(center)[
      #set par(justify: false, spacing: 0pt)
      #text(size: 38pt, weight: "bold", titolo)
      #if data != "" [
        #v(0.5cm)
        #text(size: 20pt, weight: "bold", data)
      ]
    ])
  } else {
    v(1.2cm)
    align(center)[
      #set par(justify: false, spacing: 0pt)
      #text(size: 24pt, weight: "bold", titolo)
      #if data != "" [
        #v(0.5cm)
        #text(size: 14pt, weight: "bold", data)
      ]
      #if mostraVersione or autori.len() > 0 [
        #v(0.7cm)
        #set text(size: 9pt)
        #if mostraVersione [Versione: #versione]
        #if autori.len() > 0 [
          #linebreak()
          Redazione: #autori.join(", ")
        ]
      ]
    ]
  }
  if presentazione {
    v(1fr)
    if autori.len() > 0 {
      set text(size: 18pt)
      // Stessi assi dei loghi; riempimento dall'alto verso il basso.
      let numeroRighe = calc.ceil(autori.len() / 2)
      grid(
        columns: colonneCopertina,
        column-gutter: spazioColonne,
        align: center,
        row-gutter: 0.3cm,
        ..range(numeroRighe).map(riga => (
          [#autori.at(riga)],
          [#autori.at(riga + numeroRighe, default: "")],
        )).flatten(),
      )
    }
  }
  if informazioni.len() > 0 {
    v(1.5cm)
    tabellaInformazioni(informazioni)
  }
}

// I documenti mantengono la pagina corrente; la copertina delle slide
// occupa una pagina dedicata senza intestazione né piè di pagina.
#let copertina(
  titolo,
  data: "",
  versione: "",
  autori: (),
  informazioni: (),
  presentazione: false,
) = {
  let contenuto = contenutoCopertina(
    titolo,
    data: data,
    versione: versione,
    autori: autori,
    informazioni: informazioni,
    presentazione: presentazione,
  )
  if presentazione {
    page(paper: "a4", flipped: true, margin: (x: 2cm, top: 1cm, bottom: 1cm),
      header: none, footer: none, numbering: none, contenuto)
  } else {
    contenuto
  }
}
// Resa grafica della slide di chiusura; il testo è deciso dal template.
#let slideFinale(testo) = align(
  center + horizon,
  text(size: 38pt, weight: "bold", testo),
)
