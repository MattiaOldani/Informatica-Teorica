#import "../alias.typ": *
#import "@preview/algo:0.3.3": algo, i, d

== Spazio di memoria

Veniamo ora alla formalizzazione dell'altra importante risorsa di calcolo, ovvero lo *spazio di memoria*, inteso come quantità di memoria occupata durante la computazione.

=== Complessità in spazio (1)

Data la DTM $M = (Q, Sigma, Gamma, delta, q_0, F)$ ed una stringa $x in Sigma^*$, chiamiamo $S(x)$ il numero di celle del nastro occupate (visitate, _sporcate_) durante la computazione di $M$ su $x$. Questo numero potrebbe anche essere _infinito_.

La *complessità in spazio* di $M$ (_worst case_) è la funzione $s : NN arrow.long NN$ definita come $ s(n) = max{S(x) bar.v x in Sigma^* and |x| = n}. $

Da questa definizione è chiaro che, in ogni MDT, $s(n) gt.eq n$ in quanto dovrò sempre occupare almeno spazio $n$ lineare per mantenere l'input sul nastro, ma è molto probabile che le celle effettive che _sporco_ sono molte meno delle celle occupate dall'input.

_Come non considerare l'interferenza dovuta all'input?_

Per avere complessità anche sublineari, potremmo modificare leggermente la macchina e separare le operazioni del nastro, ovvero utilizzare due nastri diversi per la lettura e per la computazione:
- il *nastro di lettura* è read-only con testina two-way read-only;
- il *nastro di lavoro* è invece read-write con testina read-write.

#v(12pt)

#figure(
  image("assets/dtm-doppio-nastro.svg", width: 65%)
)

#v(12pt)

La stringa in input è delimitata dai caratteri $cent$ e $\$$ tali che $cent,\$ in.not Sigma$.

La definizione formale di questa nuova macchina è $ M = (Q, Sigma union {cent, \$}, Gamma, delta, q_0, F), $ in cui tutto è analogo alle macchine di Turing viste finora, tranne per la funzione di transizione $delta$, ora definita come $ delta : Q times (Sigma union {cent, \$}) times Gamma arrow.long Q times (Gamma without {blank}) times {-1, 0, 1}^2 $ con la quale $M$:
+ legge un simbolo sia dal nastro di input sia dal nastro di lavoro;
+ calcola lo stato prossimo dati i simboli letti e lo stato attuale;
+ modifica il nastro di lavoro;
+ comanda il moto delle due testine.

Anche la definizione di configurazione va leggermente modificata: ora, infatti, una *configurazione* di $M$ è una quadrupla $ C = angle.l q, i, j, w angle.r $ in cui:
- $q$ è lo stato corrente;
- $i$ e $j$ sono le posizioni della testina di input e della testina di lavoro;
- $w$ è il contenuto non blank del nastro di lavoro.

Non serve salvare anche l'input perché, essendo il nastro read-only, non cambia mai.

Gli altri concetti (_computazione, accettazione, linguaggio accettato, complessità in tempo, eccetera_) rimangono inalterati con questo modello.

=== Complessità in spazio (2)

A questo punto possiamo ridefinire la complessità in spazio per queste nuove macchine di Turing.

Per ogni stringa $x in Sigma^*$, il valore $S(x)$ è ora dato dal numero di celle _del solo nastro di lavoro_ visitate da $M$ durante la computazione di $x$.

Dunque, la *complessità in spazio deterministica* $s(n)$ di $M$ è da intendersi come il massimo numero di celle visitate nel nastro di lavoro durante la computazione di stringhe di lunghezza $n$, quindi come prima $ s(n) = max{S(x) bar.v x in Sigma^* and abs(x) = n}. $

In questo modo misuriamo solo lo spazio di lavoro, che quindi può essere anche sublineare.

=== Complessità in spazio di linguaggi

Il linguaggio $L subset.eq Sigma^*$ è riconosciuto in *spazio deterministico* $f(n)$ se e solo se esiste una DTM $M$ tale che:
+ $L = L_M$;
+ $s(n) lt.eq f(n)$.

Sfruttando questa definizione, possiamo ovviamente definire la complessità in spazio per il riconoscimento di insiemi e per la funzione soluzione di problemi di decisione.

==== Calcolo di funzioni

