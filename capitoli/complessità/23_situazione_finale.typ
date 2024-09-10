#import "../alias.typ": *


= Situazione finale

Dopo tutto ciò che è stato visto in queste dispense, ecco un'illustrazione che mostra qual è la situazione attuale per quanto riguarda la classificazione di problemi.

#v(12pt)

#figure(
  image("assets/situazione-finale.svg", width: 100%)
)

#v(12pt)

_NC_ è la classe di problemi risolti da *algoritmi paralleli efficienti*, ovvero algoritmi che hanno tempo parallelo _"o piccolo"_ del tempo sequenziale e un buon numero di processori.

L'unica inclusione propria dimostrata e nota è $P subset.neq exptime$, grazie al problema di decidere se una DTM si arresta entro $n$ passi. In tutti gli altri casi è universalmente accettato (_ma non dimostrato_) che le inclusioni siano proprie.
