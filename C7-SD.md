

<!-- Start of picture text -->
Sa = D><br>wo |] HIS<br>Coy<br><!-- End of picture text -->

**Università degli studi di Padova Corso di Ingegneria del software** 

**Prof. Tullio Vardanega** 



<!-- Start of picture text -->
all G<br>' ! = ae<br>><br><!-- End of picture text -->

**SmartDashboard: piattaforma di Business Intelligence self-service potenziata da AI** 

**Capitolato per il progetto didattico 2026/2027** 



<!-- Start of picture text -->
(E\R)(eJ(c_n] ®<br><!-- End of picture text -->

SmartDashboard Capitolato progetto didattico 2026/2027 ~~———~~ <mark>Bee»)</mark> ~~——____~~ 

## **Indice** 

|1. Oggetto dell’appalto ........................................................................................................................... 3|
|---|
|2. La piattaforma di Business Intelligence .............................................................................................. 4|
|2.1 Requisiti funzionali ........................................................................................................................ 4|
|2.2 Architettura di riferimento ........................................................................................................... 5|
|2.3 Esempi di interfaccia ..................................................................................................................... 6|
|3. Layer di intelligenza artificiale ............................................................................................................ 8|
|4. Tecnologie, suggerimenti e risorse utili .............................................................................................. 8|
|4.1 Approccio di sviluppo consigliato ............................................................................................... 10|
|5. Documentazione ............................................................................................................................... 10|
|6. Supporto ........................................................................................................................................... 11|
|7. Sitografia ........................................................................................................................................... 11|
|8. L’azienda: Ergon Informatica Srl ....................................................................................................... 12|



Ergon Informatica S.r.l.   –   2 

Capitolato progetto didattico 2026/2027 

SmartDashboard 



# **1. Oggetto dell’appalto** 

Ogni azienda che opera nella produzione e nella distribuzione di beni di consumo – si pensi al settore alimentare o a quello dei trasporti e della logistica – accumula quotidianamente un’enorme quantità di dati: ordini dei clienti, vendite per articolo e per agente, movimenti di magazzino, tempi di consegna, marginalità per linea di prodotto. Questi dati raccontano in modo preciso l’andamento del business, ma nella pratica restano spesso confinati all’interno del sistema gestionale (ERP), in una forma pensata per l’operatività quotidiana e non per l’analisi. 

La conseguenza è che chi deve prendere decisioni – la direzione commerciale, il responsabile della logistica, il controllo di gestione – non riesce ad accedere autonomamente alle informazioni di cui ha bisogno. Ogni nuovo report o ogni nuova vista sui dati richiede l’intervento del reparto IT, con tempi di attesa che mal si conciliano con la rapidità richiesta dalle decisioni aziendali. Inoltre, anche quando i numeri sono disponibili, leggerli in forma grezza non basta: capire _che cosa_ sta accadendo e, soprattutto, _perché_ sta accadendo, richiede competenze analitiche che non tutti gli utenti aziendali possiedono. 

L’obiettivo del progetto è la realizzazione di **SmartDashboard** , una piattaforma di Business Intelligence (BI) _end-to-end_ che copra l’intero percorso del dato: dal recupero delle informazioni dal gestionale aziendale, al loro consolidamento in un archivio ottimizzato per l’analisi, fino alle dashboard selfservice con cui gli utenti esplorano i dati in autonomia. 

In sintesi, la piattaforma deve permettere all’azienda di recuperare i dati dal proprio ERP, consolidarli in un data warehouse ottimizzato per l’analisi ed esporre una web application moderna e reattiva in cui gli utenti finali possano costruire autonomamente le proprie dashboard (con modalità _drag & drop_ ) e visualizzare grafici, indicatori di sintesi (KPI), tabelle, tabelle pivot, indicatori a quadrante (gauge) e mappe. Sul mercato esistono già diversi prodotti BI consolidati che, con la progressiva diffusione dell'intelligenza artificiale, hanno arricchito la propria offerta integrando funzionalità AI per potenziare l'interazione degli utenti con i dati: è il caso, ad esempio, di Power BI<sup>1</sup> e Tableau<sup>2</sup> . 

