// Setup

#import "@preview/algo:0.3.3": algo, i, d

#import "alias.typ": *

// Appunti

= Lezione 21

== Spazio di memoria

Veniamo ora alla formalizzazione dell'altra importante risorsa di calcolo, ovvero lo _spazio di memoria_, inteso come quantità di memoria occupata durante la computazione.

=== Complessità in spazio (1)

Data la DTM $M = (Q, Sigma, Gamma, delta, q_0, F)$ ed una stringa $x in Sigma^*$, chiamiamo $S(x)$ il numero di celle del nastro occupate (quindi, visitate) durante la computazione di $M$ su $x$.\
La *complessità in spazio* di $M$ (nel caso peggiore) è la funzione $s : NN arrow NN$ definita come $ s(n) = max{S(x) : x in Sigma^* and |x| = n}. $

Da questa definizione è chiaro che, in ogni MDT, $s(n) gt.eq n$, in quanto dovrò sempre occupare almeno spazio lineare per mantenere l'input sul nastro.

_Come non considerare l'interferenza dovuta all'input?_\
Per avere complessità anche sub-lineari, potremmo modificare leggermente la macchina e utilizzare due nastri diversi per la lettura e per la computazione:
- il nastro di lettura può essere solo letto dalla testina e serve a scandire l'input;
- il nastro di lavoro può essere sia letto che modificato.

La definizione formale di questa nuova macchina è pressoché identica $ M = (Q, Sigma union {¢, \$}, Gamma, delta, q_0, F), $ in cui tutto è analogo alle macchine di Turing viste finora, tranne per:
- ¢, \$ $arrow$ simboli che serviranno a indicare inizio e fine input sul nastro di lettura;
- $delta arrow$ la funzione di transizione deve adeguarsi al nastro aggiunto e prevedere una variabile in più in ingresso e una in più in uscita: $ delta : Q times (Sigma union {¢, \$}) times Gamma arrow Q times (Gamma without {blank}) times {-1, 0, 1}^2 $
  in cui $M$:
  + legge un simbolo sia dal nastro di input sia dal nastro di lavoro;
  + modifica il nastro di lavoro;
  + comanda il moto delle due testine.

// gigi: se vuoi mettere una foto di una dtm di questo tipo, scrivimi. per me non è necessaria e ora come aggiungerla lascerebbe un sacco di spazio bianco nella prima pagina.

Anche la definizione di configurazione e computazione vanno leggermente modificate:
- una #underline("configurazione") per $M$ è una 4-tupla $c = angle.l q, i, j, w angle.r$ in cui $q$ è lo stato del controllo, $i(j')$ sono la posizione della testina sul nastro di input (lavoro) e $w$ è il contenuto non blank del nastro di lavoro.

=== Complessità in spazio (2)

A questo punto possiamo ridefinire la complessità in spazio per le nuove macchine di Turing.

Per ogni stringa $x in Sigma^*, S(x)$ è ora dato dal numero di celle _del solo nastro di lavoro_, visitate da $M$ durante la computazione di $x$.\
Dunque, la *complessità in spazio deterministica* $s(n)$ di $M$ è da intendersi come il massimo numero di celle visitate nel nastro di lavoro durante la computazione di stringhe di lunghezza $n$.

=== Complessità in spazio di linguaggi

Il linguaggio $L subset.eq Sigma^*$ è riconosciuto in spazio *deterministico* $f(n)$ sse esiste una DTM $M$ tale che:
+ $L = L_M$;
+ $s(n) lt.eq f(n)$.
Sfruttando questa definizione, possiamo ovviamente definire la complessità in spazio per il riconoscimento di insiemi e per la funzione soluzione di problemi di decisione.

==== Calcolo di funzioni

Per il caso specifico del calcolo di funzioni, solitamente si considera una terza macchina di Turing, in cui è presente un altro nastro dedicato alla sola scrittura dell'output della funzione da calcolare.

