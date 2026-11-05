#import "/docs/5_Templates/documento.typ": *

#let gruppo = "ByteClub"
#let capitolato = "C3 - FossDot"
#let proponente = "Uranion EMEA Ltd"
#let dataConsegna = "21/03/2027"
#let costoPreventivato = 11490
#let monteOre = 552
#let oreComponente = 92

#show: documento.with(
  titolo: "Dichiarazione degli impegni e preventivo dei costi",
  mostraRegistro: true,
  versione: "1.1.0",
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
    ("1.1.0", "2026-11-04", "Aggiornamento struttura del documento a seguito della correzione della candidatura.", RP, MMO),
    ("1.0.0", "2026-10-28", "Approvazione del documento.", LS, "-"),
    ("0.3.0", "2026-10-26", "Verifica, correzione e aggiornamento riguardo i nuovi elementi emersi.", EH, RP),
    ("0.2.0", "2026-10-24", "Aggiunta della sezione di analisi dei ruoli.", EH, RP),
    ("0.1.0", "2026-10-23", "Prima stesura del documento.", EH, RP),
  ),
)

= Scopo del documento

Il presente documento accompagna la candidatura del gruppo #gruppo per il capitolato #capitolato, proposto da #proponente. Definisce il preventivo economico e temporale, l'organizzazione dei ruoli, i criteri di rotazione, il calendario di massima, i principali rischi e gli impegni assunti dal gruppo.

Le ore e i costi riportati costituiscono una stima iniziale. Le quantità per ruolo e per componente sono obiettivi di pianificazione e possono essere aggiornate dopo il consuntivo di uno sprint, purché ogni variazione sia motivata, verificata e registrata senza superare il monte ore e il costo approvati.

== Riferimenti

- Regolamento del progetto didattico di Ingegneria del Software, anno accademico 2026/2027. #footnote[#link("https://byteclubunipd.github.io/Progetto-SWE/")[https://byteclubunipd.github.io/Progetto-SWE/]]
- Capitolato #capitolato e documentazione tecnica fornita da #proponente. #footnote[#link("https://byteclubunipd.github.io/Progetto-SWE/")[https://byteclubunipd.github.io/Progetto-SWE/]]
- Valutazione dei capitolati del gruppo ByteClub, versione 1.0.0. #footnote[#link("https://byteclubunipd.github.io/Progetto-SWE/docs/6_Output/2_Candidatura/Valutazione_Capitolati%20v1.0.0.pdf")[https://byteclubunipd.github.io/Progetto-SWE/docs/6_Output/2_Candidatura/Valutazione_Capitolati%20v1.0.0.pdf]]
- Lettera di presentazione del gruppo ByteClub. #footnote[#link("https://byteclubunipd.github.io/Progetto-SWE/docs/6_Output/2_Candidatura/Lettera_di_Presentazione.pdf")[https://byteclubunipd.github.io/Progetto-SWE/docs/6_Output/2_Candidatura/Lettera_di_Presentazione.pdf]]
- Preventivo dei costi e impegni orari, versione 1.1.0. #footnote[#link("https://byteclubunipd.github.io/Progetto-SWE/docs/6_Output/2_Candidatura/Preventivo_costi_impegni%20v1.1.0.pdf")[https://byteclubunipd.github.io/Progetto-SWE/docs/6_Output/2_Candidatura/Preventivo_costi_impegni%20v1.1.0.pdf]]
- Verbali interni ed esterni della candidatura, con particolare riferimento agli incontri del 2026-10-21, 2026-10-29 e 2026-11-03. #footnote[#link("https://byteclubunipd.github.io/Progetto-SWE/docs/6_Output/2_Candidatura/verbali/interni/VI_2026-11-03.pdf")[https://byteclubunipd.github.io/Progetto-SWE/docs/6_Output/2_Candidatura/verbali/interni/VI_2026-11-03.pdf]] #footnote[#link("https://byteclubunipd.github.io/Progetto-SWE/docs/6_Output/2_Candidatura/verbali/interni/VI_2026-10-30.pdf")[https://byteclubunipd.github.io/Progetto-SWE/docs/6_Output/2_Candidatura/verbali/interni/VI_2026-10-30.pdf]] #footnote[#link("https://byteclubunipd.github.io/Progetto-SWE/docs/6_Output/2_Candidatura/verbali/esterni/VE_2026-10-21.pdf")[https://byteclubunipd.github.io/Progetto-SWE/docs/6_Output/2_Candidatura/verbali/esterni/VE_2026-10-21.pdf]] #footnote[#link("https://byteclubunipd.github.io/Progetto-SWE/docs/6_Output/2_Candidatura/verbali/esterni/VE_2026-10-29.pdf")[https://byteclubunipd.github.io/Progetto-SWE/docs/6_Output/2_Candidatura/verbali/esterni/VE_2026-10-29.pdf]]

