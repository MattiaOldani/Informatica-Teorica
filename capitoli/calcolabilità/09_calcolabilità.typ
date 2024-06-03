#import "../alias.typ": *

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

#show thm-selector("thm-group", subgroup: "proof"): it => block(
  it,
  stroke: green + 1pt,
  inset: 1em,
  breakable: true
)


= Calcolabilità

Seguiremo la seguente roadmap:
+ *ELEM*: definiamo un insieme di tre funzioni che *qualunque* idea di calcolabile si voglia proporre deve considerare calcolabili. ELEM non può esaurire il concetto di calcolabilità, quindi lo espanderemo con altre funzioni;
+ $bold(Omega)$: definiamo insieme di operazioni su funzioni che costruiscono nuove funzioni. Le operazioni in $Omega$ sono banalmente implementabili e, applicandole a funzioni calcolabili, riesco a generare nuove funzioni calcolabili.
+ $bold(elem^Omega = cal(P))$: definiamo la classe delle *funzioni ricorsive parziali*. Questa sarà la nostra idea astratta della classe delle funzioni calcolabili secondo Kleene.

Quello che faremo dopo la definizione di $cal(P)$ sarà chiederci se questa idea di calcolabile che abbiamo _"catturato"_ coincida o meno con le funzioni presenti in $F(ram) = F(mwhile)$.

== Primo passo: ELEM

Definiamo l'insieme ELEM con le seguenti funzioni: $ elem = {"successore" &: s(x) = x + 1 bar.v x in NN, \ "zero" &: 0^n (x_1, dots, x_n) = 0 bar.v x_i in NN, \ "proiettori" &: "pro"_k^n (x_1, dots, x_n) = x_k bar.v x_i in NN} quad . $

Questo insieme è un _onesto punto di partenza_: sono funzioni basilari che qualsiasi idea data teoricamente non può non considerare come calcolabile.

Ovviamente, ELEM non può essere considerato come l'idea teorica di _TUTTO_ ciò che è calcolabile: infatti, la funzione $f(x) = x + 2$ non appartiene a ELEM ma è sicuramente calcolabile.

Quindi, ELEM è troppo povero e deve essere ampliato.

== Secondo passo: $Omega$

Definiamo ora un insieme $Omega$ di operazioni che amplino le funzioni di ELEM per permetterci di coprire tutte le funzioni calcolabili.

=== Composizione

Il primo operatore che ci viene in mente di utilizzare è quello di *composizione*.

 Siano:
- $h : NN^k arrow.long NN$ *funzione di composizione*,
- $g_1, dots, g_k : NN^n arrow.long NN$ _"funzioni intermedie"_ e
- $wstato(x) in NN^n$ input.

Allora definiamo $ comp(h, g_1, dots, g_k) : NN^n arrow.long NN $ la funzione tale che $ comp(h, g_1, dots, g_k)(wstato(x)) = h(g_1 (wstato(x)), dots, g_k (wstato(x))). $ 

#v(12pt)

#figure(
  image("assets/composizione.svg", width: 50%)
)

#v(12pt)

COMP è una funzione _intuitivamente calcolabile_ se parto da funzioni calcolabili: infatti, prima eseguo le singole funzioni $g_1, dots, g_k$ e poi applico la funzione $h$ sui risultati delle funzioni $g_i$.

Calcoliamo ora la chiusura di ELEM rispetto a COMP, ovvero l'insieme $elem^comp$.

Vediamo subito come la funzione $f(x) = x + 2$ appartenga a questo insieme perché $ comp(s,s)(x) = s(s(x)) = (x+1)+1 = x + 2. $

_Che altre funzioni ci sono in questo insieme?_ Sicuramente tutte le funzioni lineari del tipo $f(x) = x + k$, _ma la somma?_

La funzione $ "somma"(x,y) = x + y $ non appartiene a questo insieme perché il valore $y$ non è prefissato e non abbiamo ancora definito il concetto di iterazione di una funzione (in questo caso la funzione successore).

Dobbiamo ampliare ancora $elem^comp$ con altre operazioni.

=== Ricorsione primitiva

Definiamo un'operazione che ci permetta di *iterare* sull'operatore di composizione, la *ricorsione primitiva*, usata per definire *funzioni ricorsive*.

Siano:
- $g: NN^n arrow.long NN$ *funzione caso base*,
- $h: NN^(n+2) arrow.long NN$ *funzione passo ricorsivo*
- $wstato(x) in NN^n$ input.

