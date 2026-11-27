
#import "/docs/5_Templates/documento.typ": *
#import "/docs/3_RTB/Documenti_interni/Glossario.typ": termini

// Norme di Progetto
// Nomenclatura: Norme_di_Progetto v0.1.0.typ

#show: documento.with(
  titolo: "Norme di Progetto",
  mostraRegistro: true,
  versione: "0.3.0",
  stato: "In redazione",
  redazione: EH,
  verifica: LS,
  approvazione: RP,
  uso: "Interno",
  destinatari: "Tutti i componenti del gruppo ByteClub",
  proprietario: "ByteClub",
  registroModifiche: (
    ("0.3.1", "2026-11-27", "Evidenziazione dei termini da glossario.", EH, LS),
    ("0.3.0", "2026-11-20", "Aggiornamento delle norme per project board, issue, conteggio ore, gestione delle chiavi API e utilizzo del Glossario.", EH, LS),
    ("0.2.0", "2026-11-16", "Integrazione delle norme relative a Gitflow, gestione della documentazione, Typst, build, testing e nomenclatura dei commit.", EH, LS),
    ("0.1.0", "2026-11-13", "Prima stesura del documento", EH, LS),
  ),
  indice: true,
  glossario: termini,
  tabelle:true,
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

La pianificazione viene mantenuta aggiornata attraverso gli strumenti condivisi dal gruppo. La project board di GitHub costituisce il riferimento operativo per visualizzare l'andamento temporale delle attività, distinguendo quelle programmate, in corso, in revisione e concluse.

La board deve essere mantenuta ordinata e aggiornata da tutti i componenti ogni qualvolta si verifichino variazioni nello stato o nelle informazioni delle attività. La vista adottata deve consentire una panoramica temporale delle issue, in modo analogo a un diagramma di Gantt, e permettere l'esportazione dei dati necessari al monitoraggio del progetto.

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

Ogni issue deve contenere le informazioni necessarie a identificare e monitorare l'attività. Oltre ai parametri standard di GitHub, quali assegnatario, etichette e milestone, la project board prevede i seguenti campi:

- *Ruolo:* ruolo con cui viene svolta l'attività;
- *Data inizio:* data in cui il componente inizia effettivamente a lavorare sull'attività, non la data di creazione dell'issue;
- *Data fine:* data di completamento dell'attività, comprensiva della revisione e, normalmente, della chiusura della Pull Request;
- *Priorità:* livello di urgenza dell'attività, scegliendo tra Critica, Alta, Media e Bassa;
- *Conteggio*: indica se le ore impiegate nell'attività sono considerate ore produttive ai fini del conteggio del monte ore oppure se non sono considerate produttive;
- *Ore impiegate:* tempo effettivamente dedicato all'attività, da registrare alla chiusura dell'issue;
- *Sprint*: periodo di lavoro al quale viene associata l'attività;
- *Ruolo*: ruolo con cui viene svolta l'attività, scegliendo tra Responsabile, Amministratore, Analista, Progettista, Programmatore e Verificatore;
- *Sviluppo:* Pull Request che realizza e chiude l'issue.

=== Stati delle issue

Ogni issue può assumere uno dei seguenti cinque stati, che rappresentano il relativo avanzamento:
- *Waiting Requirements*: l'attività è in attesa della definizione o del completamento dei requisiti necessari per poter procedere;
- *Todo*: l'attività è stata pianificata, ma non è ancora iniziata;
- *In Progress*: l'attività è attualmente in corso;
- *Waiting Review*: l'attività è stata completata ed è in attesa di revisione o verifica;
- *Done*: l'attività è stata completata e le verifiche previste sono state concluse.

Lo stato delle issue deve essere aggiornato tempestivamente dai componenti responsabili, in modo da mantenere la project board coerente con l'effettivo avanzamento delle attività.

Ogni componente è responsabile dell'inserimento e dell'aggiornamento dei dati di propria competenza. Alla chiusura di un'issue devono essere compilati tutti i campi richiesti, così da mantenere aggiornati il monitoraggio dell'avanzamento e il conteggio delle ore.

Quando un'attività è completata e le relative verifiche sono concluse, la issue deve essere chiusa.

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

Ogni componente deve registrare il tempo effettivamente dedicato alle attività di progetto, compilando il campo *Ore impiegate* delle issue al momento della loro chiusura.

I dati relativi alle issue vengono esportati dalla project board e riportati in un foglio Excel condiviso con tutti i componenti. Il foglio consente di monitorare le ore impiegate per ciascun ruolo e le rispettive ore rimanenti, fornendo i dati necessari per l'aggiornamento del Piano di Progetto.

Al termine di ogni sprint il gruppo aggiorna il conteggio del monte ore e utilizza i risultati per pianificare lo sprint successivo. Il conteggio ha lo scopo di:

