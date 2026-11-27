#import "/docs/5_Templates/documento.typ": *
#import "Diagrammi_e_rendiconto_ore_costi.typ": *

#import "../../Documenti_interni/Glossario.typ": termini

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

// Schema delle matrici preventive: righe = componenti, colonne = ruoli.
// | Componente         | Responsabile | Amministratore | Analista | Progettista | Programmatore | Verificatore |
// | Bruno Grimaldi     | ore          | ore            | ore      | ore         | ore           | ore          |
// | Elico Huang        | ore          | ore            | ore      | ore         | ore           | ore          |
// | Mattia Milan       | ore          | ore            | ore      | ore         | ore           | ore          |
// | Margherita Monaco  | ore          | ore            | ore      | ore         | ore           | ore          |
// | Riccardo Pontello  | ore          | ore            | ore      | ore         | ore           | ore          |
// | Lorenca Shiroka    | ore          | ore            | ore      | ore         | ore           | ore          |
#let ore-preventivate-componenti-sprint-1 = (
  (0, 0, 4, 0, 0, 1),
  (0, 2, 2, 0, 0, 1),
  (0, 0, 4, 0, 0, 1),
  (0, 2, 2, 0, 0, 1),
  (4, 0, 2, 0, 0, 0),
  (0, 2, 0, 0, 0, 1),
)
#let ore-preventivate-sprint-1 = ore-per-ruolo-da-componenti(ore-preventivate-componenti-sprint-1)
#let ore-preventivate-componenti-sprint-2 = (
  (0, 0, 0, 0, 0, 0),
  (0, 0, 0, 0, 0, 0),
  (0, 0, 0, 0, 0, 0),
  (0, 0, 0, 0, 0, 0),
  (0, 0, 0, 0, 0, 0),
  (0, 0, 0, 0, 0, 0),
)
#let ore-preventivate-sprint-2 = ore-per-ruolo-da-componenti(ore-preventivate-componenti-sprint-2)
#let ore-preventivate-componenti-sprint-3 = (
  (0, 0, 0, 0, 0, 0),
  (0, 0, 0, 0, 0, 0),
  (0, 0, 0, 0, 0, 0),
  (0, 0, 0, 0, 0, 0),
  (0, 0, 0, 0, 0, 0),
  (0, 0, 0, 0, 0, 0),
)
#let ore-preventivate-sprint-3 = ore-per-ruolo-da-componenti(ore-preventivate-componenti-sprint-3)
#let ore-preventivate-componenti-sprint-4 = (
  (0, 0, 0, 0, 0, 0),
  (0, 0, 0, 0, 0, 0),
  (0, 0, 0, 0, 0, 0),
  (0, 0, 0, 0, 0, 0),
  (0, 0, 0, 0, 0, 0),
  (0, 0, 0, 0, 0, 0),
)
#let ore-preventivate-sprint-4 = ore-per-ruolo-da-componenti(ore-preventivate-componenti-sprint-4)
#let ore-preventivate-componenti-sprint-5 = (
  (0, 0, 0, 0, 0, 0),
  (0, 0, 0, 0, 0, 0),
  (0, 0, 0, 0, 0, 0),
  (0, 0, 0, 0, 0, 0),
  (0, 0, 0, 0, 0, 0),
  (0, 0, 0, 0, 0, 0),
)
#let ore-preventivate-sprint-5 = ore-per-ruolo-da-componenti(ore-preventivate-componenti-sprint-5)

#show: documento.with(
  titolo: "Piano di progetto",
  mostraRegistro: true,
  versione: "0.2.4",
  stato: "Da redigere",
  redazione: (RP),
  verifica: (EH, MMI),
  uso: "Esterno",
  destinatari: (
    "Prof. Vardanega Tullio",
    "Prof. Cardin Riccardo",
    "Ergon Informatica S.r.l.",
  ),
  registroModifiche: (
    ("0.2.4", "2026-11-27", "Aggiornamento informazioni Sprint 1", RP, MMI),
    ("0.2.3", "2026-11-25", "Aggiornamento template e aggiunta termini presenti nel Glossario", RP, EH),
    ("0.2.2", "2026-11-20", "Prima stesura sezione 5 e sprint 1", RP, EH),
    ("0.2.1", "2026-11-19", "Prima stesura dei rischi specifici e sezione 4", RP, EH),
    ("0.2.0", "2026-11-18", "Prima stesura sezioni 1, 2 e 3", RP, EH),
    ("0.1.1", "2026-11-17", "Miglioramento template, diagramma di Gantt e Burndown", RP, EH),
    ("0.1.0", "2026-11-16", "Creazione della struttura iniziale", RP, EH),
  ),
  indice: true,
  glossario: termini,
  tabelle: true,
  immagini: true,
)

= Introduzione

Il presente @piano-di-progetto descrive la @pianificazione, l'organizzazione e il controllo delle attività del gruppo ByteClub per la realizzazione del @capitolato C7 - SmartDashboard, proposto da Ergon Informatica S.r.l. Il documento è redatto nel contesto del @progetto didattico di Ingegneria del Software dell'Università degli Studi di Padova e aggiorna progressivamente obiettivi, risorse, rischi, scadenze e risultati.

