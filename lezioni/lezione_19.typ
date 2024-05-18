// Setup

#import "@preview/ouset:0.1.1": overset

#import "@preview/algo:0.3.3": algo, i, d, comment, code

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

#show thm-selector("thm-group", subgroup: "corollary"): it => block(
  it,
  stroke: red + 1pt,
  inset: 1em,
  breakable: true
)

#show thm-selector("thm-group", subgroup: "proof"): it => block(
  it,
  stroke: green + 1pt,
  inset: 1em,
  breakable: true
)

#import "alias.typ": *

// Appunti

= Lezione 19

== DTM per problemi di decisione

Dato un problema $(Pi, x in D, p(x))$, la DTM $M$ lo risolve sse $M$ è un algoritmo deterministico per $L_Pi$:
- se $p(x) arrow.double M$ accetta $cod(x)$;
- se $not p(x) arrow.double M$ si arresta su $cod(x)$ senza accettare.

=== Esempio: Parità

Definiamo il problema:
- Nome: PARITÀ
- Istanza: $x in D$
- Domanda: _$x$ è pari?_

Come codifica utilizziamo quella binaria: $cod : NN arrow.bar {0,1}^*$. Di conseguenza, il linguaggio da riconoscere è $ L_T = L_"PARI" = {x in {0,1}^* : x_1 = 1 and x_(|x|) = 0} union {0}. $

Risolvere PARITÀ significa trovare una DTM $M$ che sia un algoritmo che riconosce proprio $L_"PARI"$.

Ricordando che $M = (Q, Sigma, Gamma, delta, p, F)$, la seguente macchina riconosce $L_"PARI"$:
- $Q = {p, z_1, mu, z, r}$,
- $Sigma = {0, 1}$,
- $Gamma = {0, 1, blank}$,
- $p = "stato iniziale"$,
- $F = {z_1, z}$,
- $delta : Q times Gamma arrow Q times Sigma times {-1, 0, 1}$ così definita

  #align(center)[
    #table(
      columns: (auto, auto, auto, auto),
      inset: 10pt,
      align: horizon,
      table.header(
        [$delta$], [$blank$], [$0$], [$1$],
      ),
      $p$,
      $bot$,
      $(z_1, 0, +1)$,
      $(mu, 1, +1)$,
      $z_1$,
      $bot$,
      $(r, 0, +1)$,
      $(mu, 1, +1)$,
      $mu$,
      $bot$,
      $(z, 0, +1)$,
      $(mu, 1, +1)$,
      $z$,
      $bot$,
      $(z, 0, +1)$,
      $(mu, 1, +1)$,
      $r$,
      $bot$,
      $bot$,
      $bot$,
    )
  ]

  in cui stabiliamo che se $delta(dots) = dot$, siamo nello stato HALT.

== Semplificare DTM

Esibire, progettare e comprendere una DTM (e il suo funzionamento) è difficile anche in casi molto semplici, perché dobbiamo dettagliare stati, alfabeti, transizioni, ...

Solitamente, nel descrivere una DTM, si utilizza dello pseudo-codice che ne chiarisce la dinamica.

=== Esempio: Parità

Nel caso della DTM per $L_"PARI" = 1 {0,1}^* 0 union 0$, possiamo utilizzare questo pseudo-codice:

#algo(
  title: "Parità",
  parameters: ("n",)
)[
  i := 1;\
  f := false;\
  switch(x[i]) {#i\
    case 0:#i\
      i++;\
      f := (x[i] == blank);\
      break;#d\
    case 1:#i\
      do {#i\
        i++;\
        f := (x[i] == 0);#d\
      } while (x[i] != blank);#d#d\
  }\
  return f;
]

Alla fine della sue esecuzione avremo:
- se $x in L_"PARI" arrow.double$ #text(green)[True];
- se $x in.not L_"PARI" arrow.double$ #text(red)[False];

== DTM per calcolare funzioni

Oltre a riconoscere linguaggi, riconoscere insiemi e risolvere problemi di decisione, le DTM sono anche in grado di calcolare funzioni. È un risultato molto importante, in quanto sappiamo che calcolare funzioni significa risolvere problemi del tutto generali (quindi non solo di decisione). 

Data una funzione $f : Sigma^* arrow.bar Gamma^*$, la DTM $M$ calcola $f$ sse:
- se $f(x) arrow.b$, allora $M$ su $x$ termina con $f(x)$ sul nastro;
- se $f(x) arrow.t$, allora $M$ su $x$ va in loop.

=== Potenza computazionale

È possibile dimostrare che le DTM calcolano tutte e sole le funzioni *ricorsive parziali*.

