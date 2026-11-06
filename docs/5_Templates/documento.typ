#import "base.typ": base, copertina, indiceDocumento, tabellaDati, intestazione, tutti, BG, EH, MMI, MMO, RP, LS, tabellaRigaPari, tabellaRigaDispari

#let documento(
  titolo: "Documento",
  mostraRegistro: true,
  mostraInformazioni: true,
  versione: "",
  stato: "",
  redazione: (),
  verifica: "",
  approvazione: "",
  proprietario: "",
  uso: "",
  destinatari: "",
  registroModifiche: (),
  indice: true,
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
            ([Redazione], [#redazione]),
            ([Verifica], [#verifica]),
            ([Approvazione], [#approvazione]),
            ([Proprietario], [#proprietario]),
            ([Uso], [#uso]),
            ([Destinatari], [#destinatari]),
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
      #body
    ],
  )
}
