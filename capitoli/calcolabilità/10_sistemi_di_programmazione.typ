#import "../alias.typ": *

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


= Sistemi di programmazione

Fin'ora, nello studio dei *sistemi di programmazione*, ci siamo concentrati su una loro caratteristica principale: la _potenza computazionale_. Con la tesi di Church-Turing abbiamo affermato che ogni sistema di programmazione ha come potenza computazionale $cal(P)$, cioè l'insieme delle funzioni ricorsive parziali.

Oltre a questo, vorremmo sapere altro sui sistemi di programmazione, ad esempio la possibilità o l'impossibilità di scrivere programmi su certi compiti.

Vorremmo, come sempre, rispondere nel modo più rigoroso e generale possibile, quindi non considereremo un particolare sistema di programmazione, ma studieremo proprietà valide per tutti i sistemi di programmazione "ragionevoli".
\ Dobbiamo astrarre un sistema di calcolo generale che permetta di rappresentarli tutti. 

== Assiomi di Rogers

_Assiomatizzare_ significa _dare un insieme di proprietà_ che i sistemi di calcolo devono avere per essere considerati buoni.

Da qui in poi individueremo un sistema di programmazione con $ {phi_i}_(i in NN), $ ovvero l'insieme delle funzioni calcolabili con quel sistema, in altre parole l'insieme delle sue semantiche. Il pedice $i in NN$ indica i programmi (_codificati_) di quel sistema.

Troveremo tre proprietà che un sistema di programmazione deve avere per essere considerato buono e lo faremo prendendo spunto dal sistema RAM.

=== Potenza computazionale

La prima proprietà che vogliamo in un sistema di programmazione riguarda la *potenza computazionale*. Dato il sistema ${phi_i}$ vogliamo che $ {phi}_i = cal(P). $ Questa proprietà è ragionevole, infatti non vogliamo considerare sistemi troppo potenti, che vanno oltre $cal(P)$, o poco potenti, che sono sotto $cal(P)$. Vogliamo la giusta potenza computazionale.

=== Interprete universale

La seconda proprietà che vogliamo in un sistema di programmazione riguarda la presenza di un *interprete universale*. Un interprete universale è un programma $mu in NN$ tale che $ forall x,n in NN quad phi_mu (cantor(x,n)) = phi_n (x). $
In sostanza è un programma scritto in un certo linguaggio, che riesce a interpretare ogni altro programma $n$ scritto nello stesso linguaggio, su qualsiasi input $x$.

// gigi: forse voglio mettere quelle due righe sulle slide
// tia: quale?

La presenza di un interprete universale permette un'*algebra* sui programmi, quindi permette la trasformazione di quest'ultimi.

=== Teorema $S_1^1$

L'ultima proprietà che vogliamo in un sistema di programmazione riguarda il soddisfacimento del teorema $S_1^1$. Questo teorema afferma che è possibile costruire automaticamente programmi specifici da programmi più generali, ottenuti fissando alcuni degli input.

Supponiamo di avere $ P in programmi : phi_P (cantor(x,y)) = x + y. $ Un programma RAM per questa funzione potrebbe essere $ P equiv & R_2 arrow.long.l cantorsin(R_1) \ & R_3 arrow.long.l cantordes(R_1) \ & R_0 arrow.long.l R_2 + R_3 quad . $

_Siamo in grado di produrre automaticamente un programma $overline(P)$ che riceve in input solo $x$ e calcola, ad esempio, $x+3$ a partire da $P$ e 3?_

$ (P,3) arrow.long.squiggly S^1_1 in programmi arrow.long.squiggly overline(P). $

Per generare $overline(P)$, potrei ad esempio fare $ overline(P) equiv & inc(R_0) \ & inc(R_0) \ & inc(R_0) \ & R_1 arrow.long.l cantor(R_1, R_0) \ & R_0 arrow.long.l 0 \ & P quad . $ 

