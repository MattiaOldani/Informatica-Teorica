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

#show thm-selector("thm-group", subgroup: "proof"): it => block(
  it,
  stroke: green + 1pt,
  inset: 1em,
  breakable: true
)

#import "alias.typ": *

// Appunti

= Lezione 14

Abbiamo visto che, a prescindere dalla coppia di linguaggi che considero, esiste _sempre_ un compilatore tra essi.

Vogliamo ora trovare dei risultati che abbiano la stessa portata dei precedenti, quindi *che valgano per tutti i sistemi di programmazione*.

== Sull'esistenza di certi programmi negli SPA

Dopo aver definito i Sistemi di Programmazione Accettabili, ci poniamo due domande riguardo ad essi:
+ *programmi auto-replicanti*: dato un SPA, _esistono all'interno di esso programmi che stampano se stessi (il loro listato)?_
  
  Questi programmi sono detti *Quine*, in onore del filosofo e logico Willard Quine (1908-2000) che le descrisse.

  La risposta è positiva per molti linguaggi, quali C, C++, Java, SQL, Postscript, Php, etc. Noi, però, vogliamo rispondere tramite una dimostrazione rigorosa, quindi ambientiamo la domanda nel sistema di programmazione RAM, che diventa $ exists j in NN : phi_j (x) = j " per ogni input " x in NN "?" $

+ *compilatori completamente errati*: dati due SPA ${phi_i}$ e ${Psi_j}$, _esiste un compilatore completamente errato?_ 
  
  Un compilatore dal primo al secondo è una funzione $t: NN arrow NN$ che sia:
  - $t in cal(T) arrow$ programmabile e totale,
  - $forall i in NN : phi_i=Psi_t(i) arrow$ corretta;
  mentre un _compilatore completamente errato_ è una funzione $t: NN arrow NN$ tale che:
  - $t in cal(T)$;
  - $forall i in NN : phi_i eq.not Psi_t(i)$.

== Teorema di Ricorsione

Il *teorema di ricorsione* ci fornisce una risposta precisa a entrambi i quesiti che ci siamo posti.

#theorem(numbering: none)[
  Dato un SPA ${phi_i}$, per ogni $t : NN arrow NN$ *ricorsiva totale*, vale $ exists n in NN : phi_n = phi_t(n) $
]<thm>

Consideriamo $t$ come un programma che prende in input un programma $n$ e lo cambia nel programma $t(n)$, anche nella maniera più assurda.
Il teorema dice che qualsiasi sia la natura di $t$, esiste sempre almeno un programma il cui significato *non sarà stravolto* da $t$.

Prima di vedere la sua dimostrazione, torniamo a considerare le due domande che ci siamo posti poco fa.

=== Primo quesito: programmi auto-replicanti

Consideriamo il seguente programma RAM: $ P equiv & R_0 arrow.l.long R_0 + 1 \ & R_0 arrow.l.long R_0 + 1 \ & dots \ & R_0 arrow.l.long R_0 + 1 $ in cui l'incremento viene ripetuto $j$ volte. Calcoliamo la codifica del programma $ cod(P) = underbracket("<0, 0, ...>", j-"volte") = Z(j) in cal(T) $ ed è una funzione ricorsiva totale in quanto programmabile (sfrutta solo la funzione di Cantor) e totale. Vale quindi $ phi_Z(j) (x) = j $
Per il Teorema di ricorsione $ exists j in NN : phi_j (x) = phi_Z(j) (x) = j, $ quindi effettivamente esiste un programma $j$ la cui semantica è proprio quella di stampare sé stesso.

La risposta alla prima domanda è *sì* per RAM, ma lo è in generale per tutti gli SPA che ammettono sempre codifiche di programmi.

=== Secondo quesito: compilatori completamente errati

Consideriamo di avere in mano una funzione $t in cal(T)$ per "maltrattare" i programmi. Vediamo la semantica del programma modificato $ (*) quad Psi_t(i) (x) overset(=, (2)) Psi_mu (x, t(i)) overset(=, (1)) phi_e (x,t(i)) overset(=, (3)) phi_(underbracket(S_1^1(e,t(i)), g(i)))(x), $ dove $t(i)$ è il programma modificato e $g(i)$ è la composizione tra $t$ e $S_1^1 in cal(T)$, quindi anche $g in cal(T)$ e per il teorema di ricorsione $exists i in NN : phi_i = phi_g(i) quad (**)$.

Mettendo insieme $(*)$ e $(**)$, otteniamo $ exists i in NN : Psi_t(i) = phi_i, $ *per ogni* $t in cal(T)$.

Di conseguenza, la risposta alla seconda domanda è *no*.

=== Dimostrazione teorema di ricorsione

