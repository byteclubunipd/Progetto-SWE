#import "/docs/5_Templates/documento.typ": *

#let gruppo = "ByteClub"
#let capitolato = "C7 - SmartDashboard"
#let proponente = "Ergon Informatica S.r.l."
#let dataConsegna = "2027-04-16"
#let dataInizioLavori = "2026-11-09"
#let dataAggiornamentoPreventivo = "2026-11-07"
#let numeroComponenti = 6

#let oreRTB = (30, 30, 60, 36, 48, 48)
#let orePB = (18, 24, 24, 78, 84, 60)
#let costiOrari = (30, 20, 25, 25, 15, 15)
#let oreTotali = oreRTB.zip(orePB).map(((orePeriodoRTB, orePeriodoPB)) => orePeriodoRTB + orePeriodoPB)
#let costiTotali = oreTotali.zip(costiOrari).map(((ore, costo)) => ore * costo)
#let oreRTBPerComponente = oreRTB.map(ore => ore / numeroComponenti)
#let orePBPerComponente = orePB.map(ore => ore / numeroComponenti)
#let monteOre = oreTotali.sum()
#let oreComponente = monteOre / numeroComponenti
#let costoPreventivato = costiTotali.sum()
#let oreRTBTotali = oreRTB.sum()
#let orePBTotali = orePB.sum()
#let costoRTB = oreRTB.zip(costiOrari).map(((ore, costo)) => ore * costo).sum()
#let costoPB = orePB.zip(costiOrari).map(((ore, costo)) => ore * costo).sum()
#let numeroTesto = valore => str(valore)

#show: documento.with(
  titolo: "Dichiarazione degli impegni e preventivo dei costi",
  mostraRegistro: true,
  versione: "2.0.0",
  stato: "Da approvare",
  redazione: RP,
  verifica: MMO,
  approvazione: LS,
  proprietario: gruppo,
  uso: "Esterno",

  destinatari: [
    Prof. Tullio Vardanega \
    Prof. Riccardo Cardin
  ],

  registroModifiche: (
    ("2.0.0", "2026-11-05", "Approvazione del documento.", LS, "-"),
    ("1.2.0", "2026-11-05", "Aggiornamento contenuto del documento per allinearlo al capitolato C7.", RP, MMO),
    ("1.1.0", "2026-11-04", "Aggiornamento struttura del documento a seguito della correzione della candidatura.", RP, MMO),
    ("1.0.0", "2026-10-28", "Approvazione del documento.", LS, "-"),
    ("0.3.0", "2026-10-26", "Verifica, correzione e aggiornamento riguardo i nuovi elementi emersi.", EH, RP),
    ("0.2.0", "2026-10-24", "Aggiunta della sezione di analisi dei ruoli.", EH, RP),
    ("0.1.0", "2026-10-23", "Prima stesura del documento.", EH, RP),
  ),
)

= Scopo del documento

Il presente documento accompagna la candidatura del gruppo #emph[#gruppo] per il capitolato #emph[#capitolato], proposto da #emph[#proponente]. Definisce il preventivo economico e temporale, l'organizzazione dei ruoli, i criteri di rotazione, il calendario di massima, i principali rischi e gli impegni assunti dal gruppo.

Le ore e i costi riportati costituiscono una stima iniziale. Le quantità per ruolo e per componente sono obiettivi di pianificazione e possono essere aggiornate dopo il consuntivo di uno sprint, purché ogni variazione sia motivata, verificata e registrata senza superare il monte ore e il costo approvati.

== Riferimenti

