#import "/docs/5_Templates/documento.typ": *

// Nomenclatura: Nome_documento-v0.1.0.typ; x contenuto, y struttura, z stile.
// Modello compilabile: sostituire i segnaposto con i dati effettivi.
// Salvare una copia nella cartella della fase pertinente in docs.
#show: documento.with(
  titolo: "Valutazione Capitolati",
  versione: "1.0.0",
  stato: "Approvato",
  redazione: (BG),
  verifica: LS,
  approvazione: "Tutto il gruppo",
  proprietario: "ByteClub",
  uso: "Esterno",
  destinatari: "Prof. Vardanega Tullio \nProf. Cardin Riccardo",
  modifiche: (
    ("1.0.0", "2026-10-30", "Tutto il gruppo", "Approvazione del documento."),
    ("0.3.5", "2026-10-25", BG, "Corretti refusi e piccoli errori di battitura presenti nel documento dopo una prima revisione."),
    ("0.3.4", "2026-10-22", BG, "Modifiche minori al capitolato C3 dopo meeting con Uranion."),
    ("0.3.2", "2026-10-21", BG, "Rimossi numeri indice dato che vengono generati automaticamente attraverso GitHub, corretti errori di battitura."),
    ("0.3.1", "2026-10-20", BG, "Aggiunte sezioni mancanti sul progetto scelto, modificate le conclusioni dei 3 capitolati principali, corretti piccoli errori e ripetizioni."),
    ("0.3.0", "2026-10-19", BG, "Completata sezione 'altri capitolati valutati' con analisi dei capitolati C0, C2, C4, C5, C6, C7 e C9."),
    ("0.2.1", "2026-10-18", BG, "Aggiunti numeri indice e riferimenti incrociati per facilitare la navigazione del documento, iniziata sezione 'altri capitolati valutati' con titoli capitolati e sottotitoli delle sezioni."),
    ("0.2.0", "2026-10-18", BG, "Aggiunta sezione 'altri capitolati di interesse' con analisi dei capitolati C8 e C1."),
    ("0.1.0", "2026-10-17", BG, "Prima stesura del documento: introduzione e capitolato scelto."),
  ),
  indice: true,
)

= Introduzione
Nel presente documento viene esposta l’analisi dei capitolati d’appalto esaminati dal gruppo *ByteClub*, con l’obiettivo di individuare la proposta più adatta alle competenze, agli interessi e alle tempistiche del gruppo.
Il documento presenta in modo chiaro le motivazioni che ci hanno portato a scegliere il capitolato *C3 - FossDot*, proposto da Uranion, evidenziandone i punti di forza e i punti stimolanti per il gruppo.
Sono inoltre analizzate le altre due proposte che abbiamo preso in considerazione durante la fase di valutazione: il capitolato *C8 - Sonar* proposto da Halue e il capitolato *C1 - AURA* la cui azienda proponente è Vimar.
Per ciascuno di essi vengono esposti i principali punti di forza e di debolezza, così da argomentare in modo oggettivo la decisione finale di privilegiare FossDot come progetto di riferimento per il gruppo.
Il documento comprende inoltre una sintesi delle restanti proposte esaminate, riportandone le caratteristiche principali, i punti di forza e le criticità individuate durante la valutazione preliminare.

= Capitolato selezionato: C3 - FossDot
*Proponente*: Uranion EMEA Ltd.
== Descrizione
Il capitolato "C3 - FossDot" propone lo sviluppo di uno smart speaker open source, estensibile e rispettoso della privacy, che rappresenti un'alternativa ai dispositivi commerciali come Amazon Echo Dot e Google Nest.
L'obiettivo è realizzare un ecosistema completo, comprendente hardware, firmware, servizi backend e un'interfaccia di gestione, che consenta agli utenti di interagire vocalmente con modelli di intelligenza artificiale selezionabili liberamente. Il sistema dovrà supportare l'integrazione di servizi esterni attraverso protocolli standardizzati e permettere la comunicazione tra più dispositivi, evitando la dipendenza da un unico produttore o servizio cloud.
== Dominio
*Dominio tecnologico*: Il progetto si inserisce nell'ambito dei sistemi embedded, dell'intelligenza artificiale conversazionale e dello sviluppo di piattaforme open source. Nello specifico, lavoreremo con:
- *Sistemi Embedded e Firmware*: Il capitolato mette a disposizione una selezione di componenti hardware: una scheda di elaborazione, array di microfoni, altoparlanti e componente di feedback luminoso. Esiste la possibilità di cambiare i componenti scelti se si fornisce una buona motivazione. Sarà necessario sviluppare un firmware per gestire l'acquisizione audio, il riconoscimento della parola di attivazione (wake word) in locale sul dispositivoe la riproduzione delle risposte.
- *Speech-to-Text e Text-to-Speech*: Il sistema dovrà integrare tecnologie per la trascrizione del parlato in testo e per la sintesi vocale delle risposte, realizzando una pipeline di elaborazione audio che permetta l'interazione naturale con l'utente.
- *Large Language Models (LLM)*: Il servizio backend dovrà comunicare con modelli di intelligenza artificiale configurabili, sia attraverso provider cloud come OpenAI e Anthropic, sia mediante soluzioni locali come Ollama.
- *Model Context Protocol (MCP)*: L'integrazione di MCP permetterà all'assistente di utilizzare strumenti e servizi esterni, come sistemi domotici, calendari, servizi meteorologici e basi di conoscenza, estendendone le funzionalità attraverso Skills e Agents.
- *Architettura Client-Server e Comunicazione Multi-dispositivo*: Il progetto prevede un servizio centrale di bridging, responsabile della comunicazione tra dispositivi e provider AI, affiancato da un'interfaccia per la registrazione, la configurazione e il raggruppamento degli smart speaker.
- *Privacy e Software Open Source*: Il capitolato pone particolare attenzione alla protezione dei dati personali e alla possibilità di eseguire servizi localmente.