Il capitolato, la proponente e il calendario devono essere riallineati all'ultima decisione di candidatura approvata. In caso di modifica del capitolato, il gruppo aggiornerà nome, riferimenti, rischi, attività e calendario prima del rilascio della versione definitiva.

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

Il gruppo è composto da sei componenti. Ogni componente contribuisce a più ruoli durante il progetto, secondo la rotazione descritta nella sezione successiva. Il carico individuale previsto è di 92 ore produttive, entro l'intervallo previsto dal regolamento.

= Preventivo delle ore e dei costi

#let oreTotali = (60, 54, 84, 120, 126, 108)
#let costiOrari = (30, 20, 25, 25, 15, 15)
#let ruoli = (
  "Responsabile",
  "Amministratore",
  "Analista",
  "Progettista",
  "Programmatore",
  "Verificatore",
)
#let costiTotali = oreTotali.zip(costiOrari).map(((ore, costo)) => ore * costo)
#let orePerComponente = oreTotali.map(ore => ore / 6)
#let oreRTB = (30, 30, 60, 36, 48, 48)
#let orePB = (30, 24, 24, 84, 78, 60)
#let oreRTBPerComponente = oreRTB.map(ore => ore / 6)
#let orePBPerComponente = orePB.map(ore => ore / 6)
#let totaleOre = oreTotali.sum()
#let totaleCosti = costiTotali.sum()
#let totaleOreComponente = orePerComponente.sum()

La ripartizione iniziale è stata costruita considerando il peso atteso delle attività di analisi, architettura, implementazione, integrazione hardware/software e verifica. Programmazione e verifica hanno un peso rilevante per la necessità di validare la pipeline audio, il firmware, i servizi di integrazione e il comportamento del prodotto su dispositivo fisico. La suddivisione rimane comunque rivedibile sulla base dei consuntivi.

