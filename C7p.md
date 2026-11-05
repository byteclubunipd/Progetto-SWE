

<!-- Start of picture text -->
CE)R)[e]fo_N;<br>SmartDashboard<br><!-- End of picture text -->

**Piattaforma di Business Intelligence self-service potenziata da AI** INGEGNERIA DEL SOFTWARE  |  anno accademico 2026/2027 

- CHI SIAMO? e 

- • Software house di **Castelfranco Veneto (TV)** , attiva dal **1988** • Sviluppiamo internamente soluzioni **ERP** per aziende del settore **food, beverage e trasporti** : amministrazione e finanza, controllo di gestione, vendite e acquisti, logistica, produzione, qualità, ; oe 

- mobile, web e **Business Intelligence** 

- • Circa **60 persone** , di cui 40 sviluppatori software e 10 sistemisti • Progetti di ricerca su **AI, Machine Learning** e ottimizzazione dei sistemi gestionali {3 as 

- • Azienda certificata **ISO 9001** , in collaborazione costante con Università e istituti tecnici / oe 

- L| Be 

## **PREMESSA** 

- Ogni azienda accumula ogni giorno un’enorme quantità di dati: ordini, vendite per articolo e per agente, movimenti di magazzino, tempi di consegna, marginalità 

- Questi dati restano però confinati nel gestionale ( **ERP** ), in una forma pensata per l’operatività quotidiana e non per l’analisi 

- • Chi deve decidere come direzione commerciale, logistica, controllo di gestione non accede in autonomia alle informazioni: **ogni nuovo report passa dall’IT** 

- E leggere i numeri non basta: capire **perché** sta accadendo qualcosa richiede competenze analitiche che non tutti possiedono 

- **Serve una piattaforma che porti i dati e la loro interpretazione direttamente a chi prende le decisioni** 

- & NID a 

- L’OBIETTIVO: SMARTDASHBOARD e 

- **Una piattaforma BI end-to-end Perché serve** • Recuperare e mantenere allineati i dati provenienti dal • Riduce la **dipendenza dall’IT** per la produzione di **gestionale aziendale** reportistica ; oe 

- • Consolidarli in un **data warehouse** ottimizzato per • Accorcia i tempi tra la **domanda di business** e la l’analisi, secondo un modello dimensionale coerente risposta basata sui dati 

- • Offrire una **web app responsive** per la costruzione • Lascia alle persone il lavoro che conta: **interpretare e** self-service di dashboard interattive **decidere** , non raccogliere e preparare i dati a mano {3 as 

- • Integrare un **assistente AI** che genera visualizzazioni • Il valore aggiunto è il **layer AI** : la stessa direzione presa da richieste in linguaggio naturale e interpreta da diversi strumenti di BI automaticamente i dati / oe 

- L| Be 

# ESEMPI DI INTERFACCIA 



<!-- Start of picture text -->
vente toga 2026 sss nt : © vcore<br>co—.. -|<br>€4,82M seo 18.342 aso 24,6% vars<br>— tumaneewaneanen” | ||<br>Scie cit Meee tmende Pn<br>vena perro coco pr rv<br>ose ome om<br>on ) el<br>aa<br><!-- End of picture text -->



<!-- Start of picture text -->
@smatoashvoad vents ogstea 226 en<br>dk Grafeo bare €.4,82M noo 18.342 woos<br>O Samcnioe [petatatsmane a ne<br> 2M<br>© me || | 7 tet quest evrendretapotvo.<br>cortege<br>alelalal<br>=e<br><!-- End of picture text -->

_Modalità di consultazione: KPI, filtri trasversali, grafici e insight automatici_ 

_Modalità di costruzione: libreria di widget, canvas e assistente AI_ 



<!-- Start of picture text -->
MAP, LL.<br>/G)|C|Omy}<br><!-- End of picture text -->

- REQUISITI FUNZIONALI e 

- • **Costruzione self-service** : dashboard composte in **drag** • **Personalizzazione e usabilità** : temi chiaro/scuro, **& drop** su una griglia reattiva, con configurazione interfaccia responsive, tempi di caricamento contenuti salvata e riutilizzabile anche su dataset ampi ; oe 

- • **Libreria di widget** : grafici (barre, linee, torta), schede • **Esportazione** : contenuti delle dashboard in PDF ed KPI, indicatori a quadrante (gauge), tabelle, tabelle Excel pivot e mappe geografiche • **Gestione utenti e persistenza** : accesso autenticato, 

