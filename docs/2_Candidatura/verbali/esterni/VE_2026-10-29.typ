#import "/docs/5_Templates/verbale.typ": *

#show: verbale.with(
  titolo: "Verbale Riunione",
  data: "29 ottobre 2026",
  versione: false,
  firma: true,
  autori: (RP,),
  tipoRiunione: "Esterna con proponente",
  luogo: "Google Meet",
  oraInizio: "16:00",
  oraFine: "16:30",
  responsabile: BG,
  scriba: RP,
  partecipanti: (BG, MMI, MMO, RP, LS, "Valentino Baraldo (Halue)",),
  ordineDelGiorno: (
    "Conoscere l'azienda Halue (C8).",
    "Ricevere risposte riguardo ad alcune domande sul capitolato C8."
  ),
  diario: (
    [#v(1em)Dopo una veloce presentazione abbiamo posto le nostre domande che sono riportate qua sotto: ],
    [
      #v(1em)
      *Tecnologie e architettura*

      + *Domanda:* Come possiamo rilevare le informazioni che le API di Shopify non rendono visibili? Basta segnalare il fatto che non possiamo accedervi o creare false informazioni?

        *Risposta:* Il set di API dà accesso a tanti dati quindi bisogna scremare e decidere quali API usare. Ci sono pochissimi dati che non possono essere recuperati via API, ad esempio quelli ottenuti via GUI. Se siamo in uno di quei casi si può ammorbidire il requisito.

      + *Domanda:* Durante il progetto è possibile avere un esempio di documentazione tecnica che considerate adeguata per un passaggio di consegne?

        *Risposta:* Tutti i documenti prodotti durante il progetto di SWE sono più che sufficienti. Per altri documenti prodotti, come quelli prodotti dal tool, si può definire assieme come e con quale struttura vengono creati, dato che l'obiettivo è creare una documentazione vivente del sito.

      + *Domanda:* Ci sono già delle regole per attribuire i livelli di confidenza alle dipendenze oppure dobbiamo definirle autonomamente?

        *Risposta:* Non ci sono delle regole, è importante che si distinguano le politiche dai meccanismi. Il software crea dei meccanismi e voi decidete le politiche con cui si attivano. Esempio: c'è un attributo in un metafield che può essere popolato o meno in diversi prodotti, secondo una politica il tool mostra un alert che avvisa che il campo non è popolato. In base ad una threshold si può supporre che il campo sia orfano.

      + *Domanda:* Quale modalità di autenticazione delle custom app Shopify dobbiamo implementare? Il requisito RFO-01 prevede che l'utente inserisca dominio dello store e token di accesso. Considerando che Shopify ha cambiato la procedura di creazione delle custom app dal gennaio 2026, dobbiamo prevedere l'utilizzo della nuova Dev Dashboard e la relativa gestione delle credenziali, oppure un flusso di autenticazione diverso da quello descritto?

        *Risposta:* È meglio usare la nuova tecnologia perché Shopify viene aggiornato spesso e quindi i metodi vengono deprecati velocemente. Questa funzione è limitata al fatto che dovete creare un'app esterna che usa le API di Shopify con lo store di test.

      + *Domanda:* Dobbiamo creare uno store di test e dobbiamo popolarlo noi?

        *Risposta:* Sì, lo store dovete farlo voi tramite Shopify. Con Claude e il protocollo MCP si possono generare e iniettare molti dati direttamente nel sito.

      + *Domanda:* Per le politiche di cui ha parlato, per caso ha delle documentazioni di architettura su cui possiamo già basarci?

        *Risposta:* No, però posso fornirvi i materiali e le spiegazioni necessarie.
    ]
  ),
  todo: (("Tutto il gruppo", "Analizzare le risposte della proponente."),
         (RP, "Redigere il verbale del 29/10/2026.")),
)