*Dominio applicativo*: Il progetto riguarda il settore degli assistenti vocali intelligenti e dei dispositivi connessi, con applicazioni in ambienti domestici, uffici e piccole imprese. La piattaforma è destinata a utenti che desiderano utilizzare un assistente vocale personalizzabile, mantenendo il controllo sui propri dati e sulle tecnologie impiegate. Attraverso FossDot sarà possibile formulare richieste vocali, ottenere risposte generate dall'intelligenza artificiale, utilizzare servizi esterni e coordinare più dispositivi distribuiti in ambienti differenti.
== Vincoli e requisiti
- L'intero progetto dovrà essere distribuito con una licenza open source permissiva, come MIT o Apache 2.0.
- Necessità di gestire i flussi audio nel pieno rispetto del GDPR, preferendo l'elaborazione Speech-to-Text dopo il rilevamento della wake word e Text-to-Speech in locale per evitare trasmissioni opache in cloud.
- Collaudo finale funzionante e dimostrabile su dispositivo hardware fisico.
== Valutazione fattibilità
=== Competenze disponibili
Buona base nei linguaggi orientati agli oggetti, conoscenza di sistemi Linux per la configurazione dei servizi, capacità di utilizzo dei sistemi di versionamento Git e familiarità con modelli LLM in locale tramite Ollama.
=== Competenze da acquisire (formazione)
Programmazione embedded e system-level, gestione dello streaming audio asincrono e dei protocolli di rete in tempo reale, e formazione lato hardware per la corretta configurazione dei sistemi embedded.
=== Stima tempi apprendimento
Si stima un periodo iniziale di circa due settimane per lo studio della documentazione hardware, la configurazione della pipeline audio e l’approfondimento dei framework asincroni necessari al servizio di bridging. Potrebbe inoltre essere necessaria un’ulteriore settimana per acquisire familiarità con il funzionamento dei sistemi embedded selezionati.
== Criticità riscontrate
- L'integrazione tra hardware e software può generare colli di bottiglia, allungando i tempi di setup e testing.
- L'apprendimento del linguaggio Rust (se scelto come tecnologia principale) può creare allungamenti eccessivi tenendo conto dei tempi a disposizione.
- La limitata esperienza del gruppo nella gestione dei componenti hardware potrebbe causare difficoltà durante la configurazione e il collaudo dei dispositivi, rallentando le attività di sviluppo.
- La progettazione in CAD di un'eventuale custodia per il dispositivo, completa di supporti, fori per viti e specifiche dimensionali, anche se non obbligatoria, richiede competenze specifiche che potrebbero non essere immediatamente disponibili nel gruppo, ma è apprezzata per un progetto completo.
== Motivazioni della scelta
Il capitolato FossDot presenta diversi elementi distintivi che lo rendono interessante dal punto di vista progettuale e formativo:
- *Sviluppo di un Prodotto Completo*: La possibilità di realizzare un sistema che comprende hardware, firmware, backend e interfaccia di gestione rappresenta un'occasione per comprendere l'intero ciclo di sviluppo di un prodotto tecnologico, affrontando problematiche differenti ma strettamente collegate.
- *Tecnologie Moderne e AI Conversazionale*: L'integrazione di modelli linguistici, sistemi di riconoscimento vocale e protocolli come MCP consente di approfondire tecnologie innovative, acquisendo competenze rilevanti nell'ambito dell'intelligenza artificiale applicata.
- *Attenzione alla Privacy e all'Open Source*: L'obiettivo di creare un'alternativa aperta ai dispositivi commerciali introduce tematiche importanti, come la protezione dei dati secondo il Regolamento Generale sulla Protezione dei Dati (GDPR), la trasparenza del software e l'indipendenza dai fornitori tecnologici.
- *Architettura Modulare ed Estensibile*: La separazione tra firmware, servizio di bridging, provider AI e interfaccia di gestione permette di affrontare concretamente i principi di modularità, manutenibilità e scalabilità del software.
- *Risultato Tangibile e Stimolante*: Oltre all'attualità dell'argomento, la possibilità di interagire con un dispositivo fisico funzionante rende il progetto particolarmente coinvolgente, consentendo di verificare direttamente il risultato del lavoro svolto e di osservare l'integrazione tra componenti hardware e software.
== Conclusioni
Il gruppo ByteClub ritiene che il capitolato "C3 - FossDot" rappresenti la proposta più adatta ai propri interessi e obiettivi formativi. Pur presentando alcune difficoltà legate all'integrazione tra hardware e software e alla necessità di acquisire nuove competenze, il progetto offre un equilibrio interessante tra complessità tecnica, libertà progettuale e opportunità di apprendimento.

