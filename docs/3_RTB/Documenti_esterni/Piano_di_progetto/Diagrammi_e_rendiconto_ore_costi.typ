#import "/docs/5_Templates/base.typ": *

// ============================================================================
// IMPORT DELLA TABLE GITHUB PROJECT
// ============================================================================
//
// Il TSV viene letto a tempo di compilazione. Le colonne utilizzate sono:
// Title, URL, Assignees, Status, Inizio, Fine, Sprint, Ruolo.
// Per aggiornare il Gantt basta riesportare il TSV mantenendo lo stesso nome.

// ============================================================================
// DATE, MILESTONE E SPRINT DINAMICI
// ============================================================================

#let mese-numero(nome) = if nome == "Jan" or nome == "January" {
  1
} else if nome == "Feb" or nome == "February" {
  2
} else if nome == "Mar" or nome == "March" {
  3
} else if nome == "Apr" or nome == "April" {
  4
} else if nome == "May" or nome == "Maggio" {
  5
} else if nome == "Jun" or nome == "June" {
  6
} else if nome == "Jul" or nome == "July" {
  7
} else if nome == "Aug" or nome == "August" {
  8
} else if nome == "Sep" or nome == "September" {
  9
} else if nome == "Oct" or nome == "October" {
  10
} else if nome == "Nov" or nome == "November" or nome == "Novembre" {
  11
} else if nome == "Dec" or nome == "December" or nome == "Dicembre" {
  12
} else {
  panic("Mese non riconosciuto nella data: " + nome)
}

#let bisestile(anno) = calc.rem(anno, 400) == 0 or (
  calc.rem(anno, 4) == 0 and calc.rem(anno, 100) != 0
)

#let giorni-mese(anno, mese) = if mese == 2 {
  if bisestile(anno) { 29 } else { 28 }
} else if mese == 4 or mese == 6 or mese == 9 or mese == 11 {
  30
} else {
  31
}

#let data-valida(anno, mese, giorno, origine) = if anno < 1 or mese < 1 or mese > 12 or giorno < 1 or giorno > giorni-mese(anno, mese) {
  panic("Data non valida (" + origine + "): " + str(anno) + "-" + str(mese) + "-" + str(giorno))
} else {
  datetime(year: anno, month: mese, day: giorno)
}

// Formati supportati: YYYY-MM-DD, YYYY/MM/DD, DD/MM/YYYY,
// "Nov 11, 2026" e "11 Nov 2026".
#let parse-data(testo, origine: "data") = {
  if testo == none or testo.trim() == "" {
    none
  } else {
    let valore = testo.trim()
    let numerica = valore.replace("/", "-").split("-")
    let parole = valore.split(" ").filter(parola => parola.trim() != "")

    if numerica.len() == 3 and numerica.at(0).len() == 4 {
      data-valida(int(numerica.at(0)), int(numerica.at(1)), int(numerica.at(2)), origine)
    } else if numerica.len() == 3 and numerica.at(2).len() == 4 {
      data-valida(int(numerica.at(2)), int(numerica.at(1)), int(numerica.at(0)), origine)
    } else if parole.len() == 3 and parole.at(0).len() <= 3 {
      data-valida(int(parole.at(2)), mese-numero(parole.at(0)), int(parole.at(1).replace(",", "")), origine)
    } else if parole.len() == 3 {
      data-valida(int(parole.at(2)), mese-numero(parole.at(1)), int(parole.at(0).replace(",", "")), origine)
    } else {
      panic("Formato data non riconosciuto (" + origine + "): " + valore)
    }
  }
}

#let giorno-data(data) = {
  let valore = parse-data(data)
  if valore == none { 1 } else { valore.day() - 10 }
}

#let milestone(nome, data) = {
  let valore = parse-data(data, origine: "milestone " + nome)
  if valore == none { panic("La milestone " + nome + " richiede una data") }
  (nome: nome, data: valore, data-testo: data)
}

#let milestones-periodo(voci) = voci.map(voce => milestone(voce.at(0), voce.at(1)))

#let crea-sprint(numero, data-inizio, data-fine, milestones: ()) = {
  let inizio = parse-data(data-inizio, origine: "inizio Sprint " + str(numero))
  let fine = parse-data(data-fine, origine: "fine Sprint " + str(numero))
  if inizio == none or fine == none { panic("Lo Sprint " + str(numero) + " richiede dataInizio e dataFine") }
  if fine < inizio { panic("Intervallo non valido nello Sprint " + str(numero) + ": la fine precede l'inizio") }
  let giorni = int((fine - inizio).days()) + 1
  let etichette = range(0, giorni).map(offset => str((inizio + duration(days: offset)).day()))
  let milestone-sprint = milestones.filter(item => item.data >= inizio and item.data <= fine).map(item => (..item, giorno: int((item.data - inizio).days()) + 1))
  (
    numero: numero,
    data-inizio: inizio,
    data-fine: fine,
    milestones: milestone-sprint,
    gantt: (giorni: giorni, etichette: etichette),
  )
}