Definiamo $ rp(h,g) = f(wstato(x),y) = cases(g(wstato(x)) & "se" y = 0, h(f(wstato(x),y-1), y-1, wstato(x)) quad & "se" y > 0) quad $ funzione che generalizza la definizione ricorsiva di funzioni.

Come prima, chiudiamo $elem^comp$ rispetto a RP, ovvero calcoliamo l'insieme $elem^({comp,rp})$. Chiamiamo $ ricprim = elem^({comp, rp}) $ l'insieme ottenuto dalla chiusura, cioè l'insieme delle *funzioni ricorsive primitive*.

In questo insieme abbiamo la somma: infatti, $ "somma"(x,y) = cases(x = "Pro"^2_1 (x,y) & "se" y = 0, s("somma"(x,y-1)) quad & "se" y > 0) quad . $

Altre funzioni che stanno in RICPRIM sono: $ "prodotto"(x,y) = cases(0 = 0^2 (x,y) & "se" y = 0, "somma"(x, "prodotto"(x,y-1)) quad & "se" y > 0) quad ; \ "predecessore" P(x) = cases(0 & "se" x = 0, x - 1 quad & "se" x > 0) quad arrow.long.double quad x overset(-,.) y = cases(x & "se" y = 0, P(x) overset(-,.) (y-1) quad & "se" y > 0) quad . $

=== RICPRIM vs WHILE

L'insieme RICPRIM contiene molte funzioni, _ma abbiamo raggiunto l'insieme $F(mwhile)$?_ 

Vediamo come è definita RICPRIM:
- $forall f in elem arrow.long.double f in ricprim$;
- se $h, g_1, dots, g_k in ricprim arrow.long.double comp(h, g_1, dots, g_k) in ricprim$;
- se $g,h in ricprim arrow.long.double rp(g,h) in ricprim$;
- nient'altro sta in RICPRIM.

#theorem(numbering: none)[
  $ricprim subset.eq F(mwhile)$.
]

#proof[
  \ $underline("Passo base")$: \
  Le funzioni di ELEM sono ovviamente while programmabili, le avevamo mostrate in precedenza.

  $underline("Passo induttivo:")$ \
  Per COMP, assumiamo per ipotesi induttiva che $h, g_1, dots, g_k in ricprim$ siano while programmabili, allora esistono $H, G_1, dots, G_k in wprogrammi$ tali che $Psi_H = h, Psi_G_1 = g_1, dots, Psi_g_k = g_k$. Mostro allora un programma WHILE che calcola COMP.

  #code(
    fill: luma(240),
    indent-guides: 0.2pt + red,
    inset: 10pt,
    line-numbers: false,
    radius: 4pt,
    row-gutter: 6pt,
    stroke: 1pt + black
  )[
    ```py
    input(x)                # In x1 inizialmente ho x
    begin                   # nella forma <a1,...,an>
      x0 := G1(x1);
      x0 := [x0, G2(x1)];
      ...
      x0 := [x0, Gk(x1)];
      x1 := H(x0);
    end
    ```
  ]

  Quindi abbiamo $Psi_w (wstato(x)) = comp(h,g_1, dots, g_k)(wstato(x))$.

  Per RP, assumiamo che $h, g in ricprim$ siano while programmabili, allora esistono $H,G in wprogrammi$ tali che $Psi_H = h$ e $Psi_G = g$. Le funzioni ricorsive primitive le possiamo vedere come delle iterazioni che, partendo dal caso base $G$, mano a mano compongono con $H$ fino a quando non si raggiunge $y$ (escluso). Mostriamo un programma WHILE che calcola $ rp(h,g) = f(wstato(x),y) = cases(g(wstato(x) & "se " y=0 \ h(f(wstato(x), y-1), y-1), wstato(x)) & "se " y>0) $

  // La x va sottolineata
  #code(
    fill: luma(240),
    indent-guides: 0.2pt + red,
    inset: 10pt,
    line-numbers: false,
    radius: 4pt,
    row-gutter: 6pt,
    stroke: 1pt + black
  )[
    ```py
    input(x,y)                # In x1 inizialmente ho <x,y>
    begin
      t := G(x);              # t contiene f(x,y)
      k := 1;
      while k <= y do
        begin
          t := H(t, k-1, x);
          k := k + 1;
        end
    end
    ```
  ]

  Quindi $Psi_w (cantor(x,y)) = rp(h,g)(wstato(x), y)$.
]

