#import "/docs/5_Templates/documento.typ": *
#import "Diagrammi_e_rendiconto_ore_costi.typ": *
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

#show: documento.with(
  titolo: "Piano di progetto",
  mostraRegistro: true,
  versione: "0.2.1",
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

Il presente Piano di progetto descrive la pianificazione, l'organizzazione e il controllo delle attività del gruppo ByteClub per la realizzazione del capitolato C7 - SmartDashboard, proposto da Ergon Informatica S.r.l. Il documento è redatto nel contesto del progetto didattico di Ingegneria del Software dell'Università degli Studi di Padova e aggiorna progressivamente obiettivi, risorse, rischi, scadenze e risultati.

Il progetto prevede la realizzazione incrementale di una piattaforma per l'acquisizione, la trasformazione e l'analisi di dati aziendali. La pianificazione è articolata nei periodi RTB e PB, a loro volta suddivisi in Sprint verificabili.

== Scopo del documento

Il Piano di progetto definisce:

- obiettivi, attività e risultati attesi per ciascuno Sprint;
- ruoli, responsabilità, modalità di collaborazione e criteri di verifica;
- stima delle ore e dei costi, con aggiornamento tramite preventivi e consuntivi;
- rischi tecnologici, organizzativi, economici e relativi alle persone, con le rispettive strategie di mitigazione;
- calendario, milestone, criteri di avanzamento e modalità di gestione delle modifiche.

Il documento è destinato al gruppo ByteClub, ai docenti committenti del progetto didattico e alla proponente Ergon Informatica S.r.l. Le informazioni sono mantenute tracciabili nei verbali, nel repository e negli strumenti di gestione delle issue.

== Scopo del prodotto

Il prodotto previsto dal capitolato C7 è una SmartDashboard che consente di acquisire dati da sorgenti eterogenee, conservarli in un raw data store, trasformarli in un data warehouse e presentarli tramite una web app con dashboard e API. Il sistema comprende inoltre un layer di intelligenza artificiale per supportare l'interrogazione e l'interpretazione dei dati, nel rispetto dei vincoli di sicurezza e tracciabilità.

Gli obiettivi progettuali sono:

- fornire una pipeline dati riproducibile e verificabile;
- rendere consultabili indicatori e visualizzazioni tramite interfacce web;
- integrare le componenti mediante contratti API documentati;
- validare tecnologie, prestazioni, qualità dei dati e risposte del layer AI attraverso un PoC e successive evoluzioni incrementali;
- consegnare un MVP verificato, documentato e coerente con i requisiti concordati con la proponente.

== Glossario, acronimi e convenzioni 

Per evitare equivoci nella terminologia utilizzata, gli acronimi e i termini tecnici del documento sono raccolti nel Glossario, documento separato che riporta per ciascuna voce il termine, l'eventuale contesto di utilizzo e la relativa definizione.

La presenza di una voce nel Glossario è indicata nel testo con una "G" in apice, ad esempio: Esempio#super[G].

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
- Capitolato C7 - SmartDashboard e documentazione tecnica di Ergon Informatica S.r.l. #footnote[#link("https://www.math.unipd.it/~tullio/IS-1/2026/Progetto/C7-SD.pdf")[Documentazione del capitolato C7]]
- Standard ISO/IEC/IEEE 12207, usato come riferimento per i processi del ciclo di vita del software.
- Norme di Progetto del gruppo ByteClub, per ruoli, comunicazione, versionamento, verifica e gestione delle modifiche.

=== Riferimenti informativi

- Dichiarazione degli impegni e preventivo dei costi del gruppo ByteClub, versione 2.0.0.
- Specifica dei requisiti software secondo IEEE 830-1998.
- Glossario
- ISO/IEC 31000:2018

= Analisi e gestione dei rischi <sezione-2>

Questa sezione descrive l’analisi dei potenziali rischi associati al progetto.
Ogni rischio è stato identificato, analizzato, valutato e sono state definite strategie di gestione e monitoraggio in accordo con lo standard ISO/IEC 31000:2018.
Ogni rischio possiede una probabilità di avvenimento e una di ripercussione, espresse attraverso al seguente scala: Molto bassa, Bassa, Media, Elevata, Molto elevata.