La possibilità di intervenire sulle scelte tecnologiche e di realizzare un prototipo fisico funzionante costituisce un ulteriore elemento distintivo. Alla luce delle valutazioni effettuate, riteniamo che le criticità individuate siano affrontabili attraverso un'adeguata pianificazione e che il progetto rappresenti un'occasione significativa per consolidare le competenze del gruppo e acquisirne di nuove.
= Capitolati di interesse
== Capitolato C1 - AURA
*Proponente*: Vimar S.p.A.
=== Descrizione
Il capitolato Vimar AURA prevede la realizzazione di un sistema che consenta l'integrazione tra impianti domotici residenziali e servizi di intelligenza artificiale generativa. Attraverso l'utilizzo del protocollo MCP (Model Context Protocol), il sistema permetterà agli utenti di interagire con i dispositivi della propria abitazione mediante richieste in linguaggio naturale, sfruttando modelli AI esterni come ChatGPT, Claude o Gemini.
Il progetto richiede lo sviluppo di un'infrastruttura cloud-ready e di componenti MCP Server e Client, capaci di comunicare con le API KNX IoT messe a disposizione da Vimar, consentendo il monitoraggio e il controllo di luci, termostati, tapparelle e altri dispositivi intelligenti.
=== Dominio
*Dominio tecnologico*: integrazione di tecnologie moderne legate all'intelligenza artificiale e all'Internet of Things:
- *Model Context Protocol (MCP)*: per consentire la comunicazione standardizzata tra modelli AI e sistemi domotici;
- *KNX IoT 3rd-party API*: interfacce REST per l'accesso e il controllo dei dispositivi dell'impianto;
- *Large Language Models (LLM)*: per interpretare richieste in linguaggio naturale e trasformarle in operazioni sui dispositivi;
- *Containerizzazione e Infrastructure as Code (IaC)*: per realizzare un'infrastruttura cloud-ready, portabile e riproducibile;
- *Bluetooth Mesh*: tecnologia di comunicazione utilizzata dai dispositivi domotici Vimar View Wireless.
*Dominio applicativo*: Il progetto si inserisce nel settore della domotica residenziale e delle smart home. La piattaforma è destinata a utenti che desiderano controllare e monitorare i dispositivi della propria abitazione attraverso assistenti conversazionali, rendendo più naturale e flessibile l'interazione con l'impianto domestico.
=== Punti di forza
- *Attualità*: Il progetto affronta il tema dell'integrazione tra intelligenza artificiale generativa e dispositivi IoT, due ambiti tecnologici in forte evoluzione e di crescente interesse nel mercato.
- *Tecnologie innovative*: L'utilizzo di MCP, LLM e architetture cloud-ready offre l'opportunità di acquisire competenze su tecnologie moderne, applicandole a un caso d'uso concreto.
- *Architettura modulare*: La suddivisione del sistema in componenti distinti favorisce l'organizzazione del lavoro, la separazione delle responsabilità e l'applicazione dei principi di progettazione software.
- *Applicazione concreta*: La possibilità di interagire con dispositivi fisici permette di osservare direttamente il funzionamento del sistema sviluppato, rendendo il risultato tangibile e verificabile.
- *Supporto aziendale*: Vimar mette a disposizione un kit domotico View Wireless per effettuare test su dispositivi reali, offrendo un'importante opportunità di validazione della soluzione.
=== Criticità riscontrate
Nonostante l'interesse tecnologico del capitolato, abbiamo individuato alcune criticità che richiedono un'attenta valutazione:
- *Complessità dell'integrazione*: La comunicazione tra servizi AI, componenti MCP e API KNX IoT richiede il coordinamento di sistemi differenti. Eventuali problemi di compatibilità o comunicazione potrebbero rendere più impegnative le fasi di sviluppo e debugging.
- *Dipendenza da sistemi esterni*: Il funzionamento della soluzione dipende dall'interazione con modelli AI, servizi cloud e dispositivi domotici. Questa dipendenza potrebbe complicare le attività di testing e rendere necessario simulare alcune componenti del sistema.
- *Affidabilità e sicurezza dei comandi*: L'utilizzo di modelli linguistici per controllare dispositivi fisici richiede particolare attenzione alla corretta interpretazione delle richieste e alla validazione delle operazioni, per evitare comportamenti indesiderati.
- *Ampiezza delle competenze richieste*: Il progetto coinvolge ambiti differenti, tra cui infrastrutture cloud, protocolli di comunicazione, intelligenza artificiale e sistemi IoT. La necessità di approfondire contemporaneamente queste tecnologie potrebbe incidere sui tempi di apprendimento e sviluppo.
=== Conclusioni
Il capitolato C1 propone un progetto di notevole interesse tecnologico, in linea con l'evoluzione dell'intelligenza artificiale e dei sistemi domotici. La possibilità di integrare modelli linguistici con dispositivi reali rappresenta un'opportunità stimolante per approfondire tecnologie innovative e applicare concretamente i principi dell'ingegneria del software.
Tuttavia, l'integrazione tra numerosi sistemi esterni e la necessità di garantire un'interazione affidabile con dispositivi fisici introducono complessità che potrebbero incidere sulle tempistiche del progetto. Questi aspetti richiedono un'attenta pianificazione e una fase iniziale di approfondimento delle tecnologie coinvolte.
Nel complesso, riconosciamo il valore formativo e le potenzialità del capitolato, apprezzandone soprattutto l'applicazione concreta e l'utilizzo di standard aperti. Le criticità individuate rappresentano elementi da considerare nella valutazione della proposta, senza diminuirne l'interesse dal punto di vista tecnico e progettuale.
Pur riconoscendo il valore tecnologico e formativo della proposta, il gruppo ha ritenuto FossDot maggiormente in linea con i propri interessi, soprattutto per la possibilità di sviluppare un ecosistema completo e per la maggiore centralità della progettazione di un dispositivo autonomo.

