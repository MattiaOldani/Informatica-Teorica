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

Dato un problema $P$, finora ci siamo chiesti _"siamo in grado di scrivere un programma per la sua soluzione automatica?"_ 

Questo è il quesito fondamentale della *teoria della calcolabilità*, il poter scrivere o meno un programma per un dato problema.

Nella *teoria della complessità* entra in gioco un'altra investigazione: _"come funzionano i programmi per P?"_

Quello che vogliamo sapere è quante *risorse computazionali* consumiamo.

Con _risorse computazionali_ intendiamo qualsiasi risorsa si consumi durante il processo di calcolo, ad esempio:
- elettricità;
- numero di processori in un sistema parallelo;
- numero di entanglement in un sistema quantistico.

Su un sistema di calcolo monoprocessore prendiamo in considerazione *tempo* e *spazio di memoria*.

=== Domande della teoria della complessità

La teoria della complessità cerca risposte ad alcune domande:
- dato un programma per il problema $P$, quanto tempo impiega il programma nella sua soluzione? Quanto spazio in memoria occupa?
- dato un problema $P$, qual è il minimo tempo impiegato dai programmi per $P$? Quanto spazio in memoria al minimo posso occupare per programmi per $P$?
- in che senso possiamo dire che un programma è *efficiente* in termini di tempo e/o spazio?
- quali problemi possono essere efficientemente risolti per via automatica?

L'ultima domanda la possiamo vedere come la _versione quantitativa_ della tesi di Church-Turing.

== Risorse computazionali

Il punto iniziale fondamentale nella teoria della complessità è la definizione rigorosa delle risorse di calcolo e di come le possiamo misurare.

// Sistemare sta parte, non mi piace molto
Usiamo come modello di calcolo la *Macchina di Turing*, ideata da Alan Turing nel 1936. Essa è un *modello teorico di calcolatore* che consente di definire rigorosamente:
- i passo di computazione e la computazione stessa;
- tempo e spazio di calcolo dei programmi;
e che quindi contente l'uso di strumenti matematici per:
- misurare tempo e spazio di calcolo;
- definire il concetto di _efficiente in tempo e spazio_;
- caratterizzare i problemi che hanno soluzione automatica efficiente, ovvero vedere quali problemi aderiscono alla *tesi di Church-Turing ristretta*.

== Richiami di teoria dei linguaggi formali

Facciamo un breve richiamo sulla teoria dei linguaggi formali.

Un *alfabeto* è un insieme finito di simboli $Sigma = {sigma_1, dots, sigma_k}$.

Una *stringa* su $Sigma$ è una sequenza di simboli di $Sigma$ nella forma $x = x_1 dots x_n$, con $x_i in Sigma$.

La *lunghezza* di una stringa $x$ indica il numero di simbolo che la costituiscono ed si indica con $|x|$.

Una stringa particolare è la *stringa nulla*: si indica con $epsilon$ ed è tale che $|epsilon| = 0$.

Indichiamo con $Sigma^*$ l'insieme delle stringhe che si possono costruire sull'alfabeto $Sigma$, compresa la stringa nulla. Se vogliamo l'insieme delle stringhe formate da almeno un carattere definiamo l'insieme $Sigma^+ = Sigma^* \/ {epsilon}$.

Un *linguaggio* $L$ su $Sigma$ è un sottoinsieme $L subset.eq Sigma^*$ che può essere finito o infinito.

== Macchina di Turing determinista (DTM)

=== Introduzione

Una *macchina di Turing deterministica* è un dispositivo hardware fornito di:
- *nastro di lettura e scrittura*: insieme infinito (a destra) di celle, ognuna delle quali ha un proprio indice/indirizzo e contiene un simbolo. Questo nastro lo usiamo come contenitore per l'input ma anche come memoria;
- *testina di lettura e scrittura two-way*: dispositivo che permette di leggere e scrivere dei simboli sul nastro ad ogni passo;
- *controllo a stati finiti*: dispositivo che si può trovare in un insieme finito di stati $Q = {Q_0, dots, Q_n}$ che permette l'evoluzione della computazione.

Un *passo di calcolo* è una _mossa_: dati lo _stato corrente_ e il _simbolo letto dalla testina_, con un _insieme di regole_ definite nella *funzione di transizione* si calcola il _nuovo stato_, il _simbolo da scrivere nella cella indicata dalla testina_ e il _movimento della testina_ come +1, 0 o -1.

