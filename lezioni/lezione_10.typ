// Setup

#import "@preview/ouset:0.1.1": overset

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

= Lezione 10

== Interprete $mwhile$ di programmi $ram$

Abbiamo visto come scrivere un programma $mwhile$ (un interprete) che prenda in ingresso una coppia $<x,n>$ dove $n$ è un programma codificato in un intero e $x$ è il dato per tale programma.

Ricordiamo che, per comodità, utilizzeremo il Macro-$mwhile$.

Quello che fa l'interprete è ricostruire virtualmente tutto ciò che gli serve per gestire il programma. Nel nostro caso, $I_w$ deve ricostruire l'ambiente di una macchina $ram$. Il problema è che i programmi $ram$ possono utilizzare infiniti registri, mentre i programmi $mwhile$ ne hanno solo $21$. _C'è un modo per trovare un upper bound sul registro di indice più alto che viene utilizzato?_

Se $cod(P)=n$, allora sappiamo che $P$ non utilizzerà mai $R_j, j>n$, perché posso fare al massimo $n$ operazioni che coinvolgono al massimo $n$ registri diversi. Di conseguenza, possiamo restringerci a modellare $R_0, dots, R_n+2$ (arriviamo fino a a $n+2$ solo per avere un paio di registri in più, che potrebbero tornare utili). Ciò ci permette di codificare la memoria utilizzata dal programma $P$ tramite la funzione di Cantor sui registri.

Vediamo, nel dettaglio, l'interno di $I_w (<x,n>)=phi_n (x)$:
- $x_0 arrow.l <R_0, dots, R_n+2> arrow.long$ simulazione dei registri interni della macchina $ram$;
- $x_1 arrow.l L arrow.long$ il program counter;
- $x_2 arrow.l x arrow.long$ dato su cui lavora $P$;
- $x_3 arrow.l n arrow.long$ "listato" del programma P;
- $x_4 arrow.long$ contiene il codice dell'istruzione, da eseguire volta dopo volta, prelevata da $x_3$ grazie a $x_1$;
Come avveniva per le macchine $ram$, $I_w$ trova il suo input (cioè $<x,n>$) nella variabile di input $x_1$.

=== Codice dell'interprete $I_w$

#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: 10pt,
  radius: 4pt,
)

#align(center)[
  ```python
  Iw:
    input(<x,n>);
    x2 = sin(x1);
    x3 = des(x1);
    x0 = <0,x1,0,...,0>;
    x1 = 1;
    while(x1 != 0) do:
      if (x1 > length(x2)) then
        x1 = 0;
      else
        x4 = Proj(x1, x3);
        if (x4 mod 3 == 0) then
          x5 = x4 / 3;
          x0 = incr(x5, x0);
          x1 = x1 + 1;
        if (x4 mod 3 == 1) then
          x5 = (x4 - 1) / 3;
          x0 = decr(x5, x0);
          x1 = x1 + 1;
        if (x4 mod 3 == 2) then
          x5 = sin((x4 + 1) / 3);
          x6 = des((x4 + 1) / 3);
          if (Proj(x5, x0) == 0) then
            x1 = x4;
          else
            x1 = x1 + 1;
    x0 = sin(x0);
  ```
]
// mi piacerebbe mettere i commenti riguardo a cosa fanno le istruzioni, ma non saprei come farlo in modo carino, help me!

=== Conseguenza esistenza di $I_w$

Avendo in mano l'interprete, possiamo costruire un compilatore da programmi $ram$ a programmi $mwhile$ $ compilatore : programmi arrow wprogrammi, $ quindi l'inverso di quello trovato in precedenza.

Immaginando di avere $compilatore(P in programmi)$ esso fa:
- $n arrow.l cod(P)$;
- $x_1 = <x,n>$;
- $I_w$.
Questo significa che il programma non fa altro che cablare all'input $x$ il programma $mwhile$ da interpretare e procede con l'esecuzione dell'interprete. Vediamo se le tre proprietà sono soddisfatte:
+ Programmabile $arrow$ si, lo abbiamo fatto;
+ Completo $arrow$ l'interprete è sempre pronto e la codifica si può fare su qualsiasi programma $ram$;
+ Corretto $arrow$ $P in programmi arrow.long.bar compilatore(P) in wprogrammi$. \ Quindi, la semantica: $Psi(x) = Psi(<x,n>) = phi_n (x) = phi_P (x)$