Il @progetto prevede la realizzazione incrementale di una piattaforma per l'acquisizione, la trasformazione e l'analisi di dati aziendali. La @pianificazione è articolata nei periodi @rtb e @pb, a loro volta suddivisi in @sprint verificabili.

== Scopo del documento

Il @piano-di-progetto definisce:

- obiettivi, attività e risultati attesi per ciascuno @sprint;
- ruoli, responsabilità, modalità di collaborazione e criteri di @verifica;
- stima delle ore e dei costi, con aggiornamento tramite preventivi e consuntivi;
- rischi tecnologici, organizzativi, economici e relativi alle persone, con le rispettive strategie di mitigazione;
- calendario, @milestone, criteri di avanzamento e modalità di gestione delle modifiche.

Il documento è destinato al gruppo ByteClub, ai docenti @committente:pl del @progetto didattico e alla @proponente Ergon Informatica S.r.l. Le informazioni sono mantenute tracciabili nei verbali, nel @repository e negli strumenti di gestione delle @issue.

== Scopo del prodotto

Il prodotto previsto dal @capitolato C7 è una SmartDashboard che consente di acquisire dati da sorgenti eterogenee, conservarli in un raw data store, trasformarli in un data warehouse e presentarli tramite una web app con @dashboard e @api. Il sistema comprende inoltre un layer di @intelligenza-artificiale per supportare l'interrogazione e l'interpretazione dei dati, nel rispetto dei vincoli di sicurezza e tracciabilità.

Gli obiettivi progettuali sono:

- fornire una pipeline dati riproducibile e verificabile;
- rendere consultabili indicatori e visualizzazioni tramite interfacce web;
- integrare le componenti mediante contratti @api documentati;
- validare tecnologie, prestazioni, qualità dei dati e risposte del layer AI attraverso un @poc e successive evoluzioni incrementali;
- consegnare un @mvp verificato, documentato e coerente con i requisiti concordati con la @proponente.

== @glossario, acronimi e convenzioni

Per evitare equivoci nella terminologia utilizzata, gli acronimi e i termini tecnici del documento sono raccolti nel @glossario, documento separato che riporta per ciascuna voce il termine, l'eventuale contesto di utilizzo e la relativa definizione.

La presenza di una voce nel @glossario è indicata nel testo con una "G" in apice, ad esempio: Esempio#super[G].

Dalla #underline(link(<sezione-2>)[sezione 2]), per facilitare l'identificazione dei rischi, verrà introdotta una convenzione di formato che sà usata per tutto il documento: R[Tipo][Indice].
Il Tipo rappresenta la categoria di rischio, che può essere:
- T: Tecnologico;
- O: Organizzativo;
- P: Personale;
- A: Ambientale;
L'Indice è incrementale e identifica univocamente ogni rischio all'interno di un Tipo.

== Riferimenti

=== Riferimenti normativi

- Regolamento del @progetto didattico di Ingegneria del Software, anno accademico 2026/2027.
- @capitolato C7 - SmartDashboard e documentazione tecnica di Ergon Informatica S.r.l. #footnote[#link("https://www.math.unipd.it/~tullio/IS-1/2026/Progetto/C7-SD.pdf")[Documentazione del @capitolato C7]]
- Standard ISO/IEC/@ieee 12207, usato come riferimento per i @processo:pl del ciclo di vita del software.
- @norme-di-progetto del gruppo ByteClub, per ruoli, comunicazione, @versionamento, @verifica e gestione delle modifiche.

=== Riferimenti informativi

- Dichiarazione degli impegni e preventivo dei costi del gruppo ByteClub, versione 2.0.0.
- Specifica dei requisiti software secondo @ieee 830-1998.
- @glossario
- ISO/IEC 31000:2018

= Analisi e gestione dei rischi <sezione-2>

Questa sezione descrive l’analisi dei potenziali rischi associati al @progetto.
Ogni rischio è stato identificato, analizzato, valutato e sono state definite strategie di gestione e monitoraggio in accordo con lo standard ISO/IEC 31000:2018.
Ogni rischio possiede una probabilità di avvenimento e una di ripercussione, espresse attraverso al seguente scala: Molto bassa, Bassa, Media, Elevata, Molto elevata.

== RT

I rischi tecnologici riguardano l'incertezza delle scelte tecniche, l'integrazione dei componenti, la qualità del prodotto e l'affidabilità delle soluzioni adottate.

=== RT1

  #tabella-rischio(
    "RT1",
    "Complessità tecnologica e d'integrazione",
    [Scelta e integrazione di raw data store, data warehouse, pipeline ETL, web app, @api e layer @ia, con possibili incompatibilità tra librerie e dipendenze da servizi esterni.],
    "Elevata",
    "Elevata",
    [Definizione di contratti @api e di uno schema condiviso, @poc delle integrazioni, @sviluppo incrementale, @test di qualità dei dati e di regressione. I template condivisi per documentazione, @issue e @pull-request, insieme a @github Project, rendono ripetibile e più veloce il workflow.],
  ) <tab-rischio-rt1>

