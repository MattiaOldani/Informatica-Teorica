// Setup

#import "template.typ": project

#show: project.with(
  title: "Informatica teorica"
)

#import "@preview/ouset:0.1.1": overset

#pagebreak()

// Appunti

= Introduzione

== Definizione

L'*informatica teorica* è quella branca dell'informatica che si "contrappone" all'informatica applicata: in quest'ultima, l'informatica è usata solo come uno _strumento_ per gestire l'oggetto del discorso, mentre nella prima l'informatica  diventa l'_oggetto_ del discorso, di cui ne vengono studiati i fondamenti.

== Cosa e come

Analizziamo i due aspetti fondamentali che caratteristicano ogni materia:
1. il *cosa*: l'informatica è la scienza che studia l'informazione e la sua elaborazione automatica mediante un sistema di calcolo. Ogni volta che ho un _problema_ cerco di risolverlo automaticamente scrivendo un programma. _Posso farlo per ogni problema? Esistono problemi che non sono risolubili?_ \ Possiamo chiamare questo primo aspetto con il nome di *teoria della calcolabilità*, quella branca che studia cosa è calcolabile e cosa non lo è, a prescindere dal costo in termini di risorse che ne deriva. In questa parte utilizzeremo una caratterizzazione molto rigorosa e una definizione di problema il più generale possibile, così che l'analisi non dipenda da fattori tecnologici, storici...
2. il *come*: è relazionato alla *teoria della complessità*, quella branca che studia la quantità di risorse computazionali richieste nella soluzione automatica di un problema. Con _risorsa computazionale_ si intende qualsiasi cosa venga consumato durante l'esecuzione di un programma, ad esempio:
  - elettricità;
  - numero di processori;
  - tempo;
  - spazio di memoria.
  In questa parte daremo una definizione rigorosa di tempo, spazio e di problema efficientemente risolubile in tempo e spazio, oltre che uno sguardo al famoso problema `P = NP`.

Possiamo dire che il _cosa_ è uno studio *qualitativo*, mentre il _come_ è uno studio *quantitativo*.

Grazie alla teoria della calcolabilità individueremo le funzioni calcolabili, di cui studieremo la complessità.

#pagebreak()

= Richiami matematici

== Funzioni

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

#let circ = $ circle.stroked.tiny $

Un'operazione definita su funzioni è la *composizione*: date $f: A arrow.long B$ e $g: B arrow.long C$, la funzione _f composto g_ è la funzione $g circ f: A arrow.long C$ definita come $(g circ f)(a) = g(f(a))$.

La composizione _non è commutativa_, quindi $g circ f eq.not f circ g$ in generale, ma è _associativa_, quindi $(f circ g) circ h = f circ (g circ h)$.

La composizione _f composto g_ la possiamo leggere come _prima agisce f poi agisce g_.

Dato l'insieme $A$, la *funzione identità* su $A$ è la funzione $i_A: A arrow.long A$ tale che: $ i_A (a) = a quad forall a in A, $ ovvero è una funzione che mappa ogni elemento su se stesso.

Grazie alla funzione identità, possiamo dare una definizione alternativa di funzione inversa: data la funzione $f: A arrow.long B$ biiettiva, la sua inversa è l'unica funzione $f^(-1): B arrow.long A$ che soddisfa: $ f circ f^(-1) = f^(-1) circ f = id_A. $

Possiamo vedere $f^(-1)$ come l'unica funzione che ci permette di _tornare indietro_.

Definiamo un'ulteriore classificazione per le funzioni. Data $f: A arrow.long B$, diciamo che $f$ è:
- *totale*, se è definita per _ogni_ elemento $a in A$. Formalmente, scriviamo $f(a)arrow.t$;
- *parziale*, se è definita per _qualche_ elemento $a in A$. Formalmente, scriviamo $f(a)arrow.b$.

Chiamiamo *dominio di esistenza* di $f$ l'insieme: $ text("Dom")_f = \{ a in A : f(a) arrow.b\} subset.eq A. $
Notiamo che:
- $text("Dom")_f subset.neq A => f text("parziale")$;
- $text("Dom")_f = A => f text("totale")$.

