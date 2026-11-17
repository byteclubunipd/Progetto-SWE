#import "/docs/5_Templates/base.typ": *

// ============================================================================
// IMPORT DELLA TABLE GITHUB PROJECT
// ============================================================================
//
// Il TSV viene letto a tempo di compilazione. Le colonne utilizzate sono:
// Title, URL, Assignees, Status, Inizio, Fine, Sprint, Ruolo.
// Per aggiornare il Gantt basta riesportare il TSV mantenendo lo stesso nome.

#let tsv-righe = (read("@byteclubunipd's RTB - Diagramma di Gantt.tsv").split("\n").slice(1)).filter(riga => riga.trim() != "")
#let cell(riga, indice) = if indice < riga.len() {
  riga.at(indice).trim()
} else {
  ""
}

#let giorno-data(data) = if data == "" {
  1
} else {
  let parti = data.split(" ")
  int(parti.at(1).replace(",", "")) - 10
}

#let id-url(url) = {
  let parti = url.split("/")
  if parti.len() == 0 {
    "-"
  } else {
    parti.at(parti.len() - 1)
  }
}

#let tsv-record(riga) = {
  let colonne = riga.split("\t")
  let titolo = cell(colonne, 0)
  let url = cell(colonne, 1)
  let assegnatari = cell(colonne, 2)
  let stato = cell(colonne, 3)
  let inizio = cell(colonne, 6)
  let fine = cell(colonne, 7)
  let sprint = cell(colonne, 9)
  let ruolo = cell(colonne, 10)
  let inizio-giorno = giorno-data(inizio)
  let fine-prevista = if fine == "" { 17 } else { giorno-data(fine) }
  let fine-effettiva = if stato == "Done" and fine != "" {
    giorno-data(fine)
  } else {
    6
  }

  (
    id: id-url(url),
    titolo: titolo,
    url: url,
    assegnatari: if assegnatari == "" { "-" } else { assegnatari },
    stato: if stato == "" { "-" } else { stato },
    inizio: inizio,
    fine: fine,
    sprint: if sprint == "" { 1 } else { int(sprint) },
    ruolo: if ruolo == "" { "-" } else { ruolo },
    previsto_inizio: inizio-giorno,
    durata_prevista: calc.max(1, fine-prevista - inizio-giorno + 1),
    effettivo_inizio: inizio-giorno,
    durata_effettiva: calc.max(1, fine-effettiva - inizio-giorno + 1),
    ore: 0,
  )
}

#let issue-records = tsv-righe.map(tsv-record)

#let records-sprint(numero) = issue-records.filter(record => record.sprint == numero)

// ============================================================================
// ORE E COSTI
// ============================================================================

#let costo-orario(ruolo) = if ruolo == "Responsabile" {
  30
} else if ruolo == "Amministratore" {
  20
} else if ruolo == "Analista" or ruolo == "Progettista" {
  25
} else if ruolo == "Programmatore" or ruolo == "Verificatore" {
  15
} else {
  0
}

#let costo-record(record) = record.ore * costo-orario(record.ruolo)

// ============================================================================
// CONFIGURAZIONE DELLA TIMELINE
// ============================================================================

#let colonne-timeline(giorni) = range(1, giorni + 1).map(giorno => 1fr)

#let etichette-sprint-1 = (
  "11", "12", "13", "14", "15",
  "16", "17", "18", "19", "20",
  "21", "22", "23", "24", "25",
  "26", "27",
)
#let etichette-placeholder = range(1, 18).map(giorno => "MM-DD")

#let gantt-1 = (giorni: 17, etichette: etichette-sprint-1)
#let gantt-2 = (giorni: 17, etichette: etichette-placeholder)
#let gantt-3 = (giorni: 17, etichette: etichette-placeholder)
#let gantt-4 = (giorni: 17, etichette: etichette-placeholder)
#let gantt-5 = (giorni: 17, etichette: etichette-placeholder)

#let sprint-1 = (numero: 1, gantt: gantt-1)
#let sprint-2 = (numero: 2, gantt: gantt-2)
#let sprint-3 = (numero: 3, gantt: gantt-3)
#let sprint-4 = (numero: 4, gantt: gantt-4)
#let sprint-5 = (numero: 5, gantt: gantt-5)

// ============================================================================
// TABELLE DI SUPPORTO
// ============================================================================

