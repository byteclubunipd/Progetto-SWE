#import "/docs/5_Templates/documento.typ": *

// Piano di Qualifica
// Nomenclatura: Piano_di_Qualifica v0.1.0.typ

#show: documento.with(
  titolo: "Piano di Qualifica",
  mostraRegistro: true,
  versione: "0.1.0",
  stato: "In redazione",
  redazione: LS,
  verifica: MMO,
  approvazione: RP,
  uso: "Esterno",
  destinatari: "Prof. Tullio Vardanega\nProf. Riccardo Cardin\nErgon Informatica S.r.l.",
  proprietario: "ByteClub",
  registroModifiche: (
    (
      "0.1.0",
      "2026-11-26",
      "Completamento della prima bozza del Piano di Qualifica: definizione degli obiettivi di qualità, delle metriche di processo e di prodotto, delle attività di verifica, degli approcci alla qualifica, del cruscotto di valutazione e delle attività di miglioramento.",
      LS,
      MMO,
    ),
    (
      "0.0.3",
      "2026-11-26",
      "Definizione degli approcci alla qualifica rispetto alle milestone, della validazione con il proponente e della qualifica dello sviluppo per fasi.",
      LS,
      MMO,
    ),
    (
      "0.0.2",
      "2026-11-25",
      "Definizione dell'approccio alla qualità, dei processi di qualità e delle relative metriche di processo.",
      LS,
      MMO,
    ),
    (
      "0.0.1",
      "2026-11-25",
      "Avvio della redazione del Piano di Qualifica: definizione della struttura del documento, degli obiettivi di qualità e dell'approccio generale alla qualifica.",
      LS,
      MMO,
    ),
  )
)

#let pq-scheda(titolo, contenuto, colore: white) = block(
  width: 100%,
  fill: colore,
  stroke: 0.6pt + luma(88%),
  radius: 4pt,
  inset: 8pt,
)[
  #align(center)[#strong(titolo)]
  #v(4pt)
  #align(center)[#contenuto]
]

#let pq-freccia() = align(center)[#text(size: 12pt, "↓")]

#let pq-ciclo-qualita() = figure(
  kind: image,
  block(
    width: 100%,
    fill: white,
    stroke: 0.5pt + luma(95%),
    radius: 4pt,
    inset: 10pt,
  )[
    #grid(
      columns: (1fr, 1fr, 1fr, 1fr),
      column-gutter: 8pt,
      pq-scheda("Pianificare", [Definizione di obiettivi, metriche e soglie.], colore: rgb("#eaf4ff")),
      pq-scheda("Eseguire", [Applicazione dei processi e delle attività previste.], colore: rgb("#eef8f7")),
      pq-scheda("Controllare", [Misurazione dei risultati e confronto con le soglie.], colore: rgb("#f1edff")),
      pq-scheda("Agire", [Azioni correttive e miglioramento continuo.], colore: rgb("#fff3e8")),
    )
    #v(6pt)
    #align(center)[
      #text(size: 8pt)[Il ciclo riparte dalla pianificazione sulla base degli esiti della verifica.]
    ]
  ],
  caption: [Ciclo di miglioramento continuo della qualità],
)

#let pq-processi() = figure(
  kind: image,
  block(
    width: 100%,
    fill: white,
    stroke: 0.5pt + luma(95%),
    radius: 4pt,
    inset: 10pt,
  )[
    #align(center)[#strong("Qualità di processo")]
    #v(7pt)
    #grid(
      columns: (1fr, 1fr, 1fr),
      column-gutter: 8pt,
      pq-scheda("Processi primari", [
        Fornitura
        #linebreak()
        Sviluppo
      ], colore: rgb("#eaf4ff")),
      pq-scheda("Processi di supporto", [
        Documentazione
        #linebreak()
        Verifica
        #linebreak()
        Gestione della configurazione
      ], colore: rgb("#f1edff")),
      pq-scheda("Processi organizzativi", [
        Gestione dei processi
        #linebreak()
        Miglioramento
        #linebreak()
        Formazione
      ], colore: rgb("#eef8f7")),
    )
    #v(7pt)
    #align(center)[
      #text(size: 8pt)[Ogni area è controllata tramite attività di verifica, metriche e azioni di miglioramento.]
    ]
  ],
  caption: [Struttura della qualità di processo],
)

