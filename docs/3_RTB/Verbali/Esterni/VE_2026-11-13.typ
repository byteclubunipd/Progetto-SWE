
#import "/docs/5_Templates/verbale.typ": *

// Nomenclatura: VI_YYYY-MM-DD.typ oppure VE_YYYY-MM-DD.typ,
// senza versione nel nome.
// Salvare una copia in verbali/interni oppure verbali/esterni
// della fase.

// Modello compilabile: sostituire i segnaposto con i dati effettivi.

#show: verbale.with(
  // INFORMAZIONI GENERALI
  titolo: "Verbale riunione",
  data: "2026-11-13",
  versione: false,
  firma: false,
  daFirmare: true,
  mostraRegistro: false,
  // INFORMAZIONI SUL DOCUMENTO
  autori: (RP,),
  redattore: RP,
  verificatore: LS,
  uso: "Esterno",
  stato: "Da approvare",

  // DETTAGLI DELLA RIUNIONE
  tipoRiunione: "Esterna",
  luogo: "Microsoft Teams",
  oraInizio: "11:00",
  oraFine: "11:30",
  responsabile: RP,
  scriba: RP,
  partecipanti: (
    "Gianluca Carlesso (Ergon S.r.l)",
    BG, EH, MMO, RP, 
  ),
  assenti: (MMI, LS),

  // ORDINE DEL GIORNO
  ordineDelGiorno: (
    [Definizione delle modalità di collaborazione e degli incontri periodici.],
    [Definizione del formato dei dati e delle modalità di rilascio.],
    [Chiarimenti sui requisiti relativi agli utenti, alla versione mobile e all'esportazione dei dati.],
    [Discussione delle tecnologie per il front-end e il back-end.],
    [Chiarimenti sulla documentazione e sulle risorse di riferimento.],
    [Discussione delle attività future e del possibile coinvolgimento di aziende target.],
  ),

  // DISCUSSIONE E DECISIONI
  discussione: (
    ( 
      id: 14,
      titolo: "Comunicazione rapida",
      descrizione: [
        È stato proposto di creare un gruppo WhatsApp come canale di messaggistica veloce tra ByteClub ed Ergon S.r.l.
      ],
      
      decisione: [È stata confermata la creazione di un gruppo WhatsApp come canale di messaggistica.],
    ),
    ( 
      id: 15,
      titolo: "Formato dei dati e chiavi API",
      descrizione: [
        È stato chiesto se esistessero preferenze riguardo al formato del set di dati da utilizzare. La proponente ha indicato che, in base alle esigenze, possono essere utilizzati database Access, file CSV o JSON e dump di SQL Server. Il gruppo ha segnalato di avere già esperienza nella gestione di file CSV tramite Python.

        È stato inoltre confermato che le chiavi API e i dati necessari verranno messi a disposizione per consentire al gruppo di iniziare le prove di integrazione.
      ],
      
      decisione: [Il formato CSV è considerato adeguato per le prime attività di sviluppo.],
    ),
    ( 
      id: 16,
      titolo: "Incontri periodici di avanzamento",
      descrizione: [
        Il gruppo ha proposto di organizzare gli incontri di SAL il venerdì, con cadenza bisettimanale. L'orario potrà essere concordato di volta in volta in base alle disponibilità.

        Gli incontri coincideranno indicativamente con la conclusione degli sprint e saranno utilizzati per presentare i progressi svolti e discutere gli eventuali dubbi emersi.

        Il primo sprint è iniziato il 2026-11-11 e terminerà il 2026-11-27; il successivo incontro di allineamento è pertanto previsto per il 2026-11-27.

      ],
      
      decisione: [Incontri di SAL si terranno indicativamente ogni due settimane, al termine degli sprint, preferibilmente il venerdì.],
    ),
    ( 
      id: 17,
      titolo: "Incontro esterno in presenza",
      descrizione: [
        È stata discussa la possibilità di organizzare un incontro in presenza presso la sede dell'azienda. Per facilitare il coordinamento delle disponibilità del gruppo, è stato proposto di fissarlo dopo il 2026-11-27.

        Il gruppo comunicherà alla proponente due giornate compatibili con le proprie disponibilità. Dovranno inoltre essere considerate le giornate di indisponibilità della proponente nel periodo natalizio, in particolare il 7 e il 31 dicembre.
      ],
      
      decisione: [L'incontro in presenza sarà organizzato, se possibile, dopo il 2026-11-27; il gruppo invierà due proposte di data.],
    ),
    ( 
      id: 18,
      titolo: "Chiarimenti per analisi dei requisiti",
      descrizione: [
        *Modalità di rilascio*: per la consegna del PoC e dell'MVP è stato chiesto se fosse preferibile un rilascio containerizzato, ad esempio tramite Docker, oppure la distribuzione su un'infrastruttura cloud.

        *Gestione degli utenti*: è stato chiesto se le tre tipologie di utenti già individuate dovessero essere implementate integralmente a partire dal PoC.

        *Versione mobile*: è stato chiesto se la versione mobile, indicata nel capitolato come auspicabile, dovesse essere considerata un requisito desiderabile oppure una funzionalità facoltativa da sviluppare in futuro.

        *Esportazione in Excel*: è stato chiesto se l'esportazione dei widget dovesse conservare le formule nelle celle oppure se fosse sufficiente un'esportazione visiva dei dati.

        *Front-end*: è stato chiesto se, oltre alle librerie di charting già individuate, fosse preferibile utilizzare una specifica libreria per i componenti dell'interfaccia, come Tailwind CSS, Material UI o Bootstrap.

        *Back-end*: è stato chiesto se fosse preferibile utilizzare un framework Python, come FastAPI o Flask, oppure tecnologie differenti come Node.js o Java.

      ],
      
      decisione: [
        1. Il rilascio dovrà essere preferibilmente containerizzato tramite Docker.
        2. Nel PoC sarà sufficiente implementare il ruolo di amministratore; la gestione completa delle tre tipologie di utenti sarà sviluppata nell'MVP.
        3. La versione mobile è considerata un requisito desiderabile. Il gruppo dovrà valutarne la fattibilità, mantenendo il focus principale sulla versione desktop e tablet, che risultano più adatte alla consultazione di dashboard e tabelle. La versione mobile sarà orientata soprattutto alla consultazione sintetica degli indicatori.
        4. Per l'esportazione dei widget in Excel è sufficiente una rappresentazione visiva; non è necessario conservare le formule nelle celle.
        5. Per i componenti dell'interfaccia non è previsto un vincolo specifico. Tailwind CSS è una soluzione diffusa, ma il gruppo potrà adottare la tecnologia con cui possiede maggiore esperienza.
        6. Per il back-end è consigliato l'utilizzo di Python, preferibilmente tramite FastAPI; non è necessario introdurre Java nel progetto.
      ],
    ), 
    ( 
      id: 19,
      titolo: "Chiarimenti su documentazione e fonti",
      descrizione: [
        È stato chiesto se la proponente potesse fornire documentazione specifica sulle tecnologie da utilizzare. La proponente ha indicato come riferimento principale la documentazione ufficiale disponibile online, rendendosi disponibile a condividere anche collegamenti mirati qualora fossero necessari.
      ],
      
      decisione: [Il gruppo utilizzerà principalmente la documentazione ufficiale delle tecnologie e richiederà eventuali riferimenti mirati in caso di necessità.],
    ),
    ( 
      id: none,
      titolo: "Possibile coinvolgimento di aziende target",
      descrizione: [
        Il gruppo ha chiesto se fosse possibile organizzare, in prospettiva, un confronto con una o più aziende potenzialmente interessate al prodotto, così da raccogliere un riscontro diretto sui requisiti più utili e sulle funzionalità da includere nell'MVP.

        La proponente valuterà la possibilità di individuare un'azienda target disponibile a fornire questo tipo di feedback.
      ],
      
      decisione: none,
    ),
    ( 
      id: none,
      titolo: "Pianificazione delle attività",
      descrizione: [
        Durante il primo sprint il gruppo si concentrerà sullo studio delle tecnologie, sulla consultazione della documentazione e sull'esecuzione di prove preliminari. In seguito alla ricezione delle chiavi API e dei dati, verranno avviate la configurazione del database e le prime prove di utilizzo dei servizi.

        È stato chiarito che il primo incontro di SAL potrebbe non includere una quantità significativa di materiale implementativo, poiché lo sprint iniziale è principalmente dedicato all'analisi e alla progettazione. La proponente ha confermato che questa fase è comunque rilevante ai fini del progetto.

        Il gruppo ha comunicato alla proponente che il PoC è indicativamente previsto tra dicembre 2026 e gennaio 2027, mentre il completamento dell'MVP è previsto indicativamente tra marzo e aprile 2027.
      ],
      
      decisione: none  ),

  ),

  // AZIONI DA SVOLGERE
  azioni: (
    (
      [\#18],
      [Creare il gruppo WhatsApp.],
      RP,
      "2026-11-14",
      "D14"
    ),
    (
      [\#19],
      [Creare e testare il database relazionale con i dati CSV tramite Python e testare le chiavi API tramite FastAPI fornite dall'azienda.],
      MMI,
      "2026-11-20",
      "D15, D18"
    ),
    (
      [\#20],
      [Organizzare l'incontro di SAL del 2026-11-27.],
      RP,
      "2026-11-27",
      "D16"
    ),
    (
      [\#21],
      [Fornire le date per l'incontro in presenza.],
      RP,
      "2026-11-20",
      "D17"
    ),
    (
      [\#22],
      [Aggiornare il documento dell'analisi dei requisiti.],
      BG,
      "2026-11-20",
      "D18"
    ),
    (
      [\#23],
      [Studiare la tecnologia Tailwind CSS e individuare eventuali alternative comuni al gruppo.],
      MMO,
      "2026-11-20",
      "D18"
    ),
    (
      [\#24],
      [Testare la tecnologia Tailwind CSS.],
      MMI,
      "2026-11-20",
      "D18"
    ),
    (
      [\#25],
      [Ricercare le fonti ufficiali per le tecnologie da utilizzare.],
      MMO,
      "2026-11-20",
      "D19"
    ),
    (
      [\#26], 
      [Inviare il verbale alla proponente per l'approvazione e la firma.], 
      RP,
      "2026-11-20",
      "-----"
    )
  )
  
)
