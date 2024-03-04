// Setup

#import "template.typ": project

#show: project.with(
  title: "Informatica teorica"
)

#import "@preview/ouset:0.1.1": overset

#pagebreak()

// Appunti

= Lezione 01

== Introduzione

=== Definizione

L'*informatica teorica* è quella branca dell'informatica che si "contrappone" all'informatica applicata: in quest'ultima, l'informatica è usata solo come uno _strumento_ per gestire l'oggetto del discorso, mentre nella prima l'informatica  diventa l'_oggetto_ del discorso, di cui ne vengono studiati i fondamenti.

=== Cosa e come

Analizziamo i due aspetti fondamentali che caratterizzano ogni materia:
+ il *cosa*: l'informatica è la scienza che studia l'informazione e la sua elaborazione automatica mediante un sistema di calcolo. Ogni volta che ho un _problema_ cerco di risolverlo automaticamente scrivendo un programma. _Posso farlo per ogni problema? Esistono problemi che non sono risolubili?_ \ Possiamo chiamare questo primo aspetto con il nome di *teoria della calcolabilità*, quella branca che studia cosa è calcolabile e cosa non lo è, a prescindere dal costo in termini di risorse che ne deriva. In questa parte utilizzeremo una caratterizzazione molto rigorosa e una definizione di problema il più generale possibile, così che l'analisi non dipenda da fattori tecnologici, storici...
+ il *come*: è relazionato alla *teoria della complessità*, quella branca che studia la quantità di risorse computazionali richieste nella soluzione automatica di un problema. Con _risorsa computazionale_ si intende qualsiasi cosa venga consumato durante l'esecuzione di un programma, ad esempio:
  - elettricità;
  - numero di processori;
  - tempo;
  - spazio di memoria.
  In questa parte daremo una definizione rigorosa di tempo, spazio e di problema efficientemente risolubile in tempo e spazio, oltre che uno sguardo al famoso problema `P = NP`.

Possiamo dire che il _cosa_ è uno studio *qualitativo*, mentre il _come_ è uno studio *quantitativo*.

Grazie alla teoria della calcolabilità individueremo le funzioni calcolabili, di cui studieremo la complessità.

== Richiami matematici

=== Funzioni

Una *funzione* da un insieme $A$ ad un insieme $B$ è una _legge_, spesso indicata con $f$, che spiega come associare agli elementi di $A$ un elemento di $B$.

Abbiamo due tipi di funzioni:
- *generale*: la funzione è definita in modo generale come $f: A arrow.long B$, in cui $A$ è detto *dominio* di $f$ e $B$ è detto *codominio* di $f$;
- *locale/puntuale*: la funzione riguarda i singoli valori $a$ e $b$: $ f(a) = b quad bar.v quad a overset(arrow.long.bar, f) b $ in cui $b$ è detta *immagine* di $a$ rispetto ad $f$ e $a$ è detta *controimmagine* di $b$ rispetto ad $f$.

#let quarter = $space.quarter$

Possiamo categorizzare le funzioni in base ad alcune proprietà:
- *iniettività*: una funzione $f: A arrow.long B$ si dice _iniettiva_ se e solo se: $ forall a_1, a_2 in A quad a_1 eq.not a_2 arrow.long.double f(a_1) eq.not f(a_2) $ In poche parole, non ho _confluenze_, ovvero _elementi diversi finiscono in elementi diversi_.
- *suriettività*: una funzione $f: A arrow.long B$ si dice _suriettiva_ se e solo se: $ forall b in B quad exists a in A quarter bar.v quarter f(a) = b. $ In poche parole, _ogni elemento del codominio ha almeno una controimmagine_.

#let immagine(funzione) = $op("Im")_(funzione)$

Se definiamo l'*insieme immagine*: $ immagine(f) = {b in B quarter bar.v quarter exists a in A text("tale che") f(a) = b} = {f(a) quarter bar.v quarter a in A} subset.eq B $ possiamo dare una definizione alternativa di funzione suriettiva, in particolare una funzione è _suriettiva_ se e solo se $immagine(f) = B$.

Infine, una funzione $f: A arrow.long B$ si dice *biiettiva* se e solo se è iniettiva e suriettiva, quindi vale: $ forall b in B quad exists! a in A quarter bar.v quarter f(a) = b.$

Se $f: A arrow.long B$ è una funzione biiettiva, si definisce *inversa* di $f$ la funzione $f^(-1): B arrow.long A$ tale che: $ f(a) = b arrow.long.double.l.r f^(-1)(b) = a. $
Per definire la funzione inversa $f^(-1)$, la funzione $f$ deve essere biiettiva: se così non fosse, la sua inversa avrebbe problemi di definizione.