=== RT2

  #tabella-rischio(
    "RT2",
    "Dati incompleti, incoerenti o con schema variabile",
    [Le sorgenti eterogenee possono contenere valori mancanti, formati incompatibili, duplicati o modifiche allo schema, compromettendo trasformazioni, analisi e @dashboard.],
    "Media",
    "Elevata",
    [Definizione di un data contract, controlli automatici sulla qualità, dataset sintetico di fallback, @versionamento degli schemi e @test riproducibili della pipeline.],
  ) <tab-rischio-rt2>

=== RT3

  #tabella-rischio(
    "RT3",
    "Risposte AI errate o insight non attendibili",
    [Il layer @ia può generare @query non corrette, interpretare male le domande o produrre spiegazioni e insight non coerenti con i dati disponibili.],
    "Media",
    "Elevata",
    [Uso di guardrail, domande di riferimento, @query in sola lettura, controlli di coerenza, tracciamento delle fonti e @test di regressione su casi rappresentativi.],
  ) <tab-rischio-rt3>

=== RT4

  #tabella-rischio(
    "RT4",
    "Esposizione di dati aziendali al servizio AI esterno",
    [L'invio di dati o metadati a provider @ia esterni può causare esposizione di informazioni sensibili o accessi oltre il perimetro autorizzato.],
    "Media",
    "Molto elevata",
    "Minimizzazione e anonimizzazione dei dati, controllo degli accessi, gestione sicura dei segreti, isolamento delle query, logging degli accessi e valutazione preventiva dei flussi verso provider esterni.",
  ) <tab-rischio-rt4>

=== RT5

  #tabella-rischio(
    "RT5",
    "Prestazioni, costi e limiti sui dataset grandi",
    [Dataset ampi, @query complesse o richieste frequenti possono causare latenze elevate, consumo eccessivo di risorse, costi imprevisti o superamento dei limiti dei provider.],
    "Media",
    "Elevata",
    [@poc prestazionali, benchmark su dataset rappresentativi, @query limitate, caching, paginazione, monitoraggio dei tempi e dei costi e definizione di soglie operative.],
  ) <tab-rischio-rt5>

=== RT6

  #tabella-rischio(
    "RT6",
    "Incompatibilità o variazioni delle dipendenze esterne",
    [Librerie, @api, provider @ia e servizi di supporto possono cambiare comportamento, versione, disponibilità o condizioni d'uso durante lo @sviluppo.],
    "Media",
    "Media",
    [Astrazione tramite adapter, @versionamento delle dipendenze, mock locali, @test di integrazione, monitoraggio delle modifiche e predisposizione di alternative per i servizi critici.],
  ) <tab-rischio-rt6>

== RO

I rischi organizzativi riguardano il coordinamento del gruppo, la @pianificazione delle attività, la comunicazione, la distribuzione delle responsabilità e la tracciabilità del lavoro.

=== RO1

  #tabella-rischio(
    "RO1",
    "Sovrapposizione delle responsabilità e perdita di tracciabilità",
    "Passaggi di consegne incompleti, sovrapposizione delle responsabilità, perdita di tracciabilità e uso non uniforme degli strumenti di progetto.",
    "Media",
    "Media",
    [Assegnazione esplicita dei ruoli, template per verbali e documenti, uso uniforme di @github con @issue, @pull-request e Project, e @verifica periodica della tracciabilità dei prodotti.],
  ) <tab-rischio-ro1>

=== RO2

  #tabella-rischio(
    "RO2",
    "Sottostima delle attività e delle ore necessarie",
    [La complessità del @capitolato, l'apprendimento di nuove tecnologie e le attività di integrazione possono richiedere più tempo di quello previsto.],
    "Elevata",
    "Elevata",
    [Scomposizione delle attività in @issue più piccole, stime conservative, consuntivo a fine @sprint, ricalcolo a finire, burndown e rinegoziazione tempestiva delle @funzionalita:pl opzionali.],
  ) <tab-rischio-ro2>

=== RO3

  #tabella-rischio(
    "RO3",
    [Perdita di tracciabilità tra requisiti, codice, @test e documentazione],
    "La distribuzione del lavoro tra pipeline dati, backend, web app e AI può rendere difficile mantenere allineati requisiti, implementazione, verifiche e documenti.",
    "Media",
    "Elevata",
    [@issue collegate ai requisiti, @pull-request con riferimenti alle @issue, Project per il controllo dello stato, template di documentazione e Definition of Done con @verifica della tracciabilità.],
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
    [Calendario condiviso, margine temporale, @pianificazione anticipata delle assenze e riassegnazione preventiva delle attività. Template, @issue, @pull-request e @github Project rendono visibili gli impegni, facilitano i passaggi di consegne e velocizzano la riorganizzazione del lavoro.],
  ) <tab-rischio-rp1>