- Regolamento del progetto didattico di Ingegneria del Software, anno accademico 2026/2027. #footnote[#link("https://www.math.unipd.it/~tullio/IS-1/2026/Dispense/PD1.pdf")[Link al regolamento del progetto didattico]]
- Capitolato #capitolato e documentazione tecnica fornita da #proponente. #footnote[#link("https://www.math.unipd.it/~tullio/IS-1/2026/Progetto/C7-SD.pdf")[Link alla documentazione del capitolato C7]]
- Aggiudicazione dei capitolti I lotto, nello specifico la valutazione della precedente candidatura. #footnote[#link("https://stem.elearning.unipd.it/pluginfile.php/1458150/mod_resource/content/20/IS%202026-2027%20-%20Aggiudicazione%20Appalti%20-%20I%20Lotto.pdf")[Link al documento di aggiudicazione dei capitolati I lotto]]
- Lettera di presentazione del gruppo ByteClub. #footnote[#link("https://byteclubunipd.github.io/Progetto-SWE/docs/6_Output/2_Candidatura/Lettera_di_presentazione/Lettera_di_presentazione%20v2.0.0.pdf")[Link alla lettera di presentazione]]
- Valutazione dei capitolati del gruppo ByteClub. #footnote[#link("https://byteclubunipd.github.io/Progetto-SWE/docs/6_Output/2_Candidatura/Documenti_esterni/Valutazione_capitolati%20v2.0.0.pdf")[Link alla valutazione dei capitolati]]
- Verbali interni ed esterni della candidatura del gruppo ByteClub, con particolare riferimento agli incontri del 2026-10-30 #footnote[#link("https://byteclubunipd.github.io/Progetto-SWE/docs/6_Output/2_Candidatura/Verbali/Interni/VI_2026-10-30.pdf")[Link al verbale interno 2026-10-30]], 2026-11-03 #footnote[#link("https://byteclubunipd.github.io/Progetto-SWE/docs/6_Output/2_Candidatura/Verbali/Interni/VI_2026-11-03.pdf")[Link al verbale interno 2026-11-03]] e 2026-11-04 #footnote[#link("https://byteclubunipd.github.io/Progetto-SWE/docs/6_Output/2_Candidatura/Verbali/Esterni/VE_2026-11-04.pdf")[Link al verbale esterno 2026-11-04]].

= Composizione del gruppo

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

Il gruppo è composto da #numeroComponenti componenti. Ogni componente contribuisce a più ruoli durante il progetto, secondo la rotazione descritta nella sezione successiva. Il carico individuale previsto è di #oreComponente ore produttive, entro l'intervallo previsto dal regolamento.

= Preventivo delle ore e dei costi

#let ruoli = (
  "Responsabile",
  "Amministratore",
  "Analista",
  "Progettista",
  "Programmatore",
  "Verificatore",
)
#let totaleOre = monteOre
#let totaleCosti = costoPreventivato
#let totaleOreComponente = oreComponente

La ripartizione iniziale è stata costruita considerando il peso atteso delle attività di analisi, architettura, implementazione della pipeline dati e della web app, integrazione del layer AI#footnote[Artificial Intelligence] e verifica. Programmazione e verifica hanno un peso rilevante per la necessità di validare l'acquisizione e la trasformazione dei dati, il data warehouse, le dashboard, le API#footnote[Application Programming Interface] e le funzionalità di intelligenza artificiale. La suddivisione rimane comunque rivedibile sulla base dei consuntivi.

