// Setup

#import "@preview/ouset:0.1.1": overset

#import "@preview/algo:0.3.3": code

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

= Lezione 23

== Algoritmi non deterministici

Abbiamo visto come esistano problemi molto utili di cui non si conoscono ancora algoritmi deterministici efficienti in tempo.

Tuttavia, è possibile costruire degli *algoritmi non deterministici* che li risolvano, sfruttando il fatto che possono valutare velocemente la funzione obiettivo del problema.

=== Dinamica dell'algoritmo

In generale, in un algoritmo non deterministico, la computazione non è univoca, ma si scinde in tante computazioni, una per ogni struttura generata.

Sono formati da due fasi principali:
- *fase congetturale*, in cui viene generata "magicamente" una struttura/un assegnamento/una configurazione/una congettura che aiuta a dare una risposta "sì"/"no";
- *fase di verifica*, in cui usiamo la struttura prodotta precedentemente per decidere se vale la proprietà che caratterizza il problema di decisione.

// gigi: immagine la mettiamo?

Le varie computazioni delle fasi di verifica sono tutte deterministiche. È la fase congetturale ad essere non deterministica e in particolare lo è nella creazione della struttura "magica".

=== Soluzione algoritmi di decisione

Dato un problema $Pi$, un'istanza $x in D$ e una proprietà $p(x)$, un algoritmo non deterministico risolve $Pi$ sse:
+ su ogni $x$ a risposta #text(green)[positiva] (quindi $forall x : p(x) = 1$), esiste *almeno una computazione* $k$ che accetta la coppia $(x, s_k)$.
+ su ogni $x$ a risposta #text(red)[negativa] (quindi $forall x : p(x) = 0$), non esiste *alcuna computazione* che accetti la coppia $(x, s_k)$ per qualche $s_k$. Tutte le computazioni o rifiutano o vanno in loop.

==== _CNF-SAT_

Vediamo un algoritmo non deterministico per la soluzione di _CNF-SAT_: 

// gigi: da rivedere come tutti i programmi
$ P equiv & "input"(phi(x_1, dots, x_n)); \ & "genera ass." x in {0,1}^n; \ & "if" (phi(x_1, dots, x_n) == 1) \ & quad "return" 1; \ & "return 0"; $

Ammettendo un modello di calcolo come quello descritto, questo è a tutti gli effetti un algoritmo non deterministico, formato da fase congetturale e fase di verifica.

==== Circuito hamiltoniano

Vediamo ora un algoritmo non deterministico per trovare, se esiste, un circuito hamiltoniano in un grafo $G$.

// gigi: da rivedere come tutti i programmi
$ P equiv & "input"(G=(V,E)); \ & "genera perm." pi(v_1, dots, v_n); \ & "if" (pi(v_1, dots, v_n) "è un circuito in" G) \ & quad "return" 1; \ & "return 0"; $

Si vede chiaramente come sia simile a quello precedente, mostrando che la struttura di questi algoritmi e pressoché la stessa.

=== Tempo di calcolo

Dato che è cambiato il modello di calcolo, dobbiamo rivedere la definizione di tempo di calcolo.

Consideriamo il tempo di calcolo $T(x)$, per un'istanza $x$ a risposta positiva (negativa), come il miglior tempo di calcolo delle fasi di verifica a risposta positiva (negativa). Per convenzione, la fase congetturale non impiega tempo.\
Da ricordare che questo è un modello teorico, infatti nella realtà pagherò tempo anche per la generazione delle strutture che servono nelle verifiche.

_Come formalizzare questo tipo di algoritmi?_

== Macchina di Turing Non Deterministica

Consideriamo una DTM $M$ come l'abbiamo già descritta e apportiamo delle modifiche:
- allunghiamo il nastro, in modo che sia infinito anche verso sinistra;
- aggiungiamo un _Modulo Congetturale_, che scriva sulla parte sinistra del nastro la struttura generata;

// gigi: immagine NDTM?

