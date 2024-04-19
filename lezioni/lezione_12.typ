// Setup

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

#import "alias.typ": *

// Appunti

= Lezione 12

Vogliamo una definizione di calcolabilità che non coinvolga linguaggi, in modo da renderla più generale possibile.

#v(12pt)

  #figure(
      image("../assets/calcolabilità-venn.svg")
  )

#v(12pt)

Siamo nella direzione giusta, non abbiamo catturato cose strane che non avrei catturato in $F(ram)$/$F(mwhile)$. 

Tuttavia, ci serve ampliare ancora, in questo caso RICPRIM: introduciamo un'operazione che ci permetta di includere le funzioni parziali e chiudiamo l'insieme su questa operazione.

== Minimalizzazione

L'operatore introdotto è l'operatore di *minimalizzazione* di funzione.

Sia $f: NN^(n+1) arrow NN, f(wstato(x), y)$ con $wstato(x) in NN^n$. Vale
$ min(f)(wstato(x)) = g(wstato(x)) = cases(y & quad "se " f(wstato(x), y) = 0 and (forall y' < y : f(wstato(x), y') arrow.b and f(wstato(x), y') eq.not 0), bot & quad "altrimenti") = mu_y (f(wstato(x), y) = 0) $

Più informalmente, $y$ è il più piccolo valore che azzera $f(underline(x), y)$ ovunque precedentemente definita su $y$.

Vediamo alcuni esempi con $f: NN^2 arrow NN$:
#align(center)[
  #table(
  columns: 2,
  [$f(x,y)$], [$min(f)(x)=g(x)$],
  [$x+y+1$],[$bot$],
  [$x overset(-,.) y$],[$x$],
  [$y overset(-,.) x$],[$0$],
  [$x overset(-,.) y^2$],[$ceil(sqrt(x))$],
  [$floor(x/y)$],[$bot$],
  )
]

== Classe $cal(P)$ delle Funzioni Ricorsive Parziali

Ora ampliamo RICPRIM chiudendo ELEM rispetto a COMP,RP e MIN:
$ elem^(comp,rp,min) = cal(P) = {"Funzioni Ricorsive Parziali"} $
Sicuramente $cal(P)$, che grazie a MIN contiene anche funzioni parziali, amplia RICPRIM, fatto solo di funzioni totali. _Ma come si pone rispetto a $F(mwhile)$?_

#theorem(numbering: none)[
  $cal(P) subset.eq F(mwhile)$
]<thm>

#proof[
  \ $cal(P)$ è definito per chiusura, ma in realtà è definito induttivamente, in questo modo:
  - le funzioni ELEM sono in $cal(P)$;
  - se $h,g_1,...,g_k in cal(P)$ allora $comp(h, g_1, dots, g_k) in cal(P)$;
  - se $h,g in cal(P)$ allora $rp(h,g) in cal(P)$;
  - se $f in cal(P)$ allora $min(f) in cal(P)$;
  - nient'altro è in $cal(P)$.

  Di conseguenza, per induzione strutturale su $cal(P)$, dimostriamo:
  - *base*: le funzioni elementari sono while programmabili, lo abbiamo già dimostrato;
  - *passi induttivi*:
    - siano $h,g_1,...,g_k in cal(P)$ (quindi anche while programmabili), mostro che $comp(h,g_1,...,g_k)$ è while programmabile $arrow$ lo abbiamo già fatto per RICPRIM;
    - siano $h,g in cal(P)$ (quindi anche while programmabili), mostro che $rp(h,g)$ è while programmabile $arrow$ lo abbiamo già fatto per RICPRIM;
    - sia $f in cal(P)$, mostro che anche $min(f)$ è while programmabile, quindi devo trovare un programma while che calcoli la minimizzazione. Vediamo un esempio $ & "input"(wstato(x)) \ & "begin" \ & quad y := 0 \ & quad "while" F(wstato(x),y) eq.not 0 "do" \ & quad quad y := y + 1 \ & "end" $
    Se non esiste un $y$ che azzeri $f(wstato(x),y)$, va in loop $arrow.double$ la semantica del programma è $bot$ secondo MIN.
  
  Concludiamo, quindi, che $cal(P) subset.eq F(mwhile)$.
]

Ora viene naturale chiedersi come vale la relazione inversa, cioè se $F(mwhile) subset.eq cal(P)$ oppure no.

#theorem(numbering: none)[
  $F(mwhile) subset.eq cal(P)$
]<thm>