== *RT*

I rischi tecnologici riguardano l'incertezza delle scelte tecniche, l'integrazione dei componenti, la qualità del prodotto e l'affidabilità delle soluzioni adottate.

=== *RT1*

  #tabella-rischio(
    "RT1",
    "Complessità tecnologica e d'integrazione",
    "Scelta e integrazione di raw data store, data warehouse, pipeline ETL, web app, API e layer AI, con possibili incompatibilità tra librerie e dipendenze da servizi esterni.",
    "Elevata",
    "Elevata",
    "Definizione di contratti API e di uno schema condiviso, PoC delle integrazioni, sviluppo incrementale, test di qualità dei dati e di regressione. I template condivisi per documentazione, issue e pull request, insieme a GitHub Project, rendono ripetibile e più veloce il workflow.",
  ) <tab-rischio-rt1>

=== *RT2*

  #tabella-rischio(
    "RT2",
    "Dati incompleti, incoerenti o con schema variabile",
    "Le sorgenti eterogenee possono contenere valori mancanti, formati incompatibili, duplicati o modifiche allo schema, compromettendo trasformazioni, analisi e dashboard.",
    "Media",
    "Elevata",
    "Definizione di un data contract, controlli automatici sulla qualità, dataset sintetico di fallback, versionamento degli schemi e test riproducibili della pipeline.",
  ) <tab-rischio-rt2>

=== *RT3*

  #tabella-rischio(
    "RT3",
    "Risposte AI errate o insight non attendibili",
    "Il layer AI può generare query non corrette, interpretare male le domande o produrre spiegazioni e insight non coerenti con i dati disponibili.",
    "Media",
    "Elevata",
    "Uso di guardrail, domande di riferimento, query in sola lettura, controlli di coerenza, tracciamento delle fonti e test di regressione su casi rappresentativi.",
  ) <tab-rischio-rt3>

=== *RT4*

  #tabella-rischio(
    "RT4",
    "Esposizione di dati aziendali al servizio AI esterno",
    "L'invio di dati o metadati a provider AI esterni può causare esposizione di informazioni sensibili o accessi oltre il perimetro autorizzato.",
    "Media",
    "Molto elevata",
    "Minimizzazione e anonimizzazione dei dati, controllo degli accessi, gestione sicura dei segreti, isolamento delle query, logging degli accessi e valutazione preventiva dei flussi verso provider esterni.",
  ) <tab-rischio-rt4>

=== *RT5*

  #tabella-rischio(
    "RT5",
    "Prestazioni, costi e limiti sui dataset grandi",
    "Dataset ampi, query complesse o richieste frequenti possono causare latenze elevate, consumo eccessivo di risorse, costi imprevisti o superamento dei limiti dei provider.",
    "Media",
    "Elevata",
    "PoC prestazionali, benchmark su dataset rappresentativi, query limitate, caching, paginazione, monitoraggio dei tempi e dei costi e definizione di soglie operative.",
  ) <tab-rischio-rt5>

=== *RT6*

  #tabella-rischio(
    "RT6",
    "Incompatibilità o variazioni delle dipendenze esterne",
    "Librerie, API, provider AI e servizi di supporto possono cambiare comportamento, versione, disponibilità o condizioni d'uso durante lo sviluppo.",
    "Media",
    "Media",
    "Astrazione tramite adapter, versionamento delle dipendenze, mock locali, test di integrazione, monitoraggio delle modifiche e predisposizione di alternative per i servizi critici.",
  ) <tab-rischio-rt6>

== *RO*

I rischi organizzativi riguardano il coordinamento del gruppo, la pianificazione delle attività, la comunicazione, la distribuzione delle responsabilità e la tracciabilità del lavoro.

=== *RO1*

  #tabella-rischio(
    "RO1",
    "Sovrapposizione delle responsabilità e perdita di tracciabilità",
    "Passaggi di consegne incompleti, sovrapposizione delle responsabilità, perdita di tracciabilità e uso non uniforme degli strumenti di progetto.",
    "Media",
    "Media",
    "Assegnazione esplicita dei ruoli, template per verbali e documenti, uso uniforme di GitHub con issue, pull request e Project, e verifica periodica della tracciabilità dei prodotti.",
  ) <tab-rischio-ro1>