#let tabella-report(titolo, colonne, intestazioni, righe) = figure(
  kind: table,
  table(
    columns: colonne,
    inset: 4pt,
    stroke: 0.5pt,
    fill: (x, y) => if y == 0 {
      tabellaHeader
    } else if calc.rem(y, 2) == 0 {
      tabellaRigaPari
    } else {
      tabellaRigaDispari
    },
    table.header(..intestazioni.map(c => align(center, strong(c)))),
    ..righe.flatten(),
  ),
  caption: [#titolo],
)

#let righe-report(numero) = records-sprint(numero).map(record => (
  record.id,
  record.assegnatari,
  record.stato,
  record.ruolo,
  record.inizio + " - " + if record.fine == "" { "in corso" } else { record.fine },
  str(record.ore),
  str(costo-record(record)),
))

#let mostra-preventivo(dati) = tabella-report(
  "Sprint " + str(dati.numero) + ": Preventivo importato da GitHub Project",
  (1fr, 2fr, 1fr, 1fr, 2fr, 1fr, 1fr),
  ("ID", "Assegnatari", "Stato", "Ruolo", "Periodo", "Ore", "Costo"),
  righe-report(dati.numero),
)

#let mostra-consuntivo(dati) = tabella-report(
  "Sprint " + str(dati.numero) + ": Consuntivo importato da GitHub Project",
  (1fr, 2fr, 1fr, 1fr, 2fr, 1fr, 1fr),
  ("ID", "Assegnatari", "Stato", "Ruolo", "Periodo", "Ore", "Costo"),
  righe-report(dati.numero),
)

#let mostra-aggiornamento-risorse(dati) = tabella-report(
  "Sprint " + str(dati.numero) + ": Aggiornamento risorse",
  (1fr, 2fr, 1fr, 1fr),
  ("ID", "Assegnatari", "Stato", "Ruolo"),
  records-sprint(dati.numero).map(record => (
    record.id,
    record.assegnatari,
    record.stato,
    record.ruolo,
  )),
)

// ============================================================================
// BURNDOWN
// ============================================================================

#let posizione-punto(punto, scala, giorni, altezza) = (
  x: punto.giorno / giorni * 13cm,
  y: altezza - punto.valore / scala * altezza,
)

#let mostra-burndown(dati) = {
  let records = records-sprint(dati.numero)
  let totale = calc.max(1, records.len())
  let aperte = records.filter(record => record.stato != "Done").len()
  let punti = (
    (giorno: 0, valore: totale),
    (giorno: 6, valore: aperte),
    (giorno: dati.gantt.giorni, valore: aperte),
  )
  let ideali = (
    (giorno: 0, valore: totale),
    (giorno: dati.gantt.giorni, valore: 0),
  )
  let altezza = 5cm
  let effettivi = punti.map(punto => posizione-punto(punto, totale, dati.gantt.giorni, altezza))
  let teorici = ideali.map(punto => posizione-punto(punto, totale, dati.gantt.giorni, altezza))

  figure(
    kind: image,
    block(
      width: 100%,
      height: 7.5cm,
      stroke: 0.5pt,
      inset: (left: 1cm, right: 0.5cm, top: 0.5cm, bottom: 0.5cm),
    )[
      place(left + top, line(
        start: (0pt, altezza),
        end: (13cm, altezza),
        stroke: 1pt + luma(35%),
      ))
      place(left + top, line(
        start: (0pt, 0pt),
        end: (0pt, altezza),
        stroke: 1pt + luma(35%),
      ))
      #for segmento in range(0, teorici.len() - 1).map(i => (teorici.at(i), teorici.at(i + 1))) {
        place(left + top, line(
          start: (segmento.at(0).x, segmento.at(0).y),
          end: (segmento.at(1).x, segmento.at(1).y),
          stroke: 1.5pt + rgb("#2f80ed"),
        ))
      }
      #for segmento in range(0, effettivi.len() - 1).map(i => (effettivi.at(i), effettivi.at(i + 1))) {
        place(left + top, line(
          start: (segmento.at(0).x, segmento.at(0).y),
          end: (segmento.at(1).x, segmento.at(1).y),
          stroke: 1.5pt + rgb("#e45756"),
        ))
      }
      #for punto in effettivi {
        place(left + top, dx: punto.x - 3pt, dy: punto.y - 3pt, circle(radius: 3pt, fill: rgb("#e45756")))
      }
      place(left + top, dx: 3.2cm, dy: altezza + 0.65cm)[
        #grid(
          columns: (auto, auto, auto, auto),
          column-gutter: 5pt,
          box(width: 0.45cm, height: 2pt, fill: rgb("#2f80ed"))[],
          [Burndown ideale],
          box(width: 0.45cm, height: 2pt, fill: rgb("#e45756"))[],
          [Issue aperte],
        )
      ]
    ],
    caption: [Diagramma di Burndown dello Sprint #dati.numero],
  )
}

