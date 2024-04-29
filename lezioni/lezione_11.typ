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

#show thm-selector("thm-group", subgroup: "proof"): it => block(
  it,
  stroke: green + 1pt,
  inset: 1em,
  breakable: true
)

#import "alias.typ": *

// Appunti

= Lezione 11

== Chiusura di un insieme rispetto ad un insieme di operazioni

Siano $Omega = {"op"_1, dots, "op"_t}$ un insieme di operazioni su $U$ di arietà rispettivamente $k_1, dots, k_t$ e $A subset.eq U$. Definiamo *chiusura di $A$ rispetto a $Omega$* il più piccolo sottoinsieme di $U$ contenente $A$ e chiuso rispetto a $Omega$, cioè l'insieme $A^Omega$ definito come:
- $forall a in A arrow.long.double a in A^Omega$;
- $forall i in {1,dots,t}, quad forall a_1, dots, a_(k_i) in A^Omega arrow.long.double "op"_i (a_1, dots, a_(k_i)) in A^Omega$;
- nient'altro è in $A^Omega$.

== Definizione teorica di calcolabilità

=== Roadmap

Seguiremo la seguente roadmap:
+ *ELEM*: definiamo un insieme di tre funzioni che *qualunque* idea di calcolabile si voglia proporre deve considerare calcolabili. ELEM non può esaurire il concetto di calcolabilità, quindi lo espanderemo con altre funzioni;
+ $bold(Omega)$: definiamo insieme di operazioni su funzioni che costruiscono nuove funzioni. Le operazioni in $Omega$ sono banalmente implementabili e, applicandole a funzioni calcolabili, riesco a generare nuove funzioni calcolabili.
+ $bold(elem^Omega = cal(P))$: definiamo la classe delle *funzioni ricorsive parziali*. Questa sarà la nostra idea astratta della classe delle funzioni calcolabili secondo Kleene.

Quello che faremo dopo la definizione di $cal(P)$ sarà chiederci se questa idea di calcolabile che abbiamo _"catturato"_ coincida o meno con le funzioni presenti in $F(ram) = F(mwhile)$.

=== Primo passo: ELEM

Definiamo l'insieme ELEM con le seguenti funzioni: $ elem = {"successore" &: s(x) = x + 1 bar.v x in NN, \ "zero" &: 0^n (x_1, dots, x_n) = 0 bar.v x_i in NN, \ "proiettori" &: "pro"_k^n (x_1, dots, x_n) = x_k bar.v x_i in NN} quad . $

Questo insieme è un _onesto punto di partenza_: sono funzioni basilari che qualsiasi idea data teoricamente non può non considerare come calcolabile.

Ovviamente, ELEM non può essere considerato come l'idea teorica di _TUTTO_ ciò che è calcolabile: infatti, la funzione $f(x) = x + 2$ non appartiene a ELEM ma è sicuramente calcolabile.

Quindi, ELEM è troppo povero e deve essere ampliato.

=== Secondo passo: $Omega$

Definiamo ora un insieme $Omega$ di operazioni che amplino le funzioni di ELEM per permetterci di coprire tutte le funzioni calcolabili.

+ *Composizione*

  Il primo operatore che ci viene in mente di utilizzare è quello di *composizione*.

  Siano:
  - $h : NN^k arrow.long NN$ *funzione di composizione*,
  - $g_1, dots, g_k : NN^n arrow.long NN$ _"funzioni intermedie"_ e
  - $wstato(x) in NN^n$ input.

  Allora definiamo $ comp(h, g_1, dots, g_k) : NN^n arrow.long NN $ la funzione tale che $ comp(h, g_1, dots, g_k)(wstato(x)) = h(g_1 (wstato(x)), dots, g_k (wstato(x))). $ 

  #v(12pt)

  #figure(
      image("../assets/composizione.svg", width: 50%)
  )

  #v(12pt)

  COMP è una funzione _intuitivamente calcolabile_ se parto da funzioni calcolabili: infatti, prima eseguo le singole funzioni $g_1, dots, g_k$ e poi applico la funzione $h$ sui risultati delle funzioni $g_i$.

  Calcoliamo ora la chiusura di ELEM rispetto a COMP, ovvero l'insieme $elem^comp$.

  Vediamo subito come la funzione $f(x) = x + 2$ appartenga a questo insieme perché $ comp(s,s)(x) = s(s(x)) = (x+1)+1 = x + 2. $

  _Che altre funzioni ci sono in questo insieme?_ Sicuramente tutte le funzioni lineari del tipo $f(x) = x + k$, _ma la somma?_

  La funzione $ "somma"(x,y) = x + y $ non appartiene a questo insieme perché il valore $y$ non è prefissato e non abbiamo ancora definito il concetto di iterazione di una funzione (in questo caso la funzione successore).

  Dobbiamo ampliare ancora $elem^comp$ con altre operazioni.

+ *Ricorsione primitiva*

  Definiamo un'operazione che ci permetta di *iterare* sull'operatore di composizione, la *ricorsione primitiva*, usata per definire *funzioni ricorsive*.

  Siano:
  - $g: NN^n arrow.long NN$ *funzione caso base*,
  - $h: NN^(n+2) arrow.long NN$ *funzione passo ricorsivo*
  - $wstato(x) in NN^n$ input.

  Definiamo $ rp(h,g) = f(wstato(x),y) = cases(g(wstato(x)) & "se" y = 0, h(f(wstato(x),y-1), y-1, wstato(x)) quad & "se" y > 0) quad $ funzione che generalizza la definizione ricorsiva di funzioni.

  Come prima, chiudiamo $elem^comp$ rispetto a RP, ovvero calcoliamo l'insieme $elem^({comp,rp})$. Chiamiamo $ ricprim = elem^({comp, rp}) $ l'insieme ottenuto dalla chiusura, cioè l'insieme delle *funzioni ricorsive primitive*.

  In questo insieme abbiamo la somma: infatti, $ "somma"(x,y) = cases(x = "Pro"^2_1 (x,y) & "se" y = 0, s("somma"(x,y-1)) quad & "se" y > 0) quad . $

  Altre funzioni che stanno in RICPRIM sono: $ "prodotto"(x,y) = cases(0 = 0^2 (x,y) & "se" y = 0, "somma"(x, "prodotto"(x,y-1)) quad & "se" y > 0) quad ; \ "predecessore" P(x) = cases(0 & "se" x = 0, x - 1 quad & "se" x > 0) quad arrow.long.double quad x overset(-,.) y = cases(x & "se" y = 0, P(x) overset(-,.) (y-1) quad & "se" y > 0) quad . $

===== RICPRIM vs WHILE

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

  Quindi $Psi_w (<x,y>) = rp(h,g)(wstato(x), y)$.
]

Abbiamo quindi dimostrato che $ricprim subset.eq F(mwhile)$, _ma questa inclusione è propria?_

=== Considerazioni

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
