#import "/docs/5_Templates/documento.typ": *

// Nomenclatura: Studio_di_Fattibilita-v1.0.0.typ
// Documento interno, stessa struttura di lettera e valutazione capitolati.
// Verifica e approvazione verranno aggiunte dopo la revisione.

#show: documento.with(
  titolo: "Studio di Fattibilità",
  versione: "1.0.0",
  stato: "In redazione",
  redazione: (LS),
  verifica: "",
  approvazione: "",
  proprietario: "ByteClub",
  uso: "Interno",
  destinatari: "Gruppo ByteClub",
  modifiche: (
    ("1.0.0", "2026-10-30", LS, "Prima stesura dello Studio di Fattibilità."),
  ),
  indice: true,
)

= Introduzione
== Scopo del documento
Il presente documento, ad uso interno del gruppo ByteClub, raccoglie l'analisi di fattibilità dei capitolati esaminati e motiva la scelta del capitolato *C3 - FossDot*. Per il capitolato scelto vengono riportati le motivazioni, le strategie di mitigazione dei rischi, il piano di formazione preliminare e l'impegno orario stimato. Per i capitolati scartati vengono riportati descrizione, vincoli, aspetti positivi, fattibilità, valutazione economica e motivi di scarto.
== Capitolati analizzati
Il gruppo ha analizzato in dettaglio tre capitolati, in ordine di preferenza:
+ *C3 - FossDot* (Uranion EMEA Ltd), capitolato scelto;
+ *C8 - Sonar* (Halue S.r.l. Società Benefit), scartato;
+ *C1 - AURA* (Vimar S.p.A.), scartato.

Gli altri capitolati proposti (C0, C2, C4, C5, C6, C7 e C9) sono stati esaminati in modo più sintetico e sono descritti nel documento esterno _Valutazione Capitolati_.

= Capitolato scelto: C3 - FossDot
== Motivazioni della scelta
*Proponente:* Uranion EMEA Ltd.

*Descrizione.* FossDot prevede la realizzazione di uno smart speaker open source, estensibile e rispettoso della privacy, alternativo ai dispositivi commerciali chiusi come Amazon Echo Dot e Google Nest. L'ecosistema comprende hardware di riferimento, firmware embedded, un servizio di bridging verso provider AI configurabili (pipeline Speech-to-Text, LLM, Text-to-Speech), l'integrazione di servizi esterni tramite Model Context Protocol (MCP), Skills e Agents, e un'interfaccia web per registrare e gestire più dispositivi. L'obiettivo è offrire una piattaforma vocale domestica aperta, in cui il proprietario sceglie il provider AI, ispeziona ciò che viene inviato ai servizi remoti e fa cooperare più dispositivi.

*Tecnologie e vincoli.* Uranion non impone uno stack: la scelta spetta al gruppo, che deve motivarla. Come riferimenti non prescrittivi il capitolato cita Rust embedded ed Embassy, Raspberry Pi, Seeed ReSpeaker, openWakeWord, Silero VAD, faster-whisper, Piper, MCP, Ollama, Axum e Tokio. Il firmware in Rust è una preferenza e un valore aggiunto, non un vincolo. Sono obbligatori la licenza open source permissiva (MIT o Apache 2.0), un collaudo end-to-end su dispositivo fisico (wake word, domanda, risposta vocale), il rispetto del GDPR sui flussi audio e, per bridging e interfaccia di gestione, una copertura dei test di riferimento ≥ 80%; per il firmware il livello è concordato con la proponente. Il gruppo può fermarsi all'MVP o procedere alla consegna completa.

*Motivazioni della scelta.* Il gruppo ByteClub ha selezionato FossDot dopo aver confrontato opportunità formative, complessità tecnica e fattibilità delle proposte esaminate:

- *Allineamento con le competenze disponibili:* il gruppo ha una buona base nella programmazione orientata agli oggetti, nell'utilizzo di Git e nella configurazione di ambienti Linux, oltre a una certa familiarità con i modelli linguistici in locale tramite Ollama. Queste competenze sono un punto di partenza per il backend e l'integrazione dei servizi AI, mentre gli aspetti embedded e la gestione dell'audio richiedono un approfondimento.

- *Interesse tecnico e professionale:* FossDot permette di lavorare con modelli linguistici, riconoscimento e sintesi vocale, MCP e sistemi embedded, approfondendo l'intelligenza artificiale applicata, i sistemi distribuiti e l'integrazione tra software e hardware.

- *Rapporto tra complessità e fattibilità:* il perimetro è delimitato da una consegna minima (MVP) e da una completa, e il gruppo può fermarsi all'MVP. Esistono molti progetti open source di riferimento che riducono il rischio tecnologico, e il collaudo su un dispositivo fisico è un risultato concreto e verificabile.

