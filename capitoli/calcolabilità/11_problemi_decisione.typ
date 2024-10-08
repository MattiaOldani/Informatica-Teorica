#import "../alias.typ": *

#import "@preview/lemmify:0.1.5": *

#let (theorem, lemma, corollary, remark, proposition, example, proof, rules: thm-rules) = default-theorems(
  "thm-group",
  lang: "it",
)

#show: thm-rules

#show thm-selector("thm-group", subgroup: "theorem"): it => block(
  it,
  stroke: red + 1pt,
  inset: 1em,
  breakable: true,
)

#show thm-selector("thm-group", subgroup: "proof"): it => block(
  it,
  stroke: green + 1pt,
  inset: 1em,
  breakable: true,
)


= Problemi di decisione

Un *problema di decisione* è una domanda cui devo decidere se rispondere _SI_ o _NO_.

I problemi di decisione sono costituiti da tre elementi principali:
- *nome*: il nome del problema;
- *istanza*: dominio degli oggetti che verranno considerati;
- *domanda*: proprietà che gli oggetti del dominio possono soddisfare o meno. Dato un oggetto del dominio, devo rispondere _SI_ se soddisfa la proprietà, _NO_ altrimenti. In altre parole, è la *specifica* del problema di decisione.

Diamo ora una definizione più formale:
- *nome* $Pi$;
- *istanza* $x in D$ input;
- *domanda* $p(x)$ proprietà che $x in D$ può soddisfare o meno.

Se, per esempio, mi viene chiesto _"questo polinomio ha uno zero?"_ non devo dire _quale_ zero ha, ma solo _se lo ha_ o meno. Non devo esibire una *struttura* come risultato (cosa che avviene nei problemi di ricerca o di ottimizzazione), ma solo una risposta _SI/NO_.

== Esempi

Vediamo qualche esempio di problemi di decisione noti. L'assegnamento di un valore a $x in D$ genera un'*istanza particolare* del problema:

1. *Parità*
- Nome: Parità.
- Istanza: $n in NN$.
- Domanda: $n$ è pari?

2. *Equazione diofantea*
- Nome: Equazione Diofantea.
- Istanza: $a,b,c in NN^+$.
- Domanda: $exists x,y in ZZ bar.v a x + b y = c$?

Questa domanda nei reali avrebbe poco senso, perché ci sarebbero infiniti punti che soddisfano l'equazione della retta. Considerando punti interi, invece, ha più senso in quanto niente garantisce che la retta ne abbia.

Ad esempio, per $a=3$, $b=4$ e $c=5$ rispondo _SI_, visto che la proprietà vale per $x = -1$ e $y = 2$.

Il nome di queste equazioni deriva dal matematico Diofanto, che per primo le trattò nel contesto dell'aritmetica di, appunto, Diofanto.

3. *Fermat*
- Nome: Ultimo Teorema di Fermat.
- Istanza: $n in NN^+$.
- Domanda: $exists x,y,z in NN^+ bar.v x^n + y^n = z^n$?

Questo problema è, in un certo senso, riconducibile al precedente.

Per $n = 1$ rispondo _SI_: è facile trovare tre numeri tali che $x + y = z$, ne ho infiniti.

Per $n = 2$ rispondo _SI_, i numeri nella forma $x^2 + y^2 = z^2$ rappresentano le *terne pitagoriche*.

Per $n gt.eq 3$ rispondo _NO_, è stato dimostrato da Eulero.

Questo problema è rimasto irrisolto per circa 400 anni, fino a quando nel 1994 viene dimostrato il *teorema di Andrew-Wiles* (dall'omonimo matematico), come banale conseguenza di una dimostrazione sulla modularità delle curve ellittiche.

Si dice che il primo a risolvere questo problema sia stato Fermat, giurista che nel tempo libero giocava con la matematica, tanto da meritarsi il nome di _principe dei dilettanti_, lo dimostra il fatto che questo teorema non ha nessuna conseguenza pratica, è totalmente "inutile".

4. *Raggiungibilità*
- Nome: Raggiungibilità.
- Istanza: grafo $G = ({1,dots,n}, E)$.
- Domanda: $exists pi$ cammino dal nodo $1$ al nodo $n$?

5. *Circuito hamiltoniano*
- Nome: Circuito Hamiltoniano.
- Istanza: grafo $G = (V,E)$.
- Domanda: $exists gamma$ circuito hamiltoniano nel grafo $G$?

Un *circuito hamiltoniano* è un circuito che coinvolge ogni nodo una e una sola volta.

6. *Circuito euleriano*
- Nome: Circuito Euleriano.
- Istanza: grafo $G = (V,E)$.
- Domanda: $exists gamma$ circuito euleriano nel grafo $G$?

Un *circuito euleriano* è un circuito che coinvolge ogni arco una e una sola volta. Questo quesito ha dato via alla teoria dei grafi.

== Decidibilità

Sia $Pi$ problema di decisione con istanza $x in D$ e domanda $p(x)$. $Pi$ è *decidibile* se e solo se esiste un programma $P_Pi$ tale che

#v(12pt)

#figure(
  image("assets/decidibilità.svg", width: 50%),
)

