#import "/docs/5_Templates/documento.typ": *

#show: documento.with(
    titolo: "Preventivo dei costi e impegni orari",
    versione: "1.0.0",
    stato: "Da verificare",
    redazione: "Elico Huang",
    verifica: "Riccardo Pontello",
    approvazione: "Mattia Milan",
    uso: "Esterno",
    proprietario: "Byte Club",
    destinatari: [
        Prof. Tullio Vardanega \
        Prof. Riccardo Cardin
    ],

    modifiche: (
        ("1.0.0", "23/10/2026", EH, "Prima stesura del documento"),
    ),
)

= Introduzione

Tale documento presenta il preventivo economico e temporale dei costi per il completamento del progetto didattivo relativo al capitolato C3, calcolati sulla base delle ore produttive dei vari ruoli e dei relativi costi. Inoltre viene anche riportata la modalità di rotazione dei ruoli, il totale delle ore produttive per ciascun membro appartenente al gruppo e la data di consegna finale prevista.

= Ripartizione ruoli preventivata

A seguito di una lunga analisi degli impegni personali e di una lunga discussione sulle disponibilità generali del gruppo abbiamo dedotto la seguente tabella, contenente la suddivisione delle ore di lavoro tra i vari ruoli. 


#let oreTotali = (48, 54, 84, 120, 126, 120)
#let COSTIORARI = (30, 20, 25, 25, 15, 15)
#let NUMEROMEMBRI = 6

#let costiTotali = oreTotali.zip(COSTIORARI).map(((ore, costiOrari)) => ore * costiOrari)
#let orePerMembro = oreTotali.map(ore => ore / NUMEROMEMBRI)

#let ruoli = (
  "Responsabile",
  "Amministratore",
  "Analista",
  "Progettista",
  "Programmatore",
  "Verificatore",
)

#let righe = ruoli.zip(COSTIORARI).zip(oreTotali).zip(costiTotali).zip(orePerMembro).map((((((ruolo, costoOrario), ore), costoTotale), oreMembro)) => (
    ruolo,
    str(costoOrario),
    str(ore),
    str(costoTotale),
    str(oreMembro),
))

#let totaleOre = oreTotali.sum()
#let totaleCosti = costiTotali.sum()
#let totaleOreMembro = orePerMembro.sum()

#let righeFinali = righe + ((
  "Totale",
  "-",
  str(totaleOre),
  str(totaleCosti),
  str(totaleOreMembro),
),)

#tabellaDati(
  colonne: (2fr, 2fr, 2fr, 2fr, 1fr),
  intestazioni: (
    [Ruolo],
    [Costo orario (€/h)],
    [Ore totali (h)],
    [Costo totale (€)],
    [Ore per membro],
  ),
  righe: righeFinali,
)
La suddivisione delle ore tra i diversi ruoli è data da un'attenta analisi del capitolato e da un confronto con l'azienda proponente, dal quale è emersa la necessità di bilanciare le ore tra la progettazione e la realizzazione stessa del prodotto, dando sempre priorità a un corretta esecuzione dei valori dell'ingegneria del software. \
Ogni membro del team si impegna a dedicare un totale di 92 ore per lo svolgimento del progetto.

== Partizione interna dei ruoli

La rotazione dei ruoli avverrà alla fine di ogni sprint, la cui durata verrà definita in seguito a un consulto con la proponente. La mutazione dei ruoli si effettuerà in modo continuativo fino all'esaurimento delle ore produttive di ciascun ruolo per ogni membro del team.

= Preventivo costi e data di consegna

Il costo finale preventivato è di 11.310 €.\ 
La data di consegna finale, concordata tra tutti i membri del gruppo è il 21/03/2027.