Ciò che distingue SmartDashboard da un comune strumento di reportistica è l’integrazione di un layer di intelligenza artificiale (AI) che persegue due finalità complementari: da un lato abbattere la barriera tecnica, consentendo all’utente di ottenere un grafico o un dato semplicemente descrivendolo a parole, senza dover conoscere il modello dati o costruire interrogazioni; dall’altro arricchire l’esperienza analitica con l’interpretazione automatica dei dati, segnalando anomalie e tendenze e fornendo spiegazioni comprensibili a corredo dei numeri. 

Il progetto si presta quindi a un duplice obiettivo: la costruzione di una **pipeline BI solida e completa** (ingestione, trasformazione, modellazione dimensionale, dashboarding) e la progettazione di un **layer AI** che renda l’analisi dei dati accessibile e conversazionale. I principali risultati attesi sono: 

1. recuperare e mantenere allineati i dati provenienti dal gestionale aziendale 

> 1 <u>https://www.microsoft.com/en-us/power-platform/products/power-bi/#Product-overview https://www.youtube.com/watch?v=Pmt9TyvNsQM</u> 

> 2 <u>https://www.tableau.com/products/tableau https://www.youtube.com/watch?v=e1l7LxnTl9w</u> 

Ergon Informatica S.r.l.   –   3 

Capitolato progetto didattico 2026/2027 

SmartDashboard 



2. consolidare i dati in un data warehouse ottimizzato per l’analisi, secondo un modello dimensionale coerente 

3. offrire una web app responsive per la costruzione self-service di dashboard interattive 

4. integrare un assistente AI capace di generare visualizzazioni a partire da richieste in linguaggio naturale e di produrre interpretazioni automatiche dei dati 

L’adozione di una piattaforma di questo tipo porta benefici tangibili: riduce la dipendenza dall’IT per la produzione di reportistica, accorcia i tempi tra la domanda di business e la risposta basata sui dati, e permette al personale di concentrarsi sull’interpretazione e sulle decisioni anziché sulla raccolta e sulla preparazione manuale delle informazioni. 

# **2. La piattaforma di Business Intelligence** 

La piattaforma è concepita come un sistema a più livelli con responsabilità nettamente separate, in modo che ciascun componente possa essere sviluppato, testato e sostituito in modo indipendente. Questa impostazione modulare è funzionale tanto alla qualità del prodotto quanto alla chiarezza del percorso di sviluppo. Di seguito si descrivono i requisiti funzionali della piattaforma e l’architettura di riferimento proposta; le scelte tecnologiche puntuali restano in capo agli studenti, secondo le indicazioni del capitolo 4. 

### **2.1 Requisiti funzionali** 

La web application costituisce il punto di contatto tra l’utente e i dati. I requisiti funzionali principali sono i seguenti: 

- **Costruzione self-service delle dashboard:** L’utente compone autonomamente la propria dashboard tramite un’interfaccia drag & drop, disponendo e ridimensionando i widget su una griglia reattiva, e ne salva la configurazione per riutilizzarla nelle sessioni successive 

- **Libreria di widget:** La piattaforma mette a disposizione un catalogo di visualizzazioni: grafici (a barre, a linee, a torta), schede KPI, indicatori a quadrante (gauge), tabelle, tabelle pivot e mappe geografiche 

- **Interattività e filtri:** L’utente può applicare filtri trasversali alla dashboard (ad esempio per periodo, area geografica, linea di prodotto o agente) e interagire con i widget per esplorare i dati a diversi livelli di dettaglio 

- **Personalizzazione e usabilità:** Sono previsti temi chiaro/scuro, un’interfaccia responsive e tempi di caricamento dei dati contenuti, in modo da garantire un’esperienza d’uso fluida anche su dataset di dimensioni significative 

- **Esportazione:** I contenuti delle dashboard possono essere esportati nei formati più diffusi (ad esempio PDF ed Excel) per la condivisione 

- **Gestione utenti e persistenza:** L’accesso è riservato a utenti autenticati; le configurazioni delle dashboard sono salvate lato server e associate al singolo utente 

- **Assistente AI:** Un pannello conversazionale, descritto in dettaglio al capitolo 3, affianca l’utente nella creazione delle visualizzazioni e nell’interpretazione dei dati 