- *Libertà progettuale e modularità:* poter motivare le scelte su tecnologie e componenti hardware permette di adattarle alle competenze e ai tempi del gruppo. La separazione tra firmware, backend, provider AI e interfaccia favorisce la suddivisione del lavoro. La licenza permissiva consente di pubblicare il lavoro e citarlo nel curriculum.

- *Rapporto con il proponente:* il confronto esplorativo con Uranion (Appendice B) ha chiarito la configurabilità dei provider AI, la pipeline audio, la gestione degli aggiornamenti e le funzionalità minime per la comunicazione tra più smart speaker. Uranion ha manifestato disponibilità a fornire supporto tecnico, sessioni formative e incontri di approfondimento, con comunicazione via Mattermost, e-mail e videochiamata.

*Criticità riscontrate.* L'integrazione tra hardware e software può allungare i tempi di setup e testing; l'esperienza del gruppo con i componenti hardware è limitata; l'apprendimento di Rust, se scelto, può pesare sui tempi; la progettazione CAD di un eventuale contenitore non è obbligatoria ma è apprezzata e richiede competenze specifiche. Il capitolato non indica chi sostiene il costo dei componenti hardware e il testing del firmware è più oneroso di quello software. Infine FossDot ha capienza di un solo gruppo nel primo lotto, quindi l'assegnazione non è garantita.

Nel complesso FossDot presenta un rapporto equilibrato tra complessità, possibilità di apprendimento e libertà progettuale. Le competenze da acquisire sono una sfida significativa, ma affrontabile con una pianificazione progressiva.
== Strategie di mitigazione dei rischi
L'analisi di fattibilità ha evidenziato rischi tecnologici, di personale, sui requisiti e sulle tempistiche. Il gruppo intende adottare le seguenti strategie:

- *Capienza del capitolato:* FossDot può essere assegnato a un solo gruppo nel primo lotto. Il gruppo ha dichiarato le preferenze nel foglio condiviso e ha analizzato C8 e C1 come alternative (sezione dei capitolati scartati), per poter ripartire senza perdere il lavoro svolto.

- *Costo e disponibilità dell'hardware:* verrà chiesto a Uranion chi sostiene l'acquisto dei componenti e se può fornirne parte. La scelta cadrà su componenti diffusi e ben documentati, con una distinta base chiara.

- *Integrazione tra hardware e software:* prima di sviluppare l'intero sistema verranno configurati e verificati i componenti selezionati, controllando progressivamente acquisizione audio, riproduzione e funzionamento del dispositivo.

- *Apprendimento delle tecnologie embedded:* lo studio partirà nelle prime fasi. L'MVP potrà essere sviluppato su una scheda con Linux e un linguaggio già noto; il firmware in Rust, preferenza e non vincolo, sarà valutato in un secondo momento.

- *Complessità della pipeline audio:* il flusso verrà implementato e verificato per fasi (wake word locale, trascrizione, elaborazione della richiesta, risposta), con test separati dei componenti. Sarà prevista anche l'attivazione manuale (push-to-talk), ammessa dal capitolato.

- *Dipendenza da provider esterni:* l'accesso ai modelli AI e ai servizi di trascrizione sarà isolato dietro interfacce dedicate, per sostituire un provider in caso di indisponibilità o limiti. Per sviluppo e test si potranno usare modelli locali con Ollama.

- *Privacy e protezione dei dati:* la wake word sarà rilevata localmente; l'invio dell'audio ai servizi di trascrizione sarà coerente con le scelte architetturali documentate. STT e TTS interamente locali, previsti come evoluzione, saranno valutati dopo l'MVP. Particolare attenzione a segreti e chiavi API.

- *Aggiornamenti e affidabilità del dispositivo:* saranno considerate soluzioni che riducano il rischio di corruzione del sistema in caso di spegnimento improvviso e che consentano aggiornamenti controllati.

- *Test del firmware:* il livello di copertura sarà concordato con Uranion; per le componenti software il riferimento è ≥ 80% con report.

- *Tempi e requisiti:* sviluppo per incrementi verificabili con priorità all'MVP; integrazioni MCP, Skills e Agents e funzioni multi-dispositivo avanzate saranno pianificate dopo aver consolidato il nucleo.

- *Disponibilità dei componenti del gruppo:* calendario condiviso, rotazione dei ruoli e margine di sicurezza nel preventivo per i periodi di esami.

- *Coordinamento e integrazione:* interfacce concordate, responsabilità definite, versionamento e test progressivi; in caso di ritardi le funzionalità non essenziali saranno rinviate.
== Piano di formazione preliminare
*Competenze disponibili:* buona base nei linguaggi orientati agli oggetti, conoscenza di sistemi Linux, utilizzo di Git e familiarità con i modelli linguistici in locale tramite Ollama.