#v(12pt)

Allo stesso modo, possiamo associare a $Pi$ la sua *funzione soluzione*: $ Phi_Pi : D arrow.long {0,1} $ tale che $ Phi_Pi (x) = cases(1 & "se" p(x), 0 quad & "se" not p(x)) quad . $

Questa funzione deve essere programmabile e deve terminare sempre, ma allora $Phi_Pi in cal(T)$.

I due approcci per definire la decidibilità sono equivalenti:
- il programma $P_Pi$ calcola $Phi_Pi$, quindi $Phi_Pi in cal(T)$;
- se $Phi_Pi in cal(T)$ allora esiste un programma che la calcola e che ha il comportamento di $P_Pi$.
Quindi, definire la decidibilità partendo da un programma o da una funzione ricorsiva parziale, è indifferente: una definizione implica l'altra.

Possiamo sfruttare questa cosa per sviluppare due tecniche di risoluzione del problema Decidibilità:
+ esibiamo un algoritmo di soluzione $P_Pi$ (anche inefficiente, basta che esista);
+ mostriamo che $Phi_Pi$ è ricorsiva totale.

== Applicazione agli esempi

1. *Parità*
$ Phi_("PR") (n) = 1 overset(-,.) (n mod 2) in cal(T). $

2. *Equazione diofantea*
$ Phi_("ED") (a,b,c) = 1 overset(-,.) (c mod "mcd"(a,b)) in cal(T). $

3. *Fermat*
$ Phi_F (n) = 1 overset(-,.) (n overset(-,.) 2) in cal(T). $

4. *Raggiungibilità*
  \ Sia $M_G in {0,1}^(n times n)$ matrice di adiacenza tale che $M_G [i,j] = 1$ se e solo se $(i,j) in E$. Inoltre, $M_G^k$ ha un 1 nella cella $[i,j]$ sse esiste un cammino lungo $k$ da $i$ a $j$.

  $ Phi_R (G) = (or.big_(k=0)^n M_G^k)[1,n] in cal(T). $

5. *Circuito hamiltoniano*
  \ Dovendo visitare ogni nodo una e una sola volta, il circuito genera una permutazione dei vertici in $V$. L'algoritmo di soluzione deve:
  + generare l'insieme $P$ di tutte le permutazioni di $V$;
  + data la permutazione $p_i in P$, se è un circuito hamiltoniano rispondo _SI_;
  + se nessuna permutazione $p_i$ è un circuito hamiltoniano rispondo _NO_.

  L'algoritmo è inefficiente perché ci mette un tempo $O(n!)$, vista la natura combinatoria del problema, ma sicuramente questo problema è decidibile.

6. *Circuito euleriano*
#theorem(
  name: "Teorema di Eulero (1936)",
  numbering: none,
)[
  Un grafo $G = (V,E)$ contiene un circuito euleriano se e solo se ogni vertice in $G$ ha grado pari.
]

Grazie a questo risultato, l'algoritmo di risoluzione deve solo verificare se il grado di ogni vertice in $V$ è pari, quindi anche questo problema è decidibile.

== Problemi indecidibili

_Ma esistono dei *problemi indecidibili*?_

// Lo lascerò
#align(center)[
  #block(
    fill: rgb("#9FFFFF"),
    inset: 8pt,
    radius: 4pt,

    [*PEFFORZA*],
  )
]

Se esistono programmi che non so scrivere allora esistono problemi per i quali non riesco a scrivere dei programmi che li risolvano.

=== Problema dell'arresto ristretto

Il *problema dell'arresto ristretto* per un programma $P$ è un esempio di problema indecidibile.

Fissato $P$ un programma, il problema è il seguente:
- Nome: $arresto(P)$.
- Istanza: $x in NN$.
- Domanda: $phi_P (x) arrow.b$?

In altre parole, ci chiediamo se il programma $P$ termina su input $x$. La risposta dipende ovviamente dal programma $P$, che può essere decidibile o non decidibile.

