// Setup

#import "template.typ": project

#show: project.with(
  title: "Informatica teorica"
)

#import "@preview/ouset:0.1.1": overset

#import "@preview/lemmify:0.1.5": *

#let (
  theorem, lemma, corollary,
  remark, proposition, example,
  proof, rules: thm-rules
) = default-theorems("thm-group", lang: "it")

#show: thm-rules

#show thm-selector("thm-group", subgroup: "proof"): it => block(
  it,
  stroke: green + 1pt,
  inset: 1em,
  breakable: true
)

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
- *locale/puntuale*: la funzione riguarda i singoli valori $a$ e $b$: $ f(a) = b quad bar.v quad a arrow.long.bar^f b $ in cui $b$ è detta *immagine* di $a$ rispetto ad $f$ e $a$ è detta *controimmagine* di $b$ rispetto ad $f$.

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

È possibile _totalizzazione_ una funzione parziale definendo una funzione a tratti $f: A arrow.long B union {bot}$ tale che $ overline(f)(a) = cases(f(a) quad & a in op("Dom")_f (a), bot & text("altrimenti")) quad . $

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

Prima di definire la potenza computazionale facciamo una breve premessa: indichiamo con $ cal(C)(P,\_): dati arrow.long dati_bot $ la funzione che viene calcolata dal programma $P$, ovvero la semantica di $P$.

Fatta questa premessa, definiamo la *potenza computazionale* di un calcolatore come l'insieme di tutte le funzioni che quel sistema di calcolo può calcolare grazie ai programmi, ovvero $ F(cal(C)) = { cal(C)(P, \_) bar.v P in programmi } subset.eq dati_bot^dati. $

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

#pagebreak()

= Lezione 03

== Relazioni di equivalenza

=== Definizione

Una *relazione binaria* $R$ su due insiemi $A,B$ è un sottoinsieme $R subset.eq A times B$ di coppie ordinate. Una relazione particolare che ci interessa è $R subset.eq A^2$. Due elementi $a,b in A$ sono in relazione $R$ se e solo se $(a,b) in R$. Indichiamo la relazione tra due elementi tramite notazione infissa $a R b$.

Una classe molto importante di relazioni é quella delle *relazioni di equivalenza*: una relazione $R subset.eq A^2$ é una relazione di equivalenza se e solo se $R$ é $R S T$, ovvero:
- *riflessiva*: $forall a in A quad a R a$;
- *simmetrica*: $forall a,b in A quad a R b arrow.long.double b R a$;
- *transitiva*: $forall a,b,c in A quad a R b and b R c arrow.long.double a R c$.

=== Partizione

Ad ogni relazione di equivalenza si può associare una *partizione*, ovvero un insieme di sottoinsiemi tali che: 
- $forall i in NN^+ quad A_i eq.not emptyset.rev$;
- $forall i,j in NN^+ quad i eq.not j arrow.long.double A_i sect A_j = emptyset.rev$;
- $limits(union.big)_(i in NN^+) A_i = A$.
Diremo che $R$ definita su $A^2$ _induce_ una partizione $A_1, A_2, dots$ su $A$.

=== Classi di equivalenza e insieme quoziente

Dato un elemento $a in A$, la sua *classe di equivalenza* é l'insieme $ [a]_R = {b in A bar.v a R b}, $ ovvero tutti gli elementi che sono in relazione con $a$, chiamato anche _rappresentante della classe_.

Si può dimostrare che:
- non esistono classi di equivalenza vuote $arrow$ garantito dalla riflessività;
- dati $a,b in A$ allora $[a]_R sect [b]_R = emptyset.rev$ oppure $[a]_R = [b]_R$ $arrow$ in altre parole, due elementi o sono in relazione o non lo sono;
- $limits(union.big)_(a in A) [a]_R = A$.

Notiamo che, per definizione, l'insieme delle classi di equivalenza é una partizione indotta dalla relazione $R$ sull'insieme $A$. Questa partizione é detta *insieme quoziente* di $A$ rispetto a $R$ ed é denotato con $A \/ R$.

