#import "../alias.typ": *

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


= $dati tilde NN$

Vogliamo formare una legge che:
+ associ biunivocamente dati a numeri e viceversa;
+ consenta di operare direttamente sui numeri per operare sui corrispondenti dati, ovvero abbia delle primitive per lavorare il numero che "riflettano" il risultato sul dato senza ripassare per il dato stesso;
+ ci consenta di dire, senza perdita di generalità, che i nostri programmi lavorano sui numeri.

== Funzione coppia di Cantor

La *funzione coppia di Cantor* è la funzione $ angle.l,angle.r: NN times NN arrow.long NN^+. $ Questa funzione sfrutta due _"sotto-funzioni"_, _sin_ e _des_, tali che $ cantor(x,y) &= n, \ cantorsin: NN^+ arrow.long NN, & quad cantorsin (n) = x \ cantordes: NN^+ arrow.long NN, & quad cantordes (n) = y. $

Vediamo una rappresentazione grafica della funzione di Cantor.

#v(12pt)

#figure(
  image("assets/cantor-01.svg", width: 50%)
)

#v(12pt)

$cantor(x,y)$ rappresenta il valore all'incrocio tra la $x$-esima riga e la $y$-esima colonna.

La tabella viene riempita _diagonale per diagonale_, ovvero:
+ sia $x=0$;
+ partendo dalla cella $(x,0)$ si enumerano le celle della diagonale identificata da $(x,0)$ e da $(0,x)$;
+ si ripete il punto $2$ aumentando $x$ di $1$.

Vorremmo che questa funzione sia iniettiva e suriettiva, quindi:
- non posso avere celle con lo stesso numero (_iniettiva_);
- ogni numero in $NN^+$ deve comparire.

Questa richiesta è soddisfatta in quanto:
- numeriamo in maniera incrementale (_iniettiva_);
- ogni numero prima o poi compare in una cella, quindi ho una coppia che lo genera (_suriettiva_).

=== Forma analitica della funzione coppia

Quello che vogliamo fare ora è cercare una forma analitica della funzione coppia, questo perché non è molto comodo costruire ogni volta la tabella sopra. Nella successiva immagine notiamo come valga la relazione $ cantor(x,y) = cantor(x+y,0) + y. $

#v(12pt)

#figure(
  image("assets/cantor-02.svg", width: 40%)
)

#v(12pt)

Questo è molto comodo perché il calcolo della funzione coppia si riduce al calcolo di $cantor(x+y,0)$.

Chiamiamo $x+ y = z$, osserviamo con la successiva immagine un'altra proprietà.

#v(12pt)

#figure(
  image("assets/cantor-03.svg", width: 15%)
)

#v(12pt)

Ogni cella $cantor(z,0)$ la si può calcolare come la somma di $z$ e $cantor(z-1,0)$, ma allora $ cantor(z,0) &= z + cantor(z-1,0) = \ &= z + (z-1) + cantor(z-2,0) = \ &= z + (z-1) + dots + 1 + cantor(0,0) = \ &= z + (z-1) + dots + 1 + 1 = \ &= sum_(i=1)^z i + 1 = frac(z(z+1),2) + 1. $

Questa forma è molto più compatta ed evita il calcolo di tutti i singoli $cantor(z,0)$.

Mettiamo insieme le due proprietà per ottenere la formula analitica della funzione coppia: $ cantor(x,y) = cantor(x+y,0) + y = frac((x+y)(x+y+1), 2) + y + 1. $

=== Forma analitica di sin e des

Vogliamo adesso dare la forma analitica di _sin_ e _des_ per poter computare l'inversa della funzione di Cantor, dato $n$.

Grazie alle osservazioni precedenti sappiamo che $ n = y + cantor(gamma,0) space &arrow.long.double space y = n - cantor(gamma,0), \ gamma = x + y space & arrow.long.double space x = gamma - y. $

Se troviamo il valore di gamma abbiamo trovato anche i valori di $x$ e $y$.

Notiamo come $gamma$ sia il _"punto di attacco"_ della diagonale che contiene $n$, ma allora $ gamma = max{z in NN bar.v cantor(z,0) lt.eq n} $ perché tra tutti i punti di attacco $cantor(z,0)$ voglio quello che potrebbe contenere $n$ e che sia massimo, ovvero sia esattamente la diagonale che contiene $n$.

Risolviamo quindi la disequazione $ cantor(z,0) lt.eq n & arrow.long.double frac(z(z+1),2) + 1 lt.eq n \ & arrow.long.double z^2 + z - 2n + 2 lt.eq 0 \ & arrow.long.double z_(1,2) = frac(-1 plus.minus sqrt(1 + 8n - 8), 2) \ & arrow.long.double frac(-1 - sqrt(8n - 7), 2) lt.eq z lt.eq frac(-1 + sqrt(8n - 7), 2). $