#proof[
  Ricordiamo che un SPA soddisfa:
  + ${phi_i} = cal(P)$;
  + $exists mu in NN : phi_mu (<x,n>) = phi_n (x)$;
  + $exists S_1^1 in cal(T) : phi_n (<x,y>) = phi_(S_1^1(n,y)) (x)$.
  
  D'ora in avanti, per semplicità, scriveremo $phi_n (x,y)$ al posto di $phi_n (<x,y>)$.

  $ phi_(phi_i (i)) (x) overset(=, (2)) phi_(phi_u (i,i)) (x) overset(=, (2)) phi_u (x, phi_u (i,i)) = f(x, i) in cal(P) overset(=, (1)) phi_e (x, i) overset(=, (3)) phi_(S_1^1 (e,i)) (x) $

  Consideriamo la funzione $t(S_1^1(e,i))$. Essa è ricorsiva totale in $i$, perché composizione di $t$ e di $S_1^1 in cal(T) overset(arrow.double, (1)) exists m in NN : phi_m (i) = t(S_1^1(e,i))$.

  Abbiamo visto che:
  - $phi_(phi_i (i))(x) = phi_(S_1^1 (e,i))(x)$;
  - $phi_m (i) = t(S_1^1 (e,i))$.
  Proviamo a fissare $n = S_1^1 (e,m)$ e a mostrare che per tale $n$ vale $phi_n = phi_t(n)$, il che proverebbe il teorema di ricorsione:
  - $phi_n (x) = phi_(S_1^1 (e,m)) (x)= phi_(phi_m (m)) (x)$;
  - $phi_t(n) (x) = phi_(t(S_1^1 (e,m))) (x) = phi_(phi_m (m)) (x)$
  Il teorema è verificato.
]

A causa di questo risultato, possiamo dire che esistono sempre dei Quine negli SPA e non è possibile progettare compilatori completamente errati.

== Equazioni su SPA

La portata del teorema di ricorsione è molto ampia, infatti ci permette di risolvere equazioni su SPA, in cui sono richieste alcune proprietà.

La *strategia* da seguire per risolvere questo tipo di richieste è analoga a quella usata per la dimostrazione e può essere riassunta nei seguenti passaggi:
+ trasforma la parte destra dell'equazione in una $f(x,n)$;
+ mostra che $f(x,n) in cal(P)$ e quindi che $f(x,n) = phi_e (x,n)$;
+ l'equazione iniziale diventa $phi_n (x) = phi_e (x,n) overset(=, (2)) phi_(S_1^1 (e,n)) (x)$
+ noto che $S_1^1 (e,n)$ è una funzione ricorsiva totale in $n$ dato che $S_1^1 in cal(T)$;
+ il quesito iniziale è diventato $exists n in NN : phi_n (x) = phi_(S_1^1 (e,n)) (x)$, con $S_1^1 (e,n) in cal(T)$ ?
+ la *risposta* è *sì* per il teorema di ricorsione.

=== Esempio 1

_Dato uno SPA ${phi_i}, exists n in NN : phi_n (x) = phi_x (n+phi_(phi_n (0)) (x))$?_

Cominciamo a trasformare la parte di destra $ phi_n (x) & overset(=,(2)) phi_x (n + phi_(phi_u (0,n)) (x)) \ & overset(=,(2)) phi_x (n + phi_u (x, phi_u (0,n))) \ & overset(=,(2)) phi_u (n + phi_u (x, phi_u (0,n)), x) \ & = f(x,n) in cal(P) $
in cui l'ultimo passaggio è vero perché $phi_u (n + phi_u (x, phi_u (0,n)), x)$ compone solamente funzioni ricorsive parziali. Di conseguenza, esiste un programma $e$ che calcoli la funzione. 
\ Continuando $ f(x,n) overset(=, (1)) phi_e (x,n) overset(=, (2)) phi_(S_1^1 (e,n)) (x) $ con $S_1^1(e,n) in cal(T)$ per l'assioma $(3)$.

Per il teorema di ricorsione, possiamo concludere che $exists n :$ $ phi_n (x) = phi_(S_1^1 (e,n)) (x) = phi_x (n + phi_(phi_u (0,n)) (x)). $

=== Esempio 2

_Dato un SPA ${phi_i}$, $exists n in NN : phi_n (x) = phi_x (x) + sqrt(phi_(phi_x (n)) (x))$ ?_

Iniziamo la manipolazione: $ phi_n (x) & = phi_n (n) + sqrt(phi_(phi_x (n)) (x)) \ & overset(=, (2)) phi_u (x,n) + sqrt(phi_(phi_u (n,x)) (x)) \ & overset(=, (2)) phi_u (x,n) + sqrt(phi_u (x, phi_u (n,x))) \ & = f(x,n) in cal(P) \ & overset(=, (1)) phi_e (x,n) \ & overset(=, (3)) phi_(S_1^1 (e,n)) (x) $

Siccome $S_1^1 (e,n)$ è ricorsiva totale, il teorema di ricorsione implica l'esistenza di un $n in NN$ che soddisfa l'equazione iniziale.

=== Esercizi

// Secondo me potremmo provare a farli insieme
Dato un spa ${phi_i}, exists n in NN :$
+ $phi_n(x) = phi_x(n) + phi_(phi_x (n)) (n)$;
+ $phi_n(x) = phi_x(x) + n$;
+ $phi_n(x) = phi_x(<n, phi_x (1)>)$;
+ $phi_n(x) = phi_(phi_x (#cantor_sin (n))) (#cantor_des (n))$;
+ $phi_n(x) = n^x + (phi_x (x))^2$;
+ $phi_n(x) = phi_x (n+2) + (phi_(phi_x (n)) (n+3))^2$.