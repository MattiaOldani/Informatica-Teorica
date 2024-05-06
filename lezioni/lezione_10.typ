// Setup

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

= Lezione 10

== Interprete WHILE di programmi RAM

Risolto il problema dell'input di un interprete scritto in linguaggio WHILE per i programmi RAM, ora vogliamo scrivere questo interprete, ricordando che per comodità non useremo il WHILE puro ma il macro-WHILE.

Cosa fa l'interprete? In poche parole, esegue una dopo l'altra le istruzioni RAM del programma $P$ e restituisce il risultato $phi_P (x)$. Notiamo come restituiamo un risultato, non un eseguibile.

Infatti, quello che fa l'interprete è ricostruire virtualmente tutto ciò che gli serve per gestire il programma. Nel nostro caso, $I_w$ deve ricostruire l'ambiente di una macchina RAM. Quello che faremo sarà ricreare il programma $P$, il program counter $L$ e i registri $R_0, R_1, R_2, dots$ dentro le variabili messe a disposizione dalla macchina WHILE.

Qua sorge un problema: i programmi RAM possono utilizzare infiniti registri, mentre i programmi WHILE ne hanno solo $21$. _Ma veramente il programma P usa un numero infinito di registri?_

La risposta è no. Infatti, se $cod(P) = n$ allora $P$ non utilizza mai dei registri $R_j$, con $j > n$. Se uso un registro di indice $n+1$ non posso avere codifica $n$ perché l'istruzione che usa $n+1$ ha come codifica i numeri $3(n+1)$ se incremento, $3(n+1)+1$ se decremento oppure il numero generato da Cantor se GOTO. Inoltre, le singole istruzioni codificate vanno codificate tramite lista di Cantor, e abbiamo mostrato come questa funzione cresca molto rapidamente.

Di conseguenza, possiamo restringerci a modellare i registri $R_0, dots, R_(n+2)$. Usiamo i registri fino a a $n+2$ solo per avere un paio di registri in più che potrebbero tornare utili. Ciò ci permette di codificare la memoria utilizzata dal programma $P$ tramite la funzione di Cantor.

// Magari mettere arrow.long.l se graficamente appaga di più
Vediamo, nel dettaglio, l'interno di $I_w (cantor(x,n)) = phi_n (x)$:
- $x_0$ contiene $cantor(R_0, dots, R_(n+2))$, lo stato della memoria della macchina RAM;
- $x_1$ contiene $L$, il program counter;
- $x_2$ contiene $x$, il dato su cui lavora $P$;
- $x_3$ contiene $n$, il "listato" del programma P;
- $x_4$ contiene il codice dell'istruzione da eseguire, prelevata da $x_3$ grazie a $x_1$.

Ricordiamo che all'avvio l'interprete $I_w$ trova il suo input nella variabile di input $x_1$.

=== Codice dell'interprete $I_w$

#code(
  // Con breakable si divide in due pagine ma fa cacare
  // breakable: true,
  fill: luma(240),
  indent-guides: 0.2pt + red,
  inset: 10pt,
  line-numbers: false,
  radius: 4pt,
  row-gutter: 6pt,
  stroke: 1pt + black
)[
  ```py
  # Inizializzazione
  input(<x,n>);                         # In x1
  x2 := sin(x1);                        # Dato x
  x3 := des(x1);                        # Programma n
  x0 := <0,x2,0,...,0>;                 # Memoria iniziale
  x1 := 1;                              # Program counter

  # Esecuzione
  while (x1 != 0) do:                   # Se x1 = 0 HALT
    if (x1 > length(x2)) then           # Sono fuori dal programma?
      x1 := 0;                          # Vado in HALT
    else
      x4 := Pro(x1, x3);                # Fetch istruzione
      if (x4 mod 3 == 0) then           # Incremento?
        x5 := x4 / 3;                   # Trovo k
        x0 := incr(x5, x0);             # Incremento
        x1 := x1 + 1;                   # Istruzione successiva
      if (x4 mod 3 == 1) then           # Decremento?
        x5 := (x4 - 1) / 3;             # Trovo k
        x0 := decr(x5, x0);             # Decremento
        x1 := x1 + 1;                   # Istruzione successiva
      if (x4 mod 3 == 2) then           # GOTO?
        x5 := sin((x4 + 1) / 3);        # Trovo k
        x6 := des((x4 + 1) / 3);        # Trovo m
        if (Proj(x5, x0) == 0) then     # Devo saltare?
          x1 := x4;                     # Salto a m
        else
          x1 := x1 + 1;                 # Istruzione successiva

  # Finalizzazione
  x0 := sin(x0);                        # Oppure Pro(0,x0)
  ```
]

=== Conseguenza dell'esistenza di $I_w$

// Sistemare, in WHILE non puoi fare n <-- cod(P)
// Io farei piuttosto x2 := cod(P)
// Non mi torna comunque sta cosa
Avendo in mano l'interprete $I_W$, possiamo costruire un compilatore $ compilatore : programmi arrow.long wprogrammi $ tale che $ compilatore(P in programmi) equiv & n arrow.long.l cod(P) \ & x_1 := cantor(x_1, n) \ & I_W quad . $

Questo significa che il compilatore non fa altro che cablare all'input $x$ il programma RAM da interpretare e procede con l'esecuzione dell'interprete.

Vediamo se le tre proprietà di un compilatore sono soddisfatte:
- *programmabile*: sì, lo abbiamo appena fatto;
- *completo*: l'interprete riesce a riconoscere ogni istruzione RAM e la riesce a codificare;
- *corretto*: vale $P in programmi arrow.long.bar compilatore(P) in wprogrammi$, quindi: $ Psi_(compilatore(P)) (x) = Psi_I_W (cantor(x,n)) = phi_n (x) = phi_P (x) $ rappresenta la sua semantica.

