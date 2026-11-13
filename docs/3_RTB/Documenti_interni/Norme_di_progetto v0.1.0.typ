
#import "/docs/5_Templates/documento.typ": *

// Norme di Progetto
// Nomenclatura: Norme_di_Progetto v0.1.0.typ

#show: documento.with(
  titolo: "Norme di Progetto",
  mostraRegistro: true,
  versione: "0.1.0",
  stato: "In redazione",
  redazione: EH,
  verifica: LS,
  approvazione: RP,
  uso: "Interno",
  destinatari: "Tutti i componenti del gruppo ByteClub",
  proprietario: "ByteClub",
  registroModifiche: (
    ("0.1.0", "2026-11-13", "Prima stesura del documento", EH, LS),
  ),
  indice: true,
)

= Introduzione

== Scopo del documento

Il presente documento definisce le norme e le procedure adottate dal gruppo ByteClub per organizzare e gestire le attività relative allo sviluppo del progetto Smart Dashboard.

Le norme hanno lo scopo di stabilire un metodo di lavoro condiviso, favorire la collaborazione tra i componenti del gruppo e garantire uniformità nello svolgimento delle attività e nella produzione della documentazione.

In particolare, il documento disciplina:

- l'organizzazione del gruppo e l'assegnazione dei ruoli;
- la pianificazione e la gestione delle attività;
- l'utilizzo degli strumenti di collaborazione;
- la gestione del codice sorgente e delle relative modifiche;
- la produzione e la manutenzione della documentazione;
- la comunicazione e la verbalizzazione delle riunioni;
- le attività di verifica e controllo della qualità.

== Ambito di applicazione

Le norme si applicano a tutti i componenti del gruppo ByteClub e riguardano le attività svolte durante l'intero ciclo di vita del progetto.

Le procedure potranno essere aggiornate nel corso del progetto in seguito all'introduzione di nuovi strumenti, all'emergere di nuove esigenze organizzative o all'individuazione di miglioramenti nel metodo di lavoro.

== Terminologia

Per la terminologia specifica del progetto si fa riferimento al documento Glossario, che raccoglie e definisce i principali termini tecnici e organizzativi utilizzati nella documentazione.

= Organizzazione del gruppo

== Composizione del gruppo

Il gruppo ByteClub è composto da sei membri, che collaborano alla realizzazione del progetto FossDot e condividono la responsabilità del risultato finale.

Ogni componente contribuisce alle attività in base alle proprie competenze, conoscenze e disponibilità, nel rispetto delle responsabilità assegnate.

== Ruoli e responsabilità

Per organizzare il lavoro vengono individuati diversi ruoli, ciascuno associato a specifiche responsabilità.

- *Responsabile:* coordina il gruppo, pianifica le attività, monitora le scadenze e gestisce i rapporti con il proponente e con il docente.
- *Amministratore:* gestisce gli strumenti e gli ambienti di lavoro condivisi, il repository e gli aspetti organizzativi relativi all'infrastruttura del progetto.
- *Analista:* si occupa dell'analisi dei requisiti, della comprensione delle esigenze e della definizione delle funzionalità del sistema.
- *Progettista:* definisce le soluzioni progettuali e l'organizzazione architetturale del sistema.
- *Programmatore:* implementa le funzionalità e si occupa della manutenzione del codice sorgente.
- *Verificatore:* controlla la correttezza e la qualità dei prodotti realizzati, verificando il rispetto dei requisiti e delle norme stabilite.

I ruoli possono essere assegnati e riassegnati in funzione delle esigenze delle singole fasi di lavoro. L'assegnazione di un ruolo non implica necessariamente che un componente possa svolgere esclusivamente le attività associate a esso.

== Assegnazione dei ruoli

All'inizio di ogni periodo di lavoro il gruppo individua i responsabili delle principali attività, tenendo conto di:

- competenze e conoscenze dei componenti;
- preferenze e attitudini personali;
- disponibilità dei singoli membri;
- carico di lavoro già assegnato;
- necessità di distribuire le responsabilità in modo equilibrato.

L'assegnazione dei ruoli può essere rivista nel corso del progetto, qualora emergano esigenze differenti.

== Responsabile di progetto

Il responsabile coordina le attività del gruppo e costituisce il principale riferimento organizzativo.

In particolare, si occupa di:

- organizzare e coordinare le attività;
- monitorare l'avanzamento del lavoro;
- verificare il rispetto delle scadenze;
- facilitare la comunicazione tra i componenti;
- mantenere i rapporti con il proponente e con il docente;
- segnalare eventuali problemi organizzativi;
- coordinare la pianificazione dei periodi di lavoro.