Ad esempio, se $ P_1 equiv & "input"(x) \ & x := x + 1; \ & "output"(x) $ allora la funzione $ Phi_(arresto(P_1)) (x) = 1 in cal(T) $ ci dice quando il problema $P_1$ termina o meno (_sempre_).

Se invece $ P_2 equiv & "input"(x) \ & "if" (x mod 2 eq.not 0) \ & quad "while" (1 > 0); \ & "output"(x) $ allora la funzione $ Phi_(arresto(P_2)) (x) = 1 overset(-,.) (x mod 2) in cal(T) $ ci dice quando il problema $P_2$ termina o meno.

Abbiamo quindi trovato due funzioni $Phi_(arresto(P)) in cal(T)$ che ci dicono quando i programmi $P_1$ e $P_2$ terminano o meno, _ma è sempre possibile?_

Prendiamo ora $ ristretto equiv & "input"(x) \ & z := U(x,x); \ & "output"(z), $ con $U$ interprete universale tale che $ phi_U (x,n) = phi_n (x). $ Vale allora $ phi_(ristretto) (x) = phi_U (x,x) = phi_x (x). $

Abbiamo, quindi, un programma $x$ che lavora su un altro programma (_se stesso_). Questo non è strano: compilatori, debugger, interpreti sono programmi che lavorano su programmi.

Come prima mi chiedo se $phi_x$ su input $x$ termina. A differenza di prima, ora il programma $P$ non è fissato e dipende dall'input, essendo $x$ sia input che programma.

#theorem(numbering: none)[
  Dato $ ristretto equiv & "input"(x) \ & z := U(x,x); \ & "output"(z), $ $arresto(ristretto)$ è indecidibile.
]

#proof[
  \ Per assurdo assumiamo $arresto(ristretto)$ decidibile. Dunque esiste $ Phi_(arresto(ristretto)) (x) = cases(1 & "se" phi_ristretto (x) = phi_x (x) arrow.b, 0 quad & "se" phi_(ristretto) (x) = phi_x (x) arrow.t) quad in cal(T) $ calcolabile da un programma che termina sempre. Visto che $Phi_(ristretto) in cal(T)$, anche la funzione $ f(x) = cases(0 & "se" Phi_(arresto(ristretto)) (x) = 0 equiv phi_x (x) arrow.t, phi_x (x) + 1 quad & "se" Phi_(arresto(ristretto)) (x) = 1 equiv phi_x (x) arrow.b) $ è ricorsiva totale. Infatti, il programma $ A equiv & "input"(x) \ & "if" (Phi_(arresto(ristretto) (x)) == 0) \ & quad "output"(0) \ & "else" \ & quad "output"(U(x,x) + 1) $ calcola esattamente la funzione $f(x)$.

  Sia $alpha in NN$ la codifica del programma $A$, allora $phi_alpha = f$. Valutiamo $phi_alpha$ in $alpha$: $ phi_alpha (alpha) = cases(0 & "se" phi_alpha (alpha) arrow.t, phi_alpha (alpha) + 1 quad & "se" phi_alpha (alpha) arrow.b) quad . $

  Tale funzione non può esistere, infatti:
  - nel primo caso ho $phi_alpha (alpha) = 0$ se non termino, ma è una contraddizione perché $A in cal(T)$;
  - nel secondo caso ho $phi_alpha (alpha) = phi_alpha (alpha) + 1$ se termino, ma è una contraddizione perché questa relazione non vale per nessun naturale.

  Siamo ad un *assurdo*, quindi concludiamo che $arresto(ristretto)$ deve essere *indecidibile*.
]

=== Problema dell'arresto

La versione generale del problema dell'arresto ristretto è il *problema dell'arresto*, posto nel 1936 da Alan Turing.

#theorem(numbering: none)[
  Dati $x,y in NN$ rispettivamente un dato e un programma, il problema dell'arresto AR con domanda $phi_y (x) arrow.b$ è indecidibile.
]

#proof[
  \ Assumiamo per assurdo che AR sia decidibile, ma allora esiste un programma $P_("AR") (x,y)$ che lo risolve, quindi restituisce:
  - 1 se $phi_y (x) arrow.b$;
  - 0 altrimenti.

  Il seguente programma decide AR: $ P equiv & "input"(x,y) \ & "output"(P_("AR") (x,x)) quad . $

  Il risultato precedente dimostra che questo problema è indecidibile, quindi non possono esistere programmi per la soluzione di AR. Siamo ancora ad un *assurdo*, quindi AR è *indecidibile*.
]
