#import "/docs/5_Templates/base.typ": *

// ============================================================================
// IMPORT DELLA TABLE GITHUB PROJECT
// ============================================================================
//
// Il TSV viene letto a tempo di compilazione. Le colonne utilizzate sono:
// Title, URL, Assignees, Status, Linked pull requests, Reviewers, Inizio,
// Fine, Conteggio, Ore, Sprint, Ruolo.
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

#let tsv-linee = read("@byteclubunipd's RTB - Vista a Tabella da scaricare.tsv").split("\n").filter(riga => riga.trim() != "")
#let tsv-intestazioni = tsv-linee.at(0).split("\t").map(valore => valore.trim())
#let tsv-righe = tsv-linee.slice(1)
#let indice-colonna(nome) = {
  let indice = tsv-intestazioni.position(intestazione => intestazione == nome)
  if indice == none {
    panic("Colonna mancante nel TSV: " + nome)
  } else {
    indice
  }
}
#let cella-colonna(colonne, nome) = {
  let indice = indice-colonna(nome)
  if indice < colonne.len() { colonne.at(indice).trim() } else { "" }
}

#let id-url(url) = {
  let parti = url.split("/")
  if parti.len() == 0 { "-" } else { parti.at(parti.len() - 1) }
}

#let tsv-record(riga) = {
  let colonne = riga.split("\t")
  let titolo = cella-colonna(colonne, "Title")
  let url = cella-colonna(colonne, "URL")
  let assegnatari = cella-colonna(colonne, "Assignees")
  let stato = cella-colonna(colonne, "Status")
  let reviewers = cella-colonna(colonne, "Reviewers")
  let inizio = cella-colonna(colonne, "Inizio")
  let fine = cella-colonna(colonne, "Fine")
  let conteggio = cella-colonna(colonne, "Conteggio")
  let ore-testo = if conteggio == "Ore produttive" {
    cella-colonna(colonne, "Ore")
  } else {
    ""
  }
  let sprint = cella-colonna(colonne, "Sprint")
  let ruolo = cella-colonna(colonne, "Ruolo")
  let inizio-data = parse-data(inizio, origine: "Inizio issue " + titolo)
  let fine-data = parse-data(fine, origine: "Fine issue " + titolo)
  (
    id: id-url(url),
    titolo: titolo,
    url: url,
    assegnatari: if assegnatari == "" { "-" } else { assegnatari },
    reviewers: if reviewers == "" { "-" } else { reviewers },
    is-pull-request: url.contains("/pull/"),
    stato: if stato == "" { "-" } else { stato },
    inizio: inizio,
    fine: fine,
    inizio-data: inizio-data,
    fine-data: fine-data,
    sprint: if sprint == "" { 1 } else { int(sprint) },
    ruolo: if ruolo == "" { "-" } else { ruolo },
    conteggio: conteggio,
    previsto_inizio: 1,
    durata_prevista: 1,
    effettivo_inizio: 1,
    durata_effettiva: 1,
    ore: if ore-testo == "" { 0 } else { float(ore-testo.replace(",", ".")) },
  )
}

#let issue-records = tsv-righe.map(tsv-record)
#let records-sprint(numero) = issue-records.filter(record => record.sprint == numero)
#let records-sprint-calcolati(dati) = records-sprint(dati.numero).map(record => adatta-record-sprint(record, dati))
#let persone-record(record) = {
  let persone = if record.is-pull-request and record.ruolo == "Verificatore" {
    record.reviewers
  } else {
    record.assegnatari
  }
  if persone == "-" {
    ()
  } else {
    persone.split(",").map(persona => persona.trim()).filter(persona => persona != "")
  }
}
#let persona-in-record(record, username) = persone-record(record).contains(username)

// ============================================================================
// ORE E COSTI
// ============================================================================