== Cardinalità

=== Isomorfismi

Due insiemi $A$ e $B$ sono *isomorfi* (_equinumerosi_ o _insiemi che hanno la stessa cardinalità_) se esiste una biiezione tra essi. Formalmente scriviamo: $ A tilde B. $

Detto $cal(U)$ l'insieme di tutti gli insiemi, la relazione $tilde$ é sottoinsieme di $cal(U)^2$.

Dimostriamo che $tilde$ é una relazione di equivalenza:
- _riflessività_: $A tilde A$ se la biiezione é $i_A$;
- _simmetria_: $A tilde B arrow.long.double B tilde A$ se la biiezione é la funzione inversa;
- _transitività_: $A tilde B and B tilde C arrow.long.double A tilde C$ se la biiezione é la composizione della funzione usata per $A tilde B$ con la funzione usata per $B tilde C$.

Dato che $tilde$ è una relazione di equivalenza, è possibile partizionare l'insieme $cal(U)$. La partizione creata è formata da classi di equivalenza che contengono insiemi isomorfi, ossia con la stessa cardinalità.

Possiamo quindi definire la *cardinalità* come l'insieme quoziente di $cal(U)$ rispetto alla relazione $tilde$.

Questo approccio permette di utilizzare la nozione di _cardinalità_ anche con gli insiemi infiniti, dato che l'unica incognita da trovare è una funzione biettiva tra i due insiemi.

=== Cardinalità finita

La prima classe di cardinalità che vediamo é quella delle *cardinalità finite*. Prima di tutto definiamo la famiglia di insiemi: $ J_n = cases(emptyset.rev & text(" se ") n = 0, {1,...,n} & text(" se ") n > 0) quad . $

Un insieme $A$ ha cardinalità finita se $A tilde J_n$ per qualche $n in NN$. In tal caso possiamo scrivere $|A| = n$.

La classe di equivalenza $[J_n]_tilde$ riunisce tutti gli insiemi di $cal(U)$ contenenti $n$ elementi.

=== Cardinalità infinita

L'altra classe di cardinalità da studiare è quella delle *cardinalità infinite*, ovvero gli insiemi non in relazione con $J_n$.

==== Insiemi numerabili

I primi insiemi a cardinalità infinita sono gli *insiemi numerabili*. Un insieme $A$ é numerabile se e solo se $A tilde NN$, ovvero $A in [NN]_tilde$.

Gli insiemi numerabili sono "*listabili*", ovvero é possibile elencare _tutti_ gli elementi dell'insieme $A$ tramite una regola, in questo caso la funzione $f$ biiezione tra $NN$ e $A$. Infatti, grazie alla funzione $f$, è possibile elencare gli elementi di $A$ formando l'insieme: $ A = {f(0), space f(1), space dots}. $ Questo insieme é esaustivo, quindi elenca ogni elemento dell'insieme $A$ senza perderne nessuno.

Gli insiemi numerabili più famosi sono:
- numeri pari $PP$ e numeri dispari $DD$;
- numeri interi $ZZ$ generati con la biiezione $f(n) = (-1)^n (frac(n + (n mod 2), 2))$;
- numeri razionali $QQ$.

Gli insiemi numerabili hanno cardinalità $aleph_0$ (si legge _"aleph"_).

==== Insiemi non numerabili

Gli *insiemi non numerabili* sono insiemi a cardinalità infinita che non sono listabili come gli insiemi numerabili, ovvero sono "più fitti" di $NN$.

Il _non poter listare gli elementi_ si traduce in _qualunque lista generata mancherebbe di qualche elemento_, di conseguenza non sarebbe una lista esaustiva di tutti gli elementi.

Il più famoso insieme non numerabile é l'insieme dei numeri reali $RR$.

#theorem()[
  L'insieme $RR$ non é numerabile
]<thm>