#let pq-qualifica() = figure(
  kind: image,
  block(
    width: 100%,
    fill: white,
    stroke: 0.5pt + luma(95%),
    radius: 4pt,
    inset: 10pt,
  )[
    #grid(
      columns: (1fr, 1fr, 1fr),
      column-gutter: 8pt,
      pq-scheda("Requirements and Technology Baseline", [
        Requisiti concordati
        #linebreak()
        Tecnologie motivate
        #linebreak()
        Proof of Concept
      ], colore: rgb("#eaf4ff")),
      pq-scheda("Product Baseline", [
        Architettura definitiva
        #linebreak()
        Codifica
        #linebreak()
        Test e tracciabilità
      ], colore: rgb("#f1edff")),
      pq-scheda("Customer Acceptance", [
        Dimostrazione al proponente
        #linebreak()
        Requisiti obbligatori
        #linebreak()
        Accettazione
      ], colore: rgb("#eef8f7")),
    )
    #v(7pt)
    #align(center)[
      #text(size: 8pt)[Le evidenze raccolte a una milestone costituiscono la base per la qualifica della fase successiva.]
    ]
  ],
  caption: [Flusso di qualifica rispetto alle milestone],
)

= Introduzione

== Scopo del documento

Il presente documento descrive come il gruppo ByteClub intende verificare e qualificare la documentazione e il prodotto software SmartDashboard, la piattaforma di Business Intelligence self-service potenziata da AI proposta da Ergon Informatica (capitolato C7).

Il Piano di Qualifica specifica gli obiettivi di qualità di processo e di prodotto, le attività di verifica con cui se ne controlla il raggiungimento e gli approcci di qualifica adottati. Il documento riporta inoltre la misurazione dello stato corrente di tali obiettivi.

== Stato della bozza

Questa è una prima bozza (versione 0.1.0). Ha lo scopo di fissare la struttura del documento e le scelte iniziali; non è ancora un documento completo. In particolare:

- le metriche e le soglie riportate sono proposte preliminari, da affinare con l'avanzare dell'Analisi dei Requisiti e della scelta delle tecnologie;
- le soglie che dipendono da valori da concordare con il proponente sono indicate come da definire;
- il cruscotto di valutazione è predisposto ma non contiene ancora misurazioni consolidate.

== Ambito di applicazione

Il Piano di Qualifica si applica a tutti i prodotti del progetto (documenti e software) e a tutti i processi con cui vengono realizzati. Viene aggiornato in modo incrementale, di pari passo con l'evoluzione del way of working descritto nelle Norme di Progetto.

== Riferimenti

=== Riferimenti normativi

- Norme di Progetto (documento interno del gruppo);
- Regolamento del Progetto Didattico, Ingegneria del Software, Università di Padova;
- Capitolato C7, SmartDashboard, Ergon Informatica S.r.l.

=== Riferimenti informativi

- Analisi dei Requisiti (documento del gruppo);
- Piano di Progetto (documento del gruppo);
- Glossario (documento del gruppo);
- ISO/IEC 12207, Systems and software engineering, Software life cycle processes;
- ISO/IEC 25010, Systems and software engineering, Systems and software Quality Requirements and Evaluation (SQuaRE), System and software quality models.

== Terminologia

Per la terminologia specifica del progetto si fa riferimento al documento Glossario.

= Approccio alla qualità

== Principi generali

Il gruppo considera la qualità un obiettivo da pianificare e misurare, non solo da controllare a posteriori. Ogni obiettivo di qualità è quindi associato a una metrica, a una soglia di accettazione e a un momento in cui viene misurato.

La verifica è indipendente: chi redige o realizza un prodotto non ne è anche il verificatore, come previsto dalle Norme di Progetto e dal Regolamento.

== Miglioramento continuo

Il gruppo adotta un ciclo di miglioramento continuo articolato in quattro fasi:

+ *Pianificare:* definire obiettivi e metriche, con le relative soglie;
+ *Eseguire:* svolgere le attività secondo le Norme di Progetto;
+ *Controllare:* misurare i risultati e confrontarli con le soglie;
+ *Agire:* analizzare gli scostamenti e decidere le azioni correttive, che confluiscono nelle retrospettive di fine sprint e nelle Norme di Progetto.

#pq-ciclo-qualita()

== Identificazione delle metriche

Ogni metrica è identificata da un codice univoco, così da poterla richiamare in modo non ambiguo nei verbali, nel Piano di Progetto e nel cruscotto:

- `MPC-<sigla>` per le metriche di qualità di processo;
- `MPD-<sigla>` per le metriche di qualità di prodotto.

