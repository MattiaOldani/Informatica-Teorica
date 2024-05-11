// Setup

#import "@preview/ouset:0.1.1": overset

#import "@preview/algo:0.3.3": code

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

#show thm-selector("thm-group", subgroup: "corollary"): it => block(
  it,
  stroke: red + 1pt,
  inset: 1em,
  breakable: true
)

#show thm-selector("thm-group", subgroup: "proof"): it => block(
  it,
  stroke: green + 1pt,
  inset: 1em,
  breakable: true
)

#import "alias.typ": *

// Appunti

= Lezione 17

// gigi: controlla la gerarchia di capitoli non so come cazzo metterli porco dio

== Arresto ricorsivamente numerabile

// gigi: non so se mi piace ricordare ancora il problema dell'arresto ristretto, secondo me non serve tanto lo abbiamo già visto molte volte. Leverei nome/istanza/domanda e passerei direttamente alla riga che ti marco con un #
Un esempio di insieme che non è ricorsivo, ma è ricorsivamente numerabile è identificato dal problema dell'arresto ristretto, che era così definito:
- nome: $arresto(ristretto)$
- istanza: $x in NN$
- domanda: $phi_ristretto (x) = phi_x (x) arrow.b$?
/*#*/L'insieme $A = {x : phi_x (x) arrow.b}$ non è ricorsivo, altrimenti sarebbe decidibile. Tuttavia, è *ricorsivamente numerabile*, infatti il seguente programma $ P equiv & "input"(x); \ & U(x,x); \ & "output"(1) $ sfrutta il fatto che se $x in A$, allora $phi_x (x) arrow.b$ (quindi l'interprete universale termina) e il programma $P$ restituisce $1$, altrimenti non termina. Di conseguenza: $ phi_P (x) = cases(1 & quad "se" phi_U (x,x) = phi_x (x) arrow.b \ bot & quad "altrimenti"). $

// gigi: con "caratterizzazioni" mi riferisco agli statement dell'ultimo teo della lezione 16, non so come chiamarli, il prof ha usato questo termine
Dato che $A = "Dom"_(phi_P in cal(P))$, posso applicare la seconda caratterizzazione per dimostrare che l'insieme dell'arresto è un insieme ricorsivamente numerabile.

Alternativamente, possiamo dire che $A = {x : phi_x (x) arrow.b} = {x : exists y : (x,y) in R_ristretto}$ con relazione ricorsiva $R_ristretto = {(x,y) : ristretto "su input" x "termina entro" y "passi"}$ e qui possiamo sfruttare la terza caratterizzazione degli insiemi ricorsivamente numerabili.

== Ricorsivi vs Ricorsivamente numerabili

#theorem(numbering: none)[
  $A subset.eq NN$ ricorsivo $arrow.double A$ ricorsivamente numerabile.
]

#proof[
  $A$ ricorsivo implica che esiste un programma che è in grado di riconoscerlo.
  
  $ x in NN arrow.long.squiggly P (x) = cases(1 & "se" x in A \ 0 & "se" x in.not A) $

  dove $P$ è di questo tipo:

  $ P equiv & "input"(x); \ & "if"(P_A(x) = 1) \ & quad quad "output"(1); \ & "else" \ & quad quad "while"(1>0); $

  Di conseguenza, $A$ è il dominio di una funzione ricorsiva parziale $arrow.double$ $A$ è ricorsivamente numerabile per la seconda caratterizzazione.
]

#grid(
  columns: (1fr, 1fr),
  align(center)[
    #figure(
        image("../assets/ricorsivi-ricorsivamenteNumerabili.svg", width: 60%)
    )
  ],
  align(center + horizon)[
    $A = {x in NN: phi_x (x) arrow.b}$ non è ricorsivo, ma è ricorsivamente numerabile $arrow.double$ $ "Ricorsivi" subset "Ric. numerabili" $
  ]
)

_ Ma esistono insiemi non ricorsivamente numerabili?_\

