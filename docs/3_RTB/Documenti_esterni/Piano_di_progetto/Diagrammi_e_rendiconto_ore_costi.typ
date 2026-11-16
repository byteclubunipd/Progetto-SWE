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
  "11-11", "11-12", "11-13", "11-14", "11-15",
  "11-16", "11-17", "11-18", "11-19", "11-20",
  "11-21", "11-22", "11-23", "11-24", "11-25",
  "11-26", "11-27",
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
      #place(left + top, line(
        start: (0pt, altezza),
        end: (13cm, altezza),
        stroke: 1pt + luma(35%),
      ))
      #place(left + top, line(
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
      #place(left + top, dx: 3.2cm, dy: altezza + 0.65cm)[
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

// Il Gantt riproduce la vista a bacheca di GitHub Project:
// ogni riga contiene l'icona di stato, il titolo dell'issue, il suo ID,
// l'assegnatario e una timeline giornaliera. Il blu indica il periodo
// pianificato, mentre la barra nera più stretta indica il periodo effettivo.

#let icona-stato(record) = if record.stato == "Done" {
  circle(radius: 4pt, fill: rgb("#7668e8"), stroke: 0.5pt + rgb("#c4c0ff"))[
    #text(size: 5pt, fill: white, "✓")
  ]
} else if record.stato == "In Progress" {
  circle(radius: 4pt, fill: rgb("#1faa63"), stroke: 0.5pt + rgb("#9af0ba"))[
    #text(size: 5pt, fill: white, "•")
  ]
} else {
  circle(radius: 4pt, fill: rgb("#303a46"), stroke: 0.5pt + rgb("#9aa6b5"))
}

#let avatar-assignee(record) = {
  let testo = if record.assegnatari == "-" {
    "?"
  } else {
    record.assegnatari.slice(0, calc.min(2, record.assegnatari.len()))
  }
  box(
    width: 0.38cm,
    height: 0.38cm,
    radius: 50%,
    fill: rgb("#9b6acb"),
    stroke: 0.4pt + rgb("#e6d9f2"),
  )[ #align(center, text(size: 5pt, fill: white, testo)) ]
}

#let chip-issue(record) = box(
  width: 100%,
  height: 0.54cm,
  radius: 4pt,
  fill: rgb("#171d26"),
  stroke: 0.5pt + rgb("#596574"),
  inset: (x: 5pt, y: 2pt),
)[
  #grid(
    columns: (auto, 1fr, auto),
    column-gutter: 4pt,
    icona-stato(record),
    [#text(size: 7pt, fill: rgb("#d8dee7"), record.titolo)
      #h(3pt)
      #text(size: 6pt, fill: rgb("#9da8b5"), "#" + record.id)],
    avatar-assignee(record),
  )
]

#let cella-gantt(giorno, record) = stack(
  dir: ttb,
  spacing: -0.27cm,
  box(
    width: 100%,
    height: 0.34cm,
    fill: if giorno >= record.previsto_inizio and giorno < record.previsto_inizio + record.durata_prevista {
      rgb("#8cb9f1")
    } else {
      rgb("#202832")
    },
    stroke: 0.2pt + rgb("#374452"),
  )[],
  box(
    width: 100%,
    height: 0.11cm,
    fill: if giorno >= record.effettivo_inizio and giorno < record.effettivo_inizio + record.durata_effettiva {
      rgb("#090b0e")
    } else {
      none
    },
  )[],
)

#let barra-gantt(record, giorni) = grid(
  columns: colonne-timeline(giorni),
  column-gutter: 0pt,
  ..range(1, giorni + 1).map(giorno => cella-gantt(giorno, record)).flatten(),
)

#let intestazione-giorni(dati) = grid(
  columns: colonne-timeline(dati.gantt.giorni),
  column-gutter: 0pt,
  ..dati.gantt.etichette.map(data => box(
    width: 100%,
    height: 0.45cm,
    fill: rgb("#252e39"),
    stroke: 0.2pt + rgb("#46515e"),
  )[ #align(center, text(size: 5pt, fill: rgb("#b7c0cb"), data)) ]).flatten(),
)

#let mostra-gantt(dati) = {
  let records = records-sprint(dati.numero)

  figure(
    kind: image,
    block(
      width: 100%,
      fill: rgb("#111820"),
      stroke: 0.6pt + rgb("#3b4653"),
      inset: (x: 8pt, y: 8pt),
    )[
      #grid(
        columns: (5.8cm, 1fr),
        gutter: 6pt,
        box(
          width: 100%,
          height: 0.45cm,
          fill: rgb("#252e39"),
          stroke: 0.2pt + rgb("#46515e"),
          inset: (x: 5pt, y: 2pt),
        )[ #text(size: 6pt, fill: rgb("#b7c0cb"), "Sprint " + str(dati.numero)) ],
        intestazione-giorni(dati),
      )
      #v(3pt)
      #stack(
        dir: ttb,
        spacing: 3pt,
        ..records.map(record => grid(
          columns: (5.8cm, 1fr),
          gutter: 6pt,
          chip-issue(record),
          barra-gantt(record, dati.gantt.giorni),
        )).flatten(),
      )
      #v(7pt)
      #grid(
        columns: (auto, auto, auto, auto),
        column-gutter: 5pt,
        box(width: 0.45cm, height: 0.24cm, fill: rgb("#8cb9f1"), stroke: 0.2pt + rgb("#374452"))[],
        [#text(size: 6pt, fill: rgb("#cbd5e1"), "Periodo previsto")],
        box(width: 0.45cm, height: 0.10cm, fill: rgb("#090b0e"))[],
        [#text(size: 6pt, fill: rgb("#cbd5e1"), "Periodo effettivo")],
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
