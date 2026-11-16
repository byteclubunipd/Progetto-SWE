
#import "/docs/5_Templates/verbale.typ": verbale
#import "/docs/5_Templates/base.typ": tutti, BG, EH, MMI, MMO, RP, LS

#show: doc => verbale(
  titolo: "Verbale riunione",
  data: "2026-11-11",
  versione: false,
  autori: (EH,),
  mostraRegistro: false,
  redattore: EH,
  verificatore: LS,
  uso: "Interno",
  stato: "Da verificare",

  tipoRiunione: "Riunione interna",
  luogo: "Canale vocale Discord",
  oraInizio: "14:30",
  oraFine: "16:00",
  responsabile: RP,
  scriba: EH,
  partecipanti: (RP + " (Responsabile)", EH+ " (Amministratore)", BG + " (Analista)", MMI + " (Programmatore)", MMO + " (Progettista)"),
  assenti: (LS + " (Verificatrice)", ),

  ordineDelGiorno: (
    [Nomina responsabile primo sprint],
    [Assegnazione ruoli primo sprint.],
    [Fissaggio primo incontro con Ergon dopo l'aggiudicazione dell'appalto.],
    [Definizione obiettivi primo sprint.],
    [Definizione durata primo sprint.],
    [Creazione prima milestone e assegnazione issue.],
    [Definizione cadenza incontro interno.],
  ),

  discussione: (
    (
      id: 7,
      titolo: "Nomina responsabile",
      descrizione: [
        Nomina del responsabile per il primo sprint, doveri del responsabile:
        - Comunicazione esterna con proponente e professore.
        - Coordinamento del gruppo.
        - Pianifica sprint e scadenze.
        - Preparazione e presentazione diario di bordo del 2026-11-16.
      ],
      decisione: [
        Nominato #RP come rappresentante per il primo sprint.
      ],
    ),
    (
      id: 8,
      titolo: "Assegnazione ruoli",
      descrizione: [
        Assegnazione dei ruoli secondo preferenze, affinità, disponibilità personali. Questi ruoli sono definiti solo per il primo sprint, ma viene ritenuta la possibilità di mantenere lo stesso ruolo per sprint successivi se ritenuto necessario e proficuo per il proseguo del progetto.
      ],
      decisione: [
        - Amministratore: #EH.
        - Analista: #BG.
        - Programmatore: #MMI.
        - Progettista: #MMO.
        - Verificatrice: #LS.
      ],
    ),
    (
      id: 9,
      titolo: "Durata primo sprint",
      descrizione: [
        In base a quanto definito nel preventivo dei costi e degli impegni ogni sprint dovrebbe avere durata indicativa di due settimane. Per questo siccome l'incontro con la proponente è prevista in settimana, vengono contate due settimane dalla fine della settimana corrente.
      ],
      decisione: [
        - Inizio sprint: 2026-11-11 
        - Fine sprint: 2026-11-27
      ],
    ),    
    (
      id: 10,
      titolo: "Milestone e issue",
      descrizione: [
        Il numero di milestone deve essere ragionevole in modo da non averne solo una per revisione ma neanche troppe da spezzare il periodo in troppi micro-pezzetti. Anche le issue devono essere completabili in un periodo di tempo ragionevole e non eccessivo.
      ],
      decisione: [
        L'amministratore crea le milestone necessarie fino alla revisione RTB, per ogni milestone crea le relative issue e le assegna. Le scadenze vengono definite assieme al responsabile.
      ],
    ),
    (
      id: 11,
      titolo: "Obiettivi primo sprint",
      descrizione: [
        1. Aggiornare la repository Github con le nuove cartelle (RTB e PoC).
        2. Aggiornare workflow per la compilazione automatica dei nuovi documenti.
        3. Aggiornare vista web, riadattandola in base alla milestone del periodo.
        4. Creare file glossario.
        5. Iniziare stesura:
          - Analisi dei requisiti.
          - Norme di progetto.
          - Piano di progetto.
          - Piano di qualifica.
        6. Preparare incontro in presenza con l'azienda.
      ],
      decisione: [
        I vari obiettivi vengono relazionati alle varie azioni, assegnati in base al ruolo coperto da ogni componente.
      ],
    ),
    (
      id: 12,
      titolo: "Conteggio ore",
      descrizione: [
        Viene discusso il metodo da adottare per il conteggio delle ore dedicate al progetto da parte di ciascun componente. Si concorda sulla necessità di registrare in modo sistematico il tempo impiegato nelle diverse attività, così da poter monitorare l'effettivo impegno del gruppo e confrontarlo con le stime riportate nel "Preventivo dei Costi e degli Impegni".

        Il conteggio delle ore dovrà essere aggiornato dai singoli componenti e utilizzato come riferimento per valutare l'avanzamento delle attività, individuare eventuali scostamenti rispetto alla pianificazione iniziale e aggiornare, se necessario, le previsioni di impegno.
      ],
      decisione: [
        Ogni componente si impegna a registrare le ore effettivamente dedicate alle attività di progetto, mantenendo aggiornato il relativo conteggio secondo le modalità stabilite dal gruppo.
      ],
    ),
    (
      id: 13,
      titolo: "Incontro settimanale",
      descrizione: [
        Oltre all'incontro di allineamento bisettimanale con la proponente, il gruppo fissa un giorno della settimana con orario preciso per una riunione interna.
      ],
      decisione: [Incontro settimanale fissato ogni Venerdì alle 14.30 a partire dal 2026-11-20, tutti i componenti del gruppo si impegnano a rendersi disponibili e partecipare attivamente alle riunioni.],
    ),
  ),

  statoAzioni: (
    (
      [A1],
      [Completata],
      [Preparare terzo diario di bordo],
    ),
    (
      [A2],
      [Completata],
      [Inviare al professore i dubbi sulla prima candidatura],
    ),
    (
      [A3],
      [Completata],
      [Contattare la proponente Ergon C7 per avere una riunione],
    ),
    (
      [A4],
      [Completata],
      [Aggiornare i template per i verbali],
    ),
    (
      [A5],
      [Completata],
      [Aggiornare la vista web],
    ),
    (
      [A6],
      [Completata],
      [Riredigere preventivo costi e impegni],
    ),
    (
      [A7],
      [Completata],
      [Verificare preventivo costi e impegni],
    ),
    (
      [A8],
      [Completata],
      [Aggiornare la lettera di presentazione],
    )
  ),

  azioni: (
    (
      [A9],
      [Fissare incontro con Ergon],
      RP,
      [2026-11-11],
      [D7],
    ),
    (
      [A10],
      [Aggiornare repository github],
      EH,
      [2026-11-11],
      [D8, D11],
    ),
    (
      [A11],
      [Crezione milestone e relative issue],
      EH,
      [2026-11-12],
      [D8, D10],
    ),
    (
      [A12],
      [Aggiornare workflow],
      EH,
      [2026-12-12],
      [D8, D11],
    ),
    (
      [A13],
      [Allineare vista web],
      MMI,
      [2026-11-27],
      [D8, D11],
    ),
    (
      [A14],
      [Bozza Analisi dei requisiti],
      BG,
      [2026-11-27],
      [D8, D11],
    ),
    (
      [A15],
      [Bozza Norme di Progetto],
      EH,
      [2026-11-27],
      [D8, D11],
    ),
    (
      [A16],
      [Bozza Piano di Progetto],
      RP,
      [2026-11-27],
      [D7, D11],
    ),
    (
      [A17],
      [Bozza Piano di Qualifica],
      LS,
      [2026-11-27],
      [D8, D11],
    ),
    (
      [A18],
      [Redazione Glossario],
      BG,
      [2026-11-27],
      [D8, D11],
    )
  ),

  doc,
)