== Capitolato C8 - Sonar
*Proponente*: Halue S.r.l.
=== Descrizione
Il capitolato Sonar prevede la realizzazione di una piattaforma web capace di analizzare automaticamente la struttura e le configurazioni dello store Shopify, generando una documentazione tecnica costantemente aggiornata.
Il sistema dovrà acquisire informazioni relative ad applicazioni installate, webhook, automazioni, campi personalizzati e codice dei temi, organizzandole in un modello a grafo che ne rappresenti le dipendenze. Attraverso un motore di analisi sarà inoltre possibile individuare componenti inutilizzati, configurazioni obsolete e potenziali criticità, facilitando le attività di manutenzione e gestione degli store e-commerce.
=== Dominio
*Dominio tecnologico*: si fonda su strumenti moderni per lo sviluppo web, la gestione dei dati e l'automazione dei processi:
- *Next.js e TypeScript*: per lo sviluppo dell'applicazione web, delle API e dell'interfaccia utente;
- *Shopify Admin GraphQL API*: per acquisire le informazioni relative alle configurazioni e alle risorse degli store;
- *Supabase e PostgreSQL*: per la persistenza dei dati, degli snapshot e delle relazioni tra le entità;
- *Vercel Workflows e Cron Jobs*: per l'orchestrazione di scansioni durevoli e l'esecuzione periodica delle analisi;
- *Analisi statica del codice*: per individuare riferimenti e dipendenze all'interno dei file dei temi Shopify;
- *GitHub e CI/CD*: per il versionamento, l'integrazione continua e l'automazione dei test.
L'architettura proposta separa le fasi di acquisizione, normalizzazione, analisi e presentazione dei dati. Il modello a grafo costituisce l'elemento centrale del sistema, permettendo di rappresentare le dipendenze tra componenti e di individuare eventuali anomalie attraverso regole deterministiche.

*Dominio applicativo*: Il progetto si inserisce nel settore dell'e-commerce e della manutenzione software, con particolare riferimento allo store Shopify. La piattaforma è destinata ad aziende e team di sviluppo che necessitano di strumenti automatizzati per documentare le configurazioni, individuare componenti obsoleti e comprendere le dipendenze presenti nei propri sistemi, riducendo i tempi necessari per attività di analisi, manutenzione e passaggio di consegne.
=== Punti di forza
- *Problema concreto*: Il progetto nasce da un'esigenza reale dell'azienda proponente, legata alla crescente complessità degli store e-commerce e alla difficoltà di mantenerne una documentazione tecnica aggiornata.
- *Tecnologie moderne*: L'utilizzo di Next.js, TypeScript, PostgreSQL e Vercel permette di lavorare con strumenti diffusi nel settore dello sviluppo web, acquisendo competenze direttamente spendibili nel mercato del lavoro.
- *Architettura chiara e modulare*: La separazione tra acquisizione, normalizzazione, analisi e presentazione favorisce una suddivisione efficace delle attività e consente di sviluppare componenti indipendenti e manutenibili.
- *Requisiti ben definiti*: Il capitolato presenta una descrizione dettagliata delle funzionalità richieste, dei deliverable e dei criteri di accettazione, agevolando la pianificazione e il monitoraggio del progetto.
- *Qualità del software*: L'attenzione rivolta ai test automatici, alla gestione degli errori e all'affidabilità delle scansioni offre l'opportunità di approfondire aspetti fondamentali dell'ingegneria del software.
- *Supporto aziendale*: La possibilità di confrontarsi con Halue durante lo sviluppo permette di ricevere riscontri sulle scelte progettuali e di lavorare su una soluzione potenzialmente utilizzabile in un contesto professionale.
=== Criticità riscontrate
Nonostante la chiarezza del capitolato e l'interesse applicativo, abbiamo individuato alcune sfide che potrebbero influire sulla complessità del progetto:
- *Dipendenza dall'ecosistema Shopify*: Il progetto è strettamente legato alle API e alle strutture dati di Shopify. Sarà quindi necessario acquisire una conoscenza approfondita della piattaforma, delle sue configurazioni e delle limitazioni imposte dalle interfacce disponibili.
- *Complessità dell'analisi delle dipendenze*: La ricostruzione delle relazioni tra applicazioni, webhook, campi personalizzati e codice dei temi richiede l'elaborazione di informazioni eterogenee e talvolta incomplete. Individuare componenti realmente inutilizzati senza produrre falsi positivi rappresenta una sfida significativa.
- *Vincoli tecnologici*: Il capitolato impone l'utilizzo di uno stack specifico, comprendente Next.js, Vercel, Supabase e TypeScript. Sebbene ciò favorisca la coerenza con l'infrastruttura aziendale, limita la libertà di scelta delle tecnologie e potrebbe richiedere un periodo iniziale di apprendimento.
- *Ampiezza dei requisiti*: Il numero elevato di funzionalità richieste, unito alla necessità di garantire scansioni affidabili, documentazione aggiornata e test approfonditi, potrebbe rendere impegnativa la realizzazione di un prodotto completo nei tempi previsti.
- *Preparazione dell'ambiente di test*: Halue non fornisce uno store già configurato né dati proprietari. Il gruppo dovrà quindi predisporre autonomamente uno store Shopify di sviluppo, popolandolo con configurazioni e anomalie sufficientemente rappresentative per validare il sistema.
=== Conclusioni
Il capitolato C8 propone un progetto di forte interesse applicativo, affrontando un problema concreto nel settore dell'e-commerce attraverso tecnologie moderne e metodologie di sviluppo strutturate. La possibilità di realizzare uno strumento capace di documentare automaticamente sistemi complessi e individuarne le criticità rappresenta un'occasione significativa per approfondire la progettazione di applicazioni web e l'analisi delle dipendenze software.
Tuttavia, un'attenta valutazione ha evidenziato alcune difficoltà, legate soprattutto alla complessità dell'ecosistema Shopify, alla ricostruzione delle relazioni tra componenti e all'elevato numero di requisiti da soddisfare. Anche i vincoli tecnologici imposti dall'azienda potrebbero incidere sulla fase iniziale del progetto, richiedendo un investimento significativo nell'apprendimento degli strumenti previsti.
Queste considerazioni rendono necessaria una pianificazione accurata delle attività e una definizione delle priorità, per evitare di compromettere la qualità del prodotto finale. Pur rappresentando una proposta formativamente valida, è stato considerato meno aderente agli interessi del gruppo rispetto a FossDot.

