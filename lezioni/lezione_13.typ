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

= Lezione 13

== Sistemi di programmazione

=== Introduzione

Fin'ora, nello studio dei *sistemi di programmazione*, ci siamo concentrati su una loro caratteristica principale: la _potenza computazionale_. Con la tesi di Church-Turing abbiamo affermato che ogni sistema di programmazione ha come potenza computazionale $cal(P)$, cioè l'insieme delle funzioni ricorsive parziali.

Oltre a questo, vorremmo sapere altro sui sistemi di programmazione, ad esempio la possibilità o l'impossibilità di scrivere programmi su certi compiti.

Vorremmo, come sempre, rispondere nel modo più rigoroso e generale possibile, quindi non considereremo un particolare sistema di programmazione, ma studieremo proprietà valide per tutti i sistemi di programmazione "ragionevoli".
\ Dobbiamo astrarre un sistema di calcolo generale che permetta di rappresentarli tutti. 

=== Assiomatizzazione di "sistema di programmazione buono"

_Assiomatizzare_ significa _dare un insieme di proprietà_ che i sistemi di calcolo devono avere per essere considerati buoni.

Da qui in poi individueremo un sistema di programmazione con $ {phi_i}_(i in NN), $ ovvero l'insieme delle funzioni calcolabili con quel sistema, in altre parole l'insieme delle sue semantiche. Il pedice $i in NN$ indica i programmi (_codificati_) di quel sistema.

Troveremo tre proprietà che un sistema di programmazione deve avere per essere considerato buono e lo faremo prendendo spunto dal sistema RAM.

==== Potenza computazionale

La prima proprietà che vogliamo in un sistema di programmazione riguarda la *potenza computazionale*. Dato il sistema ${phi_i}$ vogliamo che $ {phi}_i = cal(P). $ Questa proprietà è ragionevole, infatti non vogliamo considerare sistemi troppo potenti, che vanno oltre $cal(P)$, o poco potenti, che sono sotto $cal(P)$. Vogliamo la giusta potenza computazionale.

==== Interprete universale

La seconda proprietà che vogliamo in un sistema di programmazione riguarda la presenza di un *interprete universale*. Un interprete universale è un programma $mu in NN$ tale che $ forall x,n in NN quad phi_mu (<x,n>) = phi_n (x). $
In sostanza è un programma scritto in un certo linguaggio, che riesce a interpretare ogni altro programma $n$ scritto nello stesso linguaggio, su qualsiasi input $x$.

// gigi: forse voglio mettere quelle due righe sulle slide
// tia: quale?

La presenza di un interprete universale permette un'*algebra* sui programmi, quindi permette la trasformazione di quest'ultimi.

==== Teorema $S_1^1$

L'ultima proprietà che vogliamo in un sistema di programmazione riguarda il soddisfacimento del teorema $S_1^1$. Questo teorema afferma che è possibile costruire automaticamente programmi specifici da programmi più generali, ottenuti fissando alcuni degli input.

Supponiamo di avere $ P in programmi : phi_P (<x,y>) = x + y. $ Un programma RAM per questa funzione potrebbe essere $ P equiv & R_2 arrow.long.l cantorsin(R_1) \ & R_3 arrow.long.l cantordes(R_1) \ & R_0 arrow.long.l R_2 + R_3 quad . $

_Siamo in grado di produrre automaticamente un programma $overline(P)$ che riceve in input solo $x$ e calcola, ad esempio, $x+3$ a partire da $P$ e 3?_

$ (P,3) arrow.long.squiggly S^1_1 in programmi arrow.long.squiggly overline(P). $

Per generare $overline(P)$, potrei ad esempio fare $ overline(P) equiv & inc(R_0) \ & inc(R_0) \ & inc(R_0) \ & R_1 arrow.long.l <R_1, R_0> \ & R_0 arrow.long.l 0 \ & P quad . $ 

Vediamo come questo programma segua principalmente quattro fasi:
+ si fissa il valore $y$ in $R_0$;
+ si calcola l'input $<x,y>$ del programma $P$;
+ si resetta la memoria alla situazione iniziale, tranne per il registro $R_1$;
+ si chiama il programma $P$.

In generale, il programma $S_1^1$ implementa la funzione $ S_1^1 (n,y) = overline(n), $ con $n$ codifica di $P$ e $overline(n)$ codifica del nuovo programma $overline(P)$, tale che $ phi_(overline(n)) (x) = phi_n (<x,y>) . $

