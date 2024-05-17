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

#import "alias.typ": *

// Appunti

= Lezione 18

== Teoria della complessità

=== Complessità vs calcolabilità

Dato un problema $P$, finora ci siamo chiesti _"*esiste* un programma per la sua soluzione automatica?"_\
Tramite questa domanda abbiamo potuto indagare la *teoria della calcolabilità*, il cui oggetto di studio è l'esistenza (o meno) di un programma per un dato problema.

In questa parte del corso, studieremo la *teoria della complessità*, in cui entra in gioco una seconda investigazione: _"*come* funzionano i programmi per P?"_\
Per rispondere a questa domanda, vogliamo sapere quante *risorse computazionali* utilizziamo durante la sua esecuzione.

Definiamo _risorse computazionali_ qualsiasi risorsa venga utilizzata durante il processo di calcolo, ad esempio:
- elettricità;
- numero di processori in un sistema parallelo;
- numero di entanglement in un sistema quantistico.

Le risorse principali che consideriamo per un sistema di calcolo mono-processore sono  *tempo* e *spazio di memoria*.

=== Domande Teoria della Complessità

Vediamo alcune domande a cui la teoria della complessità cerca di rispondere:
- dato un programma per il problema $P$, quanto tempo impiega il programma nella sua soluzione? Quanto spazio di memoria occupa?
- dato un problema $P$, qual è il minimo tempo impiegato dai programmi per $P$? Quanto spazio in memoria al minimo posso occupare per programmi per $P$?
- in che senso possiamo dire che un programma è *efficiente* in termini di tempo e/o spazio?
- quali problemi possono essere efficientemente risolti per via automatica? $arrow$ _versione quantitativa_ della tesi di Church-Turing.

=== Risorse computazionali

Il punto di partenza dello studio della teoria della complessità è la definizione rigorosa delle risorse di calcolo e di come possono essere misurate.

Il modello di calcolo che useremo nel nostro studio è la *Macchina di Turing*, ideata da Alan Turing nel 1936.\
Essa è un modello *teorico* di calcolatore che consente di definire rigorosamente:
- i passi di computazione e la computazione stessa;
- tempo e spazio di calcolo dei programmi;

Di conseguenza, ci fornisce strumenti matematici per:
- misurare tempo e spazio di calcolo;
- definire il concetto di _efficiente in tempo e/o spazio_;
- caratterizzare i problemi che hanno soluzione automatica efficiente, quindi vedere quali problemi aderiscono alla *tesi di Church-Turing ristretta*.

== Richiami di teoria dei linguaggi formali

Prima di iniziare il nostro studio, richiamiamo alcuni concetti della teoria dei linguaggi formali.

Un *alfabeto* è un insieme finito di simboli $Sigma = {sigma_1, dots, sigma_k}$. Un alfabeto binario è un qualsiasi alfabeto composto da due soli simboli.

Una *stringa* su $Sigma$ è una sequenza di simboli di $Sigma$ nella forma $x = x_1 space dots space x_n$, con $x_i in Sigma$.\
La *lunghezza* di una stringa $x$ indica il numero di simboli che la costituiscono e si indica con $|x|$.\
Una stringa particolare è la *stringa nulla*, che si indica con $epsilon$ ed è tale che $|epsilon| = 0$.

Indichiamo con $Sigma^*$ l'insieme delle stringhe che si possono costruire sull'alfabeto $Sigma$, compresa la stringa nulla. L'insieme delle stringhe formate da almeno un carattere è definito da $Sigma^+ = Sigma^* \/ {epsilon}$.

Un *linguaggio* $L$ su un alfabeto $Sigma$ è un sottoinsieme $L subset.eq Sigma^*$, che può essere finito o infinito.

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

=== Funzionalità di una DTM

- La principale funzionalità di una DTM è *riconoscere linguaggi*.\
  Un linguaggio $L subset.eq Sigma^*$ è *riconoscibile* da una DTM se e solo se esiste una DTM $M$ tale che $L = L_M$.

  Grazie alla possibilità di riconoscere linguaggi, una DTM può riconoscere anche gli insiemi: dato $A subset.eq NN$, _come lo riconosco con una DTM?_\
  L'idea che viene in mente è di codificare ogni elemento $a in A$ in un elemento di $Sigma^*$, per poter passare dal riconoscimento di un insieme al riconoscimento di un linguaggio.

  #align(
    center + horizon
  )[
    $A arrow.long.squiggly #square(cod) arrow.long.squiggly L_A = {cod(a) : a in A}$
  ]


  Un insieme $A$ è riconoscibile da una DTM sse esiste una DTM $M$ tale che $L_A = L_M$.

  Quando facciamo riconoscere un insieme $A$ a una DTM $M$, possiamo trovarci in due situazioni, in funzione dell'input (codificato):
  + se l'input appartiene ad $A$, allora $M$ si arresta;
  + se l'input _non_ appartiene ad $A$, allora $M$ può:
    - arrestarsi rifiutando l'input, ovvero finisce in uno stato $q in.not F arrow.double A$ è ricorsivo;
    - andare in loop $arrow.double A$ è ricorsivamente numerabile.

  #theorem(
    numbering: none
  )[
    La classe degli insiemi riconosciuti da DTM coincide con la classe degli insiemi ricorsivamente numerabili.
  ]

  Un *algoritmo deterministico* per il riconoscimento di un insieme $A subset.eq NN$ è una DTM $M$ tale che $L_A = L_M$ e tale che $M$ si arresta su ogni input.

  #theorem(
    numbering: none
  )[
    La classe degli insiemi riconosciuti da algoritmi deterministici coincide con la classe degli insiemi ricorsivi.
  ]

- Una seconda funzionalità delle DTM è che possono risolvere dei *problemi di decisione*. Vediamo il procedimento per farlo.

  Dato problema $Pi$, con istanza $x in D$ e domanda $p(x)$, andiamo a codificare gli elementi di $D$ in elementi di $Sigma^*$, ottenendo $L_Pi = {cod(x) bar.v x in D and p(x)}$ *insieme delle istanze a risposta positiva* di $Pi$.

  La DTM risolve $Pi$ sse $M$ è un algoritmo deterministico per $L_Pi$, ovvero:
  - se vale $p(x)$, allora $M$ accetta la codifica di $x$;
  - se non vale $p(x)$, allora $M$ si arresta senza accettare.
