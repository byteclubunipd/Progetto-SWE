#import "base.typ": base, copertina, indiceDocumento, tutti, BG, EH, MMI, MMO, RP, LS

#let studioDiFattibilita(
  titolo: "Studio di Fattibilità",
  data: "",
  autori: (),
  capitolatiScelti: (),
  capitolatiScartati: (),
  body,
) = {
  set document(title: titolo, author: autori)
  
  base(
    [
      #copertina(titolo, data: data,  autori: autori)

      #pagebreak()
      #indiceDocumento()

      #if capitolatiScelti.len() > 0 [
        #pagebreak()
        = Capitolati Valutati (Scelti)
        
        #for cap in capitolatiScelti [
          == Capitolato: #cap.nome
          
          === Motivazione della scelta
          #cap.motivazione
          
          === Strategie di mitigazione
          #cap.mitigazione
          
          === Piano di formazione preliminare
          #cap.formazione
          
          === Impegno orario stimato
          #cap.impegno
        ]
      ]

      #if capitolatiScartati.len() > 0 [
        #pagebreak()
        = Capitolati Scartati
        
        #for cap in capitolatiScartati [
          == Capitolato: #cap.nome
          
          === Motivazione dello scarto
          #cap.motivazione
        ]
      ]

      #body
    ],
  )
}