Per ogni metrica vengono riportati due livelli di soglia:

- *Accettabile:* valore minimo oltre il quale il risultato è considerato sufficiente;
- *Ottimo:* valore obiettivo a cui il gruppo punta.

Un valore al di sotto della soglia accettabile genera un'anomalia, gestita come descritto nelle Norme di Progetto, e deve essere discusso alla prima riunione interna utile.

= Qualità di processo

La qualità dei processi è organizzata seguendo la suddivisione di ISO/IEC 12207 in processi primari, di supporto e organizzativi. Le metriche proposte sono preliminari e collegate agli strumenti già adottati dal gruppo (project board, issue, Pull Request, foglio delle ore).

#pq-processi()

== Processi primari

=== Fornitura

La fornitura è tenuta sotto controllo attraverso il monitoraggio di costi e avanzamento, in coerenza con il Piano di Progetto. Il costo accettato in aggiudicazione costituisce un limite superiore da non superare.

#tabellaDati(
  colonne: (auto, 2fr, 1fr, 1fr),
  intestazioni: ("Codice", "Metrica", "Accettabile", "Ottimo"),
  righe: (
    ("MPC-SPI", "Schedule Performance Index (valore conseguito diviso valore pianificato)", "≥ 0,90", "≥ 1,00"),
    ("MPC-CPI", "Cost Performance Index (valore conseguito diviso costo effettivo)", "≥ 0,90", "≥ 1,00"),
    ("MPC-EAC", "Estimate at Completion rispetto al preventivo accettato (Baseline at Completion)", "≤ 100%", "≤ 95%"),
    ("MPC-SOR", "Scostamento delle ore effettive dalle ore preventivate, per ruolo", "entro ±15%", "entro ±5%"),
    ("MPC-RNP", "Rischi non previsti occorsi in uno sprint", "≤ 2", "0"),
  ),
)

=== Sviluppo

Le attività di analisi, progettazione e codifica sono pianificate tramite issue e sprint e controllate tramite Pull Request.

#tabellaDati(
  colonne: (auto, 2fr, 1fr, 1fr),
  intestazioni: ("Codice", "Metrica", "Accettabile", "Ottimo"),
  righe: (
    ("MPC-ISP", "Issue completate sul totale delle issue pianificate nello sprint", "≥ 80%", "≥ 95%"),
    ("MPC-ICC", "Issue chiuse con tutti i campi della project board compilati (ore, date, ruolo, ecc.)", "100%", "100%"),
  ),
)

== Processi di supporto

=== Documentazione

#tabellaDati(
  colonne: (auto, 2fr, 1fr, 1fr),
  intestazioni: ("Codice", "Metrica", "Accettabile", "Ottimo"),
  righe: (
    ("MPC-IG", "Indice di Gulpease, per la leggibilità dei testi in lingua italiana", "≥ 40", "≥ 60"),
    ("MPC-EO", "Errori ortografici e grammaticali residui per documento", "0", "0"),
    ("MPC-BT", "Documenti Typst che compilano senza errori", "100%", "100%"),
    ("MPC-CG", "Occorrenze dei termini del Glossario correttamente marcate e collegate", "≥ 90%", "100%"),
  ),
)

=== Verifica

#tabellaDati(
  colonne: (auto, 2fr, 1fr, 1fr),
  intestazioni: ("Codice", "Metrica", "Accettabile", "Ottimo"),
  righe: (
    ("MPC-PRR", "Pull Request integrate dopo la revisione di un componente diverso dall'autore", "100%", "100%"),
    ("MPC-TRP", "Tempo medio di revisione di una Pull Request", "≤ 3 giorni", "≤ 1 giorno"),
    ("MPC-AR", "Anomalie risolte sul totale delle anomalie rilevate", "≥ 80%", "100%"),
  ),
)

=== Gestione della configurazione

Il controllo della configurazione si basa su repository, branch e convenzioni sui commit definiti nelle Norme di Progetto. Non sono al momento previste metriche numeriche dedicate: il rispetto delle convenzioni viene controllato in sede di revisione delle Pull Request (si veda MPC-PRR).

== Processi organizzativi

I processi organizzativi (gestione dei processi, miglioramento, formazione) sono tenuti sotto controllo attraverso le retrospettive di fine sprint e l'aggiornamento delle Norme di Progetto. Le azioni di miglioramento sono tracciate nella sezione dedicata del presente documento.

= Qualità di prodotto

