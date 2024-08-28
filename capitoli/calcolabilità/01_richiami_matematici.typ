#import "../alias.typ": *


= Richiami matematici: funzioni e prodotto cartesiano

== Funzioni e insiemi di funzioni

Una *funzione* da un insieme $A$ a un insieme $B$ è una legge, spesso indicata con $f$, che definisce come associare agli elementi di $A$ un elemento di $B$.

Una funzione può essere di due tipi differenti:
- *generale*: la funzione è definita in modo generale come $f: A arrow.long B$, in cui $A$ è detto *dominio* di $f$ e $B$ è detto *codominio* di $f$;
- *locale/puntuale*: la funzione è definita solo per singoli valori $a in A$ e $b in B$, e scriviamo: $ f(a) = b quad bar.v quad a arrow.long.bar^f b, $ in cui $b$ è detta *immagine* di $a$ rispetto a $f$ e $a$ è detta *controimmagine* di $b$ rispetto a $f$.

Le funzioni possono essere categorizzate in base ad alcune proprietà:
- *iniettività*: una funzione $f: A arrow.long B$ si dice _iniettiva_ se e solo se: $ forall a_1, a_2 in A quad a_1 eq.not a_2 arrow.long.double f(a_1) eq.not f(a_2). $ In sostanza, elementi diversi sono _mappati_ ad elementi diversi.
- *suriettività*: una funzione $f: A arrow.long B$ si dice _suriettiva_ se e solo se: $ forall b in B quad exists a in A bar.v f(a) = b, $ quindi ogni elemento del codominio ha almeno una controimmagine.
- *biettività*: una funzione $f: A arrow.long B$ si dice _biiettiva_ se e solo se: $ forall b in B quad exists! a in A bar.v f(a) = b, $ che equivale a dire che è sia iniettiva sia suriettiva.

Definendo l'*insieme immagine*: $ immagine(f) = {b in B bar.v exists a in A text("tale che") f(a) = b} = {f(a) bar.v a in A} subset.eq B $ possiamo dare una definizione alternativa di funzione suriettiva: essa è tale se e solo se $immagine(f) = B$.

Se $f: A arrow.long B$ è una funzione biiettiva, si definisce *inversa* di $f$ la funzione $f^(-1): B arrow.long A$ tale che: $ f(a) = b arrow.long.double.l.r f^(-1)(b) = a. $ Se $f$ non fosse biiettiva, l'inversa avrebbe problemi di definizione.

Un'operazione definita su funzioni è la *composizione*: date $f: A arrow.long B$ e $g: B arrow.long C$, la funzione _f composto g_ è la funzione $g composizione f: A arrow.long C$ definita come: $ (g composizione f)(a) = g(f(a)). $

La composizione _non è commutativa_, ovvero $g composizione f eq.not f composizione g$ in generale, ma è _associativa_, quindi $(f composizione g) composizione h = f composizione (g composizione h)$.

Dato l'insieme $A$, la *funzione identità* su $A$ è la funzione $i_A: A arrow.long A$ tale che: $ forall a in A quad i_A (a) = a, $ quindi è una funzione che mappa ogni elemento in se stesso.

Grazie a questa, diamo una definizione alternativa di funzione inversa: data $f: A arrow.long B$ biiettiva, la sua inversa è l'unica funzione $f^(-1): B arrow.long A$ che soddisfa la relazione: $ f composizione f^(-1) = f^(-1) composizione f = id_A. $

Introduciamo la notazione $f(a) arrow.b$ per indicare che la funzione $f$ è definita per l'input $a$, mentre la notazione $f(a) arrow.t$ per indicare la situazione opposta.

Vediamo una seconda categorizzazione per le funzioni. Data $f: A arrow.long B$, diciamo che $f$ è:
- *totale* se è definita per _ogni_ elemento di $A$, ovvero $forall a in A quad f(a) arrow.b$;
- *parziale* se è definita per _qualche_ elemento di $A$, ovvero $exists a in A bar.v f(a) arrow.t$.

Chiamiamo *dominio* (o _campo_) *di esistenza* di $f$ l'insieme: $ dominio(f) = { a in A bar.v f(a) arrow.b} subset.eq A. $

Notiamo che:
- se $dominio(f) subset.neq A$ allora $f$ è una funzione parziale;
- se $dominio(f) = A$ allora $f$ è una funzione totale.

È possibile *totalizzare* una funzione parziale $f$ definendo una funzione a tratti $overline(f): A arrow.long B union {bot}$ tale che: $ overline(f)(a) = cases(f(a) quad & a in op("Dom")_f (a), bot & text("altrimenti")) quad . $

Il simbolo $bot$ è il _simbolo di indefinito_ e viene utilizzato per tutti i valori per cui la funzione di partenza $f$ non è appunto definita. Da qui in avanti utilizzeremo $B_bot$ come abbreviazione di $B union { bot }$.

L'insieme di tutte le funzioni da $A$ in $B$ si indica con: $ B^A = { f : A arrow.long B }. $ Viene utilizzata questa notazione in quanto la cardinalità di $B^A$ è esattamente $|B|^(|A|)$, se $A$ e $B$ sono insiemi finiti.

Dato che vogliamo che siano presenti anche tutte le funzioni parziali da $A$ in $B$, scriviamo: $ B^A_bot = { f : A -> B_bot }, $ mettendo in evidenza il fatto che tutte le funzioni che sono presenti sono totali oppure parziali, ma che sono state totalizzate. Le due definizioni coincidono, ovvero $ B^A = B_bot^A $.

== Prodotto cartesiano

Chiamiamo *prodotto cartesiano* l'insieme: $ A times B = { (a,b) bar.v a in A and b in B }, $ che rappresenta l'insieme di tutte le _coppie ordinate_ di valori in $A$ e in $B$.

In generale, il prodotto cartesiano *non è commutativo*, a meno che $A = B$.

Possiamo estendere il concetto di prodotto cartesiano a $n$-uple di valori: $ A_1 times dots times A_n = { (a_1, dots , a_n) bar.v a_i in A_i }. $

Per comodità chiameremo $ underbracket(A times dots times A, n) = A^n . $

L'operazione "opposta" è effettuata dal *proiettore* $i$-esimo: esso è una funzione che estrae l'$i$-esimo elemento di un tupla, quindi è una funzione $pi_i : A_1 times dots times A_n arrow.long A_i$ tale che: $ pi_i (a_1, dots, a_n) = a_i. $

== Funzione di valutazione

Dati $A, B$ e $B_bot^A$ si definisce *funzione di valutazione* la funzione: $ omega : B_bot^A times A arrow.long B $ tale che $ omega(f,a) = f(a). $

In poche parole, è una funzione che prende una funzione $f$ e la valuta su un elemento $a$ del dominio.

Esistono due tipi di analisi che possiamo effettuare su questa funzione:
- si tiene fisso $a$ e si provano tutte le funzioni $f$: otteniamo un _benchmark_, ognuno dei quali è rappresentato dal valore $a$;
- si tiene fissa $f$ e si provano tutte le $a$ nel dominio: otteniamo il _grafico_ di $f$.
