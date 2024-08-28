#import "../alias.typ": *

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


= Cardinalità

== Isomorfismi

Due insiemi $A$ e $B$ sono *isomorfi* (_equinumerosi_) se esiste una biiezione tra essi. Formalmente scriviamo: $ A tilde B. $

Detto $cal(U)$ l'insieme di tutti gli insiemi, la relazione $tilde$ è sottoinsieme di $cal(U)^2$.

Dimostriamo che $tilde$ è una relazione di equivalenza:
- *riflessività*: $A tilde A$, usiamo come biiezione la funzione identità $i_A$;
- *simmetria*: $A tilde B arrow.long.double B tilde A$, usiamo come biiezione la funzione inversa;
- *transitività*: $A tilde B and B tilde C arrow.long.double A tilde C$, usiamo come biiezione la composizione della funzione usata per $A tilde B$ con la funzione usata per $B tilde C$.

Dato che $tilde$ è una relazione di equivalenza, ci permette di partizionare l'insieme $cal(U)$. La partizione che ne risulta è formata da classi di equivalenza che contengono insiemi isomorfi, ossia con la stessa cardinalità.

Possiamo, quindi, definire la *cardinalità* come l'insieme quoziente di $cal(U)$ rispetto alla relazione $tilde$.

Questo approccio permette di confrontare tra loro la cardinalità di insiemi infiniti, dato che basta trovare una funzione biettiva tra i due insiemi per poter affermare che siano isomorfi.

== Cardinalità finita

La prima classe di cardinalità che vediamo è quella delle *cardinalità finite*. 

Definiamo la seguente famiglia di insiemi: $ J_n = cases(emptyset & text(" se ") n = 0, {1,...,n} & text(" se ") n > 0) quad . $

Diremo che un insieme $A$ ha cardinalità finita se e solo se $A tilde J_n$ per qualche $n in NN$. In tal caso possiamo scrivere $|A| = n$.

La classe di equivalenza $[J_n]_tilde$ identifica tutti gli insiemi di $cal(U)$ contenenti $n$ elementi.

== Cardinalità infinita

L'altra classe di cardinalità è quella delle *cardinalità infinite*, ovvero gli insiemi non in relazione con $J_n$. Questi insiemi sono divisibili in:
- insiemi *numerabili*;
- insiemi *non numerabili*.

Analizziamo le due tipologie separatamente.

=== Insiemi numerabili

Un insieme $A$ è numerabile se e solo se $A tilde NN$, ovvero $A in [NN]_tilde$.

Gli insiemi numerabili vengono detti anche "*listabili*", in quanto è possibile elencare _tutti_ gli elementi dell'insieme $A$ tramite una regola, la funzione $f$ biettiva tra $NN$ e $A$. Grazie alla funzione $f$, è possibile elencare gli elementi di $A$ formando l'insieme: $ A = {f(0), space f(1), space dots}. $ Questo insieme è esaustivo, dato che elenca ogni elemento dell'insieme $A$ senza perderne nessuno.

Tra gli insiemi numerabili più famosi troviamo:
- numeri pari $PP$ e numeri dispari $DD$;
- numeri interi $ZZ$, generati con la biiezione $f(n) = (-1)^n (frac(n + (n mod 2), 2))$;
- numeri razionali $QQ$.

Gli insiemi numerabili hanno cardinalità $aleph_0$ (si legge _"aleph zero"_).

=== Insiemi non numerabili

Gli *insiemi non numerabili* sono insiemi a cardinalità infinita ma che non sono listabili come gli insiemi numerabili: sono "più fitti" di $NN$. Questo significa che ogni lista generata mancherebbe di qualche elemento e, quindi, non sarebbe esaustiva di tutti gli elementi dell'insieme.

Il più famoso insieme non numerabile è l'insieme dei numeri reali $RR$.

#theorem(numbering: none)[
  L'insieme $RR$ non è numerabile ($RR tilde.not NN$).
]