#let ruoli-report = ("Responsabile", "Amministratore", "Analista", "Progettista", "Programmatore", "Verificatore")
#let abbreviazioni-ruolo = ("Resp.", "Amm.", "Anal.", "Prog.", "Program.", "Verif.")
#let costi-ruolo = (30, 20, 25, 25, 15, 15)
#let budget-rtb-ruolo = (30, 30, 60, 36, 48, 48)
#let componenti-report = (brunoGrimaldi, elicoHuang, mattiaMilan, margheritaMonaco, riccardoPontello, lorencaShiroka)
#let colori-risorse = rgb("#C62828")
#let numero-testo(valore) = if valore == int(valore) { str(int(valore)) } else { str(valore) }
#let somma-ore(records, ruolo) = records.filter(record => record.ruolo == ruolo and record.ore > 0).map(record => record.ore).fold(0, (totale, ore) => totale + ore)
#let ore-per-ruolo(records) = ruoli-report.map(ruolo => somma-ore(records, ruolo))
#let costi-per-ruolo(ore) = ore.zip(costi-ruolo).map(((ore-ruolo, costo)) => ore-ruolo * costo)
#let records-fino-a(numero) = issue-records.filter(record => record.sprint <= numero)
#let fine-reale-sprint(dati) = {
  let date = records-sprint-calcolati(dati).filter(record => record.stato == "Done" and record.fine-data != none).map(record => record.fine-data)
  if date.len() == 0 { none } else { date.slice(1).fold(date.at(0), (ultimo, valore) => if valore > ultimo { valore } else { ultimo }) }
}
#let due-cifre(valore) = if valore < 10 { "0" + str(valore) } else { str(valore) }
#let data-testo(data) = if data == none { "—" } else { str(data.year()) + "-" + due-cifre(data.month()) + "-" + due-cifre(data.day()) }

// ============================================================================
// CONFIGURAZIONE DELLA TIMELINE
// ============================================================================

#let colonne-timeline(giorni) = range(1, giorni + 1).map(giorno => 1fr)

// ============================================================================
// TABELLE DI SUPPORTO
// ============================================================================

