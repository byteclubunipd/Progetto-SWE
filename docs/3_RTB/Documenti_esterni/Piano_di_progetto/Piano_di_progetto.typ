#import "/docs/5_Templates/documento.typ": *
#import "Diagrammi_e_rendiconto_ore_costi.typ": *

#import "../../Documenti_interni/Glossario.typ": termini
#import "@preview/glossy:0.9.2": *

// Attiva la gestione del glossario usando l'elenco dei termini importato.
// I collegamenti automatici sono disabilitati perché vengono personalizzati
// dalla funzione `mostra-termine` definita sopra.
#show: init-glossary.with(
  termini,
  term-links: true,
)

// ============================================================================
// CONFIGURAZIONE AUTOMATICA DI MILESTONE E SPRINT
// ============================================================================
// Formati data accettati: YYYY-MM-DD, YYYY/MM/DD, DD/MM/YYYY,
// "Nov 11, 2026" e "11 Nov 2026".
#let milestones-progetto = milestones-periodo((
  ("M1", "2026-11-27"),
  ("M2", "2026-12-23"),
  ("M3", "2027-01-22"),
))

#let sprint-1 = crea-sprint(1, "2026-11-11", "2026-11-27", milestones: milestones-progetto)
#let sprint-2 = crea-sprint(2, "2026-11-28", "2026-12-14", milestones: milestones-progetto)
#let sprint-3 = crea-sprint(3, "2026-12-15", "2026-12-31", milestones: milestones-progetto)
#let sprint-4 = crea-sprint(4, "2027-01-01", "2027-01-17", milestones: milestones-progetto)
#let sprint-5 = crea-sprint(5, "2027-01-18", "2027-02-03", milestones: milestones-progetto)

// Ore preventivate per ruolo e Sprint: Responsabile, Amministratore,
// Analista, Progettista, Programmatore, Verificatore.
#let ore-preventivate-sprint-1 = (4, 18, 10, 0, 0, 3)
#let ore-preventivate-sprint-2 = (6, 4, 14, 8, 14, 10)
#let ore-preventivate-sprint-3 = (7, 3, 14, 12, 14, 13)
#let ore-preventivate-sprint-4 = (5, 2, 12, 10, 12, 12)
#let ore-preventivate-sprint-5 = (8, 3, 10, 6, 8, 10)

#show: documento.with(
  titolo: "Piano di progetto",
  mostraRegistro: true,
  versione: "0.2.3",
  stato: "Da redigere",
  redazione: (RP),
  verifica: (LS),
  uso: "Esterno",
  destinatari: (
    "Prof. Vardanega Tullio",
    "Prof. Cardin Riccardo",
    "Ergon Informatica S.r.l.",
  ),
  registroModifiche: (
    ("0.2.3", "2026-11-25", "Aggiornamento template e aggiunta termini presenti nel Glossario", RP, LS),
    ("0.2.2", "2026-11-20", "Prima stesura sezione 5 e sprint 1", RP, LS),
    ("0.2.1", "2026-11-19", "Prima stesura dei rischi specifici e sezione 4", RP, LS),
    ("0.2.0", "2026-11-18", "Prima stesura sezioni 1, 2 e 3", RP, LS),
    ("0.1.1", "2026-11-17", "Miglioramento template, diagramma di Gantt e Burndown", RP, LS),
    ("0.1.0", "2026-11-16", "Creazione della struttura iniziale", RP, LS),
  ),
  indice: true,
  tabelle: true,
  immagini: true,
)

= Introduzione

Il presente @piano-di-progetto[Piano di progetto] descrive la @pianificazione[pianificazione], l'organizzazione e il controllo delle attività del gruppo ByteClub per la realizzazione del @capitolato[capitolato] C7 - SmartDashboard, proposto da Ergon Informatica S.r.l. Il documento è redatto nel contesto del progetto didattico di Ingegneria del Software dell'Università degli Studi di Padova e aggiorna progressivamente obiettivi, risorse, rischi, scadenze e risultati.

Il progetto prevede la realizzazione incrementale di una piattaforma per l'acquisizione, la trasformazione e l'analisi di dati aziendali. La @pianificazione[pianificazione] è articolata nei periodi @rtb[RTB] e @pb[PB], a loro volta suddivisi in @sprint[Sprint] verificabili.

== Scopo del documento

Il @piano-di-progetto[Piano di progetto] definisce:

- obiettivi, attività e risultati attesi per ciascuno @sprint[Sprint];
- ruoli, responsabilità, modalità di collaborazione e criteri di @verifica[verifica];
- stima delle ore e dei costi, con aggiornamento tramite preventivi e consuntivi;
- rischi tecnologici, organizzativi, economici e relativi alle persone, con le rispettive strategie di mitigazione;
- calendario, @milestone[milestone], criteri di avanzamento e modalità di gestione delle modifiche.

