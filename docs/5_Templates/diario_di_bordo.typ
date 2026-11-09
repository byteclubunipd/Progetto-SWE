#import "base.typ": tutti, BG, EH, MMI, MMO, RP, LS

// Palette del mockup Canva.
#let navy = rgb("#151037")
#let violet = rgb("#5141d0")
#let violetMid = rgb("#4438b6")
#let violetDark = rgb("#17133f")
#let whiteText = white

// Fallback disponibili localmente: Bodoni/Baskerville conservano il contrasto
// serif del mockup più fedelmente del Computer Modern.
#let titleFont = ("Bodoni MT", "Bodoni MT Poster", "New Computer Modern")
#let bodyFont = ("Baskerville Old Face", "Bodoni MT", "New Computer Modern")

#let itemContent(item) = if type(item) == content { item } else { [#item] }

#let itemList(items, size: 23pt, top: 0in, indent: -0.32in, spacing: 0.16in) = {
  set text(font: bodyFont, size: size, fill: whiteText)
  v(top)
  list(
    marker: [•],
    indent: indent,
    body-indent: 0.10in,
    spacing: spacing,
    ..items.map(item => itemContent(item)),
  )
}

#let pinkGlow(width: 4.014in, height: 0.702in) = box(
  width: width,
  height: height,
  fill: gradient.radial(
    rgb("#f5a3ef").transparentize(42%),
    rgb("#f5a3ef").transparentize(100%),
  ),
  align(center + horizon)[
    #box(
      width: width * 0.72,
      height: 0.014in,
      fill: gradient.linear(
        angle: 0deg,
        rgb("#ffc4f7").transparentize(100%),
        rgb("#ffc4f7").transparentize(18%),
        rgb("#ffc4f7").transparentize(100%),
      ),
    )
  ],
)
#let centralPinkGlow(width: 4.014in, height: 0.702in) = box(
  width: width,
  height: height,
  fill: gradient.radial(
    rgb("#f5a3ef").transparentize(62%),
    rgb("#f5a3ef").transparentize(100%),
  ),
  align(center + horizon)[
    #box(
      width: width * 0.52,
      height: 0.010in,
      fill: gradient.linear(
        angle: 0deg,
        rgb("#fffaff").transparentize(100%),
        rgb("#fffaff").transparentize(22%),
        rgb("#fffaff").transparentize(100%),
      ),
    )
  ],
)
#let coverPanelGradient = gradient.linear(
  angle: 35deg,
  rgb("#5b45d4").transparentize(10%),
  rgb("#3d2a9b").transparentize(34%),
  rgb("#151037").transparentize(84%),
)
#let coverBorderGradient = gradient.linear(
  angle: 35deg,
  rgb("#765fff").transparentize(8%),
  rgb("#5347d9").transparentize(42%),
  rgb("#151037").transparentize(88%),
)
#let outerPanelGradient = gradient.linear(
  angle: 90deg,
  rgb("#5347D9").transparentize(40.5%),
  rgb("#5347D9").transparentize(100%),
)
#let innerPanelGradient = gradient.linear(
  angle: 90deg,
  rgb("#5347D9").transparentize(25%),
  rgb("#5347D9").transparentize(100%),
)

#let panel(body, x: 0.947in, y: 2.436in, width: 11.326in, height: 4.507in) = {
  // Alone del bordo, separato dal riempimento.
  place(left + top, dx: x, dy: y,
    box(
      width: width,
      height: height,
      fill: none,
      stroke: 2pt + violet.transparentize(96%),
    ),
  )
  // Pannello esterno con gradiente traslucido.
  place(left + top, dx: x, dy: y,
    box(
      width: width,
      height: height,
      fill: outerPanelGradient,
      stroke: 1.5pt + rgb("#5347D9").transparentize(15%),
    ),
  )
  // Pannello interno, anch'esso separato dal bordo esterno.
  place(left + top, dx: x + 0.445in, dy: y + 0.209in,
    box(
      width: 9.97in,
      height: 3.87in,
      fill: innerPanelGradient,
      stroke: 0.8pt + rgb("#5347D9").transparentize(35%),
      inset: 0.38in,
      body,
    ),
  )
}

