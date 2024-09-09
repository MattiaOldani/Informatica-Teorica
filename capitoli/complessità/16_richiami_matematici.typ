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