#import "../alias.typ": *


= Sistemi di calcolo

Quello che faremo ora è modellare _teoricamente_ un sistema di calcolo.

Un *sistema di calcolo* lo possiamo vedere come una _black-box_ che prende in input un programma $P$, dei dati $x$ e calcola il risultato $y$ di $P$ su input $x$. La macchina ci restituisce $y$ se è riuscita a calcolare un risultato, $bot$ se è entrata in un loop.

#v(12pt)

#figure(
  image("assets/architettura-von-neumann.svg", width: 20%)
)

#v(12pt)

Quindi, formalmente, un sistema di calcolo è una funzione del tipo: $ cal(C) : programmi times dati arrow.long dati_bot. $

Come vediamo, è molto simile ad una funzione di valutazione:
- i dati $x$ corrispondono all'input $a$;
- il programma $P$ corrisponde alla funzione $f$.

Per fare ciò ci serve prima definire cos'è un programma.

Un *programma* $P$ è una *sequenza di regole* che trasformano un dato di input in uno di output (o in un loop). Formalmente, un programma è una funzione $ P : dati arrow.long dati_bot, $ cioè una funzione che appartiene all'insieme $dati_bot^dati$.

Con questa definizione riusciamo a mappare l'insieme $programmi$ sull'insieme delle funzioni, passo che ci serviva per definire la funzione di valutazione.

Riprendendo la definizione di sistema di calcolo, possiamo dire che esso è la funzione $ cal(C) : dati_bot^dati times dati arrow.long dati. $

Con $cal(C)(P,x)$ indichiamo la funzione calcolata da $P$ su $x$ dal sistema di calcolo $cal(C)$, che viene detta *semantica*, il suo "significato" su input $x$.

Il modello classico che viene considerato quando si parla di calcolatori è quello di *Von Neumann*.

== Potenza computazionale

Prima di definire cosa sia la potenza computazionale, facciamo una breve premessa: indichiamo con $ cal(C)(P,\_): dati arrow.long dati_bot $ la funzione che viene calcolata dal programma $P$, ovvero la semantica di $P$.

Detto ciò, definiamo la *potenza computazionale* di un calcolatore come l'insieme di tutte le funzioni che quel sistema di calcolo può calcolare grazie ai programmi, ovvero: $ F(cal(C)) = { cal(C)(P, \_) bar.v P in programmi } subset.eq dati_bot^dati. $

In altre parole, $F(cal(C))$ rappresenta l'insieme di tutte le possibili semantiche di funzioni che sono calcolabili con il sistema $cal(C)$.

Stabilire _che cosa può fare l'informatica_ equivale a studiare quest'ultima inclusione. In particolare:
- se $F(cal(C)) subset.neq dati_bot^dati$ allora esistono compiti *non automatizzabili*;
- se $F(cal(C)) = dati_bot^dati$ allora l'informatica _può fare tutto_.

Se ci trovassimo nella prima situazione vorremmo trovare un modo per delineare un confine che divida le funzioni calcolabili da quelle che non lo sono.

Risolvere un problema equivale a calcolare una funzione: ad ogni problema è possibile associare una *funzione soluzione*, che mi permette di risolverlo automaticamente. Grazie a questa definizione, *calcolare le funzioni equivale a risolvere problemi*.

_In che modo possiamo risolvere l'inclusione?_

Un approccio sfrutta la *cardinalità* dei due insiemi. Con _cardinalità_ si intende una funzione che associa ad ogni insieme il numero di elementi che contiene.

Sembra un ottimo approccio, ma presenta alcuni problemi: infatti, funziona solo quando l'insieme è finito, mentre è molto fragile quando si parla di insiemi infiniti.

Ad esempio, gli insiemi $NN$ dei numeri naturali e $PP$ dei numeri naturali pari sono tali che $PP subset.neq NN$, ma hanno cardinalità $|NN| = |PP| = infinity$.

Ci serve dare una definizione diversa di cardinalità, visto che possono esistere "_infiniti più fitti/densi di altri_", come abbiamo visto nell'esempio precedente.