Per quanto riguarda l’interfaccia, il canale primario è una **web application responsive** , che ospita per intero le funzionalità di costruzione e modifica delle dashboard. È inoltre auspicabile la disponibilità di 

Ergon Informatica S.r.l.   –   4 

Capitolato progetto didattico 2026/2027 

SmartDashboard 



una **versione mobile dedicata alla sola consultazione** delle dashboard salvate, pensata per chi ha necessità di monitorare gli indicatori in mobilità. 

### **2.2 Architettura di riferimento** 

Si propone un’architettura a tre livelli, da intendersi come riferimento e non come vincolo: è possibile adottare soluzioni differenti, purché mantengano la separazione logica dei componenti. Il flusso del dato attraversa i tre livelli dal gestionale fino alla web app, come illustrato in figura 1. 



<!-- Start of picture text -->
Utenti<br>© wevanp<br>£  costonato eRe xc, (@ mawonsasiore | ev [@ ontawarouse | so, | contre<br>H sorgente da {aoe copia fede © modelo dmensionle brea wget<br>a<br><!-- End of picture text -->

_Figura 1 – Architettura di riferimento della piattaforma_ 

**Livello 1 – Raw Data Store:** Raccoglie una copia fedele e storicizzata dei dati grezzi provenienti dal gestionale, mantenendo traccia di “che cosa è arrivato” dall’ERP. In figura 2, viene mostrato un esempio di dati grezzi relativi alle vendite di un’azienda, in particolare: 

- _cod_art_ che rappresenta il codice dell’articolo, ma non presente la sua descrizione o altre informazioni utili (classificazione del prodotto o l’unità di misura in cui viene venduto) 

- le colonne _ven_lordo_ , _ven_incondizionato_ e _ven_offerta_ rappresentano rispettivamente il fatturato lordo e due tipologie di sconto, manca però il valore del fatturato netto derivato dai tre campi precedenti 



<!-- Start of picture text -->
xrolnese] cod | vrtao| vernoneaono | vente<br>2001 9 00001 211,030.00 17,926.00 1.323,60)<br>2001 9 00101 300.000,00 6.000,00 0,00)<br>2001 9 015002 540.000,00 26.676,00 0.00)<br>2001 9 00103 150,000.00 0.00 0,00)<br>2001 9 100100 180.000,00 0.00 0,00)<br>2001 9 MONTASIO30 400.000,00 0,00 0.00)<br>2001 9 00001 16.500,00 660,00 1.980,00)<br><!-- End of picture text -->

_Figura 2 - Esempio di dati grezzi_ 

**Livello 2 – Data Warehouse:** Un processo di trasformazione (ETL) legge i dati grezzi, li pulisce, li normalizza e li riorganizza in un modello dimensionale ottimizzato per l’analisi, secondo il pattern dello _star schema_<sup>3</sup> (tabelle dimensione come anagrafiche di clienti, articoli e agenti, collegate a tabelle dei fatti come gli ordini e le vendite). È il livello che risponde alla domanda “che cosa viene analizzato” 

> 3https://motherduck.com/learn/star-schema-data-warehouse-guide/ <u>https://learn.microsoft.com/it-it/power-bi/guidance/star-schema</u> 

Ergon Informatica S.r.l.   –   5 

Capitolato progetto didattico 2026/2027 

SmartDashboard 



**Livello 3 – Web App:** Comprende il backend, che interroga il data warehouse e mette a disposizione i dati tramite API, e il frontend, che ospita il costruttore di dashboard, la libreria di visualizzazioni e il pannello dell’assistente AI 

La modularità di questa architettura garantisce flessibilità (ogni livello è evolvibile in autonomia), efficienza (il warehouse è ottimizzato per il carico analitico) e manutenibilità (le responsabilità sono chiaramente delimitate). 

### **2.3 Esempi di interfaccia** 

A titolo esemplificativo si riportano due catture di schermo che illustrano le modalità d’uso previste. Si tratta di indicazioni orientative sull’esperienza utente attesa e non di un vincolo di progettazione grafica. 