- monitorare l'impegno dei singoli componenti e dei diversi ruoli;
- confrontare le ore effettive con quelle preventivate;
- individuare eventuali scostamenti;
- aggiornare il Piano di Progetto sulla base dell'avanzamento effettivo.

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
- *GitHub Projects (project board):* per visualizzare e monitorare le attività nel tempo, gestire i relativi parametri e ricavare i dati necessari al conteggio delle ore.

== Foglio di calcolo condiviso

Il gruppo utilizza un foglio Excel condiviso per raccogliere i dati relativi alle ore di lavoro, elaborati a partire dalle informazioni esportate dalla project board. Il foglio viene aggiornato al termine di ogni sprint e costituisce un supporto per il monitoraggio del monte ore e per l'aggiornamento del Piano di Progetto.

== Discord

Il gruppo utilizza Discord per la comunicazione e per lo svolgimento delle riunioni a distanza.

Le comunicazioni relative alle attività devono essere sufficientemente chiare da permettere a tutti i componenti di comprendere eventuali decisioni, assegnazioni e modifiche alla pianificazione.

Le decisioni rilevanti devono essere riportate nella documentazione del progetto, in particolare nei verbali delle riunioni.

== Typst

La documentazione del progetto viene redatta utilizzando Typst.

Per mantenere uniformità grafica e strutturale, i documenti devono fare riferimento ai template condivisi nella cartella `docs/5_Templates`.

I template costituiscono il riferimento comune per la produzione dei documenti e devono essere riutilizzati evitando modifiche non concordate alla loro struttura generale.

== Gestione delle chiavi API e delle informazioni riservate

Le chiavi API fornite dal proponente per i servizi OpenAI e Anthropic sono informazioni riservate e possono essere utilizzate per le attività di sviluppo del PoC e del prodotto finale.

Ogni componente che necessita di utilizzare tali chiavi deve configurarle localmente tramite un file `.env`. Il file contenente le credenziali effettive non deve essere inserito nel repository, condiviso o reso pubblico in alcun modo.

Per documentare le variabili necessarie alla configurazione dell'ambiente, il repository deve contenere un file `.env.example`. Questo file ha esclusivamente funzione di modello: può riportare i nomi delle variabili e valori segnaposto, ma non deve contenere le chiavi API effettive.

Quando le credenziali sono necessarie all'interno dei workflow automatizzati, devono essere configurate tramite i GitHub Actions secrets, evitando di inserirle direttamente nei file del repository o nei sorgenti dei workflow.

Tutti i componenti devono limitare l'utilizzo delle chiavi API a quanto strettamente necessario e adottare le precauzioni necessarie a impedirne la divulgazione.

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


Ogni commit deve rappresentare un insieme coerente e circoscritto di modifiche. I messaggi devono essere chiari, concisi e descrivere il cambiamento effettuato.

Il gruppo adotta una versione semplificata della convenzione Conventional Commits, secondo il formato:

`<tipo>: <descrizione>`

Le tipologie ammesse sono:

#table(
  columns: (1fr, 2fr),
  align: horizon,
  table.header(
    [*Tipo*],
    [*Utilizzo*],
  ),
  [feat], [Aggiunta di una funzionalità.],
  [fix], [Correzione di un bug.],
  [docs], [Modifiche alla documentazione.],
  [style], [Modifiche alla formattazione del codice.],
  [refactor], [Riorganizzazione del codice.],
  [test], [Aggiunta o modifica dei test.],
  [chore], [Attività di manutenzione e configurazione.],
)

Esempi:

```text
feat: add user registration
fix: correct login validation
docs: update installation instructions
style: improve navigation layout
refactor: simplify database connection
test: add registration tests
chore: update gitignore
```

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

La documentazione viene organizzata all'interno della cartella `docs`, seguendo la suddivisione prevista per le diverse fasi del progetto:

- `docs/1_Diario_di_bordo/`: diari di bordo;

- `docs/2_Candidatura/`: documenti relativi alla candidatura;

- `docs/3_RTB/`: documenti della fase RTB;

- `docs/4_PB/`: documenti della fase PB;

- `docs/5_Templates/`: sorgenti Typst riutilizzabili e relativi asset;

- `docs/6_Output/`: PDF generati, organizzati con una struttura analoga a quella dei sorgenti.

I documenti devono essere collocati nella cartella corrispondente alla loro tipologia e alla fase progettuale di riferimento. All'interno delle cartelle dei verbali, questi devono essere ulteriormente distinti in `interni/` ed `esterni/`.

I file `.gitkeep` sono utilizzati per mantenere nel repository le cartelle altrimenti vuote. I template condivisi sono conservati nella cartella `docs/5_Templates`.

== Nomenclatura dei documenti

Per garantire uniformità e rendere immediatamente riconoscibile la tipologia dei documenti, il gruppo adotta convenzioni di denominazione distinte.

Per verbali e diari di bordo si utilizza il formato:

`[VE/VI/DDB]_YYYY-MM-DD`

dove `VE` identifica un verbale esterno, `VI` un verbale interno e `DDB` un diario di bordo. La data deve essere espressa nel formato anno-mese-giorno.

Esempi: `VI_2005-12-22`, `VE_2005-12-22` e `DDB_2005-12-22`.

Per i documenti tecnici si utilizza il formato `Nome_documento vx.y.z`. La versione è composta da tre numeri: `x` identifica le modifiche sostanziali al contenuto, `y` le modifiche alla struttura e `z` le modifiche allo stile. Ad esempio: `Analisi_dei_requisiti v8.8.8`.

== Redazione dei documenti

Ogni documento deve essere redatto in modo chiaro, coerente e comprensibile.

La redazione deve rispettare:

- la struttura e la formattazione previste dal template;
- la terminologia condivisa nel Glossario;
- la coerenza con gli altri documenti del progetto;
- la correttezza delle informazioni riportate;
- la tracciabilità delle modifiche effettuate;
- l'utilizzo coerente dei termini definiti nel Glossario.

Ogni documento redatto deve evidenziare le occorrenze dei termini presenti nel Glossario e, quando il collegamento è disponibile, rimandare direttamente alla relativa definizione. I template Typst devono supportare questa modalità di marcatura e collegamento.

Il Glossario deve essere mantenuto aggiornato durante il progetto, inserendo i nuovi termini tecnici o organizzativi che risultino necessari. Chi redige un documento deve quindi verificare la presenza nel Glossario dei termini utilizzati e segnalare o predisporre l'inserimento di quelli mancanti.

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

I documenti Typst devono essere compilabili senza errori. Typst deve essere installato nell'ambiente di lavoro del componente che redige o verifica la documentazione.

L'installazione può essere effettuata attraverso il gestore di pacchetti disponibile nel sistema operativo:

- Windows, tramite Windows Package Manager: `winget install --id Typst.Typst`;

- macOS, tramite Homebrew: `brew install typst`;

- Linux, tramite `sudo apt install typst`, se disponibile nella distribuzione, oppure `cargo install typst-cli`.

L'installazione può essere verificata eseguendo `typst --version`. In caso di utilizzo di Visual Studio Code, può essere necessario riavviare l'editor dopo l'installazione.

I comandi Typst devono essere eseguiti dalla cartella principale del repository. Per compilare un sorgente in PDF si utilizza:

```bash
typst compile --root . percorso/sorgente.typ percorso/destinazione.pdf
```

Per mantenere la compilazione aggiornata automaticamente durante la modifica del sorgente si può utilizzare:

```bash
typst watch --root . percorso/sorgente.typ percorso/destinazione.pdf
```

I percorsi devono essere sostituiti con quelli del documento da compilare e del PDF da generare. Gli asset utilizzati dai template devono essere conservati nella cartella `docs/5_Templates/assets/`.

Il file `base.typ` contiene impostazioni e componenti condivisi, quali layout, font e spaziature. I file `verbale.typ`, `diario_di_bordo.typ` e `documento.typ` costituiscono i template completi per le rispettive tipologie documentali. I file `*_vuoto.typ` sono versioni minimali da copiare e compilare per creare un nuovo documento.

Il gruppo utilizza inoltre script Python e workflow automatizzati per supportare la compilazione dei documenti e la pubblicazione della documentazione. Lo script `.github/scripts/build_documents.py` individua i sorgenti Typst, li compila in PDF, aggiorna il catalogo del sito e prepara i contenuti pubblicabili nella cartella `website/build/`.

La build completa viene avviata dalla cartella principale del repository mediante il comando:

```bash
python .github/scripts/build_documents.py
```

Il comando richiede che Typst sia installato e aggiorna i PDF in `docs/6_Output/` e il sito generato in `website/build/`.

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

Per verificare la pipeline di generazione della documentazione sono disponibili test automatici nel file `test/test_build_documents.py`. I test controllano la compilazione, il catalogo HTML, i collegamenti e la gestione degli errori senza richiedere la compilazione effettiva dei documenti Typst.

I test devono essere eseguiti dalla cartella principale del repository mediante il comando:

```bash
python -m unittest discover -s test -p "test_build_documents.py" -v
```

Prima di aprire una Pull Request è consigliato eseguire prima i test automatici e successivamente la build completa, così da verificare sia il comportamento della pipeline sia la generazione degli artefatti.

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

In particolare, restano da definire o approfondire:

- i criteri di verifica specifici per il codice e per gli altri prodotti;
- la procedura dettagliata per la gestione delle versioni e dei rilasci;
- le modalità operative di esportazione dei dati dalla project board e di aggiornamento del foglio Excel condiviso;
- le modalità tecniche definitive per evidenziare e collegare automaticamente i termini del Glossario nei documenti Typst.