= Altri capitolati valutati
== Capitolato C0 - AIRA: AI Requests Automation
*Proponente*: SanMarco Informatica S.p.A.
=== Descrizione
Il capitolato propone lo sviluppo di AIRA, una piattaforma software basata sull'intelligenza artificiale per automatizzare la gestione delle richieste aziendali provenienti da canali eterogenei, come e-mail, messaggi, note vocali e documenti.
Il sistema dovrà utilizzare modelli linguistici, tecnologie OCR e strumenti di riconoscimento vocale per interpretare le informazioni ricevute, estrarre dati strutturati e identificare le azioni da eseguire. Le richieste elaborate saranno successivamente inoltrate ai sistemi gestionali aziendali, come ERP, CRM e portali B2B, attraverso API REST.
Il progetto prevede inoltre un'interfaccia amministrativa per la configurazione dei canali, la consultazione dei log e la gestione dei dati, con particolare attenzione alla modularità e alla sicurezza.
=== Punti di forza
- *Applicabilità concreta*: Il progetto affronta una problematica reale delle aziende, automatizzando attività ripetitive e migliorando l'efficienza dei processi operativi.
- *Integrazione dell'intelligenza artificiale*: L'impiego di LLM, OCR e tecnologie speech-to-text permette di approfondire applicazioni innovative dell'AI nell'elaborazione di informazioni multimodali.
- *Competenze spendibili*: L'utilizzo di tecnologie come Java, Spring Boot, Angular e API REST consente di acquisire conoscenze richieste nel settore dello sviluppo software aziendale.
- *Architettura modulare*: La separazione tra acquisizione, elaborazione e integrazione dei dati favorisce la suddivisione del lavoro e la futura estendibilità del sistema.
- *Supporto aziendale*: l'azienda proponente prevede l'affiancamento di figure professionali dedicate e l'adozione di una metodologia "_Agile_", garantendo assistenza tecnica e confronto durante lo sviluppo.
=== Criticità riscontrate
- *Complessità delle integrazioni*: La gestione di molteplici canali di ingresso e sistemi aziendali richiede un'attenta progettazione delle interfacce e dei meccanismi di comunicazione.
- *Affidabilità dell'elaborazione AI*: L'interpretazione automatica di messaggi informali, immagini e documenti potrebbe generare errori nell'estrazione dei dati, con conseguenze sulle operazioni eseguite.
- *Ampiezza tecnologica*: La combinazione di sviluppo web, backend, intelligenza artificiale e gestione dei dati richiede competenze diversificate e un considerevole impegno iniziale.
- *Sicurezza delle informazioni*: Il trattamento di dati aziendali provenienti da fonti differenti impone particolare attenzione alla separazione delle informazioni e alla prevenzione degli accessi non autorizzati.

