// Lettera di Presentazione - ByteClub

#import "../5_Templates/base.typ": tabellaDati, tutti, BG, EH, MMI, MMO, RP, LS
#import "../5_Templates/documento.typ": documento

#let gruppo = "ByteClub"
#let email = "byteclubunipd@gmail.com"
#let data = "2026-10-30" 
#let codice = "C3"
#let titolo = "FossDot: smart speaker open source, estensibile e rispettoso della privacy"
#let proponente = "Uranion EMEA Ltd"


#let repo = "https://byteclubunipd.github.io/Progetto-SWE/"
#let link-val = "https://byteclubunipd.github.io/Progetto-SWE/docs/6_Output/2_Candidatura/Valutazione_Capitolati%20v1.0.0.pdf"
#let link-prev = "https://byteclubunipd.github.io/Progetto-SWE/docs/6_Output/2_Candidatura/Preventivo_costi_impegni%20v1.0.0.pdf"

#let costo = "11.490"
#let ore = "552"
#let ore-persona = "92"
#let scadenza = "2027-03-21"

#show: documento.with(
  titolo: "Lettera di Presentazione",
  versione: "1.0.0",
  stato: "Approvato",
  redazione: (LS),
  verifica: BG,
  approvazione: "Tutto il gruppo",
  proprietario: gruppo,
  uso: "Esterno",
  destinatari: "Prof. Vardanega Tullio \nProf. Cardin Riccardo",
  modifiche: (
    ("1.0.0", "2026-10-29", "Tutto il gruppo", "Approvazione del documento"),
    ("0.2.0", "2026-10-29", BG, "Verifica del documento"),
    ("0.1.5", "2026-10-28", LS, "Aggiornamento del costo e stile"),
    ("0.1.2", "2026-10-24", LS, "Scrittura introduzione"),
    ("0.1.1", "2026-10-23", LS, "Stesura motivazioni della scelta e conclusione"),
    ("0.1.0", "2026-10-22", LS, "Creazione del documento"),
  ),
  indice: true,
)

Egregio Professore Vardanega, \
Egregio Professore Cardin,

con la presente, il gruppo #gruppo comunica formalmente la propria candidatura
per l'aggiudicazione del capitolato *#codice* "#titolo", proposto dall'azienda
#proponente.

La documentazione completa è consultabile nel #link(repo)[#underline[repository]]
pubblico, dove sono disponibili:
- #link(link-val)[#underline[Valutazione dei capitolati]];
- #link(link-prev)[#underline[Preventivo dei costi e impegno orario]] (totale, individuale e per ruolo);
- Verbali interni;
- Verbali esterni.

= Resoconto degli incontri

In data 2026-10-21 si è svolto, tramite Google Meet, un incontro con i
rappresentanti di #proponente per chiarire i dubbi emersi dall'analisi del
capitolato. Il resoconto completo, con tutte le domande e risposte, è nel
verbale esterno del 2026-10-21. Gli esiti principali sono:

- *Provider AI:* il sistema deve supportare i protocolli standard de facto (OpenAI Responses API, Anthropic Messages) con preset per i servizi più noti, cloud e on-premise (es. OpenRouter, Ollama); alcuni provider hanno free tier sufficienti per un uso sporadico;
- *Privacy:* il rilevamento della wake word deve avvenire in locale sul dispositivo; solo dopo il suo riconoscimento il buffer del discorso viene inviato al server;
- *Hardware e firmware:* la lista hardware proposta non è vincolante e ogni combinazione ben motivata è accettata; Rust è una proposta, non un obbligo, e una scheda dotata di sistema operativo Linux è ammessa;
- *Skill:* deve esistere uno standard che permetta all'utente di creare nuove skill; per la dimostrazione il gruppo ne realizzerà una o due;
- *Interconnessione:* il minimo richiesto è che un FossDot invii un messaggio e un altro lo riceva; l'ideale è una chiamata in tempo reale tra i due dispositivi; l'interoperabilità con prodotti terzi è un valore aggiunto;
- *Contenitore:* per il prototipo CAD servono le misure della scatola progettata e le modalità di montaggio, con indicazione delle dimensioni e del posizionamento delle viti.

= Motivazione della scelta

Il gruppo ha selezionato il capitolato #codice per le seguenti ragioni:

- *Interesse tecnico:* il progetto copre l'intera catena di uno smart speaker (hardware, firmware embedded, servizio di bridging STT → LLM → TTS e interfaccia di gestione), con provider AI configurabili e protocollo MCP;
- *Libertà tecnologica:* #proponente non impone uno stack e chiede di motivare le scelte; l'unico vincolo è la licenza open source permissiva (Apache 2.0 o MIT);
- *Supporto dell'azienda:* sono previsti incontri SAL e sessioni di approfondimento tecnico con i software architect di #proponente;
- *Rischi affrontabili:* le criticità principali, ossia il linguaggio Rust e la limitata esperienza hardware, sono mitigate dal fatto che #proponente ha confermato che Rust non è obbligatorio e che una scheda dotata di sistema operativo Linux è accettata. Stimiamo 2-3 settimane iniziali di formazione;
- *Confronto con le alternative:* abbiamo valutato C1 (AURA) e C8 (Sonar) oltre agli altri capitolati. Il confronto è nella Valutazione dei capitolati: C3 è risultato il più in linea con gli interessi del gruppo e con un rapporto complessità/fattibilità sostenibile;
- *Obiettivo graduale:* il progetto consente un approccio incrementale, con una prima implementazione focalizzata sui requisiti minimi concordati e la possibilità di sviluppare successivamente funzionalità aggiuntive, compatibilmente con le risorse e le scadenze previste.

= Preventivo economico

#tabellaDati(
  colonne: (auto, 1fr),
  intestazioni: ([Voce], [Valore]),
  righe: (
    ([Costo totale preventivato], [€ #costo]),
    ([Monte ore produttive totali], [#ore ore]),
    ([Ore produttive per componente], [#ore-persona ore]),
    ([Scadenza ultima prevista], [#scadenza]),
  ),
)

È prevista una rotazione dei ruoli al termine di ogni sprint, pianificata in modo
da consentire a ciascun componente di ricoprire tutti i ruoli nel corso del
progetto, senza assumerne più di uno contemporaneamente.

= Impegno del gruppo

Il gruppo #gruppo si impegna formalmente a:
- monitorare i costi di progetto e operare nel rispetto del preventivo economico, motivando e documentando eventuali scostamenti;
- garantire il monte ore dichiarato da ciascun componente;
- seguire il way of working definito nelle Norme di Progetto;
- mantenere una comunicazione costante con proponente e committente.

= Componenti del gruppo

#tabellaDati(
  colonne: (1fr, 1fr, auto),
  intestazioni: ([Cognome], [Nome], [Matricola]),
  righe: (
    ([Grimaldi], [Bruno], [2048056]),
    ([Huang], [Elico], [2147952]),
    ([Milan], [Mattia], [2137968]),
    ([Monaco], [Margherita], [2138017]),
    ([Pontello], [Riccardo], [2076441]),
    ([Shiroka], [Lorenca], [2149035]),
  ),
)

Restiamo a disposizione per eventuali chiarimenti e colloqui.

#v(1em)
Cordiali saluti, \
Il gruppo #gruppo