#proof[
  \ Suddividiamo la dimostrazione in tre punti:
  + dimostriamo che $RR tilde (0,1)$;
  + dimostriamo che $NN tilde.not (0,1)$;
  + dimostriamo che $RR tilde.not NN$.

  [1] Partiamo con il dimostrare che $RR tilde (0,1)$: mostro che esiste una biiezione tra $RR$ e $(0,1)$. Usiamo una biiezione "grafica" costruita in questo modo:
  - disegna la circonferenza di raggio $1/2$ centrata in $1/2$;
  - disegna la perpendicolare al punto da mappare che interseca la circonferenza;
  - disegna la retta passante per il centro $C$ e l'intersezione precedente.

  L'intersezione tra l'asse reale e la retta finale é il punto mappato.

  #v(-36pt)

  #figure(
      image("assets/biiezione.svg", width: 70%)
  )

  #v(12pt)

  In realtà, $RR$ é isomorfo a qualsiasi segmento di lunghezza maggiore di 0.

  La stessa biiezione vale anche sull'intervallo chiuso $[0,1]$ utilizzando la "compattificazione" $overset(RR, °) = RR union {plus.minus infinity}$ di $RR$, mappando $0$ su $-infinity$ e $1$ su $+infinity$.

  [2] Continuiamo dimostrando che $NN tilde.not (0,1)$: devo dimostrare che l'intervallo $(0,1)$ non é listabile, ovvero ogni lista che scrivo é un "colabrodo", termine tecnico che indica la possibilità di costruire un elemento che dovrebbe appartenere alla lista ma che invece non é presente. \ Per assurdo sia $NN tilde (0,1)$, allora posso listare gli elementi di $(0,1)$ esaustivamente come: $ 0.& space a_(00) space a_(01) space a_(02) space dots \ 0.& space a_(10) space a_(11) space a_(12) space dots \ 0.& space a_(20) space a_(21) space a_(22) space dots \ 0.& space dots quad , $
  dove con $a_(i j)$ indichiamo la cifra di posto $j$ dell'$i$-esimo elemento della lista.

  Costruisco il _"numero colpevole"_ $c = 0.c_0 c_1 c_2 dots$ tale che $ c_i = cases(2 "se" a_(i i) eq.not 2, 3 "se" a_(i i) = 3) quad . $
  In poche parole, questo numero é costruito "guardando" tutte le cifre sulla diagonale.

  Questo numero sicuramente appartiene a $(0,1)$ ma non appare nella lista: infatti ogni cifra $c_i$ del colpevole differisce da qualunque numero nella lista in almeno una posizione, che é quella della diagonale. Ma questo é assurdo: avevamo assunto $(0,1)$ numerabile.

  Quindi $N tilde.not (0,1)$.
  
  Questo tipo di dimostrazione é detta *dimostrazione per diagonalizzazione*.

  [3] Terminiamo dimostrando che $RR tilde.not NN$: per transitività. Vale il generico, ovvero non si riesce a listare nessun segmento di lunghezza maggiore di 0.
]<proof>

L'insieme $RR$ viene detto *insieme continuo* e tutti gli insiemi isomorfi a $RR$ si dicono a loro volta _continui_. I più famosi insiemi continui sono:
- $RR$ insieme dei numeri reali;
- $CC$ insieme dei numeri complessi;
- $TT subset II$ insieme dei numeri trascendenti.

#pagebreak()

= Lezione 04

== Cardinalità

Vediamo due insiemi continui che saranno importanti successivamente.

=== Insieme delle parti

Il primo insieme che vediamo é l'*insieme delle parti*, o _power set_, di $NN$.

Quest'ultimo é l'insieme $ P(NN) = 2^NN = {S bar.v S "é sottoinsieme di" NN}. $

#theorem()[
  $P(NN) tilde.not NN$.
]<thm>