Abbiamo quindi dimostrato che $ricprim subset.eq F(mwhile)$, _ma questa inclusione è propria?_

Notiamo subito che nel linguaggio WHILE posso fare dei cicli infiniti, mentre in RICPRIM no: RICPRIM contiene solo funzioni totali (si dimostra per induzione strutturale) mentre WHILE contiene anche delle funzioni parziali.

Di conseguenza $ ricprim subset.neq F(mwhile). $

Per poter raggiungere $F(mwhile)$ dovremo ampliare nuovamente RICPRIM.

Visto che le funzioni in RICPRIM sono tutte totali, possiamo dire che ogni ciclo in RICPRIM ha un inizio e una fine ben definiti: il costrutto utilizzato per dimostrare che $rp in F(mwhile)$ nella dimostrazione precedente, ci permette di definire un nuovo tipo di ciclo, il *ciclo FOR*.

#code(
  fill: luma(240),
  indent-guides: 0.2pt + red,
  inset: 10pt,
  line-numbers: false,
  radius: 4pt,
  row-gutter: 6pt,
  stroke: 1pt + black
)[
  ```py
  input(x,y)
  begin
    t := G(x);
    for k := 1 to y do
      t := H(t, k-1, x);
  end
  ```
]

Il FOR che viene utilizzato è quello _originale_, cioè quel costrutto che si serve di una *variabile di controllo* che parte da un preciso valore e arriva ad un valore limite, senza che la variabile di controllo venga toccata. In Pascal veniva implementato mettendo la variabile di controllo in un registro particolare, per non permettere la sua scrittura.

Il FOR language è quindi un linguaggio WHILE dove l'istruzione di loop è un FOR.

Possiamo quindi dire che $lfor = ricprim$, e quindi che $F(lfor) subset F(mwhile)$.

Dato che WHILE vince su RICPRIM solo per i loop infiniti, restringiamo WHILE imponendo dei loop finiti. Creiamo l'insieme $ overset(F,tilde)(mwhile) = {Psi_W : W in wprogrammi and Psi_W "totale"}. $

_Dove si posizione questo insieme rispetto a RICPRIM? L'inclusione è propria?_

Anche in questo caso, "vince" ancora WHILE, perché ci sono funzioni in $overset(F,tilde)(mwhile)$ che non sono scrivibili come funzioni in RICPRIM. Ad esempio, la funzione di Ackermann (1928), definita come $ cal(A)(m,n) = cases(n+1 & "se" m = 0, cal(A)(m-1, 1) & "se" m > 0 and n = 0, cal(A)(m-1, cal(A)(m, n-1)) quad & "se" m > 0 and n > 0) $ è una funzione che non appartiene a RICPRIM, perché a causa della doppia ricorsione cresce troppo in fretta.

Di conseguenza, vogliamo ampliare anche RICPRIM.

Vogliamo una definizione di calcolabilità che non coinvolga i linguaggi, in modo da renderla il più generale possibile.

#v(12pt)

#figure(
  image("assets/calcolabilità-venn.svg", width: 100%)
)

#v(12pt)

Siamo nella direzione giusta: non abbiamo catturato _"cose strane"_ che non avrei catturato in $F(ram)$, ma questo non basta. Infatti, dobbiamo ampliare ancora RICPRIM perché non abbiamo ancora catturato le funzioni parziali.

=== Minimalizzazione

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

== $cal(P)$

Ampliamo RICPRIM chiudendolo con la nuova operazione MIN:
$ elem^({comp,rp,min}) = cal(P) = {"Funzioni Ricorsive Parziali"}. $

Espandi un poco.

=== $cal(P)$ vs WHILE

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
    image("assets/funzione-stato-prossimo.svg", width: 70%)
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

=== Tesi di Church-Turing

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

Per noi un problema è _calcolabile_ quando esiste un modello di calcolo che riesce a risolverlo ragionevolmente. Se volessimo aderire alla tesi di Church-Turing, potremmo dire, in maniera più formale, che:
- _problema ricorsivo parziale_ è sinonimo di *calcolabile*;
- _problema ricorsivo totale_ è sinonimo di *calcolabile da un programma che si arresta su ogni input*, quindi che non va mai in loop.