Le caratteristiche di qualità del prodotto sono classificate secondo il modello di ISO/IEC 25010. Le metriche che seguono derivano dal capitolato C7 e sono preliminari: verranno confermate e ampliate man mano che l'Analisi dei Requisiti fissa i requisiti da soddisfare.

== Caratteristiche di qualità considerate

#tabellaDati(
  colonne: (1fr, 2fr),
  intestazioni: ("Caratteristica", "Aspetti rilevanti per SmartDashboard"),
  righe: (
    ("Adeguatezza funzionale", "Costruzione self-service delle dashboard, libreria di widget, filtri trasversali, esportazione in PDF ed Excel, gestione utenti e persistenza, generazione di visualizzazioni da linguaggio naturale, insight automatici."),
    ("Efficienza prestazionale", "Tempi di caricamento contenuti anche su dataset ampi; risposte dell'assistente AI in pochi secondi."),
    ("Affidabilità", "Correttezza delle risposte dell'assistente AI (join errati, doppi conteggi, filtri mancanti), coerenza dei dati tra raw data store e data warehouse."),
    ("Usabilità", "Interfaccia responsive, temi chiaro e scuro, chiarimenti richiesti dall'assistente in caso di domande ambigue."),
    ("Sicurezza", "Accesso autenticato, dashboard associate al singolo utente, gestione delle chiavi API, whitelist di tabelle e colonne, assenza di SQL libero, invio all'API esterna dei soli metadati necessari."),
    ("Manutenibilità", "Separazione logica dei componenti (raw data store, data warehouse, web app), prompt e schema versionati, documentazione del modello dimensionale e del layer AI."),
  ),
)

== Metriche di prodotto

=== Funzionalità e test

#tabellaDati(
  colonne: (auto, 2fr, 1fr, 1fr),
  intestazioni: ("Codice", "Metrica", "Accettabile", "Ottimo"),
  righe: (
    ("MPD-CRO", "Requisiti obbligatori soddisfatti", "100%", "100%"),
    ("MPD-CRD", "Requisiti desiderabili soddisfatti", "da definire", "da definire"),
    ("MPD-TRQ", "Requisiti associati ad almeno un test", "100%", "100%"),
    ("MPD-TS", "Test eseguiti con esito positivo", "100%", "100%"),
    ("MPD-CT", "Copertura del codice (statement coverage)", "≥ 70%", "≥ 85%"),
  ),
)

=== Qualità del codice

#tabellaDati(
  colonne: (auto, 2fr, 1fr, 1fr),
  intestazioni: ("Codice", "Metrica", "Accettabile", "Ottimo"),
  righe: (
    ("MPD-CC", "Complessità ciclomatica massima per funzione", "≤ 15", "≤ 10"),
    ("MPD-SEG", "Segreti (chiavi API, credenziali) presenti nel repository", "0", "0"),
    ("MPD-VUL", "Vulnerabilità note nelle dipendenze", "0 critiche", "0"),
  ),
)

=== Prestazioni

Le soglie di questa sezione dipendono dal dataset di riferimento e dai tempi attesi da Ergon: il capitolato parla di tempi contenuti e di risposte in pochi secondi senza fissare valori. Le soglie verranno concordate con il proponente.

#tabellaDati(
  colonne: (auto, 2fr, 1fr, 1fr),
  intestazioni: ("Codice", "Metrica", "Accettabile", "Ottimo"),
  righe: (
    ("MPD-TLD", "Tempo di caricamento di una dashboard sul dataset di riferimento", "da definire", "da definire"),
    ("MPD-TRA", "Tempo di risposta dell'assistente AI a una richiesta di visualizzazione", "da definire", "da definire"),
  ),
)

=== Layer di intelligenza artificiale

Il capitolato indica come rischio principale delle risposte dell'AI il risultato plausibile ma sbagliato, e chiede una valutazione basata su domande di riferimento con risposta attesa e test di regressione a ogni cambio di prompt o di modello. Le metriche seguenti recepiscono queste indicazioni.

#tabellaDati(
  colonne: (auto, 2fr, 1fr, 1fr),
  intestazioni: ("Codice", "Metrica", "Accettabile", "Ottimo"),
  righe: (
    ("MPD-ACC", "Domande del set di riferimento a cui l'assistente risponde in modo corretto", "da definire", "da definire"),
    ("MPD-RAI", "Test di regressione dell'assistente eseguiti a ogni cambio di prompt o di modello", "100%", "100%"),
    ("MPD-GRV", "Violazioni dei guardrail (accesso a tabelle o colonne fuori whitelist, esecuzione di SQL libero)", "0", "0"),
    ("MPD-TRC", "Risposte dell'assistente tracciabili (prompt, versione del modello, schema usato)", "100%", "100%"),
  ),
)

