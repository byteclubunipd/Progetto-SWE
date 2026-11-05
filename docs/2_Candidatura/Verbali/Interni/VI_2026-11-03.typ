
#import "/docs/5_Templates/verbale.typ": verbale
#import "/docs/5_Templates/base.typ": tutti, BG, EH, MMI, MMO, RP, LS

#show: doc => verbale(
  titolo: "Verbale di riunione interna",
  data: "2026-11-03",
  versione: "0.1.0",
  autori: (EH,),

  redattore: EH,
  verificatore: BG,
  uso: "Interno",
  stato: "Da verificare",

  tipoRiunione: "Riunione interna",
  luogo: "canale vocale Discord",
  oraInizio: "14:30",
  oraFine: "16:00",
  responsabile: LS,
  scriba: EH,
  partecipanti: tutti,
  assenti: (),

  ordineDelGiorno: (    
    [Nomina responsabile per periodo pre-candidatura.],
    [Errori prima candidatura.],
    [Nuovo capitolato a cui candidarsi.],
    [Aggiornamento vista web],
    [Aggiornamento template verbali.],
    [Ridefinizione sistema di versionamento.],
    [Dichiarazione degli impegni e scadenza di consegna.],
    [Data finale seconda candidatura.],
  ),

  registroModifiche: (
    (
      [0.1.0],
      [2026-11-03],
      [Stesura del verbale],
      [Elico Huang],
      [Riccardo Pontello],
    ),
  ),

  discussione: (
    (
      id: 1,
      titolo: "Nomina responsabile",
      descrizione: [
        Dopo il fallimento della prima candidatura è emersa la necessità di nominare un responsabile per la comunicazione esterna al gruppo, l'approvazione dei documenti e la presentazione del diario di bordo del 2026-11-09.
      ],
      decisione: [
        Nominata #LS come rappresentante per il periodo prima della seconda candidatura.
      ],
    ),
    (
      id: 2,
      titolo: "Dubbi sulla prima candidatura",
      descrizione: [
        A seguito di un'aperta discussione sono emersi diversi dubbi sugli errori commessi durante la prima candidatura:
          - Con l'espressione 'non ragionevole la modalità "uno-tutti" nella lavorazione del prodotto' intende dire che determinati nostri documenti sono stati prodotti dalla stessa persona e poi approvati da "Tutto il gruppo"?
          - A seguito delle correzioni degli errori segnalati è necessario scrivere un documento assestante che descriva i cambiamenti effettuati o è sufficiente un verbale in cui sono presenti le decisioni prese dal gruppo? 
          - Le correzioni degli errori sono retroattive per i documenti già presenti? Se è così, i verbali esterni firmati dalle aziende devono essere rifatti e mandati nuovamente alle relative proponenti? 
      ],
      decisione: [
        Il responsabile presenta queste domande al professore per ricevere chiarimenti e reindirizzare tutto il gruppo verso una candidatura di qualità.
      ],
    ),
    (
      id: 3,
      titolo: "Scelta nuovo capitolato",
      descrizione: [
        Siccome il capitolato C3 ha esaurito i posti, siamo costretti a cambiare capitolato.
      ],
      decisione: [
        Viene scelto il capitolato C7, dopo una discussione con altri gruppi per evitare, preferibilmente, altra competizione.
      ],
    ),
    (
      id: 4,
      titolo: "Aggiornamento elementi prima candidatura",
      descrizione: [
        Dalla prima candidatura si cerca di salvare quel poco che è stato fatto correttamente e aggiornare il necessario affinché la seconda candidatura abbia successo.
      ],
      decisione: [
        Vengono nominati due incaricati: uno per aggiornare la vista web e un altro per aggiornare i template dei verbali. I due incaricati sono coloro che hanno già lavorato in anticipo nel rispettivo ambito per limitare i tempi di ambientamento e studio del lavoro già fatto.
      ],
    ),
    (
      id: 5,
      titolo: "Ridefinizione sistema di versionamento",
      descrizione: [
        Dagli errori emerge che ogni modifica a un documento necesssita di una verifica e solo dopo questa il documento può venir approvato verso l'esterno.
      ],
      decisione: [
        Qualsiasi modifica a un documento deve venire verificata, per la nomenclatura dei file si mantiene la stessa della prima candidatura, siccome non sono stati segnalati errori.
      ]
    ),
    (
      id: 6,
      titolo: "Documento degli impegni",
      descrizione: [
        Dalla prima candidatura sono emersi diverse lacula sulla comprensione di questo documento, sui temi da esso trattati e sui contenuti necessari.
      ],
      decisione: [
        La sua redazione viene affidata a due persone diverse da coloro che hanno fatto la prima versione, questi due incaricati devono tenere conto degli errori passati e delle necessità tecniche e temporali che emergeranno dal nuovo capitolato.
      ]
    ),
    (
      id: 7,
      titolo: "Data seconda candidatura",
      descrizione: [
        Per quanto riguarda la data di candidatura dobbiamo darci abbastanza tempo per sistemare tutte gli errori e riredigere i documenti richiesto, ma neanché troppo per arrivare in troppo tardi alla candidatura e di conseguenza rimanere indietro.
      ],
      decisione: [
        Tutto il gruppo ha deciso come data di candidatura il 2026-11-08, prima del terzo diario di bordo.
      ],
    ),
  ),

  azioni: (
    (
      [\#1],
      [Preparare terzo diario di bordo],
      LS,
      [2026-11-09],
      [D1],
    ),
    (
      [\#2],
      [Inviare al professore i dubbi sulla prima candidatura],
      LS,
      [2026-11-03],
      [D2],
    ),
    (
      [\#3],
      [Contattare la proponente Ergon C7 per avere una riunione],
      LS,
      [2026-11-03],
      [D3],
    ),
    (
      [\#4],
      [Aggiornare i template per i verbali],
      EH,
      [2026-11-04],
      [D4],
    ),
    (
      [\#5],
      [Aggiornare la vista web],
      MMI,
      [2026-11-07],
      [D4],
    ),
    (
      [\#6],
      [Riredigere preventivo costi e impegni],
      RP,
      [2026-11-07],
      [D6]
    ),
    (
      [\#7],
      [Verificare preventivo costi e impegni],
      MMO,
      [2026-11-07],
      [D6],
    )
  ),

  doc,
)