Il documento è destinato al gruppo ByteClub, ai docenti @committente:pl[committenti] del progetto didattico e alla @proponente[proponente] Ergon Informatica S.r.l. Le informazioni sono mantenute tracciabili nei verbali, nel @repository[repository] e negli strumenti di gestione delle @issue[issue].

== Scopo del prodotto

Il prodotto previsto dal capitolato C7 è una SmartDashboard che consente di acquisire dati da sorgenti eterogenee, conservarli in un raw data store, trasformarli in un data warehouse e presentarli tramite una web app con @dashboard[dashboard] e @api[API]. Il sistema comprende inoltre un layer di @intelligenza-artificiale[intelligenza artificiale] per supportare l'interrogazione e l'interpretazione dei dati, nel rispetto dei vincoli di sicurezza e tracciabilità.

Gli obiettivi progettuali sono:

- fornire una pipeline dati riproducibile e verificabile;
- rendere consultabili indicatori e visualizzazioni tramite interfacce web;
- integrare le componenti mediante contratti @api[API] documentati;
- validare tecnologie, prestazioni, qualità dei dati e risposte del layer AI attraverso un @poc[PoC] e successive evoluzioni incrementali;
- consegnare un @mvp[MVP] verificato, documentato e coerente con i requisiti concordati con la @proponente[proponente].

== Glossario, acronimi e convenzioni 

Per evitare equivoci nella terminologia utilizzata, gli acronimi e i termini tecnici del documento sono raccolti nel @glossario[Glossario], documento separato che riporta per ciascuna voce il termine, l'eventuale contesto di utilizzo e la relativa definizione.

La presenza di una voce nel @glossario[Glossario] è indicata nel testo con una "G" in apice, ad esempio: Esempio#super[G].

Dalla #underline(link(<sezione-2>)[sezione 2]), per facilitare l'identificazione dei rischi, verrà introdotta una convenzione di formato che sà usata per tutto il documento: R[Tipo][Indice].
Il Tipo rappresenta la categoria di rischio, che può essere:
- T: Tecnologico;
- O: Organizzativo;
- P: Personale;
- A: Ambientale;
L'Indice è incrementale e identifica univocamente ogni rischio all'interno di un Tipo.

== Riferimenti

=== Riferimenti normativi

- Regolamento del progetto didattico di Ingegneria del Software, anno accademico 2026/2027.
- @capitolato[Capitolato] C7 - SmartDashboard e documentazione tecnica di Ergon Informatica S.r.l. #footnote[#link("https://www.math.unipd.it/~tullio/IS-1/2026/Progetto/C7-SD.pdf")[Documentazione del @capitolato[capitolato] C7]]
- Standard ISO/IEC/@ieee[IEEE] 12207, usato come riferimento per i processi del ciclo di vita del software.
- @norme-di-progetto[Norme di Progetto] del gruppo ByteClub, per ruoli, comunicazione, @versionamento[versionamento], verifica e gestione delle modifiche.

=== Riferimenti informativi

- Dichiarazione degli impegni e preventivo dei costi del gruppo ByteClub, versione 2.0.0.
- Specifica dei requisiti software secondo @ieee[IEEE] 830-1998.
- @glossario[Glossario]
- ISO/IEC 31000:2018

= Analisi e gestione dei rischi <sezione-2>

Questa sezione descrive l’analisi dei potenziali rischi associati al progetto.
Ogni rischio è stato identificato, analizzato, valutato e sono state definite strategie di gestione e monitoraggio in accordo con lo standard ISO/IEC 31000:2018.
Ogni rischio possiede una probabilità di avvenimento e una di ripercussione, espresse attraverso al seguente scala: Molto bassa, Bassa, Media, Elevata, Molto elevata.

== RT

I rischi tecnologici riguardano l'incertezza delle scelte tecniche, l'integrazione dei componenti, la qualità del prodotto e l'affidabilità delle soluzioni adottate.

=== RT1

  #tabella-rischio(
    "RT1",
    "Complessità tecnologica e d'integrazione",
    [Scelta e integrazione di raw data store, data warehouse, pipeline ETL, web app, @api[API] e layer @ia[AI], con possibili incompatibilità tra librerie e dipendenze da servizi esterni.],
    "Elevata",
    "Elevata",
    [Definizione di contratti @api[API] e di uno schema condiviso, @poc[PoC] delle integrazioni, sviluppo incrementale, @test[test] di qualità dei dati e di regressione. I template condivisi per documentazione, @issue[issue] e @pull-request[pull request], insieme a @github[GitHub] Project, rendono ripetibile e più veloce il workflow.],
  ) <tab-rischio-rt1>