=== *RO2*

  #tabella-rischio(
    "RO2",
    "Sottostima delle attività e delle ore necessarie",
    "La complessità del capitolato, l'apprendimento di nuove tecnologie e le attività di integrazione possono richiedere più tempo di quello previsto.",
    "Elevata",
    "Elevata",
    "Scomposizione delle attività in issue più piccole, stime conservative, consuntivo a fine Sprint, ricalcolo a finire, burndown e rinegoziazione tempestiva delle funzionalità opzionali.",
  ) <tab-rischio-ro2>

=== *RO3*

  #tabella-rischio(
    "RO3",
    "Perdita di tracciabilità tra requisiti, codice, test e documentazione",
    "La distribuzione del lavoro tra pipeline dati, backend, web app e AI può rendere difficile mantenere allineati requisiti, implementazione, verifiche e documenti.",
    "Media",
    "Elevata",
    "Issue collegate ai requisiti, pull request con riferimenti alle issue, Project per il controllo dello stato, template di documentazione e Definition of Done con verifica della tracciabilità.",
  ) <tab-rischio-ro3>

== *RP*

I rischi personali riguardano la disponibilità e la continuità dei componenti, la distribuzione delle competenze, la comunicazione e la condivisione delle conoscenze.

=== *RP1*

  #tabella-rischio(
    "RP1",
    "Disponibilità ridotta per lavoro, studio e impegni personali",
    "Impegni lavorativi, universitari, sportivi e personali possono ridurre la disponibilità dei componenti e rallentare le attività assegnate. Il rischio è rilevante anche perché il gruppo comprende tre studenti lavoratori.",
    "Elevata",
    "Elevata",
    "Calendario condiviso, margine temporale, pianificazione anticipata delle assenze e riassegnazione preventiva delle attività. Template, issue, pull request e GitHub Project rendono visibili gli impegni, facilitano i passaggi di consegne e velocizzano la riorganizzazione del lavoro.",
  ) <tab-rischio-rp1>

=== *RP2*

  #tabella-rischio(
    "RP2",
    "Competenze insufficienti o conoscenza concentrata",
    "Le diverse tecnologie del progetto possono richiedere competenze non uniformemente distribuite, creando dipendenza da uno o pochi componenti del gruppo.",
    "Media",
    "Elevata",
    "Pair programming, rotazione dei ruoli, sessioni di formazione, documentazione tramite template, code review e condivisione delle decisioni tecniche nelle issue e nelle pull request.",
  ) <tab-rischio-rp2>

== *RA*

I rischi ambientali riguardano fattori esterni al controllo diretto del gruppo, come disponibilità di dati e servizi, vincoli del calendario, cambiamenti del contesto e dipendenze dalla proponente.

=== *RA1*

  #tabella-rischio(
    "RA1",
    "Indisponibilità o ritardo dei dati della proponente",
    "Il dataset del caso di studio può essere consegnato in ritardo, risultare incompleto o non essere sufficientemente rappresentativo per validare pipeline, warehouse e dashboard.",
    "Media",
    "Elevata",
    "Dataset sintetico di fallback, accordi tempestivi sulle consegne, validazione anticipata del formato, test riproducibili e registrazione delle dipendenze nel GitHub Project.",
  ) <tab-rischio-ra1>

=== *RA2*

  #tabella-rischio(
    "RA2",
    "Indisponibilità di API, provider AI o servizi esterni",
    "Servizi cloud, API di provider AI o sistemi utilizzati per l'acquisizione e l'elaborazione dei dati possono essere temporaneamente indisponibili o soggetti a limiti d'uso.",
    "Media",
    "Elevata",
    "Mock locali, retry controllati, gestione esplicita degli errori, adapter sostituibili, caching e disponibilità di una modalità dimostrativa basata su dati e servizi locali.",
  ) <tab-rischio-ra2>

