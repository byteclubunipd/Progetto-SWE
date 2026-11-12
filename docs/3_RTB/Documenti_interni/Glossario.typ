#import "/docs/5_Templates/documento.typ": *

#let gruppo = "ByteClub"

#show: documento.with(
  titolo: "Glossario",
  versione: "0.1.0",
  mostraInformazioni: true,
  mostraRegistro: true,
  stato: "Da Approvare",
  redazione: BG,
  verifica: "",
  approvazione: "",
  proprietario: gruppo,
  uso: "Interno",
  destinatari: gruppo,
  indice: true,
  registroModifiche: (
    ("0.1.0", "2026-11-12", "Prima stesura del documento", BG, "-"),
  ),
)

// Centratura e rimozione della numerazione automatica dei titoli di livello 1
#set heading(numbering: none)
#show heading.where(level: 1): set align(center)
// Rimozione titoli di livello 2 dall'indice
#show heading.where(level: 2): set heading(outlined: false)




= Introduzione
Il documento definisce in modo univoco i termini adottati all’interno del progetto, così da evitare interpretazioni personali o variazioni di significato. Le definizioni sono presentate in ordine alfabetico per rendere la consultazione diretta e stabile nel tempo. Quando un termine compare nei documenti con un significato vincolato dal Glossario, viene segnalato con la notazione:
#align(center)[termine#super[G]]
#pagebreak()
= A
== Analisi dei Requisiti
Documento contenente i Casi d’Uso identificati da un gruppo per i requisiti di un determinato progetto. Contiene anche i Requisiti funzionali, Requisiti di Qualità e Requisiti di Vincolo.
== Agile
In informatica, Agile è un approccio di lavoro basato su iterazioni brevi e frequenti feedback. Nel metodo Scrum, uno dei più diffusi, il lavoro viene suddiviso in Sprint di una o due settimane. Ogni Sprint inizia con una Sprint Planning, in cui si definiscono gli obiettivi, e si conclude con una Sprint Retrospective, in cui il gruppo valuta cosa è andato bene e cosa migliorare.
== Amministratore
L’Amministratore si occupa della configurazione e gestione dell’infrastruttura IT di supporto a un progetto.
== Analista
Si occupa di identificare e chiarire i requisiti, interpretando le esigenze degli utilizzatori finali per garantire una corretta definizione delle funzionalità.
== API
Acronimo di Application Programming Interface, è un’interfaccia utile a permettere o facilitare la comunicazione tra diversi software o parti di un singolo software.
== Attore
Un’entità esterna e non controllabile dal progetto, ma che interagisce con esso, con attività o obiettivi specifici da soddisfare.
== Azione
L’insieme di processi intrapresi per mettere in pratica una determinata Decisione.

#pagebreak()
= B
== Backend
La parte di un progetto che si occupa del funzionamento a livello logico del sistema.
== Base di dati
Traduzione italiana del termine Database, per la definizione vedere ‘Database’.

#pagebreak()
= C
== Capitolato
Documento fornito dalla proponente, che espone le principali specifiche e condizioni di un progetto. Stabilisce delle regole e delle aspettative che il fornitore deve rispettare.
== Caso d’uso
Insieme di azioni all’interno di uno scenario, con in comune uno scopo finale per un Attore.
== Committente
Persona, ente o azienda che richiede e finanzia la realizzazione di un progetto software, di un sistema informatico o di un servizio IT. Il committente definisce gli obiettivi, approva i requisiti e verifica i risultati, ma non esegue direttamente lo sviluppo.