=== RP2

  #tabella-rischio(
    "RP2",
    "Competenze insufficienti o conoscenza concentrata",
    "Le diverse tecnologie del progetto possono richiedere competenze non uniformemente distribuite, creando dipendenza da uno o pochi componenti del gruppo.",
    "Media",
    "Elevata",
    [Pair programming, rotazione dei ruoli, sessioni di formazione, documentazione tramite template, code review e condivisione delle @decisione:pl tecniche nelle @issue e nelle @pull-request.],
  ) <tab-rischio-rp2>

== RA

I rischi ambientali riguardano fattori esterni al controllo diretto del gruppo, come disponibilità di dati e servizi, vincoli del calendario, cambiamenti del contesto e dipendenze dalla @proponente.

=== RA1

  #tabella-rischio(
    "RA1",
    [Indisponibilità o ritardo dei dati della @proponente],
    [Il dataset del caso di studio può essere consegnato in ritardo, risultare incompleto o non essere sufficientemente rappresentativo per validare pipeline, warehouse e @dashboard.],
    "Media",
    "Elevata",
    [Dataset sintetico di fallback, accordi tempestivi sulle consegne, @validazione anticipata del formato, @test riproducibili e registrazione delle dipendenze nel @github Project.],
  ) <tab-rischio-ra1>

=== RA2

  #tabella-rischio(
    "RA2",
    [Indisponibilità di @api, provider @ia o servizi esterni],
    [Servizi cloud, @api di provider @ia o sistemi utilizzati per l'acquisizione e l'elaborazione dei dati possono essere temporaneamente indisponibili o soggetti a limiti d'uso.],
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
    [Incontri SAL calendarizzati, domande raccolte in @issue, verbali condivisi, gestione formale delle modifiche e @pianificazione di attività a basso rischio durante l'attesa delle @decisione:pl.],
  ) <tab-rischio-ra3>

= Modello di @sviluppo

== Lo Standard ISO/IEC/@ieee 12207

Il @progetto adotta ISO/IEC/@ieee 12207 come riferimento per organizzare i @processo del ciclo di vita del software. Lo standard viene adattato alla dimensione del gruppo e applicato con un modello incrementale: ogni @sprint produce risultati verificabili, aggiorna la documentazione e rende espliciti rischi, @decisione e cambiamenti.

La @pianificazione distingue i @processo:pl primari, di supporto e organizzativi. Le attività sono tracciate tramite @issue, @pull-request, verbali, documenti di baseline e registrazioni delle ore; la @verifica indipendente controlla i prodotti prima del loro consolidamento.

=== I @processo:pl primari

- analisi e @validazione dei requisiti con la @proponente;
- @progettazione dell'architettura, della pipeline dati, del data warehouse, delle @api e della web app;
- implementazione incrementale delle componenti e del layer @ia;
- integrazione, @test e @verifica dei componenti su dati controllati;
- @validazione del @poc e del @mvp rispetto ai requisiti e ai criteri di accettazione;
- rilascio dei prodotti di baseline e della documentazione associata.

=== I @processo:pl di supporto

- gestione della configurazione, dei branch, delle @pull-request e delle versioni;
- assicurazione della qualità e @verifica indipendente di documenti, codice, dati e risultati;
- gestione dei rischi, delle modifiche, delle non conformità e delle @azione:pl correttive;
- documentazione tecnica e organizzativa, con tracciabilità tra requisiti, attività e verifiche;
- misurazione delle ore, dei costi, dell'avanzamento e della qualità dei prodotti.

=== I @processo:pl organizzativi

- @pianificazione di lungo e breve termine, con preventivo, calendario e @milestone;
- assegnazione e rotazione dei ruoli, coordinamento del gruppo e gestione delle comunicazioni;
- incontri SAL, riesami di @sprint, retrospettive e registrazione delle @decisione:pl;
- miglioramento continuo del @way-of-working sulla base dei consuntivi e degli esiti delle verifiche;
- gestione dei rapporti con docenti @committente e @proponente.

== Struttura dello @sprint @agile in conformità con lo Standard ISO/IEC/@ieee 12207

Ogni @sprint inizia con la definizione dell'obiettivo, delle attività, delle responsabilità e dei criteri di completamento. Durante l'esecuzione il gruppo aggiorna @issue, ore, rischi e stato dei prodotti, mantenendo il collegamento tra requisiti, codice, documentazione e verifiche.

Al termine dello @sprint si svolgono il riesame dei risultati, il consuntivo delle risorse, l'aggiornamento del burndown e del Gantt, la valutazione dei rischi e la retrospettiva. Le @decisione:pl e le @azione:pl di miglioramento alimentano lo @sprint successivo.

La struttura integra i @processo:pl ISO/IEC/@ieee 12207: analisi e @progettazione appartengono ai @processo:pl primari, @verifica e gestione della configurazione a quelli di supporto, mentre @pianificazione, coordinamento, riesami e miglioramento continuo appartengono ai @processo:pl organizzativi.

// Figura della struttura dello Sprint Agile: da inserire quando sarà disponibile l'immagine.

= @pianificazione nel lungo termine

== Introduzione

Dopo l'esito negativo della prima candidatura, il gruppo ha corretto i template e il @processo di @verifica, scelto il @capitolato C7 e ripresentato la candidatura il 2026-11-06, successivamente aggiudicata. I giorni tra l'aggiudicazione e l'avvio dello @sprint 1, fissato al 2026-11-11, sono stati utilizzati come periodo preliminare per riorganizzare la @repository e il sito web in preparazione alla fase @rtb.

Il preventivo complessivo è di 540 ore produttive, pari a 90 ore per componente. La ripartizione per ruolo e il costo risultano i seguenti:

#tabellaDati(
  colonne: (2fr, auto, auto, auto),
  intestazioni: ([Ruolo], [Ore totali (h)], [Costo orario (€/h)], [Costo totale (€)]),
  righe: (
    ([@responsabile], [48], [30], [1440]),
    ([@amministratore], [54], [20], [1080]),
    ([@analista], [84], [25], [2100]),
    ([@progettista], [114], [25], [2850]),
    ([@programmatore], [132], [15], [1980]),
    ([@verificatore], [108], [15], [1620]),
    (strong([Totale]), strong([540]), [—], strong([11070])),
  ),
  rigaTotale: 7,
)