=== Chiusura degli insiemi ricorsivi

Cerchiamo di sfruttare l'operazione di complemento degli insiemi sui ricorsivamente numerabili per vedere di che natura è l'insieme.
$ A^C = {x in NN : phi_x (x) arrow.t}?? $

#theorem(numbering: none)[
  La classe degli insiemi ricorsivi è un'Algebra di Boole (i.e. chiusa per complemento, intersezione e unione).
]

#proof[
  Siano $A,B$ ricorsivi. Allora esistono dei programmi $P_A, P_B$ che li riconoscono (o equivalentemente esistono $chi_A, chi_B in cal(T)$).

  È facile dimostrare che le operazioni di unione, intersezione e complemento sono facilmente implementabili da programmi che terminano sempre.
  Di conseguenza $A union B, A sect B, A^C$ sono ricorsive.

  Ecco tre esempi di programmi che calcolano le tre funzioni insiemistiche:
  + Complemento: 
  $ P_(A^C) equiv & "input"(x) \ & "output"(1 overset(-, .) P_A (x)) $
  + Intersezione: 
  $ P_(A sect B) equiv & "input"(x) \ & "output"(min(P_A (x), P_B (x))) $
  + Unione: 
  $ P_(A union B) equiv & "input"(x) \ & "output"(max(P_A (x), P_B (x))) $

  Allo stesso modo possiamo trovare le funzioni caratteristiche delle tre operazioni:
  + $chi_(A^C) (x) = 1 overset(-, .) chi_A (x)$
  + $chi_(A sect B) = chi_A (x) dot chi_B (x)$
  + $chi_(A union B) = 1 overset(-, .) (1 overset(-, .) chi_A (x))(1 overset(-, .) chi_B (x))$
  Tutte queste funzioni sono ricorsive totali $arrow.double$ le funzioni $A^C, A sect B, A union B$ sono ricorsive.
]

Ora, però, vediamo un risultato molto importante riguardante nello specifico il complemento dell'insieme dell'arresto $A^C = {x in NN : phi_x (x) arrow.b}$.

#theorem(numbering: none)[
  $A^C$ non è ricorsivo.
]

#proof[
  Se $A^C$ fosse ricorsivo, per la proprietà di chiusura dimostrata nel teorema precedente, avremmo $(A^C)^C=A$ ricorsivo, il che è assurdo.
]

Ricapitolando abbiamo:
- $A = {x : phi_x (x) arrow.b}$ ricorsivamente numerabile, ma non ricorsivo;
- $A^C = {x : phi_x (x) arrow.t}$ non ricorsivo. _Potrebbe essere ricorsivamente numerabile?_

#theorem(numbering: none)[
  ($A$ ricorsivamente numerabile, $A^C$ ricorsivamente numerabile) $arrow.double$ $A$ ricorsivo.
]

#proof[\
  *INFORMALE*:

  Essendo $A, A^C$ ricorsivamente numerabili, esiste un libro con infinite pagine su ognuna delle quali compare un elemento di $A$ ed esiste un libro analogo per $A^C$.

  Per decidere l'appartenenza ad $A$, possiamo utilizzare il seguente procedimento:
  + $"input"(x)$;
  + Apriamo i due libri alla prima pagina;
  + Se $x$ compare nel libro di $A$, stampa $1$,\
    Se $x$ compare nel libro di $A^C$, stampa $0$,\
    Se $x$ non compare su nessuna delle due pagine, voltiamo la pagina di ogni libro e rieseguiamo 3.
  Da notare che questo algoritmo termina sempre dato che $x$ o sta in $A$ o sta in $A^C$, quindi prima o poi verrà trovato su uno dei due libri.

  Dunque, l'algoritmo riconosce $A arrow.double A$ è ricorsivo

  *FORMALE*:

  Essendo $A, A^C$ ricorsivamente numerabili, esistono $f,g in cal(T)$ tali che $A="Im"_f, A^C="Im"_g$. Sia $f$ implementata dal programma $F$ e $g$ dal programma $G$. Il seguente programma riconosce $A$:

  $ P equiv & "input"(x) \ & i:= 0; \ & "while"("true") \ & quad quad "if"(F(i)=x) "output"(1); \ & quad quad "if"(G(i)=x) "output"(0); \ & quad quad i := i + 1; $

  Questo algoritmo termina per ogni input, in quanto $x in A$ o $x in A^C$. Possiamo concludere che l'insieme $A$ è ricorsivo.
]