Per il caso specifico del calcolo di funzioni, solitamente si considera una terza macchina di Turing, in cui è presente un _terzo nastro_ dedicato alla sola scrittura dell'output della funzione da calcolare. Questa aggiunta ci permette di conteggiare effettivamente lo spazio per l'output e di non interferire con il nastro di lavoro.

Diremo che una funzione $f : Sigma^* arrow.long Gamma^*$ è calcolabile dalla DTM $M$ se e solo se:
- $f(x) arrow.b$ ponendo $x$ sul nastro di input e ottenendo $f(x)$ sul nastro di output;
- $f(x) arrow.t$ ponendo $x$ sul nastro di input e ottenendo un loop.

Inoltre, diremo che la funzione $f : Sigma^* arrow.long Gamma^*$ viene calcolata con *complessità in spazio $s(n)$* dalla DTM $M$ se e solo se _su ogni input x di lunghezza n_ la computazione di $M$ occupa non più di $s(n)$ celle dal nastro di lavoro.

=== Classi di complessità

Per ogni funzione $f : NN arrow.long NN$ definiamo $ dspace(f(n)) $ la *classe dei linguaggi accettati da DTM in spazio deterministico* $O(f(n))$.

Chiamiamo invece $ fspace(f(n)) $ *classe delle funzioni calcolate da DTM in spazio deterministico* $O(f(n))$.

Notiamo che le classi $dspace$ e $fspace$ *non* cambiano se aggiungiamo alle nostre DTM un _numero costante di nastri di lavoro_. Se può essere comodo possiamo quindi utilizzare DTM con $k$ nastri di lavoro aggiuntivi, separando anche il nastro di input da quello di output.

=== Esempio: Parità

Riprendiamo la DTM $M$ per il linguaggio $L_"PARI" = 1 {0,1}^* 0 union 0$ definita dal seguente programma.

// tia: da sistemare, mi piace ma non troppo
#algo(
  title: "Parità",
  parameters: ("x",),
  breakable: true
)[
  $i := 1$; \
  $f := "false"$; \
  $"switch"(x[i]) space {$ #i \
    $"case" 0:$ #i \
      $i plus plus$; \
      $f := (x[i] == blank)$; \
      $"break"$; #d \
    $"case" 1$: #i \
      $"do" space {$ #i \
        $i plus plus$ ; \
        $f := (x[i] == 0)$; #d \
      $} space "while" (x[i] != blank)$; #d#d \
  $}$ \
  $"return" f$;
]

Abbiamo già visto che $L_"PARI" in dtime(n)$. _E lo spazio?_

A dire il vero, non viene occupato spazio, in quanto tutto può essere fatto usando solamente gli stati. Infatti, $L_"PARI"$ è un linguaggio *regolare* e si può dimostrare che $ "REG" = dspace(1). $ In poche parole, stiamo buttando via il nastro di lavoro, trasformando la DTM in un *automa a stati finiti*. Per _buttarlo via_ devo però aumentare il numero di stati: infatti, le informazioni che _buttiamo_ dal nastro di lavoro vanno codificate in stati, che quindi aumentano di numero.

=== Esempio: Palindrome

Consideriamo $L_"PAL" = {x in Sigma^* bar.v x = x^R}$ il linguaggio considerato la lezione precedente. Avevamo visto che una DTM $M$ per questo linguaggio è definita dal seguente programma.

// tia: da sistemare, non l'ho sistemato perché dobbiamo decidere
#algo(
  title: "Palindrome",
  parameters: ("x",)
)[
  i := 1; \
  j := n; \
  f := true; \
  while(i < j && f) { #i \
    if (x[i] != x[j]) #i \
      f := false; #d \
    i++; \
    j--; #d \
  } \
  return f;
]

Sappiamo già che, per quanto riguarda il tempo, $t(n) = O(n^2)$.

Per quanto riguarda lo spazio, invece, dobbiamo cercare di capire che valori possono assumere i numeri che scriviamo durante la computazione. Tra $i$ e $j$, il numero più grande è sempre $j$, che al massimo vale $n$, di conseguenza $ s(n) = O(n). $ Possiamo fare meglio: questa rappresentazione scelta è *unaria*, perché _sporco_ un numero di celle esattamente uguale a $n$. Usando una rappresentazione *binaria*, il numero di celle di cui abbiamo bisogno è il numero di bit necessari a rappresentare $n$, ovvero $ s(n) = O(log(n)). $

