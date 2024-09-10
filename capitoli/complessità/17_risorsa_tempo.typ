#import "@preview/algo:0.3.3": algo, i, d, code

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

#show thm-selector("thm-group", subgroup: "proof"): it => block(
  it,
  stroke: green + 1pt,
  inset: 1em,
  breakable: true
)

#import "../alias.typ": *


= Definizione della risorsa tempo

_Come mai utilizziamo una DTM e non una macchina RAM per dare una definizione rigorosa di tempo?_

La risposta sta nella *semplicità*: le macchine RAM, per quanto semplici, lavorano con banchi di memoria che possono contenere dati di grandezza arbitraria ai quali accediamo con tempo $O(1)$, cosa che invece non possiamo fare con le DTM perché il nastro contiene l'input diviso su più celle.

== Definizione

Consideriamo la DTM $M = (Q, Sigma, Gamma, delta, q_0, F)$ e definiamo:
- $T(x)$ il *tempo di calcolo* di $M$ su input $x in Sigma^*$ come il valore
$ T(x) = \# "mosse della computazione di" M "su input" x "(anche" infinity")"; $
- $t(n)$ la *complessità in tempo* di $M$ (_worst case_) come la funzione
$ t : NN arrow.long NN bar.v t(n) = max{T(x) bar.v x in Sigma^* and abs(x) = n} . $

L'attributo *worst case* indica il fatto che $t(n)$ rappresenta il tempo _peggiore_ di calcolo su tutti gli input di lunghezza $n$. È la metrica più utilizzata anche perché è la più "manovrabile matematicamente", cioè ci permette di utilizzare delle funzioni più facilmente trattabili dal punto di vista algebrico. Ad esempio, nella situazione *average case* avremo una stima probabilmente migliore ma ci servirebbe anche una distribuzione di probabilità, che non è molto facile da ottenere.

Diciamo che il linguaggio $L subset.eq Sigma^*$ è riconoscibile in *tempo deterministico* $f(n)$ se e solo se esiste una DTM $M$ tale che:
+ $L = L_M$;
+ $t(n) lt.eq f(n)$.

L'ultima condizione indica che a noi _"basta"_ $f(n)$ ma che possiamo accettare situazioni migliori.

Possiamo estendere questa definizione anche agli insiemi o ai problemi di decisione:
- l'*insieme* $A subset.eq NN$ è riconosciuto in tempo $f(n)$ se e solo se lo è il linguaggio $ L_A = {cod(A) bar.v a in A} ; $
- il *problema di decisione* $Pi$ è risolto in tempo $f(n)$ se e solo lo è il linguaggio $ L_Pi = {cod(x) bar.v p(x)} . $

Da qui in avanti, quando parleremo di *linguaggi* intenderemo indirettamente *insiemi* o *problemi di decisione*, vista la stretta analogia tra questi concetti.

== Classi di complessità

=== Classificazione di funzioni

Tramite i simboli di Landau è possibile classificare le funzioni in una serie di classi.

Per quanto riguarda il tempo, data una funzione $t : NN arrow.long NN$ possiamo avere:

#align(center)[
  #table(
    columns: (30%, 40%, 30%),
    inset: 10pt,
    align: horizon,
    
    [*Funzione*], [*Definizione formale*], [*Esempio*],

    [*Costante*], [$t(n) = O(1)$], [Segno di un numero in binario],
    [*Logaritmica*], [$f(n) = O(log(n))$], [Difficile fare esempi per questo perché quasi mai riusciamo a dare una risposta leggendo $log(n)$ input dal nastro],
    [*Lineare*], [$f(n) = O(n)$], [Parità di un numero in binario],
    [*Quadratica*], [$f(n) = O(n^2)$], [Stringa palindroma],
    [*Polinomiale*], [$f(n) = O(n^k)$], [Qualsiasi funzione polinomiale],
    [*Esponenziale*], [$f(n)$ non polinomiale ma super polinomiale], [Alcune funzioni super polinomiali sono $ e^n bar.v n! bar.v n^(log n) $]
  )
]