#let composizione = $ circle.stroked.tiny $

Un'operazione definita su funzioni è la *composizione*: date $f: A arrow.long B$ e $g: B arrow.long C$, la funzione _f composto g_ è la funzione $g composizione f: A arrow.long C$ definita come $(g composizione f)(a) = g(f(a))$.

La composizione _non è commutativa_, quindi $g composizione f eq.not f composizione g$ in generale, ma è _associativa_, quindi $(f composizione g) composizione h = f composizione (g composizione h)$.

La composizione _f composto g_ la possiamo leggere come _prima agisce f poi agisce g_.

Dato l'insieme $A$, la *funzione identità* su $A$ è la funzione $i_A: A arrow.long A$ tale che: $ i_A (a) = a quad forall a in A, $ ovvero è una funzione che mappa ogni elemento su se stesso.

Grazie alla funzione identità, possiamo dare una definizione alternativa di funzione inversa: data la funzione $f: A arrow.long B$ biiettiva, la sua inversa è l'unica funzione $f^(-1): B arrow.long A$ che soddisfa: $ f composizione f^(-1) = f^(-1) composizione f = id_A. $

Possiamo vedere $f^(-1)$ come l'unica funzione che ci permette di _tornare indietro_.

#pagebreak()

= Lezione 02

== Richiami matematici

=== Funzioni totali e parziali

Prima di fare un'ulteriore classificazione per le funzioni, introduciamo la notazione $f(a) arrow.b$ per indicare che la funzione $f$ è definita per l'input $a$, mentre la notazione $f(a) arrow.t$ per indicare la situazione opposta.

Ora, data $f: A arrow.long B$ diciamo che $f$ è:
- *totale* se è definita _per ogni elemento_ $a in A$, ovvero $f(a) arrow.b quarter forall a in A$;
- *parziale* se è definita _per qualche elemento_ $a in A$, ovvero $exists a in A bar.v f(a) arrow.t$.

#let dominio(funzione) = $op("Dom")_funzione$

Chiamiamo *dominio* (o _campo_) *di esistenza* di $f$ l'insieme $ dominio(f) = { a in A bar.v f(a) arrow.b} subset.eq A. $

Notiamo che:
- $dominio(f) subset.neq A arrow.long.double f$ parziale;
- $text("Dom")_f = A arrow.long.double f$ totale.

=== Totalizzare una funzione

È possibile _totalizzazione_ una funzione parziale definendo una funzione a tratti $f: A arrow.long B union {bot}$ tale che $ overline(f)(a) = cases(f(a) quad a in op("Dom")_f (a), bot quad text("altrimenti")). $

Il nuovo simbolo introdotto è il _simbolo di indefinito_, e viene utilizzato per tutti i valori per cui la funzione di partenza $f$ non è appunto definita.

Da qui in avanti utilizzeremo $B_bot$ come abbreviazione di $B union { bot }$.

=== Prodotto cartesiano

Chiamiamo *prodotto cartesiano* l'insieme $ A times B = { (a,b) bar.v a in A and b in B }, $ che rappresenta l'insieme di tutte le _coppie ordinate_ di valori in $A$ e in $B$.

In generale, il prodotto cartesiano *non è commutativo*, a meno che $A = B$.

Possiamo estendere il concetto di prodotto cartesiano a $n$-uple di valori, ovvero $ A_1 times dots times A_n = { (a_1, dots , a_n) bar.v a_i in A_i }. $

L'operazione "_opposta_" è effettuata dal *proiettore* $i$-esimo: esso è una funzione che estrae l'$i$-esimo elemento di un tupla, ovvero è una funzione $pi_i : A_1 times dots times A_n arrow.long A_i$ tale che $ pi_i (a_1, dots, a_n) = a_i $

Per comodità chiameremo $underbracket(A times dots times A, n) = A^n$

=== Insieme di funzioni

L'insieme di tutte le funzioni da $A$ in $B$ si indica con $ B^A = { f : A arrow.long B }. $ Viene utilizzata questa notazione in quanto la cardinalità di $B^A$ é esattamente $|B|^(|A|)$, se $A$ e $B$ sono insiemi finiti.

In questo insieme sono presenti anche tutte le funzioni parziali da $A$ in $B$: mettiamo in evidenza questa proprietà, scrivendo $ B^A_bot = { f : A -> B_bot }. $

