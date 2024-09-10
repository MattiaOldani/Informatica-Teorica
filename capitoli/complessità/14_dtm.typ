#import "@preview/algo:0.3.3": algo, i, d, code

#import "../alias.typ": *


= Macchina di Turing deterministica (DTM)

Il punto di partenza dello studio della teoria della complessità è la definizione rigorosa delle risorse di calcolo e di come possono essere misurate.

Il modello di calcolo che useremo nel nostro studio è la *Macchina di Turing*, ideata da Alan Turing nel 1936. Essa è un modello *teorico* di calcolatore che consente di definire rigorosamente:
- i passi di computazione e la computazione stessa;
- tempo e spazio di calcolo dei programmi;

== Struttura

Una *macchina di Turing deterministica* è un dispositivo hardware fornito di:
- *nastro di lettura e scrittura*: nastro infinito formato da celle, ognuna delle quali ha un proprio indice/indirizzo e contiene un simbolo. Questo nastro viene usato come _contenitore_ per l'input, ma anche come memoria durante l'esecuzione;
- *testina di lettura e scrittura two-way*: dispositivo che permette di leggere e scrivere dei simboli sul nastro ad ogni passo;
- *controllo a stati finiti*: automa a stati finiti $Q = {Q_0, dots, Q_n}$ che permette di far evolvere la computazione.

Un passo di calcolo è una *mossa* che, dato lo stato corrente e il simbolo letto dalla testina, porta la DTM in un nuovo stato, scrivendo eventualmente un simbolo sul nastro e spostando eventualmente la testina. I risultati della mossa, quindi il nuovo stato, il simbolo da scrivere e il movimento della testina vengono calcolati tramite una *funzione di transizione*, basata sui due input dati.

=== Definizione informale

Il funzionamento di una DTM $M$ su input $x in Sigma^*$ passa per due fasi:
+ *inizializzazione*:
  - la stringa $x$ viene posta, simbolo dopo simbolo, nelle celle del nastro dalla cella $1$ fino alla cella $|x|$. Le celle dopo quelle che contengono $x$ contengono il simbolo _blank_;
  - la testina si posiziona sulla prima cella;
  - il controllo a stati finiti è posto nello stato iniziale;
+ *computazione*:\
  - sequenza di mosse dettata dalla funzione di transizione.

La computazione può andare in loop o arrestarsi se raggiunge una situazione in cui non è definita nessuna mossa per lo stato attuale. Diciamo che $M$ accetta $x in Sigma^*$ se $M$ si arresta in uno stato tra quelli finali/accettanti, altrimenti la rifiuta.

Definiamo $L_M = {x in Sigma^* bar.v M "accetta" x}$ il *linguaggio accettato* da $M$.

=== Definizione formale

Una macchina di turing deterministica è una tupla $M = (Q, Sigma, Gamma, delta, q_0, F)$, con:
- $Q$: insieme finito di *stati* assumibili dal controllo a stati finiti;
- $q_0 in Q$: *stato iniziale* da cui partono le computazioni di $M$;
- $F subset.eq Q$: insieme degli *stati finali/accettanti* ove $M$ si arresta accettando l'input;
- $Sigma$: *alfabeto di input* su cui sono definite le stringhe di input;
- $Gamma$: *alfabeto di lavoro* che contiene i simboli che possono essere letti/scritti dal/sul nostro nastro. Vale $Sigma subset Gamma$ perché $Gamma$ contiene il simbolo _blank_;
- $delta : Q times Gamma arrow.long Q times (Gamma slash {"blank"}) times {-1,0,+1}$: *funzione di transizione* che definisce le mosse. È una _funzione parziale_: quando non è definita la macchina si arresta. Inoltre, $M$ non può scrivere il simbolo _blank_, lo può solo leggere.

Analizziamo nel dettaglio lo sviluppo di una DTM $M$ su input $x in Sigma^*$, visto solo informalmente:
- *inizializzazione*:
  - il nastro contiene la stringa $x = x_1 dots x_n$;
  - la testina è posizionata sul carattere $x_1$;
  - il controllo a stati finiti parte dallo stato $q_0$;
- *computazione*: sequenza di mosse definite dalla funzione di transizione $delta$ che manda, ad ogni passo, da $(q_i,gamma_i)$ a $(q_(i+1), gamma_(i+1), {-1,0,+1})$.

Se $delta(q,gamma) = bot$, la macchina $M$ si _arresta_. Quando la testina rimbalza tra due celle o rimane fissa in una sola, si verifica un _loop_. La macchina $M$ accetta $x in Sigma^*$ se e solo la computazione si arresta in uno stato $q in F$.

Come prima, $L_M = {x in Sigma^* bar.v M "accetta" x}$ è ancora il *linguaggio accettato* da $M$.

Queste macchine sono molto simili agli *automi a stati finiti*, seppur con alcune differenze:
- le FSM di default non possono tornare indietro, non sono two-way, ma questa differenza non aumenta la potenza computazionale, serve solo per avere automi più succinti;
- le FSM hanno il nastro a sola lettura, mentre le DTM possono alterare il nastro a disposizione.

=== Configurazione di una DTM

Come per le macchine RAM, proviamo a dare l'idea di *configurazione* delle DTM. Anche qui, possiamo vederla come una foto che descrive completamente $M$ in un certo istante. Questa definizione ci permette di descrivere la computazione come una serie di configurazioni/foto.