*Competenze da acquisire:* programmazione embedded e system-level, streaming audio asincrono e protocolli di rete in tempo reale, configurazione dell'hardware e, se scelto, Rust.

*Piano di formazione.* La formazione procederà in parallelo con la configurazione dell'ambiente e i primi prototipi:

- *Hardware e sistemi embedded:* documentazione della scheda e dei componenti scelti (ad esempio Raspberry Pi e array di microfoni Seeed ReSpeaker come riferimenti del capitolato). Se si valuta Rust, Rust Embedded Book ed Embassy.
- *Elaborazione audio:* streaming asincrono, wake word (ad esempio openWakeWord), voice activity detection (ad esempio Silero VAD), STT (ad esempio faster-whisper) e TTS (ad esempio Piper), con l'obiettivo di una pipeline minima verificabile.
- *Backend e comunicazione:* framework asincroni e protocolli di rete per il servizio di bridging (ad esempio Axum e Tokio, se si sceglie Rust) e scoperta dei dispositivi in rete.
- *Integrazione dei modelli AI:* API dei provider, configurabilità, gestione degli errori, modelli locali con Ollama, MCP, Skills e Agents.
- *Prior art:* Willow e Rhasspy / Home Assistant, indicati dal capitolato come ispirazione.
- *Affidabilità, test e aggiornamenti:* verifica dei singoli componenti, gestione degli errori e protezione da interruzioni e aggiornamenti non riusciti.

*Stima dei tempi.* Circa due settimane per studiare la documentazione hardware, configurare la pipeline audio e approfondire i framework asincroni del servizio di bridging, più una settimana per familiarizzare con i sistemi embedded selezionati. È una stima iniziale, da aggiornare in base ai risultati. Il gruppo userà anche gli incontri di approfondimento e le sessioni formative di Uranion.
== Impegno orario stimato
L'impegno è quello definito nel preventivo dei costi e degli impegni orari del gruppo ByteClub: *552 ore produttive*, pari a *92 ore per ciascuno dei sei componenti*, per un costo preventivato di *11.490 €* e una scadenza ultima di consegna prevista al *2027-03-21*.

Le ore saranno distribuite tra responsabilità e coordinamento, amministrazione, analisi, progettazione, programmazione e verifica, secondo la ripartizione del preventivo, e coprono analisi dei requisiti, formazione, progettazione, implementazione, integrazione hardware-software, verifica e collaudo.

*Valutazione economica.* Il monte ore è adeguato all'MVP, che richiede un solo provider AI configurabile, un flusso end-to-end su dispositivo fisico e un'interfaccia minima. La consegna completa è più impegnativa, quindi si darà priorità all'MVP e si tratteranno le estensioni in base all'avanzamento. Le incognite principali sono costo e tempi di approvvigionamento dell'hardware e il tempo di integrazione tra firmware e servizio. Come piano alternativo, se l'integrazione embedded si rivelasse troppo onerosa, l'MVP può essere realizzato su una scheda con Linux e un linguaggio già noto, rinviando Rust. La ripartizione sarà monitorata e ricalibrata nel rispetto del preventivo.

= Capitolati scartati
== Capitolato C8 - Sonar
*Proponente:* Halue S.r.l. Società Benefit.

*Descrizione.* Sonar è una piattaforma web che si collega a uno store Shopify, ne acquisisce configurazioni e codice dei temi tramite le Admin API e ricostruisce un grafo di dipendenze tra entità (app, webhook, campi personalizzati, file di tema). Un motore di regole estensibile segnala orfani e codice morto, e il sistema produce documentazione consultabile ed esportabile, con confronto tra snapshot successivi.

*Tecnologie e vincoli.* Lo stack è vincolante: Next.js su Vercel, Vercel Workflows e Cron Jobs, Supabase (PostgreSQL con Row Level Security), autenticazione solo Google, TypeScript strict e Shopify Admin GraphQL API. I requisiti obbligatori sono trentaquattro (venti funzionali, sette di qualità e sicurezza, sette non funzionali), con copertura dei test ≥ 70%, almeno il 95% di casi di test superati e falsi positivi ≤ 10% sulle segnalazioni ad alta severità. Una riduzione dell'ambito è possibile solo con accordo scritto con Halue.

*Aspetti positivi.* Problema reale, requisiti e criteri di accettazione molto chiari, architettura modulare, tecnologie web diffuse e spendibili, incontri quindicinali con la proponente e competenze su Shopify Plus.

*Fattibilità.* Il gruppo ha conoscenze di base di sviluppo web e di database relazionali; sarebbero da apprendere Vercel Workflows, Supabase con Row Level Security, il modello a punti del rate limiting di Shopify, il parsing di file Liquid e gli strumenti di test (Vitest, Playwright, MSW), con circa due settimane di studio iniziale.