=== *RA3*

  #tabella-rischio(
    "RA3",
    "Ritardo nei chiarimenti e nelle decisioni sui requisiti",
    "La mancata disponibilità della proponente o il ritardo nelle risposte può lasciare requisiti e criteri di accettazione ambigui, causando rework e ritardi.",
    "Media",
    "Elevata",
    "Incontri SAL calendarizzati, domande raccolte in issue, verbali condivisi, gestione formale delle modifiche e pianificazione di attività a basso rischio durante l'attesa delle decisioni.",
  ) <tab-rischio-ra3>

= Modello di sviluppo

== Lo Standard ISO/IEC/IEEE 12207

Il progetto adotta ISO/IEC/IEEE 12207 come riferimento per organizzare i processi del ciclo di vita del software. Lo standard viene adattato alla dimensione del gruppo e applicato con un modello incrementale: ogni Sprint produce risultati verificabili, aggiorna la documentazione e rende espliciti rischi, decisioni e cambiamenti.

La pianificazione distingue i processi primari, di supporto e organizzativi. Le attività sono tracciate tramite issue, pull request, verbali, documenti di baseline e registrazioni delle ore; la verifica indipendente controlla i prodotti prima del loro consolidamento.

=== I processi primari

- analisi e validazione dei requisiti con la proponente;
- progettazione dell'architettura, della pipeline dati, del data warehouse, delle API e della web app;
- implementazione incrementale delle componenti e del layer AI;
- integrazione, test e verifica dei componenti su dati controllati;
- validazione del PoC e del MVP rispetto ai requisiti e ai criteri di accettazione;
- rilascio dei prodotti di baseline e della documentazione associata.

=== I processi di supporto

- gestione della configurazione, dei branch, delle pull request e delle versioni;
- assicurazione della qualità e verifica indipendente di documenti, codice, dati e risultati;
- gestione dei rischi, delle modifiche, delle non conformità e delle azioni correttive;
- documentazione tecnica e organizzativa, con tracciabilità tra requisiti, attività e verifiche;
- misurazione delle ore, dei costi, dell'avanzamento e della qualità dei prodotti.

=== I processi organizzativi

- pianificazione di lungo e breve termine, con preventivo, calendario e milestone;
- assegnazione e rotazione dei ruoli, coordinamento del gruppo e gestione delle comunicazioni;
- incontri SAL, riesami di Sprint, retrospettive e registrazione delle decisioni;
- miglioramento continuo del way of working sulla base dei consuntivi e degli esiti delle verifiche;
- gestione dei rapporti con docenti committenti e proponente.

== Struttura dello Sprint Agile in conformità con lo Standard ISO/IEC/IEEE 12207

Ogni Sprint inizia con la definizione dell'obiettivo, delle attività, delle responsabilità e dei criteri di completamento. Durante l'esecuzione il gruppo aggiorna issue, ore, rischi e stato dei prodotti, mantenendo il collegamento tra requisiti, codice, documentazione e verifiche.

Al termine dello Sprint si svolgono il riesame dei risultati, il consuntivo delle risorse, l'aggiornamento del burndown e del Gantt, la valutazione dei rischi e la retrospettiva. Le decisioni e le azioni di miglioramento alimentano lo Sprint successivo.

La struttura integra i processi ISO/IEC/IEEE 12207: analisi e progettazione appartengono ai processi primari, verifica e gestione della configurazione a quelli di supporto, mentre pianificazione, coordinamento, riesami e miglioramento continuo appartengono ai processi organizzativi.

// Figura della struttura dello Sprint Agile: da inserire quando sarà disponibile l'immagine.

= Pianificazione nel lungo termine

== Introduzione

Dopo l'esito negativo della prima candidatura, il gruppo ha corretto i template e il processo di verifica, scelto il capitolato C7 e ripresentato la candidatura il 2026-11-06, successivamente aggiudicata. I giorni tra l'aggiudicazione e l'avvio dello Sprint 1, fissato al 2026-11-11, sono stati utilizzati come periodo preliminare per riorganizzare la repository e il sito web in preparazione alla fase RTB.

Il preventivo complessivo è di 540 ore produttive, pari a 90 ore per componente. La ripartizione per ruolo e il costo risultano i seguenti:

#tabellaDati(
  colonne: (2fr, auto, auto, auto),
  intestazioni: ([Ruolo], [Ore totali (h)], [Costo orario (€/h)], [Costo totale (€)]),
  righe: (
    ([Responsabile], [48], [30], [1440]),
    ([Amministratore], [54], [20], [1080]),
    ([Analista], [84], [25], [2100]),
    ([Progettista], [114], [25], [2850]),
    ([Programmatore], [132], [15], [1980]),
    ([Verificatore], [108], [15], [1620]),
    (strong([Totale]), strong([540]), [—], strong([11070])),
  ),
  rigaTotale: 7,
)

Le quantità sono obiettivi di pianificazione e saranno aggiornate tramite i consuntivi degli Sprint. Eventuali variazioni dovranno essere motivate, verificate e registrate senza superare il budget approvato, salvo diversa decisione concordata con i committenti.

== Attività previste per la RTB

La Requirements and Technology Baseline (RTB) costituisce la prima fase operativa del progetto e ha inizio il 2026-11-11, con l'avvio dello Sprint 1. La conclusione è prevista per il 2027-02-03, al termine dello Sprint 5. La data potrà essere aggiornata in base ai consuntivi e agli esiti del PoC, ma la baseline dovrà essere riesaminata prima dell'avvio della Product Baseline.

Le attività previste per la RTB sono riassunte nella seguente tabella:

#tabellaDati(
  colonne: (1.6fr, 3fr),
  intestazioni: ([Attività], [Descrizione]),
  righe: (
    ([Analisi dei requisiti], [Raccolta, formalizzazione e validazione dei requisiti funzionali, non funzionali e di vincolo della SmartDashboard, con definizione delle priorità e dei criteri di accettazione.]),
    ([Piano di progetto], [Definizione della pianificazione, delle risorse, dei costi, dei rischi, delle responsabilità e dei criteri di monitoraggio del progetto.]),
    ([Piano di qualifica], [Definizione delle strategie di verifica e validazione per documenti, pipeline dati, data warehouse, API, dashboard e funzionalità del layer AI.]),
    ([Norme di progetto], [Consolidamento del way of working, delle regole di collaborazione, del flusso GitHub, della gestione delle issue, delle pull request e della verifica dei prodotti.]),
    ([Glossario], [Raccolta e condivisione dei termini relativi a Business Intelligence, ETL, data warehouse, API, dashboard e intelligenza artificiale.]),
    ([Studio delle tecnologie e dell'architettura], [Confronto tra tecnologie e definizione dell'architettura per raw data store, pipeline ETL, data warehouse, web app, API e layer AI.]),
    ([Proof of Concept], [Realizzazione di un prototipo che dimostri la fattibilità delle integrazioni più rischiose e delle scelte tecnologiche principali su dati controllati.]),
    ([Riesame della RTB], [Verifica con il gruppo, i committenti e la proponente della coerenza tra requisiti, architettura, PoC, piano di qualifica e attività previste per la PB.]),
  ),
)

Le attività saranno distribuite tra gli Sprint 1–5. In particolare, gli Sprint iniziali saranno dedicati alla formazione, alla raccolta dei requisiti e al PoC; gli Sprint successivi consolideranno l'architettura, la documentazione e la baseline dei requisiti e delle tecnologie.

== Attività previste per la PB

Al momento non sono disponibili informazioni sufficientemente consistenti per dettagliare in modo definitivo tutte le attività della Product Baseline (PB): la sua pianificazione dipende dall'esito della RTB, dalla validazione del PoC, dai requisiti confermati e dalle decisioni architetturali condivise con Ergon.

Se la RTB si concluderà secondo la tabella di marcia, il preventivo colloca l'avvio della PB nel mese di febbraio 2027 e la conclusione dello sviluppo principale nel mese di marzo 2027. Il mese di aprile 2027 sarà riservato alla finalizzazione, alla verifica conclusiva, alla documentazione e alla consegna, comunque entro il 2027-04-16.

La PB sarà quindi pianificata in modo più dettagliato dopo il riesame della RTB. 

= Pianificazione a breve termine

== Introduzione

[Descrivere il criterio di pianificazione dei singoli Sprint.]

== Requirements and Technology Baseline

[Descrivere la baseline e il collegamento con gli Sprint.]

== Sprint 1

[Descrivere gli obiettivi e le attività dello Sprint 1.]
=== Informazioni generali e attività da svolgere