#proof[
  \ Dimostriamo questo teorema con la diagonalizzazione.
  
  Rappresentiamo il sottoinsieme $A subset.eq NN$ tramite il suo *vettore caratteristico*: $ NN&: 0 space 1 space 2 space 3 space 4 space 5 space 6 space dots \ A&: 0 space 1 space 1 space 0 space 1 space 1 space 0 space dots quad . $ Il vettore caratteristico di un sottoinsieme é un vettore che nella posizione $p_i$ ha $1$ se $i in A$, altrimenti ha $0$.
  
  Per assurdo sia $P(NN)$ numerabile. Vista questa proprietà posso listare tutti i vettori caratteristici che appartengono a $P(NN)$ come $ b_0 &= b_(00) space b_(01) space b_(02) space dots \ b_1 &= b_(10) space b_(11) space b_(12) space dots \ b_2 &= b_(20) space b_(21) space b_(22) space dots quad . $

  Costruiamo un _colpevole among us_ che appartiene a $P(NN)$ ma non é presente nella lista precedente. Definiamo il vettore $ c = overline(b_(00)) space overline(b_(11)) space overline(b_(22)) dots $ che contiene nella posizione $c_i$ il complemento di $b_(i i)$.

  Questo vettore appartiene a $P(NN)$ ma non é presente nella lista precedente perché é diverso da ogni elemento della lista in almeno una cifra.

  Ma questo é assurdo perché $P(NN)$ era numerabile, quindi $P(NN) tilde.not NN$.
]<proof>

Visto questo teorema possiamo affermare che: $ P(NN) tilde [0,1] tilde overset(RR, °). $

=== Insieme delle funzioni

Il secondo insieme che vediamo é l'insieme delle funzioni da $NN$ in $NN$.

Quest'ultimo é l'insieme $ NN_bot^NN = {f: NN arrow.long NN}. $

#theorem()[
  $NN_bot^NN tilde.not NN$.
]<thm>

#proof[
  \ Anche in questo caso useremo la dimostrazione per diagonalizzazione.
  
  Per assurdo sia $NN_bot^NN$ numerabile, quindi possiamo listare $NN_bot^NN$ come ${f_0, f_1, f_2, dots}$.

  #align(center)[
    #table(
      columns: (10%, 15%, 15%, 15%, 15%, 15%, 15%),
      inset: 10pt,
      align: horizon,

      [], [$0$], [$1$], [$2$], [$3$], [$dots$], [$NN$],

      [$f_0$], [$f_0 (0)$], [$f_0 (1)$], [$f_0 (2)$], [$f_0 (3)$], [$dots$], [$dots$],
      [$f_1$], [$f_1 (0)$], [$f_1 (1)$], [$f_1 (2)$], [$f_1 (3)$], [$dots$], [$dots$],
      [$f_2$], [$f_2 (0)$], [$f_2 (1)$], [$f_2 (2)$], [$f_2 (3)$], [$dots$], [$dots$],
      [$f_3$], [$f_3 (0)$], [$f_3 (1)$], [$f_3 (2)$], [$f_3 (3)$], [$dots$], [$dots$],
    )
  ]

  Scriviamo un colpevole $phi: NN arrow.long NN_bot$ per dimostrare l'assurdo. Una prima versione potrebbe essere la funzione $phi(n) = f_n (n) + 1$ per _disallineare_ la diagonale, ma questo non va bene: infatti, se $f_n (n) = bot$ non sappiamo dare un valore a $phi(n) = bot + 1$.

  Definiamo quindi la funzione $ phi(n) = cases(1 & "se" f_n (n) = bot, f_n (n) + 1 quad & "se" f_n (n) arrow.b) quad . $

  Questa funzione é una funzione che appartiene a $NN_bot^NN$ ma non é presente nella lista precedente: infatti, $forall k in NN$ otteniamo $ phi(k) = cases(1 eq.not f_k (k) = bot & "se" f_k (k) = bot, f_k (k) + 1 eq.not f_k (k) quad & "se" f_k (k) arrow.b) quad . $
  
  Ma questo é assurdo perché $P(NN)$ era numerabile, quindi $P(NN) tilde.not NN$.
]<proof>

== Potenza computazionale