=== RT2

  #tabella-rischio(
    "RT2",
    "Dati incompleti, incoerenti o con schema variabile",
    [Le sorgenti eterogenee possono contenere valori mancanti, formati incompatibili, duplicati o modifiche allo schema, compromettendo trasformazioni, analisi e @dashboard[dashboard].],
    "Media",
    "Elevata",
    [Definizione di un data contract, controlli automatici sulla qualità, dataset sintetico di fallback, @versionamento[versionamento] degli schemi e @test[test] riproducibili della pipeline.],
  ) <tab-rischio-rt2>

=== RT3

  #tabella-rischio(
    "RT3",
    "Risposte AI errate o insight non attendibili",
    [Il layer @ia[AI] può generare @query[query] non corrette, interpretare male le domande o produrre spiegazioni e insight non coerenti con i dati disponibili.],
    "Media",
    "Elevata",
    [Uso di guardrail, domande di riferimento, @query[query] in sola lettura, controlli di coerenza, tracciamento delle fonti e @test[test] di regressione su casi rappresentativi.],
  ) <tab-rischio-rt3>

=== RT4

  #tabella-rischio(
    "RT4",
    "Esposizione di dati aziendali al servizio AI esterno",
    [L'invio di dati o metadati a provider @ia[AI] esterni può causare esposizione di informazioni sensibili o accessi oltre il perimetro autorizzato.],
    "Media",
    "Molto elevata",
    "Minimizzazione e anonimizzazione dei dati, controllo degli accessi, gestione sicura dei segreti, isolamento delle query, logging degli accessi e valutazione preventiva dei flussi verso provider esterni.",
  ) <tab-rischio-rt4>

=== RT5

  #tabella-rischio(
    "RT5",
    "Prestazioni, costi e limiti sui dataset grandi",
    [Dataset ampi, @query[query] complesse o richieste frequenti possono causare latenze elevate, consumo eccessivo di risorse, costi imprevisti o superamento dei limiti dei provider.],
    "Media",
    "Elevata",
    [@poc[PoC] prestazionali, benchmark su dataset rappresentativi, @query[query] limitate, caching, paginazione, monitoraggio dei tempi e dei costi e definizione di soglie operative.],
  ) <tab-rischio-rt5>

=== RT6

  #tabella-rischio(
    "RT6",
    "Incompatibilità o variazioni delle dipendenze esterne",
    [Librerie, @api[API], provider @ia[AI] e servizi di supporto possono cambiare comportamento, versione, disponibilità o condizioni d'uso durante lo @sviluppo[sviluppo].],
    "Media",
    "Media",
    [Astrazione tramite adapter, @versionamento[versionamento] delle dipendenze, mock locali, @test[test] di integrazione, monitoraggio delle modifiche e predisposizione di alternative per i servizi critici.],
  ) <tab-rischio-rt6>

== RO

I rischi organizzativi riguardano il coordinamento del gruppo, la @pianificazione[pianificazione] delle attività, la comunicazione, la distribuzione delle responsabilità e la tracciabilità del lavoro.

=== RO1

  #tabella-rischio(
    "RO1",
    "Sovrapposizione delle responsabilità e perdita di tracciabilità",
    "Passaggi di consegne incompleti, sovrapposizione delle responsabilità, perdita di tracciabilità e uso non uniforme degli strumenti di progetto.",
    "Media",
    "Media",
    [Assegnazione esplicita dei ruoli, template per verbali e documenti, uso uniforme di @github[GitHub] con @issue[issue], @pull-request[pull request] e Project, e @verifica[verifica] periodica della tracciabilità dei prodotti.],
  ) <tab-rischio-ro1>

=== RO2

  #tabella-rischio(
    "RO2",
    "Sottostima delle attività e delle ore necessarie",
    [La complessità del @capitolato[capitolato], l'apprendimento di nuove tecnologie e le attività di integrazione possono richiedere più tempo di quello previsto.],
    "Elevata",
    "Elevata",
    [Scomposizione delle attività in @issue[issue] più piccole, stime conservative, consuntivo a fine @sprint[Sprint], ricalcolo a finire, burndown e rinegoziazione tempestiva delle @funzionalita:pl[funzionalità] opzionali.],
  ) <tab-rischio-ro2>

=== RO3

  #tabella-rischio(
    "RO3",
    [Perdita di tracciabilità tra requisiti, codice, @test[test] e documentazione],
    "La distribuzione del lavoro tra pipeline dati, backend, web app e AI può rendere difficile mantenere allineati requisiti, implementazione, verifiche e documenti.",
    "Media",
    "Elevata",
    [@issue[Issue] collegate ai requisiti, @pull-request[pull request] con riferimenti alle @issue[issue], Project per il controllo dello stato, template di documentazione e Definition of Done con @verifica[verifica] della tracciabilità.],
  ) <tab-rischio-ro3>

== RP

