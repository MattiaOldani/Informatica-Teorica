// Setup

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

= Lezione 13

== Sistemi di programmazione

=== Introduzione

I *sistemi di programmazione* studiati fin'ora si sono concentrati su una loro caratteristica principale: la _potenza computazionale_. Con la tesi di Church-Turing abbiamo affermato che ogni sistema di programmazione ha come potenza computazionale l'insieme $cal(P)$ delle funzioni ricorsive parziali.

Oltre a questo, vorremmo sapere altro sui sistemi di programmazione, ad esempio:
- la possibilità di scrivere programmi su certi compiti o
- l'impossibilità di scrivere programmi su certi altri compiti.

Vogliamo, come sempre, rispondere nel modo più rigoroso e generale possibile: non considereremo un particolare sistema di programmazione, ma studieremo proprietà valide per tutti i sistemi di programmazione "ragionevoli".

=== Assiomatizzazione di "sistema di programmazione buono"

_Assiomatizzare_ significa _dare un insieme di proprietà_ che i sistemi di calcolo devono avere per essere considerati buoni.

// Dobbiamo veramente mettere sta cosa?
Seguiremo questa roadmap:
+ individuazione di alcune proprietà auspicabili per un sistema di programmazione, qualunque esso sia. Devono essere proprietà ragionevoli e non troppo restrittive. I sistemi che soddisfano queste proprietà saranno detti *sistemi di programmazione accettabili*;
+ dimostrazione di alcuni risultati su un sistema usando solo tali proprietà;
+ esportazione immediata dei risultati su tutti i sistemi di programmazione accettabili.

Da qui in poi individueremo un sistema di programmazione con $ {phi_i}_(i in NN), $ ovvero l'insieme delle funzioni calcolabili con quel sistema, le sue semantiche. Il pedice $i in NN$ indica i programmi (_codificati_) di quel sistema.

Daremo tre proprietà che un sistema di programmazione deve avere per essere considerato buono, e lo faremo prendendo spunto dal sistema RAM.

==== Potenza computazionale

La prima proprietà che vogliamo in un sistema di programmazione riguarda la *potenza computazionale*, ovvero dato il sistema ${phi_i}$ vogliamo $ {phi}_i = cal(P). $ Questa proprietà è ragionevole: infatti, non voglio considerare sistemi troppo potenti, che vanno oltre $cal(P)$, o poco potenti, che sono sotto $cal(P)$. Devo avere la giusta potenza computazionale.

==== Interprete universale

La seconda proprietà che vogliamo in un sistema di programmazione riguarda la presenza di un *interprete universale*. Un interprete universale è un programma $u in NN$ tale che $ forall x,n in NN quad phi_u (<x,n>) = phi_n (x), $ ovvero è un programma scritto in un certo linguaggio che riesce a interpretare ogni altro programma scritto nello stesso linguaggio.

La presenza di un interprete universale permette un'*algebra* sui programmi, ovvero permette la trasformazione di quest'ultimi.

==== Teorema $S_1^1$

L'ultima proprietà che vogliamo in un sistema di programmazione riguarda il soddisfacimento del teorema $S_1^1$. Questo teorema afferma che è possibile costruire automaticamente programmi più specifici da programmi più generali, ottenuti prefissando alcuni input. Nel caso del teorema $S_1^1$, si riesce a ottenere un programma che accetta un input a partire da un programma che accetta due input.

Supponiamo di avere $ P in programmi bar.v phi_P (<x,y>) = x + y. $ Il programma RAM (_altissimo levissimo purissimo_) per questa funzione è $ P equiv & R_2 arrow.long.l #cantor_sin (R_1) \ & R_3 arrow.long.l #cantor_des (R_1) \ & R_0 arrow.long.l R_2 + R_3 quad . $

Siamo in grado di produrre automaticamente un programma $overline(P)$ che riceve in input solo $x$ e calcola, ad esempio, $x+3$ a partire da $P$ e 3?

$ [P,3] arrow.long.squiggly S^1_1 in programmi arrow.long.squiggly overline(P). $

Usando $P$ devo generare $overline(P)$: potrei ad esempio fare $ overline(P) equiv & inc(R_0) \ & inc(R_0) \ & inc(R_0) \ & R_1 arrow.long.l <R_1, R_0> \ & R_0 arrow.long.l 0 \ & P quad . $ Vediamo come questo programma segue quattro fasi:
+ si fissa il valore $y$ in $R_0$;
+ si calcola l'input $<x,y>$ del programma $P$;
+ si resetta la memoria alla situazione iniziale;
+ si chiama il programma $P$.

In generale, il programma $S_1^1$ implementa la funzione $ S_1^1 (n,y) = overline(n), $ con $n$ codifica di $P$ e $overline(n)$ codifica del nuovo programma $overline(P)$ tale che $ phi_(overline(n)) (x) = phi_n (<x,y>) . $