=== Validità dell'inclusione $F(cal(C)) subset.eq dati_bot^dati$

Ora che abbiamo una definizione "potente" di cardinalità, essendo basata su strutture matematiche, possiamo verificare la validità dell'inclusione $ F(cal(C)) subset.eq dati_bot^dati. $

Diamo prima qualche considerazione:
- $programmi tilde NN$: identifico ogni programma con un numero, ad esempio la sua codifica in binario;
- $dati tilde NN$: come prima, identifico ogni dato con la sua codifica in binario.

In poche parole, stiamo dicendo che programmi e dati non sono più dei numeri naturali $NN$.

Ma questo ci permette di dire che: $ F(cal(C)) tilde programmi tilde NN tilde.not NN_bot^NN tilde dati_bot^dati. $

Questo é un risultato importantissimo: abbiamo appena dimostrato con la relazione precedente che *esistono funzioni non calcolabili*. Le funzioni non calcolabili sono problemi pratici e molto sentiti al giorno d'oggi: un esempio di funzione non calcolabile é la funzione che, dato un software, dice se é corretto o no. Il problema é che _ho pochi programmi e troppe/i funzioni/problemi_.

Questo risultato però é arrivato considerando vere le due considerazioni precedenti: andiamo quindi a dimostrarle utilizzando le *tecniche di aritmetizzazione* (o _godelizzazione_) *di strutture*, ovvero delle tecniche che rappresentano delle strutture con un numero, così da avere la matematica e l'insiemi degli strumenti che ha a disposizione.

#pagebreak()

= Lezione 05

== $dati tilde NN$

Vogliamo formare una legge che:
+ associ biunivocamente dati a numeri e viceversa;
+ consenta di operare direttamente sui numeri per operare sui corrispondenti dati, ovvero abbia delle primitive per lavorare il numero che "riflettano" il risultato sul dato senza ripassare per il dato stesso;
+ ci consenta di dire, senza perdita di generalità, che i nostri programmi lavorano sui numeri.

=== Funzione coppia di Cantor

==== Definizione

#let cantor_sin = $op("sin")$
#let cantor_des = $op("des")$

La *funzione coppia di Cantor* é la funzione $ <,>: NN times NN arrow.long NN^+. $ Questa funzione é formata da due _"sotto-funzioni"_, _sin_ e _des_, tali che $ <x,y> &= n, \ #cantor_sin: NN^+ arrow.long NN, & quad #cantor_sin (n) = x \ #cantor_des: NN^+ arrow.long NN, & quad #cantor_des (n) = y. $

Vediamo una rappresentazione grafica della funzione di Cantor.

#v(12pt)

#figure(
  image("assets/cantor-01.svg", width: 50%)
)

#v(12pt)

$<x,y>$ rappresenta il valore all'incrocio tra la $x$-esima riga e la $y$-esima colonna.

La tabella viene riempita _diagonale per diagonale_, ovvero:
+ si inserisce $1$ nella cella in _alto a sinistra_;
+ si riempiono le celle della diagonale andando in _alto a destra_ fino alla cella in prima riga;
+ si ripete dal punto $2$ iniziando dalla cella sotto la precedente cella di partenza.

Vogliamo che questa funzione sia iniettiva e suriettiva, quindi:
- non posso avere celle con lo stesso numero (_iniettiva_);
- ogni numero in $NN^+$ deve comparire.

A tutti gli effetti questa funzione é iniettiva e suriettiva, perché:
- numeriamo in maniera incrementale (_iniettiva_);
- ogni numero prima o poi compare in una cella, quindi ho una coppia che lo genera (_suriettiva_).

==== Forma analitica della funzione coppia

Quello che vogliamo fare ora é cercare una forma analitica della funzione coppia, questo perché non é molto comodo costruire ogni volta la tabella sopra. Nella successiva immagine notiamo come valga la relazione $ <x,y> = <x+y,0> + y. $

#v(12pt)

#figure(
  image("assets/cantor-02.svg", width: 40%)
)