= Attività di verifica

== Verifica della documentazione

Ogni documento viene verificato prima dell'integrazione in `develop`, secondo quanto previsto dalle Norme di Progetto. La verifica comprende il controllo del contenuto (correttezza, completezza, coerenza con gli altri documenti) e quello formale (rispetto del template, compilazione Typst, ortografia, Glossario).

== Verifica del codice

Il codice viene verificato tramite revisione delle Pull Request, analisi statica e test automatici. Gli strumenti specifici (linter, framework di test, strumento di misura della copertura) saranno scelti insieme alle tecnologie del PoC e riportati nelle Norme di Progetto.

== Tabella delle attività preliminari

#tabellaDati(
  colonne: (auto, 1.2fr, 1.4fr, 1fr),
  intestazioni: ("Attività", "Oggetto", "Tecnica e strumenti", "Quando"),
  righe: (
    ("Revisione delle Pull Request", "Documenti e codice", "Ispezione da parte di un componente diverso dall'autore, tramite GitHub", "Prima di ogni integrazione in `develop`"),
    ("Controllo di compilazione", "Documenti Typst", "`typst compile` e script `build_documents.py`, con i test in `test/test_build_documents.py`", "Prima di aprire una Pull Request e a ogni build"),
    ("Controllo formale dei testi", "Documenti", "Calcolo dell'indice di Gulpease, controllo ortografico, controllo dei termini del Glossario", "A ogni revisione di documento"),
    ("Verifica di coerenza", "Documenti", "Confronto con Analisi dei Requisiti, Piano di Progetto, Norme di Progetto e Glossario", "A ogni revisione di documento"),
    ("Tracciamento requisiti-test", "Requisiti e test", "Tabella di tracciamento tra requisiti, componenti e test", "Dopo la stesura dei requisiti e a ogni loro modifica"),
    ("Analisi statica", "Codice", "Linter, formatter e controllo dei segreti, da definire con le tecnologie scelte", "A ogni Pull Request con codice"),
    ("Test di unità", "Singole unità di codice", "Framework da definire", "Durante la codifica"),
    ("Test di integrazione", "Componenti del sistema (raw data store, data warehouse, web app, assistente AI)", "Framework da definire", "Al completamento dei componenti interessati"),
    ("Test di sistema", "Prodotto rispetto ai requisiti", "Scenari derivati dai requisiti", "Prima di ogni milestone"),
    ("Test di regressione", "Prodotto e assistente AI", "Esecuzione automatica dei test e del set di domande di riferimento", "A ogni modifica rilevante e a ogni cambio di prompt o modello"),
    ("Valutazione dell'assistente AI", "Risposte dell'assistente", "Set di domande di riferimento con risposta attesa, controlli di coerenza e verifica dei guardrail", "Dalla prima versione dell'assistente"),
  ),
)

== Codifica dei test

I test sono identificati con un codice composto da un prefisso e da un numero progressivo, e sono associati ai requisiti che verificano:

- `TU-<n>` per i test di unità;
- `TI-<n>` per i test di integrazione;
- `TS-<n>` per i test di sistema;
- `TA-<n>` per i test di accettazione.

I codici dei requisiti da richiamare nella tracciabilità seguono la convenzione adottata nel documento Analisi dei Requisiti.

== Gestione delle anomalie

Le anomalie rilevate durante la verifica vengono gestite come descritto nelle Norme di Progetto: segnalate al gruppo e, quando necessario, registrate come issue con una descrizione del comportamento, dell'impatto e delle possibili soluzioni.

= Approcci alla qualifica

La qualifica è l'insieme di evidenze con cui il gruppo dimostra, a ciascuna milestone, che prodotti e processi raggiungono gli obiettivi dichiarati.

#pq-qualifica()

== Qualifica rispetto alle milestone

