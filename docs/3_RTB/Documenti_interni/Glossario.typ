#import "/docs/5_Templates/documento.typ": *
#import "@preview/glossy:0.9.2": *

// Dizionario completo da importare negli altri documenti
#let termini = (
  // --- A ---
  agile: (
    short: "agile",
    description: [In informatica, Agile è un approccio di lavoro basato su iterazioni brevi e frequenti feedback. Nel metodo Scrum, uno dei più diffusi, il lavoro viene suddiviso in Sprint di una o due settimane. Ogni Sprint inizia con una Sprint Planning, in cui si definiscono gli obiettivi, e si conclude con una Sprint Retrospective, in cui il gruppo valuta cosa è andato bene e cosa migliorare.],
  ),
  amministratore-progetto: (
    short: "amministratore del Progetto",
    description: [Ruolo che si occupa della configurazione e gestione dell’infrastruttura IT di supporto a un progetto.],
  ),
  amministratore: (
    short: "amministratore",
    description: [Specializzazione di un attore nella gerarchia di utenti previsti in SmartDashboard. Si occupa della configurazione e gestione dell’infrastruttura.],
  ),
  analisi-dei-requisiti: (
    short: "analisi dei requisiti",
    description: [Documento contenente i Casi d’Uso identificati da un gruppo per i requisiti di un determinato progetto. Contiene anche i Requisiti funzionali, Requisiti di Qualità e Requisiti di Vincolo.],
  ),
  analista: (
    short: "analista",
    description: [Ruolo che si occupa di identificare e chiarire i requisiti, interpretando le esigenze degli utilizzatori finali per garantire una corretta definizione delle funzionalità.],
  ),
  api: (
    short: "API",
    plural: "API",
    long: "Application Programming Interface",
    description: [Acronimo di Application Programming Interface, è un’interfaccia utile a permettere o facilitare la comunicazione tra diversi software o parti di un singolo software.],
  ),
  attore: (
    short: "attore",
    description: [Un’entità esterna e non controllabile dal sistema, ma che interagisce con esso, con attività o obiettivi specifici da soddisfare.],
  ),
  autenticazione: (
    short: "autenticazione",
    description: [Processo di verifica dell’identità di un utente o di un sistema, al fine di garantire l’accesso sicuro a risorse o servizi. L’autenticazione può avvenire tramite credenziali (come username e password), token, certificati digitali o altri metodi di identificazione. Una volta autenticato, l’utente può accedere alle funzionalità e ai dati autorizzati, mentre l’autenticazione fallita impedisce l’accesso non autorizzato.],
  ),
  autorizzazione: (
    short: "autorizzazione",
    description: [Processo che determina i privilegi e i permessi di un utente o di un sistema autenticato, stabilendo quali azioni può eseguire e quali risorse può accedere. L’autorizzazione viene spesso gestita tramite ruoli, gruppi o politiche di accesso, garantendo che solo gli utenti con i diritti appropriati possano eseguire determinate operazioni o visualizzare informazioni sensibili.],
  ),
  azione: (
    short: "azione",
    plural: "azioni",
    description: [L’insieme di processi intrapresi per mettere in pratica una determinata decisione.],
  ),

  // --- B ---
  backend: (
    short: "backend",
    description: [La parte di un progetto che si occupa del funzionamento a livello logico del sistema.],
  ),
  base-di-dati: (
    short: "base di dati",
    description: [Traduzione italiana del termine Database, per la definizione vedere ‘@database’.],
  ),
  bi: (
    short: "BI",
    long: "Business Intelligence",
    description: [Acronimo di Business Intelligence, è un insieme di processi, strumenti e tecnologie che consentono alle organizzazioni di raccogliere, analizzare e visualizzare dati aziendali per supportare decisioni strategiche e operative. La BI trasforma i dati grezzi in informazioni significative, permettendo di identificare tendenze, modelli e opportunità di miglioramento.],
  ),

  // --- C ---
  capitolato: (
    short: "capitolato",
    description: [Documento fornito dalla proponente, che espone le principali specifiche e condizioni di un progetto. Stabilisce delle regole e delle aspettative che il fornitore deve rispettare.],
  ),
  caso-d-uso: (
    short: "caso d’uso",
    description: [Insieme di azioni all’interno di uno scenario, con in comune uno scopo finale per un attore.],
  ),
  committente: (
    short: "committente",
    plural: "committenti",
    description: [Persona, ente o azienda che richiede e finanzia la realizzazione di un progetto software, di un sistema informatico o di un servizio IT. Il committente definisce gli obiettivi, approva i requisiti e verifica i risultati, ma non esegue direttamente lo sviluppo.],
  ),
  csv: (
    short: "CSV",
    long: "Comma-Separated Values",
    description: [Acronimo di Comma-Separated Values, è un formato di file utilizzato per memorizzare dati tabulari in cui ogni riga rappresenta un record e i valori dei campi sono separati da virgole o altri delimitatori. I file CSV sono ampiamente utilizzati per l’importazione e l’esportazione di dati tra diverse applicazioni, come fogli di calcolo, database e software di analisi dei dati.],
  ),
  // --- D ---
  database: (
    short: "database",
    plural: "database",
    description: [Un database (in italiano: base di dati) è un sistema per la conservazione e gestione dei dati. Comprende una componente fisica, che è il supporto di memorizzazione dei dati, e una componente software, detta DBMS (Guardare definizione @dbms).],
  ),
  data-warehouse: (
    short: "data warehouse",
    description: [Sistema di archiviazione e gestione dei dati progettato per supportare l’analisi e la generazione di report. Un data warehouse raccoglie dati provenienti da diverse fonti, li organizza in un formato coerente e li rende disponibili per l’analisi storica e decisionale. È ottimizzato per query complesse e analisi multidimensionali, consentendo alle organizzazioni di ottenere informazioni strategiche dai propri dati.],
  ),
  dashboard: (
    short: "dashboard",
    plural: "dashboard",
    description: [Interfaccia grafica che fornisce una panoramica delle informazioni più rilevanti e consente di monitorare lo stato di un sistema o di un progetto. Spesso include grafici, tabelle e indicatori chiave di prestazione (@kpi) per facilitare la comprensione e l’analisi dei dati.],
  ),
  db: (
    short: "DB",
    long: "Database",
    description: [Acronimo di Database, per la definizione vedere ‘@database’.],
  ),
  dbms: (
    short: "DBMS",
    long: "Database Management System",
    description: [Acronimo di Database Management System, è un software che gestisce l’archiviazione, l’organizzazione e l’accesso ai dati all’interno di un database. Fornisce strumenti per creare, leggere, aggiornare e cancellare dati, garantendo integrità, sicurezza e prestazioni ottimali. Esempi di DBMS includono MySQL, PostgreSQL, Oracle Database e Microsoft SQL Server.],
  ),
  decisione: (
    short: "decisione",
    plural: "decisioni",
    description: [Un accordo all’interno del gruppo, riguardante metodologie o convenzioni da adottare per soddisfare un determinato bisogno.],
  ),
  design-pattern: (
    short: "design pattern",
    description: [Soluzione progettuale riutilizzabile a problemi comuni nella progettazione del software, utile per migliorare struttura e manutenibilità del codice.],
  ),
  discord: (
    short: "Discord",
    description: [Piattaforma di videochiamate e messaggistica asincrona. È caratterizzata dalla possibilità di creare spazi indipendenti chiamati server, all’interno dei quali è possibile istituire vari canali testuali (tipicamente suddivisi per argomento) e canali vocali indipendenti, utilizzati per chiamate di gruppo tra i membri del server.],
  ),
  docker: (
    short: "Docker",
    description: [Piattaforma software che consente di creare, distribuire e gestire applicazioni all’interno di container, che sono ambienti isolati e portabili. Docker semplifica il processo di sviluppo e distribuzione delle applicazioni, garantendo coerenza tra diversi ambienti (sviluppo, test e produzione) e facilitando la scalabilità e la gestione delle dipendenze.],
  ),
  drag-and-drop: (
    short: "drag & drop",
    description: [Tecnica di interazione con l’interfaccia utente che permette di selezionare un elemento e spostarlo in un’altra posizione trascinandolo con il cursore del mouse o con il dito su dispositivi touch. Viene spesso utilizzata per organizzare elementi, come file o icone, in modo intuitivo e visivo.],
  ),
  drill-down: (
    short: "drill down",
    description: [Tecnica di analisi dei dati che consente di esplorare i dettagli di un insieme di informazioni, passando da un livello di aggregazione a uno più granulare. Viene spesso utilizzata in contesti di business intelligence e reporting per ottenere una visione più approfondita dei dati.],
  ),

  // --- E ---
  efficacia: (
    short: "efficacia",
    description: [Indica il modo con cui un insieme di attività raggiunge gli obiettivi attesi.],
  ),
  efficienza: (
    short: "efficienza",
    description: [Rapporto tra risultati ottenuti e risorse impiegate per ottenerli.],
  ),
  erp: (
    short: "ERP",
    long: "Enterprise Resource Planning",
    description: [Acronimo di Enterprise Resource Planning, è un sistema software integrato che gestisce e automatizza i processi aziendali principali, come contabilità, gestione delle risorse umane, produzione, approvvigionamento e vendite. Gli ERP consentono alle organizzazioni di centralizzare le informazioni, migliorare la collaborazione tra i reparti e ottimizzare l’efficienza operativa.],
  ),
  excel: (
    short: "Excel",
    description: [Software di Microsoft per la gestione di fogli di calcolo, che consente di organizzare, analizzare e visualizzare dati in tabelle, grafici e report. È ampiamente utilizzato in ambito aziendale, finanziario e accademico per attività come la contabilità, l’analisi dei dati e la pianificazione.],
  ),

  // --- F ---
  fast-api: (
    short: "FastAPI",
    description: [Framework web moderno e ad alte prestazioni per la creazione di API in Python, basato su standard come OpenAPI e JSON Schema. FastAPI semplifica lo sviluppo di applicazioni web e microservizi, offrendo funzionalità come la validazione automatica dei dati e la generazione di documentazione interattiva.],
  ),
  frontend: (
    short: "frontend",
    description: [La parte di un progetto che si occupa dell’interazione diretta con l’utilizzatore finale.],
  ),
  funzionalita: (
    short: "funzionalità",
    plural: "funzionalità",
    description: [Una caratteristica offerta da un sistema, spesso con lo scopo di soddisfare un bisogno.],
  ),

  // --- G ---
  gauge: (
    short: "gauge",
    description: [Termine tecnico per un indicatore visivo che mostra lo stato di avanzamento di una metrica. Per la definizione vedere "@indicatori-a-quadrante".],
  ),
  git: (
    short: "Git",
    description: [Sistema di controllo di versione che traccia le modifiche al codice sorgente nel tempo. Permette a più sviluppatori di collaborare simultaneamente sullo stesso progetto, gestendo la cronologia delle versioni e supportando lo sviluppo parallelo.],
  ),
  gitflow: (
    short: "GitFlow",
    description: [Modello che sfrutta i branch di Git definendo una struttura organizzata per la gestione dei rami di sviluppo; facilita il lavoro parallelo e consente la netta separazione della versione in produzione.],
  ),
  github: (
    short: "GitHub",
    description: [Servizio cloud che permette di gestire una o più repository Git, offre strumenti che semplificano la collaborazione e l’automazione di processi.],
  ),
  github-action: (
    short: "GitHub Action",
    description: [Strumento messo a disposizione da GitHub per effettuare automazioni all’interno di una repository.],
  ),
  glossario: (
    short: "glossario",
    description: [Elenco di termini con le relative definizioni, utilizzato per chiarire il significato di concetti specifici in un determinato contesto.],
  ),
  gmail: (
    short: "Gmail",
    description: [Servizio di posta elettronica sviluppato da Google che permette di inviare, ricevere e organizzare email tramite web o applicazioni dedicate.],
  ),

  // --- I ---
  ia: (
    short: "IA",
    long: "Intelligenza Artificiale",
    description: [Acronimo di Intelligenza Artificiale, per la definizione vedere ‘@intelligenza-artificiale’.],
  ),
  ieee: (
    short: "IEEE",
    long: "Institute of Electrical and Electronics Engineers",
    description: [È l’acronimo di Institute of Electrical and Electronics Engineers, un’associazione internazionale che promuove lo sviluppo delle tecnologie e dell’ingegneria in ambiti come l’elettronica, informatica e le telecomunicazioni.],
  ),
  indicatori-a-quadrante: (
    short: "indicatori a quadrante",
    description: [Elementi grafici simili a un tachimetro o a un contachilometri utilizzati per mostrare a colpo d'occhio lo stato di avanzamento di una metrica rispetto a un valore minimo, un valore massimo e determinate soglie di obiettivo.],
  ),
  intelligenza-artificiale: (
    short: "intelligenza artificiale",
    description: [Disciplina dell’informatica che studia e sviluppa sistemi in grado di eseguire compiti che richiedono tipicamente l’intelligenza umana, come il ragionamento, l’apprendimento e la comprensione del linguaggio naturale.],
  ),
  interfaccia-responsive: (
    short: "interfaccia responsive",
    description: [Design grafico che adatta automaticamente layout, dimensioni e disposizione degli elementi dello schermo al dispositivo utilizzato dall'utente (computer desktop, tablet o smartphone), garantendo sempre una navigazione ottimale.],
  ),
  issue: (
    short: "issue",
    plural: "issue",
    description: [All’interno dell’ecosistema GitHub, rappresenta un’attività che richiede modifiche al codice sorgente per essere svolta, può trattarsi di un bug da risolvere, una feature da aggiungere, di una correzione minore o anche di qualcosa definito dagli sviluppatori.],
  ),

  // --- K ---
  kpi: (
    short: "KPI",
    long: "Key Performance Indicator",
    description: [Acronimo di Key Performance Indicator, è una metrica utilizzata per misurare le prestazioni di un progetto, processo o attività, fornendo informazioni chiave sul raggiungimento degli obiettivi prefissati. I KPI aiutano a monitorare i progressi, identificare aree di miglioramento e prendere decisioni informate per ottimizzare le performance complessive.],
  ),

  // --- L ---
  llm: (
    short: "LLM",
    long: "Large Language Model",
    description: [Large Language Model. Indica i modelli addestrati su enormi quantità di testo come ChatGPT e Claude.],
  ),

  // --- M ---
  manuale-utente: (
    short: "manuale utente",
    description: [Documento che descrive le funzionalità di un software e fornisce istruzioni per il suo corretto utilizzo da parte degli utenti finali.],
  ),
  manutenzione: (
    short: "manutenzione",
    description: [Insieme di attività atte a risolvere i problemi e migliorare le funzionalità di un prodotto.],
  ),
  merge: (
    short: "merge",
    description: [Processo con il quale, in un sistema di versionamento come Git, un ramo di lavoro viene fatto confluire in un altro, generalmente in un grado gerarchico più elevato.],
  ),
  milestone: (
    short: "milestone",
    plural: "milestone",
    description: [Punto significativo nel percorso del progetto in cui il gruppo si pone il raggiungimento di determinati obiettivi.],
  ),
  minimum-viable-product: (
    short: "Minimum Viable Product",
    description: [La prima versione di un prodotto che assolve le funzionalità minime per rispettare i requisiti obbligatori stabiliti dalla proponente.],
  ),
  mvp: (
    short: "MVP",
    long: "Minimum Viable Product",
    description: [Acronimo di Minimum Viable Product, per la definizione vedere ‘@minimum-viable-product’.],
  ),

  // --- N ---
  norme-di-progetto: (
    short: "norme di progetto",
    description: [Documento che descrive il Way of Working del gruppo. Contiene le regole che ByteClub rispetta per garantire un lavoro efficace ed efficiente.],
  ),

  // --- P ---
  pb: (
    short: "PB",
    long: "Product Baseline",
    description: [Acronimo di Product Baseline, per la definizione vedere ‘@product-baseline’.],
  ),
  pdf: (
    short: "PDF",
    long: "Portable Document Format",
    description: [Acronimo di Portable Document Format, è un formato di file standard ideale per esportare, archiviare e condividere report e documenti mantenendo inalterati layout, font e grafici su qualsiasi dispositivo.],
  ),
  pianificazione: (
    short: "pianificazione",
    description: [Processo di definizione degli obiettivi del progetto identificandone le risorse ed i tempi richiesti per la sua realizzazione.],
  ),
  piano-di-progetto: (
    short: "piano di progetto",
    description: [Documento che si occupa di definire l’organizzazione del gruppo, specificando l’assegnazione dei ruoli, il monte ore previsto per ogni risorsa, le tempistiche e il conto economico preventivo in funzione dell’avanzamento del progetto.],
  ),
  piano-di-qualifica: (
    short: "piano di qualifica",
    description: [Documento che si occupa di garantire il rispetto dei requisiti del progetto definendo le strategie di verifica e validazione affinché vengano rispettate le attese della proponente.],
  ),
  poc: (
    short: "PoC",
    plural: "PoC",
    long: "Proof of Concept",
    description: [Acronimo di Proof of Concept, per la definizione vedere ‘@proof-of-concept’.],
  ),
  pr: (
    short: "PR",
    long: "Pull Request",
    description: [Acronimo di Pull Request, per la definizione vedere ‘@pull-request’.],
  ),
  processo: (
    short: "processo",
    plural: "processi",
    description: [Insieme di attività correlate e coese che trasformano ingressi (bisogni) in uscite (prodotti) secondo regole date, consumando risorse nel farlo.],
  ),
  product-baseline: (
    short: "product baseline",
    description: [versione ufficiale e approvata degli artefatti di un sistema software (inclusi codice sorgente, configurazioni, dipendenze e documentazione tecnica) in un determinato punto del ciclo di vita, tipicamente in corrispondenza di una release. Costituisce il riferimento vincolante per il build, il collaudo, il rilascio in produzione e la gestione controllata delle modifiche.],
  ),
  produzione: (
    short: "produzione",
    description: [Processo di traduzione della progettazione in codice sorgente mediante la programmazione ed i test.],
  ),
  progettazione: (
    short: "progettazione",
    description: [Processo che definisce la struttura di un sistema, identificandone componenti, relazioni e livello di dettaglio necessari per la realizzazione. Serve a semplificarne lo sviluppo e la manutenzione futura.],
  ),
  progettista: (
    short: "progettista",
    description: [Ruolo che si occupa della progettazione dell’architettura di un progetto, al fine di assicurarsi codice più corretto e manutenibile.],
  ),
  progetto: (
    short: "progetto",
    description: [Insieme ordinato di attività, istanziate dai processi di ciclo di vita che soddisfano gli obiettivi dati.],
  ),
  programmatore: (
    short: "programmatore",
    description: [Ruolo che si occupa di svolgere le attività di codifica, data l’architettura.],
  ),
  proof-of-concept: (
    short: "Proof of Concept",
    description: [Prodotto dimostrativo atto a presentare la fattibilità dell’idea.],
  ),
  proponente: (
    short: "proponente",
    description: [La persona, il gruppo o l’organizzazione che propone un progetto, un’idea o un’iniziativa, e ne definisce obiettivi, requisiti e motivazioni. La proponente di ByteClub è Ergon Informatica s.r.l.],
  ),
  pull-request: (
    short: "pull request",
    plural: "pull request",
    description: [All’interno dell’ecosistema GitHub, uno strumento che permette di sospendere momentaneamente la pubblicazione di una modifica nel ramo principale della repository, in attesa di approvazione e/o workflow automatici (e.g. GitHub Action).],
  ),

  // --- Q ---
  query: (
    short: "query",
    plural: "query",
    description: [Richiesta di dati o informazioni inviata a un sistema, come un database o un motore di ricerca, per ottenere risultati specifici.],
  ),

  // --- R ---
  redattore: (
    short: "redattore",
    description: [Colui che scrive il documento, viene identificato come “Autore” nel registro delle modifiche.],
  ),
  repository: (
    short: "repository",
    description: [Uno spazio condiviso tra tutti i membri del gruppo, in cui viene memorizzato e versionato tutto il codice sorgente prodotto.],
  ),
  requisiti-di-qualita: (
    short: "requisiti di qualità",
    description: [Tipo di requisito che descrive le caratteristiche qualitative che il progetto deve possedere, come prestazioni, sicurezza, affidabilità e usabilità.],
  ),
  requisito-di-vincolo: (
    short: "requisito di vincolo",
    plural: "requisiti di vincolo",
    description: [Tipo di requisito che descrive le restrizioni imposte dall’azienda proponente che il progetto deve rispettare.],
  ),
  requisito-funzionale: (
    short: "requisito funzionale",
    plural: "requisiti funzionali",
    description: [Definiscono cosa il sistema deve fare, descrivendo le sue azioni e funzioni specifiche. Sono le capacità che l’utente si aspetta, come “aggiungere un prodotto al carrello” in un negozio online.],
  ),
  requisito-non-funzionale: (
    short: "requisito non funzionale",
    plural: "requisiti non funzionali",
    description: [Specificano come il sistema deve comportarsi mentre svolge quelle funzioni. Si concentrano su qualità come le prestazioni, la sicurezza o l’affidabilità, ad esempio “il sistema deve supportare 1000 utenti contemporanei senza rallentamenti”.],
  ),
  responsabile: (
    short: "responsabile",
    description: [Ruolo che si occupa di coordinare le attività del gruppo e garantire una pianificazione efficace.],
  ),
  rtb: (
    short: "RTB",
    long: "Requirements and Technology Baseline",
    description: [Baseline iniziale e vincolante di requisiti e tecnologie approvate per il progetto. Comprende requisiti funzionali, non funzionali, di sicurezza e conformità, insieme a strumenti, linguaggi, piattaforme e infrastrutture scelte. Costituisce il riferimento stabile per verificare coerenza e avanzamento. Qualsiasi modifica richiede revisione e approvazione formale.],
  ),

  // --- S ---
  sal: (
    short: "SAL",
    long: "Stato Avanzamento Lavori",
    description: [Acronimo di Stato Avanzamento Lavori, è un documento che riassume lo stato di avanzamento del progetto, evidenziando le attività completate, quelle in corso e quelle pianificate. Il SAL fornisce una panoramica chiara dei progressi rispetto agli obiettivi prefissati e serve come strumento di comunicazione tra il team di progetto e gli stakeholder.],
  ),
  schede-kpi: (
    short: "schede KPI",
    description: [Strumenti di monitoraggio delle prestazioni che visualizzano metriche chiave (KPI) in modo chiaro e conciso, consentendo agli utenti di valutare rapidamente lo stato di un progetto o di un sistema e prendere decisioni informate.],
  ),
  self-service: (
    short: "self-service",
    description: [Modalità di interazione con un sistema che consente agli utenti di accedere a funzionalità e informazioni senza l’assistenza diretta di un operatore umano, spesso tramite interfacce intuitive e automatizzate.],
  ),
  server: (
    short: "server",
    description: [Sistema informatico (hardware o virtuale) che ospita applicazioni, elabora le richieste degli utenti, gestisce i database e distribuisce i dati attraverso una rete aziendale o tramite internet.],
  ),
  sprint: (
    short: "sprint",
    plural: "sprint",
    description: [Ciclo di lavoro di durata fissa, tipico dello sviluppo Agile, durante il quale il gruppo si impegna a completare un insieme prefissato di attività per produrre un incremento del software.],
  ),
  sql: (
    short: "SQL",
    long: "Structured Query Language",
    description: [Acronimo di Structured Query Language, è un linguaggio dichiarativo con lo scopo di definire, interrogare, modificare ed eliminare dati memorizzati all’interno di tabelle nei database relazionali.],
  ),
  stakeholder: (
    short: "stakeholder",
    description: [Qualunque persona, gruppo o organizzazione che ha interesse, influenza o è coinvolta nel progetto, includendo clienti, utenti, sviluppatori, dirigenti, fornitori e persino organizzazioni esterne.],
  ),
  sviluppo: (
    short: "sviluppo",
    description: [Attività pratica di scrittura, test e integrazione del codice necessaria a implementare le funzionalità definite durante la fase di progettazione.],
  ),

  // --- T ---
  tabelle-pivot: (
    short: "tabelle pivot",
    description: [Strumento di analisi dei dati che consente di riassumere, aggregare e visualizzare grandi quantità di informazioni in modo interattivo. Le tabelle pivot permettono di riorganizzare i dati, calcolare totali e medie, e creare report personalizzati per facilitare la comprensione e l’interpretazione dei dati.],
  ),
  test: (
    short: "test",
    plural: "test",
    description: [Un processo dello sviluppo software che si occupa di verificare la funzionalità di una o più parti del prodotto.],
  ),
  typst: (
    short: "Typst",
    description: [Linguaggio di markup utilizzato dal gruppo per produrre tutti i documenti.],
  ),

  // --- U ---
  uml: (
    short: "UML",
    long: "Unified Modeling Language",
    description: [Acronimo di Unified Modeling Language, si tratta di un linguaggio di modellazione standard. Utilizzato per la visualizzazione di sistemi complessi tramite diagrammi, per esempio: diagrammi di classi, casi d’uso, diagrammi delle attività, etc.],
  ),

  // --- V ---
  validazione: (
    short: "validazione",
    description: [Insieme di controlli per assicurarsi che un prodotto (o una parte di esso) soddisfi in modo congruo ciò per cui è stato creato.],
  ),
  ve: (
    short: "VE",
    long: "Verbale Esterno",
    description: [Acronimo di Verbale Esterno, viene utilizzato per tracciare nel tempo decisioni e azioni intraprese in un incontro esterno. Il codice associato ai VE segue la forma VE_YYYY_MM_DD (YYYY: anno, MM: mese, DD: giorno).],
  ),
  verifica: (
    short: "verifica",
    description: [Insieme di processi atti a garantire che una funzione all’interno di un prodotto soddisfi determinati requisiti.],
  ),
  verificatore: (
    short: "verificatore",
    description: [Ruolo che si occupa di assicurare la qualità dei prodotti e dei processi adottati, effettuando revisioni e test.],
  ),
  versionamento: (
    short: "versionamento",
    description: [Metodo per gestire e tenere traccia di documenti, codice o altri artefatti digitali, organizzandoli in versioni identificate da un codice univoco, in modo da poter monitorare modifiche, confrontare stati diversi e ripristinare versioni precedenti.],
  ),
  vi: (
    short: "VI",
    long: "Verbale Interno",
    description: [Acronimo di Verbale Interno, viene utilizzato per tracciare nel tempo decisioni e azioni intraprese in un incontro interno. Il codice associato ai VI segue la forma VI_YYYY_MM_DD (YYYY: anno, MM: mese, DD: giorno).],
  ),

  // --- W ---
  way-of-working: (
    short: "way of working",
    description: [Insieme di metodologie e strutture organizzative approvate dall’intero gruppo per svolgere in modo coerente i propri compiti.],
  ),
  widget: (
    short: "widget",
    description: [Elemento dell’interfaccia grafica di un software che consente all’utente di interagire con il sistema, come grafici o tabelle in SmartDashboard. I widget facilitano l’accesso a funzionalità e informazioni, migliorando l’esperienza dell’utente.],
  ),
  whatsapp: (
    short: "WhatsApp",
    description: [Applicazione di messaggistica istantanea adottata dal gruppo ByteClub per le comunicazioni interne e per le comunicazioni esterne con la proponente.],
  ),
)

// CONFIGURAZIONE DEL GLOSSARIO

#let gruppo = "ByteClub"
#let alfabeto = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".clusters()
#let ultimo-indice = state("ultimo-indice", -1)

#show: documento.with(
  titolo: "Glossario",
  versione: "0.1.3",
  mostraInformazioni: true,
  mostraRegistro: true,
  stato: "Da Approvare",
  redazione: BG,
  verifica: "",
  approvazione: "",
  proprietario: gruppo,
  uso: "Interno",
  destinatari: gruppo,
  indice: true,
  registroModifiche: (
    ("0.1.3", "2026-11-25", "Corrette definizioni dopo la verifica e aggiunti termini mancanti", BG, LS),
    ("0.1.2", "2026-11-21", "Automazione generazione glossario con pacchetto glossy", BG, LS),
    ("0.1.1", "2026-11-13", "Aggiunti nuovi termini", BG, LS),
    ("0.1.0", "2026-11-12", "Formattazione e prima stesura del documento", BG, LS),
  ),
)