== Capitolato C2 - Concierge
*Proponente*: Eggon - NEXUM.
=== Descrizione
Il capitolato propone lo sviluppo di un assistente conversazionale basato sull'intelligenza artificiale, integrabile nella piattaforma NEXUM, per semplificare l'accesso dei dipendenti alle informazioni e ai servizi aziendali.
Il progetto si concentra inizialmente sulla gestione di ferie e permessi, consentendo agli utenti di consultare regolamenti interni, ottenere istruzioni sull'utilizzo del gestionale, visualizzare i propri dati e registrare richieste attraverso un'interfaccia in linguaggio naturale. Il sistema dovrà integrare una base di conoscenza documentale, funzionalità di recupero dei dati tramite servizi applicativi e meccanismi di autorizzazione e conferma delle operazioni.
L'architettura dovrà garantire tracciabilità, sicurezza e possibilità di estensione futura ad altri processi aziendali.
=== Punti di forza
- *Applicabilità aziendale*: Il progetto affronta esigenze comuni nella gestione delle risorse umane, offrendo la possibilità di sviluppare uno strumento concretamente utilizzabile in ambito professionale.
- *Integrazione dell'intelligenza artificiale*: L'utilizzo di LLM e sistemi di recupero delle informazioni permette di acquisire competenze nella realizzazione di assistenti conversazionali collegati a dati e servizi aziendali.
- *Perimetro ben definito*: La scelta di limitare il prodotto iniziale alla gestione di ferie e permessi rende gli obiettivi più circoscritti e favorisce una pianificazione realistica delle attività.
- *Flessibilità tecnologica*: La possibilità di concordare lo stack tecnologico e utilizzare servizi simulati riduce i vincoli implementativi, lasciando spazio alle scelte progettuali del gruppo.
- *Supporto e collaborazione aziendale*: La disponibilità di documentazione, dati di prova e interfacce concordate con Eggon favorisce lo sviluppo e la validazione delle funzionalità richieste.
=== Criticità riscontrate
- *Complessità dell'integrazione*: Il collegamento tra assistente AI, base documentale e servizi applicativi richiede una gestione accurata del contesto e delle interazioni tra componenti.
- *Affidabilità delle risposte*: Il sistema deve distinguere correttamente regolamenti aziendali, istruzioni operative e dati personali, evitando risposte inesatte o non supportate dalle fonti.
- *Gestione delle autorizzazioni*: L'accesso a informazioni personali e l'esecuzione di operazioni richiedono controlli rigorosi per garantire sicurezza e isolamento dei dati tra utenti e aziende.
- *Dipendenza dalle specifiche aziendali*: La corretta implementazione delle funzionalità dipende dalla disponibilità e dalla definizione delle API, dei dati e delle regole operative della piattaforma NEXUM.
- *Complessità della validazione*: La necessità di verificare il comportamento conversazionale, la gestione delle ambiguità e la correttezza delle operazioni richiede un'attenta progettazione dei test.

== Capitolato C4 - GVSPV: Gestione Veicoli e Servizi Post-Vendita
*Proponente*: M31 S.r.l.
=== Descrizione
Il capitolato propone lo sviluppo di una piattaforma software distribuita per la gestione centralizzata delle informazioni relative ai veicoli e ai servizi post-vendita nel settore automobilistico. Il sistema dovrà consentire la collaborazione tra case automobilistiche, concessionarie, centri di assistenza e proprietari, attraverso interfacce e funzionalità differenziate in base al ruolo.
Le principali funzionalità comprendono la registrazione dei veicoli, la gestione delle vendite, la prenotazione delle manutenzioni, il monitoraggio delle campagne di richiamo e l'invio di notifiche. Il progetto prevede la realizzazione di un'architettura distribuita, con API, autenticazione e persistenza dei dati, suggerendo l'impiego di tecnologie moderne e microservizi.
=== Punti di forza
- *Dominio applicativo concreto*: Il progetto affronta problematiche reali del settore automotive, permettendo di sviluppare un prodotto con funzionalità facilmente comprensibili e casi d'uso ben identificabili.
- *Architettura distribuita*: La suddivisione in diversi livelli applicativi offre l'opportunità di acquisire competenze nella progettazione di sistemi distribuiti e architetture a microservizi.
- *Tecnologie moderne*: L'utilizzo di strumenti come TypeScript, Node.js, PostgreSQL e Kubernetes consente di approfondire tecnologie diffuse nel settore dello sviluppo software.
- *Suddivisione funzionale*: La presenza di diversi attori e moduli applicativi favorisce una distribuzione chiara delle responsabilità e delle attività tra i membri del gruppo.
- *Competenze spendibili*: L'esperienza permette di sviluppare conoscenze trasferibili ad altri contesti aziendali, soprattutto nella realizzazione di applicazioni web e sistemi gestionali.
=== Criticità riscontrate
- *Complessità architetturale*: La realizzazione di un sistema distribuito con molteplici componenti e ruoli richiede particolare attenzione all'integrazione, alla comunicazione tra servizi e alla gestione dei dati.
- *Ampiezza funzionale*: Le numerose funzionalità previste potrebbero comportare un carico di sviluppo elevato, rendendo necessaria un'attenta definizione delle priorità.
- *Innovazione limitata*: Il progetto si concentra prevalentemente su funzionalità gestionali consolidate, offrendo meno opportunità di sperimentazione rispetto a soluzioni basate su tecnologie emergenti.