Quindi, il nastro conterrà sia l'input $x$ del problema, sia la struttura $gamma$ generata dalla fase congetturale e la fase di verifica non lavorerà più solo su $x$, ma utilizzerà la coppia $(gamma, x)$ e $x in Sigma^*$:
- viene accettato $arrow.double.long.l.r exists gamma in Gamma^* : (gamma, x)$ viene deterministicamente accettata;
- non viene accettato altrimenti.

Il linguaggio accettato da $M$ è $ L_M = {x in Sigma^* : M "accetta" x}. $

// gigi: mi piacerebbe trovare un layout per tutte le definizioni e apportarle a tutte quelle che abbiamo fatto. Per ora lascio così solo per far capire.
// gigi: forse qui c'è qualcosa "https://github.com/sahasatvik/typst-theorems"
*Definizione*: Un linguaggio $L subset.eq Sigma^*$ è accettato da un algoritmo non deterministico sse esiste una NDTM $M = (Q, Sigma, Gamma, delta, q_0, F)$ tale che $L = L_M$.

Ricordiamo che, dato un problema $(Pi, x in D, p(x))$, il linguaggio riconosciuto dal problema è $ L_Pi = {cod(x) : x in D and p(x)} $ dove $cod : D arrow Sigma^*$ e la funzione di codifica delle istanze del problema.

*Definizione*: Un algoritmo non deterministico per la soluzione di $Pi$ è una NDTM $M$ tale che $ L_Pi = L_M. $

Ovviamente, mediante opportuna codifica, possiamo definire NDTM che accettano insiemi o funzioni.

=== Complessità in tempo

Come abbiamo accennato precedentemente, la complessità in tempo di un algoritmo non deterministico corrisponde alla miglior complessità in tempo per quell'istanza. Allo stesso modo, possiamo definire la complessità in tempo per le NDTM.

*Definizione*: Una NDTM $M = (Q, Sigma, Gamma, delta, q_0, F)$ ha *complessità in tempo* $t : NN arrow NN$ sse per ogni input $x in L_M$ con $|x| = n$ esiste almeno una computazione accettante di $M$ che impiega $t(n)$ passi.

Ne consegue anche la prossima definizione.

*Definizione*: Un linguaggio è accettato con *complessità in tempo non deterministico $t(n)$* sse esiste una NDTM $M$ con complessità in tempo $t(n)$ che lo accetta.

In questo modo abbiamo mappato tutti i concetti chiave visti nelle macchine di Turing deterministiche anche per il non determinismo.

== Classi di complessità non deterministiche

È possibile definire delle classi per i linguaggi accettati allo stesso modo di come avevamo fatto per le DTM. Chiamiamo $ ntime(f(n)) $ come l'insieme dei linguaggi accettati con complessità non deterministica $O(f(n))$.

// gigi: non mi piace molto
Caratterizziamo il concetto di "efficienza" anche per il non determinismo.\
Efficiente risolubilità: $ P = union.big_(k gt.eq 0) dtime(n^k). $
Efficiente verificabilità: $ "NP" = union.big_(k gt.eq 0) ntime(n^k), $ che corrisponde all'insieme dei problemi di decisione che ammettono algoritmi non deterministici polinomiali.

*The Millennium Prize Problem*: _Che relazione c'è tra le classi P e NP?_ $arrow.long$ È una questione ancora aperta, la quale farebbe guadagnare un milione di dollari a colui che troverà una risposta.

=== $P subset.eq NP$

Possiamo solo dimostrare una banale relazione.

#theorem(numbering:none)[
  $P subset.eq NP$
]

#proof[
  È facile dimostrare che $dtime(f(n)) subset.eq ntime(f(n))$.

  Dato $L in dtime(f(n))$, esiste una DTM $M$ che lo riconosce in $t(n) = O(f(n)). quad (*)$\
  Chiaramente $M$ può essere vista come una NDTM che ignora il modulo congetturale. La NDTM così ottenuta ripropone la stessa computazione di $M$ su ogni congettura generata inutilmente. È chiaro che questa NDTM accetta $L$ in tempo $t(n) = O(f(n)) arrow.double L in ntime(f(n))$.\
  Quindi vale: $ P = union.big_(k gt.eq 0) dtime(n^k) overset(subset.eq, (*)) union.big_(k gt.eq 0) ntime(n^k) = NP. $
]