// Inizializzazione glossy per i rimandi interni nelle descrizioni (es. @database, @dbms)
#show: init-glossary.with(termini)

// Formattazione dei titoli e dell'indice
#set heading(numbering: none)
#show heading.where(level: 1): set align(center)
#show heading.where(level: 2): set heading(outlined: false)

= Introduzione
Il documento definisce in modo univoco i termini adottati all’interno del progetto, così da evitare interpretazioni personali o variazioni di significato. Le definizioni sono presentate in ordine alfabetico per rendere la consultazione diretta e stabile nel tempo. Quando un termine compare nei documenti con un significato vincolato dal Glossario, viene segnalato con la notazione:
#align(center)[termine#super[G]]

#pagebreak()

#glossary(
  title: "",
  sort: true,
  ignore-case: true,
  show-all: true,
  theme: (
    section: (title, body) => body,
    group: (name, index, total, body) => body,
    entry: (entry, index, total) => {
      let iniziale = upper(entry.short.first())
      let target = alfabeto.position(l => l == iniziale)

      if target != none {
        context {
          let prev = ultimo-indice.get()
          for i in range(prev + 1, target + 1) {
            if i > 0 { pagebreak() }
            heading(level: 1, alfabeto.at(i))
          }
        }
        ultimo-indice.update(target)
      }

      [
        == #entry.short #entry.label
        #entry.description
      ]
    },
  ),
)

// Inserimento delle lettere senza termini disponibili
#context {
  let prev = ultimo-indice.get()
  for i in range(prev + 1, alfabeto.len()) {
    if i > 0 { pagebreak() }
    heading(level: 1, alfabeto.at(i))
  }
}