#pagebreak()
= D
== Database
Un database (in italiano: base di dati) è un sistema per la conservazione e gestione dei dati. Comprende una componente fisica, che è il supporto di memorizzazione dei dati, e una componente software, detta DBMS (Database Management System), che gestisce l’accesso ai dati, ne garantisce la persistenza e fornisce un metodo sicuro ed efficiente per leggerli e modificarli.
== DB
Acronimo di Database, per la definizione vedere ‘Database’.
== Decisione
Un accordo all’interno del gruppo, riguardante metodologie o convenzioni da adottare per soddisfare un determinato bisogno.
== Design Pattern
Soluzione progettuale riutilizzabile a problemi comuni nella progettazione del software, utile per migliorare struttura e manutenibilità del codice.
== Discord
Piattaforma di videochiamate e messaggistica asincrona. È caratterizzata dalla possibilità di creare spazi indipendenti chiamati server, all’interno dei quali è possibile istituire vari canali testuali (tipicamente suddivisi per argomento) e canali vocali indipendenti, utilizzati per chiamate di gruppo tra i membri del server.

#pagebreak()
= E
== Efficacia
Indica il modo con cui un insieme di attività raggiunge gli obiettivi attesi.
== Efficienza
Rapporto tra risultati ottenuti e risorse impiegate per ottenerli.

#pagebreak()
= F
== Frontend
La parte di un progetto che si occupa dell’interazione diretta con l’utilizzatore finale.
== Funzionalità
Una caratteristica offerta da un Sistema, spesso con lo scopo di soddisfare un bisogno.

#pagebreak()
= G
== Git
Sistema di controllo di versione che traccia le modifiche al codice sorgente nel tempo. Permette a più sviluppatori di collaborare simultaneamente sullo stesso progetto, gestendo la cronologia delle versioni e supportando lo sviluppo parallelo.
== GitFlow
Modello che sfrutta i branch di Git definendo una struttura organizzata per la gestione dei rami di sviluppo; facilita il lavoro parallelo e consente la netta separazione della versione in produzione.
== GitHub
Servizio cloud che permette di gestire una o più repository Git, offre strumenti che semplificano la collaborazione e l’automazione di processi.
== GitHub Action
Strumento messo a disposizione da GitHub per effettuare automazioni all’interno di una repository.
== Glossario
Elenco di termini con le relative definizioni, utilizzato per chiarire il significato di concetti specifici in un determinato contesto.
== Gmail
Servizio di posta elettronica sviluppato da Google che permette di inviare, ricevere e organizzare email tramite web o applicazioni dedicate.

#pagebreak()
= H

#pagebreak()
= I
== IA
Acronimo di Intelligenza Artificiale, per la definizione vedere ‘Intelligenza Artificiale’.
== IEEE
È l’acronimo di Institute of Electrical and Electronics Engineers, un’associazione internazionale che promuove lo sviluppo delle tecnologie e dell’ingegneria in ambiti come l’elettronica, informatica e le telecomunicazioni.
== Intelligenza Artificiale
Disciplina dell’informatica che studia e sviluppa sistemi in grado di eseguire compiti che richiedono tipicamente l’intelligenza umana, come il ragionamento, l’apprendimento e la comprensione del linguaggio naturale.
== Issue
All’interno dell’ecosistema GitHub, rappresenta un’attività che richiede modifiche al codice sorgente per essere svolta, può trattarsi di un bug da risolvere, una feature da aggiungere, di una correzione minore o anche di qualcosa definito dagli sviluppatori.

#pagebreak()
= J

#pagebreak()
= K

#pagebreak()
= L
== LLM
Large Language Models. Indica i modelli addestrati su enormi quantità di testo come ChatGPT e Claude.

#pagebreak()
= M
== Manuale Utente
Documento che descrive le funzionalità di un software e fornisce istruzioni per il suo corretto utilizzo da parte degli utenti finali.
== Manutenzione
Insieme di attività atte a risolvere i problemi e migliorare le funzionalità di un prodotto.
== Merge
Processo con il quale, in un sistema di versionamento come git, un ramo di lavoro viene fatto confluire in un altro, generalmente in un grado gerarchico più elevato.
== Metodo Agile
Metodo di sviluppo software per la gestione di progetti complessi basato sui cicli iterativi brevi chiamati Sprint, che favorisce la flessibilità del progetto e la collaborazione continua.
== Milestone
Periodo di tempo entro il quale il gruppo si pone il raggiungimento di determinati obiettivi.
== Minimum Viable Product
La prima versione di un prodotto che assolve le funzionalità minime per rispettare i requisiti obbligatori stabiliti dalla proponente.
== MVP
Acronimo di Minimum Viable Product, per la definizione vedere ‘Minimum Viable Product’.