#v(12pt)

Questo é molto comodo perché il calcolo della funzione coppia si riduce al calcolo di $<x+y,0>$.

Chiamiamo $x+ y = z$, osserviamo con la successiva immagine un'altra proprietà.

#v(12pt)

#figure(
  image("assets/cantor-03.svg", width: 15%)
)

#v(12pt)

Ogni cella $<z,0>$ la si può calcolare come la somma di $z$ e $<z-1,0>$, ma allora $ <z,0> &= z + <z-1,0> = \ &= z + (z-1) + <z-2,0> = \ &= dots = \ &= z + (z-1) + dots + 1 + <0,0> = \ &= z + (z-1) + dots + 1 + 1 = \ &= sum_(i=1)^z i + 1 = frac(z(z+1),2) + 1. $

Questa forma é molto più compatta ed evita il calcolo di tutti i singoli $<z,0>$.

Possiamo quindi dare la formula analitica della funzione coppia come $ <x,y> = <x+y,0> + y = frac((x+y)(x+y+1), 2) + y + 1. $

==== Forma analitica di #cantor_sin e #cantor_des

Vogliamo adesso dare la forma analitica di _sin_ e _des_ per poter _"tornare indietro"_ dato $n$.

Grazie alle osservazioni precedenti sappiamo che $ n = y + <gamma,0> space &arrow.long.double space y = n - <gamma,0>, \ gamma = x + y space & arrow.long.double space x = gamma - y. $

Se troviamo il valore di gamma abbiamo trovato anche i valori di $x$ e $y$.

Notiamo come $gamma$ sia il _"punto di attacco"_ della diagonale che contiene $n$, ma allora $ gamma = max{z in NN bar.v <z,0> lt.eq n} $ perché tra tutti i punti di attacco $<z,0>$ voglio quello che potrebbe contenere $n$ ($<z,0> lt.eq n$) e che sia massimo, ovvero sia esattamente la diagonale che contiene $n$.

Risolviamo quindi la disequazione $ <z,0> lt.eq n & arrow.long.double frac(z(z+1),2) + 1 lt.eq n \ & arrow.long.double z^2 + z - 2n + 2 lt.eq 0 \ & arrow.long.double z_(1,2) = frac(-1 plus.minus sqrt(1 + 8n - 8), 2) \ & arrow.long.double frac(-1 - sqrt(8n - 7), 2) lt.eq z lt.eq frac(-1 + sqrt(8n - 7), 2). $

Come valore di $gamma$ scelgo $ gamma = floor(frac(-1 + sqrt(8n - 7), 2)). $

Ora che abbiamo $gamma$ possiamo definire le funzioni _sin_ e _des_ come $ #cantor_des (n) = y = n - <gamma,0> = n - frac(gamma (gamma + 1), 2) - 1, \ #cantor_sin (n) = x = gamma - y. $

==== $NN times NN tilde NN$

Con la funzione coppia di Cantor possiamo dimostrare un importante risultato.

#theorem()[
  $NN times NN tilde NN^+$.
]

#proof[
  \ La funzione di Cantor é una funzione biiettiva tra l'insieme $NN times NN$ e l'insieme $NN^+$, quindi i due insiemi sono isomorfi.
]<proof>

Estendiamo adesso il risultato all'interno insieme $NN$, ovvero $ NN times NN tilde NN^+ arrow.long.squiggly NN times NN tilde NN. $

#theorem()[
  $NN times NN tilde NN$.
]

#proof[
  \ Definiamo la funzione $ [,]: NN times NN arrow.long NN $ tale che $ [x,y] = <x,y> - 1. $
  
  Questa funzione é anch'essa biiettiva, quindi i due insiemi sono isomorfi.
]<proof>

Grazie a questi risultati si può dimostrare che $QQ tilde NN$: infatti, i numeri razionali li possiamo rappresentare come coppie $("num", "den")$. In generale, tutte le tuple sono isomorfe a $NN$, iterando in qualche modo la funzione coppia di Cantor.