[Periodo dello Sprint: #sprint-1.data-inizio.day()/#sprint-1.data-inizio.month()/#sprint-1.data-inizio.year() — #sprint-1.data-fine.day()/#sprint-1.data-fine.month()/#sprint-1.data-fine.year().]
[Le attività dello Sprint sono riportate nel Gantt e nelle tabelle generate dai record del TSV.]

==== Diagramma di Gantt
#mostra-gantt(sprint-1)

=== Rischi attesi

[Indicare i rischi tecnologici, economici, organizzativi e relativi alle persone attesi durante lo Sprint, insieme alle probabilità, agli impatti e alle azioni preventive.]

=== Preventivo
#mostra-preventivo(sprint-1)

==== Ore preventivate per ruolo
#mostra-preventivo-ruoli(sprint-1)

=== Aggiornamento delle risorse rimanenti
#mostra-consuntivo(sprint-1)
#mostra-aggiornamento-risorse(sprint-1)

==== Diagramma di Burndown
#mostra-burndown(sprint-1)

=== Efficacia delle strategie di gestione e mitigazione dei rischi

[Valutare l'efficacia delle strategie applicate nello Sprint, indicando i rischi mitigati, quelli ancora aperti e le eventuali azioni correttive.]

=== Migliorie da attuare per le attività future

[Raccogliere le migliorie operative, tecniche e organizzative da applicare agli Sprint successivi.]

=== Retrospettiva

[Registrare cosa ha funzionato, cosa non ha funzionato e quali azioni concrete vengono concordate per il prossimo Sprint.]

== Sprint 2

[Descrivere gli obiettivi e le attività dello Sprint 2.]
=== Informazioni generali e attività da svolgere

[Periodo dello Sprint: #sprint-2.data-inizio.day()/#sprint-2.data-inizio.month()/#sprint-2.data-inizio.year() — #sprint-2.data-fine.day()/#sprint-2.data-fine.month()/#sprint-2.data-fine.year().]
[Le attività dello Sprint sono riportate nel Gantt e nelle tabelle generate dai record del TSV.]

==== Diagramma di Gantt
#mostra-gantt(sprint-2)

=== Rischi attesi

[Indicare i rischi tecnologici, economici, organizzativi e relativi alle persone attesi durante lo Sprint, insieme alle probabilità, agli impatti e alle azioni preventive.]

=== Preventivo
#mostra-preventivo(sprint-2)

==== Ore preventivate per ruolo
#mostra-preventivo-ruoli(sprint-2)

=== Aggiornamento delle risorse rimanenti
#mostra-consuntivo(sprint-2)
#mostra-aggiornamento-risorse(sprint-2)

==== Diagramma di Burndown
#mostra-burndown(sprint-2)

=== Efficacia delle strategie di gestione e mitigazione dei rischi

[Valutare l'efficacia delle strategie applicate nello Sprint, indicando i rischi mitigati, quelli ancora aperti e le eventuali azioni correttive.]

=== Migliorie da attuare per le attività future

[Raccogliere le migliorie operative, tecniche e organizzative da applicare agli Sprint successivi.]

=== Retrospettiva

[Registrare cosa ha funzionato, cosa non ha funzionato e quali azioni concrete vengono concordate per il prossimo Sprint.]

== Sprint 3

[Descrivere gli obiettivi e le attività dello Sprint 3.]
=== Informazioni generali e attività da svolgere

[Periodo dello Sprint: #sprint-3.data-inizio.day()/#sprint-3.data-inizio.month()/#sprint-3.data-inizio.year() — #sprint-3.data-fine.day()/#sprint-3.data-fine.month()/#sprint-3.data-fine.year().]
[Le attività dello Sprint sono riportate nel Gantt e nelle tabelle generate dai record del TSV.]

==== Diagramma di Gantt
#mostra-gantt(sprint-3)

=== Rischi attesi

[Indicare i rischi tecnologici, economici, organizzativi e relativi alle persone attesi durante lo Sprint, insieme alle probabilità, agli impatti e alle azioni preventive.]

=== Preventivo
#mostra-preventivo(sprint-3)

==== Ore preventivate per ruolo
#mostra-preventivo-ruoli(sprint-3)

=== Aggiornamento delle risorse rimanenti
#mostra-consuntivo(sprint-3)
#mostra-aggiornamento-risorse(sprint-3)

==== Diagramma di Burndown
#mostra-burndown(sprint-3)

=== Efficacia delle strategie di gestione e mitigazione dei rischi

[Valutare l'efficacia delle strategie applicate nello Sprint, indicando i rischi mitigati, quelli ancora aperti e le eventuali azioni correttive.]

=== Migliorie da attuare per le attività future

[Raccogliere le migliorie operative, tecniche e organizzative da applicare agli Sprint successivi.]

=== Retrospettiva

[Registrare cosa ha funzionato, cosa non ha funzionato e quali azioni concrete vengono concordate per il prossimo Sprint.]

== Sprint 4

[Descrivere gli obiettivi e le attività dello Sprint 4.]
=== Informazioni generali e attività da svolgere

[Periodo dello Sprint: #sprint-4.data-inizio.day()/#sprint-4.data-inizio.month()/#sprint-4.data-inizio.year() — #sprint-4.data-fine.day()/#sprint-4.data-fine.month()/#sprint-4.data-fine.year().]
[Le attività dello Sprint sono riportate nel Gantt e nelle tabelle generate dai record del TSV.]

==== Diagramma di Gantt
#mostra-gantt(sprint-4)

=== Rischi attesi

[Indicare i rischi tecnologici, economici, organizzativi e relativi alle persone attesi durante lo Sprint, insieme alle probabilità, agli impatti e alle azioni preventive.]

=== Preventivo
#mostra-preventivo(sprint-4)

==== Ore preventivate per ruolo
#mostra-preventivo-ruoli(sprint-4)

=== Aggiornamento delle risorse rimanenti
#mostra-consuntivo(sprint-4)
#mostra-aggiornamento-risorse(sprint-4)

==== Diagramma di Burndown
#mostra-burndown(sprint-4)

=== Efficacia delle strategie di gestione e mitigazione dei rischi

[Valutare l'efficacia delle strategie applicate nello Sprint, indicando i rischi mitigati, quelli ancora aperti e le eventuali azioni correttive.]

=== Migliorie da attuare per le attività future

[Raccogliere le migliorie operative, tecniche e organizzative da applicare agli Sprint successivi.]

=== Retrospettiva

[Registrare cosa ha funzionato, cosa non ha funzionato e quali azioni concrete vengono concordate per il prossimo Sprint.]

== Sprint 5

[Descrivere gli obiettivi e le attività dello Sprint 5.]
=== Informazioni generali e attività da svolgere

[Periodo dello Sprint: #sprint-5.data-inizio.day()/#sprint-5.data-inizio.month()/#sprint-5.data-inizio.year() — #sprint-5.data-fine.day()/#sprint-5.data-fine.month()/#sprint-5.data-fine.year().]
[Le attività dello Sprint sono riportate nel Gantt e nelle tabelle generate dai record del TSV.]

==== Diagramma di Gantt
#mostra-gantt(sprint-5)

=== Rischi attesi

[Indicare i rischi tecnologici, economici, organizzativi e relativi alle persone attesi durante lo Sprint, insieme alle probabilità, agli impatti e alle azioni preventive.]

=== Preventivo
#mostra-preventivo(sprint-5)

==== Ore preventivate per ruolo
#mostra-preventivo-ruoli(sprint-5)

=== Aggiornamento delle risorse rimanenti
#mostra-consuntivo(sprint-5)
#mostra-aggiornamento-risorse(sprint-5)

==== Diagramma di Burndown
#mostra-burndown(sprint-5)

=== Efficacia delle strategie di gestione e mitigazione dei rischi

[Valutare l'efficacia delle strategie applicate nello Sprint, indicando i rischi mitigati, quelli ancora aperti e le eventuali azioni correttive.]

=== Migliorie da attuare per le attività future

[Raccogliere le migliorie operative, tecniche e organizzative da applicare agli Sprint successivi.]

=== Retrospettiva

[Registrare cosa ha funzionato, cosa non ha funzionato e quali azioni concrete vengono concordate per il prossimo Sprint.]