I rischi personali riguardano la disponibilità e la continuità dei componenti, la distribuzione delle competenze, la comunicazione e la condivisione delle conoscenze.

=== RP1

  #tabella-rischio(
    "RP1",
    "Disponibilità ridotta per lavoro, studio e impegni personali",
    "Impegni lavorativi, universitari, sportivi e personali possono ridurre la disponibilità dei componenti e rallentare le attività assegnate. Il rischio è rilevante anche perché il gruppo comprende tre studenti lavoratori.",
    "Elevata",
    "Elevata",
    [Calendario condiviso, margine temporale, @pianificazione[pianificazione] anticipata delle assenze e riassegnazione preventiva delle attività. Template, @issue[issue], @pull-request[pull request] e @github[GitHub] Project rendono visibili gli impegni, facilitano i passaggi di consegne e velocizzano la riorganizzazione del lavoro.],
  ) <tab-rischio-rp1>

=== RP2

  #tabella-rischio(
    "RP2",
    "Competenze insufficienti o conoscenza concentrata",
    "Le diverse tecnologie del progetto possono richiedere competenze non uniformemente distribuite, creando dipendenza da uno o pochi componenti del gruppo.",
    "Media",
    "Elevata",
    [Pair programming, rotazione dei ruoli, sessioni di formazione, documentazione tramite template, code review e condivisione delle @decisione:pl[decisioni] tecniche nelle @issue[issue] e nelle @pull-request[pull request].],
  ) <tab-rischio-rp2>

== RA

I rischi ambientali riguardano fattori esterni al controllo diretto del gruppo, come disponibilità di dati e servizi, vincoli del calendario, cambiamenti del contesto e dipendenze dalla proponente.

=== RA1

  #tabella-rischio(
    "RA1",
    [Indisponibilità o ritardo dei dati della @proponente[proponente]],
    [Il dataset del caso di studio può essere consegnato in ritardo, risultare incompleto o non essere sufficientemente rappresentativo per validare pipeline, warehouse e @dashboard[dashboard].],
    "Media",
    "Elevata",
    [Dataset sintetico di fallback, accordi tempestivi sulle consegne, @validazione[validazione] anticipata del formato, @test[test] riproducibili e registrazione delle dipendenze nel @github[GitHub] Project.],
  ) <tab-rischio-ra1>

=== RA2

  #tabella-rischio(
    "RA2",
    [Indisponibilità di @api[API], provider @ia[AI] o servizi esterni],
    [Servizi cloud, @api[API] di provider @ia[AI] o sistemi utilizzati per l'acquisizione e l'elaborazione dei dati possono essere temporaneamente indisponibili o soggetti a limiti d'uso.],
    "Media",
    "Elevata",
    "Mock locali, retry controllati, gestione esplicita degli errori, adapter sostituibili, caching e disponibilità di una modalità dimostrativa basata su dati e servizi locali.",
  ) <tab-rischio-ra2>

=== RA3

  #tabella-rischio(
    "RA3",
    "Ritardo nei chiarimenti e nelle decisioni sui requisiti",
    "La mancata disponibilità della proponente o il ritardo nelle risposte può lasciare requisiti e criteri di accettazione ambigui, causando rework e ritardi.",
    "Media",
    "Elevata",
    [Incontri SAL calendarizzati, domande raccolte in @issue[issue], verbali condivisi, gestione formale delle modifiche e @pianificazione[pianificazione] di attività a basso rischio durante l'attesa delle @decisione:pl[decisioni].],
  ) <tab-rischio-ra3>

= Modello di sviluppo

== Lo Standard ISO/IEC/IEEE 12207

Il progetto adotta ISO/IEC/@ieee[IEEE] 12207 come riferimento per organizzare i @processo[processi] del ciclo di vita del software. Lo standard viene adattato alla dimensione del gruppo e applicato con un modello incrementale: ogni @sprint[Sprint] produce risultati verificabili, aggiorna la documentazione e rende espliciti rischi, @decisione[decisioni] e cambiamenti.

La @pianificazione[pianificazione] distingue i @processo:pl[processi] primari, di supporto e organizzativi. Le attività sono tracciate tramite @issue[issue], @pull-request[pull request], verbali, documenti di baseline e registrazioni delle ore; la @verifica[verifica] indipendente controlla i prodotti prima del loro consolidamento.

=== I processi primari

- analisi e @validazione[validazione] dei requisiti con la @proponente[proponente];
- @progettazione[progettazione] dell'architettura, della pipeline dati, del data warehouse, delle API e della web app;
- implementazione incrementale delle componenti e del layer @ia[AI];
- integrazione, @test[test] e verifica dei componenti su dati controllati;
- @validazione[validazione] del PoC e del MVP rispetto ai requisiti e ai criteri di accettazione;
- rilascio dei prodotti di baseline e della documentazione associata.

