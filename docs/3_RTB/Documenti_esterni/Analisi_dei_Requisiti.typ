
#import "/docs/5_Templates/documento.typ": *
#import "/docs/3_RTB/Documenti_interni/Glossario.typ": termini

#let gruppo = "ByteClub"
#let linkCapitolato = "https://www.math.unipd.it/~tullio/IS-1/2026/Progetto/C7-SD.pdf"
#let linkLezioneAnalisi = "https://www.math.unipd.it/~tullio/IS-1/2026/Dispense/T05.pdf"
#let linkVerbaleEsterno = "https://byteclubunipd.github.io/Progetto-SWE/docs/6_Output/2_Candidatura/Verbali/Esterni/VE_2026-11-13.pdf"
#let linkNormeProgetto = "InserireLinkNormeProgetto"

#show: documento.with(
  titolo: "Analisi dei Requisiti",
  versione: "0.1.6",
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
    ("0.1.6", "2026-11-26", "Corretti errori e modificato il documento in base alle indicazioni ricevute dopo la verifica", BG, LS),
    ("0.1.5", "2026-11-24", "Modificato codice del documento per interagire con i termini tecnici presenti nel glossario", BG, LS),
    ("0.1.4", "2026-11-17", "Aggiunto paragrafo 2.2, 3; inizializzati paragrafi 2.3, 3.1, 3.2, 3.3, 3.4, 3.5", BG, LS),
    ("0.1.3", "2026-11-16", "Aggiunti indici tabelle e immagini", BG, LS),
    ("0.1.2", "2026-11-15", "Aggiunti paragrafi 1.5, 1.6, 2, 2.1", BG, LS),
    ("0.1.1", "2026-11-13", "Aggiunti paragrafi 1.1, 1.2, 1.3, 1.4", BG, LS),
    ("0.1.0", "2026-11-12", "Formattazione e divisione in paragrafi del documento", BG, LS),
  ),
  glossario: termini,
)

/*
Per inserire e far indicizzare le immagini e le tabelle nel documento usa i seguenti blocchi di codice:
TABELLA
#figure(
  table(
    columns: (1fr, 1fr),
    fill: (col, row) => if row == 0 { rgb("e8e8e8") },
    [#strong[Intestazione 1]], [#strong[Intestazione 2]],
    [Valore 1], [Valore 2],
  ),
  caption: [Titolo della tabella]
) <nome_tabella>

IMMAGINE
#figure(
  image("percorso/immagine.formato", width: 60%),
  caption: [Titolo dell'immagine]
) \
*/

// Modifica l'indice degli elenchi delle tabelle e delle immagini, lasciando inalterati gli altri indici
#show outline.entry: it => {
  if it.element.has("kind") and (it.element.kind == table or it.element.kind == image) {
    let loc = it.element.location()
    let num = counter(figure.where(kind: it.element.kind)).at(loc).first()
    let desc = it.element.caption.body
    let page-num = loc.page()
    link(loc, [
      #num -- #desc
      #box(width: 1fr, repeat([. ]))
      #page-num \
    ])
  } else {
    it
  }
}

//Indice delle tabelle
#outline(
  title: [Elenco delle tabelle],
  target: figure.where(kind: table)
)
#pagebreak()

//indice delle immagini
#outline(
  title: [Elenco delle immagini],
  target: figure.where(kind: image)
)
#pagebreak()



= Introduzione
== Glossario
Per tutti i termini tecnici, gli acronimi e le definizioni utilizzate nel documento si rimanda al #underline[@glossario].
Ogni parola presente nel @glossario viene segnata come segue: \
#align(center)[termine#super[G]]
== Scopo del documento
Il presente documento di "@analisi-dei-requisiti" definisce in modo formale, completo e strutturato i requisiti funzionali e non funzionali del sistema software *SmartDashboard*, da sviluppare nell'ambito del @progetto didattico del corso di Ingegneria del Software.
Descrive i casi d'uso principali del sistema, corredati da diagrammi @uml per visualizzare le interazioni tra attori e funzionalità.

Rappresenta il fondamento per le successive fasi di @progettazione, implementazione, testing e @validazione, garantendo l'allineamento del prodotto finale con le specifiche del @proponente *Ergon Informatica Srl* e con gli obiettivi delineati nel @capitolato C7.