Come valore di $gamma$ scelgo $ gamma = floor(frac(-1 + sqrt(8n - 7), 2)). $

Ora che abbiamo $gamma$ possiamo definire le funzioni _sin_ e _des_ come $ cantordes(n) = y = n - cantor(gamma,0) = n - frac(gamma (gamma + 1), 2) - 1, \ cantorsin(n) = x = gamma - y. $

=== $NN times NN tilde NN$

Con la funzione coppia di Cantor possiamo dimostrare un importante risultato.

#theorem(numbering: none)[
  $NN times NN tilde NN^+$.
]

#proof[
  \ La funzione di Cantor è una funzione biiettiva tra l'insieme $NN times NN$ e l'insieme $NN^+$, quindi i due insiemi sono isomorfi.
]

Estendiamo adesso il risultato all'interno insieme $NN$, ovvero $ NN times NN tilde NN^+ arrow.long.squiggly NN times NN tilde NN. $

#theorem(numbering: none)[
  $NN times NN tilde NN$.
]

#proof[
  \ Definiamo la funzione $ [,]: NN times NN arrow.long NN $ tale che $ [x,y] = cantor(x,y) - 1. $
  
  Questa funzione è anch'essa biiettiva, quindi i due insiemi sono isomorfi.
]

Grazie a questi risultati si può dimostrare che $QQ tilde NN$: infatti, i numeri razionali li possiamo rappresentare come coppie $("num", "den")$. In generale, tutte le tuple sono isomorfe a $NN$, iterando in qualche modo la funzione coppia di Cantor.

== Dimostrazione

I risultati ottenuti fino a questo punto ci permettono di dire che ogni dato è trasformabile in un numero, che può essere soggetto a trasformazioni e manipolazioni matematiche.

La dimostrazione _formale_ non verrà fatta, ma verranno fatti esempi di alcune strutture dati che possono essere trasformate in un numero tramite la funzione coppia di Cantor. Vedremo come ogni struttura dati verrà manipolata e trasformata in una coppia $(x,y)$ per poterla applicare alla funzione coppia.

== Applicazione alle strutture dati

Le *liste* sono le strutture dati più utilizzate nei programmi. In generale non ne è nota la grandezza, di conseguenza dobbiamo trovare un modo, soprattutto durante la applicazione di _sin_ e _des_, per capire quando abbiamo esaurito gli elementi della lista.

Codifichiamo la lista $[x_1, dots, x_n]$ con $ cantor(x_1, dots, x_n) = cantor(x_1, cantor(x_2, cantor(dots cantor(x_n, 0) dots))) . $

Abbiamo quindi applicato la funzione coppia di Cantor alla coppia formata da un elemento della lista e il risultato della funzione coppia stessa applicata ai successivi elementi.

Ad esempio, la codifica della lista $M = [1,2,5]$ risulta essere: $ cantor(1,2,5) &= cantor(1, cantor(2, cantor(5,0))) \ &= cantor(1, cantor(2,16)) \ &= cantor(1, 188) \ &= 18144. $

Per decodificare la lista $M$ applichiamo le funzioni _sin_ e _des_ al risultato precedente. Alla prima iterazione otterremo il primo elemento della lista e la restante parte ancora da decodificare.

Quando ci fermiamo? Durante la creazione della codifica di $M$ abbiamo inserito un _"tappo"_, ovvero la prima iterazione della funzione coppia $cantor(x_n, 0)$. Questo ci indica che quando $cantordes(M)$ sarà uguale a $0$ ci dovremo fermare.

Cosa succede se abbiamo uno $0$ nella lista? Non ci sono problemi: il controllo avviene sulla funzione _des_, che restituisce la _"somma parziale"_ e non sulla funzione _sin_, che restituisce i valori della lista.

Possiamo anche anche delle implementazioni di queste funzioni. Assumiamo che:
- $0$ codifichi la lista nulla;
- esistano delle routine per $cantor(",")$, $cantorsin$ e $cantordes$.

#v(12pt)

#grid(
  columns: (1fr, 1fr),
  align(center)[
    Codifica
    ```python
    def encode(numbers: list[int]) -> int:
      k = 0
      for i in range(n,0,-1):
        xi = numbers[i]
        k = <xi,k>
      return k
    ```
  ],
  align(center)[
    Decodifica
    ```python
    def decode(n: int) -> list[int]:
      numbers = []
      while True:
        left, n = sin(n), des(n)
        numbers.append(left)
        if n == 0:
          break
      return numbers
    ```
  ]
)

#v(12pt)

Un metodo molto utile delle liste è quello che ritorna la sua *lunghezza*.

#align(center)[
  Lunghezza
  ```python
  def length(n: int) -> int:
    return 0 if n == 0 else 1 + length(des(n))
  ```
]

