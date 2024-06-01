// Setup

#import "@preview/ouset:0.1.1": overset

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

#show thm-selector("thm-group", subgroup: "proof"): it => block(
  it,
  stroke: green + 1pt,
  inset: 1em,
  breakable: true
)

#import "alias.typ": *

// Appunti

= Lezione 17

== Insiemi ricorsivamente numerabili ma non ricorsivi

Un esempio di insieme che non è ricorsivo, ma è ricorsivamente numerabile, è identificato dal problema dell'*arresto ristretto*.

Infatti, l'insieme $ A = {x in NN bar.v phi_x (x) arrow.b} $ non è ricorsivo, altrimenti il problema dell'arresto ristretto sarebbe decidibile.

Tuttavia, questo insieme è *ricorsivamente numerabile*: infatti, il programma $ P equiv & "input"(x) \ & U(x,x); \ & "output"(1) $ decide parzialmente $A$. Come possiamo vedere, se $x in A$ allora $phi_x (x) arrow.b$, ovvero l'interprete universale $U$ termina, e il programma $P$ restituisce $1$, altrimenti non termina. 

Di conseguenza $ phi_P (x) = cases(1 & "se" phi_U (x,x) = phi_x (x) arrow.b, bot quad & "altrimenti") quad . $

Dato che $A = dominio(phi_P in cal(P))$ posso applicare la seconda caratterizzazione data nella lezione precedente per dimostrare che l'insieme $A$ è un insieme ricorsivamente numerabile.

Alternativamente, possiamo dire che $ A = {x in NN bar.v phi_x (x) arrow.b} = {x in NN bar.v exists y in NN bar,v (x,y) in R_ristretto}, $ con $ R_ristretto = {(x,y) bar.v ristretto "su input" x "termina entro" y "passi"} $ relazione ricorsiva. Qui possiamo sfruttare la terza caratterizzazione degli insiemi ricorsivamente numerabili.

== Ricorsivi vs ricorsivamente numerabili

#theorem(numbering: none)[
  Se $A subset.eq NN$ è ricorsivo allora è ricorsivamente numerabile.
]

#proof[
  \ Se $A$ è ricorsivo esiste un programma $P$ che è in grado di riconoscerlo, ovvero un programma che restituisce $1$ se $x in A$, altrimenti restituisce $0$.

  Il programma $P$ è del tipo $ P equiv & "input"(x) \ & "if"(P_A(x) == 1) \ & quad quad "output"(1) \ & "else" \ & quad quad "while"(1>0); quad . $

  La semantica di questo programma è $ phi_(P_A) (x) = cases(1 & "se" x in A, bot quad & "se" x in.not A) quad , $ ma allora $A$ è il dominio di una funzione ricorsiva parziale, quindi $A$ è ricorsivamente numerabile per la seconda caratterizzazione.
]

Poco fa abbiamo mostrato come $A = {x in NN bar.v phi_x (x) arrow.b}$ sia un insieme ricorsivamente numerabile ma non ricorsivo, ma allora vale $ "Ricorsivi" subset "Ricorsivamente numerabili" . $

#figure(
  image("../assets/ricorsivi-rnumerabili-1.svg", width: 50%)
)

_Esistono insiemi che non sono ricorsivamente numerabili?_

== Chiusura degli insiemi ricorsivi

Cerchiamo di sfruttare l'operazione di complemento di insiemi sui ricorsivamente numerabili per vedere di che natura è l'insieme $ A^C = {x in NN bar.v phi_x (x) arrow.t} . $

#theorem(numbering: none)[
  La classe degli insiemi ricorsivi è un'Algebra di Boole, ovvero è chiusa per complemento, intersezione e unione.
]

#proof[
  \ Siano $A,B$ due insiemi ricorsivi. Allora esistono dei programmi $P_A, P_B$ che li riconoscono o, equivalentemente, esistono $chi_A, chi_B in cal(T)$.

  È facile dimostrare che le operazioni di unione, intersezione e complemento sono facilmente implementabili da programmi che terminano sempre. Di conseguenza, $ A union B, A sect B, A^C $ sono ricorsive .

  // Da sistemare
  Vediamo questi tre programmi:
  - *complemento* $ P_(A^C) equiv & "input"(x) \ & "output"(1 overset(-, .) P_A (x)) . $
  - *intersezione* $ P_(A sect B) equiv & "input"(x) \ & "output"(min(P_A (x), P_B (x))) . $
  - *unione* $ P_(A union B) equiv & "input"(x) \ & "output"(max(P_A (x), P_B (x))) . $

  Allo stesso modo possiamo trovare le funzioni caratteristiche delle tre operazioni:
  - $chi_(A^C) (x) = 1 overset(-, .) chi_A (x)$;
  - $chi_(A sect B) = chi_A (x) dot chi_B (x)$;
  - $chi_(A union B) = 1 overset(-, .) (1 overset(-, .) chi_A (x))(1 overset(-, .) chi_B (x))$.
  
  Tutte queste funzioni sono ricorsive totali, quindi anche le funzioni $A^C, A sect B, A union B$ sono ricorsive totali.
]