I requisiti identificati sono classificati secondo le seguenti priorità:
- *Obbligatori*: essenziali per il funzionamento minimo del sistema e irrinunciabili per il @proponente;
- *Desiderabili*: non critici, ma in grado di apportare un valore aggiunto significativo all'utente finale;
- *Opzionali*: implementabili in fasi successive o in estensioni future.

Il documento è redatto dal gruppo "*ByteClub*" ed è destinato a:
- il *@proponente* (Ergon Informatica S.r.l.), per la @verifica della corretta interpretazione delle richieste;
- il *team di @sviluppo* come linea guida per la @progettazione architetturale e la codifica;
- il *team di @verifica* per la definizione delle strategie di test e validazione.

Il documento è inoltre destinato ad altre figure professionali coinvolte nello @sviluppo, quali Amministratori e @responsabile di Progetto, per consentire loro di acquisire una piena comprensione delle specifiche di Sistema.

== Prospettiva del prodotto
SmartDashboard si propone come una piattaforma intelligente e multimodale per la visualizzazione e l'analisi dei dati aziendali, permettendo agli utenti di monitorare le performance del business in tempo reale.
Il sistema è progettato secondo un'architettura modulare e scalabile, in grado di integrare modelli avanzati di @intelligenza-artificiale (@llm) e di adattarsi a volumi elevati di dati mantenendo fluidità nelle prestazioni.

== Funzioni del prodotto
Il sistema dovrà offrire le seguenti @funzionalita principali:
- *Costruzione self-service delle @dashboard*: l'utente potrà creare e personalizzare le proprie @dashboard in modo intuitivo tramite un'interfaccia @drag-and-drop, selezionando e ridimensionando i @widget secondo le proprie esigenze. Avrà inoltre la possibilità di salvare le @dashboard per un utilizzo futuro;
- *Libreria di @widget*: il sistema fornirà una vasta gamma di @widget predefiniti:
  - Grafici (a barre, a torta e a linee);
  - Tabelle (normali e @tabelle-pivot);
  - Mappe geografiche; 
  - @schede-kpi:cap;
  - @indicatori-a-quadrante:cap (@gauge);
- *Filtraggio*: il sistema dovrà consentire agli utenti di filtrare i dati visualizzati nelle @dashboard, facilitando l'analisi e la comprensione delle informazioni.
- *Personalizzazione e usabilità*: sono previsti temi chiaro/scuro, un'@interfaccia-responsive e tempi di caricamento dei dati contenuti.
- *Esportazione dei dati*: il sistema dovrà consentire l'esportazione dei dati visualizzati in formati standard (@pdf, @excel) per la condivisione.
- *Gestione utenti e persistenza*: il sistema dovrà supportare la gestione degli utenti, con @autenticazione e @autorizzazione basata su ruoli, e garantire la persistenza dei dati attraverso un @database sicuro e affidabile. Le configurazioni delle @dashboard e le preferenze degli utenti sono salvate lato @server e associate al singolo utente.
- *Assistente AI*: il sistema dovrà integrare un assistente virtuale basato su modelli di @llm per affiancare gli utenti per:
  - la creazione delle @dashboard, facendo da assistente designer;
  - la comprensione dei dati, spiegando le visualizzazioni e gli indicatori;
  - l'ottimizzazione delle analisi, creando insight automatizzati.
- *Esportazione delle @dashboard*: il sistema dovrà consentire agli utenti di esportare le proprie @dashboard in formati standard (@pdf, @excel).

I requisiti obbligatori sono stati definiti in accordo con le indicazioni del @proponente e con quanto emerso dai colloqui preliminari.

