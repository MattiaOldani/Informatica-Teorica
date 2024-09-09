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

== Tempo vs spazio

Spesso promuovere l'ottimizzazione di una risorsa va a discapito dell'altra: _essere veloci_ vuol dire (tipicamente) _spendere tanto spazio_ e _occupare poco spazio_ vuol dire (tipicamente) _spendere tanto tempo_.

Viene naturale porsi due domande:
- _i limiti in tempo implicano dei limiti in spazio?_
- _i limiti in spazio implicano dei limiti in tempo?_

Per rispondere confrontiamo le classi $dtime(f(n))$ e $dspace(f(n))$.

#theorem(numbering: none)[
  Tutti i linguaggi accettati in tempo $f(n)$, sono anche accettati in spazio $f(n)$. Formalmente:
  $ dtime(f(n)) subset.eq dspace(f(n)). $
]

#proof[
  \ Se $L in dtime(f(n))$ allora esiste una DTM $M$ che riconosce $L$ in tempo $t(n) = O(f(n))$, quindi su input $x$ di lunghezza $n$ la macchina $M$ compie $O(f(n))$ passi.
  
  In tale computazione, _quante celle del nastro di lavoro posso occupare al massimo?_\
  Ovviamente $O(f(n))$ (una cella ad ogni passo). Quindi, $M$ ha complessità in spazio $s(n) = O(f(n))$, ma allora $L in dspace(f(n))$.
]

#theorem(numbering: none)[
  Tutte le funzioni accettate in tempo $f(n)$, sono anche accettate in spazio $f(n)$. Formalmente:
  $ ftime(f(n)) subset.eq fspace(f(n)). $
]

Notiamo come l'efficienza in tempo non porta immediatamente all'efficienza in spazio.

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
