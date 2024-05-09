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

= Lezione 16

== Riconoscibilità automatica di insiemi

Proviamo a dare una _gradazione_ sul livello di risoluzione dei problemi. Vogliamo capire se un dato problema:
- può essere risolto;
- non può essere risolto completamente (meglio di niente);
- non può essere risolto.

Costruiamo un programma che classifichi gli elementi di un insieme, quindi ci dica se un certo numero naturale appartiene o meno all'insieme.

Un insieme $A subset.eq NN$ è *riconoscibile automaticamente* se esiste un programma $P_A$ che classifica correttamente *ogni* elemento di $NN$ come appartenente o meno ad $A$, ovvero

$ x in NN arrow.long.squiggly P_A (x) = cases(1 & "se" x in A, 0 quad & "se" x in.not A) quad . $

Il programma $P_A$ deve essere:
- *corretto*: classifica correttamente gli elementi che riceve in input;
- *completo*: classifica tutti gli elementi di $NN$, nessuno escluso.

_Tutti gli insiemi sono automaticamente riconoscibili? Quali insiemi sono automaticamente riconoscibili? Quali invece non lo sono?_

Siamo certi che non tutti gli insiemi siano automaticamente riconoscibili, infatti grazie al concetto di _cardinalità_ sappiamo che:
- i sottoinsiemi di $NN$ sono densi come $RR$;
- io non ho $RR$ programmi quindi sicuramente c'è qualche insieme che non lo è.

=== Insiemi ricorsivi

Un insieme $A subset.eq NN$ è un *insieme ricorsivo* se esiste un programma $P_A$ che si arresta su ogni input classificando correttamente gli elementi di $NN$ in base alla loro appartenenza o meno ad $A$.

Equivalentemente, ricordando che la funzione caratteristica di $A subset.eq NN$ è la funzione $ chi_A : NN arrow.long {0,1} $ tale che $ chi_A (x) = cases(1 "se" x in A, 0 "se" x in.not A) quad , $ diciamo che l'insieme $A$ è ricorsivo se e solo se $ chi_A in cal(T) . $

Che $chi_A$ sia totale è banale, perché tutte le funzioni caratteristiche devono essere definite su tutto $NN$. Il problema risiede nella calcolabilità di queste funzioni.

Le due definizioni date sono equivalenti:
- il programma $P_A$ implementa $chi_A arrow.double chi_A in cal(T)$ perché esiste un programma che la calcola;
- $chi_A in cal(T) arrow.double$ esiste un programma $P_A$ che la implementa e che soddisfa la definizione data sopra.

==== Ricorsivo vs. Decidibile

Spesso, si dice che _un insieme ricorsivo è un insieme decidibile_, ma è solo abuso di notazione. Questo è dovuto al fatto che ad ogni insieme $A subset.eq NN$ possiamo associare il suo *problema di riconoscimento*, così definito:

- Nome: $"RIC"_A$.
- Istanza: $x in NN$.
- Domanda: $x in A$?

La sua funzione soluzione $ Phi_("RIC"_A) : NN arrow.long {0,1} $ è tale che $ Phi_("RIC"_A) (x) = cases(1 & "se" x in A, 0 quad & "se" x in.not A) quad . $

Notiamo che la semantica del problema è proprio la funzione caratteristica $arrow.double Phi_("RIC"_A) = chi_A$.
Quindi, se $A$ è ricorsivo, allora la sua funzione caratteristica è ricorsiva totale, ma lo sarà anche la funzione soluzione $Phi$ e, di conseguenza, $"RIC"_A$ è decidibile. In altre parole $ Phi_("RIC"_A) = chi_A in cal(T) arrow.double Phi_("RIC"_A) in cal(T) arrow.double "RIC"_A "è decidibile". $

==== Decidibile vs. Ricorsivo

Simmetricamente, sempre con abuso di notazione, si dice che _un problema di decisione è un problema ricorsivo_. Questo perché ad ogni problema di decisione $Pi$ possiamo associare $A_Pi$ *insieme delle sue istanze a risposta positiva*.