=== Dimostrazione

I risultati ottenuti fino a questo punto ci permettono di dire che ogni dato é trasformabile in un numero, che può essere soggetto a trasformazioni e manipolazioni matematiche.

La dimostrazione _formale_ non verrà fatta, ma verranno fatti esempi di alcune strutture dati che possono essere trasformate in un numero tramite la funzione coppia di Cantor. Vedremo come ogni struttura dati verrà manipolata e trasformata in una coppia $(x,y)$ per poterla applicare alla funzione coppia.

==== Strutture dati

===== Liste

Le *liste* sono le strutture dati più utilizzate nei programmi. In generale non ne è nota la grandezza, di conseguenza dobbiamo trovare un modo, soprattutto durante la applicazione di _sin_ e _des_, per capire quando abbiamo esaurito gli elementi della lista.

Codifichiamo la lista $[x_1, dots, x_n]$ con $ <x_1, dots, x_n> = <x_1, <x_2, < dots < x_n, 0 > dots >>>. $

Abbiamo quindi applicato la funzione coppia di Cantor alla coppia formata da un elemento della lista e il risultato della funzione coppia stessa applicata ai successivi elementi.

Ad esempio, la codifica della lista $M = [1,2,5]$ risulta essere: $ <1,2,5> &= <1, <2, <5,0>>> \ &= <1,<2,16>> \ &= <1, 188> \ &= 18144. $

Per decodificare la lista $M$ applichiamo le funzioni _sin_ e _des_ al risultato precedente. Alla prima iterazione otterremo il primo elemento della lista e la restante parte ancora da decodificare.

Quando ci fermiamo? Durante la creazione della codifica di $M$ abbiamo inserito un _"tappo"_, ovvero la prima iterazione della funzione coppia $<x_n, 0>$. Questo ci indica che quando $#cantor_des (M)$ sarà uguale a $0$ ci dovremo fermare.

Cosa succede se abbiamo uno $0$ nella lista? Non ci sono problemi: il controllo avviene sulla funzione _des_, che restituisce la _"somma parziale"_ e non sulla funzione _sin_, che restituisce i valori della lista.

Possiamo anche anche delle implementazioni di queste funzioni. Assumiamo che:
- $0$ codifichi la lista nulla;
- esistano delle routine per $<,>$, $#cantor_sin$ e $#cantor_des$.

#v(12pt)

#grid(
  columns: (1fr, 1fr),
  align(center)[
    Codifica
    ```python
    def encode(numbers: list[int]) -> int:
      k = 0
      for i in range(n,0,-1):
        xi = numbers[i]
        k = <xi,k>
      return k
    ```
  ],
  align(center)[
    Decodifica
    ```python
    def decode(n: int) -> list[int]:
      numbers = []
      while True:
        left, n = sin(n), des(n)
        numbers.append(left)
        if n == 0:
          break
      return numbers
    ```
  ]
)

#v(12pt)

Un metodo molto utile delle liste é quello che ritorna la sua *lunghezza*.

#align(center)[
  Lunghezza
  ```python
  def length(n: int) -> int:
    return 0 if n == 0 else 1 + length(des(n))
  ```
]

Infine, definiamo la funzione *proiezione* come: $ op("proj")(t,n) = cases(-1 quad & text("se") t > op("length")(n) or t lt.eq 0 \ x_t & text("altrimenti")) $

e la sua implementazione:

#align(center)[
  Proiezione
  ```python
  def proj(t: int, n: int) -> int:
    if t <= 0 or t > length(n):
      return -1
    else:
      if t == 1:
        return sin(n)
      else:
        return proj(t - 1, des(n))
  ```
]

===== Array

Per gli *array* il discorso è più semplice, in quanto la dimensione é nota a priori. Di conseguenza, non necessitiamo di un carattere di fine sequenza. Dunque avremo che l'array ${x_1, dots, x_n}$ viene codificato con: $ [x_1, dots, x_n] = [x_1, dots [x_(n-1), x_n] dots ]. $