_Possiamo usare una base del logaritmo più alta per abbassare la complessità_?

No, perché qualsiasi logaritmo può essere trasformato in un altro a meno di una costante moltiplicativa, quindi è indifferente la base utilizzata.

Ad esempio, $ O(log_2(n)) = O(frac(log_(100)(n), log_(100)(2))) = O(log_(100)(n)). $

Quindi, $ L_"PAL" in dtime(n^2) $ e $ L_"PAL" in dspace(log(n)). $

_Possiamo essere più veloci?_

Un algoritmo più "veloce" di quello che abbiamo visto, è il seguente.

#align(center)[
  #table(
    columns: (60%, 20%, 20%),
    inset: 10pt,
    align: horizon,
    
    [*Istruzione*], [*Tempo*], [*Spazio*],

    [Copia la stringa di input sul nastro di lavoro], [$n$], [$n$],
    [Sposta la testina del nastro di input in prima posizione (quella del nastro di lavoro sarà alla fine)], [$n$], [-],
    [Confronta i due caratteri, avanzando al testina di input e retrocedendo quella di lavoro], [$n$], [-],
    [Accetta se tutti i confronti tornano, altrimenti rifiuta], [$t(n) = O(n)$], [$s(n) = O(n)$]
  )
]

Questo ci mostra come abbiamo avuto un gran miglioramento per la risorsa tempo, a discapito della risorsa spazio. Spesso (_ma non sempre_) migliorare una risorsa porta al peggioramento di un'altra.

Esistono quindi diversi algoritmi per un dato problema che ottimizzano solo una delle due risorse a disposizione. Per il linguaggio $L_"PAL"$ si dimostra che $ t(n) dot s(n) = Omega(n^2). $

=== Efficienza in termini di spazio

Definiamo: 
- $L = dspace(log(n)) arrow$ classe dei linguaggi accettati in spazio deterministico $O(log(n))$;
- $fl = fspace(log(n)) arrow$ classe delle funzioni calcolate in spazio deterministico $O(log(n))$.

L e FL sono universalmente considerati i *problemi risolti efficientemente in termini di spazio*.

Finora, abbiamo stabilito due sinonimie:
- efficiente _in tempo_ se e solo se il _tempo è polinomiale_;
- efficiente _in spazio_ se e solo se lo _spazio è logaritmico_.

Entrambe le affermazioni trovano ragioni di carattere pratico, composizionale e di robustezza, come visto nella lezione scorsa per la risorsa tempo.

Per lo spazio, le motivazioni sono le seguenti:
- *pratico*: operare in spazio logaritmico (sublineare) significa saper gestire grandi moli di dati senza doverle copiare totalmente in memoria centrale (che potrebbe anche non riuscire a contenerli tutti) usando algoritmi sofisticati che si servono, ad esempio, di tecniche per fissare posizioni sull'input o contare parti dell'input (in generale procedure che siano logaritmiche in spazio).\
  I dati diventano facilmente grandi e bisogna avere algoritmi che utilizzino poca memoria.
- *composizionale*: i programmi efficienti in spazio che richiamano routine efficienti in spazio, rimangono efficienti in spazio;
- *robustezza*: le classi L e FL rimangono invariate, a prescindere dai modelli di calcolo utilizzati, ad esempio DTM multi-nastro, RAM, WHILE, etc.

// tia: formattare meglio
*Tesi di Church-Turing estesa per lo spazio* : La classe dei problemi efficientemente risolubili in spazio coincide con la classe dei problemi risolti in spazio logaritmico su DTM.

Vediamo alcuni esempi di problemi risolti efficientemente in spazio:
- in L:
  - testare la raggiungibilità tra due nodi di un grafo non diretto;
  - parsing dei linguaggi regolari;
  - ci si chiede se anche il parsing dei linguaggi context-free è efficiente. Attualmente $s(n) = O(log^2 n)$;
- in FL:
  - operazioni aritmetiche;
  - permanenti di matrici booleane
  - aritmetica modulare;
// gigi: aggiungere esempi di questo tipo anche per il tempo

Se un problema è in L o FL è anche efficientemente *parallelizzabile*. Al momento non esistono compilatori perfettamente parallelizzabili.