Ciò che ci serve ricordare è:
- in che stato siamo;
- in che posizione si trova la testina;
- il contenuto non-blank del nastro.

Definiamo quindi $C = (q,k,w)$ una configurazione con:
- $q$: stato del controllo a stati finiti;
- $k in NN^+$: posizione della testina del nastro;
- $w in Gamma^*$: contenuto non-blank del nastro.

All'inizio della computazione abbiamo la *configurazione iniziale* $C_0 = (q_0, 1, x)$.

Diciamo che una configurazione $C$ è *accettante* se $C = (q in F, k, w)$ ed è *d'arresto* se $C = (q, k, w)$ con $delta(q,w) = bot$.

=== Definizione computazione tramite configurazioni

La computazione di $M$ su $x in Sigma^*$ è la sequenza $ C_0 arrow.long^delta C_1 arrow.long^delta dots.c arrow.long^delta C_(i) arrow.long^delta C_(i+1) arrow.long^delta dots.c , $ dove, $forall i gt.eq 0$, vale che da $C_i$ si passa a $C_(i+1)$ grazie alla funzione $delta$.

La macchina $M$ accetta $x in Sigma^*$ se e solo se $C_0 arrow.long^* C_f$, con $C_f$ configurazione d'arresto e accettante.

Il linguaggio accettato da $M$ ha la stessa definizione data prima.

== Altre versioni delle macchine di Turing

=== Versioni alternative

Il fatto che la macchina sia _deterministica_ implica che, data una configurazione $C_i$, quella successiva è univocamente determinata dalla funzione $delta$. Quindi, data una configurazione $C_i$, esiste una sola configurazione $C_(i+1)$ successiva, a meno di arresti.

Nelle *macchine di Turing non deterministiche* NDTM, data una configurazione $C_i$, può non essere unica la configurazione successiva, quindi non è determinata univocamente.

Nelle *macchine di Turing probabilistiche* PTM, data una configurazione $C_i$, possono esistere più configurazioni nelle quali possiamo entriamo, ognuna associata a una probabilità $p_i in [0,1]$.

Infine, nelle *macchine di Turing quantistiche* QTM, data una configurazione $C_i$, esistono una serie di configurazioni successive nelle quali possiamo entrare osservando le ampiezze delle transizioni $alpha_i$. Queste ampiezze sono numeri complessi in $CC$ tali che:
- $|alpha_i| lt.eq 1$;
- hanno probabilità $|alpha_i|^2$;
- le probabilità sommano a $1$.

=== Versione semplificata

Esibire, progettare e comprendere una DTM è difficile anche in casi molto semplici, perché dobbiamo dettagliare stati, alfabeti, transizioni, eccetera. Solitamente, nel descrivere una DTM, si utilizza uno _pseudocodice_ che ne chiarisce la dinamica.

Esistono una serie di teoremi che dimostrano che qualsiasi frammento di programma strutturato può essere tradotto in una DTM formale e viceversa.

=== Esempio: parità

- Nome: parità.
- Istanza: $x in NN$.
- Domanda: $x$ è pari?

Come codifica utilizziamo quella _binaria_, ovvero $ cod : NN arrow.long {0,1}^* . $ Di conseguenza, il linguaggio da riconoscere è $ L_"PARI" = {x in {0,1}^* bar.v x_1 = 1 and x_(|x|) = 0} union {0}. $

Risolvere il problema _parità_ significa trovare una DTM $M$ che sia un algoritmo deterministico che riconosce proprio $L_"PARI"$.

Ricordando che $M = (Q, Sigma, Gamma, delta, q_0, F)$, la seguente macchina riconosce $L_"PARI"$:
- $Q = {p, z_1, mu, z, r}$ insieme degli stati;
- $Sigma = {0, 1}$ alfabeto;
- $Gamma = {0, 1, blank}$ alfabeto di lavoro;
- $q_0 = p$ stato iniziale;
- $F = {z_1, z}$ insiemi degli stati finali;
- $delta : Q times Gamma arrow.long Q times Sigma times {-1, 0, 1}$ funzione di transizione così definita:

#align(center)[
  #table(
    columns: (25%, 25%, 25%, 25%),
    inset: 10pt,
    align: horizon,
    
    [$delta$], [$blank$], [$0$], [$1$],
    
    [$p$], [$bot$], [$(z_1, 0, +1)$], [$(mu, 1, +1)$],
    [$z_1$], [$bot$], [$(r, 0, +1)$], [$(mu, 1, +1)$],
    [$mu$], [$bot$], [$(z, 0, +1)$], [$(mu, 1, +1)$],
    [$z$], [$bot$], [$(z, 0, +1)$], [$(mu, 1, +1)$],
    [$r$], [$bot$], [$bot$], [$bot$],
  )
]

Notiamo come, anche per un problema così semplice, abbiamo una funzione di transizione abbastanza complicata. Andiamo quindi a utilizzare uno pseudocodice:

#algo(
  title: "Parità",
  parameters: ("n",)
)[
  i := 1; \
  f := false; \
  switch(x[i]) { #i \
    case 0: #i \
      i++; \
      f := (x[i] == blank); \
      break; #d \
    case 1: #i \
      do { #i \
        f := (x[i] == 0); \
        i++; #d \
      } while (x[i] != blank); #d #d \
  } \
  return f;
]

Alla fine della sua esecuzione avremo:
- se $x in L_"PARI"$ allora #text(green)[True] ;
- se $x in.not L_"PARI"$ allora #text(red)[False] .