=== Definizione informale

Il funzionamento di una DTM $M$ su input $x in Sigma^*$ passa per due fasi:
+ *inizializzazione*:
  - la stringa $x$ viene posta simbolo dopo simbolo nelle celle del nastro dalla cella $1$ fino alla cella $|x|$. Le celle dopo quelle che contengono $x$ contengono il singolo _blank_;
  - la testina si posiziona sulla prima cella;
  - il controllo a stati finiti è posto nello stato iniziale;
+ *computazione*: sequenza di mosse dettata dalla funzione di transizione.

La computazione può andare in loop o arrestarsi se raggiunge una situazione in cui la mossa non è definita. $M$ accetta $x in Sigma^*$ se $M$ si arresta in uno stato tra quelli finali/accettanti, altrimenti la rifiuta.

Definiamo $L_M = {x in Sigma^* bar.v M "accetta" x}$ il *linguaggio accettato* da $M$.

Le MDT sono macchine perfette per riconoscere i linguaggi.

=== Definizione formale

Una macchina di turing deterministica è una tupla $M = (Q, Sigma, Gamma, delta, q_0, F)$, con:
- $Q$ insieme finito di *stati* assumibili dal controllo a stati finiti;
- $q_0 in Q$ *stato iniziale* da cui partono le computazioni;
- $F subset.eq Q$ insieme degli *stati finali/accettanti* ove $M$ si arresta accettando l'input;
- $Sigma$ *alfabeto di input* su cui sono definite le stringhe di input;
- $Gamma$ *alfabeto di lavoro* che contiene i simboli che possono essere letti/scritti dal/sul nostro nastro. Vale $Sigma subset Gamma$ perché $Gamma$ contiene il simbolo _blank_;
- $delta : Q times Gamma arrow.long Q times (Gamma \/ {"blank"}) times {-1,0,+1}$ *funzione di transizione* che definisce le mosse. È una _funzione parziale_: quando non è definita la macchina si arresta. Inoltre, $M$ non può scrivere il simbolo _blank_, lo può solo leggere.

Il funzionamento di una DTM $M$ su input $x in Sigma^*$ passa, anche qui, per due fasi:
- *inizializzazione*:
  - come prima, il nastro contiene la stringa $x = x_1 dots x_n$;
  - la testina è su posizionata sul carattere $x_1$;
  - il controllo a stati finiti parte dallo stato $q_0$;
- *computazione*: sequenza di mosse dettate dalla funzione di transizione $delta$ che mi mandano, ad ogni passo, da $(q_i,gamma_i)$ a $(q_(i+1), gamma_(i+1), {-1,0,+1})$.

Se $delta(q,gamma) = bot$ allora la macchina $M$ si arresta. L'altra situazione possibile è il loop, quando ad esempio la testina rimbalza tra due celle oppure rimane fissa in una cella.

La macchina $M$ accetta $x in Sigma^*$ se e solo la computazione si arresta in uno stato $q in F$.

Come prima, $L_M = {x in Sigma^* bar.v M "accetta" x}$ è ancora il linguaggio accettato da $M$.

Queste macchine sono molto simili agli *automi a stati finiti*, ma hanno alcune differenze:
- le FSM di default non possono tornare indietro, non sono two-way, ma questa differenza è minima perché non aumenta la potenza, serve solo per avere automi più succinti;
- le FSM hanno il nastro a sola lettura, mentre le DTM possono alterare il nastro a disposizione.

=== Definizione con le configurazioni

Come per le macchine RAM, proviamo a dare l'idea di *configurazione istantanea*. La possiamo vedere come una foto che descrive completamente la macchina $M$ in un certo istante. Questa definizione ci permette di definire la computazione come una serie di configurazioni/foto.

I tre dati che salviamo sono:
- in che stato siamo;
- in che posizione si trova la testina;
- il contenuto _non blank_ del nastro.

Definiamo quindi $C = (q,k,w)$ una configurazione con:
- $q$ stato del controllo a stati finiti;
- $k in NN^+$ posizione della testina del nastro;
- $w in Gamma^*$ contenuto non blank del nastro.

All'inizio della computazione abbiamo la *configurazione iniziale* $C_0 = (q_0, 1, x)$.