=== I processi di supporto

- gestione della configurazione, dei branch, delle @pull-request[pull request] e delle versioni;
- assicurazione della qualità e @verifica[verifica] indipendente di documenti, codice, dati e risultati;
- gestione dei rischi, delle modifiche, delle non conformità e delle azioni correttive;
- documentazione tecnica e organizzativa, con tracciabilità tra requisiti, attività e verifiche;
- misurazione delle ore, dei costi, dell'avanzamento e della qualità dei prodotti.

=== I processi organizzativi

- @pianificazione[pianificazione] di lungo e breve termine, con preventivo, calendario e @milestone[milestone];
- assegnazione e rotazione dei ruoli, coordinamento del gruppo e gestione delle comunicazioni;
- incontri SAL, riesami di Sprint, retrospettive e registrazione delle @decisione:pl[decisioni];
- miglioramento continuo del @way-of-working[way of working] sulla base dei consuntivi e degli esiti delle verifiche;
- gestione dei rapporti con docenti @committente[committenti] e @proponente[proponente].

== Struttura dello Sprint @agile[Agile] in conformità con lo Standard ISO/IEC/IEEE 12207

Ogni @sprint[Sprint] inizia con la definizione dell'obiettivo, delle attività, delle responsabilità e dei criteri di completamento. Durante l'esecuzione il gruppo aggiorna @issue[issue], ore, rischi e stato dei prodotti, mantenendo il collegamento tra requisiti, codice, documentazione e verifiche.

Al termine dello @sprint[Sprint] si svolgono il riesame dei risultati, il consuntivo delle risorse, l'aggiornamento del burndown e del Gantt, la valutazione dei rischi e la retrospettiva. Le @decisione[decisioni] e le azioni di miglioramento alimentano lo @sprint[Sprint] successivo.

La struttura integra i @processo:pl[processi] ISO/IEC/@ieee[IEEE] 12207: analisi e @progettazione[progettazione] appartengono ai processi primari, @verifica[verifica] e gestione della configurazione a quelli di supporto, mentre @pianificazione[pianificazione], coordinamento, riesami e miglioramento continuo appartengono ai processi organizzativi.

// Figura della struttura dello Sprint Agile: da inserire quando sarà disponibile l'immagine.

= Pianificazione nel lungo termine

== Introduzione

Dopo l'esito negativo della prima candidatura, il gruppo ha corretto i template e il @processo[processo] di @verifica[verifica], scelto il @capitolato[capitolato] C7 e ripresentato la candidatura il 2026-11-06, successivamente aggiudicata. I giorni tra l'aggiudicazione e l'avvio dello @sprint[Sprint] 1, fissato al 2026-11-11, sono stati utilizzati come periodo preliminare per riorganizzare la @repository[repository] e il sito web in preparazione alla fase @rtb[RTB].

Il preventivo complessivo è di 540 ore produttive, pari a 90 ore per componente. La ripartizione per ruolo e il costo risultano i seguenti:

#tabellaDati(
  colonne: (2fr, auto, auto, auto),
  intestazioni: ([Ruolo], [Ore totali (h)], [Costo orario (€/h)], [Costo totale (€)]),
  righe: (
    ([@responsabile[Responsabile]], [48], [30], [1440]),
    ([@amministratore[Amministratore]], [54], [20], [1080]),
    ([@analista[Analista]], [84], [25], [2100]),
    ([@progettista[Progettista]], [114], [25], [2850]),
    ([@programmatore[Programmatore]], [132], [15], [1980]),
    ([@verificatore[Verificatore]], [108], [15], [1620]),
    (strong([Totale]), strong([540]), [—], strong([11070])),
  ),
  rigaTotale: 7,
)

Le quantità sono obiettivi di @pianificazione[pianificazione] e saranno aggiornate tramite i consuntivi degli @sprint[Sprint]. Eventuali variazioni dovranno essere motivate, verificate e registrate senza superare il budget approvato, salvo diversa @decisione[decisione] concordata con i @committente[committenti].

== Attività previste per la RTB

La Requirements and Technology Baseline (@rtb[RTB]) costituisce la prima fase operativa del progetto e ha inizio il 2026-11-11, con l'avvio dello @sprint[Sprint] 1. La conclusione è prevista per il 2027-02-03, al termine dello @sprint[Sprint] 5. La data potrà essere aggiornata in base ai consuntivi e agli esiti del @poc[PoC], ma la baseline dovrà essere riesaminata prima dell'avvio della @product-baseline[Product Baseline].

Le attività previste per la RTB sono riassunte nella seguente tabella:

#tabellaDati(
  colonne: (1.6fr, 3fr),
  intestazioni: ([Attività], [Descrizione]),
  righe: (
    ([@analisi-dei-requisiti[Analisi dei requisiti]], [Raccolta, formalizzazione e @validazione[validazione] dei @requisito-funzionale:pl[requisiti funzionali], @requisito-non-funzionale:pl[requisiti non funzionali] e @requisito-di-vincolo:pl[requisiti di vincolo] della SmartDashboard, con definizione delle priorità e dei criteri di accettazione.]),
    ([@piano-di-progetto[Piano di progetto]], [Definizione della @pianificazione[pianificazione], delle risorse, dei costi, dei rischi, delle responsabilità e dei criteri di monitoraggio del @progetto[progetto].]),
    ([@piano-di-qualifica[Piano di qualifica]], [Definizione delle strategie di @verifica[verifica] e @validazione[validazione] per documenti, pipeline dati, data warehouse, @api[API], @dashboard[dashboard] e @funzionalita:pl[funzionalità] del layer AI.]),
    ([Norme di progetto], [Consolidamento del way of working, delle regole di collaborazione, del flusso @github[GitHub], della gestione delle issue, delle pull request e della verifica dei prodotti.]),
    ([@glossario[Glossario]], [Raccolta e condivisione dei termini relativi a Business Intelligence, ETL, data warehouse, @api[API], @dashboard[dashboard] e @intelligenza-artificiale[intelligenza artificiale].]),
    ([Studio delle tecnologie e dell'architettura], [Confronto tra tecnologie e definizione dell'architettura per raw data store, pipeline ETL, data warehouse, web app, @api[API] e layer @ia[AI].]),
    ([@proof-of-concept[Proof of Concept]], [Realizzazione di un prototipo che dimostri la fattibilità delle integrazioni più rischiose e delle scelte tecnologiche principali su dati controllati.]),
    ([Riesame della RTB], [Verifica con il gruppo, i committenti e la proponente della coerenza tra requisiti, architettura, PoC, piano di qualifica e attività previste per la PB.]),
  ),
)

Le attività saranno distribuite tra gli @sprint[Sprint] 1–5. In particolare, gli @sprint[Sprint] iniziali saranno dedicati alla formazione, alla raccolta dei requisiti e al @poc[PoC]; gli @sprint[Sprint] successivi consolideranno l'architettura, la documentazione e la baseline dei requisiti e delle tecnologie.

== Attività previste per la PB

Al momento non sono disponibili informazioni sufficientemente consistenti per dettagliare in modo definitivo tutte le attività della @product-baseline[Product Baseline] (@pb[PB]): la sua @pianificazione[pianificazione] dipende dall'esito della @rtb[RTB], dalla @validazione[validazione] del @poc[PoC], dai requisiti confermati e dalle @decisione[decisioni] architetturali condivise con Ergon.

Se la @rtb[RTB] si concluderà secondo la tabella di marcia, il preventivo colloca l'avvio della @pb[PB] nel mese di febbraio 2027 e la conclusione dello @sviluppo[sviluppo] principale nel mese di marzo 2027. Il mese di aprile 2027 sarà riservato alla finalizzazione, alla @verifica[verifica] conclusiva, alla documentazione e alla consegna, comunque entro il 2027-04-16.

La @pb[PB] sarà quindi pianificata in modo più dettagliato dopo il riesame della @rtb[RTB].

= Pianificazione a breve termine

== Introduzione

Il gruppo @pianificazione[pianifica] il lavoro con @sprint[Sprint] di due settimane. All'avvio di ogni @sprint[Sprint] vengono fissati obiettivo, attività, ruoli, ore preventivate, criteri di completamento e rischi attesi; durante l'esecuzione vengono aggiornati @issue[issue], ore e stato dei prodotti. Al termine si confrontano preventivo e consuntivo, si aggiornano le risorse rimanenti e si registrano rischi, azioni correttive e @decisione[decisioni] della retrospettiva. La @pianificazione[pianificazione] può essere ricalibrata sulla base dei consuntivi o di nuove indicazioni della @proponente[proponente], mantenendo tracciabilità nel @repository[repository] e nei verbali.

#pagebreak()
== Requirements and Technology Baseline

=== *@sprint[Sprint] 1*

==== Informazioni generali e attività da svolgere
#mostra-informazioni-sprint(sprint-1, [Avvio della @rtb[RTB], consolidamento del @way-of-working[way of working], raccolta iniziale dei requisiti e preparazione del @poc[PoC].])
- Formalizzare ruoli, responsabilità e flusso di lavoro del gruppo.
- Raccogliere i requisiti iniziali e predisporre il @glossario[glossario].
- Configurare @repository[repository], @issue[issue] tracker e workflow di @verifica[verifica].
- Individuare le tecnologie candidate e definire il perimetro del @poc[PoC].

