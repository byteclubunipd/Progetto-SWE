
#import "/docs/5_Templates/documento.typ": *

#let gruppo = "ByteClub"
// Macro per il Glossario (aggiunge la G all'apice)
#let glos(term) = [#term#super[G]]

#show: documento.with(
  titolo: "Analisi dei Requisiti",
  versione: "0.1.0",
  mostraInformazioni: true,
  mostraRegistro: true,
  stato: "Da Approvare",
  redazione: BG,
  verifica: "",
  approvazione: "",
  proprietario: gruppo,
  uso: "Esterno",
  destinatari: gruppo + "\nErgon Informatica S.r.l.\nProf. Vardanega Tullio \nProf. Cardin Riccardo",
  indice: true,
  registroModifiche: (
    ("0.1.0", "2026-11-12", "Prima stesura del documento", BG, "-"),
  ),
)

DA INSERIRE ELENCO IMMAGINI USATE
= Introduzione

== Scopo del documento
Il presente documento di "#glos[Analisi dei Requisiti]" definisce in modo formale, completo e strutturato i requisiti funzionali e non funzionali del sistema software *SmartDashboard*, da sviluppare nell'ambito del #glos[progetto] didattico del corso di Ingegneria del Software.
Descrive i casi d'uso principali del sistema, corredati da diagrammi #glos[UML] per visualizzare le interazioni tra attori e funzionalità.

Rappresenta il fondamento per le successive fasi di #glos[progettazione], implementazione, testing e #glos[validazione], garantendo l'allineamento del prodotto finale con le specifiche del #glos[proponente] *Ergon Informatica Srl* e con gli obiettivi delineati nel #glos[capitolato] C7.

I requisiti identificati sono classificati secondo le seguenti priorità:
- *Obbligatori*: essenziali per il funzionamento minimo del sistema e irrinunciabili per il #glos[proponente];
- *Desiderabili*: non critici, ma in grado di apportare un valore aggiunto significativo all'utente finale;
- *Opzionali*: implementabili in fasi successive o in estensioni future.

Il documento è redatto dal gruppo "*ByteClub*" ed è destinato a:
- il #glos[*Committente*] (Ergon Informatica Srl), per la #glos[verifica] della corretta interpretazione delle richieste;
- il #glos[*Team di Sviluppo*] come linea guida per la #glos[progettazione] architetturale e la codifica;
- il #glos[*Team di Verifica*] per la definizione delle #glos[strategie di test] e validazione.

Il documento è inoltre destinato ad altre figure professionali coinvolte nello #glos[sviluppo], quali Amministratori e #glos[Responsabili di Progetto], per consentire loro di acquisire una piena comprensione delle specifiche di Sistema.

== Prospettiva del prodotto
SmartDashboard si propone come una piattaforma intelligente e multimodale per la visualizzazione e l'analisi dei dati aziendali, permettendo agli utenti di monitorare le performance del business in tempo reale.

Il sistema è progettato secondo un'architettura modulare e scalabile, in grado di integrare modelli avanzati di #glos[intelligenza artificiale] (#glos[LLM]) e di adattarsi a volumi elevati di dati mantenendo fluidità nelle prestazioni.

== Funzioni del prodotto
Il sistema dovrà offrire le seguenti #glos[funzionalità] principali:
- requisiti obbligatori 1;
- requisiti obbligatori 2;
- requisiti obbligatori 3;

I requisiti obbligatori sono stati definiti in accordo con le indicazioni del #glos[proponente] e con quanto emerso dai colloqui preliminari.

== Caratteristiche dell'utente

== Glossario
Per tutti i termini tecnici, gli acronimi e le definizioni utilizzate nel documento si rimanda al #link("InserireLinkGlossario")[#glos[Glossario]], disponibile come documento separato.
Ogni parola presente nel #glos[Glossario] viene segnata come segue: \
#align(center)[#glos[termine]]