Questo teorema è molto comodo perché permette di calcolare facilmente la codifica $overline(n)$: infatti, avendo $n$ devo solo codificare le istruzioni iniziali di fissaggio di $y$, la funzione coppia di Cantor e l'azzeramento. In poche parole, $ S_1^1 (n,y) = overline(n) = <underbracket(0\, dots\, 0, y), s, t, n>, $ con $s$ codifica dell'istruzione che calcola la funzione coppia di Cantor e $t$ codifica dell'istruzione di azzeramento.

$S_1^1$ è una funzione totale e programmabile, quindi $S_1^1 in cal(T)$ è una funzione *ricorsiva totale*.

#theorem(numbering: none)[
  Dato $phi_i$ sistema RAM, esiste una funzione $S_1^1 in cal(T)$ tale che $ forall n,x,y in NN quad phi_n (<x,y>) = phi_(S_1^1 (n,y)) (x). $
]

Questo teorema ci garantisce un'algebra sui programmi.

Il teorema ha anche una forma generale $S_n^m$ che riguarda programmi a $m+n$ input in cui si prefissano $n$ input e si lasciano variare i primi $m$.

#theorem(numbering: none)[
  Dato $phi_i$ sistema RAM, esiste una funzione $S_n^m in cal(T)$ tale che per ogni programma $k in NN$, $wstato(x) in NN^m$ e $wstato(y) in NN^n$ vale $ phi_k (<wstato(x), wstato(y)>) = phi_(S_n^m (k,wstato(y))) (<wstato(x)>). $
]

=== Sistemi di programmazione accettabili (SPA)

Le tre caratteristiche presentate formano gli *assiomi di Rogers* (1953). Questi assiomi caratterizzano i sistemi di programmazioni su cui ci concentreremo.

Gli assiomi di Rogers non sono restrittivi: tutti i modelli di calcolo ragionevoli sono di fatto SPA.

Grazie a questi mostreremo dei risultati che saranno validi e applicabili a tutti gli SPA.

=== Esistenza di compilatori tra SPA

Sappiamo che esiste compilatore da WHILE a RAM, ma è l'unico?

Dati gli SPA ${phi_i}$ e ${Psi_i}$, un compilatore dal primo al secondo SPA è una funzione $t: NN arrow.long NN$ che soddisfa le proprietà di:
+ *programmabilità*: esiste un programma che implementa $t$;
+ *completezza*: $t$ compila ogni $i in NN$;
+ *correttezza*: $forall i in NN$ vale $phi_i = Psi_(t(i))$.

I punti 1 e 2 ci dicono che $t$ deve essere _ricorsiva totale_, e in più deve essere corretta.

#theorem(numbering: none)[
  Dati due SPA, esiste sempre un compilatore tra essi.
]

#proof[
  \ I sistemi ${phi_i}$ e ${Psi_i}$ sono due SPA, quindi valgono i tre assiomi di Rogers. Devo esibire un compilatore $t in cal(T)$ che sia corretto. Ma allora $ phi_i (x) =^2 phi_u (<x,i>) =^1 Psi_e (<x,i>) =^3 Psi_(S_1^1 (e,i)) (x) $
  
  In ordine ho applicato:
  - assioma 2: esiste un interprete universale per ${phi_i}$;
  - assioma 1: essendo ${phi_i}$ e ${Psi_i}$ ricorsivi parziali in ${Psi_i}$ esiste un programma $e$ ricorsivo parziale che abbia la stessa semantica di $u$;
  - assioma 3: usando il teorema $S_1^1$ fisso un input.
  
  In poche parole, il compilatore cercato è la funzione $t(i) = S_1^1 (e,i)$ per ogni $i in NN$. Infatti:
  + $t in cal(T)$ in quanto $S_1^1 in cal(T)$;
  + $t$ corretto perché $phi_i = Psi_(t(i))$ per quanto scritto sopra.
]

Notiamo la portata molto generale del teorema: non ci dice quale è il compilatore, ma ci dice che sicuramente esiste.

#corollary(numbering: none)[
  Dati gli SPA $A,B,C$ esiste sempre un compilatore da $A$ a $B$ scritto nel linguaggio $C$.
]

#proof[
  \ Per il teorema precedente esiste un compilatore $t in cal(T)$ da $A$ a $B$. $C$ è un SPA, quindi C contiene programmi per tutte le funzioni ricorsive parziali, quindi contiene un programma anche per $t$ che è una funzione ricorsiva totale.
]

In pratica, ciò vuol dire che per qualunque coppia di linguaggi, esistenti o che verranno progettati in futuro, sarò sempre in grado di scrivere un compilatore tra essi nel linguaggio che più preferisco. È un risultato assolutamente generale.
