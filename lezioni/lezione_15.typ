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

= Lezione 15

== Problemi di decisione

=== Introduzione

Un *problema di decisione* è una domanda cui devo decidere se rispondere _SI_ o _NO_.

I problemi di decisione sono formati da 3 _"ingredienti"_:
- *nome*: nome del problema;
- *istanza* (generica): dominio degli oggetti che verranno considerati;
- *domanda*: proprietà che gli oggetti del dominio possono soddisfare o meno. Dato un oggetto del dominio, devo risponde _SI_ se soddisfa la proprietà, _NO_ altrimenti. In poche parole, è la *specifica* del problema di decisione.

In modo formale:
- *nome*: $Pi$;
- *istanza*: $x in D$ detto anche input;
- *domanda*: $p(x)$ proprietà che l'oggetto $x in D$ può o meno soddisfare.

La domanda che viene posta è solo _SI_ o _NO_. Ad esempio, se mi viene chiesto _"questo polinomio ha uno zero?"_ non devo dire _quale_ zero ha, ma solo se ce l'ha o meno. In poche parole, non devo esibire una *struttura* come risultato (questo avviene nei problemi di ricerca e/o ottimizzazione) ma solo una risposta _SI_ o _NO_.

// Modo bruttissimo di fare le liste
// Senza sta cosa usciva un indice enorme

=== Esempi

Vediamo qualche esempio di problema di decisione noto. L'assegnamento di un valore a $x in D$ genera un'*istanza particolare* del problema.

1. *Parità*

- Nome: parità.
- Istanza: $n in NN$.
- Domanda: $n$ è pari?

2. *Equazione diofantea*

- Nome: equazione diofantea.
- Istanza: $a,b,c in NN^+$.
- Domanda: $exists x,y in ZZ bar.v a x + b y = c$?

Questa domanda nei reali ha poco senso perché l'equazione rappresenta una retta, che ha infiniti punti che soddisfano l'equazione. In questo caso parliamo di punti interi.

Ad esempio, per $a=3$, $b=4$ e $c=5$ rispondo _SI_: la proprietà vale per $x = -1$ e $y = 2$.

Il nome di queste equazioni deriva dal matematico *Diofanto* che per primo trattò queste equazioni, dette appunte diofantee, nel contesto dell'aritmetica di Diofanto.

3. *Fermat*

- Nome: ultimo teorema di Fermat.
- Istanza: $n in NN^+$.
- Domanda: $exists x,y,z in NN^+ bar.v x^n + y^n = z^n$?

Per $n = 1$ rispondo _SI_: è facile trovare tre numeri tali che $x + y = z$, ne ho infiniti.

Per $n = 2$ rispondo _SI_, i numeri nella forma $x^2 + y^2 = z^2$ rappresentano le *terne pitagoriche*.

Per $n = 3$ rispondo _NO_, è stato dimostrato da Eulero.

Per circa 400 anni questo problema è rimasto irrisolto, ma poi nel 1994 Andrew Wiles riesce a dimostrare quello che ora si chiama il *teorema di Andrew-Wiles* grazie ad una banale conseguenza di una dimostrazione della modularità delle curve ellittiche.

Il teorema originale è stato "dimostrato" da Fermat, giurista che _per il meme_ si dilettava nella matematica, tanto da meritarsi il nome di _principe dei dilettanti_. Era così dilettante che questo teorema non ha nessuna conseguenza, è totalmente inutile.

4. *Raggiungibilità*

- Nome: raggiungibilità.
- Istanza: grafo $G = ({1,dots,n}, E)$.
- Domanda: esiste un cammino dal nodo $1$ al nodo $n$?

5. *Circuito hamiltoniano*

- Nome: circuito hamiltoniano.
- Istanza: grafo $G = (V,E)$.
- Domanda: esiste un circuito hamiltoniano nel grafo $G$?

Un *circuito hamiltoniano* è un circuito che coinvolge ogni nodo una e una sola volta.

6. *Circuito euleriano*

- Nome: circuito euleriano.
- Istanza: grafo $G = (V,E)$.
- Domanda: esiste un circuito euleriano nel grafo $G$?

Un circuito euleriano è un circuito che coinvolge ogni arco una e una sola volta. Questo quesito ha dato via alla teoria dei grafi.

