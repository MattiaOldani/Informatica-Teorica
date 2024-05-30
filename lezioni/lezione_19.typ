// Setup

#import "@preview/algo:0.3.3": algo, i, d, code

#import "alias.typ": *

// Appunti

= Lezione 19

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

=== Semplificare le DTM

Esibire, progettare e comprendere una DTM è difficile anche in casi molto semplici, perché dobbiamo dettagliare stati, alfabeti, transizioni, eccetera. Solitamente, nel descrivere una DTM, si utilizza uno _pseudocodice_ che ne chiarisce la dinamica.

Esistono una serie di teoremi che dimostrano che qualsiasi frammento di programma strutturato può essere tradotto in una DTM formale e viceversa.

=== Applicazione all'esempio precedente

Nel caso della DTM $M$ che abbiamo progettato per $L_"PARI" = {1 {0,1}^* 0} union {0}$ al punto precedente possiamo utilizzare questo pseudo-codice:

#algo(
  title: "Parità",
  parameters: ("n",)
)[
  i := 1; \
  f := false; \
  switch(x[i]) { #i \
    case 0: #i \
      i++; \
      f := (x[i] == blank); \
      break; #d \
    case 1: #i \
      do { #i \
        f := (x[i] == 0); \
        i++; #d \
      } while (x[i] != blank); #d #d \
  } \
  return f;
]

Alla fine della sua esecuzione avremo:
- se $x in L_"PARI"$ allora #text(green)[True] ;
- se $x in.not L_"PARI"$ allora #text(red)[False] .

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

== Definizione della risorsa tempo

=== Introduzione

Come mai utilizziamo una DTM e non una macchina RAM per dare una definizione rigorosa di tempo? La risposta sta nella *semplicità*: le macchine RAM, per quanto semplici, lavorano con banchi di memoria che possono contenere dati di grandezza arbitraria ai quali accediamo con tempo $O(1)$, cosa che invece non possiamo fare con le DTM perché il nastro contiene l'input diviso su più celle.

=== Definizione

Consideriamo la DTM $M = (Q, Sigma, Gamma, delta, q_0, F)$ e definiamo:
- $T(x)$ il *tempo di calcolo* di $M$ su input $x in Sigma^*$ come il valore
$ T(x) = \# "mosse della computazione di" M "su input" x "(anche" infinity")"; $
- $t(n)$ la *complessità in tempo* di $M$ (_worst case_) come la funzione
$ t : NN arrow.long NN bar.v t(n) = max{T(x) bar.v x in Sigma^* and abs(x) = n} . $

L'attributo *worst case* indica il fatto che $t(n)$ rappresenta il tempo _peggiore_ di calcolo su tutti gli input di lunghezza $n$. È la metrica più utilizzata anche perché è la più "manovrabile matematicamente", cioè ci permette di utilizzare delle funzioni più facilmente trattabili dal punto di vista algebrico. Ad esempio, nella situazione *average case* avremo una stima probabilmente migliore ma ci servirebbe anche una distribuzione di probabilità, che non è molto facile da ottenere.

=== Esempio: parità

Facendo riferimento allo pseudocodice scritto precedentemente per il problema _parità_, facciamo un'analisi temporale dell'algoritmo.

// tia: secondo me t(n) = n
Dato l'input $x$ di lunghezza $n$, il nostro algoritmo non fa altro che consumare tutti i simboli dell'input fino a quando a non arriva al primo blank dopo l'input, quindi $t(n) = n + 1$.

In realtà questo che abbiamo appena mostrato è il _caso peggiore_. Ci sono delle istanze $n_z$ per cui il problema impiega $t(n_z) = 2$. Infatti, se ci sono almeno due zeri in testa al numero, ovvero siamo di fronte a istanze nella forma $ n_z = O^n bar.v n > 1 $ allora abbiamo $t(n_z) = 2$ poiché la DTM si arresta subito.

=== Linguaggio riconosciuto in tempo deterministico

Diciamo che il linguaggio $L subset.eq Sigma^*$ è riconoscibile in *tempo deterministico* $f(n)$ se e solo se esiste una DTM $M$ tale che:
+ $L = L_M$;
+ $t(n) lt.eq f(n)$.

L'ultima condizione indica che a noi _"basta"_ $f(n)$ ma che possiamo accettare situazioni migliori.

// tia: che palle non è centrato
Possiamo estendere questa definizione anche agli insiemi o ai problemi di decisione:
- l'*insieme* $A subset.eq NN$ è riconosciuto in tempo $f(n)$ se e solo se lo è il linguaggio $ L_A = {cod(A) bar.v a in A} ; $
- il *problema di decisione* $Pi$ è risolto in tempo $f(n)$ se e solo lo è il linguaggio $ L_Pi = {cod(x) bar.v p(x)} . $

Da qui in avanti, quando parleremo di *linguaggi* intenderemo indirettamente *insiemi* o *problemi di decisione*, vista la stretta analogia tra questi concetti.

=== Esempio: parità

Tornando all'esempio del problema _parità_, abbiamo mostrato una DTM che riconosce il linguaggio $ L_"PARI" = {1 {0,1}^* 0} union {0} $ con complessità in tempo $t(n) = n + 1$. Ma allora abbiamo che:
- il linguaggio $L_"PARI"$ è riconoscibile in tempo $n + 1$;
- l'insieme dei numeri pari è riconoscibile in tempo $n + 1$;
- il problema di decisione _parità_ è risolubile in tempo $n + 1$.

=== Esempio: palindrome

- Nome: palindrome.
- Istanza: $x in Sigma^*$.
- Domanda: $x$ palindroma?

// tia: sistemare
In questo problema, data la stringa $ x = x_1 x_2 dots x_n in Sigma^* $ definiamo la stringa $ x^R = x_n dots x_2 x_1 in Sigma^* $ tale che $ L_"PAL" = {x in Sigma^* bar.v x = x^R} . $

Una DTM $M$ per _palindrome_ e che riconosce $L_"PAL"$ è la seguente:

#algo(
  title: "Palindrome",
  parameters: ("x",)
)[
  i := 1; \
  j := n; \
  f := true; \
  while (i < j && f) { #i \
    if (x[i] != x[j]) #i \
      f := false; #d \
    i++; \
    j--; #d \
  } \
  return f;
]

// tia: wtf devo mettere uno spazio sennò non va
Ovviamente vale che:
- se $x in L_"PAL"$ allora viene restituito #text(green)[True] ;
- se $x in.not L_"PAL"$ allora viene restituito #text(red)[False].

Notiamo una cosa importante: il worst case *NON* è $ t(n) = n/2 . $

Infatti, in una macchina di Turing se voglio confrontare la posizione $i$-esima con quella $j$-esima devo spostare la testina $j-i$ volte, dalla posizione $i$ alla posizione $j$. Il tempo reale è $ t(n) = sum_(k=0)^(n-1) k approx n^2 . $

Quando valutiamo il tempo dobbiamo stare bene attenti di considerare anche i tempi di spostamento della DTM. Bisogna sempre tenere a mente l'architettura su cui implementiamo un certo algoritmo.