Ora, però, vediamo un risultato molto importante riguardante nello specifico il complemento dell'insieme dell'arresto $A^C$ che abbiamo definito prima.

#theorem(numbering: none)[
  $A^C$ non è ricorsivo.
]

#proof[
  \ Se $A^C$ fosse ricorsivo, per la proprietà di chiusura dimostrata nel teorema precedente, avremmo $ (A^C)^C = A $ ricorsivo, il che è assurdo.
]

Ricapitolando abbiamo:
- $A = {x : phi_x (x) arrow.b}$ ricorsivamente numerabile, ma non ricorsivo;
- $A^C = {x : phi_x (x) arrow.t}$ non ricorsivo.

_L'insieme $A^C$ Potrebbe essere ricorsivamente numerabile?_

#theorem(numbering: none)[
  Se $A$ è ricorsivamente numerabile e $A^C$ è ricorsivamente numerabile allora $A$ è ricorsivo.
]

#proof[\
  \ *INFORMALE*

  Essendo $A, A^C$ ricorsivamente numerabili, esistono due libri con infinite pagine su ognuna delle quali compare un elemento di $A$ (primo libro) e un elemento di $A^C$ (secondo libro).

  Per decidere l'appartenenza di $x$ ad $A$, possiamo utilizzare il seguente procedimento:
  + $"input"(x)$;
  + apriamo i due libri alla prima pagina;
    - se $x$ compare nel libro di $A$, stampa $1$,
    - se $x$ compare nel libro di $A^C$, stampa $0$,
    - se $x$ non compare su nessuna delle due pagine, voltiamo la pagina di ogni libro e ricominciamo.
  
  Questo algoritmo termina sempre dato che $x$ o sta in $A$ o sta in $A^C$, quindi prima o poi verrà trovato su uno dei due libri.

  Ma allora questo algoritmo riconosce $A$, quindi $A$ è ricorsivo.

  *FORMALE*

  // da aggiungere commenti
  Essendo $A, A^C$ ricorsivamente numerabili, esistono $f,g in cal(T)$ tali che $A = immagine(f) and A^C = immagine(g)$. Sia $f$ implementata dal programma $F$ e $g$ dal programma $G$. Il seguente programma riconosce $A$: $ P equiv & "input"(x) \ & i:= 0; \ & "while"("true") \ & quad quad "if" (F(i)=x) "output"(1); \ & quad quad "if" (G(i)=x) "output"(0); \ & quad quad i := i + 1; $

  Questo algoritmo termina per ogni input, in quanto $x in A$ o $x in A^C$. Possiamo concludere che l'insieme $A$ è ricorsivo.
]

Concludiamo immediatamente che $A^C$ *non* può essere ricorsivamente numerabile.

In generale, questo teorema ci fornisce uno strumento molto interessante per studiare le caratteristiche della riconoscibilità di un insieme $A$:
- se $A$ non è ricorsivo, potrebbe essere ricorsivamente numerabile;
- se non riesco a mostrarlo, provo a studiare $A^C$;
- se $A^C$ è ricorsivamente numerabile, allora per il teorema possiamo concludere che $A$ non è ricorsivamente numerabile.

// gigi: non so se serva
// tia: mo vediamo
== Situazione finale

#v(12pt)

#figure(
  image("../assets/ricorsivi-rnumerabili-2.svg", width: 50%)
)

#v(12pt)

== Chiusura degli insiemi ricorsivamente numerabili

#theorem(numbering: none)[
  La classe degli insiemi ricorsivamente numerabili è chiusa per unione e intersezione, ma non per complemento.
]

#proof[
  \ Per complemento, abbiamo mostrato che $A = {x : phi_x (x) arrow.b}$ è ricorsivamente numerabile, mentre $A^C = {x : phi_x (x) arrow.t}$ non lo è.

  Siano $A,B$ insiemi ricorsivamente numerabili. Esistono, perciò, $f, g in cal(T) bar.v A = immagine(f) and B = immagine(g)$. Sia $f$ implementata da $F$ e $g$ implementata da $G$. Siano 
  
  #grid(
    columns: (50%, 50%),
    
    align(center)[
      $ P_i equiv & "input"(x); \ & i := 0; \ & "while"(F(i) eq.not x) \ & quad i++; \ & i := 0; \ & "while"(G(i) eq.not x) \ & quad i++; \ & "output"(1); $
    ],
    
    align(center)[
      $ P_u equiv & "input"(x); \ & i := 0; \ & "while"("true") \ & quad "if" (F(i) = x) \ & quad quad "output"(1); \ & quad "if" (G(i) = x) \ & quad quad "output"(1); \ & quad i++; $
    ]
  )

  i due programmi che calcolano rispettivamente $A sect B$ e $A union B$. Le loro semantiche sono
  
  #grid(
    columns: (50%, 50%),

    align(center)[
      $ phi_(P_i) = cases(1 & "se" x in A sect B, bot quad & "altrimenti") $
    ],

    align(center)[
      $ phi_(P_u) = cases(1 & "se" x in A union B, bot quad & "altrimenti") $
    ]
  )
  da cui ricaviamo che

  #grid(
    columns: (50%, 50%),

    align(center)[
      $ A sect B = dominio(phi_P' in cal(P)) $
    ],

    align(center)[
      $ A union B = dominio(phi_P'' in cal(P)) $
    ]
  )
  
  I due insiemi sono quindi ricorsivamente numerabili per la seconda caratterizzazione.
]