#let header(data) = {
  place(left + top, dx: 0in, dy: 0in,
    box(
      width: 13.333in,
      height: 0.74in,
      fill: gradient.linear(
        angle: 0deg,
        rgb("#3f82cc"),
        rgb("#34378d"),
        rgb("#292264"),
        rgb("#292264"),
        rgb("#34378d"),
        rgb("#3f82cc"),
      ),
      stroke: (bottom: 1.5pt + rgb("#4638b7")),
    ),
  )
  place(left + top, dx: 0.947in, dy: 0.25in,
    text(font: titleFont, size: 13pt, style: "italic", fill: whiteText)[Università di Padova],
  )
  place(left + top, dx: 4.40in, dy: 0.25in,
    box(width: 4.50in, align(center,
      text(font: titleFont, size: 13pt, fill: whiteText)[#data - Diario di Bordo],
    )),
  )
  place(left + top, dx: 10.273in, dy: 0.25in,
    box(width: 2.00in, align(right,
      text(font: titleFont, size: 13pt, style: "italic", fill: whiteText)[Gruppo 10 - ByteClub],
    )),
  )
}

#let slidePage(body) = page(
  width: 13.333in,
  height: 7.5in,
  margin: 0pt,
  numbering: none,
  fill: navy,
  body,
)

#let cover(data, responsible, title: "DIARIO DI BORDO", showGroup: true) = {
  let coverData = if data == "[Data]" { "[DATA]" } else { data }
  slidePage([
  // Asset originali nelle coordinate del PowerPoint.
  #place(left + top, dx: -2.81in, dy: -0.146in,
    image("assets/canva-image1.png", width: 11.694in, height: 7.795in),
  )
  #place(left + top, dx: 7.75in, dy: 2.052in,
    rotate(-42.067deg, scale(x: 100%, y: -100%, image("assets/canva-image3.svg", width: 11.18in, height: 4.823in))),
  )
  // Secondo passaggio dello stesso SVG originale per aumentarne la presenza cromatica.
  #place(left + top, dx: 7.75in, dy: 2.052in,
    rotate(-42.067deg, scale(x: 100%, y: -100%, image("assets/canva-image3.svg", width: 11.18in, height: 4.823in))),
  )
  #place(left + top, dx: 1.344in, dy: 1.785in,
    image("assets/logo.png", width: 3.389in, height: 3.389in),
  )
  #place(left + top, dx: 10.99in, dy: 0.10in,
    image("assets/logounipd.png", width: 1.05in, height: 1.07in),
  )

  // Unico pannello traslucido della copertina.
  #place(left + top, dx: 6.1in, dy: 2.4in,
    box(
      width: 6.16in,
      height: 2.74in,
      fill: none,
      stroke: 5pt + violet.transparentize(88%),
    ),
  )
  #place(left + top, dx: 6.1in, dy: 2.4in,
    box(
      width: 6.16in,
      height: 2.74in,
      fill: coverPanelGradient,
      stroke: 1.2pt + coverBorderGradient,
    ),
  )

  // I bagliori sono sopra i pannelli, come nella composizione Canva.
  #place(left + top, dx: 5.72in, dy: 1.95in,
    image("assets/canva-image4.png", width: 5.164in, height: 0.904in),
  )
  #place(left + top, dx: 7.11in, dy: 4.688in,
    pinkGlow(width: 5.164in, height: 0.904in),
  )

  // Caselle di testo indipendenti nelle coordinate del PowerPoint.
  #place(left + top, dx: 6.59in, dy: 2.965in,
    text(font: titleFont, size: 30pt, fill: whiteText)[#coverData],
  )
  #place(left + top, dx: 6.667in, dy: 3.557in,
    text(font: titleFont, size: 42pt, weight: "bold", fill: whiteText)[#title],
  )
  #if showGroup [
    #place(left + top, dx: 6.466in, dy: 4.42in,
      box(width: 4.841in, height: 0.317in,
        align(center + horizon,
          text(font: bodyFont, size: 16pt, weight: "bold", style: "italic", fill: whiteText)[GRUPPO 10 - BYTECLUB],
        ),
      ),
    )
  ]
  #place(left + top, dx: 10.25in, dy: 1.30in,
    text(font: titleFont, size: 14pt, fill: whiteText)[UNIVERSITÀ DI PADOVA],
  )
  #place(left + top, dx: 9.69in, dy: 6.227in,
    text(font: titleFont, size: 16pt, fill: whiteText)[Autore: #linebreak() #responsible],
  )
])
}

