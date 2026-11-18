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
  versione: "0.2.0",
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
    ("0.2.0", "2026-11-17", "Prima stesura sezioni 1, 2 e 3", RP, LS),
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

Alla #underline(link(<sezione-2>)[sezione 2]), per facilitare l'identificazione dei rischi, è stata introdotta una convenzione di formato che verrà usata per tutto il documento: R[Tipo][Indice].
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

Questa sezione descrive l’analisi dei potenziali rischi associati al progetto. Ogni rischio è stato identificato, analizzato, valutato e sono state definite strategie di gestione e monitoraggio in accordo con lo standard ISO/IEC 31000:2018.

== *RT*

I rischi tecnologici riguardano la scelta e l'integrazione di raw data store, data warehouse, pipeline ETL, web app, API e layer AI. Sono inoltre considerati i rischi di prestazioni, qualità dei dati, compatibilità tra librerie e dipendenza da servizi esterni.

=== *RT1*

== *RO*

I rischi organizzativi comprendono passaggi di consegne incompleti, sovrapposizione delle responsabilità, perdita di tracciabilità e uso non uniforme degli strumenti di progetto.

=== *RO1*

== *RP*

I rischi personali riguardano assenze, carichi di studio, differenze di competenze, ritardi nelle comunicazioni e concentrazione delle conoscenze su un solo componente.

=== *RP1*

== *RA*

I rischi ambientali riguardano indisponibilità dei dati della proponente, variazioni dei requisiti, incompatibilità tecniche, indisponibilità dei servizi esterni, imprevisti al lavoro per gli studeti lavoratori e vincoli di calendario, inclusi esami e festività.

=== *RA1*



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

[Descrivere la pianificazione complessiva del progetto.]

== Attività previste per la RTB

[Elencare le attività previste per la Requirements and Technology Baseline.]

== Attività previste per la PB

[Elencare le attività previste per la Product Baseline.]

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