== Caratteristiche dell'utente
Il sistema si rivolge a utenti aziendali con competenze di base nell'uso di strumenti informatici e nella lettura di dati. In particolare:
- *Dipendente*: utilizzatore della @dashboard per l'analisi e la visualizzazione dei dati aziendali.
- *@amministratore:cap*: gestisce gli utenti e i relativi permessi; crea delle @dashboard aziendali.
- *@amministratore:cap di gestione*: crea altri utenti, ne imposta i ruoli e gli abilita o disabilita le autorizzazioni; ha accesso alle impostazioni generali della piattaforma (configurazione @api).
Ogni ruolo eredita i permessi e le funzionalità del ruolo precedente, con l'aggiunta di privilegi specifici.\
Gli utenti dovranno essere in grado di interagire con l'interfaccia del sistema, comprendere le visualizzazioni dei dati e utilizzare le funzionalità di filtraggio e personalizzazione delle @dashboard.
== Riferimenti
=== Riferimenti normativi
- #link(linkNormeProgetto)[#underline[@norme-di-progetto:cap]]. Ultima consultazione: 2026-xx-yy.
- #link(linkCapitolato)[#underline[@capitolato:cap] C7 - Ergon Informatica S.r.l. - SmartDashboard]. Ultima consultazione: 2026-11-13.
=== Riferimenti informativi
- #link(linkVerbaleEsterno)[#underline[Verbale esterno del 2026-11-13]]. Ultima consultazione: 2026-11-13.
- #link(linkLezioneAnalisi)[#underline[Lezione del prof. Tullio sull'@analisi-dei-requisiti]]. Ultima consultazione: 2026-11-15.
- #underline[@glossario:cap]. Ultima consultazione: 2026-11-13.
= Casi d'uso
== Descrizione associata al caso d'uso
Ogni @caso-d-uso si  compone di tutte le informazioni presenti nella seguente
tabella, salvo i casi in cui uno specifico campo non risulti rilevante.
#figure(
  table(
    columns: (0.3fr, 1fr),
    fill: (col, row) => if row == 0 { rgb("e8e8e8") },
    [#strong[Campo]], [#strong[Descrizione]],
    [Grafico @uml], [Rappresenta lo scenario del @caso-d-uso in oggetto.],
    [@attore:cap primario], [Rappresenta coloro che interagiscono in quel sistema, senza il controllo da parte del sistema.],
    [@attore:cap secondario], [Rappresenta coloro che che il sistema contatta o utilizza per completare il @caso-d-uso, oppure che riceve notifiche/dati in risposta all'azione avviata dall'@attore primario.],
    [Scenario principale], [La sequenza ragionevole delle operazioni che l’@attore deve effettuare per portare a compimento lo scenario.],
    [Precondizioni], [Lista di elementi necessari per far sì che l’@attore possa soddisfare il @caso-d-uso in oggetto.],
    [Postcondizioni], [Lista di elementi che descrive le modifiche effettuate internamente dopo il corretto avvenimento dello scenario principale.],
    [Scenario alternativo], [Rappresenta un comportamento valido ma non principale, che devia dal flusso base a causa di errori.],
    [Inclusioni], [Ulteriori Casi d’Uso che l’@attore deve compiere per portare a termine lo scenario.],
    [Estensioni], [Relazione che aggiunge comportamento opzionale o alternativo a un caso d’uso completo, attivata solo al verificarsi di una condizione specifica.],
    [Specializzazioni], [Rappresentazioni di varianti del caso d’uso generale, sono tra loro mutualmente esclusive. Non impongono un percorso di esecuzione obbligatorio.],
    [Trigger], [Evento o @funzionalita che avvia il @caso-d-uso.],
  ),
  caption: [Campi dei casi d'uso e loro descrizione]
) <DescrizioneCasoUso>
#pagebreak()
== Attori
#figure(
  image("Assets/attori.svg", width: 60%),
  caption: [Attori principali del sistema SmartDashboard]
) \
#figure(
  table(
    columns: (0.4fr, 1fr),
    fill: (col, row) => if row == 0 { rgb("e8e8e8") },
    [#strong[Attore]], [#strong[Descrizione]],
    [Utente], [Indica quando il @caso-d-uso è generico e può essere eseguito da qualsiasi @attore.],
    [Dipendente], [Accede al sistema per visualizzare e analizzare i dati aziendali tramite le @dashboard.],
    [@amministratore:cap], [Gestisce gli utenti e i relativi permessi; crea delle @dashboard aziendali.],
    [@amministratore:cap di gestione], [Crea altri utenti, ne imposta i ruoli e gli abilita o disabilita le autorizzazioni; ha accesso alle impostazioni generali della piattaforma (configurazione @api).],
  ),
  caption: [Descrizione attori]
) <Attori>
#pagebreak()

