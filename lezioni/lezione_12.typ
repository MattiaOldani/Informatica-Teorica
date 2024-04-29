// Setup

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

= Lezione 12

== Introduzione

Vogliamo una definizione di calcolabilità che non coinvolga i linguaggi, in modo da renderla il più generale possibile.

#v(12pt)

#figure(
  image("../assets/calcolabilità-venn.svg", width: 100%)
)

#v(12pt)

Siamo nella direzione giusta: non abbiamo catturato _"cose strane"_ che non avrei catturato in $F(ram)$, ma questo non basta. Infatti, dobbiamo ampliare ancora RICPRIM perché non abbiamo ancora catturato le funzioni parziali.

== Minimalizzazione

Introduciamo quindi un nuovo operatore per permettere la presenza di funzioni parziali.

L'operatore scelto è l'operatore di *minimalizzazione* di funzione.

Sia $f: NN^(n+1) arrow.long NN$ con $f(wstato(x), y)$ e $wstato(x) in NN^n$, allora: $ min(f)(wstato(x)) = g(wstato(x)) = cases(y & "se" f(wstato(x), y) = 0 and (forall y' < y quad f(wstato(x),y') arrow.b and f(wstato(x),y') eq.not 0), bot quad & "altrimenti") quad . $ 

Un'altra definizione di MIN è $ mu_y (f(wstato(x),y)=0). $

Più informalmente, questa funzione restituisce il più piccolo valore di $y$ che azzera $f(underline(x), y)$ ovunque precedentemente definita su $y'$.

// Li teniamo?
Vediamo alcuni esempi con $f: NN^2 arrow NN$.

#align(center)[
  #table(
    columns: (30%, 30%),
    inset: 10pt,
    align: horizon,

    [$f(x,y)$], [$min(f)(x)=g(x)$],
    
    [$x+y+1$], [$bot$],
    [$x overset(-,.) y$], [$x$],
    [$y overset(-,.) x$], [$0$],
    [$x overset(-,.) y^2$], [$ceil(sqrt(x))$],
    [$floor(x/y)$], [$bot$],
  )
]

== Classe $cal(P)$ delle Funzioni Ricorsive Parziali

Ampliamo RICPRIM chiudendolo con la nuova operazione MIN:
$ elem^({comp,rp,min}) = cal(P) = {"Funzioni Ricorsive Parziali"}. $

Sicuramente $cal(P)$, che grazie a MIN ora contiene anche funzioni parziali, amplia RICPRIM, fatto solo di funzioni totali. _Ma come si pone rispetto a $F(mwhile)$?_

#theorem(numbering: none)[
  $cal(P) subset.eq F(mwhile)$.
]

#proof[
  \ $cal(P)$ è definito per chiusura, ma in realtà è definito induttivamente in questo modo:
  - le funzioni ELEM sono in $cal(P)$;
  - se $h, g_1, dots, g_k in cal(P)$ allora $comp(h, g_1, dots, g_k) in cal(P)$;
  - se $h, g in cal(P)$ allora $rp(h,g) in cal(P)$;
  - se $f in cal(P)$ allora $min(f) in cal(P)$;
  - nient'altro è in $cal(P)$.

  Di conseguenza, per induzione strutturale su $cal(P)$, dimostriamo:
  - *passo base*: le funzioni elementari sono WHILE programmabili, lo abbiamo già dimostrato;
  - *passi induttivi*:
    - siano $h, g_1, dots, g_k in cal(P)$ WHILE programmabili per ipotesi induttiva, allora mostro che $comp(h, g_1, dots, g_k)$ è WHILE programmabile, ma questo lo abbiamo già fatto per RICPRIM;
    - siano $h, g in cal(P)$ WHILE programmabili per ipotesi induttiva, allora mostro che $rp(h,g)$ è WHILE programmabile, ma anche questo lo abbiamo già fatto per RICPRIM;
    - sia $f in cal(P)$ WHILE programmabile per ipotesi induttiva, allora mostro che $min(f)$ è WHILE programmabile. Devo trovare un programma WHILE che calcoli la minimizzazione: il programma WHILE $ P equiv & "input"(wstato(x)) \ & "begin" \ & quad y := 0 \ & quad "while" f(wstato(x),y) eq.not 0 "do" \ & quad quad y := y + 1 \ & "end" $ è un programma che calcola la minimizzazione: infatti, se non esiste un $y$ che azzeri $f(wstato(x),y)$ il programma va in loop, quindi la semantica di $P$ è $bot$ secondo MIN.
  
  Concludiamo quindi che $cal(P) subset.eq F(mwhile)$.
]