===== Matrici

Per quanto riguarda *matrici* l'approccio utilizzato codifica singolarmente le righe e successivamente codifica i risultati ottenuti come se fossero un array di dimensione uguale al numero di righe.

#set math.mat(delim: "[")

Ad esempio, la matrice $ mat(x_11, x_12, x_13; x_21, x_22, x_23; x_31, x_32, x_33) $ viene codificata in: $ mat(x_11, x_12, x_13; x_21, x_22, x_23; x_31, x_32, x_33) = [[x_11, x_12, x_13], [x_21, x_22, x_23], [x_31, x_32, x_33]]. $

===== Grafi

Consideriamo il seguente grafo.

#v(12pt)

#figure(
  image("assets/grafo.svg", width: 25%)
)

#v(12pt)

I *grafi* sono rappresentati principalmente in due modi:
- *liste di adiacenza dei vertici*: per ogni vertice si ha una lista che contiene gli identificatori dei vertici che collegati direttamente con esso. Il grafo precedente ha $ {1:[2,3,4], 2:[1,3], 3:[1,2,4], 4:[1,3]} $ come lista di adiacenza, e la sua codifica si calcola come: $ [<2,3,4>,<1,2>,<1,2,4>,<1,3>]. $ Questa soluzione esegue prima la codifica di ogni lista di adiacenza e poi la codifica dei risultati del passo precedente.
- *matrice di adiacenza*: per ogni cella $m_(i j)$ della matrice $|V| times |V|$, dove $V$ é l'insieme dei vertici, si ha:
  - $1$ se esiste un arco dal vertice $i$ al vertice $j$;
  - $0$ altrimenti;
  Essendo questa una matrice la andiamo a codificare come abbiamo già descritto.

==== Applicazioni

Una volta visto come rappresentare le principali strutture dati, é facile trovare delle vie per codificare qualsiasi tipo di dato in un numero. Vediamo alcuni esempi.

===== Testi

Dato un *testo*, possiamo ottenere la sua codifica nel seguente modo:
+ trasformiamo il testo in una lista di numeri tramite la codifica ASCII dei singoli caratteri;
+ sfruttiamo l'idea dietro la codifica delle liste per codificare quanto ottenuto.

Per esempio, $ "ciao" = [99, 105, 97, 111] = <99, <105, <97, <111, 0>>>. $

Possiamo chiederci:
- _Il codificatore proposto é un buon compressore?_ \ No, si vede facilmente che il numero ottenuto tramite la funzione coppia (o la sua concatenazione) sia generalmente molto grande, e che i bit necessari a rappresentarlo crescano esponenzialmente sulla lunghezza dell'input. Ne segue che questo è un _pessimo_ modo per comprimere messaggi.
- _Il codificatore proposto é un buon sistema crittografico?_ \ La natura stessa del processo garantisce la possibilità di trovare un modo per decifrare in modo analitico, di conseguenza chiunque potrebbe, in poco tempo, decifrare il mio messaggio. Inoltre, questo metodo é molto sensibile agli errori.

===== Suoni

Dato un *suono*, possiamo _campionare_ il suo segnale elettrico a intervalli di tempo regolari e codificare la sequenza dei valori campionati tramite liste o array.

===== Immagini

Per codificare le *immagini* esistono diverse tecniche, ma la più usata é la *bitmap*: ogni pixel contiene la codifica numerica di un colore, quindi posso codificare separatamente ogni pixel e poi codificare i singoli risultati insieme tramite liste o array.

=== Conclusioni

Abbiamo mostrato come i dati possano essere _"buttati via"_ in favore delle codifiche numeriche associate ad essi. 

Di conseguenza, possiamo sostituire tutte le funzioni $f: dati arrow.long dati_bot$ con delle funzioni $f': NN arrow NN_bot$. In altre parole, l'universo dei problemi per i quali cerchiamo una soluzione automatica è rappresentabile dall'insieme $NN_bot^NN.$