#let righeRuoli = (
  ([Resp.#footnote[Responsabile]], numeroTesto(costiOrari.at(0)), numeroTesto(oreTotali.at(0)), numeroTesto(costiTotali.at(0)), numeroTesto(oreRTB.at(0)), numeroTesto(oreRTBPerComponente.at(0)), numeroTesto(orePB.at(0)), numeroTesto(orePBPerComponente.at(0))),
  ([Amm.#footnote[Amministratore]], numeroTesto(costiOrari.at(1)), numeroTesto(oreTotali.at(1)), numeroTesto(costiTotali.at(1)), numeroTesto(oreRTB.at(1)), numeroTesto(oreRTBPerComponente.at(1)), numeroTesto(orePB.at(1)), numeroTesto(orePBPerComponente.at(1))),
  ([Anal.#footnote[Analista]], numeroTesto(costiOrari.at(2)), numeroTesto(oreTotali.at(2)), numeroTesto(costiTotali.at(2)), numeroTesto(oreRTB.at(2)), numeroTesto(oreRTBPerComponente.at(2)), numeroTesto(orePB.at(2)), numeroTesto(orePBPerComponente.at(2))),
  ([Prog.#footnote[Progettista]], numeroTesto(costiOrari.at(3)), numeroTesto(oreTotali.at(3)), numeroTesto(costiTotali.at(3)), numeroTesto(oreRTB.at(3)), numeroTesto(oreRTBPerComponente.at(3)), numeroTesto(orePB.at(3)), numeroTesto(orePBPerComponente.at(3))),
  ([Program.#footnote[Programmatore]], numeroTesto(costiOrari.at(4)), numeroTesto(oreTotali.at(4)), numeroTesto(costiTotali.at(4)), numeroTesto(oreRTB.at(4)), numeroTesto(oreRTBPerComponente.at(4)), numeroTesto(orePB.at(4)), numeroTesto(orePBPerComponente.at(4))),
  ([Verif.#footnote[Verificatore]], numeroTesto(costiOrari.at(5)), numeroTesto(oreTotali.at(5)), numeroTesto(costiTotali.at(5)), numeroTesto(oreRTB.at(5)), numeroTesto(oreRTBPerComponente.at(5)), numeroTesto(orePB.at(5)), numeroTesto(orePBPerComponente.at(5))),
)

#tabellaDati(
  colonne: (auto, auto, auto, auto, auto, auto, auto, auto),
  rigaTotale: 7,
  intestazioni: (
    [Ruolo],
    [Costo orario (€/h)],
    [Ore totali (h)],
    [Costo #linebreak() totale (€)],
    [Ore RTB#footnote[Requirements and Technology Baseline] totali (h)],
    [Ore RTB per componente (h)],
    [Ore PB#footnote[Product Baseline] totali (h)],
    [Ore PB per componente (h)],
  ),
  righe: righeRuoli + ((strong("Totale"), "-", strong(numeroTesto(totaleOre)), strong(numeroTesto(totaleCosti)), strong(numeroTesto(oreRTBTotali)), strong(numeroTesto(oreRTBPerComponente.sum())), strong(numeroTesto(orePBTotali)), strong(numeroTesto(orePBPerComponente.sum()))),),
)

Il costo totale preventivato è di *#totaleCosti €* per *#totaleOre ore produttive*, pari a *#totaleOreComponente ore* per componente. Il valore è una stima iniziale e costituisce il limite di riferimento per il controllo dei costi; eventuali scostamenti saranno discussi con i committenti e documentati nei verbali.

== Ore per componente, ruolo e periodo

La tabella mostra la ripartizione delle ore assegnate a ciascun componente nei periodi RTB e PB. Nel periodo RTB il carico è maggiore per i ruoli di Responsabile, Amministratore e Analista, coerentemente con le attività di studio dei requisiti, definizione dell’architettura e validazione del PoC#footnote[Proof of Concept]. Nel periodo PB, parte del carico si sposta verso i ruoli di Progettista, Programmatore e Verificatore, in coerenza con l’implementazione, l’integrazione e la verifica della piattaforma BI#footnote[Business Intelligence] e delle funzionalità AI.

#tabellaDati(
  colonne: (auto, auto, 0.8fr, 0.8fr, 0.8fr, 0.8fr, 1.1fr, 0.8fr),
  rigaTotale: 13,
  intestazioni: ([Componente], [Periodo], [Resp.], [Amm.], [Anal.], [Prog.], [Program.], [Verif.]),
  righe: (
    (table.cell(rowspan: 2, fill: tabellaRigaDispari)[#BG], [RTB], numeroTesto(oreRTBPerComponente.at(0)), numeroTesto(oreRTBPerComponente.at(1)), numeroTesto(oreRTBPerComponente.at(2)), numeroTesto(oreRTBPerComponente.at(3)), numeroTesto(oreRTBPerComponente.at(4)), numeroTesto(oreRTBPerComponente.at(5))),
    ([PB], numeroTesto(orePBPerComponente.at(0)), numeroTesto(orePBPerComponente.at(1)), numeroTesto(orePBPerComponente.at(2)), numeroTesto(orePBPerComponente.at(3)), numeroTesto(orePBPerComponente.at(4)), numeroTesto(orePBPerComponente.at(5))),
    (table.cell(rowspan: 2, fill: tabellaRigaPari)[#EH], [RTB], numeroTesto(oreRTBPerComponente.at(0)), numeroTesto(oreRTBPerComponente.at(1)), numeroTesto(oreRTBPerComponente.at(2)), numeroTesto(oreRTBPerComponente.at(3)), numeroTesto(oreRTBPerComponente.at(4)), numeroTesto(oreRTBPerComponente.at(5))),
    ([PB], numeroTesto(orePBPerComponente.at(0)), numeroTesto(orePBPerComponente.at(1)), numeroTesto(orePBPerComponente.at(2)), numeroTesto(orePBPerComponente.at(3)), numeroTesto(orePBPerComponente.at(4)), numeroTesto(orePBPerComponente.at(5))),
    (table.cell(rowspan: 2, fill: tabellaRigaDispari)[#MMI], [RTB], numeroTesto(oreRTBPerComponente.at(0)), numeroTesto(oreRTBPerComponente.at(1)), numeroTesto(oreRTBPerComponente.at(2)), numeroTesto(oreRTBPerComponente.at(3)), numeroTesto(oreRTBPerComponente.at(4)), numeroTesto(oreRTBPerComponente.at(5))),
    ([PB], numeroTesto(orePBPerComponente.at(0)), numeroTesto(orePBPerComponente.at(1)), numeroTesto(orePBPerComponente.at(2)), numeroTesto(orePBPerComponente.at(3)), numeroTesto(orePBPerComponente.at(4)), numeroTesto(orePBPerComponente.at(5))),
    (table.cell(rowspan: 2, fill: tabellaRigaPari)[#MMO], [RTB], numeroTesto(oreRTBPerComponente.at(0)), numeroTesto(oreRTBPerComponente.at(1)), numeroTesto(oreRTBPerComponente.at(2)), numeroTesto(oreRTBPerComponente.at(3)), numeroTesto(oreRTBPerComponente.at(4)), numeroTesto(oreRTBPerComponente.at(5))),
    ([PB], numeroTesto(orePBPerComponente.at(0)), numeroTesto(orePBPerComponente.at(1)), numeroTesto(orePBPerComponente.at(2)), numeroTesto(orePBPerComponente.at(3)), numeroTesto(orePBPerComponente.at(4)), numeroTesto(orePBPerComponente.at(5))),
    (table.cell(rowspan: 2, fill: tabellaRigaDispari)[#RP], [RTB], numeroTesto(oreRTBPerComponente.at(0)), numeroTesto(oreRTBPerComponente.at(1)), numeroTesto(oreRTBPerComponente.at(2)), numeroTesto(oreRTBPerComponente.at(3)), numeroTesto(oreRTBPerComponente.at(4)), numeroTesto(oreRTBPerComponente.at(5))),
    ([PB], numeroTesto(orePBPerComponente.at(0)), numeroTesto(orePBPerComponente.at(1)), numeroTesto(orePBPerComponente.at(2)), numeroTesto(orePBPerComponente.at(3)), numeroTesto(orePBPerComponente.at(4)), numeroTesto(orePBPerComponente.at(5))),
    (table.cell(rowspan: 2, fill: tabellaRigaPari)[#LS], [RTB], numeroTesto(oreRTBPerComponente.at(0)), numeroTesto(oreRTBPerComponente.at(1)), numeroTesto(oreRTBPerComponente.at(2)), numeroTesto(oreRTBPerComponente.at(3)), numeroTesto(oreRTBPerComponente.at(4)), numeroTesto(oreRTBPerComponente.at(5))),
    ([PB], numeroTesto(orePBPerComponente.at(0)), numeroTesto(orePBPerComponente.at(1)), numeroTesto(orePBPerComponente.at(2)), numeroTesto(orePBPerComponente.at(3)), numeroTesto(orePBPerComponente.at(4)), numeroTesto(orePBPerComponente.at(5))),
    (strong("Totale"), strong("-"), strong(numeroTesto(oreTotali.at(0))), strong(numeroTesto(oreTotali.at(1))), strong(numeroTesto(oreTotali.at(2))), strong(numeroTesto(oreTotali.at(3))), strong(numeroTesto(oreTotali.at(4))), strong(numeroTesto(oreTotali.at(5)))),
  ),
)

== Preventivo per periodo

Il lavoro è organizzato nei due periodi di riferimento RTB e PB. Le ore sono obiettivi di pianificazione e saranno consuntivate al termine di ogni sprint; non costituiscono un vincolo assoluto per la singola persona.

#tabellaDati(
  colonne: (auto, 2fr, auto, auto, 2fr, auto),
  rigaTotale: 3,
  intestazioni: ([Periodo], [Attività principali], [Ore], [Costo (€)], [Risultato atteso], [Riesame]),
  righe: (
    ([RTB], [Formazione, studio delle tecnologie, requisiti, architettura e PoC], numeroTesto(oreRTBTotali), numeroTesto(costoRTB), [PoC e baseline dei requisiti e dell'architettura], [RTB]),
    ([PB], [Sviluppo, integrazione della pipeline dati e della web app, test, documentazione e rilascio], numeroTesto(orePBTotali), numeroTesto(costoPB), [MVP#footnote[Minimum Viable Product] verificato e consegnabile], [PB]),
    (strong("Totale"), strong("-"), strong(numeroTesto(monteOre)), strong(numeroTesto(costoPreventivato)), strong("-"), strong("-")),
  ),
)

= Calendario di massima

#tabellaDati(
  colonne: (2fr, 1.4fr, 2.8fr),
  intestazioni: ([Evento], [Data obiettivo], [Nota]),
  righe: (
    ([Inizio dei lavori — Sprint 1], [#dataInizioLavori], [Avvio della formazione e raccolta dei requisiti]),
    ([PoC — Sprint 1-2], [Entro dicembre 2026], [Validazione delle tecnologie più rischiose]),
    ([RTB — Sprint 3–5], [Entro gennaio 2027], [Riesame dei requisiti e dell'architettura]),
    ([PB e sviluppo dell'MVP — Sprint 6–9], [Febbraio–marzo 2027], [Implementazione incrementale e integrazione]),
    ([Finalizzazione dei lavori e consegna — Sprint 10], [Entro #dataConsegna], [Verifica finale, documentazione e rilascio]),
  ),
)

La pianificazione iniziale prevede 10 sprint di due settimane, compatibili con gli allineamenti quindicinali con la proponente; durata, numero e distribuzione degli sprint possono essere modificati per esigenze di calendario, indisponibilità o vincoli tecnici, purché ogni modifica sia deliberata, motivata, verbalizzata e recepita nel preventivo quando incide su ore, costi o scadenze. Il calendario di massima tiene conto gli incontri SAL#footnote[Stato Avanzamento Lavori] e gli approfondimenti tecnici della proponente, online o in presenza, e delle vacanze natalizie e pasquali, della sessione d'esami e della disponibilità dei componenti.

= Rotazione e gestione dei ruoli

La rotazione è progettata per distribuire l'esperienza e il carico in modo equilibrato, senza introdurre vincoli non giustificati dall'avanzamento reale.

- Ogni componente ricopre un solo ruolo operativo alla volta.
- I ruoli vengono riesaminati al termine di ogni sprint, con durata obiettivo di due settimane.
- Nessun componente dovrebbe ricoprire lo stesso ruolo in due sprint consecutivi, salvo necessità motivata.
- Nel corso del progetto ogni componente dovrebbe sperimentare tutti i ruoli, compatibilmente con le attività effettive.
- Il ruolo di Verificatore deve essere assegnato a una persona indipendente dall'autore del prodotto verificato.
- Il componente uscente trasferisce al subentrante stato di avanzamento, decisioni aperte, prodotti e scadenze.
- Il Responsabile raccoglie il consuntivo delle ore, propone eventuali riequilibri e aggiorna la pianificazione.
- Ogni eccezione deve avere una motivazione, una durata e un piano di recupero, riportati nel verbale.

Le assegnazioni dei ruoli sono obiettivi operativi e non vincoli assoluti: possono essere riviste quando i consuntivi, le competenze maturate o i rischi lo rendano necessario. La revisione deve essere verificata da un componente diverso dall'autore della proposta.

= Analisi dei ruoli

La distribuzione quantitativa delle ore per ruolo, componente e periodo RTB/PB è riportata nella sezione 3. La ripartizione è inizialmente uguale per tutti, ma può essere riequilibrata nei consuntivi degli sprint.

== Responsabile

- coordina il gruppo e rappresenta il progetto verso committenti e proponente;
- pianifica sprint, risorse, scadenze e riesami;
- conduce le riunioni SAL e mantiene il registro delle decisioni;
- monitora rischi, costi e scostamenti;
- propone la riassegnazione delle attività quando emergono ritardi o indisponibilità.

== Amministratore

- configura e mantiene repository, permessi, issue tracker, CI/CD#footnote[Continuous Integration / Continuous Delivery] e strumenti documentali;
- garantisce l'applicazione del way of working;
- mantiene la struttura del repository e la pubblicazione della vista web;
- supporta la continuità operativa e la tracciabilità delle modifiche.

== Analista

- studia il dominio e raccoglie i bisogni della proponente;
- formalizza requisiti, vincoli, criteri di accettazione e priorità;
- valida i requisiti con gli stakeholder;
- aggiorna l'analisi quando emergono chiarimenti o modifiche.

== Progettista

- definisce l'architettura software e le interfacce tra raw data store, data warehouse e web app;
- valuta tecnologie, framework e pattern;
- traduce i requisiti in soluzioni realizzabili e verificabili;
- coordina le decisioni relative a ETL#footnote[Extract, Transform, Load], API, dashboard, visualizzazioni e layer AI.

== Programmatore

- implementa pipeline dati, servizi backend, interfacce web e integrazioni del layer AI;
- realizza il PoC e il MVP secondo i requisiti approvati;
- mantiene il codice, documenta le scelte e corregge i difetti;
- opera entro le deleghe definite dal Responsabile e dal Progettista.

== Verificatore

- verifica documenti, codice e prodotti durante tutto il progetto;
- definisce casi di test, metriche e soglie di accettazione;
- controlla test unitari, di integrazione, end-to-end e validazione su dati, API, dashboard e funzionalità AI;
- non verifica materiale prodotto da sé stesso;
- registra esiti, non conformità e attività di correzione.

= Analisi dei rischi e mitigazione

#tabellaDati(
  colonne: (2fr, auto, auto, 3fr),
  intestazioni: ([Rischio], [Probabilità], [Impatto], [Mitigazione]),
  righe: (
    ([Ampiezza della piattaforma BI e del layer AI], [Alta], [Alto], [Priorità ai requisiti essenziali, sviluppo incrementale per fasi e riesame periodico]),
    ([Complessità della pipeline dati], [Media], [Alto], [Schema condiviso, validazione della qualità dei dati e test delle trasformazioni]),
    ([Inaccuratezza delle risposte dell'assistente AI], [Media], [Alto], [Guardrail, domande di riferimento, controlli di coerenza e test di regressione]),
    ([Prestazioni, latenza e costi su dataset ampi], [Media], [Medio], [PoC prestazionali, query limitate, caching e monitoraggio dei tempi di risposta]),
    ([Disponibilità o qualità dei dati di caso di studio], [Media], [Medio], [Dataset sintetico di fallback, accordo tempestivo con la proponente e test riproducibili]),
    ([Integrazione tra raw store, data warehouse e web app], [Media], [Medio], [Contratti API, PoC delle interfacce e integrazione progressiva dei componenti]),
    ([Esposizione di dati sensibili al servizio AI esterno], [Media], [Alto], [Minimizzazione dei metadati, controllo degli accessi e verifica dei flussi verso l'API]),
    ([Sottostima delle ore], [Media], [Alto], [Consuntivo a fine sprint, ricalcolo a finire e rinegoziazione dei requisiti opzionali]),
    ([Disponibilità ridotta per esami e impegni personali], [Alta], [Medio], [Calendario condiviso, margine temporale e riassegnazione preventiva]),
    ([Modifica o incomprensione dei requisiti], [Media], [Medio], [Incontri SAL, verbali esterni e gestione formale delle modifiche]),
  ),
)

Il registro dei rischi sarà riesaminato a ogni fine periodo. Per ciascun rischio il Responsabile individuerà, quando necessario, un incaricato, un trigger di attivazione e un termine per la verifica della contromisura.

= Impegni del gruppo

Con la presente candidatura il gruppo #gruppo si impegna a:

- perseguire il monte ore preventivato di #monteOre ore produttive, con #oreComponente ore per componente;
- mantenere il costo entro il preventivo di #costoPreventivato € salvo variazioni concordate e documentate;
- consegnare il prodotto entro e non oltre il #dataConsegna;
- lavorare secondo il way of working e le Norme di Progetto;
- mantenere una comunicazione costante con #proponente e con i committenti;
- registrare ore, decisioni, azioni, verifiche e scostamenti;
- aggiornare preventivo, calendario e rischi quando l'avanzamento reale lo richieda.

Le quantità per ruolo e per componente restano obiettivi preventivi: il gruppo non considera la distribuzione iniziale un vincolo assoluto, ma si impegna a motivare ogni variazione e a conservarne la tracciabilità.

= Riepilogo finale

#tabellaDati(
  colonne: (2fr, 2fr),
  intestazioni: ([Voce], [Valore]),
  righe: (
    ([Capitolato], [#capitolato]),
    ([Proponente], [#proponente]),
    ([Componenti], [#numeroComponenti]),
    ([Ore produttive totali], [#monteOre]),
    ([Ore per componente], [#oreComponente]),
    ([Costo totale preventivato], [#costoPreventivato €]),
    ([Consegna prevista], [#dataConsegna]),
  ),
)
