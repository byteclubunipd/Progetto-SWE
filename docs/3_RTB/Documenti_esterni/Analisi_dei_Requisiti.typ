
#import "/docs/5_Templates/documento.typ": *

#let gruppo = "ByteClub"
// Macro per il Glossario (aggiunge la G all'apice)
#let glos(term) = [#term#super[G]]

#show: documento.with(
  titolo: "Analisi dei Requisiti",
  versione: "0.1.1",
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
    ("0.1.1", "2026-11-13", "Aggiunte funzioni del prodotto", BG, "-"),
    ("0.1.0", "2026-11-12", "Prima stesura del documento", BG, "-"),
  ),
)

DA INSERIRE ELENCO IMMAGINI USATE
= Introduzione
== Glossario
Per tutti i termini tecnici, gli acronimi e le definizioni utilizzate nel documento si rimanda al #link("InserireLinkGlossario")[#underline[#glos[Glossario]]], disponibile come documento separato.
Ogni parola presente nel #glos[Glossario] viene segnata come segue: \
#align(center)[#glos[termine]]
== Scopo del documento
Il presente documento di "#glos[Analisi dei Requisiti]" definisce in modo formale, completo e strutturato i requisiti funzionali e non funzionali del sistema software *SmartDashboard*, da sviluppare nell'ambito del #glos[progetto] didattico del corso di Ingegneria del Software.
Descrive i casi d'uso principali del sistema, corredati da diagrammi #glos[UML] per visualizzare le interazioni tra attori e funzionalità.

Rappresenta il fondamento per le successive fasi di #glos[progettazione], implementazione, testing e #glos[validazione], garantendo l'allineamento del prodotto finale con le specifiche del #glos[proponente] *Ergon Informatica Srl* e con gli obiettivi delineati nel #glos[capitolato] C7.

I requisiti identificati sono classificati secondo le seguenti priorità:
- *Obbligatori*: essenziali per il funzionamento minimo del sistema e irrinunciabili per il #glos[proponente];
- *Desiderabili*: non critici, ma in grado di apportare un valore aggiunto significativo all'utente finale;
- *Opzionali*: implementabili in fasi successive o in estensioni future.

Il documento è redatto dal gruppo "*ByteClub*" ed è destinato a:
- il #glos[*Committente*] (Ergon Informatica S.r.l.), per la #glos[verifica] della corretta interpretazione delle richieste;
- il *Team di #glos[Sviluppo]* come linea guida per la #glos[progettazione] architetturale e la codifica;
- il *Team di #glos[Verifica]* per la definizione delle #glos[strategie di test] e validazione.

Il documento è inoltre destinato ad altre figure professionali coinvolte nello #glos[sviluppo], quali Amministratori e #glos[Responsabili di Progetto], per consentire loro di acquisire una piena comprensione delle specifiche di Sistema.

== Prospettiva del prodotto
SmartDashboard si propone come una piattaforma intelligente e multimodale per la visualizzazione e l'analisi dei dati aziendali, permettendo agli utenti di monitorare le performance del business in tempo reale.

Il sistema è progettato secondo un'architettura modulare e scalabile, in grado di integrare modelli avanzati di #glos[intelligenza artificiale] (#glos[LLM]) e di adattarsi a volumi elevati di dati mantenendo fluidità nelle prestazioni.

== Funzioni del prodotto
Il sistema dovrà offrire le seguenti #glos[funzionalità] principali:
- *Costuzione self-service delle #glos[dashboard]*: l'utente potrà creare e personalizzare le proprie #glos[dashboard] in modo intuitivo tramite un'interfaccia #glos[drag & drop], selezionando e ridimensionando i #glos[widget] secondo le proprie esigenze. Avrá inoltre la possibilità di salvare le #glos[dashboard] per un utilizzo futuro;
- *Librerie di #glos[widget]*: il sistema fornirà una vasta gamma di #glos[widget] predefiniti:
  - Grafici (a barre, a torta e a linee);
  - Tabelle (normali e #glos[pivot]);
  - Mappe geografiche; 
  - #glos[Schede KPI];
  - #glos[Indicatori a quadrante] (#glos[gauge]);
- *Filtraggio e ordinamento*: il sistema dovrà consentire agli utenti di filtrare e ordinare i dati visualizzati nelle #glos[dashboard], facilitando l'analisi e la comprensione delle informazioni.
- *Personalizzazione e usabilità*: sono previsti temi chiaro/scuro, un'#glos[interfaccia responsive] e tempi di caricamento dei dati contenuti.
- *Esportazione dei dati*: il sistema dovrà consentire l'esportazione dei dati visualizzati in formati standard (#glos[PDF], #glos[Excel]) per la condivisione.
- *Gestione utenti e persistenza*: il sistema dovrà supportare la gestione degli utenti, con #glos[autenticazione] e #glos[autorizzazione] basata su ruoli, e garantire la persistenza dei dati attraverso un #glos[database] sicuro e affidabile. Le configurazioni delle #glos[dashboard] e le preferenze degli utenti sono salvate lato #glos[server] e associate al singolo utente.
- *Assistente AI*: il sistema dovrà integrare un assistente virtuale basato su modelli di #glos[LLM] per affiancare gli utenti nella creazione delle dashboard, nella comprensione dei dati e nell'ottimizzazione delle analisi.

I requisiti obbligatori sono stati definiti in accordo con le indicazioni del #glos[proponente] e con quanto emerso dai colloqui preliminari.

== Caratteristiche dell'utente


