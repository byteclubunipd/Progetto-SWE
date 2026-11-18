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

#let nome-mese(numero) = (
  "Gennaio", "Febbraio", "Marzo", "Aprile", "Maggio", "Giugno",
  "Luglio", "Agosto", "Settembre", "Ottobre", "Novembre", "Dicembre",
).at(numero - 1)

// Raggruppa i giorni consecutivi dello Sprint per mese o anno.
#let segmenti-temporali(dati, livello) = {
  let inizio = dati.data-inizio
  let primo-data = inizio
  let primo-chiave = if livello == "anno" { primo-data.year() } else { primo-data.month() }
  let primo-testo = if livello == "anno" { str(primo-data.year()) } else { nome-mese(primo-data.month()) }
  let primo = (chiave: primo-chiave, testo: primo-testo, giorni: 1)

  range(1, dati.gantt.giorni).fold((primo,), (acc, offset) => {
    let data = inizio + duration(days: offset)
    let chiave = if livello == "anno" { data.year() } else { data.month() }
    let testo = if livello == "anno" { str(data.year()) } else { nome-mese(data.month()) }
    let ultimo = acc.last()
    if ultimo.chiave == chiave {
      let senza-ultimo = acc.slice(0, acc.len() - 1)
      senza-ultimo + ((..ultimo, giorni: ultimo.giorni + 1),)
    } else {
      acc + ((chiave: chiave, testo: testo, giorni: 1),)
    }
  })
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
  let ore-testo = cell(colonne, 8)
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
    ore: if ore-testo == "" { 0 } else { int(ore-testo) },
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

#let mostra-preventivo-ruoli(dati) = {
  let records = records-sprint-calcolati(dati)
  let ruoli = ("Responsabile", "Amministratore", "Analista", "Progettista", "Programmatore", "Verificatore")
  let ore-ruolo(ruolo) = records.filter(record => record.ruolo == ruolo).map(record => record.ore).fold(0, (totale, ore) => totale + ore)
  let valori = ruoli.map(ruolo => ore-ruolo(ruolo))
  let massimo = calc.max(1, valori.fold(0, (massimo, valore) => calc.max(massimo, valore)))
  let larghezza = 13cm
  let altezza = 5cm
  let spazio = larghezza / ruoli.len()
  let larghezza-colonna = spazio * 0.58

  figure(
    kind: image,
    block(
      width: 100%,
      height: 7.4cm,
      stroke: 0.5pt,
      inset: (left: 1.35cm, right: 0.5cm, top: 0.45cm, bottom: 0.45cm),
    )[
      #for valore in range(0, massimo + 1) {
        let presente = valori.fold(false, (trovato, elemento) => trovato or elemento == valore)
        if valore == 0 or presente {
          let y = altezza - valore / massimo * altezza
          place(left + top, line(
            start: (0pt, y),
            end: (larghezza, y),
            stroke: 0.45pt + rgb("#E5E7EB"),
          ))
          place(left + top, dx: -0.32cm, dy: y - 3pt)[
            #text(size: 6pt, fill: rgb("#526071"), str(valore))
          ]
        }
      }
      #place(left + top, line(
        start: (0pt, altezza),
        end: (larghezza, altezza),
        stroke: 1pt + luma(35%),
      ))
      #place(left + top, line(
        start: (0pt, 0pt),
        end: (0pt, altezza),
        stroke: 1pt + luma(35%),
      ))
      #for elemento in valori.enumerate() {
        let indice = elemento.at(0)
        let ore = elemento.at(1)
        let x = indice * spazio + (spazio - larghezza-colonna) / 2
        let h = ore / massimo * altezza
        place(left + top, dx: x, dy: altezza - h, box(width: larghezza-colonna, height: h, fill: rgb("#8651FF"))[])
        place(left + top, dx: indice * spazio, dy: altezza + 5pt)[
          #box(width: spazio)[#align(center)[#text(size: 5.5pt, fill: rgb("#526071"), ruoli.at(indice))]]
        ]
      }
      #place(left + top, dx: -1cm, dy: 1.8cm)[
        #rotate(90deg)[#text(size: 7pt, fill: rgb("#07051C"), "Ore")]
      ]
      #place(left + top, dx: 5.1cm, dy: altezza + 0.75cm)[
        #box(width: 2.8cm)[#align(center)[#text(size: 7pt, fill: rgb("#07051C"), "Ruolo")]]
      ]
    ],
    caption: [Preventivo ore per ruolo dello Sprint #dati.numero],
  )
}

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