#let data-sprint-fallback(data, fallback) = if data == none { fallback } else { data }

#let adatta-record-sprint(record, dati) = {
  let inizio-data = data-sprint-fallback(record.inizio-data, dati.data-inizio)
  let fine-data = data-sprint-fallback(record.fine-data, dati.data-fine)
  let inizio = calc.max(1, int((inizio-data - dati.data-inizio).days()) + 1)
  let fine-prevista = calc.min(dati.gantt.giorni, int((fine-data - dati.data-inizio).days()) + 1)
  let fine-effettiva = if record.stato == "Done" and record.fine-data != none {
    calc.min(dati.gantt.giorni, int((record.fine-data - dati.data-inizio).days()) + 1)
  } else { dati.gantt.giorni }
  (
    ..record,
    previsto_inizio: inizio,
    durata_prevista: calc.max(1, fine-prevista - inizio + 1),
    effettivo_inizio: inizio,
    durata_effettiva: calc.max(1, fine-effettiva - inizio + 1),
  )
}

#let tsv-righe = (read("@byteclubunipd's RTB - Diagramma di Gantt.tsv").split("\n").slice(1)).filter(riga => riga.trim() != "")
#let cell(riga, indice) = if indice < riga.len() { riga.at(indice).trim() } else { "" }

#let id-url(url) = {
  let parti = url.split("/")
  if parti.len() == 0 { "-" } else { parti.at(parti.len() - 1) }
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
  let inizio-data = parse-data(inizio, origine: "Inizio issue " + titolo)
  let fine-data = parse-data(fine, origine: "Fine issue " + titolo)
  (
    id: id-url(url),
    titolo: titolo,
    url: url,
    assegnatari: if assegnatari == "" { "-" } else { assegnatari },
    stato: if stato == "" { "-" } else { stato },
    inizio: inizio,
    fine: fine,
    inizio-data: inizio-data,
    fine-data: fine-data,
    sprint: if sprint == "" { 1 } else { int(sprint) },
    ruolo: if ruolo == "" { "-" } else { ruolo },
    previsto_inizio: 1,
    durata_prevista: 1,
    effettivo_inizio: 1,
    durata_effettiva: 1,
    ore: 0,
  )
}

#let issue-records = tsv-righe.map(tsv-record)
#let records-sprint(numero) = issue-records.filter(record => record.sprint == numero)
#let records-sprint-calcolati(dati) = records-sprint(dati.numero).map(record => adatta-record-sprint(record, dati))

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

// Configurazione predefinita, sovrascrivibile dal documento Piano di progetto.
#let etichette-placeholder = range(1, 18).map(giorno => "MM-DD")
#let gantt-1 = (giorni: 17, etichette: etichette-placeholder)
#let gantt-2 = (giorni: 17, etichette: etichette-placeholder)
#let gantt-3 = (giorni: 17, etichette: etichette-placeholder)
#let gantt-4 = (giorni: 17, etichette: etichette-placeholder)
#let gantt-5 = (giorni: 17, etichette: etichette-placeholder)

#let sprint-1 = crea-sprint(1, "2026-11-11", "2026-11-27")
#let sprint-2 = crea-sprint(2, "2026-11-28", "2026-12-14")
#let sprint-3 = crea-sprint(3, "2026-12-15", "2026-12-31")
#let sprint-4 = crea-sprint(4, "2027-01-01", "2027-01-17")
#let sprint-5 = crea-sprint(5, "2027-01-18", "2027-02-03")

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

#let righe-report(dati) = records-sprint-calcolati(dati).map(record => (
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
  righe-report(dati),
)

#let mostra-consuntivo(dati) = tabella-report(
  "Sprint " + str(dati.numero) + ": Consuntivo importato da GitHub Project",
  (1fr, 2fr, 1fr, 1fr, 2fr, 1fr, 1fr),
  ("ID", "Assegnatari", "Stato", "Ruolo", "Periodo", "Ore", "Costo"),
  righe-report(dati),
)

#let mostra-aggiornamento-risorse(dati) = tabella-report(
  "Sprint " + str(dati.numero) + ": Aggiornamento risorse",
  (1fr, 2fr, 1fr, 1fr),
  ("ID", "Assegnatari", "Stato", "Ruolo"),
  records-sprint-calcolati(dati).map(record => (
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
  let records = records-sprint-calcolati(dati)
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
  let records = records-sprint-calcolati(dati)

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
