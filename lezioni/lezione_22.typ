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

= Lezione 22

== Tempo vs spazio

Abbiamo visto che un limite in tempo implica, in qualche modo, un limite in spazio. _Vale anche il contrario?_

_È possibile dimostrare che $dspace(f(n)) subset.eq dtime(f(n))$?_\
Avendo un numero di celle prestabilito, è possibile iterare il loro utilizzo (anche all'infinito, entrando in un loop), di conseguenza limitare lo spazio non implica necessariamente una limitazione del tempo.

Notiamo che, in una DTM $M$, un loop si verifica quando visitiamo una configurazione già visitata in passato. Sfruttando questo fatto, è possibile trovare una limitazione al tempo, trovando dopo quanto tempo vengono visitate tutte le configurazioni possibili.

#theorem(numbering: none)[
  Tutti i linguaggi accettati in spazio $f(n)$ vengono accettati in tempo $n dot.op alpha^(O(f(n)))$. Formalmente:
  $ dspace(f(n)) subset.eq dtime(n dot.op alpha^(O(f(n)))) $
]

#proof[
  \ Dato $L in dspace(f(n))$ e una DTM $M$, esistono una serie di configurazioni per $M$ tali che $ C_0 arrow.long^delta C_1 arrow.long^delta dots.c arrow.long^delta C_m, $ in cui $C_m$ è uno stato accettanto per $L$.

  Sappiamo che $dtime$ è calcolabile dal numero di volte che viene utilizzata la funzione transizione $delta$.

  Date $C_i$ e $C_j$ con $i eq.not j$, vale $C_i eq.not C_j$, altrimenti significa che si è entrati in un loop. Di conseguenza, calcolando la cardinalità dell'insieme contenente tutte le configurazioni possibili, troviamo anche un upper bound per la risorsa tempo.

  Ricordiamo che una configurazione è una quadrupla $ angle.l q,i,j,w angle.r $ con $q$ stato della macchina, $i,j$ posizioni delle due testine, stato e $w$ valore sul nastro di lavoro.\
  Analizziamo quanti valori possono assumere ognuno di questi elementi:
  - $q arrow.long |Q|$, è una costante;
  - $i arrow.long n+2$, contando i due delimitatori;
  - $j arrow.long O(f(n))$, che possiamo scrivere come $alpha f(n)$;
  - $w arrow.long w in Gamma^(O(f(n)))$, quindi ho $|Gamma|^(O(f(n)))$, scrivibile come $|Gamma|^(alpha f(n))$.

  Moltiplicando questi valori, troviamo il seguente upper bound: $ |C| & lt.eq O(1) dot.op (n+2) dot.op alpha f(n) dot.op |Gamma|^(alpha f(n)) \ & lt.eq O(1) dot.op (n+2) dot.op |Gamma|^(alpha f(n)) dot.op |Gamma|^(alpha f(n)) \ & = O(1) dot.op (n+2) dot.op |Gamma|^(2alpha f(n)) \ & = O(1) dot.op (n+2) dot.op 2^(2alpha f(n) dot.op log |Gamma|) \ & = O(n dot.op 2^(O(f(n)))) $

  Quindi $M$ sa se accettare o meno $x in Sigma^*$ in al massimo $O(n dot.op 2^(O(f(n))))$ passi.

  Detto ciò, data una DTM $M$ che accetta $L$ con $s(n) lt.eq alpha dot.op f(n)$, possiamo costruire una DTM $M'$ che su input $x in Sigma^*$ con $|x| = n$ procede così:
  + scrive in unario su un nastro il $"time-out" tilde O(n dot.op 2^(O(f(n))))$;
  + simula $M$ e ad ogni mossa cancella un simbolo del nastro $"time-out"$;
  + se $M$ accetta o rifiuta prima della fine del $"time-out"$, allora $M'$ accetta o rifiuta;
  + se allo scadere del $"time-out" M$ non ha ancora scelto, $M'$ rifiuta perché sa di essere in un loop.
  In questo modo, $M'$ accetta $L$ in tempo $ t(n) = O(n dot.op 2^(O(f(n)))) \ arrow.double.b \ dspace(f(n)) subset.eq dtime(n dot.op 2^(O(f(n)))) $
]

Come per il tempo, il teorema dimostrate vale ovviamente anche per gli insiemi $fspace$ e $ftime$.

#theorem(numbering:none)[
  Tutti le funzioni calcolate in spazio $f(n)$ vengono calcolate in tempo $n dot.op alpha^(O(f(n)))$. Formalmente:
  $ fspace(f(n)) subset.eq ftime(n dot.op alpha^(O(f(n)))) $
]

=== Relazioni L e P

Ottenuti questi risultati, vogliamo studiare le relazioni tra efficienza in termini di spazio ($L$) e l'efficienza in termini di tempo ($P$).

#theorem(numbering:none)[
  Vale la seguente relazione per efficienza in spazio e efficienza in tempo: $ L subset.eq P "e" fl subset.eq fp. $
]

