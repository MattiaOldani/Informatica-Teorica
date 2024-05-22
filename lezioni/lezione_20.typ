// Setup

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

#import "alias.typ": *

// Appunti

= Lezione 20

== Crescita asintotica

=== Introduzione

Quello che facciamo nella teoria della complessità è chiederci _"quanto costa questo programma?"_

Considerando il tempo, abbiamo due diversi tipi di costo: _"poco"_ oppure _"troppo"_. Capiremo durante la lezione il perché delle virgolette.

Stiamo valutando $t(n)$, ovvero $ t(n) = max{T(x) bar.v x in Sigma^* and |x| = n} $ il massimo numero di iterazioni di una DTM nell'eseguire input di grandezza $n$.

Nel fare il confronto tra due algoritmi per uno stesso problema, bisogna tenere in considerazione che a fare la differenza (in termini di prestazioni) sono gli input di dimensione "ragionevolmente grande", dove con questa espressione intendiamo una dimensione significativa nel contesto d'applicazione del problema.

Siano ad esempio $t_1,t_2$ le due potenze computazionali tali che $ t_1 (n) = 2n quad bar.v quad t_2 (n) = 1/100 n^2 + 1/2 n + 1 . $

Quale delle due è migliore? La risposta è _dipende_: se considero $n$ abbastanza piccoli allora $t_2$ è migliore perché i coefficienti ammortizzano il valore di $n^2$, mentre se considero $n$ sufficientemente grandi è migliore $t_1$.

Date due complessità, non le devo valutare per precisi valori di $n$, ma devo valutare il loro *andamento asintotico*, ovvero quando $n$ tende a $+infinity$.

=== Simboli di Landau

Riprendiamo i simboli matematici che abbiamo già visto in molti altri corsi che ci permettono di stabilire degli *ordini di grandezza* fra le funzioni, in modo da poterle paragonare.

Questi simboli si chiamano *simboli di Landau*, e i più utilizzati sono i seguenti tre:
+ $O$: letto _"O grande"_, date due funzioni $f,g : NN arrow.long NN$ diciamo che $ f(n) = O(g(n)) $ se e solo se $ exists c > 0 quad exists n_0 in NN bar.v forall n gt.eq n_0 quad f(n) lt.eq c dot g(n) . $ Questo simbolo dà un *upper bound* alla funzione $f$.
+ $Omega$: letto _"Omega grande"_, date due funzioni $f,g : NN arrow.long NN$ diciamo che $ f(n) = Omega(g(n)) $ se e solo se $ exists c > 0 quad exists n_0 in NN bar.v forall n gt.eq n_0 quad f(n) gt.eq c dot g(n). $ Questo simbolo dà un *lower bound* alla funzione $f$.
+ $Theta$: letto _"teta grande"_, date due funzioni $f,g : NN arrow.long NN$ diciamo che $ f(n) = Theta(g(n)) $ se e solo se $exists c_1, c_2 > 0 quad exists n_0 in NN bar.v forall n gt.eq n_0 quad c_1 dot g(n) lt.eq f(n) lt.eq c_2 dot g(n). $

// tia: mettiamo un disegno? l'ha fatto a lezione

Si può notare facilmente che valgono la proprietà $ f(n) = O(g(n)) arrow.l.r.long.double g(n) = Omega(f(n)) $ e la proprietà $ f(n) = Theta(g(n)) arrow.l.r.long.double f(n) = O(g(n)) and f(n) = Omega(g(n)) . $

Noi useremo spesso $O$ perché ci permette di definire il _worst case_.

== Classificazione di funzioni

=== Introduzione

Con l'uso di questa notazione è possibile classificare le funzioni in una serie di classi in base a come è fatta la loro funzione soluzione $t(n)$.

Data una funzione $t : NN arrow.long NN$, possiamo avere:

#align(center)[
  #table(
    columns: (30%, 40%, 30%),
    inset: 10pt,
    align: horizon,
    
    [*Tempo*], [*Definizione formale*], [*Esempio*],

    [*Costante*], [$t(n) = O(1)$], [Segno di un numero in binario],
    [*Logaritmica*], [$f(n) = O(log(n))$], [Difficile fare esempi per questo perché quasi mai riusciamo a dare una risposta leggendo $log(n)$ input dal nastro],
    [*Lineare*], [$f(n) = O(n)$], [Parità di un numero in binario],
    [*Quadratica*], [$f(n) = O(n^2)$], [Stringa palindroma],
    [*Polinomiale*], [$f(n) = O(n^k)$], [Qualsiasi funzione polinomiale],
    [*Esponenziale*], [$f(n)$ non polinomiale ma super polinomiale], [Alcune funzioni super polinomiali sono $ e^n bar.v n! bar.v n^(log n) $]
  )
]

L'ultima classe rappresenta il _"troppo"_ che abbiamo definito prima: infatti, nel _"troppo"_ ci va tutto il calderone delle funzioni super polinomiali. Un algoritmo in questa classe si definisce *inefficiente*.

Altrimenti, convenzionalmente, un algoritmo si dice *efficiente* se la sua complessità temporale è *polinomiale*.

=== Classi di complessità

Vogliamo utilizzare il concetto di _classi di equivalenza_ per definire delle classi che racchiudano tutti i problemi che hanno bisogno della stessa quantità di risorse computazionali per essere risolti correttamente.

Una *classe di complessità* è un insieme dei problemi che vengono risolti entro gli stessi limiti di risorse computazionali.

Proviamo a definire alcune classi di complessità in funzione della risorsa tempo.

La prima che introduciamo è la classe $ dtime(f(n)), $ definita come l'insieme dei problemi risolti da una DTM in tempo deterministico $t(n) = O(f(n))$. Sappiamo in realtà che la definizione corretta dovrebbe riguardare i _linguaggi accettati_, ma abbiamo visto nella scorsa lezione che abbiamo una analogia tra essi.

Nella scorsa lezione abbiamo inoltre mostrato che le DTM possono anche calcolare funzioni, quindi possiamo propagare questa definizione di DTIME anche alle funzioni stesse, ovvero possiamo definire delle classi di complessità anche per le funzioni.

_Ma cosa intendiamo con "complessità in tempo per una funzione"?_

La funzione $f : Sigma^* arrow.long Gamma^*$ è calcolata con *complessità in tempo* $t(n)$ dalla DTM $M$ se e solo se su ogni input $x$ di lunghezza $n$ la computazione di $M$ su $x$ si arresta entro $t(n)$ passi, avendo $f(x)$ sul nastro.

Detto ciò, introduciamo la classe $ ftime(f(n)) $ definita come l'insieme delle funzioni risolte da una DTM in tempo deterministico $t(n) = O(f(n))$.

Grazie a quanto detto finora, possiamo definire due classi di complessità storicamente importanti: $ P = union.big_(k gt.eq 0) dtime(n^k) $ *classe dei problemi* (_linguaggi_) *risolti da una DTM in tempo polinomiale* e $ fp = union.big_(k gt.eq 0) ftime(n^k) $ *classe delle funzioni calcolate da una DTM in tempo polinomiale*.

Questi sono universalmente riconosciuti come i problemi efficientemente risolubili in tempo.

_Ma perché *polinomiale* è sinonimo di efficiente in tempo?_

Possiamo dare tre motivazioni:
- *pratica*: facendo qualche banale esempio, è possibile vedere come la differenza tra un algoritmo polinomiale e uno esponenziale, per input tutto sommato piccoli, è abissale: il tempo di risoluzione di un problema, nel primo caso, è di frazioni di secondo, mentre nel secondo arriva facilmente ad anni o secoli;
- *"composizionale"*: programmi efficienti che richiamano routine efficienti rimangono efficienti, questo perché concatenare algoritmi efficienti non fa altro che generare un tempo pari alla somma delle complessità dei due algoritmi, che rimane polinomiale in quanto efficienti e polinomiali a loro volta;
- *"robustezza"*: le classi $P$ e $fp$ rimangono invariate a prescindere dai molti modelli di calcolo utilizzati per circoscrivere i problemi efficientemente risolti.

