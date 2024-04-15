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

Siano $Omega = {"op"_1, dots, "op"_t}$ un insieme di operazioni su $U$ di arità rispettivamente $k_1, dots, k_t$ e $A subset.eq U$. Il più piccolo sottoinsieme di $U$ contenente $A$ e chiuso rispetto a $Omega$ è la *chiusura di $A$ rispetto a $Omega$*, e cioè l'insieme $A^Omega$ definito come:
- $forall a in A arrow.long.double a in A^Omega$;
- $forall i in {1,dots,t}, quad forall a_1, dots, a_(k i) in A^Omega arrow.long.double "op"_i (a_i, dots, a_(k i)) in A^Omega$;
- nient'altro è in $A^Omega$.

== Definizione teorica di calcolabilità

=== Roadmap

Seguiremo la seguente roadmap:
+ *ELEM*: definiamo un insieme di tre funzioni che *qualunque* idea di calcolabile si voglia proporre deve considerare calcolabili. ELEM non può esaurire il concetto di calcolabilità, quindi lo espanderemo con altre funzioni;
+ $bold(Omega)$: definiamo insieme di operazioni su funzioni che costruiscono nuove funzioni. Le operazioni in $Omega$ sono banalmente implementabili e, applicandole a funzioni calcolabili, riesco a generare nuove funzioni calcolabili.
+ $bold(elem^Omega = cal(P))$: definiamo la classe delle *funzioni ricorsive parziali*. Questa sarà la nostra idea astratta della classe delle funzioni calcolabili secondo Kleene.

Quello che faremo dopo la definizione di $cal(P)$ sarò chiederci se questa idea di calcolabile che abbiamo _"catturato"_ coincide o meno con le funzioni presenti in $F(ram) = f(mwhile)$.

=== Primo passo: ELEM

Definiamo l'insieme ELEM con le seguenti funzioni: $ elem = {"successore" &: s(x) = x + 1 bar.v x in NN, \ "zero" &: 0^n (x_1, dots, x_n) = 0 bar.v x_i in NN, \ "proiettori" &: "pro"_k^n (x_1, dots, x_n) = x_k bar.v x_i in NN} quad . $

Questo insieme è un _onesto punto di partenza_: sono funzioni basilari che qualsiasi idea data teoricamente non può non considerare come calcolabile.

Ovviamente, ELEM non può essere considerato come l'idea teorica di _TUTTO_ ciò che è calcolabile: infatti, la funzione $f(x) = x + 2$ non appartiene a ELEM ma è sicuramente calcolabile.

Quindi, ELEM è troppo povero e deve essere ampliato.

=== Secondo passo: $Omega$

Definiamo ora un insieme $Omega$ di operazioni che amplino le funzioni di ELEM per permetterci di coprire tutte le funzioni calcolabili.

==== Composizione

Il primo operatore (_banale_) che ci viene in mente di utilizzare è quello di *composizione*.

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

COMP è una funzione _intuitivamente calcolabile_ se parto da funzioni calcolabili: infatti, prima eseguo le singole funzioni $g_1, dots, g_k$ e poi le applico alla funzione $h$.

Calcoliamo ora la chiusura di ELEM rispetto a COMP, ovvero l'insieme $elem^comp$.

Vediamo subito come la funzione $f(x) = x + 2$ appartenga a questo insieme perché $ comp(s,s)(x) = s(s(x)) = s(x+1) = x + 2. $

Che altre funzioni ci sono in questo insieme? Sicuramente tutte le funzioni lineari del tipo $f(x) = x + k$, ma la somma?

La funzione $ "somma"(x,y) = x + y $ non appartiene a questo insieme perché il valore $y$ non è prefissato e noi non sappiamo _iterare_ un certo numero di volte una certa funzione (in questo caso la funzione successore).

DObbiamo ampliare ancora $elem^comp$ con altre operazioni.

==== Ricorsione primitiva

Definiamo un'operazione che ci permetta di *iterare* sull'operatore di composizione. Questa operazione è la *ricorsione primitiva* e viene usata per definire *funzioni ricorsive*, ovvero funzioni definite tramite loro stesse.

Siano:
- $g: NN^n arrow.long NN$ *funzione caso base*,
- $h: NN^(n+2) arrow.long NN$ *funzione passo ricorsivo* e
- $wstato(x) in NN^n$ input.

Allora definiamo $ rp(h,g) = f(wstato(x),y) = cases(g(wstato(x)) & "se" y = 0, h(f(wstato(x),y-1), y-1, wstato(x)) quad & "se" y > 0) quad $ funzione che generalizza la definizione ricorsiva di funzioni.

Come prima, chiudiamo $elem^comp$ rispetto a RP, ovvero calcoliamo l'insieme $elem^({comp,rp})$.

Questo insieme che otteniamo tramite la chiusura lo chiamiamo $ ricprim = elem^({comp, rp}) $ ed è l'insieme delle *funzioni ricorsive primitive*.