La **modalità di consultazione** (figura 3) presenta una dashboard già composta: la barra dei filtri trasversali, le schede KPI di sintesi con la variazione rispetto al periodo precedente, i grafici e il riquadro degli insight generati automaticamente. È la vista con cui l’utente finale legge i dati e, tramite l’assistente, può chiedere approfondimenti sui valori osservati. 



<!-- Start of picture text -->
G soaroestnou vente topsten 2026 GQ==D o----<br>€4,82M son 18.342 sax 24,6% vim<br>a venenena<br>Andamentofaturto mersite cacy Mxperlinend isnaeaitnescnsene<br>gerraiee come oc<br>| | |<br><!-- End of picture text -->

_Figura 3 – Modalità di consultazione della dashboard_ 

La **modalità di costruzione** (figura 4) mostra invece l’ambiente di composizione: la libreria dei widget trascinabili, il canvas con i riquadri già posizionati e l’area di rilascio per un nuovo widget. Sulla destra opera l’assistente AI, che genera una visualizzazione a partire da una richiesta espressa a parole, propone widget pertinenti e fornisce la spiegazione di un indicatore su richiesta; tali funzionalità sono descritte nel capitolo 3. 

<u>https://www.databricks.com/it/blog/what-is-star-schema</u> 

Ergon Informatica S.r.l.   –   6 

SmartDashboard ~~——~~ <mark>RIG»)</mark> ~~—~~ 

Capitolato progetto didattico 2026/2027 



<!-- Start of picture text -->
GB sarvashboard ventea tops 2026 [on en os|<br>© crarcoatena | aa | = woul<br>1© raetamappa pt |||||| ff | * prtcodbraryriodoeaartiCOMI elton<br>PUPTL | | |<br>=<br><!-- End of picture text -->

_Figura 4 – Modalità di costruzione della dashboard con assistente AI_ 

Ergon Informatica S.r.l.   –   7 

SmartDashboard Capitolato progetto didattico 2026/2027 ~~———~~ <mark>Bee»)</mark> ~~——____~~ 

# **3. Layer di intelligenza artificiale** 

Il layer AI è l’elemento che differenzia SmartDashboard da una piattaforma di reportistica tradizionale. La sua funzione è rendere l’analisi dei dati accessibile a chiunque, indipendentemente dalle competenze tecniche, e arricchirla con interpretazioni automatiche. Il cuore di questo layer è un Large Language Model (LLM) che opera sempre nel contesto del modello dati e delle dashboard dell’utente: l’AI non sostituisce il motore analitico, ma fa da interprete tra il linguaggio dell’utente e i dati della piattaforma. 

Si individuano quattro capacità, presentate in ordine di priorità. Le prime costituiscono il nucleo da realizzare; le successive sono estensioni progressive che arricchiscono la piattaforma una volta consolidato il nucleo. 

1. **Generazione di visualizzazioni in linguaggio naturale (capacità centrale):** L’utente descrive a parole ciò che desidera – ad esempio “mostrami il fatturato mensile per regione dell’ultimo anno” – e il sistema interpreta la richiesta, individua i dati pertinenti nel modello e genera automaticamente una risposta eventualmente arricchita con un widget 

2. **Insight automatici:** Il sistema analizza i dati visualizzati e ne estrae automaticamente informazioni di rilievo: anomalie, scostamenti significativi, tendenze e stagionalità, restituite all’utente sotto forma di brevi riassunti narrativi che mettono in evidenza ciò che merita attenzione 

3. **Assistente designer:** Un pannello conversazionale che conosce il contenuto della dashboard corrente e i metadati delle sorgenti, e che può suggerire o aggiungere widget pertinenti, guidando l’utente nella costruzione di una vista completa e significativa 

4. **Spiegazione di un indicatore su richiesta (estensione):** A fronte di una domanda dell’utente su uno specifico grafico o KPI – ad esempio “perché le vendite sono calate a marzo?” – il sistema fornisce una spiegazione contestuale basata sui dati sottostanti, individuando i fattori che hanno maggiormente contribuito al fenomeno osservato 

