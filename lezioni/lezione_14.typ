// Setup

#import "@preview/algo:0.3.3": code

#import "@preview/lemmify:0.1.5": *

#let (
  theorem, lemma, corollary,
  remark, proposition, example,
  proof, rules: thm-rules
) = default-theorems("thm-group", lang: "it")

#show: thm-rules

#show thm-selector("thm-group", subgroup: "proof"): it => block(
  it,
  stroke: green + 1pt,
  inset: 1em,
  breakable: true
)

#import "alias.typ": *

// Appunti

= Lezione 14

== Teorema di Rogers

Un risultato più potente del teorema precedente è dato dal *teorema di Rogers*.

#theorem(
  name: "Teorema di isomorfismo tra SPA",
  numbering: none
)[
  Dati due SPA ${phi_i}$ e ${Psi_i}$, esiste $t : NN arrow.long NN$ tale che:
  + $t in cal(T)$;
  + $forall i in NN quad phi_i = Psi_(t(i))$;
  + $t$ è invertibile, quindi $t^(-1)$ può essere visto come un decompilatore.
]

I primi due punti sono uguali al teorema precedente e ci dicono che il compilatore $t$ è programmabile e completo (punto 1) e corretto (punto 2).

== Introduzione

Vogliamo trovare dei risultati che abbiano la stessa portata dei precedenti, quindi che valgano per _tutti i sistemi di programmazione accettabili_.

== Esistenza di certi programmi negli SPA

Ci poniamo due quesiti riguardo gli SPA:
+ *programmi auto-replicanti*: dato un SPA, _esiste all'interno di esso un programma che stampa se stesso (il proprio listato)?_

  Ovviamente, questa operazione deve essere fatta senza aprire il file che contiene il listato.
  
  Questi programmi sono detti *Quine*, in onore del filosofo e logico Willard Quine (1908-2000) che li descrisse per la prima volta.

  La risposta è positiva per molti linguaggi: ad esempio, in Python il programma
  
  #align(center)[
    #code(
      fill: luma(240),
      indent-guides: 0.2pt + red,
      inset: 10pt,
      line-numbers: false,
      radius: 4pt,
      row-gutter: 6pt,
      stroke: 1pt + black
    )[
      ```python
        a='a=%r;print(a%%a)';print(a%a)
      ```
    ]
  ]

  stampa esattamente il proprio listato. Noi, però, vogliamo rispondere tramite una dimostrazione rigorosa, quindi ambientiamo la domanda nel sistema di programmazione RAM, che diventa $ exists j in NN bar.v phi_j (x) = j "per ogni input" x in NN ? $
+ *compilatori completamente errati*: dati due SPA ${phi_i}$ e ${Psi_j}$, _esiste un compilatore completamente errato?_ 
  
  Un compilatore dal primo SPA al secondo SPA è una funzione $t: NN arrow NN$ tale che:
  - $t in cal(T)$ programmabile e totale;
  - $forall i in NN quad phi_i = Psi_t(i)$ corretta.
  
  Invece, un _compilatore completamente errato_ è una funzione $t: NN arrow NN$ tale che:
  - $t in cal(T)$ programmabile e totale;
  - $forall i in NN quad phi_i eq.not Psi_t(i)$ errata.

== Teorema di ricorsione

=== Definizione

Il *teorema di ricorsione* ci fornisce una risposta precisa a entrambi i quesiti che ci siamo posti.

#theorem(numbering: none)[
  Dato un SPA ${phi_i}$, per ogni $t : NN arrow.long NN$ ricorsiva totale vale $ exists n in NN bar.v phi_n = phi_t(n). $
]<thm>

Diamo una chiave di lettura a questo teorema:
- consideriamo $t$ come un programma che prende in input un programma $n$ e lo cambia nel programma $t(n)$, anche nella maniera più assurda;
- il teorema dice che qualsiasi sia la natura di $t$, esisterà sempre almeno un programma il cui significato *non sarà stravolto* da $t$.

Prima di vedere la sua dimostrazione, torniamo a considerare le due domande che ci siamo posti poco fa e vediamo la risposta usando proprio il teorema di ricorsione.

=== Primo quesito: Quine

Consideriamo il programma RAM $ P equiv & inc(R_0) \ & inc(R_0) \ & dots \ & inc(R_0) $ che ripete l'istruzione di incremento di $R_0$ un numero $j$ di volte. La semantica di questo programma è esattamente $j$: infatti, dopo la sua esecuzione avremo $j$ nel registro di output $R_0$.

Calcoliamo la codifica di $P$ come $ cod(P) = < underbracket(0 \, dots \, 0, j"-volte") > = Z(j) in cal(T). $ 

Questa funzione è ricorsiva totale in quanto programmabile e totale, visto che sfrutta solo la funzione di Cantor. Vale quindi $ phi_Z(j) (x) = j. $

Per il teorema di ricorsione $ exists j in NN bar.v phi_j (x) = phi_Z(j) (x) = j, $ quindi effettivamente esiste un programma $j$ la cui semantica è proprio quella di stampare sé stesso.

La risposta alla prima domanda è _SI_ per RAM, ma lo è in generale per tutti gli SPA che ammettono una codifica per i propri programmi.

=== Secondo quesito: compilatori completamente errati

Supponiamo di avere in mano una funzione $t in cal(T)$ che _"maltratta"_ i programmi.

Vediamo la semantica del programma _"maltrattato"_ $t(i)$: $ (*) quad quad Psi_t(i) (x) =^((2)) Psi_u (x, t(i)) =^((1)) phi_e (x,t(i)) =^((3)) phi_(S_1^1 (e,t(i))) (x). $

