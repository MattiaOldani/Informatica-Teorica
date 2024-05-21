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

= Lezione 20

== Crescita Asintotica

Nel fare il confronto tra due algoritmi per uno stesso problema, bisogna tenere in considerazione che a fare la differenza (in termini di prestazioni) sono gli input di dimensione "ragionevolmente grande", dove con questa espressione intendiamo una dimensione significativa nel contesto d'applicazione del problema.

Per fare un'analisi più precisa, è meglio valutare la crescita di $T(n)$ per $n$ grandi, trascurando costanti moltiplicative e termini di ordine inferiore.\
Questa analisi si chiama *valutazione asintotica*.

== Simboli di Landau

Introduciamo dei simboli matematici che ci permettono di stabilire degli "ordini di grandezza" fra le funzioni, in modo da poterle paragonare fra loro.

Questi simboli si chiamano *simboli di Landau*.

+ *$O$-grande:*\
  Date due funzioni $f,g : NN arrow NN$, diciamo $f(n) = O(g(n))$ sse $exists c > 0, n_0 in NN : forall n gt.eq n_0$ e vale $f(n) lt.eq c dot g(n)$.

+ *$Omega$-grande:*\
  Date due funzioni $f,g : NN arrow NN$, diciamo che $f(n) = Omega(g(n))$ sse $exists c > 0, n_0 in NN : forall n gt.eq n_0$ e vale $f(n) gt.eq c dot g(n).$ 

+ *$Theta$-grande:*\
  Date due funzioni $f,g : NN arrow NN$, diciamo che $f(n) = Theta(g(n))$ sse $exists c_1, c_2 > 0, n_0 in NN : forall n gt.eq n_0$ e vale $ c_1 dot g(n) lt.eq f(n) lt.eq c_2 dot g(n).$

Si può notare facilmente che valgono le seguenti proprietà:
- $f(n) = O(g(n)) arrow.l.r.long.double g(n) = Omega(f(n))$
- $f(n) = Theta(g(n)) arrow.l.r.long.double f(n) = O(g(n)) and f(n) = Omega(g(n))$

== Classificazioni di funzioni

Grazie all'introduzione dei simboli di Landau, è possibile classificare le funzioni in base a come è fatta la loro funzione soluzione $f(n)$, con $n$ input.

Data una funzione $f : NN arrow NN$, essa può essere:

#align(center)[
  #table(
    columns: (auto, auto),
    inset: 10pt,
    align: horizon,
    [*logaritmica*],
    $f(n) = O(log n)$,
    [*lineare*],
    $f(n) = O(n)$,
    [*quadratica*],
    $f(n) = O(n^2)$,
    [*polinomiale*],
    $f(n) = O(n^k)$,
    [*esponenziale*],
    [$f(n)$ non è polinomiale]
  )
]

== Classi di complessità

Vogliamo utilizzare il concetto di _classi di equivalenza_ per definire delle classi che racchiudano tutti i problemi che hanno bisogno della stessa quantità di risorse computazionali per essere risolti correttamente. 

*Classe di complessità*: insieme dei problemi che vengono risolti entro gli stessi limiti di risorse computazionali.

Proviamo a definire le classi di complessità in funzione della risorsa tempo: $ dtime(f(n)) = {"linguaggi accettati da DTM in tempo deterministico" O(f(n))}. $

Dato che abbiamo definito che le DTM possono anche calcolare funzioni, possiamo propagare questa definizione anche alle funzioni stesse $arrow.long.double$ possiamo definire le classi di complessità anche per le funzioni.

_Cosa intendiamo con "complessità in tempo per una funzione"?_\
La funzione $f : Sigma^* arrow Gamma^*$ è calcolata con *complessità in tempo $t(n)$* dela DTM $M$ sse su ogni input $x$ di lunghezza $n$, la computazione di $M$ su $x$ si arresta entro $t(n)$ passi, avendo $f(x)$ sul nastro.

Detto ciò, definiamo $ ftime(f(n)) = {"funzioni calcolate da DTM in tempo" O(f(n))}. $

Grazie a quanto detto finora, possiamo definire le due classi di complessità storicamente più importanti:
$ P = union.big_(k gt.eq 0) dtime(n^k) = {"linguaggi accettati da DTM in tempo polinomiale"} $
$ "FP" = union.big_(k gt.eq 0) ftime(n^k) = {"funzioni calcolate da DTM In tempo polinomiale"} $

Questi sono universalmente riconosciuti come i problemi efficientemente risolubili in tempo.

_Perché *polinomiale* è sinonimo di efficiente in tempo?_\
- Motivi pratici: facendo qualche banale esempio, è possibile vedere come la differenza tra un algoritmo polinomiale e uno esponenziale, per input tutto sommato piccoli, è abissale: il tempo di risoluzione di un problema, nel primo caso, è di frazioni di secondo, mentre nel secondo arriva facilmente ad anni o secoli.
- Motivi "composizionali": programmi efficienti che richiamano routine efficienti, rimangono efficienti. Questo perché concatenare algoritmi efficienti non fa altro che generare un tempo pari alla somma delle complessità dei due algoritmi (polinomiali, in quanto efficienti) e la somma di due polinomi genera comunque un polinomio $arrow.double$ l'algoritmo finale sarà anch'esso efficiente.
- Motivi di "robustezza": le classi P e FP rimangono invariate a prescindere dai molti modelli di calcolo utilizzati per circoscrivere i problemi efficientemente risolti.

*Tesi di Churc-Turing estesa*: La classe dei problemi *efficientemente risolubili in tempo* coincide con la classe dei problemi risolti in #underline("tempo polinomiale") su DTM.

// gigi: non so se mettere gli esempi dei problemi efficientemente risolubili

== Problemi difficili

Esistono moltissimi problemi pratici e importanti per i quali ancora non sono stati trovati algoritmi efficienti e non è nemmeno stato provato che tali algoritmi non possano per natura esistere. 

In altre parole, non sappiamo se tutti i problemi sono in realtà efficientemente risolubili o se ne esistono alcuni il cui miglior algoritmo di risoluzione abbia una complessità esponenziale.

== Teoria vs Pratica

- Sebbene da un punto di vista teorico "polinomiale in tempo" significa "efficiente", un algoritmo di complessità $n^1000$ non è praticabile.

  C'è da dire, però, che solitamente trovare un algoritmo polinomiale per un problema porta a trovare miglioramenti che riescono a rendere l'algoritmo praticabile, quindi possiamo dire che polinomiale è quasi sempre sinonimo di buono. Al contrario, è difficile che da algoritmi esponenziali si riesca a ottenere un algoritmo praticabile.

- Escludere a priori un algoritmo perché esponenziale non è sempre molto saggio: esistono problemi in cui è molto raro che si verifichi il caso peggiore, mentre in media, l'algoritmo di risoluzione, si comporta molto bene (Quick-sort, algoritmo del simplesso).

  Per mitigare questo problema, a volte ha senso utilizzare il concetto di *average case*, in cui si va a vedere come si comporta l'algoritmo in media piuttosto che nel caso pessimo.