Il ruolo di responsabile può essere assegnato nuovamente in funzione delle necessità del gruppo e della fase progettuale.

= Organizzazione del lavoro

== Pianificazione delle attività

Il lavoro viene organizzato attraverso attività pianificate e assegnate ai componenti del gruppo.

Le attività devono essere sufficientemente definite da permettere di individuare:

- l'obiettivo da raggiungere;
- il responsabile o i responsabili;
- la scadenza prevista, quando applicabile;
- il prodotto atteso;
- eventuali dipendenze da altre attività.

La pianificazione viene mantenuta aggiornata attraverso gli strumenti condivisi dal gruppo.

== Gestione delle milestone

Le milestone rappresentano traguardi significativi del progetto e permettono di organizzare le attività in funzione degli obiettivi da raggiungere.

Ogni milestone dovrebbe:

- identificare un risultato o un insieme coerente di risultati;
- contenere le attività necessarie al suo completamento;
- avere una scadenza indicativa;
- permettere di valutare lo stato di avanzamento del progetto.

Le milestone vengono gestite attraverso GitHub.

== Gestione delle issue

Le attività operative vengono rappresentate mediante issue su GitHub.

Ogni issue dovrebbe contenere:

- un titolo breve e descrittivo;
- una descrizione dell'attività;
- il risultato atteso;
- il componente o i componenti responsabili;
- la scadenza, quando prevista;
- la milestone di riferimento, se applicabile.

Le issue devono essere aggiornate durante lo svolgimento dell'attività, in modo da rendere visibile lo stato di avanzamento.

Quando un'attività è completata, la relativa issue deve essere chiusa.

== Periodi di lavoro

Il gruppo organizza le attività in periodi di lavoro, durante i quali vengono definiti gli obiettivi da raggiungere e le relative scadenze.

La durata dei periodi viene stabilita in base alla quantità e alla complessità delle attività previste, cercando di mantenere una pianificazione sostenibile e verificabile.

Al termine di ciascun periodo il gruppo valuta il lavoro completato e gli eventuali scostamenti rispetto agli obiettivi iniziali.

== Monitoraggio dell'avanzamento

L'avanzamento delle attività viene monitorato attraverso:

- lo stato delle issue;
- il completamento delle milestone;
- l'aggiornamento dei documenti;
- il confronto durante le riunioni interne;
- la verifica delle scadenze pianificate.

Eventuali ritardi o difficoltà devono essere comunicati tempestivamente al responsabile, in modo da poter valutare eventuali modifiche alla pianificazione.

== Conteggio delle ore

Ogni componente deve registrare il tempo effettivamente dedicato alle attività di progetto.

Il conteggio delle ore ha lo scopo di:

- monitorare l'impegno dei singoli componenti;
- confrontare le ore effettive con quelle preventivate;
- individuare eventuali scostamenti;
- fornire informazioni utili per aggiornare la pianificazione.

Le modalità operative di registrazione, aggiornamento e consultazione del conteggio devono essere definite e condivise dal gruppo.

= Strumenti di collaborazione

== GitHub

GitHub viene utilizzato come piattaforma principale per la gestione del repository, la collaborazione sui prodotti del progetto e il coordinamento delle attività.

In particolare, vengono utilizzati:

- *Repository:* per conservare e versionare i prodotti del progetto.
- *Branch:* per separare le diverse linee di sviluppo.
- *Issue:* per descrivere e assegnare le attività.
- *Milestone:* per organizzare le attività in funzione degli obiettivi.
- *Pull Request:* per proporre e revisionare modifiche prima della loro integrazione.
- *GitHub Pages:* per pubblicare e rendere consultabile la documentazione del progetto.

== Discord

Il gruppo utilizza Discord per la comunicazione e per lo svolgimento delle riunioni a distanza.

Le comunicazioni relative alle attività devono essere sufficientemente chiare da permettere a tutti i componenti di comprendere eventuali decisioni, assegnazioni e modifiche alla pianificazione.

Le decisioni rilevanti devono essere riportate nella documentazione del progetto, in particolare nei verbali delle riunioni.

== Typst

La documentazione del progetto viene redatta utilizzando Typst.

Per mantenere uniformità grafica e strutturale, i documenti devono fare riferimento ai template condivisi nella cartella `docs/5_Templates`.