==== Attività svolte
#mostra-burndown(sprint-1)
#mostra-gantt(sprint-1)
#pagebreak()
==== Preventivo ore per ruolo
#mostra-preventivo-ruoli(sprint-1, ore-preventivate: ore-preventivate-sprint-1)

==== Consuntivo ore per ruolo
#mostra-consuntivo-ruoli(sprint-1)

#pagebreak()
==== Aggiornamento delle risorse rimanenti
#mostra-aggiornamento-risorse(sprint-1, ore-preventivate: ore-preventivate-sprint-1)

#pagebreak()
==== Rischi attesi
- *RT1:* complessità dell'integrazione tra le tecnologie candidate; probabilità elevata, impatto elevato; eseguire un @poc[PoC] incrementale e definire contratti tra componenti.
- *RO2:* sottostima delle attività di avvio e raccolta requisiti; probabilità elevata, impatto elevato; scomporre le @issue[issue] e controllare il burndown ogni settimana.
- *RP1:* disponibilità ridotta dei componenti; probabilità elevata, impatto elevato; condividere il calendario e predisporre passaggi di consegne.

==== Rischi incontrati
- *RO1:* rischio da compilare a consuntivo con riferimento a sovrapposizioni o perdite di tracciabilità osservate nello @sprint[Sprint].

==== @efficacia[Efficacia] delle strategie di gestione e mitigazione dei rischi
La valutazione viene compilata al termine dello Sprint indicando rischi mitigati, rischi ancora aperti e azioni correttive concordate.

==== Migliorie da attuare per le attività future
Registrare le migliorie operative, tecniche e organizzative emerse durante il riesame dello Sprint.

==== Retrospettiva
Registrare cosa ha funzionato, cosa non ha funzionato e le azioni concrete concordate per lo Sprint successivo.

#pagebreak()
=== *@sprint[Sprint] 2*

==== Informazioni generali e attività da svolgere
#mostra-informazioni-sprint(sprint-2, [Completamento della raccolta requisiti e @validazione[validazione] delle prime integrazioni tecnologiche.])
- Consolidare requisiti, vincoli e criteri di accettazione.
- Eseguire il @poc[PoC] sulle integrazioni a rischio.
- Aggiornare @piano-di-qualifica[piano di qualifica], @glossario[glossario] e documentazione tecnica.

==== Attività svolte
#mostra-burndown(sprint-2)
#mostra-gantt(sprint-2)

==== Preventivo ore per ruolo
#mostra-preventivo-ruoli(sprint-2, ore-preventivate: ore-preventivate-sprint-2)

==== Consuntivo ore per ruolo
#mostra-consuntivo-ruoli(sprint-2)

#pagebreak()
==== Aggiornamento delle risorse rimanenti
#mostra-aggiornamento-risorse(sprint-2, ore-preventivate: ore-preventivate-sprint-2)

#pagebreak()
==== Rischi attesi
- *RT2:* dati incompleti o con schema variabile; probabilità media, impatto elevato; usare dataset sintetici e controlli automatici di qualità.
- *RA2:* indisponibilità di @api[API] o servizi esterni; probabilità media, impatto elevato; predisporre mock locali e adapter sostituibili.

==== Rischi incontrati
- *RO1:* rischio da compilare a consuntivo con riferimento alla tracciabilità tra requisiti, @issue[issue] e prodotti.

==== @efficacia[Efficacia] delle strategie di gestione e mitigazione dei rischi
La valutazione viene compilata al termine dello Sprint.

==== Migliorie da attuare per le attività future
Registrare le migliorie emerse nel riesame dello Sprint.

==== Retrospettiva
Registrare risultati, problemi e azioni per lo Sprint successivo.

#pagebreak()
=== *@sprint[Sprint] 3*

==== Informazioni generali e attività da svolgere
#mostra-informazioni-sprint(sprint-3, [Definizione dell'architettura e consolidamento della Requirements and Technology Baseline (@rtb[RTB]).])
- Definire l'architettura della pipeline dati, del data warehouse e della web app.
- Documentare interfacce, flussi dati e decisioni tecnologiche.
- Riesaminare requisiti, rischi e risultati del @poc[PoC] con la @proponente[proponente].

==== Attività svolte
#mostra-burndown(sprint-3)
#mostra-gantt(sprint-3)

==== Preventivo ore per ruolo
#mostra-preventivo-ruoli(sprint-3, ore-preventivate: ore-preventivate-sprint-3)

==== Consuntivo ore per ruolo
#mostra-consuntivo-ruoli(sprint-3)

#pagebreak()
==== Aggiornamento delle risorse rimanenti
#mostra-aggiornamento-risorse(sprint-3, ore-preventivate: ore-preventivate-sprint-3)

