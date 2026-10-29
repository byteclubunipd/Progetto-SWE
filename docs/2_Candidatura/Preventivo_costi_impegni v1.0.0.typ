#import "/docs/5_Templates/documento.typ": *

#show: documento.with(
    titolo: "Preventivo dei costi e impegni orari",
    versione: "1.0.0",
    stato: "Da approvare",
    redazione: "Elico Huang",
    verifica: "Riccardo Pontello",
    approvazione: "Tutto il gruppo",
    uso: "Esterno",
    proprietario: "ByteClub",
    destinatari: [
        Prof. Tullio Vardanega \
        Prof. Riccardo Cardin
    ],

    modifiche: (
        ("1.0.0", "28/10/2026", "Tutto il gruppo", "Approvazione del documento"),
        ("0.3.0", "26/10/2026", EH, "Verifica, correzione e aggiornamento riguardo i nuovi elementi emersi"),
        ("0.2.0", "24/10/2026", EH, "Aggiunta sezione di analisi dei ruoli"),
        ("0.1.0", "23/10/2026", EH, "Prima stesura del documento"),
    ),
)

= Introduzione

Con tale documento, il gruppo ByteClub, intende presentavi il preventivo economico e temporale dei costi per il completamento del progetto didattivo relativo al capitolato C3, calcolati sulla base delle ore produttive dei vari ruoli e dei relativi costi. Inoltre viene anche riportata la modalità di rotazione dei ruoli, il totale delle ore produttive per ciascun membro appartenente al gruppo e la data di consegna finale prevista.

= Ripartizione ruoli preventivata

A seguito di una lunga analisi degli impegni personali e di una lunga discussione sulle disponibilità generali del gruppo abbiamo definito la seguente tabella, contenente il costo orario, le ore totali, il costo totale e le ore per membro del gruppo.


#let oreTotali = (60, 54, 84, 120, 126, 108)
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
  strong("Totale"),
  "-",
  strong(str(totaleOre)),
  strong(str(totaleCosti)),
  strong(str(totaleOreMembro)),
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

La suddivisione delle ore tra i diversi ruoli è data da un'attenta analisi del capitolato e da un confronto con l'azienda proponente, dal quale è emersa la necessità di bilanciare le ore tra la progettazione e la realizzazione stessa del prodotto, poiché saranno le parti più dispendiose del progetto. Il numero elevato di ore dedicate al ruolo di verificatore è dato dalla necessità di utilizzare tecnologie nuove e dalla grande attenzione richiesta dall'azienda nell'ambito della privacy e della tutela dei dati. \
Ogni membro del team si impegna a dedicare un totale di *92* ore per lo svolgimento del progetto.

== Partizione interna dei ruoli

L'ammontare delle ore per ogni ruolo è stato diviso equamente tra ogni componente del gruppo.
La rotazione dei ruoli avverrà alla fine di ogni sprint, la cui durata verrà definita in seguito a un consulto con la proponente. La mutazione dei ruoli si effettuerà in modo continuativo fino all'esaurimento delle ore produttive di ciascun ruolo per ogni membro del team.

= Analisi dei ruoli

Nonostante la presenza di diversi ruoli non vi è uno che detenga le competenze per la effettiva costruzione del prodotto, essendo esso un prodotto fisico. Per questo le modalità di coordinamento per fase di progettazione e creazione del contenitore verranno definite a seguire. \
Di seguito viene effettuata una sintetica analisi delle funzioni e caratteristiche di ciascun ruolo.

==  Responsabile

- Governa il team e rappresenta il progetto verso l’esterno (livello customer).
- Detiene la responsabilità su pianificazione e gestione delle risorse; controllo, coordinamento e relazioni esterne.
- Il suo costo orario elevato rende essenziali le ore a lui assegnate, infatti seguirà il team durante tutte le fasi del progetto.

== Amministratore

- Definisce, controlla, e mantiene l’ambiente IT di lavoro.
- Conoscenza dettagliata del way of working e si occupa della sua applicazione.

== Analista

- Conosce il dominio del problema e ha esperienza professionale.
- Definiscono le funzionalità del prodotto, producendo il documento di analisi dei requisiti.
- Il successo del progetto ha una stretta correlanza con questo ruolo.

== Progettista

- Ha competenze tecniche e tecnologiche aggiornate.
- Determina la scelte realizzative e risolve i problemi riscontrati durante lo sviluppo.
- Si occupa del design del prodotto.

== Programmatore

- Possiede competenze tecniche riguardo varie tecnlogie.
- Si occupa della parte principale di sviluppo e dell'implementazione delle funzionalità.
- Possiede deleghe limitate.

== Verificatore

- Seguono l'intera fase di realizzazione del prodotto.
- Possiede competenze tecniche, esperienze professionali e conoscenza del way of working.
- Garantiscono la qualità del codice prodotto.
- Sono fondamentali per la realizzazione di un software robusto e affidabile.

= Preventivo costi e data di consegna

Il costo finale preventivato è di *#totaleCosti €*, il monte ore totale è *#totaleOre h* ovvero *#totaleOreMembro h* per ogni membro del gruppo. \
La data di consegna finale, concordata tra tutti i membri del gruppo è il *21/03/2027*.
