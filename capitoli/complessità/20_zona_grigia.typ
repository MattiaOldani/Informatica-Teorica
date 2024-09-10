#import "@preview/lemmify:0.1.5": *

#let (theorem, lemma, corollary, remark, proposition, example, proof, rules: thm-rules) = default-theorems(
  "thm-group",
  lang: "it",
)

#show: thm-rules

#show thm-selector("thm-group", subgroup: "theorem"): it => block(
  it,
  stroke: red + 1pt,
  inset: 1em,
  breakable: true,
)

#import "../alias.typ": *


= La "zona grigia"

Chiamiamo *zona grigia* quella _nuvola_ di problemi di decisione importanti e con molte applicazioni per i quali non si conoscono ancora algoritmi efficienti in tempo, _ma_ per i quali nessuno ha mai dimostrato che tali algoritmi non possano esistere. Infatti, dato un problema $Pi$, se mi viene detto che ad oggi non esiste un algoritmo efficiente per la sua soluzione, questo non implica che allora lo sia veramente: è molto difficile come dimostrazione.

I problemi di decisione in questa zona hanno una particolarità: sono *efficientemente verificabili*. Data un'istanza particolare, è facile capire se per quel problema e quell'istanza bisogna rispondere #text(green)[SI] o #text(red)[NO].

== Esempi

=== _CNF-SAT_

Il problema _*CNF-SAT*_ ha come obiettivo quello di stabilire se esiste un assegnamento a variabili booleane che soddisfi un predicato logico in forma normale congiunta. Le formule sono indicate con $phi(x_1, dots, x_n)$ e sono formate da congiunzioni $C_1 and dots and C_k$, ognuna delle quali contiene almeno una variabile booleana $x_i$.

Formalmente, data una _CNF_ $phi(x_1, dots, x_n)$, vogliamo rispondere alla domanda $ exists wstato(x) in {0,1}^n bar.v phi(wstato(x)) = 1? $

Un possibile algoritmo di risoluzione è quello esaustivo: $ P equiv & "for" wstato(x) in {0,1}^n "do" \ & quad "if" phi(wstato(x)) = 1 "then" \ & quad quad "return" 1 \ & "return" 0. $

Notiamo come le possibili permutazioni con ripetizione sono $2^n$, mentre la verifica della soddisfacibilità è fattibile in tempo polinomiale $n^k$. Di conseguenza, questo algoritmo risulta inefficiente, in quanto esplorare tutto l'albero dei possibili assegnamenti (_sottoproblemi_) richiederebbe tempo esponenziale.

*Attenzione al viceversa*. Se ho infinite configurazioni da testare non è vero che il problema usi algoritmi inefficienti: esistono problemi su grafi (_raggiungibilità_) che potrebbero testare infinite configurazioni ma che in realtà sono efficientemente risolti con altre tecniche.

=== Circuiti hamiltoniani

Dato $G = (V,E)$ grafo non diretto, vogliamo sapere se $G$ contiene un circuito hamiltoniano o meno.

Ricordiamo un paio di concetti sui grafi:
- *cammino*: sequenza di vertici $V_1, dots, V_k$ tali che $forall 1 lt.eq i lt k quad (V_i, V_(i+1)) in E$;
- *circuito*: cammino $V_1, dots, V_k$ tale che $V_1 = V_k$, quindi un cammino che parte e termina in uno stesso vertice;
- *circuito hamiltoniano*: circuito in cui tutti i vertici di $G$ vengono visitati una e una sola volta.

Un algoritmo per questo problema è il seguente: $ P equiv & "for" (V_i_1, dots, V_i_n, V_i_1) in op("Perm")(V) "do" \ & quad "if" op("IS_HC") (V_i_1, dots, V_i_n, V_i_1) = 1 "then" \ & quad quad "return" 1 \ & "return" 0, $ in cui sostanzialmente generiamo tutte le permutazioni possibili di vertici che iniziano e finiscono con lo stesso vertice e verifichiamo efficientemente se esse sono un circuito hamiltoniano o meno.

Calcoliamo la complessità temporale di questo algoritmo:
- il numero di permutazioni, e quindi il numero di volte che viene eseguito il ciclo, sono $n!$;
- il controllo sulla permutazione può essere implementato efficientemente in tempo polinomiale.

=== Circuiti euleriani

Dato $G = (V,E)$ un grafo non diretto, vogliamo sapere se $G$ contiene un circuito euleriano o meno.

Ricordiamo che un circuito euleriano è un circuito in cui tutti gli archi di $G$ vengono visitati una e una sola volta. Potrebbe sembrare simile al problema precedente, ma non lo è!

#theorem(numbering: none, name: "Eulero 1736")[
  Un grafo $G$ contiene un circuito euleriano se e solo se ogni suo vertice ha grado pari, ovvero $ forall v in V quad "GRADO"(v) = 2k bar.v k in NN. $
]

Grazie a questo teorema è possibile risolvere il problema in tempo lineare, quindi efficiente. Purtroppo non esiste un teorema simile per i circuiti hamiltoniani.

== Classe EXPTIME

Definiamo ora la classe $ exptime = union.big_(k gt.eq 0) dtime(2^n^k) $ dei problemi con complessità temporale *esponenziale*. Ovviamente vale $ P subset.eq exptime, $ perché ogni polinomio è "_maggiorabile_" da un esponenziale. Per diagonalizzazione si è dimostrato in realtà che $ P subset exptime $ sfruttando una *NDTM* (_Non-Deterministic Turing Machine_) con timeout.