#let burndown-larghezza = 13cm
#let burndown-altezza = 5cm
#let burndown-fucsia = rgb("#D946EF")
#let burndown-viola-scuro = rgb("#4C1D95")
#let burndown-testo = rgb("#07051C")
#let burndown-testo-secondario = rgb("#526071")

#let posizione-punto(punto, scala, giorni, altezza, larghezza: burndown-larghezza) = (
  x: punto.giorno / calc.max(1, giorni) * larghezza,
  y: altezza - punto.valore / scala * altezza,
)

#let mostra-burndown(dati) = {
  let records = records-sprint-calcolati(dati)
  let totale = calc.max(1, records.len())
  let rimanenti = records.filter(record => record.stato != "Done").len()
  let punti = (
    (giorno: 0, valore: totale),
    (giorno: 6, valore: rimanenti),
    (giorno: dati.gantt.giorni, valore: rimanenti),
  )
  // Il burndown ideale parte dal totale iniziale e arriva a zero
  // nell'ultimo giorno: valore(giorno) = totale * (1 - giorno / giorni).
  let ideali = (
    (giorno: 0, valore: totale),
    (giorno: dati.gantt.giorni, valore: 0),
  )
  let altezza = burndown-altezza
  let larghezza = burndown-larghezza
  let effettivi = punti.map(punto => posizione-punto(punto, totale, dati.gantt.giorni, altezza, larghezza: larghezza))
  let teorici = ideali.map(punto => posizione-punto(punto, totale, dati.gantt.giorni, altezza, larghezza: larghezza))
  let passo-x = calc.max(1, calc.ceil(dati.gantt.giorni / 8))
  // Mostra le tacche dell'asse Y ogni cinque issue, mantenendo comunque
  // sempre visibili il valore iniziale e lo zero.
  let passo-y = 5

  figure(
    kind: image,
    block(
      width: 100%,
      height: 8.2cm,
      stroke: 0.5pt,
      inset: (left: 1.35cm, right: 0.5cm, top: 0.45cm, bottom: 0.45cm),
    )[
      #for valore in range(0, totale + 1) {
        if valore == 0 or valore == totale or calc.rem(valore, passo-y) == 0 {
          let y = altezza - valore / totale * altezza
          place(left + top, line(
            start: (0pt, y),
            end: (larghezza, y),
            stroke: 0.45pt + rgb("#E5E7EB"),
          ))
          place(left + top, dx: -0.32cm, dy: y - 3pt)[
            #text(size: 6pt, fill: burndown-testo-secondario, str(valore))
          ]
        }
      }
      #for giorno in range(0, dati.gantt.giorni + 1) {
        if giorno == 0 or giorno == dati.gantt.giorni or calc.rem(giorno, passo-x) == 0 {
          let x = giorno / calc.max(1, dati.gantt.giorni) * larghezza
          place(left + top, line(
            start: (x, 0pt),
            end: (x, altezza),
            stroke: 0.45pt + rgb("#E5E7EB"),
          ))
          place(left + top, dx: x - 4pt, dy: altezza + 5pt)[
            #text(size: 6pt, fill: burndown-testo-secondario, str(giorno))
          ]
        }
      }
      #place(left + top, line(
        start: (0pt, altezza),
        end: (larghezza, altezza),
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
          stroke: 1.5pt + burndown-fucsia,
        ))
      }
      #for segmento in range(0, effettivi.len() - 1).map(i => (effettivi.at(i), effettivi.at(i + 1))) {
        place(left + top, line(
          start: (segmento.at(0).x, segmento.at(0).y),
          end: (segmento.at(1).x, segmento.at(1).y),
          stroke: 1.5pt + burndown-viola-scuro,
        ))
      }
      #for punto in effettivi {
        place(left + top, dx: punto.x - 3pt, dy: punto.y - 3pt, circle(radius: 3pt, fill: burndown-viola-scuro))
      }
      #place(left + top, dx: -1.55cm, dy: 1.65cm)[
        #rotate(90deg)[#text(size: 7pt, fill: burndown-testo, "Issue rimanenti")]
      ]
      #place(left + top, dx: 5cm, dy: altezza + 0.65cm)[
        #box(width: 3cm)[#align(center)[#text(size: 7pt, fill: burndown-testo, "Giorni di sprint")]]
      ]
      #place(left + top, dx: 3.2cm, dy: altezza + 1.25cm)[
        #grid(
          columns: (auto, auto, auto, auto),
          column-gutter: 5pt,
          box(width: 0.45cm, height: 2pt, fill: burndown-fucsia)[],
          [Burndown ideale],
          box(width: 0.45cm, height: 2pt, fill: burndown-viola-scuro)[],
          [Issue rimanenti],
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
#let gantt-ambra = rgb("#F59E0B")
#let gantt-corallo = rgb("#E45756")
#let gantt-grigio = rgb("#94A3B8")