#proof[
  \ Suddividiamo la dimostrazione in tre punti:
  + dimostriamo che $RR tilde (0,1)$;
  + dimostriamo che $NN tilde.not (0,1)$;
  + dimostriamo che $RR tilde.not NN$.

  [1] Partiamo con il dimostrare che $RR tilde (0,1)$: serve trovare una biiezione tra $RR$ e $(0,1)$. Usiamo una rappresentazione grafica, costruita in questo modo:
  - disegnare la circonferenza di raggio $1/2$ centrata in $1/2$;
  - disegnare la perpendicolare al punto da mappare che interseca la circonferenza;
  - disegnare la semiretta passante per il centro $C$ e l'intersezione precedente.

  L'intersezione tra l'asse reale e la retta finale è il punto mappato.

  #v(-36pt)

  #figure(
      image("assets/biiezione.svg", width: 70%)
  )

  #v(12pt)

  In realtà, questo approccio ci permette di dire che $RR$ è isomorfo a qualsiasi segmento di lunghezza maggiore di 0.\
  La stessa biiezione vale anche sull'intervallo chiuso $[0,1]$, utilizzando la "compattificazione" $overset(RR, .) = RR union {plus.minus infinity}$ e mappando $0$ su $-infinity$ e $1$ su $+infinity$.

  [2] Continuiamo dimostrando che $NN tilde.not (0,1)$: serve dimostrare che l'intervallo $(0,1)$ non è listabile, quindi che ogni lista che scrivo manca di almeno un elemento e per farlo proveremo a "costruire" proprio questo elemento.\ Per assurdo, sia $NN tilde (0,1)$. Allora, possiamo listare gli elementi di $(0,1)$ esaustivamente come: $ 0.& space a_(00) space a_(01) space a_(02) space dots \ 0.& space a_(10) space a_(11) space a_(12) space dots \ 0.& space a_(20) space a_(21) space a_(22) space dots \ 0.& space dots quad , $ dove con $a_(i j)$ indichiamo la cifra di posto $j$ dell'$i$-esimo elemento della lista.

  Costruiamo il numero $c = 0.c_0 c_1 c_2 dots$ tale che $ c_i = cases(2 quad & "se" a_(i i) eq.not 2, 3 & "se" a_(i i) = 2) quad . $
  In altre parole, questo numero viene costruito "guardando" le cifre sulla diagonale principale.

  Questo numero appartiene a $(0,1)$, ma non appare nella lista scritta sopra: ogni cifra $c_i$ del numero costruito differisce per almeno una posizione (quella sulla diagonale principale) da qualunque numero nella lista. Questo è assurdo, visto che avevamo assunto $(0,1)$ numerabile $arrow.long.double NN tilde.not (0,1)$.

  [3] Terminiamo dimostrando che $RR tilde.not NN$ per transitività.
  
  Più in generale, non si riesce a listare nessun segmento di lunghezza maggiore di 0.
]

Questo tipo di dimostrazione (in particolare il punto [2]) è detta *dimostrazione per diagonalizzazione*.

L'insieme $RR$ viene detto *insieme continuo* e tutti gli insiemi isomorfi a $RR$ si dicono a loro volta continui. I più famosi insiemi continui sono:
- $RR$: insieme dei numeri reali;
- $CC$: insieme dei numeri complessi;
- $TT subset II$: insieme dei numeri trascendenti.

Vediamo due insiemi continui che saranno importanti successivamente.

=== Insieme delle parti

Il primo insieme che vediamo è l'*insieme delle parti* di $NN$, detto anche _power set_, ed è così definito: $ P(NN) = 2^NN = {S bar.v S "è sottoinsieme di" NN}. $

#theorem(numbering: none)[
  $P(NN) tilde.not NN$.
]

