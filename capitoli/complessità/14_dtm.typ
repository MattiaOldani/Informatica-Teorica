#import "../alias.typ": *

#import "@preview/algo:0.3.3": algo, i, d, code

// Appunti

== Macchina di Turing determinista (DTM)

Una *macchina di Turing deterministica* è un dispositivo hardware fornito di:
- *nastro di lettura e scrittura*: nastro infinito di celle, ognuna delle quali ha un proprio indice/indirizzo e contiene un simbolo. Questo nastro viene usato come contenitore per l'input, ma anche come memoria durante l'esecuzione;
- *testina di lettura e scrittura two-way*: dispositivo che permette di leggere e scrivere dei simboli sul nastro ad ogni passo;
- *controllo a stati finiti*: automa a stati finiti $Q = {Q_0, dots, Q_n}$ che permette di far evolvere la computazione.

Un passo di calcolo è una *mossa*:

#grid(
  columns: (42.5%, 15%, 42.5%),
  align(right + horizon)[
    Stato corrente\
    Simbolo letto dalla testina
  ],
  align(center + horizon)[
    $overset(arrow.long, "passo")$
  ],
  align(left + horizon)[
    Nuovo stato\
    Simbolo da scrivere\
    Movimento della testina (+1, 0 o -1)
  ]
)

in cui gli elementi di destra vengono calcolati tramite una *funzione di transizione*, basata sugli elementi di sinistra.

=== Definizione informale

Il funzionamento di una DTM $M$ su input $x in Sigma^*$ passa per due fasi:
+ *inizializzazione*:
  - la stringa $x$ viene posta, simbolo dopo simbolo, nelle celle del nastro dalla cella $1$ fino alla cella $|x|$. Le celle dopo quelle che contengono $x$, contengono il simbolo _blank_;
  - la testina si posiziona sulla prima cella;
  - il controllo a stati finiti è posto nello stato iniziale;
+ *computazione*:\
  sequenza di mosse dettata dalla funzione di transizione.

La computazione può andare in loop o arrestarsi se raggiunge una situazione in cui non è definita nessuna mossa per lo stato attuale.\
Diciamo che $M$ accetta $x in Sigma^*$ se $M$ si arresta in uno stato tra quelli finali/accettanti, altrimenti la rifiuta.

Definiamo $L_M = {x in Sigma^* bar.v M "accetta" x}$ il *linguaggio accettato* da $M$.

Le MDT sono macchine perfette per riconoscere i linguaggi.

=== Definizione formale

Una macchina di turing deterministica è una tupla $M = (Q, Sigma, Gamma, delta, q_0, F)$, con:
- $Q arrow$ insieme finito di *stati* assumibili dal controllo a stati finiti;
- $q_0 in Q arrow$: *stato iniziale* da cui partono le computazioni di $M$;
- $F subset.eq Q arrow$: insieme degli *stati finali/accettanti* ove $M$ si arresta accettando l'input;
- $Sigma arrow$: *alfabeto di input* su cui sono definite le stringhe di input;
- $Gamma arrow$: *alfabeto di lavoro* che contiene i simboli che possono essere letti/scritti dal/sul nostro nastro. Vale $Sigma subset Gamma$ perché $Gamma$ contiene il simbolo _blank_;
- $delta : Q times Gamma arrow.bar Q times (Gamma slash {"blank"}) times {-1,0,+1} arrow$ *funzione di transizione* che definisce le mosse. È una _funzione parziale_: quando non è definita la macchina si arresta. Inoltre, $M$ non può scrivere il simbolo _blank_, lo può solo leggere.

Analizziamo nel dettaglio lo sviluppo di una DTM $M$ su input $x in Sigma^*$, visto solo informalmente
- *inizializzazione*:
  - il nastro contiene la stringa $x = x_1 dots x_n$;
  - la testina è posizionata sul carattere $x_1$;
  - il controllo a stati finiti parte dallo stato $q_0$;
- *computazione*: sequenza di mosse definite dalla funzione di transizione $delta$ che mandano, ad ogni passo, da $(q_i,gamma_i)$ a $(q_(i+1), gamma_(i+1), {-1,0,+1})$.

Se $delta(q,gamma) = bot$, la macchina $M$ si _arresta_.\
Quando la testina rimbalza tra due celle o rimane fissa in una sola, si verifica un _loop_.

La macchina $M$ accetta $x in Sigma^*$ se e solo la computazione si arresta in uno stato $q in F$.

Come prima, $L_M = {x in Sigma^* bar.v M "accetta" x}$ è ancora il linguaggio accettato da $M$.

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

La computazione di $M$ su $x in Sigma^*$ è la sequenza: $ C_0 arrow.long^delta C_1 arrow.long^delta dots.c arrow.long^delta C_(i) arrow.long^delta C_(i+1) arrow.long^delta dots.c , $ dove, $forall i gt.eq 0$, vale che da $C_i$ si passa a $C_(i+1)$ grazie alla funzione $delta$.

La macchina $M$ accetta $x in Sigma^*$ se e solo se $C_0 arrow.long^* C_f$, con $C_f$ configurazione d'arresto e accettante.

Il linguaggio accettato da $M$ ha la stessa definizione data prima.

=== Considerazioni

Il fatto che la macchina sia _deterministica_ implica che, data una configurazione $C_i$, quella successiva è univocamente determinata dalla funzione $delta$. Quindi, data una configurazione $C_i$, esiste una sola configurazione $C_(i+1)$ successiva, a meno di arresti.

Nelle *macchine di Turing non deterministiche* NTM, data una configurazione $C_i$, può non essere unica la configurazione successiva, quindi non è determinata univocamente.

Nelle *macchine di Turing probabilistiche* PTM, data una configurazione $C_i$, possono esistere più configurazioni nelle quali possiamo entriamo, ognuna associata a una probabilità $p_i in [0,1]$.

Infine, nelle *macchine di Turing quantistiche* QTM, data una configurazione $C_i$, esistono una serie di configurazioni successive nelle quali possiamo entrare osservando le ampiezze delle transizioni $alpha_i$. Queste ampiezze sono numeri complessi in $CC$ tali che:
- $|alpha_i| lt.eq 1$;
- hanno probabilità $|alpha_i|^2$;
- le probabilità sommano a $1$.

=== Semplificare le DTM

Esibire, progettare e comprendere una DTM è difficile anche in casi molto semplici, perché dobbiamo dettagliare stati, alfabeti, transizioni, eccetera. Solitamente, nel descrivere una DTM, si utilizza uno _pseudocodice_ che ne chiarisce la dinamica.

Esistono una serie di teoremi che dimostrano che qualsiasi frammento di programma strutturato può essere tradotto in una DTM formale e viceversa.

=== Applicazione all'esempio precedente

Nel caso della DTM $M$ che abbiamo progettato per $L_"PARI" = {1 {0,1}^* 0} union {0}$ al punto precedente possiamo utilizzare questo pseudo-codice:

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
