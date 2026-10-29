#import "/docs/5_Templates/verbale.typ": *

#show: verbale.with(
  titolo: "Verbale Riunione",
  data: "21 ottobre 2026",
  versione: false,
  firma: false,
  autori: (EH,),
  tipoRiunione: "Esterna con proponente",
  luogo: "Google Meet",
  oraInizio: "14:30",
  oraFine: "15:30",
  responsabile: RP,
  scriba: EH,
  partecipanti: (..tutti, "Giacomo Cariello (Uranion)", "Niccolò Campana (Uranion)", "Componenti di altri gruppi di progetto"),
  ordineDelGiorno: (
    "Conoscere l'azienda Uranion (C3).",
    "Ricevere risposte riguardo ad alcune domande sul capitolato C3."
  ),
  diario: (
    [#v(1em)Dopo una veloce presentazione abbiamo posto le nostre domande che sono riportate qua sotto: ],
    [
      #v(1em)
      *Tecnologie e architettura*

      + *Domanda:* Qualora l’utente non disponga di un abbonamento al servizio LLM, quale modello si utilizzerà di base? Si sceglie un modello con piano base gratuito, quindi con interazioni limitate, o si utilizzerà un modello locale proprietario?

        *Risposta:* Di base l'idea è di offrire la possibilità di supportare i protocolli di comunicazione che sono standard de-facto: OpenAI Responses API, Anthropic Messages, possibilmente con dei preset affinché funzionino correttamente con i player più noti SaaS e on-premise (a parte gli ovvii OpenAI e Anthropic, considererei OpenRouter, Ollama, Z.AI, etc.). Alcuni dei provider supportati hanno dei free tier su alcuni modelli che sono sufficientemente generosi da permettere un uso sporadico.  

      + *Domanda:* Quali sono i requisiti e le aspettative in materia di tutela della privacy dell’utente? In particolare, come dovrebbe essere progettato il sistema affinché l’audio venga elaborato esclusivamente per il rilevamento della wake word, evitando l’acquisizione e l’elaborazione delle conversazioni ambientali prima della sua rilevazione?

        *Risposta:* Ci aspettiamo che il riconoscimento della wake word sia processato in locale sul dispositivo e solo in caso di riconoscimento della wakeword, il buffer contenente il discorso venga inviato. Tutto il resto si può fare benissimo online.

      + *Domanda:* Le opzioni di scelta dell'hardware sono vincolanti o possiamo ricercare noi altre possibili combinazioni di hardware che ci sembrano adatte al progetto?

        *Risposta:* La lista di proposte hardware non sono vincolanti ma possono essere un ottimo punto di partenza da cui prendere spunto per decidere i pezzi hardaware specifici, ovviamente la lista che vi abbiamo proposta non è sicuro completa al 100%. Quindi ogni combinazione di componenti hardware è per accetta purché ben motivata.

      + *Domanda:* Cosa si intende per estendere il dispositivo oltre l'ecosistema di skill che il produttore decide di supportare? Potreste fare un esempio concreto di una skill e di un agent che vorreste vedere? Chi crea le skill, l'utente oppure ci accordiamo noi?

        *Risposta:* Ci aspettiamo che ci sia uno standard per creare delle nuove skill in modo tale che l'utente tipo, che sia un po' "smanettone", si mette lì crea la sua skill quando vede che tra quelle disponibili non ci sono. Ovviamente per provare che il prodotto funzioni una o due skill dovrete crearle.
      
      + *Domanda:* Tra le skill che il prodotto può avere ci può essere anche la possibilità di comunicare con dispositivi di altre tipologie, tipo Google Home, oppure queste funzionalità sarebbero da bloccare per perseguire l'acquisto di un numero maggiore di dispositvi nostri?

        *Risposta:* Mi verrebbe da dire che in queste situazioni la scelta di Google Home sarebbe esattamente di non permetterlo, quindi noi che vogliamo essere diversi diremmo che ci piace l'interoperabilità, lo scopo di fare una cosa open-source è proprio quello di non vincolare l'utente alle nostre scelte tecnologiche, premesso che l'obiettivo principale di questo prodotto per ora non è guadagnarci.
      
      + *Domanda:* Se scegliamo un hardware che possiede un sistema operativo tipo Linux o Android è accettato o per forza dobbiamo creare un filmware embedded con Rust?

        *Risposta:* Sì va bene non per forza dovrete creare un sistema completo con Rust dalla A alla Z, potete fare anche solo l'applicativo. Anzi se avete delle motivazioni forti potete usare anche altre tecnologie, la nostra era solo una proposta che ci piace e che supportenemo più facilmente.
      
      + *Domanda:* Per quanto riguarda l'interconnessione tra più dispositivi, ai fini del progetto, è sufficiente far comunicare due dispositivi FossDot tra di loro?

        *Risposta:* Il minimo indispensabile per il progetto sarebbe che un FossDot invia un messaggio e l'altro lo riceve, l'ideale sarebbe riuscire a poter fare una chiamata in tempo reale tra i due dispositivi, in modo da verificare l'effettivo funzionamento dell'interconnessione. Se oltre a questo riuscite a implementare prodotti terzi smart è valore aggiunto.

      + *Domanda:* Quali sono i requisiti per l'accettazione di un progetto CAD per il primo prototipo di scatola che conterrà l'hardware?

        *Risposta:* Quello che ci servirebbe di base sono le dimensioni della scatola e come ci si monta il prodotto, se ci sono delle viti questi devono essere misurati e riportati. In modo tale da avere un contenitore adatto e che supporti a pieno l'hardware.
    ],
    [
      #v(1em)
      *Organizzazione del lavoro*

      + *Domanda:* Come scritto nella presentazione l'azienda è nata a Londra e ha una sede a Roma, vi era una sede a Padova o nei dintorni dove noi possiamo trovarci per fare degli incontri formativi o semplicemente lavorare tra di noi?

        *Risposta:* Stiamo progettando una sede a Piove di Sacco ma al momento non è ancora operativa, comunque se servono degli incontri in presenza per chiarimenti o tech dive possiamo sempre sfruttare gli spazi offerti dall'università o anche cercarli in zona.
    ],
  ),
  todo: (("Tutto il gruppo", "Analizzare le risposte della proponente."),
         (EH, "Redigere il verbale del 21/10/2026.")),
)