#let righeRuoli = (
  ([Resp.#footnote[Responsabile]], "30", "60", "1800", "30", "5", "30", "5"),
  ([Amm.#footnote[Amministratore]], "20", "54", "1080", "30", "5", "24", "4"),
  ([Anal.#footnote[Analista]], "25", "84", "2100", "60", "10", "24", "4"),
  ([Prog.#footnote[Progettista]], "25", "120", "3000", "36", "6", "84", "14"),
  ([Program.#footnote[Programmatore]], "15", "126", "1890", "48", "8", "78", "13"),
  ([Verif.#footnote[Verificatore]], "15", "108", "1620", "48", "8", "60", "10"),
)

#tabellaDati(
  colonne: (auto, auto, auto, auto, auto, auto, auto, auto),
  rigaTotale: 7,
  intestazioni: (
    [Ruolo],
    [Costo orario (€/h)],
    [Ore totali (h)],
    [Costo #linebreak() totale (€)],
    [Ore RTB totali (h)],
    [Ore RTB per componente (h)],
    [Ore PB totali (h)],
    [Ore PB per componente (h)],
  ),
  righe: righeRuoli + ((strong("Totale"), "-", strong(str(totaleOre)), strong(str(totaleCosti)), strong(str(oreRTB.sum())), strong(str(oreRTBPerComponente.sum())), strong(str(orePB.sum())), strong(str(orePBPerComponente.sum()))),),
)

Il costo totale preventivato è di *#totaleCosti €* per *#totaleOre ore produttive*, pari a *#totaleOreComponente ore* per componente. Il valore è una stima iniziale e costituisce il limite di riferimento per il controllo dei costi; eventuali scostamenti saranno discussi con i committenti e documentati nei verbali.

== Ore per componente, ruolo e periodo

La seguente tabella mostra le Ore assegnate a ciascun componente nei periodi RTB e PB. In questo modo la ripartizione per persona e per periodo è leggibile in un'unica vista, senza duplicare i dati nelle tabelle riepilogative.

#tabellaDati(
  colonne: (auto, auto, 0.8fr, 0.8fr, 0.8fr, 0.8fr, 1.1fr, 0.8fr, 0.8fr),
  rigaTotale: 13,
  intestazioni: ([Componente], [Periodo], [Resp.], [Amm.], [Anal.], [Prog.], [Program.], [Verif.], [Totale]),
  righe: (
    (table.cell(rowspan: 2, fill: tabellaRigaDispari)[#BG], [RTB], [5], [5], [10], [6], [8], [8], [42]),
    ([PB], [5], [4], [4], [14], [13], [10], [50]),
    (table.cell(rowspan: 2, fill: tabellaRigaPari)[#EH], [RTB], [5], [5], [10], [6], [8], [8], [42]),
    ([PB], [5], [4], [4], [14], [13], [10], [50]),
    (table.cell(rowspan: 2, fill: tabellaRigaDispari)[#MMI], [RTB], [5], [5], [10], [6], [8], [8], [42]),
    ([PB], [5], [4], [4], [14], [13], [10], [50]),
    (table.cell(rowspan: 2, fill: tabellaRigaPari)[#MMO], [RTB], [5], [5], [10], [6], [8], [8], [42]),
    ([PB], [5], [4], [4], [14], [13], [10], [50]),
    (table.cell(rowspan: 2, fill: tabellaRigaDispari)[#RP], [RTB], [5], [5], [10], [6], [8], [8], [42]),
    ([PB], [5], [4], [4], [14], [13], [10], [50]),
    (table.cell(rowspan: 2, fill: tabellaRigaPari)[#LS], [RTB], [5], [5], [10], [6], [8], [8], [42]),
    ([PB], [5], [4], [4], [14], [13], [10], [50]),
    (strong("Totale"), strong("-"), strong("60"), strong("54"), strong("84"), strong("120"), strong("126"), strong("108"), strong("552")),
  ),
)

== Preventivo per periodo

Il lavoro è organizzato nei due periodi di riferimento RTB e PB. Le ore sono obiettivi di pianificazione e saranno consuntivate al termine di ogni sprint; non costituiscono un vincolo assoluto per la singola persona.

#tabellaDati(
  colonne: (auto, 2fr, auto, auto, 2fr, auto),
  rigaTotale: 3,
  intestazioni: ([Periodo], [Attività principali], [Ore], [Costo (€)], [Risultato atteso], [Riesame]),
  righe: (
    ([RTB], [Formazione, studio delle tecnologie, requisiti, architettura e PoC], "252", "5340", [PoC e baseline dei requisiti e dell'architettura], [RTB]),
    ([PB], [Sviluppo, integrazione hardware/software, test, documentazione e rilascio], "300", "6150", [MVP verificato e consegnabile], [PB]),
    (strong("Totale"), strong("-"), strong("552"), strong("11490"), strong("-"), strong("-")),
  ),
)

= Calendario di massima

#tabellaDati(
  colonne: (2fr, 1.4fr, 2.8fr),
  intestazioni: ([Evento], [Data obiettivo], [Nota]),
  righe: (
    ([Inizio dei lavori], [2026-11-04], [Avvio della formazione e raccolta dei requisiti]),
    ([PoC iniziale], [Entro la terza settimana], [Validazione delle tecnologie più rischiose]),
    ([Requirements and Technology Baseline], [Entro gennaio 2027], [Riesame dei requisiti e dell'architettura]),
    ([Sviluppo del MVP], [Gennaio–marzo 2027], [Implementazione incrementale e integrazione]),
    ([Product Baseline e consegna], [Entro 21/03/2027], [Verifica finale e rilascio]),
  ),
)

La durata obiettivo dello sprint è di due settimane. La durata potrà essere modificata per esigenze di calendario, disponibilità dei componenti o dipendenze hardware; la modifica dovrà essere deliberata, motivata e registrata. Il calendario terrà conto delle vacanze, della sessione d'esami e della disponibilità della proponente per incontri SAL e approfondimenti tecnici.

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

- configura e mantiene repository, permessi, issue tracker, CI/CD e strumenti documentali;
- garantisce l'applicazione del way of working;
- mantiene la struttura del repository e la pubblicazione della vista web;
- supporta la continuità operativa e la tracciabilità delle modifiche.

== Analista

- studia il dominio e raccoglie i bisogni della proponente;
- formalizza requisiti, vincoli, criteri di accettazione e priorità;
- valida i requisiti con gli stakeholder;
- aggiorna l'analisi quando emergono chiarimenti o modifiche.

== Progettista

- definisce l'architettura hardware/software e le interfacce tra componenti;
- valuta tecnologie, framework e pattern;
- traduce i requisiti in soluzioni realizzabili e verificabili;
- coordina le decisioni relative a firmware, backend, pipeline audio, interfaccia e contenitore.

== Programmatore

- implementa firmware, servizi, interfacce e integrazioni;
- realizza il PoC e il MVP secondo i requisiti approvati;
- mantiene il codice, documenta le scelte e corregge i difetti;
- opera entro le deleghe definite dal Responsabile e dal Progettista.

== Verificatore

- verifica documenti, codice e prodotti durante tutto il progetto;
- definisce casi di test, metriche e soglie di accettazione;
- controlla test unitari, integrazione, end-to-end e validazione su dispositivo fisico;
- non verifica materiale prodotto da sé stesso;
- registra esiti, non conformità e attività di correzione.

= Analisi dei rischi e mitigazione

#tabellaDati(
  colonne: (2fr, auto, auto, 3fr),
  intestazioni: ([Rischio], [Probabilità], [Impatto], [Mitigazione]),
  righe: (
    ([Esperienza limitata con hardware e firmware], [Alta], [Alto], [Formazione iniziale, PoC incrementale e scelta di componenti alternativi]),
    ([Apprendimento di Rust o tecnologie embedded], [Media], [Medio], [Studio concentrato nei primi sprint e possibilità di usare una soluzione Linux motivata]),
    ([Ritardo nella disponibilità dei componenti], [Media], [Alto], [Mock, componenti sostitutivi e pianificazione anticipata degli acquisti]),
    ([Problemi nella pipeline audio o nella wake word], [Media], [Alto], [Test separati di acquisizione, rilevamento, STT e TTS]),
    ([Risposte variabili dei provider AI], [Media], [Medio], [Mock, provider alternativi, gestione degli errori e criteri di accettazione]),
    ([Integrazione tra più dispositivi], [Media], [Medio], [PoC della comunicazione prima dell'integrazione completa]),
    ([Violazioni dei vincoli di privacy], [Media], [Alto], [Wake word locale, minimizzazione dei dati e test dedicati]),
    ([Sottostima delle ore], [Media], [Alto], [Consuntivo a fine sprint, ricalcolo a finire e rinegoziazione dei requisiti opzionali]),
    ([Disponibilità ridotta per esami e impegni personali], [Alta], [Medio], [Calendario condiviso, margine temporale e riassegnazione preventiva]),
    ([Modifica o incomprensione dei requisiti], [Media], [Medio], [Incontri SAL, verbali esterni e gestione formale delle modifiche]),
  ),
)

Il registro dei rischi sarà riesaminato a ogni fine periodo. Per ciascun rischio il Responsabile individuerà, quando necessario, un incaricato, un trigger di attivazione e un termine per la verifica della contromisura.

= Tracciabilità di decisioni e azioni

Questa tabella non è una seconda pianificazione del progetto: serve a collegare le decisioni dei verbali alle azioni concrete e ai rispettivi responsabili. È stata inserita per garantire la tracciabilità richiesta nella candidatura e per evitare azioni assegnate genericamente a “tutto il gruppo”.

Ogni decisione rilevante deve produrre almeno un'azione assegnata a una persona identificabile. L'assegnatario è responsabile dell'esecuzione; il verificatore controlla il risultato.

#tabellaDati(
  colonne: (0.7fr, 2.4fr, 3fr, 2.2fr, 1.3fr),
  intestazioni: ([ID], [Decisione], [Azione], [Assegnatario], [Scadenza]),
  righe: (
    ([D6], [Redigere il preventivo aggiornato], [Integrare correzioni e sezioni mancanti], [#RP], [2026-11-07]),
    ([D6], [Verificare il preventivo aggiornato], [Controllare calcoli, contenuti e coerenza], [#MMO], [2026-11-07]),
    ([D4], [Aggiornare la vista web], [Pubblicare PDF e verbali della versione corrente], [#MMI], [2026-11-07]),
  ),
)

La tabella deve essere aggiornata quando il verbale di candidatura viene approvato o quando una decisione produce nuove azioni. Non vengono usati assegnatari generici come “tutto il gruppo” per attività operative.

= Impegni del gruppo

Con la presente candidatura il gruppo #gruppo si impegna a:

- perseguire il monte ore preventivato di 552 ore produttive, con 92 Ore per componente;
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
    ([Componenti], [6]),
    ([Ore produttive totali], [#monteOre]),
    ([Ore per componente], [#oreComponente]),
    ([Costo totale preventivato], [#costoPreventivato €]),
    ([Consegna prevista], [#dataConsegna]),
  ),
)

Il documento sarà considerato pronto per l'approvazione solo dopo la verifica dei calcoli, l'aggiornamento della vista web, la pubblicazione dei verbali pertinenti e l'allineamento con l'ultima decisione approvata sulla candidatura.
