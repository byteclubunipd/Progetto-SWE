#import "base.typ": base, copertina, indiceDocumento, tabellaDati, intestazione, tutti, BG, EH, MMI, MMO, RP, LS, tabellaRigaPari, tabellaRigaDispari
#import "@preview/glossy:0.9.2": *

#let valore-metadati(valore) = if valore == none {
  []
} else if type(valore) == array {
  valore.map(elemento => [#elemento]).join(linebreak())
} else {
  valore
}

#let documento(
  titolo: "Documento",
  mostraRegistro: true,
  mostraInformazioni: true,
  versione: "",
  stato: "",
  redazione: (),
  verifica: (),
  approvazione: "",
  proprietario: "",
  uso: "",
  destinatari: (),
  registroModifiche: (),
  indice: true,
  glossario: none,
  urlGlossario: "https://byteclubunipd.github.io/Progetto-SWE/docs/6_Output/3_RTB/Documenti_interni/Glossario.pdf",
  tabelle: false,
  immagini: false,
  body,
) = {
  set document(title: titolo, author: redazione)
  base(
    tipo: "Documento " + uso,
    intestazione: intestazione(titolo),
    [
      // COPERTINA
      #copertina(titolo)

      // INFORMAZIONI SUL DOCUMENTO
      #if mostraInformazioni [
        #v(1em)
        #text(weight: "bold", size: 14pt)[Informazioni sul documento]

        #tabellaDati(
          colonne: (1fr, 2fr),
          intestazioni: ([Campo], [Valore]),
          righe: (
            ([Versione], [#versione]),
            ([Stato], [#stato]),
            ([Redazione], [#valore-metadati(redazione)]),
            ([Verifica], [#valore-metadati(verifica)]),
            ([Approvazione], [#approvazione]),
            ([Proprietario], [#proprietario]),
            ([Uso], [#uso]),
            ([Destinatari], [#valore-metadati(destinatari)]),
          ),
        )
      ]

      // REGISTRO DELLE MODIFICHE
      #if mostraRegistro [
        #v(1em)
        #text(weight: "bold", size: 14pt)[Registro delle modifiche]

        #tabellaDati(
          colonne: (auto, auto, 1fr, auto, auto),
          intestazioni: (
            [Versione],
            [Data],
            [Descrizione],
            [Autore],
            [Verificatore],
          ),
          righe: registroModifiche,
        )
      ]
      
      #if indice [
        #pagebreak()
        #indiceDocumento()
        #pagebreak()
      ]
      
      #if glossario != none [
        #show: init-glossary.with(glossario)
        #show ref: it => {
          let key = str(it.target).split(":").first()
          if key in glossario {
            link(urlGlossario + "#" + key)[#it#super[G]]
          } else {
            it
          }
        }
        #body
      ] else [
        #body
      ]
      #if tabelle [
        #outline(
          title: [Elenco delle tabelle],
          target: figure.where(kind: table),
          indent: 1em,
        )
        #pagebreak()
      ]
      #if immagini [
        #outline(
          title: [Elenco delle figure],
          target: figure.where(kind: image),
          indent: 1em,
        )
        #pagebreak()
      ]
      #body
    ],
  )
}