Le quantità sono obiettivi di @pianificazione e saranno aggiornate tramite i consuntivi degli @sprint. Eventuali variazioni dovranno essere motivate, verificate e registrate senza superare il budget approvato, salvo diversa @decisione concordata con i @committente.

== Attività previste per la @rtb

La Requirements and Technology Baseline (@rtb) costituisce la prima fase operativa del @progetto e ha inizio il 2026-11-11, con l'avvio dello @sprint 1. La conclusione è prevista per il 2027-02-03, al termine dello @sprint 5. La data potrà essere aggiornata in base ai consuntivi e agli esiti del @poc, ma la baseline dovrà essere riesaminata prima dell'avvio della @product-baseline.

Le attività previste per la @rtb sono riassunte nella seguente tabella:

#tabellaDati(
  colonne: (1.6fr, 3fr),
  intestazioni: ([Attività], [Descrizione]),
  righe: (
    ([@analisi-dei-requisiti], [Raccolta, formalizzazione e @validazione dei @requisito-funzionale:pl, @requisito-non-funzionale:pl e @requisito-di-vincolo:pl della SmartDashboard, con definizione delle priorità e dei criteri di accettazione.]),
    ([@piano-di-progetto], [Definizione della @pianificazione, delle risorse, dei costi, dei rischi, delle responsabilità e dei criteri di monitoraggio del @progetto.]),
    ([@piano-di-qualifica], [Definizione delle strategie di @verifica e @validazione per documenti, pipeline dati, data warehouse, @api, @dashboard e @funzionalita:pl del layer AI.]),
    ([@norme-di-progetto], [Consolidamento del @way-of-working, delle regole di collaborazione, del flusso @github, della gestione delle @issue:pl, delle @pull-request:pl e della @verifica dei prodotti.]),
    ([@glossario], [Raccolta e condivisione dei termini relativi a Business Intelligence, ETL, data warehouse, @api, @dashboard e @intelligenza-artificiale.]),
    ([Studio delle tecnologie e dell'architettura], [Confronto tra tecnologie e definizione dell'architettura per raw data store, pipeline ETL, data warehouse, web app, @api e layer @ia.]),
    ([@proof-of-concept], [Realizzazione di un prototipo che dimostri la fattibilità delle integrazioni più rischiose e delle scelte tecnologiche principali su dati controllati.]),
    ([Riesame della @rtb], [@verifica con il gruppo, i @committente:pl e la @proponente della coerenza tra requisiti, architettura, @poc, @piano-di-qualifica e attività previste per la @pb.]),
  ),
)

Le attività saranno distribuite tra gli @sprint 1–5. In particolare, gli @sprint iniziali saranno dedicati alla formazione, alla raccolta dei requisiti e al @poc; gli @sprint successivi consolideranno l'architettura, la documentazione e la baseline dei requisiti e delle tecnologie.

== Attività previste per la @pb

Al momento non sono disponibili informazioni sufficientemente consistenti per dettagliare in modo definitivo tutte le attività della @product-baseline (@pb): la sua @pianificazione dipende dall'esito della @rtb, dalla @validazione del @poc, dai requisiti confermati e dalle @decisione architetturali condivise con Ergon.

Se la @rtb si concluderà secondo la tabella di marcia, il preventivo colloca l'avvio della @pb nel mese di febbraio 2027 e la conclusione dello @sviluppo principale nel mese di marzo 2027. Il mese di aprile 2027 sarà riservato alla finalizzazione, alla @verifica conclusiva, alla documentazione e alla consegna, comunque entro il 2027-04-16.

La @pb sarà quindi pianificata in modo più dettagliato dopo il riesame della @rtb.

= @pianificazione a breve termine

== Introduzione