Per l'ultimo motivo, infatti, si può dimostrare che $P$ e $fp$ non dipendono dal modello scelto, che sia RAM, WHILE, DTM, eccetera.

=== Tesi di Church-Turing estesa

// Formattare meglio

*Tesi di Church-Turing estesa*: la classe dei problemi *efficientemente risolubili in tempo* coincide con la classe dei problemi risolti in _tempo polinomiale_ su DTM.

// gigi: non so se mettere gli esempi dei problemi efficientemente risolubili
// tia: si mettili che io non li so

=== Chiusura di $P$

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

  Date due istanze $A,B in P$ e siano $M_A,M_B$ due DTM con tempi rispettivamente $p(n)$ e $q(n)$, allora il seguente programma (ad alto livello) $ P equiv & "input"(n) \ & y := M_A (x); \ & z := M_B (x); \ & "output"(y or z) $ permette il calcolo dell'unione di $A$ e $B$ in tempo $t(n) = p(n) + q(n)$.

  #block(
    fill: rgb("#9FFFFF"),
    inset: 8pt,
    radius: 4pt,
    
    [INTERSEZIONE] 
  )

  Date due istanze $A,B in P$ e siano $M_A,M_B$ due DTM con tempi rispettivamente $p(n)$ e $q(n)$, allora il seguente programma (ad alto livello) $ P equiv & "input"(n) \ & y := M_A (x); \ & z := M_B (x); \ & "output"(y and z) $ permette il calcolo dell'intersezione di $A$ e $B$ in tempo $t(n) = p(n) + q(n)$.

  #block(
    fill: rgb("#9FFFFF"),
    inset: 8pt,
    radius: 4pt,
    
    [COMPLEMENTO] 
  )

  Data l'istanza $A in P$ e sia $M_A$ una DTM con tempo $p(n)$, allora il seguente programma (ad alto livello) $ P equiv & "input"(n) \ & y := M_A (x); \ & "output"(not y) $ permette il calcolo del complemento di $A$ in tempo $t(n) = p(n)$.
]

La classe $P$, inoltre, è anche chiusa rispetto all'operazione di *composizione*: infatti, posso comporre tra loro le macchine di Turing come se fossero procedure black box. Facendo l'esempio con due DTM, otteniamo $ x arrow.long.squiggly M_1 arrow.long.squiggly x' arrow.long.squiggly M_2 arrow.long.squiggly y. $ Supponiamo che le macchine $M_1,M_2$ abbiano tempo rispettivamente $p(n)$ e $q(n)$, allora il tempo totale è $ t(n) lt.eq p(n) + q(p(n)) . $ Usiamo $q(p(n))$ perché eseguendo $M_1$ in $p(n)$ passi il massimo output che scrivo è grande $p(n)$.

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
    [$n^3$], [$approx s \/ a$],
    [$2^n$], [$1$ gogol, ovvero $10^100$ secondi, più dell'età dell'universo]
  )
]

Infine, parliamo di costanti nei simboli di Landau: con costanti molto grandi riesco a inserire algoritmi inefficienti negli efficienti e viceversa. Ad esempio, l'algoritmo del _quicksort_ è più lento nel _worst case_ dell'algoritmo del _mergesort_, però la costante del mergesort è più grande di quella del quicksort.

=== Problemi difficili

Esistono moltissimi problemi pratici e importanti per i quali ancora non sono stati trovati algoritmi efficienti e non è nemmeno stato provato che tali algoritmi non possano per natura esistere. 

In altre parole, non sappiamo se tutti i problemi sono in realtà efficientemente risolubili o se ne esistono alcuni il cui miglior algoritmo di risoluzione abbia una complessità esponenziale.