Questo teorema è molto comodo perché permette di calcolare facilmente la codifica $overline(n)$: avendo $n$ devo solo codificare le istruzioni iniziali di fissaggio di $y$, la funzione coppia di Cantor per creare l'input e l'azzeramento dei registri utilizzati. In poche parole, $ S_1^1 (n,y) = overline(n) = <underbracket(0\, dots\, 0, y), s, t, n>, $ con $s$ codifica dell'istruzione che calcola la funzione coppia di Cantor e $t$ codifica dell'istruzione di azzeramento.

$S_1^1$ è una funzione totale e programmabile, quindi $S_1^1 in cal(T)$ (funzione *ricorsiva totale*).

In sintesi, per RAM, esiste una funzione $S_1^1$ *ricorsiva totale* che accetta come argomenti 
+ il codice $n$ di un programma che ha $2$ input;
+ un valore $y$ cui fissare il secondo input 
e produce il codice $overline(n) = S_1^1(n,y)$ di un programma che si comporta come $n$ nel caso in cui il secondo input è fissato ad essere $y$.

#theorem(numbering: none)[
  Dato $phi_i$ sistema RAM, esiste una funzione $S_1^1 in cal(T)$ tale che $ forall n,x,y in NN quad phi_n (<x,y>) = phi_(S_1^1 (n,y)) (x). $
]

Questo teorema ci garantisce un modo di usare l'algebra sui programmi.

Inoltre, ha anche una forma generale $S_n^m$ che riguarda programmi a $m+n$ input in cui si prefissano $n$ input e si lasciano variare i primi $m$.

#theorem(numbering: none)[
  Dato $phi_i$ sistema RAM, esiste una funzione $S_n^m in cal(T)$ tale che per ogni programma $k in NN$, $wstato(x) in NN^m$ e $wstato(y) in NN^n$ vale $ phi_k (<wstato(x), wstato(y)>) = phi_(S_n^m (k,wstato(y))) (<wstato(x)>). $
]

=== Sistemi di programmazione accettabili (SPA)

Le tre caratteristiche che abbiamo identificato formano gli *assiomi di Rogers* (1953). Questi caratterizzano i sistemi di programmazioni su cui ci concentreremo che chiameremo _Sistemi di Programmazione Accettabili_.

Questi assiomi non sono restrittivi: tutti i modelli di calcolo ragionevoli sono di fatto SPA.

=== Esistenza di compilatori tra SPA

Sappiamo che esiste un compilatore da WHILE a RAM, _ma è l'unico?_

Dati i SPA ${phi_i}$ e ${Psi_i}$, un compilatore dal primo al secondo è una funzione $t: NN arrow.long NN$ che soddisfa le proprietà di:
+ *programmabilità*: esiste un programma che implementa $t$;
+ *completezza*: $t$ compila ogni $i in NN$;
+ *correttezza*: $forall i in NN$ vale $phi_i = Psi_(t(i))$.

I primi due punti ci dicono che $t in cal(T)$.

#theorem(numbering: none)[
  Dati due SPA, esiste sempre un compilatore tra essi.
]

#proof[
  \ Consideriamo ${phi_i}$ e ${Psi_i}$ due SPA. Valgono i tre assiomi di Rogers:
  + ${phi_i} = cal(P)$;
  + $exists u : phi_u (<x,n>)=phi_n (x)$;
  + $exists S_1^1 in cal(T) : phi_n (<x,y>)=phi_(S_1^1(e,i)) (x)$;
  Voglio trovare un compilatore $t in cal(T)$ che sia corretto. Ma allora $ phi_i (x) =^((2)) phi_u (<x,i>) =^((1)) Psi_e (<x,i>) =^((3)) Psi_(S_1^1 (e,i)) (x) $
    
  In poche parole, il compilatore cercato è la funzione $t(i) = S_1^1 (e,i)$ per ogni $i in NN$. 
  \ Infatti:
  + $t in cal(T)$ in quanto $S_1^1 in cal(T)$;
  + $t$ corretto perché $phi_i = Psi_(t(i))$.
]

Notiamo la portata molto generale del teorema: non ci dice quale è il compilatore, ma ci dice che sicuramente esiste.

#corollary(numbering: none)[
  Dati gli SPA $A,B,C$ esiste sempre un compilatore da $A$ a $B$ scritto nel linguaggio $C$.
]

#proof[
  \ Per il teorema precedente esiste un compilatore $t in cal(T)$ da $A$ a $B$. 
  \ $C$ è un SPA, quindi contiene programmi per tutte le funzioni ricorsive parziali, dunque ne contiene uno anche per $t$, che è una funzione ricorsiva totale.
]

In pratica, ciò vuol dire che per qualunque coppia di linguaggi, esistenti o che verranno progettati in futuro, sarò sempre in grado di scrivere un compilatore tra essi nel linguaggio che più preferisco. È un risultato assolutamente generale.