Sembrano due insiemi diversi ma sono la stessa cosa: nel secondo viene messo in evidenza il fatto che tutte le funzioni che sono presenti sono totali oppure parziali che sono state totalizzate.

=== Funzione di valutazione

Dati $A, B$ e $B_bot^A$ si definisce *funzione di valutazione* la funzione $ omega : B_bot^A times A arrow.long B $ tale che $ w(f,a) = f(a). $

In poche parole, è una funzione che prende una funzione $f$ e la valuta su un elemento $a$ del dominio.

Abbiamo due possibili approcci:
- tengo fisso $a$ e provo tutte le funzioni $f$: sto eseguendo un _benchmark_, quest'ultimo rappresentato da $a$;
- tengo fissa $f$ e provo tutte le $a$ del dominio: sto ottenendo il grafico di $f$.

== Teoria della calcolabilità

=== Sistema di calcolo

Quello che faremo ora è _modellare teoricamente un sistema di calcolo_.

#let dati = $text("DATI")$
#let programmi = $text("PROG")$

Un *sistema di calcolo* lo possiamo vedere come una _black-box_ che prende un programma $P$, una serie di dati $x$ e calcola il risultato di $P$ sull'input $x$.

La macchina ci restituisce:
- $y$ se è riuscita a calcolare un risultato;
- $bot$ se è entrata in un loop.

#v(12pt)

#figure(
    image("assets/architettura-von-neumann.svg", width: 20%)
)

#v(12pt)

Un sistema di calcolo quindi è una funzione del tipo $ cal(C) : programmi times dati arrow.long dati_bot. $

Come vediamo, è molto simile ad una funzione di valutazione: infatti, la parte dei dati $x$ la riusciamo a "mappare" sull'input $a$ del dominio, ma facciamo più fatica con l'insieme dei programmi, questo perché non abbiamo ancora definito cos'é un programma.

Un *programma* $P$ è una *sequenza di regole* che trasformano un dato di input in uno di output (o in un loop): in poche parole, un programma è una funzione del tipo $ P : dati arrow.long dati_bot, $ ovvero una funzione che appartiene all'insieme $dati_bot^dati$.

Con questa definizione riusciamo a "mappare" l'insieme $programmi$ sull'insieme delle funzioni che ci serviva per definire la funzione di valutazione.

Formalmente, un sistema di calcolo è quindi la funzione $ cal(C) : dati_bot^dati times dati arrow.long dati. $

Con $cal(C)(P,x)$ indichiamo la funzione calcolata da $P$ su $x$, ovvero la sua *semantica*, il suo _significato_.

Il modello classico che viene considerato quando si parla di calcolatori è quello di *Von Neumann*.

=== Potenza computazionale

Definiamo la *potenza computazionale* di un calcolatore come l'insieme di tutte le funzioni che quel sistema di calcolo può calcolare grazie ai programmi, ovvero $ F(cal(C)) = { cal(C)(P, \_) bar.v P in programmi } subset.eq dati_bot^dati. $

In poche parole, $F(cal(C))$ rappresenta l'insieme di tutte le possibili semantiche di funzioni che sono calcolabili con il sistema $cal(C)$.

Stabilire _cosa può fare l'informatica_ equivale a studiare quest'ultima inclusione: in particolare, se
- $F(cal(C)) subset.neq dati_bot^dati$ allora esistono compiti *non automatizzabili*;
- $F(cal(C)) = dati_bot^dati$ allora l'informatica può fare tutto.

Se ci trovassimo nella prima situazione dovremmo individuare una sorta di "recinto" per dividere le funzioni calcolabili da quelle che non lo sono.

Calcolare una funzione vuole dire _risolvere un problema_: ad ognuno di questi associo una *funzione soluzione*, che mi permette di risolvere in modo automatico il problema.

Grazie a questa definizione, calcolare le funzioni equivale a risolvere problemi.

In che modo possiamo risolvere l'inclusione?

Un primo approccio è quello della *cardinalità*: viene definita come una funzione che associa ad ogni insieme il numero di elementi che contiene.

Sembra un ottimo approccio, ma presenta alcuni problemi: infatti, funziona solo quando l'insieme è finito, mentre è molto fragile quando si parla di insiemi infiniti.

Ad esempio, gli insiemi
- $NN$ dei numeri naturali e
- $PP$ dei numeri naturali pari
sono tali che $PP subset.neq NN$ ma hanno cardinalità $|NN| = |PP| = infinity$.

Dobbiamo dare una definizione diversa di cardinalità, visto che possono esistere "_infiniti più fitti/densi di altri_", come abbiamo visto nell'esempio precedente.