L’assistente è esposto all’utente attraverso un pannello di chat integrato nella web app. Per garantire affidabilità, l’AI deve operare esclusivamente sui dati e sui metadati resi disponibili dalla piattaforma, senza mai esporre direttamente le interrogazioni al livello dati verso il frontend e con opportuni controlli sulla coerenza delle risposte generate. 

# **4. Tecnologie, suggerimenti e risorse utili** 

A richiesta del gruppo di lavoro, l’azienda proponente è disponibile a fornire i dati di un caso di studio reale (vendite, ordini, logistica) da utilizzare per lo sviluppo e per la fase di test, così da validare la piattaforma su un contesto concreto e valutarne le prestazioni. 

Le tecnologie indicate di seguito sono _suggerimenti_ : il gruppo è libero di adottare strumenti diversi, purché adeguati agli obiettivi. Si segnalano però alcune indicazioni di preferenza, motivate dalle caratteristiche del progetto. 

**Database del data warehouse (scelta consigliata: DuckDB)** 

Come database alla base della piattaforma si consiglia **DuckDB** . Si tratta di un motore analitico _filebased_ , che non richiede l’installazione e la gestione di un server dedicato, offre prestazioni eccellenti 

Ergon Informatica S.r.l.   –   8 

SmartDashboard Capitolato progetto didattico 2026/2027 ~~———~~ <mark>Bee»)</mark> ~~——____~~ 

sulle interrogazioni analitiche e si integra in modo naturale con gli strumenti di trasformazione dati più diffusi. Queste caratteristiche lo rendono particolarmente adatto al carico tipico di una piattaforma BI, in cui prevale la lettura analitica su grandi volumi di dati. In alternativa è possibile valutare motori analitici di natura analoga, orientati alla colonna e ottimizzati per i carichi di sola lettura, quali ClickHouse, MonetDB o Apache DataFusion. 

**Requisito desiderabile – supporto multi-database.** Pur assumendo DuckDB come opzione predefinita, è considerato un requisito desiderabile che la piattaforma sia progettata in modo da poter operare anche su altri database (ad esempio PostgreSQL, MySQL/MariaDB, SQL Server o altri motori analitici). In termini progettuali, ciò si traduce nell’introduzione di un livello di astrazione sulla sorgente dati (sorgente _pluggable_ ) che disaccoppi la logica della piattaforma dallo specifico database, con DuckDB come implementazione di riferimento. 

Riferimenti: DuckDB 

**Raw store e database relazionale di servizio** 

Per il livello di raccolta dei dati grezzi e per la persistenza delle configurazioni utente (dashboard, preferenze, autenticazione) è consigliato un database relazionale. A libera scelta tra le soluzioni attualmente diffuse, quali PostgreSQL, MySQL o MariaDB. 

#### **ETL e trasformazione dei dati** 

Per il processo di estrazione, pulizia e trasformazione dei dati verso il data warehouse si possono adottare librerie di manipolazione dati performanti dell’ecosistema Python (ad esempio Polars) eventualmente affiancate da strumenti di orchestrazione dei flussi quando il numero di tabelle e di dipendenze cresce. 

#### **Connettività con il gestionale** 

Il recupero dei dati dal gestionale aziendale può avvenire tramite connettori standard (ad esempio una fonte dati ODBC) oppure attraverso un middleware che gestisca la comunicazione tra i componenti in un formato di scambio (ad esempio JSON), rendendo la piattaforma indipendente dallo specifico sistema sorgente. 

#### **Layer AI – modello di linguaggio** 

Per le funzionalità di intelligenza artificiale si consiglia, per semplicità di integrazione e qualità dei risultati, il ricorso a un **LLM esposto tramite API commerciale** (ad esempio GPT di OpenAI o Claude di Anthropic). Questa scelta consente di concentrare l’impegno del gruppo sulla logica applicativa – la traduzione delle richieste in visualizzazioni e l’interpretazione dei dati – anziché sulla gestione dell’infrastruttura del modello. Resta naturalmente possibile valutare soluzioni alternative, come la creazione di un server MCP associato alla fonte dati e un agente AI specializzato nello scopo. 

Riferimenti: OpenAI Platform   –   Anthropic Claude 

#### **Frontend e libreria di visualizzazione** 

