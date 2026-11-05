
#import "/docs/5_Templates/verbale.typ": *

// Nomenclatura: VI_YYYY-MM-DD.typ oppure VE_YYYY-MM-DD.typ,
// senza versione nel nome.
// Salvare una copia in verbali/interni oppure verbali/esterni
// della fase.

// Modello compilabile: sostituire i segnaposto con i dati effettivi.

#show: verbale.with(
  // INFORMAZIONI GENERALI
  titolo: "Verbale Riunione",
  data: "2026-11-04",
  versione: "0.1.0",
  firma: false,
  daFirmare: true,

  // INFORMAZIONI SUL DOCUMENTO
  autori: (EH,),
  redattore: EH,
  verificatore: RP,
  uso: "Esterno",
  stato: "Da verificare",

  // DETTAGLI DELLA RIUNIONE
  tipoRiunione: "Esterna",
  luogo: "Google meet",
  oraInizio: "14.00",
  oraFine: "14.30",
  responsabile: LS,
  scriba: EH,
  partecipanti: (
    "Gianluca Carlesso (Ergon S.r.l)",
    ..tutti,
  ),
  assenti: (),

  // ORDINE DEL GIORNO
  ordineDelGiorno: (
    [Approfondimento dell'architettura del sistema],
    [Discussione delle tecnologie e degli strumenti consigliati],
    [Analisi delle funzionalità del layer AI],
    [Definizione dei requisiti minimi e delle funzionalità dell'MVP],
    [Definizione delle modalità di collaborazione con la proponente],
  ),

  // DISCUSSIONE E DECISIONI
  discussione: (
    (
      titolo: "Architettura del sistema",
      descrizione: [
        *Separazione dei database*: è preferibile mantenere distinti tre componenti:
        - Database relazionale per la gestione delle informazioni di funzionamento della piattaforma, come utenti, preferenze e configurazioni.
        - Data Warehouse per la memorizzazione dei dati aziendali destinati alle attività di Business Intelligence.
        - Data Raw Store per conservare una copia dei dati originari che hanno alimentato il Data Warehouse, permettendo di confrontarli con quelli trasformati o aggregati e facilitando l'individuazione di eventuali anomalie o errori.

        *Ruolo della Web App*: deve occuparsi principalmente della visualizzazione e rappresentazione dei dati, consentendo anche di eseguire interrogazioni sul Data Warehouse.

        *Progettazione del Data Warehouse*: dovrà basarsi su un modello dimensionale, utilizzando gli schemi a stella (Star Schema) o a fiocco di neve (Snowflake Schema). Il primo prevede una tabella dei fatti centrale collegata direttamente alle dimensioni, mentre il secondo permette anche collegamenti tra le dimensioni stesse.

        *Flessibilità del modello dimensionale*: è opportuno definire un pattern generale riutilizzabile per costruire le strutture del Data Warehouse, tenendo conto che le tabelle dovranno comunque essere adattate alle specifiche esigenze del business.

        *Supporto multi-database*: è consigliabile predisporre l'architettura affinché possa supportare in futuro diversi motori di database, senza necessariamente implementarli tutti fin dall'inizio.
      ],
      id: "1",
      decisione: none,
    ),
    (
      titolo: "Tecnologie da usare",
      descrizione: [
        *Database*: la proponente ha suggerito l'utilizzo di DuckDB, tecnologia che ritiene interessante per il progetto e che ha già sperimentato in ambito di ricerca e sviluppo. Ne ha evidenziato la semplicità di utilizzo, la sintassi simile a SQL e la presenza di una community open source. Il suo utilizzo non è comunque obbligatorio.

        *Intelligenza artificiale*: è consigliato utilizzare servizi LLM esterni, come quelli offerti da OpenAI e Google, attraverso le rispettive API, evitando di concentrarsi sull'esecuzione di modelli offline tramite strumenti come Ollama. Questi ultimi richiedono risorse hardware considerevoli, soprattutto RAM e GPU, e potrebbero sottrarre troppo tempo allo sviluppo.

        *Accesso ai servizi AI*: l'azienda metterà a disposizione le chiavi API e un credito precaricato per consentire al gruppo di utilizzare i servizi durante lo sviluppo.

        *Integrazione con il gestionale ERP*: non è previsto inizialmente un collegamento diretto al gestionale aziendale. La proponente fornirà un dataset di esempio, concordando con il gruppo il formato di esportazione più adatto alle esigenze implementative.
      ],
      id: none,
      decisione: none,
    ),
    (
      titolo: "Layer AI",
      descrizione: [
        *Affidabilità delle risposte*: non esiste un metodo che garantisca completamente la correttezza delle risposte generate da un LLM. È possibile utilizzare tecniche di prompt engineering e guardrail, fornendo istruzioni esplicite affinché il modello non inventi dati o informazioni e si limiti a utilizzare le fonti disponibili.

        *Verifica delle risposte*: sarà necessario predisporre una suite di test empirici, definendo richieste degli utenti e relative risposte attese, per valutare il comportamento e l'affidabilità del modello.

        *Tracciabilità e trasparenza*: è consigliabile chiedere all'LLM di indicare le tabelle consultate e i passaggi effettuati per elaborare una risposta. Secondo la proponente, fornire queste informazioni al modello tende a migliorare la precisione e a ridurre il rischio di allucinazioni. Non è tuttavia necessario mostrarle sempre all'utente finale: si potrebbe prevedere un dettaglio espandibile, simile a quello presente in ChatGPT o Claude.

        *Skills*: è consigliabile realizzare skills specifiche per migliorare le capacità dell'AI e guidarne le operazioni. Queste dovrebbero avere una dimensione equilibrata, essere sufficientemente dettagliate rispetto al proprio scopo e possibilmente organizzate in maniera modulare, consentendo anche a una skill di fare riferimento a un'altra.

        *Privacy e sicurezza*: all'AI devono essere fornite esclusivamente le informazioni strettamente necessarie per rispondere alla richiesta dell'utente, evitando di trasmettere credenziali o dati non pertinenti. Qualora debba accedere al database delle preferenze, è opportuno utilizzare un account dedicato con permessi limitati alle sole tabelle necessarie e autorizzazioni di sola lettura.
      ],
      id: none,
      decisione: none,
    ),
    (
      titolo: "Requisiti minimi e funzionalità aggiuntive",
      descrizione: [
        La proponente ha individuato quattro principali funzionalità, organizzate secondo una possibile evoluzione del prodotto:
        1. *Interrogazione dei dati tramite linguaggio naturale*: permette agli utenti di porre domande sui dati aziendali e ottenere risposte sotto forma di grafici o tabelle. È la funzionalità principale e indispensabile per l'MVP.
        2. *Generazione automatica di insight*: permette all'AI di individuare autonomamente anomalie, tendenze e informazioni rilevanti nei dati visualizzati, ad esempio evidenziando una diminuzione significativa del fatturato in una determinata regione. È una funzionalità interessante, eventualmente già inseribile nell'MVP.
        3. *Assistente per la creazione di dashboard*: consente agli utenti di creare dashboard in autonomia attraverso l'AI, che genera le query necessarie e aggiunge i relativi widget. È una funzionalità desiderabile, ma particolarmente complessa da implementare.
        4. *Spiegazione dei singoli indicatori*: permette agli utenti di richiedere approfondimenti sui singoli indicatori presenti nelle dashboard, fornendo all'AI le informazioni relative al dato selezionato. È considerata una funzionalità aggiuntiva desiderabile.
        \
        *Gestione degli utenti e dei permessi*

        La piattaforma dovrà prevedere tre tipologie di utenti:
        - *Utente utilizzatore finale*: può visualizzare le dashboard per cui possiede i permessi, consultare i dati ed effettuare richieste all'AI.
        - *Utente amministratore*: può creare nuove dashboard e assegnare agli utenti i relativi permessi di visualizzazione.
        - *Utente amministrativo di gestione*: può creare e gestire gli altri utenti, modificarne i ruoli, abilitare o disabilitare funzionalità e accedere alle impostazioni generali della piattaforma, comprese le configurazioni delle API degli LLM e gli eventuali limiti di utilizzo.
      ],
      id: none,
      decisione: none,
    ),
    (
      titolo: "Collaborazione con l'azienda",
      descrizione: [
        *Fornitura dei dati e supporto alla progettazione*: l'azienda metterà a disposizione un dataset di esempio, concordando con il gruppo il formato più conveniente. È inoltre prevista una collaborazione nella progettazione di almeno un caso d'uso concreto per il Data Warehouse, fornendo indicazioni sulle strutture dimensionali e sulle modalità di organizzazione dei dati.

        *Incontri e visite in azienda*: la proponente si è resa disponibile ad accogliere il gruppo presso la sede di Castelfranco Veneto, generalmente almeno una volta durante il progetto, per conoscere l'ambiente di lavoro e utilizzare una sala riunioni dedicata. Sono inoltre possibili ulteriori visite in base alle esigenze del gruppo, seppur con diserve complicazioni.

        *Riunioni periodiche e supporto*: è stato espresso l'obiettivo di organizzare incontri periodici con il gruppo, indipendentemente dalla presenza di argomenti specifici, per verificare l'avanzamento del progetto e individuare eventuali difficoltà. Per necessità aggiuntive, l'azienda è disponibile a organizzare incontri, anche online, generalmente entro due o tre giorni dalla richiesta.

        *Canali di comunicazione*: l'azienda è disponibile a utilizzare diversi strumenti di comunicazione, tra cui email, Whatsapp e Telegram, lasciando al gruppo la scelta delle modalità più comode.

        *Supporto alle tecnologie e ai servizi AI*: l'azienda fornirà le credenziali e il credito necessario per l'utilizzo delle API dei modelli linguistici, oltre a offrire indicazioni e suggerimenti sulle tecnologie da adottare.
      ],
      id: none,
      decisione: none,
    ),
  ),

  // STATO DELLE AZIONI PRECEDENTI
  // Lasciare vuoto se non ci sono azioni precedenti da aggiornare.

  // REGISTRO DELLE MODIFICHE
  registroModifiche: (
    (
      [0.1.0],
      [2026-11-05],
      [Prima stesura del verbale],
      EH,
      MMO,
    ),
  ),

  // AZIONI DA SVOLGERE
  azioni: (
    (
      [\#9], 
      [Inviare il verbale alla proponente per l'approvazione e la firma.], 
      LS,
      "2026-11-06",
      "-----"
    )
  )
  
)
