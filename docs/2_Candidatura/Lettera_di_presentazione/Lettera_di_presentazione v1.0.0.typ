// Lettera di Presentazione - ByteClub

#import "/docs/5_Templates/base.typ": tabellaDati, tutti, BG, EH, MMI, MMO, RP, LS
#import "/docs/5_Templates/documento.typ": documento

#let gruppo = "ByteClub"
#let email = "byteclubunipd@gmail.com"
#let codice = "C7"
#let titolo = "SmartDashboard: piattaforma web di Business Intelligence"
#let proponente = "Ergon Informatica S.r.l."


#let repo = "https://github.com/byteclubunipd/Progetto-SWE"
#let sito = "https://byteclubunipd.github.io/Progetto-SWE/"
#let link-val = "https://byteclubunipd.github.io/Progetto-SWE/docs/6_Output/2_Candidatura/Valutazione_Capitolati%20v1.0.0.pdf"
#let link-prev = "https://byteclubunipd.github.io/Progetto-SWE/docs/6_Output/2_Candidatura/Preventivo_costi_impegni%20v1.1.0.pdf"
#let link-VE = "INSERIRE LINK VE MEETING ERGON"

#let costo = "11.070"
#let ore = "540"
#let ore-persona = "90"
#let scadenza = "2027/04/16"

#show: documento.with(
  titolo: "Lettera di presentazione",
  versione: "2.0.0",
  mostraInformazioni: false,
  mostraRegistro: false,
  stato: "Approvato",
  redazione: BG,
  verifica: RP,
  approvazione: LS,
  proprietario: gruppo,
  uso: "Esterno",
  destinatari: "Prof. Vardanega Tullio \nProf. Cardin Riccardo",
  indice: false,
)

\ \ \ \ \ \
Egregio Professore Vardanega, \
Egregio Professore Cardin,

con la presente, il gruppo #gruppo comunica formalmente la propria candidatura
per l'aggiudicazione del capitolato *#codice - "#titolo"*, proposto dall'azienda
#proponente. Qualora la capienza del capitolato non lo consentisse, il gruppo indica come alternative, in ordine di preferenza, *C8 - Sonar* proposto da Halue e *C9 - SpecCheck* proposto da Zucchetti.

La documentazione completa è consultabile nel #link(repo)[#underline[*repository*]] pubblico e nel #link(sito)[#underline[*sito web*]] del gruppo, dove sono disponibili:
- #link(link-val)[#underline[Valutazione dei capitolati]];
- #link(link-prev)[#underline[Preventivo dei costi e impegno orario]] (totale, individuale e per ruolo);
- Verbali interni ed esterni.
#pagebreak()
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

Il gruppo #gruppo si impegna formalmente a monitorare i costi di progetto operando nel rispetto del budget preventivato, documentando e motivando ogni eventuale scostamento, e assicurando il rispetto del monte ore dichiarato da ciascun componente.

= Motivazione della scelta

Il gruppo ha selezionato il capitolato *#codice* per le seguenti ragioni:

- *Interesse tecnico:* il progetto offre l'opportunità di sviluppare una piattaforma di Business Intelligence end-to-end completa, gestendo l'intero ciclo di vita del dato. L'aspetto più stimolante è l'integrazione di un layer di Intelligenza Artificiale (basato su LLM) per la costruzione conversazionale delle dashboard e la generazione di insight automatici.
- *Libertà tecnologica:* #proponente propone un'architettura modulare a tre livelli e suggerisce tecnologie moderne e performanti (come DuckDB per l'OLAP, Python/Polars per l'ETL e React/Vue per il frontend), ma lascia al gruppo la totale libertà di integrare strumenti diversi e di cambiare quelli definiti, purché la scelta sia motivata e adeguata agli obiettivi.
- *Supporto dell'azienda:* #proponente garantisce un forte affiancamento, con incontri di allineamento periodici ogni 15 giorni con il referente tecnico e disponibilità per sessioni più ravvicinate con un incontro in sede in caso di necessità, mettendo a disposizione una sala riunioni per i gruppo. Un grande valore aggiunto è la disponibilità dell'azienda a fornire un dataset basato su un caso di studio reale (vendite, ordini, logistica), fondamentale per testare il motore analitico e l'efficacia dell'AI giá per il primo PoC.
- *Rischi affrontabili:* le sfide principali riguardano l'affidabilità del layer AI (evitare "allucinazioni" e garantire l'esattezza dei dati restituiti a partire da domande in linguaggio naturale) e i vincoli architetturali (sicurezza e isolamento delle query). Questi rischi sono mitigati dalla netta separazione delle responsabilità tra il backend analitico e il frontend, oltre all'uso suggerito di API commerciali (es. OpenAI/Claude) che permettono di concentrarsi sulla logica applicativa anziché sull'infrastruttura del modello linguistico.
- *Confronto con le alternative:* abbiamo valutato anche altri capitolati tra quelli rimanenti, come C8 (Sonar, di Halue) e C9 (SpecCheck, di Zucchetti). Il confronto ha evidenziato come il C7 offra il miglior bilanciamento tra l'ingegneria del software classica (modellazione dati, sviluppo web) e le nuove frontiere dell'AI generativa applicata ai dati, risultando il progetto con il miglior rapporto tra innovazione e fattibilità per il gruppo.
- *Obiettivo graduale:* il progetto è intrinsecamente strutturato per consentire un approccio di sviluppo fortemente incrementale, diviso in 4 fasi. Questo ci permetterà di consolidare prima il nucleo vitale della piattaforma (pipeline dati e web app per dashboard self-service) e di estendere progressivamente le funzionalità AI (generazione widget, insight automatici, spiegazioni causali), garantendo la consegna di un prodotto funzionante a prescindere dal completamento delle estensioni più complesse.

= Correzioni effettuate
In risposta ai rilievi emersi durante la prima candidatura, il gruppo ha rivisto le proprie scelte e definito le seguenti azioni correttive::
- *Scelta del nuovo capitolato*: tra i capitolati disponibili rimanenti, abbiamo scelto di candidarci per _"#codice: #titolo"_. Questa decisione è stata presa dopo un incontro conoscitivo avvenuto in data 2026/11/04, in cui #proponente si è dimostrato con immediatezza molto disponibile per il gruppo, rispondendo chiaramente alle nostre domande e ai dubbi riguardo il capitolato (il tutto consultabile nel #link(link-VE)[#underline[verbale esterno]] dedicato). Il meeting ci ha fatto capire che il progetto è più comprensibile ad ogni membro del gruppo ed è più fattibile per le competenze che abbiamo, ritrovandolo più stimolante rispetto alle altre preferenze elencate in precedenza.
- *Miglioramento dei template per la documentazione*: abbiamo modificato i template dei verbali rendendo il versionamento migliore. Ora ogni versione del documento, quindi ad ogni modifica minore o sostanziale, viene verificata prima di procedere.
- *Sito web*: Abbiamo ottimizzato l'organizzazione delle diverse tipologie dei documenti e l'ordinamento per quelli necessari riguardo la candidatura. Inoltre, per agevolare la navigazione, i file PDF presenti sul sito si aprono ora in una nuova scheda del browser anziché nella pagina corrente.

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
#v(1em)
Cordiali saluti, \
Il gruppo #gruppo.