=== Definizione

// Fare la freccia fatta bene
Sia $Pi$ problema di decisione con istanza $x in D$ e domanda $p(x)$, $Pi$ è decidibile se e solo se esiste un programma $P_Pi$ tale che $ & quad arrow.long 1 "se" p(x) \ forall x in D arrow.long.squiggly P_Pi \ & quad arrow.long 0 "se" not p(x) quad . $

Equivalentemente, associamo a $Pi$ la sua funzione soluzione $ Phi_Pi : D arrow.long {0,1} $ tale che $ Phi_Pi (x) = cases(1 & "se" p(x), 0 quad & "se" not p(x)) $

Che caratteristiche deve avere questa funzione soluzione? Sicuramente deve essere _ricorsiva totale_ perché deve essere programmabile e deve terminare sempre.

// Da capire bene
Le due definizioni date sono equivalenti:
- il programma $P_Pi$ calcola $Phi_Pi$ quindi $Phi_Pi in cal(T)$;
- se $Phi_Pi in cal(T)$ allora esiste un programma che la calcola e che ha il comportamento di $P_Pi$.

Quindi, dato il problema di decisione $Pi$, posso dimostrarne la decidibilità:
+ esibendo un algoritmo di soluzione $P_Pi$ (anche inefficiente, basta che esista) oppure
+ mostrando che $Phi_Pi$ è ricorsiva totale.

=== Applicazione agli esempi

1. *Parità*

$ Phi_("PR") (n) = 1 overset(-,.) (n mod 2) in cal(T). $

2. *Equazione diofantea*

$ Phi_("ED") (a,b,c) = 1 overset(-,.) (c mod "mcd"(a,b)) in cal(T). $

3. *Fermat*

$ Phi_F (n) = 1 overset(-,.) (n overset(-,.) 2) in cal(T). $

4. *Raggiungibilità*

Sia $M_G in {0,1}^(n times n)$ matrice di adiacenza tale che $M_G [i,j] = 1$ se e solo se $(i,j) in E$. Questo approccio è molto comodo perché $M_G^k$ se ha un 1 nella cella $[i,j]$ indica che esiste un cammino lungo $k$ da $i$ a $j$.

$ Phi_R (G) = (or.big_(k=0)^n M_G^k)[1,n] in cal(T). $

5. *Circuito hamiltoniano*

Dovendo visitare ogni nodo una e una sola volta, il circuito genera una permutazione dei vertici in $V$. L'algoritmo di soluzione deve:
+ generare tutte le permutazioni $P$ di $V$;
+ data la permutazione $p_i in P$, se è un circuito hamiltoniano rispondo _SI_;
+ se nessuna permutazione $p_i$ è un circuito hamiltoniano rispondo _NO_.

L'algoritmo è inefficiente perché ci mette un tempo $O(n!)$, vista la natura combinatoria del problema, ma sicuramente questo problema è decidibile.

6. *Circuito euleriano*

#theorem(
  name: "Teorema di Eulero (1936)",
  numbering: none
)[
  Un grafo $G = (V,E)$ contiene un circuito euleriano se e solo se ogni vertice in $G$ ha grado pari.
]

Grazie a questo teorema, l'algoritmo per questo problema deve solo verificare se il grado di ogni vertice in $V$ è pari, quindi anche questo problema è decidibile.

=== Problemi indecidibili

Ma esistono dei *problemi indecidibili*?

*PEFFORZA*, se esistono programmi che non so scrivere allora esistono problemi per i quali non riesco a scrivere dei programmi che li risolvano.

==== Problema dell'arresto ristretto

Il *problema dell'arresto ristretto* per un programma $P$ è un problema indecidibile.

Fissato $P$ un programma, definiamo il problema:
- Nome: $arresto(P)$.
- Istanza: $x in NN$.
- Domanda: $phi_P (x) arrow.b$?

In poche parole, ci chiediamo se il programma $P$ termina su input $x$.

La risposta dipende dal programma $P$: può essere decidibile o non decidibile.

Ad esempio, se $ P_1 equiv & "input"(x) \ & x := x + 1; \ & "output"(x) $ allora la funzione $ Phi_(arresto(P_1)) (x) = 1 in cal(T) $ ci dice quando il problema $P_1$ termina o meno (_sempre_).