L'ultima classe rappresenta una classe che costo _"troppo"_ elevato, ovvero una classe nella quale non vorremmo mai capitare. Qua dentro ci va tutto il calderone delle funzioni super polinomiali, che sono dette anche *inefficienti*.

Altrimenti, convenzionalmente, un algoritmo si dice *efficiente* se la sua complessità temporale è *polinomiale*.

=== Definizione di classi di complessità

Vogliamo utilizzare il concetto di _classi di equivalenza_ per definire delle classi che racchiudano tutti i problemi che hanno bisogno della stessa quantità di risorse computazionali per essere risolti correttamente.

Una *classe di complessità* è un insieme dei problemi che vengono risolti entro gli stessi limiti di risorse computazionali.

=== Classi di complessità principali

Proviamo a definire alcune classi di complessità in funzione della risorsa tempo.

La prima che introduciamo è la classe $ dtime(f(n)), $ definita come l'insieme dei problemi risolti da una DTM in tempo deterministico $t(n) = O(f(n))$. Sappiamo in realtà che la definizione corretta dovrebbe riguardare i _linguaggi accettati_, ma abbiamo visto nella scorsa lezione che abbiamo una analogia tra essi.

Nella scorsa lezione abbiamo inoltre mostrato che le DTM possono anche calcolare funzioni, quindi possiamo propagare questa definizione di DTIME anche alle funzioni stesse, ovvero possiamo definire delle classi di complessità anche per le funzioni.

_Ma cosa intendiamo con "complessità in tempo per una funzione"?_

La funzione $f : Sigma^* arrow.long Gamma^*$ è calcolata con *complessità in tempo* $t(n)$ dalla DTM $M$ se e solo se su ogni input $x$ di lunghezza $n$ la computazione di $M$ su $x$ si arresta entro $t(n)$ passi, avendo $f(x)$ sul nastro.

Detto ciò, introduciamo la classe $ ftime(f(n)) $ definita come l'insieme delle funzioni risolte da una DTM in tempo deterministico $t(n) = O(f(n))$.

Grazie a quanto detto finora, possiamo definire due classi di complessità storicamente importanti: $ P = union.big_(k gt.eq 0) dtime(n^k) $ *classe dei problemi risolti da una DTM in tempo polinomiale* e $ fp = union.big_(k gt.eq 0) ftime(n^k) $ *classe delle funzioni calcolate da una DTM in tempo polinomiale*.

Questi sono universalmente riconosciuti come i problemi efficientemente risolubili in tempo.

_Ma perché *polinomiale* è sinonimo di efficiente in tempo?_

Possiamo dare tre motivazioni:
- *pratica*: facendo qualche banale esempio, è possibile vedere come la differenza tra un algoritmo polinomiale e uno esponenziale, per input tutto sommato piccoli, è abissale: il tempo di risoluzione di un problema, nel primo caso, è di frazioni di secondo, mentre nel secondo arriva facilmente ad anni o secoli;
- *"composizionale"*: programmi efficienti che richiamano routine efficienti rimangono efficienti, questo perché concatenare algoritmi efficienti non fa altro che generare un tempo pari alla somma delle complessità dei due algoritmi, che rimane polinomiale in quanto efficienti e polinomiali a loro volta;
- *"robustezza"*: le classi $P$ e $fp$ rimangono invariate a prescindere dai molti modelli di calcolo utilizzati per circoscrivere i problemi efficientemente risolti.

Per l'ultimo motivo, infatti, si può dimostrare che $P$ e $fp$ non dipendono dal modello scelto, che sia RAM, WHILE, DTM, eccetera.

=== Esempio

Facciamo vedere quanto influenzano l'esponente della funzione polinomiale e le costanti dei simboli di Landau. Consideriamo una macchina a $4$GHz che esegue un'operazione ogni $ 1 / (4 dot.op 10^9) $ secondi. Fissiamo anche l'input di grandezza $n = 4000$ caratteri.

La seguente tabella mostra i tempi approssimati di alcune funzioni su input di grandezza $n$.