== Capitolato C5 - RareCare Navigator
*Proponente*: Miriade S.r.l.
=== Descrizione
Il capitolato propone lo sviluppo di RareCare Navigator, una piattaforma digitale basata sull'intelligenza artificiale per supportare le famiglie e i professionisti coinvolti nella gestione delle malattie rare, con particolare riferimento alla Sindrome di Sanfilippo. Il sistema dovrà integrare un assistente conversazionale basato su LLM e architettura RAG, strumenti per la gestione di scadenze e percorsi assistenziali, un archivio documentale sicuro e funzionalità di coordinamento tra i diversi soggetti della rete di cura. Il progetto prevede un'architettura modulare e scalabile, progettata per essere estesa ad altre patologie, con particolare attenzione alla protezione dei dati sanitari, all'accessibilità e all'usabilità.
=== Punti di forza
- *Impatto sociale*: Il progetto affronta una problematica concreta e delicata, offrendo la possibilità di sviluppare una soluzione tecnologica con benefici diretti per famiglie e professionisti sanitari.
- *Intelligenza artificiale*: L'integrazione di LLM, architetture RAG e tecniche di elaborazione del linguaggio naturale permette di acquisire competenze in un settore tecnologico di grande attualità.
- *Architettura modulare*: La separazione tra funzionalità generali e moduli specifici per patologia favorisce la progettazione di un sistema estendibile e manutenibile.
- *Supporto aziendale e validazione*: La collaborazione prevista con l'associazione Sanfilippo Fighters offre l'opportunità di confrontarsi con esigenze reali e validare concretamente le funzionalità sviluppate.
- *Competenze trasversali*: Il progetto combina sviluppo software, cloud computing, sicurezza informatica, intelligenza artificiale e progettazione di interfacce accessibili.
=== Criticità riscontrate
- *Elevata complessità tecnica*: L'integrazione di componenti AI, architetture cloud, gestione documentale e sistemi di autorizzazione richiede competenze diversificate e un considerevole impegno progettuale.
- *Gestione di dati sensibili*: Il trattamento di informazioni sanitarie, anche relative a minori, impone requisiti rigorosi di sicurezza, riservatezza e conformità al GDPR.
- *Affidabilità delle risposte AI*: L'impiego di modelli linguistici in un contesto sanitario richiede particolare attenzione alla correttezza delle informazioni e alla prevenzione di risposte inesatte o di allucinazioni.
- *Ampiezza del dominio*: La comprensione dei percorsi assistenziali, delle procedure amministrative e delle esigenze degli utenti potrebbe richiedere un'importante fase iniziale di analisi.

== Capitolato C6 - SCSDF: Sistema AI di Caching Semantico e Dashboard FinOps
*Proponente*: VarGroup.
=== Descrizione
Il capitolato propone l'estensione del progetto open source LiteLLM attraverso lo sviluppo di due componenti principali: un sistema di caching semantico e una dashboard FinOps per il monitoraggio dei costi dell'intelligenza artificiale.
Il primo componente dovrà riconoscere richieste semanticamente equivalenti, utilizzando embedding e algoritmi di similarità, per riutilizzare risposte precedentemente generate e ridurre il numero di chiamate ai modelli linguistici. Il secondo componente dovrà consentire il monitoraggio dei consumi per utente, team e progetto, integrando funzionalità di gestione dei budget, notifiche e previsione della spesa.
Il sistema dovrà integrarsi con LiteLLM, garantendo modularità, isolamento dei dati e verifica automatizzata delle funzionalità.
=== Punti di forza
- *Applicazione concreta dell'AI*: Il progetto affronta problematiche reali legate all'utilizzo aziendale dei modelli linguistici, con particolare attenzione all'ottimizzazione delle prestazioni e dei costi.
- *Tecnologie innovative*: L'impiego di embedding, database vettoriali e algoritmi di ricerca per similarità permette di approfondire strumenti e metodologie attuali nel settore dell'intelligenza artificiale.
- *Obiettivi ben definiti*: La suddivisione in due componenti principali rende chiari i risultati attesi e facilita l'organizzazione delle attività di sviluppo.
- *Supporto aziendale strutturato*: l'azienda proponente prevede sessioni formative, incontri periodici, attività di design thinking e revisioni tecniche, offrendo un accompagnamento concreto durante il progetto.
- *Competenze spendibili*: Le conoscenze acquisite in ambito AI, backend, API, gestione dei dati e monitoraggio dei costi risultano applicabili in numerosi contesti professionali.
=== Criticità riscontrate
- *Dipendenza da LiteLLM*: La necessità di estendere un progetto open source esistente richiede una comprensione preliminare della sua architettura e dei meccanismi di integrazione.
- *Complessità del caching semantico*: La definizione delle soglie di similarità e delle strategie di invalidazione richiede un'attenta sperimentazione per evitare il riutilizzo di risposte non pertinenti.
- *Verifica delle prestazioni*: La valutazione dell'efficacia del sistema necessita di test rappresentativi per misurare correttamente risparmio economico, accuratezza e tempi di risposta.
- *Vincoli di qualità*: La copertura minima dei test del 70% e la necessità di distinguere le verifiche deterministiche da quelle probabilistiche richiedono un'attenta pianificazione delle attività di collaudo.