#proof[
  \ Dimostriamo questo teorema tramite diagonalizzazione.
  
  Il *vettore caratteristico* di un sottoinsieme è un vettore che nella posizione $p_i$ ha $1$ se $i in A$, altrimenti ha $0$.

  Rappresentiamo il sottoinsieme $A subset.eq NN$ sfruttando il suo vettore caratteristico: $ NN&: 0 space 1 space 2 space 3 space 4 space 5 space 6 space dots \ A&: 0 space 1 space 1 space 0 space 1 space 1 space 0 space dots quad . $
  
  Per assurdo, sia $P(NN)$ numerabile. Vista questa proprietà, possiamo listare tutti i vettori caratteristici che appartengono a $P(NN)$ come: $ b_0 &= b_(00) space b_(01) space b_(02) space dots \ b_1 &= b_(10) space b_(11) space b_(12) space dots \ b_2 &= b_(20) space b_(21) space b_(22) space dots quad . $

  Vogliamo costruire un vettore che appartenga a $P(NN)$, ma non è presente nella lista precedente. Definiamo il seguente: $ c = overline(b_(00)) space overline(b_(11)) space overline(b_(22)) dots $ che contiene nella posizione $c_i$ il complemento di $b_(i i)$.

  Questo vettore appartiene a $P(NN)$ (perché rappresenta sicuramente un suo sottoinsieme), ma non è presente nella lista precedente perché è diverso da ogni elemento in almeno una cifra, quella sulla diagonale principale.

  Questo è assurdo perché abbiamo assunto che $P(NN)$ fosse numerabile, quindi $P(NN) tilde.not NN$.
]

Visto questo teorema possiamo concludere che: $ P(NN) tilde [0,1] tilde overset(RR, .). $

=== Insieme delle funzioni

Il secondo insieme che vediamo è l'*insieme delle funzioni* da $NN$ in $NN$ così definito: $ NN_bot^NN = {f: NN arrow.long NN}. $

#theorem(numbering: none)[
  $NN_bot^NN tilde.not NN$.
]

#proof[
  \ Anche in questo caso useremo la diagonalizzazione.
  
  Per assurdo, assumiamo $NN_bot^NN$ numerabile. Possiamo, quindi, listare $NN_bot^NN$ come ${f_0, f_1, f_2, dots}$.

  #align(center)[
    #table(
      columns: (10%, 15%, 15%, 15%, 15%, 15%, 15%),
      inset: 10pt,
      align: horizon,

      [], [$0$], [$1$], [$2$], [$3$], [$dots$], [$NN$],

      [$f_0$], [$f_0 (0)$], [$f_0 (1)$], [$f_0 (2)$], [$f_0 (3)$], [$dots$], [$dots$],
      [$f_1$], [$f_1 (0)$], [$f_1 (1)$], [$f_1 (2)$], [$f_1 (3)$], [$dots$], [$dots$],
      [$f_2$], [$f_2 (0)$], [$f_2 (1)$], [$f_2 (2)$], [$f_2 (3)$], [$dots$], [$dots$],
      [$dots$], [$dots$], [$dots$], [$dots$], [$dots$], [$dots$], [$dots$], 
    )
  ]

  Costruiamo una funzione $phi: NN arrow.long NN_bot$ per dimostrare l'assurdo. Una prima versione potrebbe essere la funzione $phi(n) = f_n (n) + 1$, per _disallineare_ la diagonale, ma questo non va bene: se $f_n (n) = bot$ non sappiamo dare un valore a $phi(n) = bot + 1$.

  Definiamo quindi la funzione $ phi(n) = cases(1 & "se" f_n (n) = bot, f_n (n) + 1 quad & "se" f_n (n) arrow.b) quad . $

  Questa funzione è una funzione che appartiene a $NN_bot^NN$, ma non è presente nella lista precedente. Infatti, $forall k in NN$ otteniamo $ phi(k) = cases(1 eq.not f_k (k) = bot & "se" f_k (k) = bot, f_k (k) + 1 eq.not f_k (k) quad & "se" f_k (k) arrow.b) quad . $
  
  Questo è assurdo, perché abbiamo assunto $P(NN)$ numerabile, quindi $P(NN) tilde.not NN$.
]