Abbiamo dimostrato quindi che $ F(ram) subset.eq F(mwhile), $ che è l'inclusione opposta del precedente risultato.

Il risultato appena ottenuto ci permette di definire un teorema molto importante.

#theorem(
  name: "Teorema di Böhm-Jacopini (1970)",
  numbering: none
)[
  Per ogni programma con GOTO (RAM) ne esiste uno equivalente in un linguaggio strutturato (WHILE).
]

Questo teorema è fondamentale perché lega la programmazione a basso livello con quella ad alto livello. In poche parole, il GOTO può essere eliminato e la programmazione a basso livello può essere sostituita da quella ad alto livello.

=== Altre conseguenze e osservazioni

Grazie alle due inclusioni dimostrate in precedenza abbiamo dimostrato anche che $ F(mwhile) subset.eq F(ram) \ F(ram) subset.eq F(mwhile) \ arrow.double.b \ F(ram) = F(mwhile) \ arrow.double.b \ F(ram) = F(mwhile) tilde programmi tilde NN tilde.not NN^NN_bot. $

Quindi, seppur profondamente diversi, i sistemi $ram$ e $mwhile$ calcolano le stesse cose. Viene naturale chiedersi quindi quale sia la vera natura della calcolabilità.

Un altro risultato che abbiamo dimostrato _formalmente_ è che nei sistemi di programmazione RAM e WHILE esistono funzioni *non calcolabili*, che sono nella _parte destra_ della catena scritta sopra.

=== Compilatore universale

Facciamo una mossa esotica: usiamo il compilatore da WHILE a RAM $compilatore : wprogrammi arrow programmi$ sul programma $I_w$. Lo possiamo fare? Certo, posso compilare $I_W$ perché è un programma WHILE.

Chiamiamo questo risultato $ cal(U) = compilatore(I_W) in programmi. $ La sua semantica è $ phi_(cal(U)) (cantor(x,n)) = Psi_(I_W) (cantor(x,n)) = phi_n (x) $ dove $n$ è la codifica del programma RAM e $x$ il dato di input.

Cosa abbiamo fatto vedere? Abbiamo appena mostrato che esiste un programma RAM in grado di simulare tutti gli altri programmi RAM.

Questo programma viene detto *interprete universale*.

Considereremo _"buono"_ un linguaggio se esiste un interprete universale per esso.

== Riflessioni sul concetto di calcolabilità

Ricordiamo che il nostro obiettivo è andare a definire la regione delle funzioni calcolabili e, di conseguenza, anche quella delle funzioni non calcolabili. Abbiamo visto che RAM e WHILE permettono di calcolare le stesse cose.

_Possiamo definire ciò che è calcolabile a prescindere dalle macchine che usiamo per calcolare?_

Come disse *Kleene*, vogliamo definire ciò che è calcolabile in termini più astratti, matematici, lontani dall'informatica. Se riusciamo a definire il concetto di calcolabile senza che siano nominate macchine calcolatrici, linguaggi e tecnologie ma utilizzando la matematica potremmo usare tutta la potenza di quest'ultima.

== Chiusura di insiemi rispetto alle operazioni

=== Operazioni

Dato un insieme $U$, si definisce *operazione* su $U$ una qualunque funzione $ "op": underbracket(U times dots times U, k) arrow.long U. $ 

Il numero $k$ indica l'*arietà* (o _arità_) dell'operazione, ovvero la dimensione del dominio dell'operazione.

=== Chiusura

L'insieme $A subset.eq U$ si dice *chiuso* rispetto all'operazione $"op": U^k arrow.long U$ se e solo se $ forall a_1, dots, a_k in A quad "op"(a_1, dots, a_k) in A. $ In poche parole, _se opero in A rimango in A_.

In generale, se $Omega$ è un insieme di operazioni su $U$, allora $A subset.eq U$ è chiuso rispetto a $Omega$ se e solo se $A$ è chiuso per *ogni* operazioni in $Omega$.

=== Chiusura di un insieme

#underline("Problema"): siano $A subset.eq U$ e $"op" : U^k arrow.long U$, voglio espandere l'insieme $A$ per trovare il più piccolo sottoinsieme di $U$ tale che:
+ contiene $A$;
+ chiuso per $"op"$.

Quello che voglio fare è espandere $A$ il minimo possibile per garantire la chiusura rispetto a $"op"$.

Due risposte ovvie a questo problema sono:
+ se $A$ è chiuso rispetto a $"op"$, allora $A$ stesso è l'insieme cercato;
+ sicuramente $U$ soddisfa le due richieste, _ma è il più piccolo?_

#theorem(numbering: none)[
  Siano $A subset.eq U$ e $"op" : U^k arrow.long U$. Il più piccolo sottoinsieme di $U$ contenente $A$ e chiuso rispetto all'operazione $"op"$ si ottiene calcolando la *chiusura di $A$ rispetto a $"op"$*, e cioè l'insieme $A^"op"$ definito *induttivamente* come:
  + $forall a in A arrow.long.double a in A^"op"$;
  + $forall a_1, dots, a_k in A^"op" arrow.long.double "op"(a_1, dots, a_k) in A^"op"$;
  + nient'altro sta in $A^"op"$.
]

Vediamo una definizione più _operativa_ di $A^"op"$:
+ metti in $A^"op"$ tutti gli elementi di $A$;
+ applica $"op"$ a una $k$-tupla di elementi in $A^"op"$;
+ se trovi un risultato che non è già in $A^"op"$ allora aggiungilo ad $A^"op"$;
+ ripeti i punti (2) e (3) fintantoché $A^"op"$ cresce.