Diremo che una funzione $f : Sigma^* arrow Gamma^*$ è calcolabile dalla DTM $M$ sse:
- $f(x) arrow.b$ : la computazione di $M$ su $x$ termina con $f(x)$ sul nastro di output;
- $f(x) arrow.t$ : la computazione di $M$ su $x$ va in loop.

Inoltre, diremo che la funzione $f : Sigma^* arrow Gamma^*$ viene calcolata con *complessità in spazio $t(n)$* dalla DTM $M$ sse _su ogni input $x$ di lunghezza $n$_, la computazione di $M$ occupa non più di $t(n)$ celle dal nastro di lavoro $arrow$ vogliamo misurare solo lo spazio di lavoro.

=== Classi di complessità

Per ogni funzione $f : NN arrow NN,$ $ dspace(f(n)) $ è la classe dei linguaggi accettati in spazio deterministico $O(s(n))$.

Chiamiamo, invece, $ fspace(f(n)) $ l'insieme delle funzioni calcolate da DTM in spazio $O(f(n))$.

Notiamo che le classi $dspace$ e $fspace$ *non* cambiano se aggiungiamo alle nostre DTM un numero costante di nastri di lavoro.

=== Esempio: Parità

Data una DTM $M$ per il linguaggio $L_"PARI" = 1 {0,1}^* 0 union 0$:

#algo(
  title: "Parità",
  parameters: ("x",),
  breakable: true
)[
  i := 1;\
  f := false;\
  switch(x[i]) {#i\
    case 0:#i\
      i++;\
      f := (x[i] == blank);\
      break;#d\
    case 1:#i\
      do {#i\
        i++;\
        f := (x[i] == 0);#d\
      } while (x[i] != blank);#d#d\
  }\
  return f;
]

Abbiamo già visto che $L_"PARI" in dtime(n)$. _E lo spazio?_\
A dire il vero, non viene occupato spazio, in quanto tutto può essere fatto usando solamente gli stati. Infatti, $L_"PARI"$ è un linguaggio *regolare* e si può dimostrare che $ "REG" = dspace(1). $

=== Esempio: Palindrome

Consideriamo $L_"PAL" = {x in Sigma^* : x = x^R}$ già considerato precedentemente. Avevamo visto che una DTM per questo linguaggio è $M$ così definita:

#algo(
  title: "Palindrome",
  parameters: ("x",)
)[
  i := 1;\
  j := n;\
  f := true;\
  while(i < j && f) {#i\
    if (x[i] != x[j])#i\
      f := false;#d\
    i++;\
    j--;#d\
  }\
  return f;
]

Sappiamo già che, per quanto riguarda il #underline("tempo"), $t(n) = O(n^2)$.\
Per quanto riguarda lo #underline("spazio"), invece, dobbiamo cercare di capire che valori possono assumere i numeri che scriviamo durante la computazione. Tra $i$ e $j$, il numero più grande è sempre $j$, che al massimo vale $n$, di conseguenza il numero di celle di cui abbiamo bisogno è il numero di bit necessari a rappresentare $n arrow.double.long s(n) = O(log n)$.

_Possiamo essere più veloci?_\
Un algoritmo più "veloce" di quello che abbiamo visto, è il seguente:

#align(center)[
  #table(
    columns: (50%, 25%, 25%),
    inset: 10pt,
    align: horizon,
    
    [*Istruzione*], [*Tempo*], [*Spazio*],

    [Copia la stringa di input sul nastro di lavoro], [$n$], [$n$],
    [Sposta la testina del nastro di input in prima posizione (quella del nastro di lavoro sarà alla fine)], [$n$], [-],
    [Confronta i due caratteri, avanzando al testina di input e retrocedendo quella di lavoro], [$n$], [-],
    [Accetta se tutti i confronti tornano, altrimenti rifiuta], [$t(n) = O(n)$], [$s(n) = O(n)$]
  )
]

Questo ci mostra come abbiamo avuto un gran miglioramento per la risorsa tempo, a discapito della risorsa spazio. 

Spesso (e non sempre) migliorare una risorsa porta al peggioramento di un'altra.