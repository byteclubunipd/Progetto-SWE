#import "/docs/5_Templates/documento.typ": *
#import "Diagrammi_e_rendiconto_ore_costi.typ": *

#show: documento.with(
  titolo: "Piano di progetto",
  mostraRegistro: true,
  versione: "0.1.0",
  redazione: RP,
  verifica: LS,
  uso: "Esterno",
  destinatari: [Prof.Vardanega Tullio Prof. Cardin Riccardo Ergon Informatica S.r.l.],
  registroModifiche: (
    ("0.1.0", "2026-11-16", "Creazione della struttura iniziale", RP, LS),
  ),
  indice: true,
  tabelle: true,
  immagini: true,
)

= Introduzione

[Descrivere lo scopo del documento e il contesto di riferimento.]

== Scopo del documento

[Descrivere gli obiettivi e i destinatari del Piano di progetto.]

== Scopo del prodotto

[Descrivere il prodotto e gli obiettivi progettuali.]

== Glossario

[Inserire i termini, gli acronimi e le abbreviazioni utilizzati.]

== Riferimenti

=== Riferimenti normativi

[Inserire i riferimenti normativi applicabili.]

=== Riferimenti informativi

[Inserire i riferimenti informativi e bibliografici.]

= Analisi e gestione dei rischi

== RT

[Descrivere i rischi legati alle tecnologie.]

== RE

[Descrivere i rischi legati alla stima e alla gestione del lavoro.]

== RO

[Descrivere i rischi legati all'organizzazione del gruppo.]

== RA

[Descrivere i rischi legati agli avvenimenti imprevisti.]

== RP

[Descrivere i rischi legati alle persone e agli impegni del gruppo.]

= Modello di sviluppo

== Lo Standard ISO/IEC/IEEE 12207

[Descrivere l'applicazione dello standard al progetto.]

=== I processi primari

[Descrivere i processi primari.]

=== I processi di supporto

[Descrivere i processi di supporto.]

=== I processi organizzativi

[Descrivere i processi organizzativi.]

== Struttura dello Sprint Agile in conformità con lo Standard ISO/IEC/IEEE 12207

[Descrivere la struttura di uno Sprint Agile e il collegamento con i processi dello standard.]

// Figura della struttura dello Sprint Agile: da inserire quando sarà disponibile l'immagine.

= Pianificazione nel lungo termine

== Introduzione

[Descrivere la pianificazione complessiva del progetto.]

#figure(
  kind: table,
  table(
    columns: (2fr, 1fr, 1fr),
    inset: 4pt,
    stroke: 0.5pt,
    table.header([Ruolo], [Ore], [Costo totale]),
    [Responsabile], [0], [0],
    [Verificatore], [0], [0],
    [Membro], [0], [0],
  ),
  caption: [Ore per ciascun ruolo e calcolo dei costi totali],
)

== Attività previste per la RTB

[Elencare le attività previste per la Requirements and Technology Baseline.]

== Attività previste per la PB

[Elencare le attività previste per la Product Baseline.]

= Pianificazione a breve termine

== Introduzione

[Descrivere il criterio di pianificazione dei singoli Sprint.]

== Requirements and Technology Baseline

[Descrivere la baseline e il collegamento con gli Sprint.]

== Sprint 1

[Descrivere gli obiettivi e le attività dello Sprint 1.]
#mostra-sprint(sprint-1)

== Sprint 2

[Descrivere gli obiettivi e le attività dello Sprint 2.]
#mostra-sprint(sprint-2)

== Sprint 3

[Descrivere gli obiettivi e le attività dello Sprint 3.]
#mostra-sprint(sprint-3)

== Sprint 4

[Descrivere gli obiettivi e le attività dello Sprint 4.]
#mostra-sprint(sprint-4)

== Sprint 5

[Descrivere gli obiettivi e le attività dello Sprint 5.]
#mostra-sprint(sprint-5)