La @pianificazione del gruppo si articola in @sprint di due settimane. All'avvio di ogni @sprint vengono fissati obiettivo, attività, ruoli, ore preventivate, criteri di completamento e rischi attesi; durante l'esecuzione vengono aggiornati @issue, ore e stato dei prodotti. Al termine si confrontano preventivo e consuntivo, si aggiornano le risorse rimanenti e si registrano rischi, @azione:pl correttive e @decisione della retrospettiva. La @pianificazione può essere ricalibrata sulla base dei consuntivi o di nuove indicazioni della @proponente, mantenendo tracciabilità nel @repository e nei verbali.

#pagebreak()
== Requirements and Technology Baseline

=== *@sprint 1*

==== Informazioni generali e attività da svolgere
#mostra-informazioni-sprint(sprint-1, [Questo primo periodo ha una durata di 17 giorni invece di due settimane, per permettere al gruppo di allineare i template al periodo della @rtb e avere il tempo necessario per testare e studiare le tecnologie proposte dall'azienda.
Le attività da svolgere, definite nei verbali interni ed esterni, sono:
- Aggiornare la @repository con le cartelle @rtb e @poc.
- Creare le @milestone e le relative @issue, assegnandole.
- Aggiornare il workflow di compilazione automatica dei documenti.
- Allineare la vista web alla @milestone corrente.
- Redigere e aggiornare l'@analisi-dei-requisiti.
- Redigere le bozze delle @norme-di-progetto, del @piano-di-progetto e del @piano-di-qualifica.
- Redigere il @glossario.
- Configurare un @database relazionale con dati CSV tramite Python ed eseguire @test sulle chiavi @api tramite FastAPI.
- Organizzare gli incontri periodici di SAL e proporre date per un incontro in presenza con l'azienda.
- Studiare Tailwind CSS, valutarne le alternative e testarne la tecnologia.
- Consultare le fonti ufficiali delle tecnologie.
])
==== Attività svolte
#mostra-burndown(sprint-1)
#mostra-gantt(sprint-1)
#pagebreak()

==== Preventivo ore
#mostra-tabella-preventivo-ruoli(ore-preventivate-componenti-sprint-1)
#mostra-preventivo-ruoli(sprint-1, ore-preventivate: ore-preventivate-sprint-1)
Le ore produttive rappresentano circa il 30% dell'impegno complessivo; il restante 70% è stato dedicato alla creazione dei template e allo studio delle tecnologie, con meno tempo riservato alla stesura dei documenti. Il preventivo iniziale di Lorenca Shiroka è stato contenuto in considerazione dei suoi impegni sportivi.
#pagebreak()
==== Consuntivo ore
#mostra-tabella-consuntivo-ruoli(sprint-1)
#mostra-consuntivo-ruoli(sprint-1)

Il consuntivo ha richiesto una riorganizzazione delle ore a causa di diversi imprevisti. Il ritardo nella consegna del dataset da parte di Ergon ha spostato alla seconda settimana dello @sprint le @issue che dipendevano dai dati. Le incompatibilità riscontrate nei dataset hanno rallentato le attività e riorgainzzando le ore da @amministratore a Margherita Monaco; gli esempi pratici forniti da Ergon sui @database da realizzare le hanno invece agevolato lo studio delle nuove tecnologie facendole risparmiare un'ora.

È stato sottostimato il rischio tecnologico legato ai template documentali: l'automazione del @glossario ha richiesto a Bruno Grimaldi un'ora aggiuntiva, togliendola dal ruolo di @verificatore, per studiare e integrare il pacchetto `glossy:0.9.2` di @typst. Il @glossario ha inoltre generato errori nel workflow: Elico Huang ha dovuto occuparsene, con conseguente riorganizzazione delle sue ore da @analista; a Riccardo Pontello è stata aggiunta un'ora per supportarlo nella correzione dei bug. Infine, la disponibilità di Lorenca Shiroka si è rivelata superiore alle previsioni, consentendo di assegnarle due ore aggiuntive per la @verifica dei documenti.

#pagebreak()
==== Aggiornamento delle risorse rimanenti
#mostra-aggiornamento-risorse(sprint-1, ore-preventivate: ore-preventivate-sprint-1)

#pagebreak()
==== Rischi attesi
- *#underline(link(<tab-rischio-rt1>)[RT1]):* complessità dell'integrazione tra le tecnologie candidate;
- *#underline(link(<tab-rischio-ro2>)[RO2]):* sottostima delle attività di avvio, @issue e raccolta requisiti;
- *#underline(link(<tab-rischio-rp1>)[RP1]):* disponibilità ridotta dei componenti;

==== Rischi incontrati
Sono stati incontrati tutti i rischi precedentemenete citati e inoltre anche i seguenti rischi:
- *#underline(link(<tab-rischio-ra1>)[RA1]):* indisponibilità o ritardo dei dati della @proponente
- *#underline(link(<tab-rischio-rt1>)[RT2]):* dati incompleti o con schema variabile;
- *#underline(link(<tab-rischio-rt1>)[RO3]):* perdita di tracciabilità tra requisiti, codice, @test e documentazione
- *#underline(link(<tab-rischio-rp2>)[RP2]):* competenze insufficienti o conoscenza concentrata