Abbiamo dimostrato che $F(ram) subset.eq F(mwhile)$, l'opposto del precedente risultato.

// si può mettere un nome e l'anno al teorema?
#theorem(numbering: none)[
  Per ogni programma con goto ($ram$) ne esiste uno equivalente in linguaggio strutturato ($mwhile$).
]<thm>

Questo significa che la programmazione a basso livello può essere sostituita da quella ad alto livello.

=== Altre conseguenze

- Abbiamo visto che $ F(mwhile) subset.eq F(ram) \ F(ram) subset.eq F(mwhile) \ arrow.double.b \ NN^NN_bot tilde.not NN programmi tilde F(ram) = F(mwhile) $
  Quindi, seppur profondamente diversi, i sistemi $ram$ e $mwhile$ calcolano le stesse cose. Viene naturale chiedersi quale sia la vera natura della calcolabilità.

- Abbiamo dimostrato _formalmente_ che nei sistemi di programmazione $ram$ e $mwhile$ esistono funzioni *non computabili*.

- Usiamo $compilatore : wprogrammi arrow programmi$ su $I_w$ per costruire un *interprete universale* (cioè un interprete che basterebbe per poter fare tutti i programmi possibili):
$ U = compilatore(I_w) in programmi \ phi_U (<x,n>) = Psi_I_w (<x,n>) = phi_n (x). $ 

Nei sistemi di programmazione $ram$ esiste un programma $ram$ capace di simulare _qualunque_ altro programma $ram$.

== Riflessioni sul concetto di calcolabilità

Ricordiamo che il nostro obiettivo è andare a definire la regione delle funzioni calcolabili (e di conseguenza quelle non calcolabili).
Abbiamo visto che $ram$ e $mwhile$ permettono di calcolare le stesse cose. 

_Possiamo scindere il concetto di calcolabile? Potremmo pensare di definire ciò che è calcolabile a prescindere dalle macchine che usiamo per calcolare?_

Se caratterizzassimo matematicamente ciò che è calcolabile, potremmo usare tutta la potenza della matematica per parlare di informatica.

== Chiusura di insiemi

Dato un insieme $U$, si definisce *operazione* su $U$ una qualunque funzione $op: U times dots U arrow U$. 
Indichiamo con "arietà dell'operazione" il numero di dimensione del dominio dell'operazione.

// non ho messo gli esempi perché sono davvero banali

L'insieme $A subset.eq U$ si dice *chiuso* rispetto all'operazione $op: U^k arrow U$ se $ forall a_1, dots, a_k in A: "op"(a_1, dots, a_k) in A $

In generale, se $Omega$ è un insieme di operazioni su $U$, allora $A subset.eq U$ è chiuso rispetto a $Omega$ sse $A$ è chiuso per *ogni* operazioni in $Omega$.

$underline("Problema")$: sia $A subset.eq U$ e $op : U^k arrow U$, _qual è il più piccolo sottoinsieme di $U$ che contiene $A$ e che sia chiuso per $op$?_
Delle risposte ovvie sono:
+ se $A$ è chiuso per $op$, allora l'insieme cercato è $A$ stesso;
+ sicuramente $U$ soddisfa le due richieste, _ma è il più piccolo?_

#theorem(numbering: none)[
  Sia $A subset.eq U$ e $op : U^k arrow U$. Il più piccolo insieme di $U$ contenente $A$ e chiuso rispetto a $op$ si ottiene calcolando la *chiusura di $A$ rispetto a $op$*, e ciè, l'insieme $A^op$ definito *induttivamente* come:
  + $forall a in A arrow.double a in A^op$;
  + $forall a_1, dots, a_k in A^op arrow.double "op"(a_1, dots, a_k) in A^op$.
]<thm>

Vediamo una definizione più operativa di $A^op$:
+ Metti in $A^op$ tutti gli elementi di $A$;
+ Applica $op$ a una $k$-tupla di elementi in $A^op$;
+ Se trovi un risultato che non è già in $A^op$ allora aggiungilo ad $A^op$;
+ Ripeti i punti (2) e (3) fintantoché $A^op$ cresce.