#let tabella-report(titolo, colonne, intestazioni, righe, riga-totale: none) = figure(
  kind: table,
  table(
    columns: colonne,
    inset: 4pt,
    stroke: 0.5pt,
    fill: (x, y) => if y == 0 {
      tabellaHeader
    } else if riga-totale != none and y == riga-totale {
      tabellaTotale
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

// Tabella a scheda per il registro dei rischi.
// La prima colonna si dimensiona automaticamente sull'etichetta più lunga;
// la cella iniziale occupa entrambe le colonne e costituisce il titolo della scheda.
#let tabella-rischio(
  codice,
  titolo,
  descrizione,
  probabilita,
  ripercussione,
  mitigazione,
) = figure(
  kind: table,
  table(
    columns: (auto, 1fr),
    inset: 4pt,
    stroke: 0.5pt,
    fill: (x, y) => if y == 0 {
      tabellaHeader
    } else if calc.rem(y, 2) == 0 {
      tabellaRigaPari
    } else {
      tabellaRigaDispari
    },
    table.header(
      table.cell(colspan: 2)[#align(center, strong(titolo))],
    ),
    [Codice], [#codice],
    [Descrizione], [#descrizione],
    [Probabilità di avvenimento], [#probabilita],
    [Probabilità di ripercussione], [#ripercussione],
    [Mitigazione], [#mitigazione],
  ),
  caption: [#codice — #titolo],
)

#let grafico-colonne(valori, etichette, colore, titolo) = {
  // L'asse usa range, quindi il suo massimo deve essere un intero anche
  // quando il consuntivo contiene ore frazionarie.
  let massimo-reale = valori.fold(0, (massimo, valore) => calc.max(massimo, valore))
  let massimo = calc.max(1, calc.ceil(massimo-reale))
  let larghezza = 13cm
  let altezza = 5cm
  let spazio = larghezza / etichette.len()
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
        place(left + top, dx: x, dy: altezza - h, box(width: larghezza-colonna, height: h, fill: colore)[])
        place(left + top, dx: indice * spazio, dy: altezza + 5pt)[
          #box(width: spazio)[#align(center)[#text(size: 5.5pt, fill: rgb("#526071"), etichette.at(indice))]]
        ]
      }
      #place(left + top, dx: -1cm, dy: 1.8cm)[
        #rotate(90deg)[#text(size: 7pt, fill: rgb("#07051C"), "Ore")]
      ]
      #place(left + top, dx: 5.1cm, dy: altezza + 0.75cm)[
        #box(width: 2.8cm)[#align(center)[#text(size: 7pt, fill: rgb("#07051C"), "Ruolo")]]
      ]
    ],
    caption: [#titolo],
  )
}

#let mostra-preventivo-ruoli(dati, ore-preventivate: budget-rtb-ruolo) = grafico-colonne(
  ore-preventivate,
  abbreviazioni-ruolo,
  rgb("#0F9D8A"),
  "Preventivo ore per ruolo dello Sprint " + str(dati.numero),
)

#let mostra-consuntivo-ruoli(dati) = grafico-colonne(
  ore-per-ruolo(records-sprint-calcolati(dati)),
  abbreviazioni-ruolo,
  rgb("#8651FF"),
  "Consuntivo ore per ruolo dello Sprint " + str(dati.numero),
)

#let mostra-informazioni-sprint(dati, descrizione) = {
  let fine-reale = fine-reale-sprint(dati)
  let ritardo = if fine-reale == none { "—" } else { numero-testo(calc.max(0, int((fine-reale - dati.data-fine).days()))) }
  tabella-report(
    "Sprint " + str(dati.numero) + ": periodo e avanzamento",
    (1.5fr, 1fr, 1fr, 1fr),
    ("Inizio", "Fine prevista", "Fine reale", "Giorni di ritardo"),
    ((data-testo(dati.data-inizio), data-testo(dati.data-fine), data-testo(fine-reale), ritardo),),
  )
  [*Descrizione:* #descrizione]
}

#let mostra-aggiornamento-risorse(dati, ore-preventivate: (0, 0, 0, 0, 0, 0)) = {
  let precedenti = records-fino-a(dati.numero - 1)
  let correnti = records-sprint-calcolati(dati)
  let righe = componenti-report.enumerate().map(((indice, componente)) => {
    let username = ("BrunoGrimaldi", "ElicoPro", "PitinPitan", "mimi8017", "rpontell", "lololoren").at(indice)
    let valori = ruoli-report.enumerate().map(((ruolo-indice, ruolo)) => {
      let budget = budget-rtb-ruolo.at(ruolo-indice) / componenti-report.len()
      let gia-speso = precedenti.filter(record => persona-in-record(record, username) and record.ruolo == ruolo).map(record => record.ore).fold(0, (totale, ore) => totale + ore)
      let sprint-speso = correnti.filter(record => persona-in-record(record, username) and record.ruolo == ruolo).map(record => record.ore).fold(0, (totale, ore) => totale + ore)
      let residuo = numero-testo(calc.max(0, budget - gia-speso - sprint-speso))
      let sottrazione = if sprint-speso == 0 {
        [(-#numero-testo(sprint-speso))]
      } else {
        text(fill: colori-risorse)[(-#numero-testo(sprint-speso))]
      }
      [#residuo #sottrazione]
    })
    (componente,) + valori
  })
  tabella-report(
    "Sprint " + str(dati.numero) + ": Aggiornamento delle risorse rimanenti (ore)",
    (1.5fr, 0.8fr, 0.8fr, 0.8fr, 0.8fr, 0.9fr, 0.8fr),
    ("Componente",) + abbreviazioni-ruolo,
    righe,
  )
  let spese = ore-per-ruolo(correnti)
  let spese-precedenti = ore-per-ruolo(precedenti)
  let spese-cumulative = spese-precedenti.zip(spese).map(((precedente, corrente)) => precedente + corrente)
  let ore-rimanenti = budget-rtb-ruolo.zip(spese-cumulative).map(((budget, speso)) => calc.max(0, budget - speso))
  let preventivo = costi-per-ruolo(ore-preventivate)
  let costo-sprint = costi-per-ruolo(spese)
  let budget-rimanente = costi-per-ruolo(ore-rimanenti)
  let righe-costo = ruoli-report.enumerate().map(((indice, ruolo)) => {
    let riduzione-ore = if spese.at(indice) == 0 {
      [(-#numero-testo(spese.at(indice)))]
    } else {
      text(fill: colori-risorse)[(-#numero-testo(spese.at(indice)))]
    }
    let riduzione-budget = if costo-sprint.at(indice) == 0 {
      [(-0)]
    } else {
      text(fill: colori-risorse)[(-#numero-testo(costo-sprint.at(indice)))]
    }
    (
      abbreviazioni-ruolo.at(indice),
      numero-testo(costi-ruolo.at(indice)),
      numero-testo(spese.at(indice)),
      numero-testo(preventivo.at(indice)),
      numero-testo(costo-sprint.at(indice)),
      [#numero-testo(ore-rimanenti.at(indice)) #riduzione-ore],
      [#numero-testo(budget-rimanente.at(indice)) #riduzione-budget],
    )
  })
  let riduzione-totale-ore = if spese.sum() == 0 {
    [(-0)]
  } else {
    text(fill: colori-risorse)[(-#numero-testo(spese.sum()))]
  }
  let riduzione-totale-budget = if costo-sprint.sum() == 0 {
    [(-0)]
  } else {
    text(fill: colori-risorse)[(-#numero-testo(costo-sprint.sum()))]
  }
  tabella-report(
    "Sprint " + str(dati.numero) + ": Aggiornamento delle risorse rimanenti",
    (1.2fr, 0.7fr, 0.65fr, 1fr, 0.95fr, 1.15fr, 1.2fr),
    ("Ruolo", "Costo orario (€/h)", "Ore (h)", "Costo Sprint preventivo (€)", "Costo Sprint consuntivo (€)", "Ore rimanenti (h)", "Budget rimanente (€)"),
    righe-costo + ((
      strong("Totale"),
      "—",
      strong(numero-testo(spese.sum())),
      strong(numero-testo(preventivo.sum())),
      strong(numero-testo(costo-sprint.sum())),
      strong([#numero-testo(ore-rimanenti.sum()) #riduzione-totale-ore]),
      strong([#numero-testo(budget-rimanente.sum()) #riduzione-totale-budget]),
    ),),
    riga-totale: 7,
  )
  let scostamento = costo-sprint.sum() - preventivo.sum()
  let valutazione = if scostamento > 0 {
    "Il costo consuntivo è aumentato di " + numero-testo(scostamento) + " € rispetto al preventivo dello Sprint."
  } else if scostamento == 0 {
    "Il costo consuntivo è rimasto uguale a quello previsto per lo Sprint."
  } else {
    "Il costo consuntivo è diminuito di " + numero-testo(0 - scostamento) + " € rispetto al preventivo dello Sprint."
  }
  let budget-massimo = costi-per-ruolo(budget-rtb-ruolo).sum()
  let budget-massimo-rimanente = budget-massimo - costo-sprint.sum()
  [#valutazione Il budget massimo RTB residuo al termine dello Sprint #dati.numero è di #numero-testo(budget-massimo-rimanente) €.]
}

#let mostra-riepilogo-rtb(sprints) = {
  let spese = sprints.map(sprint => ore-per-ruolo(records-sprint-calcolati(sprint))).fold((0, 0, 0, 0, 0, 0), (acc, valori) => acc.zip(valori).map(((totale, valore)) => totale + valore))
  let costi = costi-per-ruolo(spese)
  let righe-riepilogo = ruoli-report.enumerate().map(((indice, ruolo)) => (
    abbreviazioni-ruolo.at(indice),
    numero-testo(spese.at(indice)),
    numero-testo(costi.at(indice)),
    numero-testo(budget-rtb-ruolo.at(indice) * costi-ruolo.at(indice)),
    numero-testo(budget-rtb-ruolo.at(indice) * costi-ruolo.at(indice) - costi.at(indice)),
  ))
  tabella-report(
    "Riepilogo RTB: consuntivo e budget massimo",
    (1.3fr, 0.8fr, 1fr, 1fr, 1fr),
    ("Ruolo", "Ore consuntive (h)", "Costo consuntivo (€)", "Budget RTB (€)", "Saldo (€)"),
    righe-riepilogo + ((
      strong("Totale"),
      strong(numero-testo(spese.sum())),
      strong(numero-testo(costi.sum())),
      strong(numero-testo(costi-per-ruolo(budget-rtb-ruolo).sum())),
      strong(numero-testo(costi-per-ruolo(budget-rtb-ruolo).sum() - costi.sum())),
    ),),
    riga-totale: 7,
  )
  [*Totale RTB:* #numero-testo(costi.sum()) € spesi su #numero-testo(costi-per-ruolo(budget-rtb-ruolo).sum()) € preventivati.]
}

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
  // Il valore viene ricalcolato per ogni giorno dello Sprint usando le date
  // di inizio e di completamento effettivo delle issue.
  let valore-giorno = giorno => records.filter(record => {
    let giorno-inizio = if record.inizio-data == none {
      1
    } else {
      int((record.inizio-data - dati.data-inizio).days()) + 1
    }
    let giorno-fine = if record.stato == "Done" and record.fine-data != none {
      int((record.fine-data - dati.data-inizio).days()) + 1
    } else {
      dati.gantt.giorni + 1
    }
    giorno-inizio <= giorno and giorno < giorno-fine
  }).len()

  let totale-iniziale = if dati.gantt.giorni == 0 { 0 } else { valore-giorno(1) }
  let totale-ideale = records.len()
  // Le osservazioni effettive sono costruite solo nei giorni in cui una o più
  // card vengono chiuse. La coordinata conserva comunque la distanza reale
  // tra i giorni, quindi le etichette non comprimono la timeline.
  let punti = if records.len() == 0 or dati.gantt.giorni == 0 {
    ()
  } else {
    ((giorno: 0, valore: totale-iniziale),) + range(1, dati.gantt.giorni + 1).map(giorno => (
      giorno: giorno,
      valore: valore-giorno(giorno),
    ))
  }
  let massimo = if punti.len() == 0 {
    totale-iniziale
  } else {
    punti.map(punto => punto.valore).fold(totale-iniziale, (acc, valore) => calc.max(acc, valore))
  }
  let scala = calc.max(1, calc.max(massimo, totale-ideale))
  let ideali = (
    (giorno: 0, valore: totale-ideale),
    (giorno: dati.gantt.giorni, valore: 0),
  )
  let altezza = burndown-altezza
  let larghezza = burndown-larghezza
  let effettivi = if punti.len() == 0 {
    ()
  } else {
    punti.map(punto => posizione-punto(punto, scala, dati.gantt.giorni, altezza, larghezza: larghezza))
  }
  let teorici = ideali.map(punto => posizione-punto(punto, scala, dati.gantt.giorni, altezza, larghezza: larghezza))
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
      #for valore in range(0, scala + 1) {
        if valore == 0 or valore == scala or valore == totale-ideale or valore == totale-iniziale or calc.rem(valore, passo-y) == 0 {
          let y = altezza - valore / scala * altezza
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
      #if effettivi.len() > 1 {
        for segmento in range(0, effettivi.len() - 1).map(i => (effettivi.at(i), effettivi.at(i + 1))) {
          place(left + top, line(
            start: (segmento.at(0).x, segmento.at(0).y),
            end: (segmento.at(1).x, segmento.at(1).y),
            stroke: 1.5pt + burndown-viola-scuro,
          ))
        }
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
#let gantt-blu = rgb("#2877FF")
#let gantt-ciano = rgb("#00C7DD")
#let gantt-viola = rgb("#8651FF")
#let gantt-lavanda = rgb("#E1D4EC")
#let gantt-verde = rgb("#15803D")
#let gantt-ambra = rgb("#F59E0B")
#let gantt-corallo = rgb("#E45756")
#let gantt-grigio = rgb("#94A3B8")

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

#let icona-stato-vuota(record) = circle(
  radius: 4pt,
  fill: none,
  stroke: 0.8pt + colore-stato(record),
)

#let contenuto-chip-testo(record, titolo: none) = {
  let titolo = if titolo == none { record.titolo } else { titolo }
  [#box(width: auto)[#text(size: 7pt, fill: gantt-testo, titolo)]
    #h(3pt)
    #text(size: 6pt, fill: gantt-testo-secondario, "#" + record.id)
    #if record.is-pull-request {
      text(size: 6pt, fill: colore-stato(record), " PR")
    }]
}

#let chip-icona(record) = box(
  height: 0.54cm,
  inset: (left: 5pt, y: 2pt),
)[#icona-stato-vuota(record)]

#let contenuto-chip-testo-con-inset(record, titolo: none) = {
  let titolo = if titolo == none { record.titolo } else { titolo }
  box(
    inset: (right: 5pt, y: 2pt),
  )[#contenuto-chip-testo(record, titolo: titolo)]
}

// Restituisce il titolo più lungo che può stare nello spazio disponibile.
// Il calcolo usa la larghezza reale del contenuto, così l'eventuale
// accorciamento dipende dal font e non da una stima del numero di caratteri.
#let titolo-chip-adattato(record, larghezza) = {
  let titolo = record.titolo
  let caratteri = titolo.clusters()
  let candidati = range(0, caratteri.len() + 1).map(limite => {
    let prefisso = caratteri.slice(0, limite).join()
    let testo = if limite == caratteri.len() {
      prefisso
    } else if limite == 0 {
      "…"
    } else {
      prefisso + "…"
    }
    (testo: testo, larghezza: measure(contenuto-chip-testo-con-inset(record, titolo: testo)).width)
  }).filter(candidato => candidato.larghezza <= larghezza)
  if candidati.len() == 0 { "…" } else { candidati.last().testo }
}

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

#let chip-testo(record, larghezza, titolo: none) = {
  let titolo = if titolo == none { record.titolo } else { titolo }
  box(
    width: larghezza,
    height: 0.54cm,
    clip: true,
  )[#contenuto-chip-testo-con-inset(record, titolo: titolo)]
}

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

#let cella-gantt(giorno, primo: false, milestones: ()) = cella-timeline(
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

#let barra-gantt(record, giorni, primo: false, milestones: ()) = layout(size => {
  let durata = calc.min(record.durata_prevista, giorni)
  let inizio = calc.min(record.previsto_inizio, giorni - durata + 1)
  let larghezza-giorno = size.width / giorni
  let larghezza = durata * larghezza-giorno
  let posizione-inizio = (inizio - 1) * larghezza-giorno
  let larghezza-icona = measure(chip-icona(record)).width
  let posizione-testo-base = posizione-inizio + larghezza-icona + 3pt
  let larghezza-contenuto = measure(contenuto-chip-testo-con-inset(record)).width
  let spostamento-testo = calc.max(
    -posizione-testo-base,
    calc.min(0pt, size.width - posizione-testo-base - larghezza-contenuto - 1pt),
  )
  let posizione-testo = posizione-testo-base + spostamento-testo
  let posizione-icona = posizione-inizio + spostamento-testo
  let spazio-testo = calc.max(1pt, size.width - posizione-testo - 1pt)
  let titolo = titolo-chip-adattato(record, spazio-testo)

  box(width: 100%, height: 0.62cm)[
    #grid(
      columns: colonne-timeline(giorni),
      column-gutter: 0pt,
      ..range(1, giorni + 1).map(giorno => cella-gantt(giorno, milestones: milestones, primo: primo)).flatten(),
    )
    #place(
      left + top,
      dx: posizione-inizio,
      dy: 4pt,
      chip-fondo(record, larghezza),
    )
    #place(
      left + top,
      dx: posizione-icona,
      dy: 4pt,
      chip-icona(record),
    )
    #place(
      left + top,
      dx: posizione-testo,
      dy: 4pt,
      chip-testo(record, spazio-testo, titolo: titolo),
    )
  ]
})

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

#let legenda-gantt(dati) = grid(
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

#let gantt-righe-prima-pagina = 33

#let pagina-gantt(dati, records) = block(
  width: 100%,
  // La pagina è volutamente indivisibile: il punto di separazione è statico
  // e lascia sempre alla legenda uno spazio autonomo, senza sovrapposizioni.
  breakable: false,
  fill: gantt-sfondo,
  stroke: 0.6pt + gantt-bordo,
  inset: (x: 8pt, y: 8pt),
)[
  #table(
    columns: 1,
    stroke: none,
    inset: 0pt,
    column-gutter: 0pt,
    row-gutter: 0.5pt,
    table.header(
      repeat: false,
      [#intestazione-temporale(dati)],
    ),
    ..records.enumerate().map(((indice, record)) => [
      #barra-gantt(
        record,
        dati.gantt.giorni,
        milestones: dati.milestones,
        primo: indice == 0,
      )
    ]),
  )
  #v(5pt)
  #align(center)[#legenda-gantt(dati)]
]

#show figure.where(kind: image): set block(breakable: true)

#let mostra-gantt(dati) = {
  let records = records-sprint-calcolati(dati)
  let prima-pagina = records.slice(0, calc.min(gantt-righe-prima-pagina, records.len()))
  let seconda-pagina = if records.len() > gantt-righe-prima-pagina {
    records.slice(gantt-righe-prima-pagina)
  } else {
    ()
  }
  if seconda-pagina.len() == 0 {
    figure(
      kind: image,
      pagina-gantt(dati, prima-pagina),
      caption: [Diagramma di Gantt dello Sprint #dati.numero],
    )
  } else {
    // Il salto è al livello del documento, fuori dalla figura/contenitore.
    // In questo modo la seconda parte non può rimanere nella stessa pagina.
    [
      #pagina-gantt(dati, prima-pagina)
      #label("gantt-sprint-" + str(dati.numero))
      #pagebreak()
      #figure(
        kind: image,
        pagina-gantt(dati, seconda-pagina),
        caption: [Diagramma di Gantt dello Sprint #dati.numero],
      )
    ]
  }
}