Come previsto, RT1 è stato causato dalle difficoltà incontrate nella realizzazione dei template in @typst, RO2 dalla limitata esperienza del gruppo e RP1 dagli impegni già assunti dai componenti. Sono invece emersi RA1, dovuto al ritardo di Ergon nella consegna del dataset; RT2, legato alle incompatibilità presenti in alcuni dati; RO3, causato dal numero inizialmente ridotto di @issue e dalla mancata gestione delle priorità; e RP2, dovuto alla competenza insufficiente del gruppo nell'uso di @typst e @github.

==== @efficacia delle strategie di gestione e mitigazione dei rischi
RT1, RO2 e RP1 sono stati mitigati in fase di @pianificazione riorganizzando le ore, dando più spazio ai ruoli di @amministratore e @analista e mantenendo per Lorenca un carico di lavoro inferiore; RA1 e RT2 sono stati mitigati grazie al canale @whatsapp, che ha permesso al gruppo di aggiornarsi tempestivamente con l'azienda e di conseguenza riorganizzare le attività in base alla situazione dei dati; RO3 è stato mitigato in parte introducendo la gestione delle priorità e creando @issue più specifiche; RP2 è stato mitigato tramite lo studio individuale e il supporto reciproco per colmare le lacune di competenza.

==== Migliorie da attuare per le attività future
Nei prossimi @sprint verrà adottato un nuovo metodo di @pianificazione. Dopo aver scelto il @responsabile e un @amministratore, il gruppo definirà le attività da svolgere nel corso dello @sprint e preparerà tutte le @issue in un'unica sessione. Per ciascuna @issue verranno indicati la priorità, la Definition of Done nella descrizione e il ruolo incaricato del completamento. Alle @issue con ore da conteggiare verrà assegnata l'etichetta "Ore produttive"; il tempo di completamento sarà stimato con la formula ((OraMin + 4 × OraMedia + OraMax) / 6). Il risultato sarà indicativo e potrà essere arrotondato in base alle esigenze di pianificazione. Infine, i ruoli saranno assegnati agli altri componenti in base a quelli richiesti dalle @issue, si cercherà di distribuire equamente il carico di lavoro tra tutti tenendo conto dei rischi di RP1.

==== Retrospettiva
Registrare cosa ha funzionato, cosa non ha funzionato e le @azione:pl concrete concordate per lo @sprint successivo.

#pagebreak()
=== *@sprint:cap 2*

==== Informazioni generali e attività da svolgere
#mostra-informazioni-sprint(sprint-2, [Completamento della raccolta requisiti e @validazione delle prime integrazioni tecnologiche.])
- Consolidare requisiti, vincoli e criteri di accettazione.
- Eseguire il @poc sulle integrazioni a rischio.
- Aggiornare @piano-di-qualifica, @glossario e documentazione tecnica.

==== Attività svolte
#mostra-burndown(sprint-2)
#mostra-gantt(sprint-2)

==== Preventivo ore
#mostra-tabella-preventivo-ruoli(ore-preventivate-componenti-sprint-2)
#mostra-preventivo-ruoli(sprint-2, ore-preventivate: ore-preventivate-sprint-2)

#pagebreak()
==== Consuntivo ore
#mostra-tabella-consuntivo-ruoli(sprint-2)
#mostra-consuntivo-ruoli(sprint-2)

#pagebreak()
==== Aggiornamento delle risorse rimanenti
#mostra-aggiornamento-risorse(sprint-2, ore-preventivate: ore-preventivate-sprint-2)

#pagebreak()
==== Rischi attesi
- *RT2:* dati incompleti o con schema variabile; probabilità media, impatto elevato; usare dataset sintetici e controlli automatici di qualità.
- *RA2:* indisponibilità di @api o servizi esterni; probabilità media, impatto elevato; predisporre mock locali e adapter sostituibili.

==== Rischi incontrati
- *RO1:* rischio da compilare a consuntivo con riferimento alla tracciabilità tra requisiti, @issue e prodotti.

==== @efficacia:cap delle strategie di gestione e mitigazione dei rischi
La valutazione viene compilata al termine dello Sprint.

==== Migliorie da attuare per le attività future
Registrare le migliorie emerse nel riesame dello @sprint.

==== Retrospettiva
Registrare risultati, problemi e @azione:pl per lo @sprint successivo.

#pagebreak()
=== *@sprint:cap 3*

==== Informazioni generali e attività da svolgere
#mostra-informazioni-sprint(sprint-3, [Definizione dell'architettura e consolidamento della Requirements and Technology Baseline (@rtb).])
- Definire l'architettura della pipeline dati, del data warehouse e della web app.
- Documentare interfacce, flussi dati e @decisione:pl tecnologiche.
- Riesaminare requisiti, rischi e risultati del @poc con la @proponente.