// ============================================================================
// GANTT
// ============================================================================

#let gantt-sfondo = rgb("#FFFFFF")
#let gantt-sfondo-secondario = rgb("#FAFBFC")
#let gantt-testo = rgb("#07051C")
#let gantt-testo-secondario = rgb("#526071")
#let gantt-bordo = rgb("#EAEAEA")
#let gantt-griglia = rgb("#EEF1F5")
#let gantt-blu = rgb("#2877FF")
#let gantt-ciano = rgb("#00C7DD")
#let gantt-viola = rgb("#8651FF")
#let gantt-lavanda = rgb("#E1D4EC")
#let gantt-verde = rgb("#15803D")
#let gantt-corallo = rgb("#E45756")
#let gantt-grigio = rgb("#94A3B8")

#let giorno-milestone = 17

#let colore-stato(record) = if record.stato == "Done" {
  gantt-viola
} else if record.stato == "In Progress" {
  gantt-blu
} else if record.stato == "Waiting review" {
  gantt-ciano
} else {
  gantt-grigio
}

#let icona-stato(record) = if record.stato == "Done" {
  circle(radius: 4pt, fill: gantt-viola, stroke: 0.5pt + gantt-lavanda)
} else if record.stato == "In Progress" {
  circle(radius: 4pt, fill: gantt-blu, stroke: 0.5pt + rgb("#BFD5FF"))
} else if record.stato == "Waiting review" {
  circle(radius: 4pt, fill: gantt-ciano, stroke: 0.5pt + rgb("#A5F3FC"))
} else {
  circle(radius: 4pt, fill: gantt-sfondo-secondario, stroke: 0.6pt + gantt-grigio)
}

#let icona-elemento(record) = []

#let contenuto-chip(record) = grid(
  columns: (auto, auto),
  column-gutter: 3pt,
  icona-stato(record),
  [#box(width: auto)[#text(size: 7pt, fill: gantt-testo, record.titolo)]
    #h(3pt)
    #text(size: 6pt, fill: gantt-testo-secondario, "#" + record.id)],
)

// Il fondo segue il periodo previsto, mentre il contenuto resta indipendente
// dalla larghezza del fondo e quindi non va a capo.
#let chip-fondo(record, larghezza) = box(
  width: larghezza,
  height: 0.54cm,
  radius: 4pt,
  fill: gantt-sfondo-secondario,
  stroke: 0.8pt + colore-stato(record),
  inset: 0pt,
)

#let chip-issue(record) = box(
  height: 0.54cm,
  inset: (x: 5pt, y: 2pt),
)[ #contenuto-chip(record) ]

#let chip-issue-legacy(record, larghezza: none) = if larghezza == none {
  box(
    height: 0.54cm,
    radius: 4pt,
    fill: gantt-sfondo-secondario,
    stroke: 0.8pt + gantt-bordo,
    inset: (x: 5pt, y: 2pt),
  )[ #contenuto-chip(record) ]
} else { chip-fondo(record, larghezza) }

#let e-settimana(giorno) = giorno == 1 or calc.rem(giorno - 1, 7) == 0

// Le verticali giornaliere sono nell'header; quelle settimanali attraversano
// anche le issue per mantenere l'allineamento del calendario.
#let cella-timeline(giorno, altezza, contenuto: [], fill: gantt-sfondo-secondario, verticale: false, settimanale: false, orizzontale: false) = box(
  width: 100%,
  height: altezza,
  fill: fill,
  inset: 0pt,
)[
  #if verticale {
    place(left + top, line(
      start: (0pt, 0pt),
      end: (0pt, altezza),
      stroke: 0.8pt + gantt-testo-secondario,
    ))
  }
  #if settimanale and e-settimana(giorno) {
    place(left + top, line(
      start: (0pt, 0pt),
      end: (0pt, altezza),
      stroke: 0.6pt + gantt-bordo,
    ))
  }
  #if orizzontale {
    place(left + top, line(
      start: (0pt, altezza),
      end: (100%, altezza),
      stroke: 0.8pt + gantt-testo-secondario,
    ))
  }
  #contenuto
]

#let cella-header(giorno, altezza, contenuto: [], verticale: false, orizzontale: true, chiudi: false) = cella-timeline(
  giorno,
  altezza,
  verticale: verticale,
  orizzontale: orizzontale,
  contenuto: [
    #align(center + horizon, contenuto)
    #if chiudi {
      place(right + top, line(
        start: (0pt, 0pt),
        end: (0pt, altezza),
        stroke: 0.8pt + gantt-testo-secondario,
      ))
    }
  ],
)

