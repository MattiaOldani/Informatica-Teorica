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

L'*informatica teorica* è una branca dell'informatica e della matematica che si "contrappone" all'informatica applicata: infatti, in quest'ultima, l'informatica è usata solo come uno strumento per gestire l'oggetto del discorso

In questo caso, invece, vogliamo rendere l'informatica l'oggetto del discorso, studiandone i fondamenti

== Cosa e come

Per studiare una nuova materia dobbiamo studiarne i _cosa_ e i _come_:
- _cosa_: l'informatica è la scienza che studia l'informazione e la sua elaborazione automatica, fatta da un sistema di calcolo \ Ogni volta che ho un _problema_ cerco di risolverlo automaticamente scrivendo un programma, ma posso farlo per ogni problema? Esistono problemi che non sono risolubili? \ Il _cosa_ riguarda la *teoria della calcolabilità*, ovvero quella branca che studia tutto ciò che è calcolabile o meno, a prescindere dal costo in termini di risorse che ne deriva \ In questa parte utilizzeremo una caratterizzazione molto rigorosa e una definizione il più generale possibile di un problema, così che non dipenda da fattori tecnologici, storici, eccetera
- _come_: riguarda la *teoria della complessità*, ovvero quella branca che studia la quantità di risorse computazionali richieste nella soluzione automatica di un problema \ Con _risorsa computazionale_ si intende qualsiasi cosa venga consumato durante l'esecuzione di un programma, ad esempio
  - elettricità
  - numero di processori
  - tempo
  - spazio di memoria
  In questa fase daremo una definizione rigorosa di tempo, spazio e di problema efficientemente risolubile in tempo e spazio, oltre che uno sguardo al famoso problema `P = NP`

In poche parole, il _cosa_ fa uno studio *qualitativo*, il _come_ fa uno studio *quantitativo*

Studieremo prima la teoria della calcolabilità per individuare le funzioni calcolabili, poi di queste ultime ne studieremo la complessità

#pagebreak()

= Linguaggio matematico

== Funzioni

Una *funzione* da un insieme $A$ ad un insieme $B$ è una _legge_, spesso indicata con $f$, che spiega come associare ad ogni elemento di $A$ un elemento di $B$

Abbiamo due livelli di funzioni
- *generale*: la funzione è definita in modo generale come $f: A arrow.long B$, dove $A$ è detto *dominio* di $f$ e $B$ è detto *codominio* di $f$
- *locale/puntuale*: la funzione riguarda i singoli valori $a$ e $b$ $ f(a) = b quad bar.v quad a overset(arrow.long.bar, f) b $ $b$ è detta *immagine* di $a$ rispetto ad $f$ e $a$ è detta *controimmagine* di $b$ rispetto ad $f$

#let quarter = $space.quarter$

Possiamo categorizzare le funzioni in base ad alcune proprietà
- *iniettiva*: una funzione $f: A arrow.long B$ si dice _iniettiva_ se e solo se $ forall a_1, a_2 in A quad a_1 eq.not a_2 arrow.long.double f(a_1) eq.not f(a_2) $ In poche parole, non ho _confluenze_, ovvero _elementi diversi finiscono in elementi diversi_
- *suriettiva*: una funzione $f: A arrow.long B$ si dice _suriettiva_ se e solo se $ forall b in B quad exists a in A quarter bar.v quarter f(a) = b $ In poche parole, _ogni elemento del codominio ha almeno una controimmagine_

#let immagine(funzione) = $op("Im")_(funzione)$

Se definiamo l'*insieme immagine* $ immagine(f) = {b in B quarter bar.v quarter exists a in A text("tale che") f(a) = b} = {f(a) quarter bar.v quarter a in A} subset.eq B $ possiamo dare una definizione alternativa di funzione suriettiva, ovvero una funzione è _suriettiva_ se e solo se $immagine(f) = B$

L'ultima proprietà è l'intersezione delle due precedenti: una funzione $f: A arrow.long B$ si dice *biiettiva* se e solo se è iniettiva e suriettiva, ovvero $ forall b in B quad exists! a in A quarter bar.v quarter f(a) = b $

Se $f: A arrow.long B$ è una funzione biiettiva, si definisce *inversa* di $f$ la funzione $f^(-1): B arrow.long A$ tale che $ f(a) = b arrow.long.double.l.r f^(-1)(b) = a $

La funzione $f$ deve essere biiettiva: se così non fosse, la sua inversa avrebbe problemi di definizione

Un'operazione importante è la *composizione*: date $f: A arrow.long B$ e $g: B arrow.long C$, la funzione _f composto g_ è la funzione $g dot.circle f: A arrow.long C$ definita come $(g dot.circle f)(a) = g(f(a))$

In generale, la composizione _non è commutativa_, quindi $g dot.circle f eq.not f dot.circle g$ in generale, ma è _associativa_, quindi $(f dot.circle g) dot.circle h = f dot.circle (g dot.circle h)$

La composizione _f composto g_ la possiamo leggere come _prima agisce f poi agisce g_

Una funzione molto importante è la *funzione identità*: dato l'insieme $A$, la funzione identità su $A$ è la funzione $i_A: A arrow.long A$ tale che $ i_A (a) = a quad forall a in A, $ ovvero è una funzione che mappa ogni elemento su se stesso

Grazie alla funzione identità possiamo dare una definizione alternativa di funzione inversa: data la funzione $f: A arrow.long B$ biiettiva, la sua inversa è l'unica funzione $f^(-1): B arrow.long A$ che soddisfa $ f dot.circle f^(-1) = f^(-1) dot.circle f = id_A $

Possiamo vedere $f^(-1)$ come l'unica funzione che ci permette di _tornare indietro_