Viene naturale chiedersi se vale la relazione inversa, cioè se $F(mwhile) subset.eq cal(P)$ oppure no.

#theorem(numbering: none)[
  $F(mwhile) subset.eq cal(P)$.
]

#proof[
  \ Sappiamo che $ F(mwhile) = {Psi_W : W in wprogrammi}. $ 
  
  Consideriamo un $Psi_W in F(mwhile)$ e facciamo vedere che $Psi_W in cal(P)$, mostrando che può essere espressa come composizione, ricorsione primitiva e minimalizzazione a partire dalle funzioni in ELEM.
  
  Le funzione in $wprogrammi$ sono nella forma $ Psi_W = "Pro"^21_0 ([|W|](winizializzazione(wstato(x)))), $ con $[|C|](wstato(x)) = wstato(y)$ la funzione che calcola lo stato prossimo $wstato(y) in NN^21$ a seguito dell'esecuzione del comando C a partire dallo stato corrente $wstato(x) in NN^21$. 
  
  In sostanza, $[||]() : NN^21 arrow.long NN^21$ rappresenta la funzione di stato prossimo definita induttivamente per via della struttura induttiva del linguaggio WHILE.

  Abbiamo definito $Psi_W$ come composizione delle funzioni $"Pro"^21_0$ e $[|W|](winizializzazione(wstato(x)))$, ma allora:
  + $"Pro"^21_0 in elem arrow.long.double "Pro"^21_0 in cal(P)$;
  + $cal(P)$ è chiuso rispetto alla composizione;
  + a causa delle due precedenti, se dimostro che la funzione di stato prossimo è ricorsiva parziale allora $Psi_W in cal(P)$ per la definizione induttiva di $cal(P)$.

  La funzione di stato prossimo restituisce elementi in $NN^21$, mentre gli elementi in $cal(P)$ hanno codominio $NN$. Per risolvere questo piccolo problema tramite le liste di Cantor riesco a condensare il vettore in un numero.
  
  Consideriamo quindi $f_C (x) = y$ *funzione numero prossimo*, con $x = [wstato(x)]$ e $y = [wstato(y)]$.

  #v(12pt)

  #figure(
    image("../assets/funzione-stato-prossimo.svg", width: 70%)
  )

  #v(12pt)

  Ovviamente $ f_C in cal(P) arrow.long.double.l.r [|C|] in cal(P) $ dato che posso passare da una all'altra usando funzioni in $cal(P)$ quali Cantor e proiezioni.

  Dimostriamo, tramite induzione strutturale, sul comando while $C$:
  - *caso base*: i comandi base WHILE devono stare in $cal(P)$.
    - *azzeramento* $C equiv x_k := 0$:
    $ f_(x_k := 0) (x) = ["Pro"(0,x), dots, underbracket(0(x), k), dots, "Pro"(20,x)] . $ 
    
    Tutte le funzioni usate sono in $cal(P)$, così come la loro composizione;
    - *incremento/decremento* $C equiv x_k := x_j plus.minus 1$:
    $ f_(x_k := x_j plus.minus 1) (x) = ["Pro"(x,0), dots, "Pro"(j,x) plus.minus 1, dots, "Pro"(20,x)]. $ 
    
    Tutte le funzioni usate sono in $cal(P)$, così come la loro composizione;
  - *passi induttivi*: i comandi "complessi" WHILE devono stare in $cal(P)$.
    - *comando composto* $C equiv composto$ sapendo che $f_(C_i) in cal(P)$:
    $ f_C (x) = f_(C_n) (dots (f_(C_2)(f_(C_1)(x))) dots ). $
    
    Ogni $f_(C_i) in cal(P)$ per ipotesi induttiva, così come la loro composizione;
    - *comando while* $C' equiv comandowhile$, sapendo che $f_C in cal(P)$:
    $ f_(C') (x) = f_C^e(x) (x), $ con $ e(x) = mu_y ("Pro"(k,f_c^y (x)) = 0). $ 
    
    $f_C^e(x)$ è la composizione di $f_C$ per $e(x)$ volte, che non è un numero costante dato che dipende dallo stato iniziale $x$, ma questo è problema: grazie all'operatore di composizione sappiamo comporre un numero predeterminato di volte, _ma come facciamo con un numero non costante?_

    Rinominiamo $ f_C^y (x) = T(x,y) = cases(x & "se" y = 0, f_C (T(x,y-1)) quad & "se" y > 1) quad . $ Come rappresento $T(x,y)$ in $cal(P)$?
    
    Notiamo come $T(x,y)$ sia un operatore ottenuto tramite RP su una funzione $f_C in cal(P)$, di conseguenza anche lei starà in $cal(P)$.
    
    L'ultima cosa da sistemare è $e(x)$. Questa funzione è la minimizzazione di $T(x,y)$: infatti, $ e(x) = mu_y ("Pro"(k, T(x,y)) = 0) $ cerca il primo numero che azzera il registro $k$, quindi $e(x) in cal(P)$.

    In conclusione, $ f_(C') (x) = f_C^e(x) = T(x,e(x)) $ è composizione di funzioni in $cal(P)$, quindi $f_(C') in cal(P)$.
]