#proof[
  $ L = dspace(log n) subset.eq dtime(n dot.op 2^(O(log n))) = dtime(n^2) subset.eq union.big_(k gt.eq 0) dtime(n^k) = P. $

  Allo stesso modo è ottenibile anche l'equazione per $fl$ e $fp$.
]

Grazie a questo teorema sappiamo che, in teoria, algoritmi efficienti in spazio portano immediatamente ad algoritmi efficienti in tempo. Non è detto il contrario.\
Nella pratica, il grado del polinomio ottenuto da algoritmi efficienti in spazio è molto alto (infatti solitamente gli algoritmi efficienti in tempo vengono progettati separatamente).

Ora ci chiediamo se l'inclusione di $L$ in $P$ sia propria o impropira. _Esiste un problema in $P$ che non sta in $L$?_\
Questo è un problema ancora aperto.

Definiamo $ exptime = union.big_(k gt.eq 0) dtime(2^n^k) $ come la classe dei problemi con complessità temporale esponenziale.

Ovviamente $ P subset.eq exptime, $perché ogni polinomio è maggiorabile da un esponenziale. Per diagonalizzazione, si è dimostrato anche che $ P subset exptime, $ sfruttando una NDTM (Non Deterministic Turing Machine) con timeout.

== La "Zona Grigia"

Chiamiamo *Zona Grigia* quella nuvola di problemi di decisione importanti e con molte applicazioni per i quali non si conoscono ancora algoritmi efficienti in tempo, _ma_ per i quali nessuno ha mai dimostrato che tali algoritmi non possano esistere.

I problemi di decisione in questa zona hanno una particolarità: sono *efficientemente verificabili*. Data un'istanza particolare, è facile capire se per quel problema e quell'istanza bisogna rispondere #text(green)[SI] o #text(red)[NO].

=== _CNF-SAT_

Il problema _CNF-SAT_ ha come obiettivo capire se è possibile trovare un assegnamento delle variabili booleane che soddisfi un predicato logico in forma normale congiunta (formule $phi(x_1, dots, x_n)$ formata da congiunzioni $C_1 and dots and C_k$).

Formalmente, data una CNF $phi(x_1, dots, x_n)$, vogliamo sapere $ exists wstato(x) in {0,1}^n : phi(wstato(x)) = 1? $

// gigi: da sistemare, con tutti gli altri programmi delle dispense
Un possibile algoritmo di risoluzione è quello esaustivo: $ P equiv & "for" wstato(x) in {0,1}^n "do" \ & quad "if" phi(wstato(x)) = 1 \ & quad quad "return" 1 \ & "return" 0 $

Notiamo come le possibili permutazioni con ripetizione sono $2^n$, mentre la verifica della soddisfacibilità è fattibile in tempo polinomiale $n^k$.\
Di conseguenza, questo algoritmo risulta inefficiente in quanto esplorare tutto l'albero dei possibili assegnamenti richiederebbe tempo esponenziale.

=== Circuiti Hamiltoniani

Dato $G = (V,E)$ un grafo non diretto, vogliamo sapere se $G$ contiene un circuito hamiltoniano o meno.

Ricordiamo un paio di concetti sui grafi:
- *cammino*: sequenza di vertici $v_1, dots, v_k$ tali che $forall 1 lt.eq i lt t$ vale $(v_i, v_t) in E$;
- *circuito*: cammino $v_1, dots, v_t$ tale che $v_1 = v_t$, quindi che parte e termina in uno stesso vertici.
- *circuito Hamiltoniano*: circuito in cui tutti i vertici di $G$ vengono visitati una e una sola volta.

// gigi: da sistemare
Un algoritmo per questo problema è il seguente: $ P equiv & "for" (V_i_1, dots, V_i_n, V_i_1) in "Perm"(V) "do" \ & quad "if IS_HC" (V_i_1, dots, V_i_n, V_i_1) = 1 \ & quad quad "return" 1 \ & "return" 0 $ in cui sostanzialmente visitiamo tutte le permutazioni possibili di vertici che iniziano e finiscono con lo stesso e verifichiamo (efficientemente) se è un circuito hamiltoniano o meno.

Calcoliamo la complessità temporale di questo algoritmo:
- il numero di permutazioni (quindi il numero di volte che viene eseguito il ciclo) sono $n!$;
- il controllo sulla permutazione può essere implementato efficientemente, in tempo meno che esponenziale.\
Quindi, $t(n) = O()$

=== Circuiti Euleriani

Dato $G = (V,E)$ un grafo non diretto, vogliamo sapere se $G$ contiene un circuito euleriano o meno.

Ricordiamo che un circuito euleriano è un circuito in cui tutti i lati di $G$ vengono visitati una e una sola volta.

Potrebbe sembrare simile al problema precedente, ma non lo è!
#theorem(numbering:none, name: "Eulero 1736")[
  $G$ contiene un circuito euleriano sse ogni vertice in $G$ ha grado pari.
]

Grazie a questo teorema è possibile risolvere il problema in tempo ovviamente efficiente (lineare).\
Purtroppo non esiste un teorema simile per i circuiti hamiltoniani.