== Capitolato C7 - SmartDashboard
*Proponente*: Ergon Informatica S.r.l.
=== Descrizione
Il capitolato propone lo sviluppo di SmartDashboard, una piattaforma web di Business Intelligence che consenta agli utenti aziendali di analizzare autonomamente i dati provenienti dai sistemi gestionali.
Il progetto prevede la realizzazione di una pipeline per l'acquisizione, la trasformazione e l'organizzazione dei dati in un data warehouse, oltre a un'interfaccia interattiva per la creazione di dashboard personalizzate tramite funzionalità drag & drop.
L'elemento centrale è l'integrazione di un assistente basato sull'intelligenza artificiale, capace di generare visualizzazioni a partire da richieste in linguaggio naturale, individuare anomalie e fornire interpretazioni dei dati.
=== Punti di forza
- *Applicabilità aziendale*: Il progetto affronta esigenze diffuse nelle imprese, offrendo l'opportunità di sviluppare uno strumento concreto per l'analisi dei dati e il supporto alle decisioni.
- *Integrazione dell'intelligenza artificiale*: L'utilizzo di LLM per la generazione di visualizzazioni e l'interpretazione dei dati permette di approfondire applicazioni innovative dell'AI.
- *Flessibilità tecnologica*: Il capitolato lascia libertà nella scelta dei linguaggi, dei framework e delle soluzioni architetturali, favorendo l'autonomia progettuale del gruppo.
- *Architettura modulare*: La separazione tra acquisizione dei dati, data warehouse e applicazione web facilita la suddivisione del lavoro e la manutenzione del sistema.
- *Competenze trasversali*: Il progetto consente di acquisire esperienza in sviluppo web, database, elaborazione dei dati, Business Intelligence e intelligenza artificiale.
=== Criticità riscontrate
- *Ampiezza del progetto*: La realizzazione di un'intera piattaforma BI, dalla gestione dei dati fino alle funzionalità AI, comporta un carico di lavoro significativo.
- *Complessità della pipeline dati*: Le attività di estrazione, trasformazione e modellazione richiedono particolare attenzione alla qualità e alla coerenza delle informazioni.
- *Affidabilità dell'assistente AI*: La generazione automatica di grafici e interpretazioni potrebbe produrre risultati inesatti, rendendo necessari controlli sulla correttezza delle elaborazioni.
- *Gestione delle priorità*: Le numerose funzionalità previste richiedono un'attenta selezione dei requisiti fondamentali per garantire la realizzazione di un prodotto funzionante nei tempi disponibili.

== Capitolato C9 - SpecCheck
*Proponente*: Zucchetti S.p.A.
=== Descrizione
Il capitolato propone lo sviluppo di SpecCheck, un insieme di estensioni per lo strumento open source OpenCode, finalizzate alla verifica automatizzata della tracciabilità tra casi d'uso, requisiti software e codice sorgente.
Il sistema dovrà utilizzare modelli linguistici per analizzare la documentazione progettuale, confrontare le specifiche con le funzionalità implementate e individuare eventuali incongruenze o requisiti non soddisfatti.
Il progetto prevede la realizzazione di skill, tool e almeno un plugin per OpenCode, accompagnati da una dashboard per visualizzare i risultati delle verifiche. L'obiettivo è supportare il processo di sviluppo software, migliorando la qualità e la conformità del prodotto rispetto alle specifiche iniziali.
=== Punti di forza
- *Innovazione tecnologica*: Il progetto affronta una problematica emergente dell'ingegneria del software, legata alla verifica del codice prodotto mediante strumenti di intelligenza artificiale.
- *Applicazione concreta degli LLM*: L'utilizzo di modelli linguistici per l'analisi dei requisiti e del codice permette di approfondire tecniche innovative di automazione dei processi di sviluppo.
- *Competenze specialistiche*: Il progetto offre un'esperienza formativa nella gestione dei requisiti, nella tracciabilità e nella verifica della qualità del software.
- *Integrazione open source*: Lo sviluppo di estensioni per OpenCode consente di contribuire a un ecosistema tecnologico esistente, acquisendo competenze nella realizzazione di plugin e strumenti per sviluppatori.
- *Supporto aziendale*: l'azienda proponente prevede la possibilità di utilizzare modelli linguistici di diverse dimensioni, favorendo la sperimentazione e il confronto tra soluzioni alternative.
=== Criticità riscontrate
- *Elevata incertezza tecnica*: Il carattere esplorativo del progetto rende difficile prevedere l'effettiva capacità dei modelli linguistici di verificare correttamente la corrispondenza tra requisiti e codice.
- *Complessità concettuale*: La realizzazione richiede una conoscenza approfondita dei processi di ingegneria del software, della gestione dei requisiti e del funzionamento degli agenti AI.
- *Dipendenza da OpenCode*: La necessità di sviluppare estensioni per uno strumento esistente impone una fase preliminare di studio della sua architettura e dei meccanismi di integrazione.
- *Difficoltà di validazione*: La verifica dell'accuratezza dei risultati prodotti dagli LLM richiede la definizione di criteri di valutazione affidabili e casi di test rappresentativi.
- *Disponibilità dei dati di prova*: Il sistema necessita di progetti software corredati da casi d'uso, requisiti e codice coerenti, la cui preparazione potrebbe richiedere un ulteriore impegno.