#proof[
  \ Sappiamo che $ F(mwhile) = {Psi_W : W in wprogrammi} $ 
  
  Consideriamo $Psi_W in F(mwhile)$ e facciamo vedere che $Psi_W in cal(P)$, mostrando che può essere espressa come composizione, ricorsione primitiva e minimalizzazione a partire dalle funzioni in ELEM.
  
  $ Psi_W = "Pro"^21_0 ([|W|](winizializzazione(x))) $ dove $[|C|](wstato(x)) = wstato(y)$ è la funzione che calcola lo stato prossimo $wstato(y) in NN^21$, a seguito dell'esecuzione del comando C a partire dallo stato $wstato(x) in NN^21$. 
  \ In sostanza, $[||]() : NN^21 arrow.long NN^21$ rappresenta la funzione di stato prossimo (definita induttivamente).

  Abbiamo definito $Psi_W$ come la composizione di due funzioni: $"Pro"^21_0 in elem$ con la funzione di stato prossimo $[|W|](winizializzazione(x))$. Valgono:
  + $"Pro"^21_0 in elem arrow.long.double "Pro"^21_0 in cal(P)$;
  + $cal(P)$ chiuso rispetto alla composizione;
  + a causa delle due precedenti, se dimostro che $[|C|](wstato(x)) = wstato(y) in cal(P)$, allora $Psi_W in cal(P)$.

  $underline("Oss:")$ notiamo che la funzione stato prossimo restituisce numeri in $NN^21$, mentre gli elementi in $cal(P)$ hanno codominio $NN$. Tramite liste di Cantor, riesco a condensare il vettore in un numero.
  \ $arrow.double$ consideriamo $f_C (x) = y$ con $x = [wstato(x)]$ e $y = [wstato(y)]$.

  #align(center)[
    #image("../assets/funzione-stato-prossimo.svg", width: 85%)
  ]

  Ovviamente $ f_C in cal(P) arrow.long.double.l.r [|C|] in cal(P) $ dato che posso passare da una all'altra (e viceversa) usando solo funzioni in $cal(P)$.

  Dimostriamo, tramite induzione strutturale, sul comando while $C$:
  - *caso base*: vediamo come i comandi base siano in $cal(P)$
    - azzeramento $arrow C equiv x_k := 0$ 
    $ f_(x_k := 0) (x) = ["Pro"(0,x), dots, underbrace(0(k), k"-esima"), dots, "Pro"(20,x)] $ 
    Tutte le funzioni usate sono in $cal(P)$, così come la loro composizione;
    - incremento/decremento $ arrow C equiv x_k := x_j plus.minus 1$
    $ f_(x_k := x_j plus.minus 1) (x) = ["Pro"(x,0), dots, "Pro"(j,x) plus.minus 1, dots, "Pro"(20,x)] $ 
    Tutte le funzioni usate sono in $cal(P)$, così come la loro composizione;
  - *passi induttivi*: ora vediamo i comandi più "complessi":
    - comando composto $arrow C equiv composto$, sapendo che $f_(C_i) in cal(P)$
    $ arrow.double f_C (x) = f_(C_m) (dots, f_(C_i) (x), dots) $ ogni $f_(C_i) in cal(P)$ per ipotesi induttiva, ma quindi anche la loro composizione;
    - comando while $arrow C equiv comandowhile$, sapendo che $f_C in cal(P)$
    $ arrow.double f_C (x) = f_C^e(x) (x) "con" e(x) = mu_y ("Pro"(k,f_c^y (x)) = 0). $ 
    $f_C^e(x)$ è la composizione di $f_C$ per $e(x)$ volte, che non è un numero costante dato che dipende dallo stato iniziale $x$. 
    \ Grazie all'operatore di composizione, sappiamo comporre un numero predeterminato di volte, _come facciamo con un numero non costante? Come rappresento $T(x,y) = f_C^y (x)$ in $cal(P)$?_ 
    $ T(x,y) = cases(x & quad "se" y = 0, f_C (T(x,y-1)) & quad "se" y > 1) $ 
    Quindi $T(x,y)$ è un operatore ottenuto tramite RP su una funzione $f_C in cal(P)$, di conseguenza anche lei starà in $cal(P)$. Abbiamo $ e(x) = mu_y ("Pro"(k, T(x,y)) = 0) $ che è MIN della funzione $T(x,y)$, che sta in $cal(P)$ $arrow.long.double e(x) in cal(P)$. 
    
    Dato che $f_(C') (x) = f_C^(e(x)) (x) = T(x,e(x))$ (composizione di funzioni in $cal(P)$), ne consegue che $f_c' in cal(P)$.
]<proof>

Visti i risultati ottenuti dai due teoremi precedenti, possiamo concludere che $ F(mwhile) = cal(P). $

Abbiamo ottenuto che la classe delle funzioni ricorsive parziali (che dà un'idea di _calcolabile_ in termini matematici) coincide con quello che noi intuitivamente consideriamo _calcolabile_ (dove con "intuitivamente" intendiamo quei problemi di cui vediamo una macchina che li risolva).

Oltre alle classi viste finora, esiste anche la la classe delle funzioni ricorsive totali, ovvero funzioni ricorsive parziali, ma totali.

== Tesi di Church-Turing

Il risultato principale di questo studio è aver trovato le due classi di funzioni
$ cal(P) = {"funzioni ricorsive parziali"} \ cal(T) = {"funzioni ricorsive totali"} $
legate in questa relazione
$ cal(T) subset cal(P) $

L'insieme $cal(P)$ cattura tutti i sistemi di calcolo esistenti: while, ram, MDT, lambda-calcolo di Church, paradigma quantistico, grammatiche, circuiti, sistemi di riscrittura. Tutte, dal 1930 ad oggi.

Dal 1930 in poi, sono stati proposti un sacco di modelli di calcolo che volevano catturare ciò che è calcolabile. Tutti questi modelli individuavano sempre la classe delle funzioni ricorsive parziali.

#rect[*Tesi di Church-Turing* (anni '30-'40): la classe delle funzioni intuitivamente calcolabili coincide con la classe $cal(P)$ delle funzioni ricorsive parziali.]

Questa tesi non è un teorema, è una congettura, un'opinione. Non può essere un teorema in quanto non è possibile caratterizzare i modelli di calcolo ragionevoli che sono stati e saranno proposti in maniera completa. Possiamo semplicemente decidere se aderire o meno a questa tesi.

=== Conseguenze della tesi

Per noi un problema è _calcolabile_ è quando esiste un modello di calcolo che riesca a risolverlo ragionevolmente. Se volessimo aderire alla tesi di Church-Turing, potremmo dire, in maniera più formale, che:
- problema ricorsivo parziale è sinonimo di *calcolabile*;
- problema ricorsivo totale è sinonimo di *calcolabile da un programma che si arresta su ogni input* (no loop).