Una configurazione $C$ è *accettante* se $C = (q in F, k, w)$, mentre è *d'arresto* se $C = (q, k, w)$ con $delta(q,w) = bot$.

La computazione di $M$ su $x in Sigma^*$ è la sequenza $ C_0 arrow.long^delta C_1 arrow.long^delta dots.c arrow.long^delta C_(i) arrow.long^delta C_(i+1) arrow.long^delta dots.c , $ dove $forall i gt.eq 0$ vale che da $C_i$ si passa a $C_(i+1)$ grazie alla funzione $delta$.

La macchina $M$ accetta $x in Sigma^*$ se e solo se $C_0 arrow.long^* C_f$, con $C_f$ configurazione d'arresto e accettante.

Il linguaggio accettato da $M$ ha la stessa definizione data prima.

=== Considerazioni

L'attributo _deterministico_ descrive il fatto che, data una configurazione $C_i$, quella successiva è univocamente determinata dalla funzione $delta$. In poche parole, data una certa configurazione $C_i$ esiste una sola configurazione $C_(i+1)$ successiva, a meno di arresti.

Nelle NTM *macchine di Turing non deterministiche* data una configurazione $C_i$ possono esistere più configurazioni successive, quindi non è determinata univocamente la successiva configurazione.

Nelle PTM *macchine di Turing probabilistiche* data una configurazione $C_i$ esistono una serie di configurazioni successive nelle quali entriamo con una certa probabilità $p_i in [0,1]$. Ovviamente, le probabilità $p_i$ sommano a $1$.

Infine, nelle QTM *macchine di Turing quantistiche* data una configurazione $C_i$ esistono una serie di configurazioni successive nelle quali entriamo osservando le ampiezze delle transizioni $alpha_i$. Queste ampiezze sono numeri complessi in $CC$ tali che:
- $|alpha_i| lt.eq 1$;
- hanno probabilità $|alpha_i|^2$;
- le probabilità sommano a $1$.

=== Funzionalità di una DTM

La principale funzionalità di una DTM è *riconoscere linguaggi*. Un linguaggio $L subset.eq Sigma^*$ è *riconoscibile* da una DTM se e solo se esiste una DTM $M$ tale che $L = L_M$.

In realtà una DTM può riconoscere anche gli insiemi: dato $A subset.eq NN$ come lo riconosco con una DTM?

L'idea che viene in mente è *codificare* ogni elemento $a in A$ in un elemento di $Sigma^*$ per passare dal riconoscimento di un insieme al riconoscimento di un linguaggio, che una DTM sa fare.

Un insieme $A$ è riconoscibile da una DTM se esiste una DTM $M$ tale che $L_A = L_M$.

Come avviene il riconoscimento di $A$ da parte della DTM $M$?

Abbiamo due situazioni:
+ se alla macchina viene dato un input (_codificato_) in $A$ allora essa si arresta;
+ se alla macchina viene dato un input (_codificato_) _non_ in $A$ allora essa può:
  - arrestarsi rifiutando l'input, ovvero finisce in uno stato $q in.not F$;
  - andare in loop.

Possiamo chiederci quale sia la *potenza di riconoscimento di insiemi* di una DTM.

#theorem(
  numbering: none
)[
  La classe degli insiemi riconosciuti da DTM coincide con la classe degli insiemi ricorsivamente numerabili.
]

Definiamo *algoritmo deterministico* per il riconoscimento di un insieme $A subset.eq NN$ una DTM $M$ tale che $L_A = L_M$ e tale che $M$ si arresta su ogni input.

#theorem(
  numbering: none
)[
  La classe degli insiemi riconosciuti da algoritmi deterministici coincide con la classe degli insiemi ricorsivi.
]

Una DTM può anche risolvere dei *problemi di decisione*.

Infatti, dato
- Nome: $Pi$.
- Istanza: $x in D$.
- Domanda: $p(x)$.

Come prima, andiamo a codificare gli elementi di $D$ in elementi di $Sigma^*$, ottenendo $L_Pi = {cod(x) bar.v x in D and p(x)}$ *insieme delle istanze a risposta positiva* di $Pi$.

La DTM risolve $Pi$ se e solo se $M$ è un algoritmo deterministico per $L_Pi$, ovvero:
- se vale $p(x)$ allora $M$ accetta la codifica di $x$;
- se non vale $p(x)$ allora $M$ si arresta senza accettare.