*Valutazione economica.* Con 552 ore il perimetro obbligatorio è molto ampio rispetto al budget e il rapporto tra ore e complessità è sfavorevole, soprattutto per la costruzione dello store di test e per le soglie di accettazione. La riduzione dell'ambito richiede un accordo scritto con Halue con anticipo.

*Motivi di scarto.* Sonar è stata la seconda preferenza del gruppo, ma è stato scartato per questi motivi:
- *Stack vincolante:* Vercel, Supabase, autenticazione Google e TypeScript strict; una deroga va richiesta entro l'analisi dei requisiti. È l'opposto della libertà tecnologica di FossDot.
- *Dominio specifico:* servono conoscenze di Shopify (GraphQL, metafield, temi Liquid, rate limiting), poco riusabili al di fuori della piattaforma.
- *Ampiezza dei requisiti:* trentaquattro requisiti obbligatori con soglie di accettazione severe.
- *Lavoro preliminare:* costruzione e documentazione di uno store Shopify di test a carico del gruppo.
- *Limiti dei piani gratuiti e supporto:* Supabase e Vercel hanno soglie basse da monitorare a ogni incontro; non c'è un canale di messaggistica condiviso (solo una casella di posta dedicata) né incontri in presenza.
- *Interesse tecnico:* inferiore rispetto a FossDot, che copre l'intera catena da hardware a servizi.
== Capitolato C1 - AURA
*Proponente:* Vimar S.p.A.

*Descrizione.* AURA prevede un server e un client MCP che espongono le API KNX IoT 3rd-party di Vimar a servizi AI commerciali (ad esempio Claude, ChatGPT, Gemini), per monitorare e controllare in linguaggio naturale luci, termostati, tapparelle e altri dispositivi di un impianto domotico residenziale, con un'infrastruttura cloud-ready.

*Tecnologie e vincoli.* Sono obbligatori Docker Compose come Infrastructure as Code, compatibilità con AWS, MCP, API KNX IoT con OAuth2 e notifiche in push tramite Subscription (il polling non è ammesso). Il server MCP deve supportare le API Authorization, Datapoint, Function, Information, Location, Subscription e Timeseries. La copertura dei test deve essere ≥ 75% (unità e integrazione) e ≥ 80% (end-to-end).

*Aspetti positivi.* Tecnologie innovative (MCP, LLM, IoT); applicazione concreta su un kit domotico View Wireless fornito da Vimar; sede a Padova con almeno due incontri in presenza, stati di avanzamento bisettimanali e spazio su AWS se richiesto; casi d'uso già elencati (17 base e 21 avanzati); tecnologia MCP in comune con FossDot.

*Fattibilità.* Le competenze generali del gruppo su Git, Linux e modelli linguistici sono applicabili; sarebbero da apprendere MCP, API KNX IoT con OAuth2, Docker Compose come Infrastructure as Code e servizi AWS, con circa due settimane di studio iniziale (stima preliminare).

*Valutazione economica.* Il perimetro obbligatorio è ben definito e confrontabile con il monte ore di 552 ore, ma le soglie di test elevate e l'infrastruttura come codice assorbirebbero una quota significativa delle ore di verifica. Il rapporto tra ore e complessità è accettabile.

*Motivi di scarto.*
- *Elevata concorrenza:* numerosi gruppi hanno indicato C1 tra le proprie preferenze. Con una capienza di due gruppi nel primo lotto, la probabilità di assegnazione sarebbe più bassa; il gruppo ha preferito proposte con maggiori probabilità di essere ottenute.
- *Ecosistema proprietario:* l'accesso alla documentazione KNX IoT richiede registrazione sul sito Vimar e la firma di un documento d'uso, e la soluzione ha senso solo con impianti Vimar.
- *Componente AI esterna:* l'agente è un servizio commerciale già esistente; il lavoro si concentra sull'adattatore MCP, senza pipeline audio, AI configurabile né firmware.
- *Requisiti rigidi e test elevati:* Infrastructure as Code, OAuth2, supporto alle API richieste e soglie di copertura ≥ 75% e ≥ 80%.
- *Complessità dell'integrazione:* il coordinamento tra modelli AI, MCP, API KNX IoT e dispositivi fisici rende più complessi sviluppo, debugging e testing, e l'uso di modelli linguistici per comandare dispositivi reali richiede controlli per evitare operazioni errate.
- *Overhead di processo:* gli stati di avanzamento richiedono agenda inviata in anticipo e relatore a turno.

AURA è di elevato interesse tecnologico e coerente con FossDot per tema, ma il gruppo ha preferito FossDot per la completezza dell'ecosistema, la libertà tecnologica e la maggiore probabilità di assegnazione.

#pagebreak()
= Appendice A - Contatti aziende


#pagebreak()
= Appendice B - Verbali dei colloqui esplorativi