#let giorno-milestone = 17

#let colore-milestone(milestone) = if milestone.nome == "M2" {
  gantt-ambra
} else if milestone.nome == "M3" {
  gantt-corallo
} else {
  gantt-verde
}

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

#let cella-gantt(giorno, record: none, primo: false, milestones: ()) = cella-timeline(
  giorno,
  0.62cm,
  settimanale: true,
  contenuto: [
    #for milestone in milestones {
      if giorno == milestone.giorno {
        let colore = colore-milestone(milestone)
        place(center + top, line(
          start: (0pt, 0pt),
          end: (0pt, 0.62cm),
          stroke: 1pt + colore,
        ))
        if primo {
          place(center + top, circle(radius: 2.4pt, fill: colore))
        }
      }
    }
  ],
)

#let barra-gantt(record, giorni, primo: false, milestones: ()) = {
  let durata = calc.min(record.durata_prevista, giorni)
  let contenuto-giorni = calc.max(durata, calc.ceil(record.titolo.len() / 12))
  let inizio = calc.min(record.previsto_inizio, giorni - contenuto-giorni + 1)
  let larghezza = durata * (100% / giorni)

  box(width: 100%, height: 0.62cm)[
    #grid(
      columns: colonne-timeline(giorni),
      column-gutter: 0pt,
      ..range(1, giorni + 1).map(giorno => cella-gantt(giorno, milestones: milestones, primo: primo)).flatten(),
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

#let fascia-temporale(dati, livello, altezza, dimensione) = grid(
  columns: colonne-timeline(dati.gantt.giorni),
  column-gutter: 0pt,
  ..segmenti-temporali(dati, livello).map(segmento => grid.cell(
    colspan: segmento.giorni,
  )[
#box(width: 100%, height: altezza, fill: gantt-sfondo-secondario)[
  #align(center + horizon, text(size: dimensione, fill: gantt-testo, segmento.testo))
  #place(right + top, line(
    start: (0pt, 0pt),
    end: (0pt, altezza),
    stroke: 0.8pt + gantt-testo-secondario,
  ))
  #place(left + top, line(
    start: (0pt, altezza),
    end: (100%, altezza),
    stroke: 0.8pt + gantt-testo-secondario,
  ))
]
    ]
  ).flatten(),
)

#let intestazione-temporale(dati) = stack(
  dir: ttb,
  spacing: 0pt,
  fascia-temporale(dati, "anno", 0.34cm, 9pt),
  fascia-temporale(dati, "mese", 0.45cm, 8pt),
  intestazione-giorni(dati),
)

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
          milestones: dati.milestones,
          primo: indice == 0,
        )),
      )
      #v(5pt)
      #grid(
        columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto, auto, auto, auto, auto, auto),
        column-gutter: 5pt,
        icona-stato((stato: "Done")),
        [#text(size: 6pt, fill: gantt-testo-secondario, "Completato")],
        icona-stato((stato: "In Progress")),
        [#text(size: 6pt, fill: gantt-testo-secondario, "In corso")],
        icona-stato((stato: "Waiting review")),
        [#text(size: 6pt, fill: gantt-testo-secondario, "In revisione")],
        icona-stato((stato: "Todo")),
        [#text(size: 6pt, fill: gantt-testo-secondario, "Da fare")],
        ..dati.milestones.map(milestone => (
          box(width: 0.45cm, height: 1pt, fill: colore-milestone(milestone))[],
          [#text(size: 6pt, fill: gantt-testo-secondario, milestone.nome)],
        )).flatten(),
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