#tabellaDati(
  colonne: (auto, 2fr, 2fr),
  intestazioni: ("Milestone", "Evidenze di qualità", "Approccio"),
  righe: (
    ("Requirements and Technology Baseline", "Requisiti concordati con il proponente; tecnologie motivate; Proof of Concept eseguibile coerente con gli obiettivi; documentazione verificata.", "Verifica dei documenti tramite Pull Request e controlli automatici; misura delle metriche di processo; esecuzione dei test sul Proof of Concept e valutazione preliminare dell'assistente AI."),
    ("Product Baseline", "Architettura definitiva coerente con il Proof of Concept; avanzamento sostanziale della codifica; prodotto dimostrabile.", "Test di unità, integrazione e sistema; misura delle metriche di prodotto; tracciamento requisiti-test; valutazione dell'assistente AI sul set di riferimento."),
    ("Customer Acceptance", "Prodotto dimostrato al proponente; requisiti obbligatori soddisfatti.", "Test di accettazione concordati con il proponente; verifica finale dei requisiti."),
  ),
)

== Validazione con il proponente

La validazione, cioè la conferma che il prodotto risponde alle esigenze di Ergon, avviene tramite gli incontri periodici con il proponente (SAL, stato avanzamento lavori). Il capitolato prevede un allineamento ogni quindici giorni, con la possibilità di incontri più ravvicinati. In tali incontri il gruppo presenta lo stato del prodotto e raccoglie il parere del proponente sulle priorità e sulle funzionalità realizzate. Gli esiti vengono riportati nei verbali esterni.

== Qualifica dello sviluppo per fasi

Il capitolato suggerisce uno sviluppo per fasi: piattaforma BI end-to-end, generazione di visualizzazioni da linguaggio naturale, insight automatici e assistente di dashboard, spiegazione di un indicatore. La qualifica segue le stesse fasi: i test e le metriche di ciascuna fase vengono definiti prima di iniziarne lo sviluppo e rimangono nel set di regressione per le fasi successive.

= Cruscotto di valutazione

Il cruscotto riporta, a ogni sprint, il valore misurato di ciascuna metrica confrontato con le soglie. In questa versione è predisposto ma non è ancora compilato.

#tabellaDati(
  colonne: (auto, 1fr, 1fr, 1fr),
  intestazioni: ("Metrica", "Sprint 1 (2026-11-11 / 2026-11-27)", "Esito", "Note"),
  righe: (
    ("MPC-SPI", "N/D", "N/D", ""),
    ("MPC-CPI", "N/D", "N/D", ""),
    ("MPC-ISP", "N/D", "N/D", ""),
    ("MPC-ICC", "N/D", "N/D", ""),
    ("MPC-IG", "N/D", "N/D", ""),
    ("MPC-BT", "N/D", "N/D", ""),
    ("MPC-PRR", "N/D", "N/D", ""),
  ),
)

Le misurazioni del primo sprint verranno inserite alla sua conclusione, utilizzando i dati esportati dalla project board.

= Retrospettive e auto-miglioramento

Al termine di ogni sprint il gruppo svolge una retrospettiva per individuare ciò che ha funzionato, ciò che non ha funzionato e le azioni di miglioramento. Le azioni vengono registrate nella tabella seguente, con un responsabile, una scadenza e un criterio con cui verificarne il completamento.

#tabellaDati(
  colonne: (auto, 2fr, 1fr, 1fr, 1fr),
  intestazioni: ("ID", "Azione di miglioramento", "Responsabile", "Scadenza", "Stato"),
  righe: (
    ("AM-01", "Definire con il proponente le soglie di prestazione (MPD-TLD, MPD-TRA)", "Responsabile", "Da definire", "Da avviare"),
    ("AM-02", "Scegliere gli strumenti di analisi statica, test e copertura insieme alle tecnologie del Proof of Concept e aggiornare le Norme di Progetto", "Verificatore, Amministratore", "Da definire", "Da avviare"),
    ("AM-03", "Definire il set di domande di riferimento per la valutazione dell'assistente AI", "Analista, Verificatore", "Da definire", "Da avviare"),
    ("AM-04", "Definire la modalità di marcatura automatica dei termini del Glossario, necessaria per MPC-CG", "Amministratore", "Da definire", "Da avviare"),
  ),
)

= Aspetti da formalizzare

Nelle versioni successive del documento verranno integrati:

- la conferma o la revisione delle soglie di tutte le metriche, in base ai dati misurati e al parere del proponente;
- le soglie e le modalità di misura delle metriche di prestazione e di accuratezza dell'assistente AI;
- gli strumenti di verifica e di test, una volta scelte le tecnologie;
- la tabella di tracciamento tra requisiti, componenti e test;
- la descrizione dei test di accettazione, concordati con il proponente;
- il cruscotto compilato con le misurazioni degli sprint conclusi.
