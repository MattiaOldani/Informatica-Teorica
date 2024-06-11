// Setup

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

#show thm-selector("thm-group", subgroup: "proof"): it => block(
  it,
  stroke: green + 1pt,
  inset: 1em,
  breakable: true,
)

#import "alias.typ": *

// Appunti

== Relazione tempo-spazio

Abbiamo visto che un limite in tempo implica, in qualche modo, un limite in spazio, _ma vale anche il contrario? È possibile dimostrare che $dspace(f(n)) subset.eq dtime(f(n))$?_

Avendo un numero di celle prestabilito, è possibile iterare il loro utilizzo (anche all'infinito, entrando ad esempio in un loop), di conseguenza limitare lo spazio non implica necessariamente una limitazione del tempo.

Notiamo che, in una DTM $M$, un loop si verifica quando visitiamo una configurazione già visitata in passato. Sfruttando questo fatto, è possibile trovare una limitazione al tempo, trovando dopo quanto tempo vengono visitate tutte le configurazioni possibili.

#theorem(numbering: none)[
  Tutti i linguaggi accettati in spazio $f(n)$ vengono accettati in tempo $n dot.op alpha^(O(f(n)))$. $ dspace(f(n)) subset.eq dtime(n dot.op alpha^(O(f(n)))) $
]

#proof[
  \ Dato $L in dspace(f(n))$ e una DTM $M$ esistono una serie di configurazioni per $M$ tali che $ C_0 arrow.long^delta C_1 arrow.long^delta dots.c arrow.long^delta C_m, $ in cui $C_m$ è uno stato accettante per $L$.

  Sappiamo che $dtime$ è calcolabile dal numero di volte che viene utilizzata la funzione transizione $delta$. Date $C_i$ e $C_j$ con $i eq.not j$, vale $C_i eq.not C_j$: infatti, se fossero uguali saremmo entrati in un loop. Di conseguenza, calcolando la cardinalità dell'insieme contenente tutte le configurazioni possibili, troviamo anche un upper bound per la risorsa tempo.

  Ricordiamo che una configurazione è una quadrupla $ angle.l q,i,j,w angle.r $ formata da:
  - $q$ stato della macchina;
  - $i,j$ posizioni delle due testine;
  - $w$ valore sul nastro di lavoro.

  Analizziamo quanti valori possono assumere ognuno di questi elementi:
  - $q$: è una costante e vale $abs(Q)$;
  - $i$: contando i due delimitatori, il numero massimo è $n+2$;
  - $j$: stiamo lavorando in $dspace(f(n))$, quindi questo indice vale $O(f(n))$, che possiamo scrivere più semplicemente come $alpha f(n)$;
  - $w$: è una stringa sull'alfabeto $Gamma^(O(f(n)))$, che ha cardinalità $|Gamma|^(O(f(n)))$, scrivibile anche in questo caso come $|Gamma|^(alpha f(n))$.

  Moltiplicando tutti questi valori, troviamo il seguente upper bound: $ |C| & lt.eq O(1) dot.op (n+2) dot.op alpha f(n) dot.op |Gamma|^(alpha f(n)) \ & lt.eq O(1) dot.op (n+2) dot.op |Gamma|^(alpha f(n)) dot.op |Gamma|^(alpha f(n)) \ & = O(1) dot.op (n+2) dot.op |Gamma|^(2alpha f(n)) \ & = O(1) dot.op (n+2) dot.op 2^(log_2(|Gamma|^(2 alpha f(n)))) \ & = O(1) dot.op (n+2) dot.op 2^(2 alpha f(n) dot.op log_2(|Gamma|)) \ & = O(n dot.op 2^(O(f(n)))). $

  Quindi, $M$ sa accettare o meno $x in Sigma^*$ in al massimo $O(n dot.op 2^(O(f(n))))$ passi.

  Ora, data una DTM $M$ che accetta $L$ con $s(n) lt.eq alpha f(n)$, costruiamo una DTM $M'$ che su input $x in Sigma^*$, con $|x| = n$, si comporta nel seguente modo:
  + scrive in unario su un nastro dedicato un time-out $t$ tale che $t tilde O(n dot.op 2^(O(f(n))))$;
  + simula $M$ e ad ogni mossa cancella un simbolo di time-out del nastro dedicato;
  + se $M$ accetta o rifiuta prima della fine del time-out, allora $M'$ accetta o rifiuta allo stesso modo di $M$;
  + se allo scadere del time-out $M$ non ha ancora scelto, $M'$ rifiuta perché sa di essere entrata in un loop.

  In questo modo, $M'$ accetta il linguaggio $L$ in tempo $ t(n) = O(n dot.op 2^(O(f(n)))), $ e quindi $ dspace(f(n)) subset.eq dtime(n dot.op 2^(O(f(n)))). $
]