La Tesi di Church-Turing può essere riscritta in questo modo: _"una funzione è intuitivamente calcolabile sse è calcolata da una DTM."_

Inoltre, è possibile dimostrare che le DTM sono un spa, semplicemente mostrando che valgono i seguenti:
+ Le DTM calcolano tutte e sole le funzioni *ricorsive parziali*;
+ Esiste una DTM universale (simula tutte le altre);
+ Vale il teorema $S_n^m$.

== Definire il Tempo dalle DTM

Consideriamo la DTM $M = (Q, Sigma, Gamma, delta, q_0, F)$ e definiamo:
- *Tempo di calcolo di $M$ su input $x in Sigma^*$*: 
$ T(x) = n° "di mosse della computazione di" M "su input" x "(anche" infinity")". $
- *Complessità in Tempo di $M$ (worst case)*:
$ t : NN arrow NN "tale che" t(n) = max{T(x) : x in Sigma^* and |x| = n}. $
- *worst case*:\
  indica il fatto che $t(n)$ rappresenta il tempo _peggiore_ di calcolo su tutti gli input di lunghezza $n$. È la metrica più utilizzata anche perché è la più "manovrabile matematicamente", cioè anno origini a delle funzioni più facilmente trattabili dal punto di vista algebrico.

=== Esempio: Parità

Facendo riferimento allo pseudo-codice scritto precedentemente per il problema PARITÀ, facciamo un'analisi temporale dell'algoritmo.

Dato l'input $x$ di lunghezza $n$, il nostro algoritmo non fa altro che consumare tutti i simboli dell'input ($n$ simboli), fino a quando a non arriva al primo blank dopo l'input $arrow.double$ $t(n) = n + 1$.

In realtà questo è il *caso peggiore*: ci sono delle istanze $n'$ per cui il problema impiega $t(n') = 2$, in particolare per quegli input in cui ci sono almeno due zeri in testa al numero ($x = 00dots$).

=== Linguaggio riconosciuto in tempo deterministico

Diciamo che il linguaggio $L subset.eq Sigma^*$ è riconoscibile in tempo deterministico $f(n)$ sse esiste una DTM $M$ tale che:
+ $L = L_M$;
+ $t(n) lt.eq f(n)$.

Possiamo estendere questa definizione anche agli insiemi o ai problemi di decisione:
- l'*insieme* $A subset.eq NN$ è riconosciuto in tempo $f(n)$ sse lo è il linguaggio $L_A = {cod(A) : a in A}$.
- il *problema di decisione* $Pi$ è risolvibile in tempo $f(n)$ sse il linguaggio $L_Pi = {cod(x) : p(x)}$ è riconosciuto in tempo $f(n)$.

Da qui in avanti, quando parleremo di *linguaggi* intenderemo indirettamente *insiemi* o *problemi di decisione*.

=== Esempio: Parità

Tornando all'esempio del problema PARITÀ, abbiamo mostrato una DTM che riconosce il linguaggio $ L_"PARI" = 1{0,1}^*0 union 0 $ con complessità in tempo $t(n) = n + 1$. Quindi abbiamo:
- il *linguaggio* $L_"PARI"$ è riconoscibile in tempo $n + 1$;
- l'*insieme* dei numeri PARI è riconoscibile in tempo $n + 1$;
- il *problema di decisione* PARI è risolubile in tempo $n + 1$.

=== Esempio: Palindrome

Problema PALINDROME:\
Data $x = x_1 x_2 dots space x_n in Sigma^*$, sia $x^R = x_n dots space x_2 x_1$: $ L_"PAL" = {x in Sigma^* : x = x^R} $

Una DTM $M$ per questo problema e che riconosce $L_"PAL"$ è la seguente:

#algo(
  title: "Palindrome",
  parameters: ("x",)
)[
  i := 1;\
  j := n;\
  f := true;\
  while(i < j && f) {#i\
    if (x[i] != x[j])#i\
      f := false;#d\
    i++;\
    j--;#d\
  }\
  return f;
]

Ovviamente, se $x in L_"PAL" arrow.double$ viene restituito #text(green)[True], mentre se $x in.not L_"PAL" arrow.double$ viene restituito #text(red)[False].

Notiamo che il worst case *NON* è $t(n) = n/2$: in una macchina di Turing, se voglio confrontare la posizione $i$-esima con quella $j$-esima, devo spostare la testina $j-i$ volte (da $i$ a $j$). Il reale tempo è circa $ t(n) approx sum_(k=0)^n k approx n^2/2 + n/2 $

Quando valutiamo il tempo, dobbiamo stare bene attenti di considerare anche i tempi di spostamento della DTM. Bisogna sempre tenere a mente l'architettura su cui implementiamo un certo algoritmo.