#align(center)[
  #table(
    columns: (35%, 35%),
      inset: 10pt,
      align: horizon,

    [*Funzione* $t(n)$], [*Tempo di esecuzione*],
    [$n$], [$approx  mu s$],
    [$n^2$], [$approx m s$], 
    [$n^3$], [$approx s slash a$],
    [$2^n$], [$1$ gogol, ovvero $10^100$ secondi, più dell'età dell'universo]
  )
]

Infine, parliamo di costanti nei simboli di Landau: con costanti molto grandi riesco a inserire algoritmi inefficienti negli efficienti e viceversa. Ad esempio, l'algoritmo del _quicksort_ è più lento nel _worst case_ dell'algoritmo del _mergesort_, però la costante del mergesort è più grande di quella del quicksort.

== Tesi di Church-Turing estesa

La *tesi di Church-Turing estesa* afferma che la classe dei problemi *efficientemente risolubili in tempo* coincide con la classe dei problemi risolti in _tempo polinomiale_ su DTM.

La possiamo vedere come la _versione quantitativa_ della tesi di Church-Turing.

== Chiusura di $P$

#theorem(numbering: none)[
  La classe $P$ è un'algebra di Boole, ovvero è chiusa rispetto alle operazioni di unione, intersezione e complemento.
]

#proof[
  #block(
    fill: rgb("#9FFFFF"),
    inset: 8pt,
    radius: 4pt,
    
    [UNIONE] 
  )

  Date due istanze $A,B in P$, siano $M_A$ e $M_B$ due DTM con tempi rispettivamente $p(n)$ e $q(n)$. Allora il seguente programma (_ad alto livello_) $ P equiv & "input"(n) \ & y := M_A (x); \ & z := M_B (x); \ & "output"(y or z) $ permette il calcolo dell'unione di $A$ e $B$ in tempo $t(n) = p(n) + q(n)$.

  #block(
    fill: rgb("#9FFFFF"),
    inset: 8pt,
    radius: 4pt,
    
    [INTERSEZIONE] 
  )

  Date due istanze $A,B in P$, siano $M_A$ e $M_B$ due DTM con tempi rispettivamente $p(n)$ e $q(n)$. Allora il seguente programma (_ad alto livello_) $ P equiv & "input"(n) \ & y := M_A (x); \ & z := M_B (x); \ & "output"(y and z) $ permette il calcolo dell'intersezione di $A$ e $B$ in tempo $t(n) = p(n) + q(n)$.

  #block(
    fill: rgb("#9FFFFF"),
    inset: 8pt,
    radius: 4pt,
    
    [COMPLEMENTO] 
  )

  Data l'istanza $A in P$, sia $M_A$ una DTM con tempo $p(n)$. Allora il seguente programma (_ad alto livello_) $ P equiv & "input"(n) \ & y := M_A (x); \ & "output"(not y) $ permette il calcolo del complemento di $A$ in tempo $t(n) = p(n)$.
]

La classe $P$, inoltre, è anche chiusa rispetto all'operazione di *composizione*: infatti, posso comporre tra loro le macchine di Turing come se fossero procedure black box. Facendo l'esempio con due DTM, otteniamo $ x arrow.long.squiggly M_1 arrow.long.squiggly x' arrow.long.squiggly M_2 arrow.long.squiggly y. $ Supponiamo che le macchine $M_1$ e $M_2$ abbiano tempo rispettivamente $p(n)$ e $q(n)$, allora il tempo totale è $ t(n) lt.eq p(n) + q(p(n)) . $ Usiamo $q(p(n))$ perché eseguendo $M_1$ in $p(n)$ passi il massimo output che scrivo è grande $p(n)$.

== Problemi difficili

Esistono moltissimi problemi pratici e importanti per i quali ancora non sono stati trovati algoritmi efficienti e non è nemmeno stato provato che tali algoritmi non possano per natura esistere. 

In altre parole, non sappiamo se tutti i problemi sono in realtà efficientemente risolubili o se ne esistono alcuni il cui miglior algoritmo di risoluzione abbia una complessità esponenziale.