#let slideDecorations(variante: "centro") = {
  if variante == "sinistra" {
    place(left + top, dx: 1.392in, dy: 0.705in,
      centralPinkGlow(),
    )
    place(left + top, dx: 1.392in, dy: 1.496in,
      centralPinkGlow(),
    )
  } else if variante == "centro3" {
    place(left + top, dx: 4.384in, dy: 0.730in,
      centralPinkGlow(),
    )
    place(left + top, dx: 4.533in, dy: 1.516in,
      centralPinkGlow(),
    )
  } else {
    place(left + top, dx: 4.370in, dy: 0.723in,
      centralPinkGlow(),
    )
    place(left + top, dx: 4.385in, dy: 1.509in,
      centralPinkGlow(),
    )
  }
}

#let slideDecorationsBottom() = {
  // Sono renderizzati dopo il pannello per restare visibili sopra di esso.
  place(left + top, dx: 7.142in, dy: 2.294in,
    image("assets/canva-image4.png", width: 4.014in, height: 0.702in),
  )
  place(left + top, dx: 0.521in, dy: 6.596in,
    image("assets/canva-image4.png", width: 4.014in, height: 0.702in),
  )
}

#let contentPage(data, title, body, variante: "centro") = slidePage([
  #header(data)
  #place(left + top, dx: 0.947in, dy: 1.217in,
    text(font: bodyFont, size: 44pt, fill: whiteText)[#title],
  )
  #body
  #slideDecorations(variante: variante)
  #slideDecorationsBottom()
])

#let activityContent(item) = if type(item) == dictionary {
  item.at("contenuto", default: "[inserire contenuto]")
} else {
  itemContent(item)
}

#let activityDeadline(item, data) = if type(item) == dictionary {
  let deadline = item.at("scadenza", default: "[scadenza]")
  let shown = if deadline == "" { "[scadenza]" } else { deadline }
  text(font: bodyFont, fill: whiteText)[#shown]
} else {
  text(font: bodyFont, fill: whiteText)[#data]
}

// Ogni attività e la relativa scadenza occupano la stessa riga della griglia.
// In questo modo una descrizione multilinea aumenta solo l'altezza della
// propria riga e la scadenza resta allineata all'inizio della descrizione.
#let activityGrid(items, data) = {
  let cells = items.map(item => (
    itemList((activityContent(item),), size: 22pt, top: 0in, indent: -0.32in),
    itemList((activityDeadline(item, data),), size: 22pt, top: 0in, indent: -0.32in),
  )).flatten()
  grid(
    columns: (1fr, 1fr),
    column-gutter: 0.55in,
    row-gutter: 0.14in,
    text(font: bodyFont, size: 24pt, weight: "bold", fill: whiteText)[ATTIVITÀ],
    text(font: bodyFont, size: 24pt, weight: "bold", fill: whiteText)[SCADENZA],
    ..cells,
  )
}

// Dimensioni effettive dell'area interna del pannello, al netto dell'inset.
#let innerPanelWidth = 9.21in
#let innerPanelHeight = 3.11in

// Divide un elenco solo quando la sua altezza misurata supera l'area interna.
// Il font resta invariato: le pagine successive ripetono la stessa composizione.
#let paginateList(items, width: innerPanelWidth, height: innerPanelHeight, size: 22pt, indent: -0.32in, spacing: 0.16in) = {
  let pages = ()
  let current = ()
  for item in items {
    let trial = current + (item,)
    let measured = measure(box(
      width: width,
      itemList(trial, size: size, top: 0in, indent: indent, spacing: spacing),
    )).height
    if current.len() > 0 and measured > height {
      pages.push(current)
      current = (item,)
    } else {
      current = trial
    }
  }
  if current.len() > 0 {
    pages.push(current)
  }
  pages
}