=== $NP subset.eq P$

_Cosa possiamo dire sulla relazione inversa?_\
È chiaro che il punto cruciale del Millennium Problem è proprio la relazione $NP subset.eq P$, che in realtà si può tradurre in $P = NP$ vista la relazione appena dimostrata.

Detto in altre parole, ci chiediamo se da un algoritmo non deterministico efficiente è possibile ottenere un algoritmo _reale_ efficiente.

Similmente a quanto fatto nella dimostrazione di $P subset.eq NP$, proviamo ad analizzare questo problema $ ntime(f(n)) subset.eq dtime(?), $ che quantifica quanto costa togliere il fattore di non determinismo (che è un concetto non naturale) della fase congetturale.

Supponiamo di avere $L in ntime(f(n))$. Questo implica che esiste una NDTM $M$ tale che $M$ accetta $L$ con $t(n) = O(f(n))$. _Come possiamo simulare la dinamica di $M$ con una DTM $overset(M, tilde)$?_

Il funzionamento di $overset(M, tilde)$ può essere qualcosa di questo tipo:
+ prendiamo in input $x in Sigma^*$, con $|x| = n$;
+ genera tutte le strutture $gamma in Gamma^*$ delle fasi di verifica;
+ per ognuna di esse, calcola *deterministicamente* se $(gamma, x)$ viene accettata con $M$;
+ se in una delle computazioni al punto 3 la risposta è positiva, allora accetta $x$, altrimenti $overset(M, tilde)$ rifiuta (la gestione dei loop può essere fatta tramite la tecnica del count-down).

Il problema qui è che di stringhe $gamma in Gamma^*$ ne esistono infinite!

_Ma ci servono proprio tutte?_\
Rivediamo lo pseudo-codice dell'algoritmo che stiamo progettando:

/// gigi: da rivedere come tutti i programmi
$ "DTM" overset(M, tilde) equiv & "input"(x) \ & "for each" gamma in Gamma^*: \ & quad "if"(M "accetta" (gamma, x) "in" t(n) "passi") \ & quad quad "return" 1; \ & "return" 0; $

Per evitare di considerare tutte le stringhe $gamma$, possiamo considerare solo quelle che non sono più lunghe di $t(n)$, perché altrimenti non potrei finire la computazione in $t(n)$ passi.

L'algoritmo diventa:
// gigi: da rivedere come tutti i programmi
$ "DTM" overset(M, tilde) equiv & "input"(x) \ & "for each" (gamma in Gamma^* and |gamma| = O(f(n))): \ & quad "if"(M "accetta" (gamma, x) "in" t(n) "passi") \ & quad quad "return" 1; \ & "return" 0; $

Studiamo quanto tempo impiega $ t(n) = |Gamma|^(O(f(n))) dot.op O(f(n)) = O(f(n) dot.op 2^(O(f(n)))), $
di conseguenza avremo che $ ntime(f(n)) subset.eq dtime(f(n) dot.op 2^(O(f(n)))). $

Come ci si poteva aspettare, togliere il non determinismo purtroppo costa parecchio, tanto da rendere l'algoritmo esponenziale e quindi inefficiente.

$ NP subset.eq dtime(2^(n^(O(1)))) = exptime. $

L'unica cosa che attualmente sappiamo dire è che tutti i problemi in $NP$ hanno sicuramente algoritmi di soluzione con tempo esponenziale, ma ancora non possiamo escludere che $NP subset.eq P$.

*Attenzione*: $NP$ non sta per "Non Polinomiale" e quindi esponenziale. $NP$ sta per polinomiale in un architettura non deterministica. Dire che $NP$ contiene problemi con algoritmi di soluzione esponenziale è #text(red)[FALSO]. Tali problemi potrebbero anche avere soluzioni efficienti (anche se nessuno lo crede).