Vediamo come questo programma segua principalmente quattro fasi:
+ si fissa il valore $y$ in $R_0$;
+ si calcola l'input $cantor(x,y)$ del programma $P$;
+ si resetta la memoria alla situazione iniziale, tranne per il registro $R_1$;
+ si chiama il programma $P$.

In generale, il programma $S_1^1$ implementa la funzione $ S_1^1 (n,y) = overline(n), $ con $n$ codifica di $P$ e $overline(n)$ codifica del nuovo programma $overline(P)$, tale che $ phi_(overline(n)) (x) = phi_n (cantor(x,y)) . $

Questo teorema è molto comodo perché permette di calcolare facilmente la codifica $overline(n)$: avendo $n$ devo solo codificare le istruzioni iniziali di fissaggio di $y$, la funzione coppia di Cantor per creare l'input e l'azzeramento dei registri utilizzati. In poche parole, $ S_1^1 (n,y) = overline(n) = cantor(underbracket(0\, dots\, 0, y), s, t, n), $ con $s$ codifica dell'istruzione che calcola la funzione coppia di Cantor e $t$ codifica dell'istruzione di azzeramento.

$S_1^1$ è una funzione totale e programmabile, quindi $S_1^1 in cal(T)$ (funzione *ricorsiva totale*).

In sintesi, per RAM, esiste una funzione $S_1^1$ *ricorsiva totale* che accetta come argomenti 
+ il codice $n$ di un programma che ha $2$ input;
+ un valore $y$ cui fissare il secondo input 
e produce il codice $overline(n) = S_1^1(n,y)$ di un programma che si comporta come $n$ nel caso in cui il secondo input è fissato ad essere $y$.

#theorem(numbering: none)[
  Dato $phi_i$ sistema RAM, esiste una funzione $S_1^1 in cal(T)$ tale che $ forall n,x,y in NN quad phi_n (cantor(x,y)) = phi_(S_1^1 (n,y)) (x). $
]

Questo teorema ci garantisce un modo di usare l'algebra sui programmi.

Inoltre, ha anche una forma generale $S_n^m$ che riguarda programmi a $m+n$ input in cui si prefissano $n$ input e si lasciano variare i primi $m$.

#theorem(numbering: none)[
  Dato $phi_i$ sistema RAM, esiste una funzione $S_n^m in cal(T)$ tale che per ogni programma $k in NN$, $wstato(x) in NN^m$ e $wstato(y) in NN^n$ vale $ phi_k (cantor(wstato(x), wstato(y))) = phi_(S_n^m (k,wstato(y))) (cantor(wstato(x))). $
]

== Sistemi di programmazione accettabili (SPA)

Le tre caratteristiche che abbiamo identificato formano gli *assiomi di Rogers* (1953). Questi caratterizzano i sistemi di programmazioni su cui ci concentreremo che chiameremo _Sistemi di Programmazione Accettabili_.

Questi assiomi non sono restrittivi: tutti i modelli di calcolo ragionevoli sono di fatto SPA.

== Compilatori tra SPA

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
  + $exists u : phi_u (cantor(x,n))=phi_n (x)$;
  + $exists S_1^1 in cal(T) : phi_n (cantor(x,y))=phi_(S_1^1(e,i)) (x)$;
  Voglio trovare un compilatore $t in cal(T)$ che sia corretto. Ma allora $ phi_i (x) =^((2)) phi_u (cantor(x,i)) =^((1)) Psi_e (cantor(x,i)) =^((3)) Psi_(S_1^1 (e,i)) (x) $
    
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

== Teorema di ricorsione

Vogliamo trovare dei risultati che abbiano la stessa portata dei precedenti, quindi che valgano per _tutti i sistemi di programmazione accettabili_.

Il *teorema di ricorsione* ci fornisce una risposta precisa a entrambi i quesiti che ci siamo posti.

#theorem(numbering: none)[
  Dato un SPA ${phi_i}$, per ogni $t : NN arrow.long NN$ ricorsiva totale vale $ exists n in NN bar.v phi_n = phi_t(n). $
]