In questo insieme abbiamo la somma: infatti, $ "somma"(x,y) = cases(x = "Pro"^2_1 (x,y) & "se" y = 0, s("somma"(x,y-1)) quad & "se" y > 0) quad . $

Altre funzioni che stanno in RICPRIM sono: $ "prodotto"(x,y) = cases(0 = 0^2 (x,y) & "se" y = 0, "somma"(x, "prodotto"(x,y-1)) quad & "se" y > 0) quad ; \ "predecessore" P(x) = cases(0 & "se" x = 0, x - 1 quad & "se" x > 0) quad arrow.long.double quad x overset(-,.) y = cases(x & "se" y = 0, P(x) overset(-,.) (y-1) quad & "se" y > 0) quad . $

===== RICPRIM vs WHILE

L'insieme RICPRIM contiene molte funzioni, ma abbiamo raggiunto l'insieme $F(mwhile)$? Mostriamo che $ricprim subset.eq F(mwhile)$ per induzione strutturale.

Prima di tutto, vediamo come è definita RICPRIM:
- $forall f in elem arrow.long.double f in ricprim$;
- se $h, g_1, dots, g_k in ricprim arrow.long.double comp(h, g_1, dots, g_k) in ricprim$;
- se $g,h in ricprim arrow.long.double rp(g,h) in ricprim$;
- nient'altro sta in RICPRIM.

#theorem(numbering: none)[
  $ricprim subset.eq F(mwhile)$.
]<thm>

#proof[
  \ Dimostriamo prima di tutto il caso base.
  Le funzioni di ELEM sono ovviamente while programmabili, le avevamo mostrate in precedenza.

  Passiamo ora al passo induttivo.

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
    begin
      x0 := G1(x1);         # In x1 inizialmente ho <a1,...,an>
      x0 := [x0, G2(x1)];
      ...
      x0 := [x0, Gk(x1)];
      x1 := H(x0);
    end
    ```
  ]

  Per RP, assumiamo per ipotesi induttiva che $h, g in ricprim$ siano while programmabili, allora esistono $H,G in wprogrammi$ tali che $Psi_H = h$ e $Psi_G = g$. Le funzioni ricorsive primitive le possiamo vedere come delle iterazioni che, partendo dal caso base $G$, mano a mano compongono con $H$ fino a quando non si raggiunge $y$ (escluso).

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
]<proof>

Abbiamo quindi dimostrato che $ricprim subset.eq F(mwhile)$, ma questa inclusione è propria?

===== Considerazioni

Notiamo subito che nel linguaggio WHILE posso fare dei cicli infiniti, mentre in RICPRIM questo non posso farlo: infatti, RICPRIM contiene solo funzioni totali (si dimostra per induzione strutturale) mentre WHILE contiene anche delle funzioni parziali.

Abbiamo quindi dimostrato che $ ricprim subset.neq F(mwhile). $

Visto che le funzioni in RICPRIM sono tutte totali possiamo di dire che ogni ciclo in RICPRIM ha un inizio e una fine ben definiti: infatti, il costrutto usato per dimostrare che $rp in F(mwhile)$ nella dimostrazione precedente ci permette di definire un nuovo tipo di ciclo, il *ciclo FOR*.

// Uffa ha lasciato una riga sotto
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

Il FOR che viene utilizzato è il _FOR giusto_, cioè quel costrutto che si serve di una *variabile di controllo* che parte da un preciso valore e arriva ad un valore limite (senza toccarlo) senza la possibilità di poterla modificare in corso d'opera. Questo costrutto nel linguaggio Pascal veniva implementato mettendo la variabile di controllo in un registro particolare per permettere la sua non modifica da esterni.

Il FOR language è quindi un linguaggio WHILE dove l'istruzione di loop è un FOR.

Possiamo quindi dire che $lfor = ricprim$, e quindi che $F(lfor)$ non raggiunge $F(mwhile)$.

Vediamo però che questo confronto sia un po' impari: WHILE vince su RICPRIM solo perché ha i loop infiniti. Restringiamo allora WHILE imponendo dei loop non infiniti: creiamo l'insieme $ overset(F,tilde)(mwhile) = {Psi_W : W in wprogrammi and Psi_W "totale"}. $

Dove si posizione questo insieme rispetto a RICPRIM? L'inclusione è propria?

La risposta è sì: vince ancora WHILE perché ci sono funzioni in $overset(F,tilde)(mwhile)$ che non sono scrivibili come funzioni in RICPRIM. Ad esempio, la funzione di Ackermann del 1928 definita come $ cal(A)(m,n) = cases(n+1 & "se" m = 0, cal(A)(m-1, 1) & "se" m > 0 and n = 0, cal(A)(m-1, cal(A)(m, n-1)) quad & "se" m > 0 and n > 0) $ è una funzione che non appartiene a RICPRIM perché con la doppia ricorsione questa funzione cresce troppo in fretta, e quindi non può appartenere a RICPRIM.

Dobbiamo quindi ampliare RICPRIM.
