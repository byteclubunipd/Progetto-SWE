
#import "/docs/5_Templates/verbale.typ": verbale
#import "/docs/5_Templates/base.typ": tutti, BG, EH, MMI, MMO, RP, LS

#show: doc => verbale(
  titolo: "Verbale riunione",
  data: "2026-11-20",
  versione: false,
  autori: (EH,),
  mostraRegistro: false,
  redattore: EH,
  verificatore: LS,
  uso: "Interno",
  stato: "Approvato",

  tipoRiunione: "Riunione interna",
  luogo: "Canale vocale Discord",
  oraInizio: "14:30",
  oraFine: "16:00",
  responsabile: RP,
  scriba: EH,
  partecipanti: (RP + " (Responsabile)", EH + " (Amministratore)", BG + " (Analista)", MMI + " (Programmatore)", MMO + " (Progettista)", ),
  assenti: (LS + " (Verificatrice)", ),

  ordineDelGiorno: (
    [Allineamento situazione primo sprint],
    [Creazione nuova visione project board],
    [Aggiornamento parametri issue],
    [Sistema di conteggio ore],
    [Definizione delle modalità di utilizzo delle chiavi API],
    [Modalità di popolamento e utilizzo del Glossario]
  ),

  discussione: (
    (
      id: 20,
      titolo: "Situazione primo sprint",
      descrizione: [
        Riunione interna a metà del primo sprint, con analisi e condivisione della situazione:
        - Il ritardo di consegna delle chiavi API e dei dataset di test da parte dell'azienda proponente ha rallentato i progressi per la fase di test e studio delle tecnologie.
        - L'indisponibilità di un componente del gruppo per la sua partecipazione a eventi all'estero per rappresentare l'ateneo ha rallentato la progressione del progetto, specialmente nelle fasi di verifica.
        - Buona parte delle attività sono in attesa di revisione proprio a causa del punto menzionato sopra.
        - La redazione delle bozze dei vari documenti è completa ma in attesa di verifiche sostanziali.
      ],
      decisione: none,
    ),
    (
      id: 21,
      titolo: "Nuova visione project board",
      descrizione: [
        Per garantire una vista temporale delle attività (programmate, in corso, in revisione e concluse), si opta per una vista simile a un diagramma di Gantt.
        Questo permette anche di esportare in massa i dati relativi alle issue e avere una panoramica migliore del tempo impiegato per ogni fase di ogni singola attività.
      ],
      decisione: "Ogni componente si impegna a tenere ordinata la board, inserendovi i dati necessari e di aggiornarla ogni qualvolta sia necessario."
    ),
    (
      id: 22,
      titolo: "Aggiornamento parametri issue",
      descrizione: [
        Oltre ai parametri di default delle issue, quali: Assegnatario, Etichette e Milestone.
        Vengono aggiunti altri parametri utili, attraverso la project board, al fine del monitoraggio dell'andamento del progetto e il conteggio delle ore utilizzate:
        - Ruolo (viene inserito per ogni issue il ruolo con cui l'attività è svolta),
        - Data inizio (la data di inizio del completamento della issue, non la data della creazione),
        - Data fine (la data di fine della issue, compresa la revisione, normalmente con anche chiusura della PR),
        - Priorità (Critica, Alta, Media, Bassa),
        - Ore impiegate (alla chiusura della issue si inserisce le ore impiegate al fine del monitoraggio),
        - Sviluppo (la PR che chiude la issue).
      ],
      decisione: "Ogni membro si impegna a inserire ogni parametro richiesto alla chiusura di una issue, in modo da tenere sempre sotto controllo l'andamento del progetto e il tempo impiegato.",
    ),
    (
      id: 23,
      titolo: "Sistema conteggio ore",
      descrizione: [
        Viene creato un foglio excel condiviso a tutti i membri del gruppo che viene usato per aggiornare il Piano di progetto di volta in volta, il foglio excel si aggiorna con i dati esportati dalla project board. In questo modo vengono tenute conto le ore usate da ogni ruolo e le rispettive ore rimanenti.
      ],
      decisione: "Alla fine di ogni sprint verrà fatto un aggiornamento del conteggio del monte ore e se ne terrà conto per l'inizio dello sprint successivo."
    ),
    (
      id: 24,
      titolo: "Modalità di uso delle chiavi API",
      descrizione: [
        Dopo il primo incontro la proponente ci ha fornito due chiavi API, una per OpenAI e una per Anthropic, queste verranno utilizzate per lo sviluppo del PoC e anche del prodotto finale. Per utilizzarle ogni componente dovrà creare un file .env che contenga queste chiavi, siccome sono informazioni riservate il file .env non deve essere pubblicato nella repository, per tenere traccia di dove inserire il file viene creato un placeholder ".env.example" che *non* contiene e *non* deve contenere le effettive chiavi ma solo un template. \
        Per utilizzare le chiavi nel workflow quando necessario vengono utilizzati i *Github Action secrets*, molto versatili da questo punto di vista e facili da implementare.
      ],
      decisione: "Ogni membro si impegna a usare le chiavi API lo stretto necessario e a non condividerle o renderle pubbliche in alcun modo.",
    ),
    (
      id: 25,
      titolo: "Popolamento e utilizzo del Glossario",
      descrizione: [
        Una volta che il glossario viene pubblicato nel sito web e ha un link bisogna evidenziare tutti i termini da glossario per qualsiasi documento, ciò è fattibile attraverso una macro che assegna la marcatura ad ogni istanza di un termine da glossario. Inoltre tramite l'utilizzo di un plugin di typst si può linkare direttamente il termine alla rispettiva definizione all'interno del glossario. Tutto ciò ha bisogno però di un aggiornamento dei template.
      ],
      decisione: "Ogni file che viene redatto deve evidenziare i termini da glossario e riportare alla sua definizione, inoltre il Glossario deve essere continuamente aggiornato inserendo qualsiasi nuovo termine necessario."
    )
  ),

  statoAzioni: (
    (
      [A9],
      [Completata],
      [Fissare incontro con Ergon],
    ),
    (
      [A10],
      [Completata],
      [Aggiornare repository github],
    ),
    (
      [A11],
      [Completata],
      [Creazione milestone e relative issue],
    ),
    (
      [A12],
      [Completata],
      [Aggiornare workflow],
    ),
    (
      [A13],
      [In revisione],
      [Allineare vista web],
    ),
    (
      [A14],
      [In revisione],
      [Bozza Analisi dei requisiti],
    ),
    (
      [A15],
      [In corso],
      [Bozza Norme di Progetto],
    ),
    (
      [A16],
      [In corso],
      [Bozza Piano di Progetto],
    ),
    (
      [A17],
      [In corso],
      [Bozza Piano di Qualifica],
    ),
    (
      [A18],
      [In revisione],
      [Redazione Glossario],
    ),
    (
      [A19],
      [Completata],
      [Creare il gruppo WhatsApp],
    ),
    (
      [A20],
      [In corso],
      [Creare e testare il database relazionale con i dati CSV tramite Python e testare le chiavi API tramite FastAPI fornite dall'azienda],
    ),
    (
      [A21],
      [Completata],
      [Organizzare l'incontro di SAL del 2026-11-27],
    ),
    (
      [A22],
      [Completata],
      [Fornire le date per l'incontro in presenza],
    ),
    (
      [A23],
      [Completata],
      [Aggiornare il documento dell'analisi dei requisiti],
    ),
    (
      [A24],
      [In corso],
      [Studiare la tecnologia Tailwind CSS e individuare eventuali alternative comuni al gruppo],
    ),
    (
      [A25],
      [In corso],
      [Testare la tecnologia Tailwind CSS],
    ),
    (
      [A26],
      [In corso],
      [Ricercare le fonti ufficiali per le tecnologie da utilizzare],
    ),
    (
      [A27],
      [Completata],
      [Inviare il verbale esterno del 2026-11-13 alla proponente per l'approvazione e la firma], 
    )
  ),

  azioni: (
    (
      [A28],
      [Preparare diario di bordo del 2026-11-23],
      RP,
      [2026-11-22],
      [---],
    ),
    (
      [A29],
      [Redigere verbale interno del 2026-11-20],
      EH,
      [2026-11-22],
      [---],
    ),
    (
      [A30],
      [Evidenziare termini da glossario nel Piano di Progetto],
      RP,
      [2026-11-27],
      [D25]
    ),
    (
      [A31],
      [Evidenziare termini da glossario nelle Norme di Progetto],
      EH,
      [2026-11-27],
      [D25]
    ),
    (
      [A32],
      [Evidenziare termini da glossario nell'Analisi dei requisiti],
      BG,
      [2026-11-27],
      [D25]
    ),
    (
      [A33],
      [Aggiornare i template in modo da supportare i termini da glossario],
      BG,
      [2026-11-27],
      [D25]
    ),
    (
      [A34],
      [Inserire il file .env.example come placeholder per il file delle chiavi API],
      EH,
      [2026-11-27],
      [D24]
    )
  ),

  doc,
)