- • **Interattività e filtri** : filtri trasversali (periodo, area, dashboard salvate lato server e associate al singolo {3 as linea di prodotto, agente) ed esplorazione dei dati a utente diversi livelli di dettaglio • **Assistente AI** : pannello conversazionale integrato nella web app 

- • _Auspicabile una_ **_versione mobile_** _dedicata alla sola_ / oe _consultazione_ L| Be 

# ARCHITETTURA DI RIFERIMENTO 

**1. Raw Data Store** copia fedele e storicizzata dei dati grezzi 

**2. Data Warehouse** modello dimensionale (star schema) per l’analisi 



<!-- Start of picture text -->
e 6<br>e +)<br><!-- End of picture text -->

**3. Web App** API, dashboard builder, libreria di widget e assistente AI 

_Architettura di riferimento, non un vincolo: sono ammesse soluzioni diverse purché mantengano la separazione logica dei componenti_ 



<!-- Start of picture text -->
EJLRILG)<br>LEBILG [OLN }<br><!-- End of picture text -->

- & NID a 

- IL LAYER DI INTELLIGENZA ARTIFICIALE e 

- Un **LLM** che opera sempre nel contesto del modello dati e delle dashboard dell’utente: non sostituisce il motore analitico, fa da **interprete** tra il linguaggio dell’utente e i dati della piattaforma • **1. Generazione di visualizzazioni in linguaggio naturale** (capacità centrale): «mostrami il fatturato mensile per ; oe 

- regione dell’ultimo anno» 

- • **2. Insight automatici** : anomalie, scostamenti significativi, tendenze e stagionalità, restituiti come brevi riassunti narrativi {3 as 

- • **3. Assistente designer** : conosce la dashboard corrente e i metadati delle sorgenti, suggerisce e aggiunge widget pertinenti 

- • **4. Spiegazione di un indicatore** (estensione): «perché le vendite sono calate a marzo?» spiegazione contestuale basata sui dati sottostanti / oe 

- _L’AI lavora solo su dati e metadati esposti dalla piattaforma, senza mai rendere accessibili al frontend le interrogazioni al livello dati e con controlli di coerenza sulle risposte generate_ L| Be 

# LE SFIDE APERTE 

### **Dalla domanda al dato** 

- **Domande ambigue** : l’assistente chiede chiarimenti o dichiara l’assunzione fatta (lordo/netto, trimestre solare/fiscale) 

- **Plausibile ma sbagliato** : il rischio vero sono join errati, doppi conteggi, filtri mancanti, non la sintassi 

- **Valutazione** : domande di riferimento con risposta attesa e test di regressione a ogni cambio di prompt o modello 

- **Insight, non ovvietà** : separare anomalie da rumore e stagionalità, spiegare i cali con l’analisi dei contributi 

- e 

- **Ingegneria attorno all’AI** • **Guardrail** : whitelist di tabelle e colonne, niente SQL libero, limiti su righe e tempi, validazione prima ; oe 

- dell’esecuzione 

- • **Latenza e costi** : risposte in pochi secondi con caching, prompt compatti, scelta del modello 

- • **Privacy** : verso l’API esterna solo i metadati necessari {3 as • **Non determinismo** : prompt e schema versionati, risposte tracciabili, criteri di accettazione condivisi / oe 

- L| Be 

# TECNOLOGIE SUGGERITE 

_Sono suggerimenti: il gruppo è libero di adottare strumenti diversi, purché adeguati agli obiettivi. Consigliato_ **_DuckDB_** _come motore analitico,_ ® a xa _con sorgente dati_ **_pluggable_** _come requisito desiderabile_ e +) ° + : B®. ° ° “ *LEJLR] (a}fo_n] 

# PERCHÉ DUCKDB 

### **DuckDB in breve** 

- **OLAP in-process** : nessun server, il DWH è un singolo file («lo SQLite dell’analisi») 

- **Colonnare e vettorizzato** : query parallele su tutti i core 

- **SQL moderno** : window function, CTE, ASOF join, PIVOT; legge Parquet, CSV, JSON e DataFrame 

- **ACID, licenza MIT** : API multi-linguaggio, gira anche nel browser (WASM) 



<!-- Start of picture text -->
DucKDB<br><!-- End of picture text -->

### **Perché un database a colonne, per la BI** 