#pagebreak()
==== Rischi attesi
- *RT3:* risposte @ia[AI] non attendibili; probabilità media, impatto elevato; definire guardrail e @test[test] di regressione.
- *RO3:* perdita di tracciabilità tra requisiti, architettura e verifiche; probabilità media, impatto elevato; collegare @issue[issue], @pull-request[pull request] e documenti.

==== Rischi incontrati
- *RO1:* rischio da compilare a consuntivo.

==== @efficacia[Efficacia] delle strategie di gestione e mitigazione dei rischi
La valutazione viene compilata al termine dello Sprint.

==== Migliorie da attuare per le attività future
Registrare le migliorie emerse nel riesame dello Sprint.

==== Retrospettiva
Registrare risultati, problemi e azioni per lo Sprint successivo.

#pagebreak()
=== *@sprint[Sprint] 4*

==== Informazioni generali e attività da svolgere
#mostra-informazioni-sprint(sprint-4, [Completamento dei documenti @rtb[RTB] e preparazione del riesame della baseline.])
- Completare architettura, @piano-di-qualifica[piano di qualifica] e @norme-di-progetto[norme di progetto].
- Integrare i risultati del @poc[PoC] nella documentazione.
- Preparare criteri e materiale per il riesame RTB.

==== Attività svolte
#mostra-burndown(sprint-4)
#mostra-gantt(sprint-4)

==== Preventivo ore per ruolo
#mostra-preventivo-ruoli(sprint-4, ore-preventivate: ore-preventivate-sprint-4)

==== Consuntivo ore per ruolo
#mostra-consuntivo-ruoli(sprint-4)

#pagebreak()
==== Aggiornamento delle risorse rimanenti
#mostra-aggiornamento-risorse(sprint-4, ore-preventivate: ore-preventivate-sprint-4)

#pagebreak()
==== Rischi attesi
- *RT5:* prestazioni o costi superiori alle attese; probabilità media, impatto elevato; eseguire benchmark e monitorare soglie.
- *RP2:* conoscenza concentrata su pochi componenti; probabilità media, impatto elevato; effettuare pair working e code review.

==== Rischi incontrati
- *RO1:* rischio da compilare a consuntivo.

==== @efficacia[Efficacia] delle strategie di gestione e mitigazione dei rischi
La valutazione viene compilata al termine dello Sprint.

==== Migliorie da attuare per le attività future
Registrare le migliorie emerse nel riesame dello Sprint.

==== Retrospettiva
Registrare risultati, problemi e azioni per lo Sprint successivo.

#pagebreak()
=== *@sprint[Sprint] 5*

==== Informazioni generali e attività da svolgere
#mostra-informazioni-sprint(sprint-5, [Riesame e chiusura della @rtb[RTB], con @decisione[decisioni] per la @product-baseline[Product Baseline].])
- @verifica[Verificare] coerenza tra requisiti, architettura, @poc[PoC] e @piano-di-qualifica[piano di qualifica].
- Consolidare la baseline e registrare le decisioni aperte.
- Pianificare la @product-baseline[Product Baseline] sulla base dei consuntivi @rtb[RTB].

==== Attività svolte
#mostra-burndown(sprint-5)
#mostra-gantt(sprint-5)

==== Preventivo ore per ruolo
#mostra-preventivo-ruoli(sprint-5, ore-preventivate: ore-preventivate-sprint-5)

==== Consuntivo ore per ruolo
#mostra-consuntivo-ruoli(sprint-5)

#pagebreak()
==== Aggiornamento delle risorse rimanenti
#mostra-aggiornamento-risorse(sprint-5, ore-preventivate: ore-preventivate-sprint-5)

#pagebreak()
==== Rischi attesi
- *RA3:* ritardo nei chiarimenti sui requisiti; probabilità media, impatto elevato; calendarizzare il SAL e mantenere attività a basso rischio in attesa delle decisioni.
- *RO2:* scostamento tra ore preventivate e consuntive; probabilità media, impatto elevato; aggiornare il ricalcolo a finire e motivare ogni variazione.

==== Rischi incontrati
- *RO1:* rischio da compilare a consuntivo.

==== @efficacia[Efficacia] delle strategie di gestione e mitigazione dei rischi
La valutazione viene compilata al termine dello Sprint.

==== Migliorie da attuare per le attività future
Registrare le migliorie emerse nel riesame della RTB e applicarle alla PB.

==== Retrospe sttiva
Registrare risultati, problemi e azioni concordate per l'avvio della PB.

#pagebreak()
== Riepilogo RTB

Il riepilogo confronta automaticamente le ore e i costi consuntivati nel TSV con il budget @rtb[RTB] preventivato per ruolo. Il saldo è calcolato sul budget massimo approvato e comprende tutti gli @sprint[Sprint] della @rtb[RTB].

#mostra-riepilogo-rtb((sprint-1, sprint-2, sprint-3, sprint-4, sprint-5))
