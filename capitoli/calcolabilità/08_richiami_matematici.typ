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


= Richiami matematici: chiusura

== Operazioni

Dato un insieme $U$, si definisce *operazione* su $U$ una qualunque funzione $ "op": underbracket(U times dots times U, k) arrow.long U. $ 

Il numero $k$ indica l'*arietà* (o _arità_) dell'operazione, ovvero la dimensione del dominio dell'operazione.

== Proprietà di chiusura

L'insieme $A subset.eq U$ si dice *chiuso* rispetto all'operazione $"op": U^k arrow.long U$ se e solo se $ forall a_1, dots, a_k in A quad "op"(a_1, dots, a_k) in A. $ In poche parole, _se opero in A rimango in A_. In generale, se $Omega$ è un insieme di operazioni su $U$, allora $A subset.eq U$ è chiuso rispetto a $Omega$ se e solo se $A$ è chiuso per *ogni* operazione in $Omega$.

== Chiusura di un insieme

Siano $A subset.eq U$ insieme e $"op" : U^k arrow.long U$ un'operazione su esso, vogliamo espandere l'insieme $A$ per trovare il più piccolo sottoinsieme di $U$ tale che:
+ contiene $A$;
+ chiuso per $"op"$.

Quello che vogliamo fare è espandere $A$ il minimo possibile per garantire la chiusura rispetto a $"op"$.

Due risposte ovvie a questo problema sono:
+ se $A$ è chiuso rispetto a $"op"$, allora $A$ stesso è l'insieme cercato;
+ sicuramente $U$ soddisfa le due richieste, _ma è il più piccolo?_

#theorem(numbering: none)[
  Siano $A subset.eq U$ insieme e $"op" : U^k arrow.long U$ un'operazione su esso. Il più piccolo sottoinsieme di $U$ contenente $A$ e chiuso rispetto all'operazione $"op"$ si ottiene calcolando la *chiusura di $A$ rispetto a $"op"$*, e cioè l'insieme $A^"op"$ definito *induttivamente* come:
  + $forall a in A arrow.long.double a in A^"op"$;
  + $forall a_1, dots, a_k in A^"op" arrow.long.double "op"(a_1, dots, a_k) in A^"op"$;
  + nient'altro sta in $A^"op"$.
]

Vediamo una definizione più _operativa_ di $A^"op"$:
+ metti in $A^"op"$ tutti gli elementi di $A$;
+ applica $"op"$ a una $k$-tupla di elementi in $A^"op"$;
+ se trovi un risultato che non è già in $A^"op"$ allora aggiungilo ad $A^"op"$;
+ ripeti i punti (2) e (3) fintantoché $A^"op"$ cresce.

Siano $Omega = {"op"_1, dots, "op"_t}$ un insieme di operazioni su $U$ di arietà rispettivamente $k_1, dots, k_t$ e $A subset.eq U$ insieme. Definiamo *chiusura di $A$ rispetto a $Omega$* il più piccolo sottoinsieme di $U$ contenente $A$ e chiuso rispetto a $Omega$, cioè l'insieme $A^Omega$ definito come:
- $forall a in A arrow.long.double a in A^Omega$;
- $forall i in {1,dots,t} quad forall a_1, dots, a_(k_i) in A^Omega arrow.long.double "op"_i (a_1, dots, a_(k_i)) in A^Omega$;
- nient'altro è in $A^Omega$.