Per la realizzazione della web app responsive si possono impiegare i framework più diffusi per le interfacce web interattive (ad esempio React, Angular o Vue), affiancati da una libreria di charting completa e performante per i widget. Per il costruttore di dashboard è utile una libreria di layout a griglia che supporti il trascinamento, il ridimensionamento e la reattività ai diversi formati di schermo. 

Ergon Informatica S.r.l.   –   9 

Capitolato progetto didattico 2026/2027 

SmartDashboard 



#### **Comunicazione tra i componenti** 

La comunicazione tra il frontend e il backend avviene tramite API (ad esempio REST), che espongono i dati e le funzionalità della piattaforma in modo controllato, senza mai rendere accessibili al frontend le interrogazioni dirette al livello dati. 



<!-- Start of picture text -->
ETL: Python Polars/ pandas (+orchestazione)<br>= = Web App.<br>| exe | Raw Data Store meager Frontend + dashboard builder<br>} oe ; DB relazionale motore analitico sackend / API<br>;<br>L 0 Connetori middleware  ODBC ISON y L PostgreSQL1 MariadB/ MySQL J ‘DuckDBCekHouse,temave (consigliato) anaogneMonetO8 ra<br>“Apache DataFsion Norra di charting, API REST<br>am 08 requsio desirable LLM via APE: GPT<br>I Claude<br><!-- End of picture text -->

_Figura 5 – Collocazione delle tecnologie suggerite_ 

### **4.1 Approccio di sviluppo consigliato** 

Vista l'ampiezza del progetto e il numero di funzionalità potenzialmente implementabili, il consiglio è di non provare a fare tutto subito: molto più utile è concentrarsi sui punti chiave, usando l'analisi dei requisiti proprio per stabilire dove focalizzarsi. 

In questo senso conviene classificare i requisiti nelle tre categorie di priorità: tra gli **obbligatori** vanno inseriti solo quelli davvero indispensabili, ossia ciò senza cui il prodotto non ha senso; i **desiderabili** raccolgono le funzionalità importanti ma non necessarie a un PoC o a un MVP; i **facoltativi** , infine, sono le idee migliorative da lasciare a sviluppi futuri. 

Coerentemente con questa impostazione, si consiglia di procedere per fasi, consolidando la parte di Business Intelligence prima di concentrarsi sul layer AI e introducendo le capacità di intelligenza artificiale in seguito: 

1. Realizzare la piattaforma BI end-to-end funzionante: recupero dei dati, data warehouse, e web app con costruzione self-service delle dashboard e libreria di widget. 

2. Introdurre la capacità AI centrale: la generazione di visualizzazioni a partire da richieste in linguaggio naturale. 

3. Estendere il layer AI con gli insight automatici e l'assistente di dashboard. 

4. Completare, come estensione, la spiegazione su richiesta di un indicatore o di un grafico. 

Questo approccio incrementale consente di disporre in tempi rapidi di un prodotto utilizzabile e di aggiungere progressivamente le funzionalità a maggior valore, validando ciascuna sul caso di studio reale, anziché arrivare a molte funzionalità appena abbozzate. 

# **5. Documentazione** 

Il progetto dovrà essere supportato dalla documentazione minima necessaria a comprendere il sistema sviluppato nelle sue componenti: 

Ergon Informatica S.r.l.   –   10 

SmartDashboard Capitolato progetto didattico 2026/2027 ~~———~~ <mark>Bee»)</mark> ~~——____~~ 

- progettazione architetturale e tecnologie utilizzate 

- schema di progettazione della base di dati e del modello dimensionale del data warehouse 

- codice prodotto in formato sorgente, reso disponibile tramite repository pubblico (ad esempio GitHub) 

- documentazione descrittiva della piattaforma e, in particolare, del funzionamento del layer di intelligenza artificiale 

# **6. Supporto** 

Per garantire un confronto costante, si propone di fissare un **allineamento ricorrente ogni quindici giorni** , in cui valutare lo stato di avanzamento del progetto, discutere le difficoltà emerse e individuare le possibili soluzioni. Questi appuntamenti periodici sono anche l'occasione per verificare che le scelte adottate restino coerenti con gli obiettivi del capitolato e per riesaminare, se necessario, le priorità dei requisiti. 