#pagebreak()
= N
== Norme di Progetto
Documento che descrive il Way of Working del gruppo. Contiene le regole che ByteClub rispetta per garantire un lavoro efficace ed efficiente.

#pagebreak()
= O

#pagebreak()
= P
== PB
Acronimo di Product Baseline, per la definizione vedere ‘Product Baseline’.
== Pianificazione
Processo di definizione degli obiettivi del progetto identificandone le risorse ed i tempi richiesti per la sua realizzazione.
== Piano di Progetto
Documento che si occupa di definire l’organizzazione del gruppo, specificando l’assegnazione dei ruoli, il monte ore previsto per ogni risorsa, le tempistiche e il conto economico preventivo in funzione dell’avanzamento del progetto.
== Piano di Qualifica
Documento che si occupa di garantire il rispetto dei requisiti del progetto definendo le strategie di verifica e validazione affinché vengano rispettate le attese della proponente.
== PoC
Acronimo di Proof of Concept, per la definizione vedere ‘Proof of Concept’.
== PR
Acronimo di Pull Request, per la definizione vedere ‘Pull Request’.
== Processo
Insieme di attività correlate e coese che trasformano ingressi (bisogni) in uscite (prodotti) secondo regole date, consumando risorse nel farlo.
== Product Baseline
Fase finale in un progetto, che prevede la realizzazione di un Minimum Viable Product, a seguito del superamento dei test concordati nella Requirements and Technology Baseline.
== Produzione
Processo di traduzione della progettazione in codice sorgente mediante la programmazione ed i test.
== Progettazione
Processo che definisce la struttura di un sistema, identificandone componenti, relazioni e livello di dettaglio necessari per la realizzazione. Serve a semplificarne lo sviluppo e la manutenzione futura.
== Progettista
Ruolo dedito alla progettazione dell’architettura di un progetto, al fine di assicurarsi codice più corretto e manutenibile.
== Progetto
Insieme ordinato di attività, istanziate dai processi di ciclo di vita che soddisfano gli obiettivi dati.
== Programmatore
La persona incaricata di svolgere le attività di codifica, data l’architettura.
== Proof of Concept
Prodotto dimostrativo atto a presentare la fattibilità dell’idea.
== Proponente
La persona, il gruppo o l’organizzazione che propone un progetto, un’idea o un’iniziativa, e ne definisce obiettivi, requisiti e motivazioni. La proponente di ByteClub è Ergon Informatica s.r.l.
== Pull Request
All’interno dell’ecosistema GitHub, uno strumento che permette di sospendere momentaneamente la pubblicazione di una modifica nel ramo principale della repository, in attesa di approvazione e/o workflow automatici (e.g. GitHub Action).

#pagebreak()
= Q
== Query
Richiesta di dati o informazioni inviata a un sistema, come un database o un motore di ricerca, per ottenere risultati specifici.