Se invece $ P_2 equiv & "input"(x) \ & "if" (x mod 2 eq.not 0) \ & quad "while" (1 > 0); \ & "output"(x) $ allora la funzione $ Phi_(arresto(P_2)) (x) = 1 overset(-,.) (x mod 2) in cal(T) $ ci dice quando il problema $P_2$ termina o meno.

Abbiamo quindi trovato due funzioni $Phi_(arresto(P)) in cal(T)$ che ci dicono quando il programma $P$ in questione termina o meno, ma è sempre possibile?

// Fa schifo ^ sopra la P, facciamolo meme
Prendiamo ora $ ristretto equiv & "input"(x) \ & z := U(x,x); \ & "output"(z), $ con $U$ interprete universale. Vale allora $ phi_(ristretto) (x) = phi_U (x,x) = phi_x (x). $

Abbiamo quindi il programma $x$ che lavora su se stesso. Questo problema non è strano: compilatori, debugger, interpreti sono programmi che lavorano su programmi.

Come prima mi chiedo se $phi_x$ su input $x$ termina. La situazione ora è diversa: il programma non più è fissato ma dipende dall'input, essendo $x$.

#theorem(numbering: none)[
  Dato $ ristretto equiv & "input"(x) \ & z := U(x,x); \ & "output"(z), $ $arresto(ristretto)$ è indecidibile.
]

#proof[
  \ Per assurdo assumiamo $arresto(ristretto)$ decidibile, dunque esiste $ Phi_(arresto(ristretto)) (x) = cases(1 & "se" phi_ristretto (x) = phi_x (x) arrow.b, 0 quad & "se" phi_(ristretto) (x) = phi_x (x) arrow.t) quad in cal(T) $ calcolabile da un programma che termina sempre.

  Visto che $Phi_(ristretto) in cal(T)$ allora anche la funzione $ f(x) = cases(0 & "se" Phi_(arresto(ristretto)) (x) = 0 equiv phi_x (x) arrow.t, phi_x (x) + 1 quad & "se" Phi_(arresto(ristretto)) (x) = 1 equiv phi_x (x) arrow.b) $ è ricorsiva totale: infatti, il programma $ A equiv & "input"(x) \ & "if" (Phi_(arresto(ristretto) (x)) == 0) \ & quad "output"(0) \ & "else" \ & quad "output"(U(x,x) + 1) $ calcola esattamente la funzione $f(x)$.

  Sia $alpha in NN$ la codifica del programma $A$, allora $phi_alpha = f$. Valutiamo $phi_alpha$ in $alpha$: $ phi_alpha (alpha) = cases(0 & "se" phi_alpha (alpha) arrow.t, phi_alpha (alpha) + 1 quad & "se" phi_alpha (alpha) arrow.b) quad . $

  Tale funzione non può esistere, infatti:
  - nel primo "ramo" ho $phi_alpha (alpha) = 0$ se non termino, contraddizione perché $A in cal(T)$;
  - nel secondo "ramo" ho $phi_alpha (alpha) = phi_alpha (alpha) + 1$ se termino, contraddizione perché questa relazione non vale per nessun naturale.

  Siamo ad un assurdo, quindi concludiamo che $arresto(ristretto)$ è indecidibile.
]

==== Problema dell'arresto

La versione generale del problema dell'arresto ristretto è il *problema dell'arresto*, posto nel 1936 da Alan Turing.

#theorem(numbering: none)[
  Dati $x,y in NN$ rispettivamente dato e programma, il problema dell'arresto AR con domanda $phi_y (x) arrow.b$ è indecidibile.
]

// Da sistemare, scritto con il culo
#proof[
  \ Assumiamo per assurdo che AR sia decidibile, allora esiste un programma $P_("AR") (x,y)$ che lo risolve, ovvero restituisce 1 se $phi_y (x) arrow.b$, altrimenti restituisce 0.

  Il seguente programma decide AR: $ P equiv & "input"(x) \ & "output"(P_("AR") (x,x)) quad . $

  Abbiamo fatto vedere prima che questo problema è indecidibile, per cui non esistono programmi per la soluzione di AR, ma questo è un assurdo, quindi AR è indecidibile.
]