Infine, definiamo la funzione *proiezione* come: $ op("proj")(t,n) = cases(-1 quad & text("se") t > op("length")(n) or t lt.eq 0 \ x_t & text("altrimenti")) $

e la sua implementazione:

#align(center)[
  Proiezione
  ```python
  def proj(t: int, n: int) -> int:
    if t <= 0 or t > length(n):
      return -1
    else:
      if t == 1:
        return sin(n)
      else:
        return proj(t - 1, des(n))
  ```
]

Per gli *array* il discorso è più semplice, in quanto la dimensione è nota a priori. Di conseguenza, non necessitiamo di un carattere di fine sequenza. Dunque avremo che l'array ${x_1, dots, x_n}$ viene codificato con: $ [x_1, dots, x_n] = [x_1, dots [x_(n-1), x_n] dots ]. $

Per quanto riguarda *matrici* l'approccio utilizzato codifica singolarmente le righe e successivamente codifica i risultati ottenuti come se fossero un array di dimensione uguale al numero di righe.

#set math.mat(delim: "[")

Ad esempio, la matrice $ mat(x_11, x_12, x_13; x_21, x_22, x_23; x_31, x_32, x_33) $ viene codificata in: $ mat(x_11, x_12, x_13; x_21, x_22, x_23; x_31, x_32, x_33) = [[x_11, x_12, x_13], [x_21, x_22, x_23], [x_31, x_32, x_33]]. $

Consideriamo il seguente grafo.

#v(12pt)

#figure(
  image("assets/grafo.svg", width: 25%)
)

#v(12pt)

I *grafi* sono rappresentati principalmente in due modi:
- *liste di adiacenza dei vertici*: per ogni vertice si ha una lista che contiene gli identificatori dei vertici che collegati direttamente con esso. Il grafo precedente ha $ {1:[2,3,4], 2:[1,3], 3:[1,2,4], 4:[1,3]} $ come lista di adiacenza, e la sua codifica si calcola come: $ [cantor(2,3,4),cantor(1,2),cantor(1,2,4),cantor(1,3)]. $ Questa soluzione esegue prima la codifica di ogni lista di adiacenza e poi la codifica dei risultati del passo precedente.
- *matrice di adiacenza*: per ogni cella $m_(i j)$ della matrice $|V| times |V|$, dove $V$ è l'insieme dei vertici, si ha:
  - $1$ se esiste un arco dal vertice $i$ al vertice $j$;
  - $0$ altrimenti;
  Essendo questa una matrice la andiamo a codificare come abbiamo già descritto.

== Applicazione alle strutture dati

Una volta visto come rappresentare le principali strutture dati, è facile trovare delle vie per codificare qualsiasi tipo di dato in un numero. Vediamo alcuni esempi.

Dato un *testo*, possiamo ottenere la sua codifica nel seguente modo:
+ trasformiamo il testo in una lista di numeri tramite la codifica ASCII dei singoli caratteri;
+ sfruttiamo l'idea dietro la codifica delle liste per codificare quanto ottenuto.

Per esempio, $ "ciao" = [99, 105, 97, 111] = cantor(99, cantor(105, cantor(97, cantor(111, 0)))) . $

Possiamo chiederci:
- _Il codificatore proposto è un buon compressore?_ \ No, si vede facilmente che il numero ottenuto tramite la funzione coppia (o la sua concatenazione) sia generalmente molto grande, e che i bit necessari a rappresentarlo crescano esponenzialmente sulla lunghezza dell'input. Ne segue che questo è un _pessimo_ modo per comprimere messaggi.
- _Il codificatore proposto è un buon sistema crittografico?_ \ La natura stessa del processo garantisce la possibilità di trovare un modo per decifrare in modo analitico, di conseguenza chiunque potrebbe, in poco tempo, decifrare il mio messaggio. Inoltre, questo metodo è molto sensibile agli errori.

Dato un *suono*, possiamo _campionare_ il suo segnale elettrico a intervalli di tempo regolari e codificare la sequenza dei valori campionati tramite liste o array.

Per codificare le *immagini* esistono diverse tecniche, ma la più usata è la *bitmap*: ogni pixel contiene la codifica numerica di un colore, quindi posso codificare separatamente ogni pixel e poi codificare i singoli risultati insieme tramite liste o array.

Abbiamo mostrato come i dati possano essere _"buttati via"_ in favore delle codifiche numeriche associate ad essi. 

Di conseguenza, possiamo sostituire tutte le funzioni $f: dati arrow.long dati_bot$ con delle funzioni $f': NN arrow NN_bot$. In altre parole, l'universo dei problemi per i quali cerchiamo una soluzione automatica è rappresentabile dall'insieme $NN_bot^NN.$
