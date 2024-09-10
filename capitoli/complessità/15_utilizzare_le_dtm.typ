#import "@preview/lemmify:0.1.5": *

#let (
  theorem, lemma, corollary,
  remark, proposition, example,
  proof, rules: thm-rules
) = default-theorems("thm-group", lang: "it")

#show: thm-rules

#show thm-selector("thm-group", subgroup: "theorem"): it => block(
  it,
  stroke: red + 1pt,
  inset: 1em,
  breakable: true
)

#import "../alias.typ": *


= Funzionalità di una DTM

== Insiemi riconosciuti

La principale funzionalità di una DTM è *riconoscere linguaggi*. Un linguaggio $L subset.eq Sigma^*$ è *riconoscibile* da una DTM se e solo se esiste una DTM $M$ tale che $L = L_M$.

Grazie alla possibilità di riconoscere linguaggi, una DTM può riconoscere anche gli insiemi: dato $A subset.eq NN$, _come lo riconosco con una DTM?_ L'idea che viene in mente è di codificare ogni elemento $a in A$ in un elemento di $Sigma^*$, per poter passare dal riconoscimento di un insieme al riconoscimento di un linguaggio.

$ A arrow.long.squiggly #square(align(center + horizon)[cod]) arrow.long.squiggly L_A = {cod(a) : a in A} $

Un insieme $A$ è riconoscibile da una DTM se e solo se esiste una DTM $M$ tale che $L_A = L_M$.

Quando facciamo riconoscere un insieme $A$ a una DTM $M$, possiamo trovarci in due situazioni, in funzione dell'input (_codificato_):
+ se l'input appartiene ad $A$, allora $M$ si arresta;
+ se l'input _non_ appartiene ad $A$, allora $M$ può:
  - arrestarsi rifiutando l'input, ovvero finisce in uno stato $q in.not F$, ma allora $A$ è ricorsivo;
  - andare in loop, ma allora $A$ è ricorsivamente numerabile.

#theorem(
  numbering: none
)[
  La classe degli insiemi riconosciuti da DTM coincide con la classe degli insiemi ricorsivamente numerabili.
]

Un *algoritmo deterministico* per il riconoscimento di un insieme $A subset.eq NN$ è una DTM $M$ tale che $L_A = L_M$ e tale che $M$ si arresta su ogni input.

#theorem(
  numbering: none
)[
  La classe degli insiemi riconosciuti da algoritmi deterministici coincide con la classe degli insiemi ricorsivi.
]

== Problemi di decisione

Una seconda funzionalità delle DTM è quella di risolvere dei *problemi di decisione*.

Dato problema $Pi$, con istanza $x in D$ e domanda $p(x)$, andiamo a codificare gli elementi di $D$ in elementi di $Sigma^*$, ottenendo $L_Pi = {cod(x) bar.v x in D and p(x)}$ *insieme delle istanze (_codificate_) a risposta positiva* di $Pi$.

La DTM risolve $Pi$ se e solo se $M$ è un *algoritmo deterministico* per $L_Pi$, ovvero:
- se vale $p(x)$, allora $M$ accetta la codifica di $x$;
- se non vale $p(x)$, allora $M$ si arresta senza accettare.

== Calcolo di funzioni

Oltre a riconoscere linguaggi, riconoscere insiemi e risolvere problemi di decisione, le DTM sono anche in grado di *calcolare funzioni*. Questo è un risultato molto importante, in quanto sappiamo che calcolare funzioni significa risolvere problemi del tutto generali, quindi non solo di decisione.

Data una funzione $f : Sigma^* arrow.long Gamma^*$, la DTM $M$ calcola $f$ se e solo se:
- se $f(x) arrow.b$ allora $M$ su input $x$ termina con $f(x)$ sul nastro;
- se $f(x) arrow.t$ allora $M$ su input $x$ va in loop.

A tutti gli effetti le DTM sono _sistemi di programmazione_.

== Potenza computazionale

È possibile dimostrare che le DTM calcolano tutte e sole le funzioni *ricorsive parziali*.

Possiamo riscrivere la *tesi di Church-Turing* come

#align(center)[
  #block(
    stroke: green + 1pt,
    inset: 1em,
    breakable: true,
    
    [_"Una funzione è intuitivamente calcolabile se e solo se è calcolata da una DTM"_]
  )
]

Inoltre, è possibile dimostrare che le DTM sono *SPA* (sistemi di programmazione accettabili), semplicemente mostrando che valgono i _tre assiomi di Rogers_:
+ le DTM calcolano tutte e sole le funzioni *ricorsive parziali*;
+ esiste una *DTM universale* che simula tutte le altre;
+ vale il teorema $S^m_n$.