== Totalizzare una funzione

Data $f:A -> B$ parziale, possiamo renderla totale aggiungendo un valore speciale, utilizzeremo $perp$, per tutti i valori per cui la funzione di partenza non è definita. La funzione risultante sarà: $ f': A -> B union \{ perp \}. $ Questa viene interpretata nel seguente modo: $ f'(a) = cases(
  f(a) quad text("se ") a in text("Dom")_f,
  perp quad text("altrimenti")
) $
Da qui in avanti utilizzeremo $B_perp$ come abbreviazione di $B union \{ perp \}$.

== Prodotto cartesiano

Chiamiamo *prodotto cartesiano* l'insieme: $ A times B = \{ (a,b) : a in A and b in B \} $ che rappresenta tutte le coppie di valori in $A$ e in $B$.

In generale, il prodtto cartesiano *non è commutativo*, a meno che $A = B$.

Possiamo estendere il concetto di prodotto cartesiano a $n$-uple di valori: $ A_1 times ... times A_n = \{ (a_1, ..., a_n) : a_i in A_i \}. $

Ad ogni prodotto cartesiano possiamo associare una proiezione che recupera un componente della tupla: $ pi_i : A_1 times ... times A_n -> A_i. $

== Insieme di funzioni

Per indicare l'insieme di tutte le funzioni da $A$ a $B$, scriviamo: $ B^A = \{ f : A -> B \}. $ Viene utilizzata questa notazione in quanto la cardinalità di $B^A$ è esattamente $|B|^(|A|)$.

Se può succedere che $f$ sia parziale, scriviamo: $B^A = \{ f : A -> B_perp \}.$

== Funzione valutazione

Dati $A, B$ e $B_perp^A$ si definisce *funzione di valutazione* la funzione: $ omega : B_perp^A times A -> B $ $ w(f,a) = f(a). $
Tenendo fisso $a$ posso scorrere tutte le funzioni su $a$, mentre tenendo fisso $f$ riesco a trovare il grafico di $f$.

#pagebreak()

= Teoria della calcolabilità

== Sistema di calcolo

Definiamo un *programma* $P$ come una *sequenza di regole* che trasformano un dato di input in uno di output. Diciamo che $P in text("DATI")_perp^(text("DATI"))$

Il modello classico che viene considerato quando si parla di calcolatori è quello di Von Neumann.
// TODO: Ho fatto un'immagine da mettere, ma non riesco a regolarne la grandezza. Prova a vedere se riesci tu a inserirla

In questa architettura $cal(C)$, dato il programma $P$ e input $x$, abbiamo due possibili situazioni:
- la macchina restituisce un output -> $y$;
- la macchina entra in loop -> $perp$.

Formalmente, abbiamo che $cal(C) : text("DATI")_perp^(text("DATI")) times text("DATI") -> text("DATI")_perp$. 
Possiamo interpretare una funzione di valutazione come una macchina di Von Neumann, in cui $cal(C)$ è la funzione di valutazione e $cal(C)(P,x)$ è la funzione calcolata da $P$ (anche chiamata *semantica* di $P$).

== Potenza computazionale

Definiamo la potenza computazionale di un calcolatore $cal(C)$: $ F(cal(C)) = \{ cal(C)(P,_) : P in text("PROG") \} subset.eq text("DATI")_perp^(text("DATI")). $

Stabilire _cosa_ può l'informatica equivale a studiare quest'ultima inclusione, in particolare se:
- $F(cal(C)) subset.neq text("DATI")_perp^(text("DATI")) =>$ esistono compiti non automatizzabili;
- $F(cal(C)) = text("DATI")_perp^(text("DATI")) =>$ l'informatica può fare tutto.

Dato che ogni problema può essere visto come una "funzione soluzione", calcolare funzioni equivale a risolvere problemi.

_Ma in che modo possiamo risolvere l'inclusione?_ \
Possiamo analizzare la cardinalità dei due insiemi e metterli a confronto. Questo discorso ha senso ovviamente solo se abbiamo a che fare con insiemi di cardinalità #underline("finita").