Possiamo concludere immediatamente che $A^C = {x : phi_x (x) arrow.t}$ non può essere ricorsivamente numerabile.

In generale, questo teorema ci fornisce uno strumento molto interessante per studiare le caratteristiche della riconoscibilità di un insieme $A$:
- se $A$ non è ricorsivo, potrebbe essere ricorsivamente numerabile;
- se non riesco a mostrarlo, provo a studiare $A^C$;
- se $A^C$ è ricorsivamente numerabile, allora per il teorema possiamo concludere che $A$ non è ricorsivamente numerabile.

//gigi: non so se serva
== Situazione finale

#v(12pt)

#figure(
  image("../assets/ricorsivi-ricorsivamenteNumerabili2.svg", width: 50%)
)

#v(12pt)


== Chiusura degli insiemi ricorsivamente numerabili

#theorem(numbering: none)[
  La classe degli insiemi ricorsivamente numerabili è chiusa per unione e intersezione, ma non per complemento.
]

#proof[
  Per complemento, abbiamo mostrato che $A = {x : phi_x (x) arrow.b}$ è ricorsivamente numerabile, mentre $A^C = {x : phi_x (x) arrow.t}$ non lo è.

  Siano $A,B$ ricorsivamente numerabili. Esistono, perciò, $f, g in cal(T) : A = "Im"_f$ e $B = "Im"_g$. \
  Sia $f$ implementata da $F$ e $g$ implementata da $G$. Siano 
  #grid(
    columns: (1fr, 1fr),
    align(center)[
      $ P' equiv & "input"(x); \ & i := 0; \ & "while"(F(i) eq.not x) i++; \ & i := 0; \ & "while"(G(i) eq.not x) i++; \ & "output"(1); $
    ],
    align(center)[
      $ P'' equiv & "input"(x); \ & i := 0; \ & "while"("true") \ & quad quad "if"(F(i) = x) "output"(1); \ & quad quad "if"(G(i) = x) "output"(x); \ & quad quad i++; $
    ]
  )
  i due programmi che calcolano rispettivamente $A sect B$ e $A union B$. Le loro semantiche sono
  #grid(
    columns: (1fr, 1fr),
    align(center)[
      $ phi_(P') = cases(1 & quad "se" x in A sect B \ bot & quad "altrimenti") $
    ],
    align(center)[
      $ phi_(P'') = cases(1 & quad "se" x in A union B \ bot & quad "altrimenti") $
    ]
  )
  da cui ricaviamo che
  #grid(
    columns: (1fr, 1fr),
    align(center)[
      $ A sect B = "Dom"_(phi_P' in cal(P)) $
    ],
    align(center)[
      $ A union B = "Dom"_(phi_P'' in cal(P)) $
    ]
  )
  
  Entrambe le funzioni sono, dunque, ricorsive numerabili per la seconda caratterizzazione. 
]

== Teorema di Rice

Il teorema di Rice è un potente strumento per mostrare che gli insiemi appartenenti a una certa classe non sono ricorsivi. 

Sia ${phi_i}$ un spa.\
*Insiemi che rispettano le funzioni* $arrow I subset.eq NN$ (insieme di programmi) rispetta le funzioni sse $(a in I and phi_a = phi_b) arrow.double b in I$.

In sostanza, $I$ rispetta le funzioni sse data una funzione calcolata da un programma in $I$, allora $I$ contiene tutti i programmi che calcolano quella funzione.