Al di là della cadenza fissa, il referente aziendale resta comunque a disposizione per incontri più ravvicinati o per chiarimenti puntuali, ogni volta che l'andamento dei lavori lo richieda. 

#### Contatti: 

- Il referente del progetto sarà Gianluca Carlesso (carlesso@ergon.it). 

- Per problemi di natura organizzativa: Anna Tieppo (tieppo.a@ergon.it). 

# **7. Sitografia** 

_Business Intelligence e modellazione dei dati_ 

- Modellazione dimensionale e star schema (Kimball Group): 

   - <u>https://www.kimballgroup.com/data-warehouse-business-intelligence-resources/kimballtechniques/</u> 

_Database analitici_ 

- DuckDB: https://duckdb.org/ 

- ClickHouse: https://clickhouse.com/ 

- MonetDB: https://www.monetdb.org/ 

- Apache DataFusion: https://datafusion.apache.org/ 

- PostgreSQL: https://www.postgresql.org/ 

- MariaDB: https://mariadb.org/ 

_ETL e trasformazione dei dati_ 

- Polars: https://pola.rs/ 

- Pandas: https://pandas.pydata.org/ 

- Apache Arrow: https://arrow.apache.org/ 

#### _Orchestrazione dei flussi_ 

Ergon Informatica S.r.l.   –   11 

SmartDashboard Capitolato progetto didattico 2026/2027 ~~———~~ <mark>Bee»)</mark> ~~——____~~ 

- Apache Airflow: https://airflow.apache.org/ 

- Prefect: https://www.prefect.io/ 

- Dagster: https://dagster.io/ 

_Frontend e visualizzazione_ 

- React: https://react.dev/ 

- Angular: https://angular.dev/ 

- Vue.js: https://vuejs.org/ 

- Apache ECharts: https://echarts.apache.org/ 

- Chart.js: https://www.chartjs.org/ 

- AG Grid (tabelle e pivot): https://www.ag-grid.com/ 

- react-grid-layout (layout drag & drop): <u>https://github.com/react-grid-layout/react-grid-layout</u> 

_Intelligenza artificiale e modelli linguistici_ 

- OpenAI Platform (GPT): https://platform.openai.com/docs/ 

- Anthropic (Claude): https://docs.anthropic.com/ 

- Introduzione al prompt engineering: https://www.promptingguide.ai/ 

_Interrogazione dei dati in linguaggio naturale_ 

- LangChain (integrazione LLM e sorgenti dati): https://python.langchain.com/ 

- Vanna.ai (text-to-SQL open source): https://vanna.ai/ 

- Spider — benchmark per text-to-SQL: https://yale-lily.github.io/spider 

# **8. L’azienda: Ergon Informatica Srl** 

Ergon Informatica Srl è una società di informatica di Castelfranco Veneto (TV), attiva dal 1988. Fornisce soluzioni ERP (Enterprise Resource Planner) per aziende del settore alimentare e dei trasporti, interamente analizzate e sviluppate al proprio interno. In particolare, si occupa di progettazione, consulenza e sviluppo di software gestionale nelle seguenti aree: Amministrazione e Finanza, Controllo di Gestione, Area Vendite e Acquisti, Logistica, Produzione, Archiviazione Documentale, Qualità, Mobile, Web e Business Intelligence. 

Ergon fornisce inoltre servizi sistemistici, installando tutta l’infrastruttura hardware necessaria ai propri clienti e occupandosi di sicurezza, networking, radio frequenza e virtualizzazione dei sistemi. 

Negli ultimi dieci anni l’azienda è stata interessata da una costante crescita, sia in termini di Risorse Umane sia di progetti, alcuni dei quali afferenti ad ambiti innovativi come l’AI (Artificial Intelligence) e il Machine Learning, nonché l’ottimizzazione dei sistemi gestionali. A questo proposito Ergon si avvale sempre di più della collaborazione di Università ed Istituti tecnici per offrire soluzioni software più competitive e all’avanguardia. 

Si tratta di un’azienda certificata, che da molti anni segue gli standard ISO:9001, con un sistema di gestione e di processo secondo i parametri richiesti. 

Ergon Informatica S.r.l.   –   12 