Come per il tempo, il teorema dimostrato vale anche per gli insiemi $fspace$ e $ftime$.

#theorem(numbering: none)[
  Tutti le funzioni calcolate in spazio $f(n)$ vengono calcolate in tempo $n dot.op alpha^(O(f(n)))$. $ fspace(f(n)) subset.eq ftime(n dot.op alpha^(O(f(n)))). $
]

=== Relazione delle classi L e P

Ottenuti questi risultati, vogliamo studiare le relazioni tra efficienza in termini di spazio (classe $L$) e l'efficienza in termini di tempo (classe $P$).

#theorem(numbering: none)[
  Valgono le seguenti relazioni per efficienza in spazio e efficienza in tempo: $ L subset.eq P \ fl subset.eq fp. $
]

#proof[
  $
    L = dspace(log(n)) & subset.eq dtime(n dot.op alpha^(O(log(n)))) = \ & = dtime(n dot.op alpha^(frac(log_alpha (n), log_alpha(2)))) = \ & = dtime(n dot.op (alpha^(log_alpha (n)))^(frac(1, log_alpha (2)))) = \ & = dtime(n dot.op n^(frac(1, log_alpha (2)))) = \ & = dtime(n dot.op n^beta) = dtime(n^(beta+1)) = dtime(n^k) = P
  $

  Allo stesso modo è ottenibile l'inclusione per $fl$ e $fp$.
]

Grazie a questo teorema sappiamo che:
- *in teoria*, algoritmi efficienti in spazio portano immediatamente ad algoritmi efficienti in tempo. Non è detto il contrario: la domanda _"esiste un problema in P che non sta il L?"_ ancora oggi non ha una risposta, è un problema aperto;
- *in pratica*, il grado del polinomio ottenuto da algoritmi efficienti in spazio è molto alto, e solitamente gli algoritmi efficienti in tempo vengono progettati separatamente.

== Classe EXPTIME

Definiamo ora la classe $ exptime = union.big_(k gt.eq 0) dtime(2^n^k) $ dei problemi con complessità temporale *esponenziale*. Ovviamente vale $ P subset.eq exptime, $ perché ogni polinomio è "_maggiorabile_" da un esponenziale. Per diagonalizzazione si è dimostrato in realtà che $ P subset exptime $ sfruttando una *NDTM* (_Non-Deterministic Turing Machine_) con timeout.

== La "zona grigia"

Chiamiamo *zona grigia* quella _nuvola_ di problemi di decisione importanti e con molte applicazioni per i quali non si conoscono ancora algoritmi efficienti in tempo, _ma_ per i quali nessuno ha mai dimostrato che tali algoritmi non possano esistere. Infatti, dato un problema $Pi$, se mi viene detto che ad oggi non esiste un algoritmo efficiente per la sua soluzione, questo non implica che allora lo sia veramente: è molto difficile come dimostrazione.

I problemi di decisione in questa zona hanno una particolarità: sono *efficientemente verificabili*. Data un'istanza particolare, è facile capire se per quel problema e quell'istanza bisogna rispondere #text(green)[SI] o #text(red)[NO].

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