//gigi: l'ho messo più per te, per farti capire. se vuoi possiamo anche lasciarlo però
Esempio:\
$I = {x in NN : phi_ (3) = 5}$ rispetta le funzioni. Infatti: $ underbrace(a in I, phi_a (3) = 5) and underbrace(phi_a = phi_b, phi_b (3) = 5 arrow.double b in I) $

#theorem(numbering: none, name: "Teorema di Rice")[
  Sia $I subset.eq NN$ un insieme che rispetta le funzioni. Allora $I$ è ricorsivo solo se $I = emptyset.rev$ oppure $I = NN$.
]

#proof[
  Sia $I$ che rispetta le funzioni con $I eq.not emptyset.rev$ e $I eq.not NN$. 
  
  _Per assurdo_, assumiamo che $I$ sia ricorsivo. 
  
  Dato che $I eq.not emptyset.rev$, esiste almeno un elemento $a in I$. Inoltre, dato che $I eq.not NN$, esiste almeno un elemento $overset(a, "-") in.not I$.

  Definiamo la funzione $t : NN arrow NN$ come:
  $ t(n) = cases(overset(a, "-") & quad "se" n in I \ a & quad "se" n in.not I) $

  Sappiamo che $t in cal(T)$, dato che è calcolabile dal seguente programma $ P equiv & "input"(x); \ & "if"(P_I (n) = 1) "output"(overset(a,-)); \ & "else output"(a) $
  Notiamo che $P$ si arresta sempre e calcola $t(n) arrow.double t in cal(T)$.\
  Il *teorema di Ricorsione* assicura in un spa ${phi_i}$ l'esistenza di un $d in NN$ tale che $ phi_d = phi_t(d) $
  Per tale $d$, ci sono solo due possibilità rispetto a $I$:
  - $d in I$:\
    dato che $I$ rispetta le funzioni e $phi_d = phi_t(d)$, allora $t(d)$ devve essere in $I$. Ma $t(d)=overset(a,-) in.not I arrow.double$ *contraddizione*;
  - $d in.not I$:\
    $t(d)=a in I$ e $I$ rispetta le funzioni. Dato che $phi_d = phi_t(d)$, devve essere che $d in I arrow.double$ *contraddizione*.

  Assumere $I$ ricorsivo ha portato ad un assurdo.
]

=== Mostrare che un insieme non è ricorsivo

Il teorema di Rice suggerisce un approccio per stabilire se un insieme $A subset.eq NN$ *non è ricorsivo*:
+ Mostrare che $A$ rispetta le funzioni;
+ Mostrare che $A eq.not emptyset.rev$ e $A eq.not NN$;
+ $A$ non è ricorsivo per Rice.

=== Limiti verifica automatica del software

Definiamo:
- *specifiche* = descrizione di un problema e richiesta per i programmi che devono risolverlo automaticamente. Un programma è _corretto_ se risponde alle specifiche;
- *problema* = _Posso scrivere un programma $V$ che testa automaticamente se un programma sia corretto o meno?_

  $ P arrow.squiggly V(P) = cases(1 & quad "se" P "è corretto" \ 0 & quad "se" P "è errato") $

Chiamiamo $PC = {P : P "è corretto"}$. Osserviamo che esso rispetta le funzioni $ underbrace(P in PC, P "è corretto") and underbrace(phi_P = phi_P', P' "è corretto") arrow.double P' in PC arrow.double PC "non è ricorsivo" $

Dato che $PC$ non è ricorsivo, la correttezza dei programmi non può essere testata automaticamente.

Esistono, però, dei casi limite in cui è possibile costruire dei test automatici:
- specifiche = "nessun programma è corretto" $arrow.double$ $PC = emptyset.rev$
- specifiche = "tutti i programmi sono corretto" $arrow.double$ $PC = NN$
entrambi i $PC$ sono ovviamente ricorsivi e quindi possono essere testati automaticamente.