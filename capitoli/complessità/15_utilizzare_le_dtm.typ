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

=== Funzionalità di una DTM

- La principale funzionalità di una DTM è *riconoscere linguaggi*.\
  Un linguaggio $L subset.eq Sigma^*$ è *riconoscibile* da una DTM se e solo se esiste una DTM $M$ tale che $L = L_M$.

  Grazie alla possibilità di riconoscere linguaggi, una DTM può riconoscere anche gli insiemi: dato $A subset.eq NN$, _come lo riconosco con una DTM?_\
  L'idea che viene in mente è di codificare ogni elemento $a in A$ in un elemento di $Sigma^*$, per poter passare dal riconoscimento di un insieme al riconoscimento di un linguaggio.

  #align(
    center + horizon
  )[
    $A arrow.long.squiggly #square(cod) arrow.long.squiggly L_A = {cod(a) : a in A}$
  ]


  Un insieme $A$ è riconoscibile da una DTM sse esiste una DTM $M$ tale che $L_A = L_M$.

  Quando facciamo riconoscere un insieme $A$ a una DTM $M$, possiamo trovarci in due situazioni, in funzione dell'input (codificato):
  + se l'input appartiene ad $A$, allora $M$ si arresta;
  + se l'input _non_ appartiene ad $A$, allora $M$ può:
    - arrestarsi rifiutando l'input, ovvero finisce in uno stato $q in.not F arrow.double A$ è ricorsivo;
    - andare in loop $arrow.double A$ è ricorsivamente numerabile.

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

- Una seconda funzionalità delle DTM è che possono risolvere dei *problemi di decisione*. Vediamo il procedimento per farlo.

  Dato problema $Pi$, con istanza $x in D$ e domanda $p(x)$, andiamo a codificare gli elementi di $D$ in elementi di $Sigma^*$, ottenendo $L_Pi = {cod(x) bar.v x in D and p(x)}$ *insieme delle istanze a risposta positiva* di $Pi$.

  La DTM risolve $Pi$ sse $M$ è un algoritmo deterministico per $L_Pi$, ovvero:
  - se vale $p(x)$, allora $M$ accetta la codifica di $x$;
  - se non vale $p(x)$, allora $M$ si arresta senza accettare.

== DTM per problemi di decisione

=== Definizione

Dato un problema $Pi$ con istanza $x in D$ e domanda $p(x)$, la DTM $M$ risolve $Pi$ se e solo se $M$ è un *algoritmo deterministico* per $L_Pi$, ovvero:
- se $p(x)$ allora $M$ accetta $cod(x)$;
- se $not p(x)$ allora $M$ si arresta su $cod(x)$ senza accettare.

=== Esempio: parità

- Nome: parità.
- Istanza: $x in NN$.
- Domanda: $x$ è pari?

Come codifica utilizziamo quella _binaria_, ovvero $ cod : NN arrow.long {0,1}^* . $ Di conseguenza, il linguaggio da riconoscere è $ L_"PARI" = {x in {0,1}^* bar.v x_1 = 1 and x_(|x|) = 0} union {0}. $

Risolvere il problema _parità_ significa trovare una DTM $M$ che sia un algoritmo deterministico che riconosce proprio $L_"PARI"$.

Ricordando che $M = (Q, Sigma, Gamma, delta, q_0, F)$, la seguente macchina riconosce $L_"PARI"$:
- $Q = {p, z_1, mu, z, r}$ insieme degli stati;
- $Sigma = {0, 1}$ alfabeto;
- $Gamma = {0, 1, blank}$ alfabeto di lavoro;
- $q_0 = p$ stato iniziale;
- $F = {z_1, z}$ insiemi degli stati finali;
- $delta : Q times Gamma arrow.long Q times Sigma times {-1, 0, 1}$ funzione di transizione così definita:

#align(center)[
  #table(
    columns: (25%, 25%, 25%, 25%),
    inset: 10pt,
    align: horizon,
    
    [$delta$], [$blank$], [$0$], [$1$],
    
    [$p$], [$bot$], [$(z_1, 0, +1)$], [$(mu, 1, +1)$],
    [$z_1$], [$bot$], [$(r, 0, +1)$], [$(mu, 1, +1)$],
    [$mu$], [$bot$], [$(z, 0, +1)$], [$(mu, 1, +1)$],
    [$z$], [$bot$], [$(z, 0, +1)$], [$(mu, 1, +1)$],
    [$r$], [$bot$], [$bot$], [$bot$],
  )
]

== DTM per calcolare funzioni

=== Definizione

Oltre a riconoscere linguaggi, riconoscere insiemi e risolvere problemi di decisione, le DTM sono anche in grado di *calcolare funzioni*. Questo è un risultato molto importante, in quanto sappiamo che calcolare funzioni significa risolvere problemi del tutto generali, quindi non solo di decisione.

Data una funzione $f : Sigma^* arrow.long Gamma^*$, la DTM $M$ calcola $f$ se e solo se:
- se $f(x) arrow.b$ allora $M$ su input $x$ termina con $f(x)$ sul nastro;
- se $f(x) arrow.t$ allora $M$ su input $x$ va in loop.

A tutti gli effetti le DTM sono _sistemi di programmazione_.

=== Potenza computazionale

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

// tia: da rivedere, le slide sono un po' sus
Analogamente, per gli insiemi possiamo affermare che:
- la classe degli insiemi riconosciuti da DTM coincide con la classe degli insiemi ricorsivamente numerabili;
- la classe degli insiemi riconosciuti da algoritmi deterministici coincide con la classe degli insiemi ricorsivi.