Dato il problema
- Nome: $Pi$.
- Istanza: $x in D$.
- Domanda: $p(x)$?
definiamo $ A_Pi = {x in D bar.v Phi_Pi (x) = 1} "con" Phi_Pi (x) = 1 equiv p(x) $ insieme delle istanze a risposta positiva di $Pi$.

Notiamo che, se $Pi$ è decidibile allora $Phi_Pi in cal(T)$, quindi esiste un programma che calcola questa funzione. La funzione in questione è quella che riconosce automaticamente l'insieme $A_Pi$, quindi $A_Pi$ è ricorsivo.

=== Insiemi non ricorsivi

Per trovare degli insiemi non ricorsivi cerco nei problemi di decisione non decidibili.

L'unico problema di decisione non decidibile che abbiamo visto è il *problema dell'arresto ristretto* $arresto(ristretto)$.

- Nome: $arresto(ristretto)$.
- Istanza: $x in NN$.
- Domanda: $phi_(ristretto) (x) = phi_x (x) arrow.b$?

Definiamo l'insieme delle istanze a risposta positiva di $arresto(ristretto)$ $ A = {x in NN bar.v phi_x (x) arrow.b}. $ Questo non può essere ricorsivo: se lo fosse, avrei un programma ricorsivo totale che mi classifica correttamente se $x$ appartiene o meno ad $A$, ma abbiamo dimostrato che il problema dell'arresto ristretto non è decidibile, quindi $A$ non è ricorsivo.

=== Relazioni ricorsive

$R subset.eq NN times NN$ è una *relazione ricorsiva* se e solo se l'insieme $R$ è ricorsivo, ovvero:
- la sua funzione caratteristica $chi_R$ è tale che $chi_R in cal(T)$, oppure
- esiste un programma $P_R$ che, presi in ingresso $x,y in NN$ restituisce $1$ se $(x R y)$, $0$ altrimenti.

Un'importante relazione ricorsiva è la relazione $ R_P = {(x,y) in NN^2 bar.v P "su input" x "termina in" y "passi"} . $

È molto simile al problema dell'arresto, ma non chiedo se $P$ termina in generale, chiedo se termina in $y$ passi.

Questa relazione è ricorsiva e per dimostrarlo costruiamo un programma che classifica $R_P$ usando:
- $U$ interprete universale;
- *clock* per contare i passi di interpretazione;
- *check del clock* per controllare l'arrivo alla quota $y$.

Definiamo quindi il programma $ overset(U,tilde) = U + "clock" + "check clock" $ tale che $ overset(U,tilde) equiv & "input"(x,y) \ & U(P,x) + "clock" \ & "ad ogni passo di" U(P,x): \ & quad "if clock" > y: \ & quad quad "output"(0) \ & quad "clock"++; \ & "output"("clock" == y) quad . $

Nel sistema RAM, ad esempio, per capire se l'output è stato generato o meno osservo se il PC, contenuto nel registro $L$, è uguale a 0.

Riprendiamo il problema dell'arresto ristretto: _come possiamo esprimere $A = {x in NN bar.v phi_x (x) arrow.b}$ attraverso la relazione ricorsiva $R_ristretto$?_

Possiamo definire l'insieme $ B = {x in NN bar.v exists y in NN bar.v (x R_ristretto y)}. $

Notiamo come $A = B$:
- $A subset.eq B$: se $x in A$ il programma codificato con $x$ su input $x$ termina in un certo numero di passi. Chiamiamo $y$ il numero di passi. $ristretto(x)$ termina in $y$ passi, ma allora $x R_ristretto y$ e quindi $x in B$;
- $B subset.eq A$: se $x in B$ esiste $y$ tale che $x R_ristretto y$, quindi $ristretto(x)$ termina in $y$ passi, ma allora il programma $ristretto = x$ su input $x$ termina, quindi $x in A$.

=== Insiemi ricorsivamente numerabili