#pagebreak()
= R
== Redattore
Colui che scrive il documento, viene identificato come “Autore” nel registro delle modifiche.
== Repository
Uno spazio condiviso tra tutti i membri del gruppo, in cui viene memorizzato e versionato tutto il codice sorgente prodotto.
== Requisito di vincolo
Tipo di requisito che descrive le restrizioni imposte dall’azienda proponente che il progetto deve rispettare.
== Requisito funzionale
Definiscono cosa il sistema deve fare, descrivendo le sue azioni e funzioni specifiche. Sono le capacità che l’utente si aspetta, come “aggiungere un prodotto al carrello” in un negozio online.
== Requisito non funzionale
Specificano come il sistema deve comportarsi mentre svolge quelle funzioni. Si concentrano su qualità come le prestazioni, la sicurezza o l’affidabilità, ad esempio “il sistema deve supportare 1000 utenti contemporanei senza rallentamenti”.
== Responsabile
Il Responsabile coordina le attività del gruppo e garantisce una pianificazione efficace.
== RTB
Baseline iniziale e vincolante di requisiti e tecnologie approvate per il progetto. Comprende requisiti funzionali, non funzionali, di sicurezza e conformità, insieme a strumenti, linguaggi, piattaforme e infrastrutture scelte. Costituisce il riferimento stabile per verificare coerenza e avanzamento. Qualsiasi modifica richiede revisione e approvazione formale.

#pagebreak()
= S
== Sprint
Ciclo di lavoro di durata fissa, tipico dello sviluppo Agile, durante il quale il gruppo si impegna a completare un insieme prefissato di attività per produrre un incremento del software.
== SQL
Acronimo di Structured Query Language, è un linguaggio di programmazione con lo scopo di creare, filtrare ed eliminare dati memorizzati all’interno di tabelle nei database relazionali.
== Stakeholder
Qualunque persona, gruppo o organizzazione che ha interesse, influenza o è coinvolta nel progetto, includendo clienti, utenti, sviluppatori, dirigenti, fornitori e persino organizzazioni esterne, ed è fondamentale per definire requisiti.
== Sviluppo
Attività pratica di scrittura, test e integrazione del codice necessaria a implementare le funzionalità definite durante la fase di progettazione.

#pagebreak()
= T
== Test
Un processo dello sviluppo software che si occupa di verificare la funzionalità di una o più parti del prodotto.
== Typst
Linguaggio di markup utilizzato dal gruppo per produrre tutti i documenti.

#pagebreak()
= U
== UML
Acronimo di Unified Modeling Language, si tratta di un linguaggio di modellazione standard. Utilizzato per la visualizzazione di sistemi complessi tramite diagrammi, per esempio: diagrammi di classi, casi d’uso, diagrammi delle attività, etc.

#pagebreak()
= V
== Validazione
Insieme di controlli per assicurarsi che un prodotto (o una parte di esso) soddisfi in modo congruo ciò per cui è stato creato.
== VE
Acronimo di Verbale Esterno, viene utilizzato per tracciare nel tempo decisioni e azioni intraprese in un incontro esterno. Il codice associato ai VE segue la forma VE x.y.z, dove x identifica il numero progressivo del verbale approvato, y identifica una specifica decisione o voce registrata all’interno del verbale e z identifica le modifiche minori.
== Verifica
Insieme di processi atti a garantire che una funzione all’interno di un prodotto soddisfi determinati requisiti.
== Verificatore
Il Verificatore si occupa di assicurare la qualità dei prodotti e dei processi adottati, effettuando revisioni e test.
== Versionamento
Metodo per gestire e tenere traccia di documenti, codice o altri artefatti digitali, organizzandoli in versioni identificate da un codice univoco, in modo da poter monitorare modifiche, confrontare stati diversi e ripristinare versioni precedenti.
== VI
Acronimo di Verbale Interno, viene utilizzato per tracciare nel tempo decisioni e azioni intraprese in un incontro interno. Il codice associato ai VI segue la forma VI x.y.z, dove x identifica il numero progressivo del verbale approvato, y identifica una specifica decisione o voce registrata all’interno del verbale e z identifica le modifiche minori.

#pagebreak()
= W
== Way of Working
Insieme di metodologie e strutture organizzative approvate dall’intero gruppo per svolgere in modo coerente i propri compiti.
== WhatsApp
Applicazione di messaggistica istantanea adottata dal gruppo ByteClub per le comunicazioni interne.

#pagebreak()
= X

#pagebreak()
= Y

#pagebreak()
= Z