Chiamiamo $g(i)$ la funzione $S_1^1 (e,t(i))$ che dipende solo da $i$, essendo $e$ un programma fissato. Notiamo come questa funzione sia composizione di funzioni ricorsive totali, ovvero $t(i)$ per ipotesi e $S_1^1$ per definizione, quindi anch'essa è ricorsiva totale.

Per il teorema di ricorsione $ (**) quad quad exists i in NN bar.v phi_i = phi_g(i) . $

Unendo i risultati $(*)$ e $(**)$, otteniamo $ exists i in NN bar.v Psi_t(i) =^((*)) phi_g(i) =^((**)) phi_i quad forall t in cal(T) . $

Di conseguenza, la risposta alla seconda domanda è _NO_.

=== Dimostrazione

#proof[
  \ Siamo in un SPA ${phi_i}$ quindi valgono i tre assiomi di Rogers.
  
  D'ora in avanti, per semplicità, scriveremo $phi_n (x,y)$ al posto di $phi_n (<x,y>)$.

  Dobbiamo esibire, data una funzione $t$, uno specifico valore di $n$.

  Partiamo con il mostrare che $ phi_(phi_i (i)) (x) =^((2)) phi_(phi_u (i,i)) (x) =^((2)) phi_u (x, phi_u (i,i)) arrow.long.squiggly f(x,i) in cal(P). $ Infatti, la funzione $f(x,i)$ è composizione di funzioni ricorsive parziali, quindi anch'essa lo è.

  Continuiamo affermando che $ f(x,i) =^((1)) phi_e (x, i) =^((3)) phi_(S_1^1 (e,i)) (x). $

  Consideriamo ora la funzione $t(S_1^1 (e,i))$: essa è ricorsiva totale in $i$ perché composizione di $t$ e di $S_1^1$ ricorsive totali, quindi $ exists m in NN bar.v phi_m (i) = t(S_1^1 (e,i)). $

  Abbiamo quindi mostrato che $ (A) quad quad phi_(phi_i (i)) (x) = phi_(S_1^1 (e,i)) (x); \ (B) quad quad phi_m (i) = t(S_1^1 (e,i)) . $
  
  Fissiamo $n = S_1^1 (e,m)$ e mostriamo che vale $phi_n = phi_t(n)$, ovvero il teorema di ricorsione.
  
  $ phi_n (x) & =^("def") phi_(S_1^1 (e,m)) (x) =^((A)) phi_(phi_m (m)) (x) . \ phi_t(n) (x) & =^("def") phi_(t(S_1^1 (e,m))) (x) = phi_(phi_m (m)) (x) . $
  
  Ho ottenuto lo stesso risultato, quindi il teorema è verificato.
]

Le conseguenze di questo teorema sono le due proprietà mostrate in precedenza.

== Equazioni su SPA

=== Strategia

La portata del teorema di ricorsione è molto ampia: infatti, ci permette di risolvere *equazioni su SPA* in cui si chiede l'esistenza di certi programmi in SPA.

Ad esempio, dato uno SPA ${phi_i}$ ci chiediamo se $ exists n in NN bar.v phi_n (x) = phi_x (n+phi_(phi_n (0)) (x))? $

La *strategia* da seguire per risolvere questo tipo di richieste è analoga a quella usata per la dimostrazione del teorema di ricorsione e può essere riassunta nei seguenti passaggi:
+ trasforma il membro di destra dell'equazione in una funzione $f(x,n)$;
+ mostra che $f(x,n)$ è ricorsiva parziale e quindi che $f(x,n) = phi_e (x,n)$;
+ l'equazione iniziale diventa $phi_n (x) = phi_e (x,n) = phi_(S_1^1 (e,n)) (x)$;
+ so che $S_1^1 (e,n)$ è una funzione ricorsiva totale;
+ il quesito iniziale è diventato $exists n in NN bar.v phi_n (x) = phi_(S_1^1 (e,n)) (x)?$
+ la risposta è _SI_ per il teorema di ricorsione.

Riprendiamo in mano l'esempio appena fatto.

Cominciamo con il trasformare la parte di destra: $ phi_n (x) & =^((2)) phi_x (n + phi_(phi_u (0,n)) (x)) \ & =^((2)) phi_x (n + phi_u (x, phi_u (0,n))) \ & =^((2)) phi_u (n + phi_u (x, phi_u (0,n)), x) \ & = f(x,n) in cal(P). $

L'ultimo passaggio è vero perché $phi_u (n + phi_u (x, phi_u (0,n)), x)$ compone solamente funzioni ricorsive parziali quali somma e interprete universale. Di conseguenza, esiste un programma $e$ che calcoli la funzione $f(x,n)$.

Continuando, riscriviamo l'equazione come $ phi_n (x) = f(x,n) =^((1)) phi_e (x,n) =^((3)) phi_(S_1^1 (e,n)) (x), $ con $S_1^1 (e,n) in cal(T)$ per l'assioma $3$.

Per il teorema di ricorsione possiamo concludere che $ exists n in NN bar.v phi_n (x) = phi_(S_1^1 (e,n)) (x) = phi_x (n + phi_(phi_u (0,n)) (x)). $

=== Esercizi

// Da fare assieme, lo metto nel README
Dato un spa ${phi_i}, exists n in NN$ tale che:
+ $phi_n (x) = phi_x (n) + phi_(phi_x (n)) (n)$;
+ $phi_n (x) = phi_x (x) + n$;
+ $phi_n (x) = phi_x (<n, phi_x (1)>)$;
+ $phi_n (x) = phi_(phi_x (#cantor_sin (n))) (#cantor_des (n))$;
+ $phi_n (x) = n^x + (phi_x (x))^2$;
+ $phi_n (x) = phi_x (n+2) + (phi_(phi_x (n)) (n+3))^2$.