Un insieme $A subset.eq NN$ è *ricorsivamente numerabile* se è *automaticamente listabile*: esiste una _routine_ $F$ che, su input $i in NN$, dà in output $F(i)$ come l'$i$-esimo elemento di $A$.

Il programma che lista gli elementi di $A$ è: $ P equiv & i := 0; \ & "while" (1 > 0) space { \ & quad "output"(F(i)) \ & quad i := i + 1; \ & } $

Per alcuni insiemi non è possibile ricoscere tutti gli elementi che gli appartengono, ma può essere che si conosca un modo per elencarli. Alcuni insiemi invece non hanno nemmeno questa proprietà.

Se il meglio che posso fare per avere l'insieme A è listarlo con P, _come posso scrivere un algoritmo che "tenta di riconoscere" A?_

Questo algoritmo deve listare tutti gli elementi senza un clock di timeout: se inserissi un clock avrei un insieme ricorsivo per la relazione $R_P$ mostrata in precedenza.

Vediamo il programma di *massimo riconoscimento*: $ P equiv & "input"(x) \ & i := 0; \ & "while" (F(i) eq.not x) \ & quad i := i + 1; \ & "output"(1) quad . $

Come viene riconosciuto l'insieme $A$? $ x in NN arrow.long.squiggly P(x) = cases(1 & "se" x in A, "LOOP" quad & "se" x in.not A) quad . $

Vista la natura di questa funzione, gli insiemi ricorsivamente numerabili sono anche detti *insiemi parzialmente decidibili/riconoscibili* o *semidecidibili*.

Se avessi indicazioni sulla monotonia della routine $F$ allora avrei sicuramente un insieme ricorsivo. In questo caso non assumiamo niente quindi rimaniamo negli insiemi ricorsivamente numerabili.

==== Definizione formale

L'insieme $A subset.eq NN$ è *ricorsivamente numerabile* se e solo se:
- $A = emptyset.rev$ oppure
- $A = immagine(f)$, con $f : NN arrow.long NN in cal(T) quad (A = {f(0), f(1), f(2), dots})$.

Visto che $f$ è ricorsiva totale esiste un/a programma/routine $F$ che la implementa e che usiamo per il parziale riconoscimento di $A$: questo programma, se $x in A$, prima o poi mi restituisce 1, altrimenti entra in loop.

È come avere un _libro con infinite pagine_, su ognuna delle quali compare un elemento di $A$. Il programma di riconoscimento $P$, grazie alla routine $F$, non fa altro che sfogliare le pagine $i$ di questo libro alla ricerca di $x$:
- se $x in A$ prima o poi $x$ compare nelle pagine del libro come $F(i)$;
- se $x in.not A$ sfoglio il libro all'infinito, non sapendo quando fermarmi.

==== Caratterizzazioni degli insiemi ricorsivamente numerabili

#theorem(numbering: none)[
  Le seguenti definizioni sono equivalenti:
  + $A$ è ricorsivamente numerabile, con $A = immagine(f)$ e $f in cal(T)$ funzione ricorsiva totale;
  + $A = dominio(f)$, con $f in cal(P)$ funzione ricorsiva parziale;
  + esiste una relazione $R subset.eq NN^2$ ricorsiva tale che $A = {x in NN bar.v exists y in NN bar.v (x,y) in R}$.
]