- **Solo le colonne usate** : I/O ridotto di un ordine di grandezza 

- **Compressione efficiente** : più dati in RAM 

- **Aggregazioni veloci** : vettorizzazione e SIMD al massimo 

- **Zone map** : i filtri su periodo o area saltano interi blocchi 

- **Star schema** : grandi tabelle dei fatti, letture massive, pochi aggiornamenti 



<!-- Start of picture text -->
ORG e 4)<br><!-- End of picture text -->

# RIGHE vs COLONNE 

La stessa domanda sulla tabella dei fatti: **SELECT data, SUM(fatturato) FROM vendite GROUP BY data** Archiviazione a **RIGHE** (OLTP, come l’ERP) Archiviazione a **COLONNE** 

Archiviazione a **COLONNE** (OLAP, il data warehouse) 

_ordine dei dati su disco:  ↓  colonna per colonna_ 

_ordine dei dati su disco:  riga per riga  →_ 



<!-- Start of picture text -->
data cliente articolo q.tà fatturato agente data cliente articolo q.tà fatturato<br>| a | |<br>|_| [| | |<br>|_| [| | |<br>|_| [| | |<br>[| [| | |<br>I campi di una riga sono contigui su disco: per leggerne due il  Ogni colonna è un blocco a sé: si leggono  solo le due colonne<br>motore  attraversa comunque tutte le colonne citate , compresse e pronte per la somma<br>30 celle lette · 10 utili  → due terzi del lavoro è sprecato 10 celle lette · 10 utili  → 3× meno I/O; con 50 colonne<br>diventa 25×<br>letto e usato letto ma inutile non letto<br><!-- End of picture text -->



<!-- Start of picture text -->
data cliente articolo q.tà fatturato agente<br><!-- End of picture text -->



Ogni colonna è un blocco a sé: si leggono **solo le due colonne citate** , compresse e pronte per la somma **10 celle lette · 10 utili** → 3× meno I/O; con 50 colonne diventa 25× 

_È la differenza tra scorrere tutto lo scaffale e aprire solo il cassetto giusto: per questo un data warehouse colonnare regge dashboard interattive su milioni di righe_ 



<!-- Start of picture text -->
EVR e)o_n}<br><!-- End of picture text -->

- & NID a 

- APPROCCIO DI SVILUPPO CONSIGLIATO e 

- Il progetto è ampio: **non provate a fare tutto subito** . Usate l’analisi dei requisiti per stabilire dove concentrarvi • **Fase 1** Piattaforma BI end-to-end funzionante: recupero dei dati, data warehouse, web app con dashboard selfservice e libreria di widget ; oe 

- • **Fase 2** Capacità AI centrale: generazione di visualizzazioni a partire da richieste in linguaggio naturale • **Fase 3** Estensione del layer AI: insight automatici e assistente di dashboard • **Fase 4** Estensione finale: spiegazione su richiesta di un indicatore o di un grafico {3 as / oe 

- L| Be 



- & NID a 

- DOCUMENTAZIONE E SUPPORTO e 

- **Documentazione attesa Il nostro supporto** • Progettazione architetturale e tecnologie utilizzate • **Allineamento ogni 15 giorni** con il referente aziendale: avanzamento, difficoltà emerse, riesame 

- • Schema della base di dati e **modello dimensionale** del ; oe delle priorità 

- data warehouse • Incontri più ravvicinati e chiarimenti puntuali ogni 

- • Codice sorgente su **repository** (ad esempio GitHub) volta che serve 

- • Documentazione della piattaforma e, in particolare, • In azienda oppure **da remoto** {3 (Teams, Zoom, …) as 

- del **funzionamento del layer AI** • Su richiesta: **dati di un caso di studio reale** (vendite, ordini, logistica) per lo sviluppo e per i test / oe 

- L| Be 

CONTATTI e 7 . **Gianluca** . 4 e **Carlesso** 6° _Responsabile R&D_ e _carlesso@ergon.it_ @ . . bad e 

e> **Anna Tieppo** _HR Manager_ = _tieppo.a@ergon.it_ 



<!-- Start of picture text -->
REGIO_N|<br><!-- End of picture text -->

SERVIZI I NFORMATICI See ERGON INFORMATICA SRL Via per Salvatronda, 21 31033 Castelfranco Veneto (TV) 

Tel: 0423 4247 www.ergon.it 