== Lista casi d'uso
=== UC_01: ???

#pagebreak()
= Requisiti
Vengono ora descritti i requisiti individuati dal gruppo ByteClub.\ I requisiti vengono classificati in:
- *Funzionali*: requisiti che individuano ciò che il sistema deve presentare per soddisfare l’aspettativa.
- *Qualità*: requisiti che individuano la qualità del @progetto realizzato.
- *Vincolo*: requisiti che individuano le restrizioni del sistema, come ad esempio l’utilizzo di determinate tecnologie e di specifiche caratteristiche tecniche.
Per chiarimenti sulla nomenclatura utilizzata si rimanda al documento #link(linkNormeProgetto)[#underline[@norme-di-progetto]].
== Requisiti funzionali
=== Requisiti funzionali obbligatori
#figure(
  table(
    columns: (0.4fr, 1fr, 0.4fr),
    fill: (col, row) => if row == 0 { rgb("e8e8e8") },
    [#strong[Codice]], [#strong[Descrizione]], [#strong[Fonti]],
    [Codice requisito], [Testo della descrizione], [Link al riferimento],
  ),
  caption: [Requisiti funzionali obbligatori]
) <RequisitiFunzionaliObbligatori>
=== Requisiti funzionali desiderabili
#figure(
  table(
    columns: (0.4fr, 1fr, 0.4fr),
    fill: (col, row) => if row == 0 { rgb("e8e8e8") },
    [#strong[Codice]], [#strong[Descrizione]], [#strong[Fonti]],
    [Codice requisito], [Testo della descrizione], [Link al riferimento],
  ),
  caption: [Requisiti funzionali desiderabili]
) <RequisitiFunzionaliDesiderabili>
=== Requisiti funzionali opzionali
#figure(
  table(
    columns: (0.4fr, 1fr, 0.4fr),
    fill: (col, row) => if row == 0 { rgb("e8e8e8") },
    [#strong[Codice]], [#strong[Descrizione]], [#strong[Fonti]],
    [Codice requisito], [Testo della descrizione], [Link al riferimento],
  ),
  caption: [Requisiti funzionali opzionali]
) <RequisitiFunzionaliOpzionali>
== Requisiti di qualità
=== Requisiti di qualità obbligatori
#figure(
  table(
    columns: (0.4fr, 1fr, 0.4fr),
    fill: (col, row) => if row == 0 { rgb("e8e8e8") },
    [#strong[Codice]], [#strong[Descrizione]], [#strong[Fonti]],
    [Codice requisito], [Testo della descrizione], [Link al riferimento],
  ),
  caption: [Requisiti di qualità obbligatori]
) <RequisitiQualitaObbligatori>
== Requisiti di vincolo
=== Requisiti di vincolo obbligatori
#figure(
  table(
    columns: (0.4fr, 1fr, 0.4fr),
    fill: (col, row) => if row == 0 { rgb("e8e8e8") },
    [#strong[Codice]], [#strong[Descrizione]], [#strong[Fonti]],
    [Codice requisito], [Testo della descrizione], [Link al riferimento],
  ),
  caption: [Requisiti di vincolo obbligatori]
) <RequisitiVincoloObbligatori>
== Tracciamento dei casi d'uso e riepilogo
#figure(
  table(
    columns: (0.4fr, 1fr),
    fill: (col, row) => if row == 0 { rgb("e8e8e8") },
    [#strong[@caso-d-uso:cap]], [#strong[Requisiti associati]],
    [Codice caso d'uso], [Codici dei requisiti associati al caso d'uso],
  ),
  caption: [Tracciamento dei casi d'uso e riepilogo dei requisiti]
) <TracciamentoCasiUso>
== Riepilogo dei requisiti
#figure(
    table(
      columns: (1fr, 1fr, 1fr, 1fr),
      fill: (col, row) => if row == 0 { rgb("e8e8e8") },
      [#strong[Tipologia]], [#strong[Obbligatori]], [#strong[Desiderabili]], [#strong[Opzionali]],
      [*Funzionali*], [x], [y], [z],
      [*Qualità*], [x], [y], [z],
      [*Vincolo*], [x], [y], [z],
    ),
    caption: [Riepilogo dei requisiti]
  ) <RiepilogoRequisiti>