#proof[
  \ Per dimostrare questi teoremi dimostriamo che $1 arrow.long.double 2 arrow.long.double 3 arrow.long.double 1$, creando un'implicazione ciclica.

  #block(
    fill: rgb("#9FFFFF"),
    inset: 8pt,
    radius: 4pt,
    
    [$1 arrow.long.double 2$] 
  )
  
  Sappiamo che $A = immagine(f)$, con $f in cal(T)$, è ricorsivamente numerabile, quindi esistono la sua routine di calcolo $f$ e il suo algoritmo di parziale riconoscimento $P$, definiti in precedenza. Vista la definizione di $P$, abbiamo che $ phi_P (x) = cases(1 "se" x in A, bot "se" x in.not A) quad , $ ma allora $A = dominio(phi_P)$: il dominio è l'insieme dei valori dove la funzione è definita, in questo caso proprio l'insieme $A$. Inoltre, $phi_P in cal(P)$ perché ho mostrato che esiste un programma $P$ che la calcola.

  #block(
    fill: rgb("#9FFFFF"),
    inset: 8pt,
    radius: 4pt,
    
    [$2 arrow.long.double 3$]
  )

  Sappiamo che $A = dominio(f)$, con $f in cal(P)$, quindi esiste un programma $P$ tale che $phi_P = f$. Considero allora la relazione $ R_P = {(x,y) in NN^2 bar.v P "su input" x "termina in" y "passi"}, $ che abbiamo dimostrato prima essere ricorsiva. Definiamo $ B = {x in NN bar.v exists y bar.v (x,y) in R_P}. $ Dimostriamo che A = B. Infatti:
  - $A subset.eq B$: se $x in A$ allora su input $x$ il programma $P$ termina in un certo numero di passi $y$, visto che $x$ è nel "dominio" di tale programma. Vale allora $(x,y) in R_P$ e quindi $x in B$;
  - $B subset.eq A$: se $x in B$ allora per un certo $y$ ho $(x,y) in R_P$, quindi $P$ su input $x$ termina in $y$ passi, ma visto che $phi_P (x) arrow.b$ allora $x$ sta nel dominio di $f = phi_P$, quindi $x in A$.

  #block(
    fill: rgb("#9FFFFF"),
    inset: 8pt,
    radius: 4pt,
    
    [$3 arrow.long.double 1$]
  )

  Sappiamo che $A = {x in NN bar.v exists y bar.v (x,y) in R}$, con $R$ relazione ricorsiva.

  Assumiamo che $A eq.not emptyset.rev$ e scegliamo $a in A$, sfruttando l'assioma della scelta. Definiamo ora la funzione $t : NN arrow.long NN$ come $ t(n) = cases(cantorsin(n) quad & "se" (cantorsin(n), cantordes(n)) in R, a & "altrimenti") quad . $

  Visto che $R$ è una relazione ricorsiva esiste un programma $P_R$ che categorizza ogni numero naturale, ma allora la funzione $t$ è ricorsiva totale. Infatti, possiamo scrivere il programma $ P equiv & "input"(n) \ & x := cantorsin(n); \ & y := cantordes(n); \ & "if" (P_R (x,y) == 1) \ & quad "output"(x) \ & "else" \ & quad "output"(a) $ che implementa la funzione $t$, quindi $phi_P = t$.

  Dimostriamo che $A = immagine(t)$. Infatti:
  - $A subset.eq immagine(t)$: se $x in A$ allora $(x,y) in R$, ma allora $t(cantor(x,y)) = x$, quindi $x in immagine(t)$;
  - $immagine(t) subset.eq A$: se $x in immagine(t)$ allora:
    - se $x = a$ per l'assioma della scelta $a in A$ quindi $x in A$;
    - se $x = cantorsin(n)$, con $n = cantor(x,y)$ per qualche $y$ tale che $(x,y) in R$, allora $x in A$ per definizione di $A$.
]

Grazie a questo teorema abbiamo tre caratterizzazioni per gli insiemi ricorsivamente numerabili e possiamo sfruttare la formulazione che ci è più comoda.

Nell'esperienza del Prof. Carlo Mereghetti, è molto utile e comodo il punto 2. In ordine:
+ scrivo un programma $P$ che restituisce $1$ su input $x in NN$, altrimenti va in loop se $x in.not A$: $ P(x) = cases(1 quad & "se" x in A, bot & "se" x in.not A) quad ; $
+ la semantica di $P$ è quindi tale che: $ phi_P (x) = cases(1 "se" x in A, bot "se" x in.not A) quad ; $
+ la funzione calcolata è tale che $ phi_P in cal(P), $ visto che il programma che la calcola è proprio $P$, mentre l'insieme $A$ è tale che $ A = dominio(phi_P); $
+ $A$ è ricorsivamente numerabile per il punto 2.