#let paginateActivities(items, data, width: innerPanelWidth, height: innerPanelHeight) = {
  let pages = ()
  let current = ()
  for item in items {
    let trial = current + (item,)
    let measured = measure(box(width: width, activityGrid(trial, data))).height
    if current.len() > 0 and measured > height {
      pages.push(current)
      current = (item,)
    } else {
      current = trial
    }
  }
  if current.len() > 0 {
    pages.push(current)
  }
  pages
}

#let difficultyBody(difficolta, dubbi, size: 22pt, spacing: 0.16in) = {
  let cells = ()
  if difficolta.len() > 0 {
    cells.push(text(font: bodyFont, size: 25pt, weight: "bold", fill: whiteText)[DIFFICOLTÀ])
    cells.push(itemList(difficolta, size: size, top: 0in, indent: 0.08in, spacing: spacing))
  }
  if dubbi.len() > 0 {
    cells.push(text(font: bodyFont, size: 25pt, weight: "bold", fill: whiteText)[DUBBI])
    cells.push(itemList(dubbi, size: size, top: 0in, indent: 0.08in, spacing: spacing))
  }
  grid(columns: (1fr,), row-gutter: 0.14in, ..cells)
}

#let paginateDifficulties(difficolta, dubbi, width: innerPanelWidth, height: innerPanelHeight) = {
  let pages = ()
  let currentDifficolta = ()
  let currentDubbi = ()
  for item in difficolta {
    let trial = currentDifficolta + (item,)
    let measured = measure(box(width: width, difficultyBody(trial, currentDubbi))).height
    if (currentDifficolta.len() + currentDubbi.len()) > 0 and measured > height {
      pages.push((currentDifficolta, currentDubbi))
      currentDifficolta = (item,)
      currentDubbi = ()
    } else {
      currentDifficolta = trial
    }
  }
  for item in dubbi {
    let trial = currentDubbi + (item,)
    let measured = measure(box(width: width, difficultyBody(currentDifficolta, trial))).height
    if (currentDifficolta.len() + currentDubbi.len()) > 0 and measured > height {
      pages.push((currentDifficolta, currentDubbi))
      currentDifficolta = ()
      currentDubbi = (item,)
    } else {
      currentDubbi = trial
    }
  }
  if (currentDifficolta.len() + currentDubbi.len()) > 0 {
    pages.push((currentDifficolta, currentDubbi))
  }
  pages
}

#let diarioDiBordo(
  titolo: "DIARIO DI BORDO",
  data: false,
  responsabile: "[Nome Responsabile]",
  progressi: ("[inserire contenuto]"),
  attivita: ((contenuto: "[inserire contenuto]", scadenza: "[scadenza]"),),
  difficolta: ("[inserire contenuto]"),
  dubbi: ("[inserire contenuto]"),
  body,
  // Parametri mantenuti per compatibilità con i diari già esistenti.
  fase: "",
  versione: false,
  autori: (),
  retrospettiva: none,
  backlog: none,
) = {
  let visualData = if data == false or data == "" { "[Data]" } else { data }
  let progressiData = if retrospettiva == none { progressi } else { retrospettiva }
  let attivitaData = if backlog == none { attivita } else { backlog }
  set document(title: titolo, author: autori)

  cover(visualData, responsabile, title: titolo)

  // Le tre sezioni vengono paginate dentro la stessa composizione grafica.
  // Il contesto consente di misurare il contenuto prima di emettere le pagine.
  context {
    for chunk in paginateList(progressiData) {
      contentPage(
        visualData,
        "Progressi raggiunti nel periodo trascorso",
        [#panel(itemList(chunk, top: 0in, indent: -0.32in))],
      )
    }
  }

  context {
    for chunk in paginateActivities(attivitaData, visualData) {
      contentPage(
        visualData,
        "Attività programmate nel prossimo periodo",
        [#panel(activityGrid(chunk, visualData))],
        variante: "centro3",
      )
    }
  }

  context {
    for pair in paginateDifficulties(difficolta, dubbi) {
      contentPage(
        visualData,
        "Difficoltà e dubbi",
        [#panel(difficultyBody(pair.at(0), pair.at(1)))],
        variante: "sinistra",
      )
    }
  }

  cover(
    visualData,
    responsabile,
    title: [GRAZIE PER #linebreak() L’ASCOLTO],
    showGroup: false,
  )
}