== Teorema di Rice

Il *teorema di Rice* è un potente strumento per mostrare che gli insiemi appartenenti a una certa classe non sono ricorsivi.

Sia ${phi_i}$ un SPA. Un insieme (_di programmi_) $I subset.eq NN$ è un *insieme che rispetta le funzioni* se e solo se $ (a in I and phi_a = phi_b) arrow.long.double b in I . $

In sostanza, $I$ rispetta le funzioni se e solo se, data una funzione calcolata da un programma in $I$, allora $I$ contiene tutti i programmi che calcolano quella funzione.

Questi insiemi sono detti anche *chiusi per semantica*.

Per esempio, l'insieme $I = {x in NN bar.v phi_x (3) = 5}$ rispetta le funzioni. Infatti, $ underbracket(a in I, phi_a (3) = 5) and underbracket(phi_a = phi_b, phi_b (3) = 5) arrow.double b in I . $

#theorem(
  name: "Teorema di Rice",
  numbering: none
)[
  Sia $I subset.eq NN$ un insieme che rispetta le funzioni. Allora $I$ è ricorsivo solo se $I = emptyset.rev$ oppure $I = NN$.
]

Questo teorema ci dice che gli insiemi che rispettano le funzioni non sono mai ricorsivi, tolti i casi banali $emptyset.rev$ e $NN$.

#proof[
  Sia $I$ insieme che rispetta le funzioni con $I eq.not emptyset.rev$ e $I eq.not NN$. Assumiamo per assurdo che $I$ sia ricorsivo. 
  
  Dato che $I eq.not emptyset.rev$, esiste almeno un elemento $a in I$. Inoltre, dato che $I eq.not NN$, esiste almeno un elemento $overline(a) in.not I$.

  Definiamo la funzione $t : NN arrow.long NN$ come: $ t(n) = cases(overline(a) quad & "se" n in I, a & "se" n in.not I) . $

  Sappiamo che $t in cal(T)$ dato che è calcolabile dal programma $ P equiv & "input"(x); \ & "if"(P_I (n) = 1) \ & quad "output"(overline(a)); \ & "else" \ & quad "output"(a) $
  
  Visto che $t in cal(T)$, il _teorema di ricorsione_ assicura che in un SPA ${phi_i}$ esiste $d in NN$ tale che $ phi_d = phi_t(d) . $

  Per tale $d$ ci sono solo due possibilità rispetto a $I$:
  - se $d in I$, visto che $I$ rispetta le funzioni e $phi_d = phi_t(d)$ allora $t(d) in I$. Ma $t(d in I) = overline(a) in.not I$, quindi ho un assurdo;
  - se $d in.not I$ allora $t(d) = a in I$ ma $I$ rispetta le funzioni, quindi sapendo che $phi_d = phi_t(d)$ deve essere che $d in I$, quindi ho un assurdo.

  Assumere $I$ ricorsivo ha portato ad un assurdo, quindi $I$ non è ricorsivo.
]

=== Come mostrare che un insieme non è ricorsivo

Il teorema di Rice suggerisce un approccio per stabilire se un insieme $A subset.eq NN$ non è ricorsivo:
+ mostrare che $A$ rispetta le funzioni;
+ mostrare che $A eq.not emptyset.rev$ e $A eq.not NN$;
+ $A$ non è ricorsivo per Rice.

=== Limiti ala verifica automatica del software

Definiamo:
- *specifiche*: descrizione di un problema e richiesta per i programmi che devono risolverlo automaticamente. Un programma è _corretto_ se risponde alle specifiche;
- *problema*: _posso scrivere un programma $V$ che testa automaticamente se un programma sia corretto o meno?_

Il programma che vogliamo scrivere ha semantica $ phi_V (P) = cases(1 & "se" P "è corretto", 0 quad & "se" P "è errato") quad . $

Definiamo $ "PC" = {P bar.v P "è corretto"} . $ Osserviamo che esso rispetta le funzioni: infatti, $ underbracket(P in "PC", P "corretto") and underbracket(phi_P = phi_Q, Q "corretto") arrow.long.double Q in "PC" $

Ma allora PC non è ricorsivo. Dato ciò, la correttezza dei programmi non può essere testata automaticamente. Esistono, però, dei casi limite in cui è possibile costruire dei test automatici:
- specifiche del tipo _"nessun programma è corretto"_ generano $"PC" = emptyset.rev$;
- specifiche del tipo _"tutti i programmi sono corretti"_ generano $"PC" = NN$.

Entrambi gli insiemi PC sono ovviamente ricorsivi e quindi possono essere testati automaticamente.

Questo risultato mostra che non è possibile verificare automaticamente le *proprietà semantiche* dei programmi (_a meno di proprietà banali_).