==== Attività svolte
#mostra-burndown(sprint-3)
#mostra-gantt(sprint-3)

==== Preventivo ore
#mostra-tabella-preventivo-ruoli(ore-preventivate-componenti-sprint-3)
#mostra-preventivo-ruoli(sprint-3, ore-preventivate: ore-preventivate-sprint-3)

#pagebreak()
==== Consuntivo ore
#mostra-tabella-consuntivo-ruoli(sprint-3)
#mostra-consuntivo-ruoli(sprint-3)

#pagebreak()
==== Aggiornamento delle risorse rimanenti
#mostra-aggiornamento-risorse(sprint-3, ore-preventivate: ore-preventivate-sprint-3)

#pagebreak()
==== Rischi attesi
- *RT3:* risposte @ia non attendibili; probabilità media, impatto elevato; definire guardrail e @test di regressione.
- *RO3:* perdita di tracciabilità tra requisiti, architettura e verifiche; probabilità media, impatto elevato; collegare @issue, @pull-request e documenti.

==== Rischi incontrati
- *RO1:* rischio da compilare a consuntivo.

==== @efficacia:cap delle strategie di gestione e mitigazione dei rischi
La valutazione viene compilata al termine dello Sprint.

==== Migliorie da attuare per le attività future
Registrare le migliorie emerse nel riesame dello @sprint.

==== Retrospettiva
Registrare risultati, problemi e @azione:pl per lo @sprint successivo.

#pagebreak()
=== *@sprint:cap 4*

==== Informazioni generali e attività da svolgere
#mostra-informazioni-sprint(sprint-4, [Completamento dei documenti @rtb e preparazione del riesame della baseline.])
- Completare architettura, @piano-di-qualifica e @norme-di-progetto.
- Integrare i risultati del @poc nella documentazione.
- Preparare criteri e materiale per il riesame della @rtb.

==== Attività svolte
#mostra-burndown(sprint-4)
#mostra-gantt(sprint-4)

==== Preventivo ore
#mostra-tabella-preventivo-ruoli(ore-preventivate-componenti-sprint-4)
#mostra-preventivo-ruoli(sprint-4, ore-preventivate: ore-preventivate-sprint-4)

#pagebreak()
==== Consuntivo ore
#mostra-tabella-consuntivo-ruoli(sprint-4)
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

==== @efficacia delle strategie di gestione e mitigazione dei rischi
La valutazione viene compilata al termine dello @sprint.

==== Migliorie da attuare per le attività future
Registrare le migliorie emerse nel riesame dello @sprint.

==== Retrospettiva
Registrare risultati, problemi e @azione:pl per lo @sprint successivo.

#pagebreak()
=== *@sprint:cap 5*

==== Informazioni generali e attività da svolgere
#mostra-informazioni-sprint(sprint-5, [Riesame e chiusura della @rtb, con @decisione per la @product-baseline.])
- @verifica:cap coerenza tra requisiti, architettura, @poc e @piano-di-qualifica.
- Consolidare la baseline e registrare le decisioni aperte.
- Pianificare la @product-baseline sulla base dei consuntivi @rtb.

==== Attività svolte
#mostra-burndown(sprint-5)
#mostra-gantt(sprint-5)

==== Preventivo ore
#mostra-tabella-preventivo-ruoli(ore-preventivate-componenti-sprint-5)
#mostra-preventivo-ruoli(sprint-5, ore-preventivate: ore-preventivate-sprint-5)

#pagebreak()
==== Consuntivo ore
#mostra-tabella-consuntivo-ruoli(sprint-5)
#mostra-consuntivo-ruoli(sprint-5)

#pagebreak()
==== Aggiornamento delle risorse rimanenti
#mostra-aggiornamento-risorse(sprint-5, ore-preventivate: ore-preventivate-sprint-5)

#pagebreak()
==== Rischi attesi
- *RA3:* ritardo nei chiarimenti sui requisiti; probabilità media, impatto elevato; calendarizzare il SAL e mantenere attività a basso rischio in attesa delle @decisione:pl.
- *RO2:* scostamento tra ore preventivate e consuntive; probabilità media, impatto elevato; aggiornare il ricalcolo a finire e motivare ogni variazione.

==== Rischi incontrati
- *RO1:* rischio da compilare a consuntivo.

==== @efficacia:cap delle strategie di gestione e mitigazione dei rischi
La valutazione viene compilata al termine dello Sprint.

==== Migliorie da attuare per le attività future
Registrare le migliorie emerse nel riesame della @rtb e applicarle alla @pb.

==== Retrospe sttiva
Registrare risultati, problemi e @azione:pl concordate per l'avvio della @pb.

#pagebreak()
== Riepilogo @rtb

Il riepilogo confronta automaticamente le ore e i costi consuntivati nel TSV con il budget @rtb preventivato per ruolo. Il saldo è calcolato sul budget massimo approvato e comprende tutti gli @sprint della @rtb.

#mostra-riepilogo-rtb((sprint-1, sprint-2, sprint-3, sprint-4, sprint-5))