Diamo una chiave di lettura a questo teorema:
- consideriamo $t$ come un programma che prende in input un programma $n$ e lo cambia nel programma $t(n)$, anche nella maniera più assurda;
- il teorema dice che qualsiasi sia la natura di $t$, esisterà sempre almeno un programma il cui significato *non sarà stravolto* da $t$.

Prima di vedere la sua dimostrazione, torniamo a considerare le due domande che ci siamo posti poco fa e vediamo la risposta usando proprio il teorema di ricorsione.

== Due quesiti sugli SPA

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

=== Primo quesito: Quine

Consideriamo il programma RAM $ P equiv & inc(R_0) \ & inc(R_0) \ & dots \ & inc(R_0) $ che ripete l'istruzione di incremento di $R_0$ un numero $j$ di volte. La semantica di questo programma è esattamente $j$: infatti, dopo la sua esecuzione avremo $j$ nel registro di output $R_0$.

Calcoliamo la codifica di $P$ come $ cod(P) = cantor(underbracket(0 \, dots \, 0, j"-volte")) = Z(j) in cal(T). $ 

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

#proof[
  \ Siamo in un SPA ${phi_i}$ quindi valgono i tre assiomi di Rogers.
  
  D'ora in avanti, per semplicità, scriveremo $phi_n (x,y)$ al posto di $phi_n (cantor(x,y))$.

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

In tutti gli esercizi viene dato un SPA ${phi_i}$.

$ exists n in NN bar.v phi_n (x) = phi_x (n) + phi_(phi_x (n)) (n)? $

$ phi_n (x) & =^((2)) phi_u (n,x) + phi_(phi_u (n,x)) (n) \ & =^((2)) phi_u (n,x) + phi_u (n, phi_u (n,x)) \ & = f(x,n) \ & =^((1)) phi_e (x,n) =^((3)) phi_(S_1^1 (e,n)) (x) \ & =^("TR") "OK" . $

$ exists n in NN bar.v phi_n (x) = phi_x (x) + n? $

$ phi_n (x) & =^((2)) phi_u (x,x) + n \ & = f(x,n) \ & =^((1)) phi_e (x,n) =^((3)) phi_(S_1^1 (e,n)) (x) \ & =^("TR") "OK" . $

$ exists n in NN bar.v phi_n (x) = phi_x (cantor(n, phi_x (1)))? $

$ phi_n (x) & =^((2)) phi_u (cantor(n, phi_u (1,x)), x) \ & = f(x,n) \ & =^((1)) phi_e (x,n) =^((3)) phi_(S_1^1 (e,n)) (x) \ & =^("TR") "OK" . $

$ exists n in NN bar.v phi_n (x) = phi_(phi_x (cantorsin(n))) (cantordes(n))? $

$ phi_n (x) & =^((2)) phi_(phi_u (cantorsin(n), x)) (cantordes(n)) \ & =^((2)) phi_u (cantordes(n), phi_u (cantorsin(n), x)) \ & = f(x,n) \ & =^((1)) phi_e (x,n) =^((3)) phi_(S_1^1 (e,n)) (x) \ & =^("TR") "OK" . $

$ exists n in NN bar.v phi_n (x) = n^x + (phi_x (x))^2? $

$ phi_n (x) & =^((2)) n^x + (phi_u (x,x))^2 \ & = f(x,n) \ & =^((1)) phi_e (x,n) =^((3)) phi_(S_1^1 (e,n)) (x) \ & =^("TR") "OK" . $

$ exists n in NN bar.v phi_n (x) = phi_x (n+2) + (phi_(phi_x (n)) (n+3))^2? $

$ phi_n (x) & =^((2)) phi_u (n+2,x) + (phi_(phi_u (n,x)) (n+3))^2 \ & =^((2)) phi_u (n+2,x) + (phi_u (n+3, phi_u (n,x)))^2 \ & = f(x,n) \ & =^((1)) phi_e (x,n) =^((3)) phi_(S_1^1 (e,n)) (x) \ & =^("TR") "OK" . $
