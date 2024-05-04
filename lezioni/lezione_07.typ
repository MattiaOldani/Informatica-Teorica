// Setup

#import "@preview/ouset:0.1.1": overset

#import "alias.typ": *

// Appunti

= Lezione 07

== Aritmetizzazione di un programma

Per verificare che vale $programmi tilde NN$ dobbiamo trovare un modo per codificare i programmi in numeri in modo biunivoco. Notiamo che, data la lista di istruzioni semplici $P equiv istr(1), dots, istr(m)$, se questa fosse codificata come una lista di interi potremmo sfruttare la funzione coppia di Cantor per ottenere un numero associato al programma $P$.

/* Su Godel mettere l'accento, anche nelle lezioni prima */

Quello che dobbiamo fare è trovare una funzione che trasforma le istruzioni in numeri, così da avere poi accesso alla funzione coppia per fare la codifica effettiva. In generale, il processo che associa biunivocamente un numero ad una struttura viene chiamato *aritmetizzazione* o *godelizzazione*.

Troviamo una funzione $ar$ che associ ad ogni istruzione $I_k$ la sua codifica numerica $c_k$. Se la funzione trovata è anche biunivoca siamo sicuri di trovare la sua inversa, ovvero quella funzione che ci permette di ricavare l'istruzione $I_k$ data la sua codifica $c_k$.

Riassumendo quanto detto finora, abbiamo deciso di trasformare ogni lista di istruzioni in una lista di numeri e, successivamente, applicare la funzione coppia di Cantor, ovvero $ [istr(1), dots, istr(n)] arrow.long.squiggly^(ar) [c_1, dots, c_n] arrow.long.squiggly^(<>) n. $ Vorremmo anche ottenere la lista di istruzioni originale data la sua codifica, ovvero $ n arrow.long.squiggly^(<>) [c_1, dots, c_n] arrow.long.squiggly^(ar^(-1)) [istr(1), dots, istr(n)]. $

La nostra funzione _"complessiva"_ è biunivoca se dimostriamo la biunivocità della funzione $ar$, avendo già dimostrato questa proprietà per $<>$. 

Dobbiamo quindi trovare una funzione biunivoca $ar : istruzioni arrow.long NN$ con la sua funzione inversa $ar^(-1) : NN arrow.long istruzioni$ tali che $ ar(I) = n arrow.long.double.l.r ar^(-1)(n) = I. $

Dovendo codificare tre istruzioni nel linguaggio RAM, definiamo la funzione $ar$ tale che: $ ar(I) = cases(3k & "se" I equiv inc(R_k), 3k + 1 & "se" I equiv subsus(R_k), 3 <k\,m> - 1 quad & "se" I equiv ifgoto(R_k, m)) quad . $

Come è fatta l'inversa $ar^(-1)$? In base al modulo tra $n$ e $3$ ottengo una certa istruzione: $ ar^(-1)(n) = cases(inc(R_(n/3)) & "se" n mod 3 = 0, subsus(R_(frac(n-1,3))) & "se" n mod 3 = 1, "IF" R_(cantorsin(frac(n+1,3))) = 0 "THEN GOTO" cantordes(frac(n+1,3)) quad & "se" n mod 3 = 2) quad . $

La codifica del programma $P$ è quindi $ cod(P) = <ar(istr(1)), dots, ar(istr(n))>. $ Per tornare indietro devo prima invertire la funzione coppia di Cantor e poi invertire la funzione $ar$.

La lunghezza del programma $P$, indicata con $|P|$, si calcola come $listlength(cod(P))$.

Abbiamo quindi dimostrato che $programmi tilde NN$.

== Osservazioni

Vediamo una serie di osservazioni importanti:
- avendo $n = cod(P)$ si può scrivere $ phi_P (t) = phi_n (t), $ ovvero la semantica di $P$ è uguale alla semantica della sua codifica;
- i numeri diventano un _linguaggio di programmazione_;
- posso scrivere l'insieme $ F(ram) = {phi_P : P in programmi} $ come $ F(ram) = {phi_i}_(i in NN). $ L'insieme, grazie alla dimostrazione di $programmi tilde NN$, è numerabile;
- ho dimostrato rigorosamente che $ F(ram) tilde NN tilde.not NN_bot^NN, $ quindi anche nel sistema di calcolo RAM esistono funzioni non calcolabili;
- la RAM è troppo elementare affinche $F(ram)$ rappresenti formalmente la "classe dei problemi risolubili automaticamente", quindi considerando un sistema di calcolo $cal(C)$ più sofisticato, ma comunque trattabile rigorosamente come il sistema RAM, potremmo dare un'idea formale di "ciò che è calcolabile automaticamente";
- se riesco a dimostrare che $F(ram) = F(cal(C))$ allora cambiare la tecnologia non cambia ciò che è calcolabile, ovvero la calcolabilità è intrinseca ai problemi, quindi possiamo _"catturarla"_ matematicamente.

== Sistema di calcolo $mwhile$

=== Macchina $mwhile$

La macchina WHILE, come quella RAM, è molto semplice, essendo formata da una serie di *registri*, detti *variabili*. Al contrario delle macchine RAM, questi ultimi non sono _potenzialmente infiniti_, ma sono esattamente $21$. Il registro $R_0$ è il *registro di output*, mentre $R_1$ è il *registro di input*. Inoltre, non esiste il registro del program counter in quanto il linguaggio è _strutturato_ e ogni istruzione di questo linguaggio va eseguita in ordine.

=== Linguaggio $mwhile$

Il linguaggio WHILE prevede una *definizione induttiva*: vengono definiti alcuni comandi base e i comandi più complessi sono una concatenazione dei comandi base.

Il comando di base è l'*assegnamento*. In questo linguaggio ne esistono di tre tipi: $ x_k &:= 0, \ x_k &:= x_j + 1, \ x_k &:= x_j overset(-,.) 1. $ Vediamo come queste istruzioni siamo molto più complete rispetto alle istruzioni RAM $ inc(R_k) \ subsus(R_k) $ in quanto con una sola istruzione possiamo azzerare il valore di una variabile o assegnare ad una variabile il valore di un'altra aumentata/diminuita di $1$.

I comandi "induttivi" sono invece il comando while e il comando composto.

Il *comando while* è un comando nella forma $ comandowhile, $ dove $C$ è detto *corpo* e può essere un assegnamento, un comando while o un comando composto.

Il *comando composto* è un comando nella forma $ composto, $ dove i vari $C_i$ sono, come prima, assegnamenti, comandi while o comandi composti.

Un *programma WHILE* è un comando composto, e l'insieme di tutti i programmi WHILE è l'insieme $ wprogrammi = {programmi "scritti in linguaggio" mwhile}. $

Chiamiamo $ Psi_W : NN arrow NN_bot $ la *semantica* del programma $W in wprogrammi$.

Per dimostrare una proprietà $P$ di un programma $W in wprogrammi$ procederemo induttivamente:
1. dimostro $P$ vera sugli assegnamenti;
2. suppongo $P$ vera sul comando $C$ e la dimostro vera per $comandowhile$;
3. suppongo $P$ vera sui comandi $C_1, dots, C_n$ e la dimostro vera per $composto$.