I template costituiscono il riferimento comune per la produzione dei documenti e devono essere riutilizzati evitando modifiche non concordate alla loro struttura generale.

= Gestione della configurazione

== Repository

Il repository GitHub del gruppo costituisce il riferimento centrale per la conservazione e la gestione dei prodotti del progetto.

Tutti i componenti devono lavorare utilizzando il repository condiviso e mantenere sincronizzata la propria copia locale con quella remota.

Prima di iniziare una nuova attività è opportuno aggiornare il repository locale, così da ridurre il rischio di conflitti e lavorare su una versione recente dei prodotti.

== Strategia di branching

Il gruppo adotta una strategia di branching ispirata a Gitflow.

I branch principali sono:

- `main`: contiene le versioni stabili dei prodotti, considerate pronte per il rilascio;
- `develop`: contiene le modifiche integrate e costituisce il riferimento per lo sviluppo.

Per le attività che richiedono modifiche significative è opportuno creare branch dedicati, a partire da `develop`.

I branch dedicati devono avere una denominazione descrittiva, che permetta di identificare facilmente l'attività a cui sono associati.

Esempi:

- `feature/gestione-utenti`;
- `docs/analisi-requisiti`;
- `fix/correzione-workflow`.

== Commit

Ogni commit deve rappresentare un insieme coerente di modifiche.

Il messaggio associato al commit deve descrivere sinteticamente il contenuto delle modifiche, evitando descrizioni generiche o poco significative.

È preferibile effettuare commit frequenti e circoscritti, così da facilitare la comprensione della cronologia e l'eventuale individuazione di problemi.

La convenzione formale per la denominazione dei commit deve essere condivisa e mantenuta uniforme da tutti i componenti.

== Pull Request

Le modifiche realizzate su branch dedicati vengono proposte per l'integrazione mediante Pull Request.

Ogni Pull Request dovrebbe:

- avere un titolo descrittivo;
- spiegare lo scopo delle modifiche;
- indicare le issue eventualmente collegate;
- permettere di individuare facilmente i file modificati;
- essere controllata prima dell'integrazione.

La revisione deve verificare che le modifiche siano coerenti con l'attività assegnata e non introducano regressioni o incongruenze.

L'integrazione in `develop` avviene dopo la revisione e l'approvazione delle modifiche.

L'integrazione in `main` avviene quando il gruppo ritiene che la versione di `develop` sia sufficientemente stabile e pronta per il rilascio.

== Risoluzione dei conflitti

In caso di conflitto durante un'operazione Git, il componente coinvolto deve analizzare le modifiche in contrasto e risolverle preservando il lavoro valido di tutti i componenti.

Se il conflitto riguarda modifiche non facilmente riconciliabili, è necessario confrontarsi con gli autori delle modifiche interessate prima di procedere.

Non devono essere eliminate o sovrascritte modifiche altrui senza averne verificato il contenuto e l'impatto.

== Versionamento dei prodotti

I prodotti del progetto devono essere mantenuti aggiornati nel repository.

Le modifiche ai documenti e agli altri artefatti devono essere tracciabili attraverso la cronologia Git.

Quando previsto, i documenti devono riportare le informazioni relative alla versione e alle modifiche effettuate, secondo quanto definito dai rispettivi template.

= Gestione della documentazione

== Organizzazione dei documenti

La documentazione viene organizzata all'interno della cartella `docs`, seguendo la suddivisione prevista per le diverse fasi del progetto.

I documenti devono essere collocati nella cartella corrispondente alla loro tipologia e alla fase progettuale di riferimento.

I template condivisi sono conservati nella cartella `docs/5_Templates`.

== Redazione dei documenti

Ogni documento deve essere redatto in modo chiaro, coerente e comprensibile.

La redazione deve rispettare:

- la struttura e la formattazione previste dal template;
- la terminologia condivisa nel Glossario;
- la coerenza con gli altri documenti del progetto;
- la correttezza delle informazioni riportate;
- la tracciabilità delle modifiche effettuate.

I documenti devono essere aggiornati quando cambiano le decisioni progettuali o le informazioni in essi contenute.

== Verifica dei documenti

Prima di considerare conclusa la redazione di un documento, è necessario verificarne il contenuto.

La verifica deve comprendere almeno:

- la correttezza delle informazioni;
- la completezza rispetto allo scopo del documento;
- la coerenza con gli altri prodotti;
- il rispetto delle convenzioni redazionali;
- la correttezza della compilazione Typst, quando applicabile.