Visti i risultati ottenuti dai due teoremi precedenti, possiamo concludere che $ F(mwhile) = cal(P). $

Abbiamo ottenuto che la classe delle funzioni ricorsive parziali, che dà un'idea di _calcolabile_ in termini matematici, coincide con quello che noi intuitivamente consideriamo _calcolabile_, dove con "intuitivamente calcolabile" intendiamo tutti quei problemi di cui vediamo una macchina che li risolva.

== Tesi di Church-Turing

Il risultato principale di questo studio è aver trovato due classi di funzioni molto importanti:
- $cal(P)$ insieme delle funzioni ricorsive parziali;
- $cal(T)$ insieme delle funzioni ricorsive totali.

Il secondo insieme presentato contiene tutte le funzioni di $cal(P)$ che sono totali, ma allora $ cal(T) subset cal(P). $ Inoltre vale $ ricprim subset cal(T) $ perché, ad esempio, la funzione di Ackermann $cal(A)(m,n)$ non sta in RICPRIM (già dimostrato) ma è sicuramente calcolabile e totale.

L'insieme $cal(P)$ cattura tutti i sistemi di calcolo esistenti: WHILE, RAM, Macchine Di Turing, Lambda-calcolo di Church, paradigma quantistico, grammatiche, circuiti, sistemi di riscrittura, eccetera. In poche parole, tutti i sistemi creati dal 1930 ad oggi.

Infatti, dal 1930 in poi sono stati proposti un sacco di modelli di calcolo che volevano catturare ciò che è calcolabile, ma tutti questi modelli individuavano sempre la classe delle funzioni ricorsive parziali. Visti questi risultati, negli anni 1930/1940 *Church* e *Turing* decidono di enunciare un risultato molto importante.

// Sistemare lo stile
#rect(
  stroke: red
)[
  *Tesi di Church-Turing*: la classe delle funzioni intuitivamente calcolabili coincide con la classe $cal(P)$ delle funzioni ricorsive parziali.
]

Questa tesi non è un teorema, è una *congettura*, un'opinione. Non può essere un teorema in quanto non è possibile caratterizzare i modelli di calcolo ragionevoli che sono stati e saranno proposti in maniera completa. Possiamo semplicemente decidere se aderire o meno a questa tesi.

=== Conseguenze della tesi

Per noi un problema è _calcolabile_ quando esiste un modello di calcolo che riesce a risolverlo ragionevolmente. Se volessimo aderire alla tesi di Church-Turing, potremmo dire, in maniera più formale, che:
- _problema ricorsivo parziale_ è sinonimo di *calcolabile*;
- _problema ricorsivo totale_ è sinonimo di *calcolabile da un programma che si arresta su ogni input*, quindi che non va mai in loop.
