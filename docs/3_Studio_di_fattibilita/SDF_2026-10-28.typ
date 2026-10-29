#import "/docs/5_Templates/studio_di_fattibilita.typ": *

#show: studioDiFattibilita.with(
  data: "2026-10-28",
  autori: (MMI, LS),
  
  capitolatiScelti: (
    (
      nome: [C3 - FossDot],
      motivazione: [
        Il gruppo ByteClub ha selezionato il capitolato *C3 - FossDot*, proposto da Uranion EMEA Ltd., dopo aver confrontato le opportunità formative, la complessità tecnica e la fattibilità delle proposte esaminate. La scelta è motivata dai seguenti aspetti:

        - *Allineamento con le competenze disponibili:* il gruppo possiede una buona base nella programmazione orientata agli oggetti, nell'utilizzo di Git e nella configurazione di ambienti Linux. È inoltre presente una certa familiarità con i modelli linguistici eseguibili localmente tramite Ollama. Queste competenze costituiscono un punto di partenza per affrontare lo sviluppo del backend e l'integrazione dei servizi AI, pur rendendo necessario un approfondimento degli aspetti embedded e della gestione dell'audio.

        - *Interesse tecnico e professionale:* FossDot permette di lavorare con tecnologie attuali, tra cui modelli linguistici, riconoscimento e sintesi vocale, Model Context Protocol (MCP) e sistemi embedded. Il progetto offre quindi l'opportunità di approfondire l'intelligenza artificiale applicata, la progettazione di sistemi distribuiti e l'integrazione tra componenti software e hardware.

        - *Realizzazione di un prodotto completo:* il capitolato comprende hardware, firmware, servizi backend e interfaccia di gestione. Questa articolazione consente di affrontare diverse fasi del ciclo di sviluppo del software e di comprendere come componenti distinti possano collaborare all'interno di un unico sistema. La possibilità di realizzare e collaudare un dispositivo fisico funzionante rappresenta inoltre un risultato concreto e verificabile.

        - *Libertà progettuale e modularità:* la possibilità di motivare le scelte relative alle tecnologie e ai componenti hardware offre al gruppo margine per individuare soluzioni adeguate alle proprie competenze e ai vincoli temporali. La separazione tra firmware, backend, provider AI e interfaccia di gestione favorisce inoltre una suddivisione del lavoro in componenti e responsabilità distinte. La licenza open source permissiva prevista dal capitolato è un ulteriore elemento positivo.

        - *Rapporto con il proponente:* il confronto esplorativo con Uranion ha permesso di chiarire aspetti rilevanti del progetto, tra cui la configurabilità dei provider AI, il funzionamento della pipeline audio, la gestione degli aggiornamenti del dispositivo e le funzionalità minime richieste per la comunicazione tra più smart speaker. Il proponente ha inoltre manifestato disponibilità a fornire supporto tecnico, incontri di approfondimento e sessioni formative, contribuendo a ridurre l'incertezza iniziale.

        Nel complesso, il gruppo ritiene che FossDot presenti un rapporto equilibrato tra complessità, possibilità di apprendimento e libertà progettuale. Le competenze da acquisire rappresentano una sfida significativa, ma affrontabile mediante una pianificazione progressiva e una suddivisione chiara delle attività.
      ],
      mitigazione: [
        L'analisi di fattibilità ha evidenziato alcuni rischi tecnici e organizzativi che potrebbero incidere sulle tempistiche e sulla qualità del prodotto. Per limitarne gli effetti, il gruppo intende adottare le seguenti strategie:

        - *Integrazione tra hardware e software:* prima di sviluppare l'intero sistema, verranno configurati e verificati i componenti hardware selezionati, controllando progressivamente l'acquisizione audio, la riproduzione del suono e il funzionamento del dispositivo. Le prove iniziali consentiranno di individuare tempestivamente eventuali problemi di compatibilità o configurazione.

        - *Apprendimento delle tecnologie embedded e di sistema:* lo studio delle tecnologie necessarie sarà avviato nelle prime fasi del progetto. La scelta del linguaggio e degli strumenti sarà effettuata considerando i requisiti del capitolato, le competenze disponibili e il tempo necessario per acquisire familiarità con essi. L'eventuale utilizzo di Rust sarà valutato attentamente, evitando di introdurre complessità non necessarie.

        - *Complessità della pipeline audio:* il flusso di elaborazione vocale verrà implementato e verificato per fasi, distinguendo il rilevamento locale della wake word, la trascrizione del parlato, l'elaborazione della richiesta e la riproduzione della risposta. In caso di difficoltà nell'integrazione completa, i singoli componenti saranno testati separatamente e collegati progressivamente.

        - *Dipendenza da servizi e provider esterni:* l'accesso ai modelli AI e ai servizi di trascrizione sarà isolato dietro interfacce dedicate, così da facilitare la sostituzione di un provider in caso di indisponibilità, incompatibilità o limiti di utilizzo. Le prove saranno pianificate considerando anche i vincoli dei servizi selezionati e le risorse messe a disposizione dal proponente.

        - *Privacy e protezione dei dati:* il sistema dovrà rispettare i requisiti di riservatezza previsti dal capitolato e la normativa applicabile. Il rilevamento della wake word avverrà localmente sul dispositivo; l'invio dell'audio ai servizi di trascrizione sarà gestito in modo coerente con il comportamento previsto e con le scelte architetturali documentate. Saranno valutate attentamente le informazioni trasmesse ai provider esterni.

        - *Aggiornamenti e affidabilità del dispositivo:* saranno considerate soluzioni che riducano il rischio di corruzione del sistema in caso di spegnimento improvviso e che consentano aggiornamenti controllati. Le scelte implementative saranno verificate rispetto ai vincoli hardware e alle indicazioni del proponente.

        - *Rischi relativi a tempi e requisiti:* lo sviluppo sarà suddiviso in incrementi verificabili, dando priorità alle funzionalità minime richieste. Le funzionalità aggiuntive, come le integrazioni con prodotti di terze parti o le estensioni più avanzate, saranno pianificate solo dopo aver consolidato il funzionamento del nucleo essenziale del sistema.

        - *Difficoltà di coordinamento e integrazione:* i componenti saranno sviluppati con interfacce concordate e responsabilità definite. Il gruppo utilizzerà il versionamento del codice e test progressivi per individuare tempestivamente regressioni e incompatibilità. In caso di ritardi, le funzionalità non essenziali potranno essere rinviate, preservando gli obiettivi minimi del capitolato.
      ],
      formazione: [
        La formazione iniziale sarà orientata a colmare le lacune individuate nell'analisi di fattibilità, consolidando al contempo le competenze già disponibili. Le attività saranno organizzate in modo progressivo, in parallelo con la configurazione dell'ambiente di sviluppo e con i primi prototipi.

        - *Studio dell'hardware e dei sistemi embedded:* analisi della documentazione dei componenti selezionati, configurazione dell'ambiente di esecuzione e approfondimento delle modalità di comunicazione con microfoni, altoparlanti e componenti di feedback luminoso.

        - *Elaborazione audio:* studio dei meccanismi necessari per la gestione dello streaming audio asincrono, del rilevamento della wake word e dell'integrazione tra Speech-to-Text e Text-to-Speech. L'obiettivo iniziale sarà realizzare una pipeline minima funzionante e verificabile.

        - *Backend e comunicazione tra componenti:* approfondimento dei framework asincroni e dei protocolli di rete necessari per implementare il servizio di bridging e gestire le comunicazioni tra dispositivo, backend e servizi esterni.

        - *Integrazione dei modelli AI:* studio delle API e dei formati di comunicazione supportati dai provider selezionati, con particolare attenzione alla configurabilità dei modelli e alla gestione degli errori. Saranno inoltre approfondite le modalità di integrazione di MCP e delle relative Skills e Agents, in funzione delle priorità concordate.

        - *Affidabilità, test e aggiornamenti:* studio delle tecniche di verifica dei singoli componenti, della gestione degli errori e delle soluzioni utili a proteggere il dispositivo da interruzioni impreviste e aggiornamenti non riusciti.

        Il piano prevede una prima fase di circa due settimane dedicata allo studio della documentazione hardware, alla configurazione della pipeline audio e all'approfondimento dei framework asincroni necessari al servizio di bridging. Potrà essere necessaria un'ulteriore settimana per acquisire familiarità con i sistemi embedded selezionati. Queste stime costituiscono una previsione iniziale e saranno aggiornate sulla base dei risultati ottenuti.

        Il gruppo intende inoltre sfruttare gli incontri di approfondimento e le sessioni formative offerte da Uranion, utilizzandoli per chiarire i dubbi tecnici emersi durante lo sviluppo e verificare la correttezza delle scelte architetturali.
      ],
      impegno: [
        L'impegno previsto per la realizzazione del progetto è quello definito nel preventivo dei costi e degli impegni orari del gruppo ByteClub. La pianificazione considera un totale di *552 ore produttive*, corrispondenti a *92 ore per ciascuno dei sei componenti del gruppo*.

        Le ore saranno distribuite tra le attività di responsabilità e coordinamento, amministrazione, analisi, progettazione, programmazione e verifica, secondo la ripartizione riportata nel preventivo dedicato.

        L'impegno sarà articolato lungo l'intero ciclo di sviluppo: analisi e chiarimento dei requisiti, formazione preliminare, progettazione architetturale, implementazione dei componenti, integrazione hardware-software, verifica e collaudo finale. La ripartizione delle ore sarà monitorata durante il progetto e potrà essere aggiornata in funzione dell'avanzamento e delle criticità riscontrate, mantenendo gli obiettivi concordati e i vincoli del preventivo.
      ]
    ),
    (
      nome: [C8 - Sonar],
      motivazione: [
        Il gruppo ha selezionato il capitolato C8 - Sonar, proposto da Halue S.r.l. SB, valutando positivamente il dominio applicativo reale, l'architettura cloud-native e la chiarezza degli obiettivi. La scelta è motivata dai seguenti aspetti:

        - *Allineamento con le competenze:* Il gruppo possiede solide basi nello sviluppo web e nell'uso di database relazionali. Le tecnologie richieste (TypeScript, React/Next.js) sono in parte note, offrendo una base sicura su cui innestare l'apprendimento di concetti più complessi come l'orchestrazione durevole.
        - *Interesse tecnico e architetturale:* Il progetto affronta una sfida concreta e non banale: la costruzione di un grafo di dipendenze estraendo dati eterogenei (API e analisi statica del codice). L'uso di pattern come la durable execution (Vercel Workflows) è un forte incentivo professionale.
        - *Stack tecnologico moderno e definito:* L'obbligo di utilizzare l'ecosistema Vercel e Supabase riduce l'incertezza iniziale sulle scelte infrastrutturali, permettendo al gruppo di concentrarsi rapidamente sulla logica di business e sulle best practice di settore.
        - *Prodotto ad alto valore d'uso:* Il sistema genererà documentazione vivente e segnalerà "codice morto", risolvendo un problema reale delle agenzie e-commerce. L'obiettivo è chiaro, misurabile e altamente gratificante.
        - *Rapporto con il proponente:* Halue ha definito un capitolato molto dettagliato e si è resa disponibile per incontri quindicinali e supporto specialistico (su Shopify e architetture), garantendo un monitoraggio costante e costruttivo.

        Nel complesso, Sonar bilancia perfettamente la difficoltà tecnica (gestione limiti API, parsing di codice) con una curva di apprendimento gestibile, rendendolo un progetto sfidante ma assolutamente fattibile.
      ],
      mitigazione: [
        L'analisi del capitolato ha evidenziato rischi specifici legati all'integrazione con Shopify e ai limiti infrastrutturali. Il gruppo adotterà le seguenti strategie:

        - *Limiti delle API Shopify (Rate Limiting):* L'acquisizione dei dati è soggetta a limiti di frequenza stringenti. Si svilupperanno fin da subito test con richieste asincrone orchestrate (Vercel Workflows) per gestire le pause necessarie (sleep) senza far fallire il processo.
        - *Costi e limiti delle piattaforme:* Il piano gratuito di Vercel e Supabase impone vincoli su database, storage e AI. Il consumo delle risorse verrà misurato e monitorato costantemente fin dai primi sprint, discutendolo con Halue ad ogni incontro per evitare blocchi a ridosso della consegna.
        - *Complessità dell'analisi del codice (Tema/Liquid):* L'estrazione di dipendenze dai file di tema è complessa a causa di codice potenzialmente malformato. Lo sviluppo procederà per iterazioni: prima l'identificazione di pattern semplici e stringhe esatte, poi casi più complessi, isolando il parsing per evitare crash (Vercel Sandbox).
        - *Modellazione del database a grafo:* Tradurre dati eterogenei in un grafo unificato relazionale (PostgreSQL) può causare problemi di performance. Il database sarà progettato attentamente nelle fasi iniziali, validando le query di estrazione delle dipendenze sul Proof of Concept.
        - *Gestione del tempo e dello scope:* Per rispettare le scadenze, lo sviluppo si concentrerà rigorosamente sui Requisiti Funzionali Obbligatori (RFO). Funzionalità avanzate, come descrizioni generate da AI o importazioni esterne, saranno posticipate a nucleo stabilizzato.
        - *Sicurezza e multi-tenancy:* I dati trattati sono sensibili. La separazione tra organizzazioni verrà garantita delegando la sicurezza direttamente al database tramite Row Level Security (RLS) di Supabase, riducendo il rischio di bug applicativi.
      ],
      formazione: [
        La prima fase del progetto sarà dedicata a colmare i divari tecnologici e a padroneggiare il dominio Shopify, procedendo in parallelo con la stesura del Proof of Concept (PoC).

        - *Ecosistema Vercel e Supabase:* Studio di Next.js App Router, configurazione di Vercel Workflows per processi di lunga durata e approfondimento della Row Level Security in PostgreSQL.
        - *Shopify Admin GraphQL:* Apprendimento della struttura dati di Shopify (Metafield, Webhook, Temi), delle policy di Rate Limiting (modello a punti) e della creazione di custom app per l'autenticazione.
        - *Analisi statica e parsing:* Studio di librerie e tecniche in TypeScript per eseguire parsing sicuro (AST o regex avanzate) di file Liquid e JSON provenienti dal tema Shopify.
        - *Testing automatizzato:* Studio di Vitest, Playwright e MSW (Mock Service Worker) per simulare l'ambiente Shopify, essenziale per testare le scansioni senza consumare crediti API reali.

        Si prevede una fase di studio iniziale di circa due settimane, culminante nella realizzazione del PoC richiesto (connessione, scansione parziale e modello base su Supabase). La formazione continuerà poi on-demand durante le sprint, supportata dai feedback di Halue.
      ],
      impegno: [
        L'impegno previsto per la realizzazione del progetto è quello definito nel preventivo dei costi e degli impegni orari del gruppo. La pianificazione considera un totale di *552 ore produttive*, corrispondenti a *92 ore per ciascuno dei sei componenti del gruppo*.

        Le ore saranno distribuite tra le attività di responsabilità e coordinamento, amministrazione, analisi, progettazione, programmazione e verifica, secondo la ripartizione riportata nel preventivo dedicato.

        L'impegno sarà articolato lungo l'intero ciclo di sviluppo: analisi dei requisiti, formazione preliminare e RTB (Requirements and Technology Baseline), progettazione, implementazione iterativa del MVP, validazione e collaudo finale. La ripartizione oraria sarà costantemente monitorata ed eventualmente ricalibrata per rispettare i vincoli di budget e garantire la consegna dei requisiti obbligatori.
      ]
    )
  ),


  capitolatiScartati: (
    (
      nome: [C1 - AURA],
      motivazione: [
        *Proponente:* Vimar S.p.A.
        
        Il capitolato C1 - AURA prevede lo sviluppo di un sistema per integrare impianti domotici residenziali e servizi di intelligenza artificiale generativa. Attraverso MCP, API KNX IoT e modelli linguistici esterni, la soluzione dovrà consentire agli utenti di monitorare e controllare dispositivi domestici, come luci, termostati e tapparelle, mediante richieste in linguaggio naturale.

        Il gruppo ha riconosciuto diversi punti di forza nella proposta:
        - *Tecnologie innovative:* l'integrazione tra intelligenza artificiale, MCP e sistemi IoT offre un'importante opportunità di apprendimento.
        - *Applicazione concreta:* il progetto permette di verificare il funzionamento della soluzione su dispositivi fisici.
        - *Architettura modulare:* la suddivisione in componenti distinti favorisce la separazione delle responsabilità e la manutenibilità.
        - *Supporto del proponente:* la disponibilità di un kit domotico View Wireless consente di effettuare prove su dispositivi reali.

        La valutazione ha tuttavia evidenziato alcune criticità:
        - *Complessità dell'integrazione:* il coordinamento tra modelli AI, componenti MCP, API KNX IoT e dispositivi domotici richiede competenze eterogenee e un'attenta attività di debugging.
        - *Dipendenza da servizi esterni:* il funzionamento dipende dall'interazione con modelli linguistici, servizi cloud e dispositivi, con possibili difficoltà nelle attività di testing e nella gestione delle indisponibilità.
        - *Affidabilità e sicurezza:* l'utilizzo di modelli linguistici per generare comandi destinati a dispositivi fisici richiede controlli adeguati per evitare operazioni errate o comportamenti indesiderati.
        - *Ampiezza delle competenze richieste:* il progetto coinvolge infrastrutture cloud, protocolli di comunicazione, AI e IoT, rendendo necessario un investimento iniziale significativo nella formazione.

        AURA rappresenta quindi una proposta di elevato interesse tecnologico, ma la combinazione di sistemi differenti e la necessità di garantire interazioni affidabili con dispositivi domotici sono state considerate criticità rilevanti rispetto alle tempistiche e alle competenze da acquisire.

        Il gruppo ha preferito FossDot perché consente di concentrarsi sulla progettazione di un dispositivo autonomo e di un ecosistema software open source, mantenendo una maggiore libertà nelle scelte tecnologiche e affrontando comunque sfide significative nell'integrazione tra hardware, firmware e servizi AI.
      ]
    ),
  )
)