La responsabilità della verifica deve essere assegnata a un componente diverso dal redattore, quando l'organizzazione del gruppo lo consente.

== Compilazione e pubblicazione

I documenti Typst devono essere compilabili senza errori.

Il gruppo utilizza workflow automatizzati per supportare la compilazione dei documenti e la pubblicazione della documentazione.

La documentazione destinata alla consultazione deve essere resa disponibile attraverso il sito del progetto, pubblicato mediante GitHub Pages.

= Riunioni e comunicazione

== Riunioni interne

Le riunioni interne vengono utilizzate per coordinare il lavoro, discutere eventuali problemi e prendere decisioni organizzative e progettuali.

Il gruppo ha stabilito di svolgere una riunione interna con cadenza settimanale, indicativamente il venerdì alle ore 14:30.

Eventuali variazioni di data o orario devono essere comunicate a tutti i componenti.

== Riunioni esterne

Le riunioni esterne coinvolgono soggetti al di fuori del gruppo, come il proponente o il docente.

Il responsabile coordina l'organizzazione degli incontri e la comunicazione con gli interlocutori esterni.

Gli incontri devono essere preparati individuando gli argomenti da discutere e le eventuali domande da sottoporre agli interlocutori.

== Verbali

Per ogni riunione rilevante deve essere redatto un verbale, utilizzando il template condiviso.

Il verbale deve riportare almeno:

- data e tipologia della riunione;
- luogo o piattaforma utilizzata;
- orario di inizio e fine;
- partecipanti e assenti;
- ordine del giorno;
- argomenti discussi;
- decisioni prese;
- eventuali azioni da svolgere.

Le azioni individuate durante la riunione devono essere assegnate ai componenti responsabili e, quando possibile, associate a una scadenza.

I verbali devono essere conservati nella cartella prevista per la fase progettuale e per la tipologia di riunione.

== Comunicazione delle decisioni

Le decisioni che incidono sull'organizzazione, sulla pianificazione o sullo sviluppo del progetto devono essere condivise con tutti i componenti.

Le decisioni prese durante le riunioni devono essere riportate nei relativi verbali, in modo da mantenere una traccia consultabile delle scelte effettuate.

= Verifica e qualità

== Principi generali

Il gruppo considera la verifica una parte integrante del processo di sviluppo.

Ogni prodotto realizzato deve essere controllato prima di essere considerato concluso o integrato nella versione stabile del progetto.

== Verifica del codice

Il codice sorgente deve essere controllato per individuare eventuali errori, incongruenze o problemi di integrazione.

Le modifiche devono essere revisionate prima di essere integrate nei branch principali.

Quando disponibili, devono essere utilizzati strumenti automatizzati per controllare la correttezza e il funzionamento del codice.

== Verifica della documentazione

La documentazione deve essere controllata sia dal punto di vista del contenuto sia dal punto di vista formale.

Devono essere verificati:

- la coerenza tra i documenti;
- il rispetto dei template;
- la correttezza delle informazioni;
- la corretta compilazione dei sorgenti Typst;
- la presenza delle informazioni necessarie.

== Gestione delle anomalie

Quando viene individuato un problema, questo deve essere comunicato al gruppo e, se necessario, registrato come issue.

L'anomalia deve essere descritta in modo da consentire di comprenderne il comportamento, l'impatto e le eventuali modalità di risoluzione.

= Manutenzione delle Norme di Progetto

Le presenti norme costituiscono il riferimento condiviso per l'organizzazione del lavoro del gruppo ByteClub.

Il documento deve essere aggiornato quando vengono introdotte nuove procedure, modificati gli strumenti utilizzati o individuate pratiche di lavoro più efficaci.

Ogni modifica deve essere condivisa con il gruppo e sottoposta a verifica prima della sua integrazione nella versione aggiornata del documento.

= Aspetti da formalizzare

Alcuni aspetti organizzativi e operativi richiedono ulteriori decisioni da parte del gruppo. Tali aspetti saranno integrati nelle successive versioni del documento.

In particolare, devono essere definiti:

- la convenzione definitiva per i messaggi dei commit;
- la convenzione per la denominazione dei branch;
- le modalità di approvazione delle Pull Request e il numero di revisioni richieste;
- lo strumento e la frequenza di aggiornamento del conteggio delle ore;
- le modalità di gestione delle priorità delle issue;
- i criteri di verifica specifici per codice, documenti e altri prodotti;
- la procedura per la gestione delle versioni e dei rilasci.