#let cella-gantt(giorno, record, primo: false) = cella-timeline(
  giorno,
  0.62cm,
  settimanale: true,
  contenuto: [
    #if giorno == giorno-milestone {
      place(center + top, line(
        start: (0pt, 0pt),
        end: (0pt, 0.62cm),
        stroke: 1pt + gantt-verde,
      ))
    }
    #if primo and giorno == giorno-milestone {
      place(center + top, circle(radius: 2.4pt, fill: gantt-verde))
    }
  ],
)

#let barra-gantt(record, giorni, primo: false) = {
  let durata = calc.min(record.durata_prevista, giorni)
  let contenuto-giorni = calc.max(durata, calc.ceil(record.titolo.len() / 12))
  let inizio = calc.min(record.previsto_inizio, giorni - contenuto-giorni + 1)
  let larghezza = durata * (100% / giorni)

  box(width: 100%, height: 0.62cm)[
    #grid(
      columns: colonne-timeline(giorni),
      column-gutter: 0pt,
      ..range(1, giorni + 1).map(giorno => cella-gantt(giorno, record, primo: primo)).flatten(),
    )
    #place(
      left + top,
      dx: (inizio - 1) * (100% / giorni),
      dy: 4pt,
      chip-fondo(record, larghezza),
    )
    #place(
      left + top,
      dx: (inizio - 1) * (100% / giorni),
      dy: 4pt,
      chip-issue(record),
    )
  ]
}

#let intestazione-giorni(dati) = grid(
  columns: colonne-timeline(dati.gantt.giorni),
  column-gutter: 0pt,
  ..dati.gantt.etichette.enumerate().map(((indice, data)) => cella-header(
    indice + 1,
    0.42cm,
    contenuto: text(size: 9pt, fill: gantt-testo-secondario, data),
    verticale: true,
    orizzontale: true,
    chiudi: indice + 1 == dati.gantt.giorni,
  )).flatten(),
)

#let fascia-temporale(dati, altezza, testo, dimensione) = {
  box(width: 100%, height: altezza, fill: gantt-sfondo-secondario)[
    #align(center + horizon, box(width: auto, height: 100%)[
      #text(size: dimensione, fill: gantt-testo, testo)
    ])
    #place(left + top, line(
      start: (0pt, altezza),
      end: (100%, altezza),
      stroke: 0.8pt + gantt-testo-secondario,
    ))
  ]
}

#let intestazione-temporale(dati) = {
  let anno = if dati.numero == 1 { "2026" } else { "----" }
  let mese = if dati.numero == 1 { "Novembre" } else { "Mese" }

  stack(
    dir: ttb,
    spacing: 0pt,
    fascia-temporale(dati, 0.34cm, anno, 9pt),
    fascia-temporale(dati, 0.45cm, mese, 8pt),
    intestazione-giorni(dati),
  )
}

#let mostra-gantt(dati) = {
  let records = records-sprint(dati.numero)

  figure(
    kind: image,
    block(
      width: 100%,
      fill: gantt-sfondo,
      stroke: 0.6pt + gantt-bordo,
      inset: (x: 8pt, y: 8pt),
    )[
      #intestazione-temporale(dati)
      #v(-10pt)
      #stack(
        dir: ttb,
        spacing: 0pt,
        ..records.enumerate().map(((indice, record)) => barra-gantt(
          record,
          dati.gantt.giorni,
          primo: indice == 0,
        )),
      )
      #v(5pt)
      #grid(
        columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto, auto),
        column-gutter: 5pt,
        icona-stato((stato: "Done")),
        [#text(size: 6pt, fill: gantt-testo-secondario, "Completato")],
        icona-stato((stato: "In Progress")),
        [#text(size: 6pt, fill: gantt-testo-secondario, "In corso")],
        icona-stato((stato: "Waiting review")),
        [#text(size: 6pt, fill: gantt-testo-secondario, "In revisione")],
        icona-stato((stato: "Todo")),
        [#text(size: 6pt, fill: gantt-testo-secondario, "Da fare")],
        box(width: 0.45cm, height: 1pt, fill: gantt-verde)[],
        [#text(size: 6pt, fill: gantt-testo-secondario, "M1")],
      )
    ],
    caption: [Diagramma di Gantt dello Sprint #dati.numero],
  )
}

#let mostra-sprint(dati) = {
  mostra-preventivo(dati)
  mostra-consuntivo(dati)
  mostra-aggiornamento-risorse(dati)
  mostra-burndown(dati)
  mostra-gantt(dati)
}
