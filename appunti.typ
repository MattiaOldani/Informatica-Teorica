// Setup

#import "template.typ": project

#show: project.with(
  title: "Informatica teorica"
)

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

#pagebreak()

// Appunti

#include "lezioni/lezione_01.typ"

#pagebreak()

#include "lezioni/lezione_02.typ"

#pagebreak()

#include "lezioni/lezione_03.typ"

#pagebreak()

#include "lezioni/lezione_04.typ"

#pagebreak()

= Lezione 05

#let dati = $text("DATI")$
#let programmi = $text("PROG")$

== $dati tilde NN$

Vogliamo formare una legge che:
+ associ biunivocamente dati a numeri e viceversa;
+ consenta di operare direttamente sui numeri per operare sui corrispondenti dati, ovvero abbia delle primitive per lavorare il numero che "riflettano" il risultato sul dato senza ripassare per il dato stesso;
+ ci consenta di dire, senza perdita di generalità, che i nostri programmi lavorano sui numeri.

=== Funzione coppia di Cantor

==== Definizione

#let cantor_sin = $text("sin")$
#let cantor_des = $text("des")$

La *funzione coppia di Cantor* è la funzione $ <,>: NN times NN arrow.long NN^+. $ Questa funzione sfrutta due _"sotto-funzioni"_, _sin_ e _des_, tali che $ <x,y> &= n, \ #cantor_sin: NN^+ arrow.long NN, & quad #cantor_sin (n) = x \ #cantor_des: NN^+ arrow.long NN, & quad #cantor_des (n) = y. $

Vediamo una rappresentazione grafica della funzione di Cantor.

#v(12pt)

#figure(
  image("assets/cantor-01.svg", width: 50%)
)

#v(12pt)

$<x,y>$ rappresenta il valore all'incrocio tra la $x$-esima riga e la $y$-esima colonna.

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

==== Forma analitica della funzione coppia

Quello che vogliamo fare ora è cercare una forma analitica della funzione coppia, questo perché non è molto comodo costruire ogni volta la tabella sopra. Nella successiva immagine notiamo come valga la relazione $ <x,y> = <x+y,0> + y. $

#v(12pt)

#figure(
  image("assets/cantor-02.svg", width: 40%)
)

#v(12pt)

Questo è molto comodo perché il calcolo della funzione coppia si riduce al calcolo di $<x+y,0>$.

Chiamiamo $x+ y = z$, osserviamo con la successiva immagine un'altra proprietà.

#v(12pt)

#figure(
  image("assets/cantor-03.svg", width: 15%)
)

#v(12pt)

Ogni cella $<z,0>$ la si può calcolare come la somma di $z$ e $<z-1,0>$, ma allora $ <z,0> &= z + <z-1,0> = \ &= z + (z-1) + <z-2,0> = \ &= z + (z-1) + dots + 1 + <0,0> = \ &= z + (z-1) + dots + 1 + 1 = \ &= sum_(i=1)^z i + 1 = frac(z(z+1),2) + 1. $

Questa forma è molto più compatta ed evita il calcolo di tutti i singoli $<z,0>$.

Mettiamo insieme le due proprietà per ottenere la formula analitica della funzione coppia: $ <x,y> = <x+y,0> + y = frac((x+y)(x+y+1), 2) + y + 1. $

==== Forma analitica di #cantor_sin e #cantor_des

Vogliamo adesso dare la forma analitica di _sin_ e _des_ per poter computare l'inversa della funzione di Cantor, dato $n$.

Grazie alle osservazioni precedenti sappiamo che $ n = y + <gamma,0> space &arrow.long.double space y = n - <gamma,0>, \ gamma = x + y space & arrow.long.double space x = gamma - y. $

Se troviamo il valore di gamma abbiamo trovato anche i valori di $x$ e $y$.

Notiamo come $gamma$ sia il _"punto di attacco"_ della diagonale che contiene $n$, ma allora $ gamma = max{z in NN bar.v <z,0> lt.eq n} $ perché tra tutti i punti di attacco $<z,0>$ voglio quello che potrebbe contenere $n$ e che sia massimo, ovvero sia esattamente la diagonale che contiene $n$.

Risolviamo quindi la disequazione $ <z,0> lt.eq n & arrow.long.double frac(z(z+1),2) + 1 lt.eq n \ & arrow.long.double z^2 + z - 2n + 2 lt.eq 0 \ & arrow.long.double z_(1,2) = frac(-1 plus.minus sqrt(1 + 8n - 8), 2) \ & arrow.long.double frac(-1 - sqrt(8n - 7), 2) lt.eq z lt.eq frac(-1 + sqrt(8n - 7), 2). $

Come valore di $gamma$ scelgo $ gamma = floor(frac(-1 + sqrt(8n - 7), 2)). $

Ora che abbiamo $gamma$ possiamo definire le funzioni _sin_ e _des_ come $ #cantor_des (n) = y = n - <gamma,0> = n - frac(gamma (gamma + 1), 2) - 1, \ #cantor_sin (n) = x = gamma - y. $

==== $NN times NN tilde NN$

Con la funzione coppia di Cantor possiamo dimostrare un importante risultato.

#theorem()[
  $NN times NN tilde NN^+$.
]

#proof[
  \ La funzione di Cantor è una funzione biiettiva tra l'insieme $NN times NN$ e l'insieme $NN^+$, quindi i due insiemi sono isomorfi.
]<proof>

Estendiamo adesso il risultato all'interno insieme $NN$, ovvero $ NN times NN tilde NN^+ arrow.long.squiggly NN times NN tilde NN. $

#theorem()[
  $NN times NN tilde NN$.
]

#proof[
  \ Definiamo la funzione $ [,]: NN times NN arrow.long NN $ tale che $ [x,y] = <x,y> - 1. $
  
  Questa funzione è anch'essa biiettiva, quindi i due insiemi sono isomorfi.
]<proof>

Grazie a questi risultati si può dimostrare che $QQ tilde NN$: infatti, i numeri razionali li possiamo rappresentare come coppie $("num", "den")$. In generale, tutte le tuple sono isomorfe a $NN$, iterando in qualche modo la funzione coppia di Cantor.

=== Dimostrazione

I risultati ottenuti fino a questo punto ci permettono di dire che ogni dato è trasformabile in un numero, che può essere soggetto a trasformazioni e manipolazioni matematiche.

La dimostrazione _formale_ non verrà fatta, ma verranno fatti esempi di alcune strutture dati che possono essere trasformate in un numero tramite la funzione coppia di Cantor. Vedremo come ogni struttura dati verrà manipolata e trasformata in una coppia $(x,y)$ per poterla applicare alla funzione coppia.

==== Strutture dati

===== Liste

Le *liste* sono le strutture dati più utilizzate nei programmi. In generale non ne è nota la grandezza, di conseguenza dobbiamo trovare un modo, soprattutto durante la applicazione di _sin_ e _des_, per capire quando abbiamo esaurito gli elementi della lista.

Codifichiamo la lista $[x_1, dots, x_n]$ con $ <x_1, dots, x_n> = <x_1, <x_2, < dots < x_n, 0 > dots >>>. $

Abbiamo quindi applicato la funzione coppia di Cantor alla coppia formata da un elemento della lista e il risultato della funzione coppia stessa applicata ai successivi elementi.

Ad esempio, la codifica della lista $M = [1,2,5]$ risulta essere: $ <1,2,5> &= <1, <2, <5,0>>> \ &= <1,<2,16>> \ &= <1, 188> \ &= 18144. $

Per decodificare la lista $M$ applichiamo le funzioni _sin_ e _des_ al risultato precedente. Alla prima iterazione otterremo il primo elemento della lista e la restante parte ancora da decodificare.

Quando ci fermiamo? Durante la creazione della codifica di $M$ abbiamo inserito un _"tappo"_, ovvero la prima iterazione della funzione coppia $<x_n, 0>$. Questo ci indica che quando $#cantor_des (M)$ sarà uguale a $0$ ci dovremo fermare.

Cosa succede se abbiamo uno $0$ nella lista? Non ci sono problemi: il controllo avviene sulla funzione _des_, che restituisce la _"somma parziale"_ e non sulla funzione _sin_, che restituisce i valori della lista.

Possiamo anche anche delle implementazioni di queste funzioni. Assumiamo che:
- $0$ codifichi la lista nulla;
- esistano delle routine per $<,>$, $#cantor_sin$ e $#cantor_des$.

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

===== Array

Per gli *array* il discorso è più semplice, in quanto la dimensione è nota a priori. Di conseguenza, non necessitiamo di un carattere di fine sequenza. Dunque avremo che l'array ${x_1, dots, x_n}$ viene codificato con: $ [x_1, dots, x_n] = [x_1, dots [x_(n-1), x_n] dots ]. $

===== Matrici

Per quanto riguarda *matrici* l'approccio utilizzato codifica singolarmente le righe e successivamente codifica i risultati ottenuti come se fossero un array di dimensione uguale al numero di righe.

#set math.mat(delim: "[")

Ad esempio, la matrice $ mat(x_11, x_12, x_13; x_21, x_22, x_23; x_31, x_32, x_33) $ viene codificata in: $ mat(x_11, x_12, x_13; x_21, x_22, x_23; x_31, x_32, x_33) = [[x_11, x_12, x_13], [x_21, x_22, x_23], [x_31, x_32, x_33]]. $

===== Grafi

Consideriamo il seguente grafo.

#v(12pt)

#figure(
  image("assets/grafo.svg", width: 25%)
)

#v(12pt)

I *grafi* sono rappresentati principalmente in due modi:
- *liste di adiacenza dei vertici*: per ogni vertice si ha una lista che contiene gli identificatori dei vertici che collegati direttamente con esso. Il grafo precedente ha $ {1:[2,3,4], 2:[1,3], 3:[1,2,4], 4:[1,3]} $ come lista di adiacenza, e la sua codifica si calcola come: $ [<2,3,4>,<1,2>,<1,2,4>,<1,3>]. $ Questa soluzione esegue prima la codifica di ogni lista di adiacenza e poi la codifica dei risultati del passo precedente.
- *matrice di adiacenza*: per ogni cella $m_(i j)$ della matrice $|V| times |V|$, dove $V$ è l'insieme dei vertici, si ha:
  - $1$ se esiste un arco dal vertice $i$ al vertice $j$;
  - $0$ altrimenti;
  Essendo questa una matrice la andiamo a codificare come abbiamo già descritto.

==== Applicazioni

Una volta visto come rappresentare le principali strutture dati, è facile trovare delle vie per codificare qualsiasi tipo di dato in un numero. Vediamo alcuni esempi.

===== Testi

Dato un *testo*, possiamo ottenere la sua codifica nel seguente modo:
+ trasformiamo il testo in una lista di numeri tramite la codifica ASCII dei singoli caratteri;
+ sfruttiamo l'idea dietro la codifica delle liste per codificare quanto ottenuto.

Per esempio, $ "ciao" = [99, 105, 97, 111] = <99, <105, <97, <111, 0>>>. $

Possiamo chiederci:
- _Il codificatore proposto è un buon compressore?_ \ No, si vede facilmente che il numero ottenuto tramite la funzione coppia (o la sua concatenazione) sia generalmente molto grande, e che i bit necessari a rappresentarlo crescano esponenzialmente sulla lunghezza dell'input. Ne segue che questo è un _pessimo_ modo per comprimere messaggi.
- _Il codificatore proposto è un buon sistema crittografico?_ \ La natura stessa del processo garantisce la possibilità di trovare un modo per decifrare in modo analitico, di conseguenza chiunque potrebbe, in poco tempo, decifrare il mio messaggio. Inoltre, questo metodo è molto sensibile agli errori.

===== Suoni

Dato un *suono*, possiamo _campionare_ il suo segnale elettrico a intervalli di tempo regolari e codificare la sequenza dei valori campionati tramite liste o array.

===== Immagini

Per codificare le *immagini* esistono diverse tecniche, ma la più usata è la *bitmap*: ogni pixel contiene la codifica numerica di un colore, quindi posso codificare separatamente ogni pixel e poi codificare i singoli risultati insieme tramite liste o array.

=== Conclusioni

Abbiamo mostrato come i dati possano essere _"buttati via"_ in favore delle codifiche numeriche associate ad essi. 

Di conseguenza, possiamo sostituire tutte le funzioni $f: dati arrow.long dati_bot$ con delle funzioni $f': NN arrow NN_bot$. In altre parole, l'universo dei problemi per i quali cerchiamo una soluzione automatica è rappresentabile dall'insieme $NN_bot^NN.$

#pagebreak()

= Lezione 06

== $programmi tilde NN$

La relazione interviene nella parte che afferma che $ F(cal(C)) tilde programmi tilde NN. $ 

In poche parole, la potenza computazionale, cioè l'insieme dei programmi che $cal(C)$ riesce a calcolare, è isomorfa all'insieme di tutti i programmi, a loro volta isomorfi a $NN$.

Per dimostrare l'ultima parte di questa catena di relazione dobbiamo esibire una legge che mi permetta di ricavare un numero dato un file sorgente e viceversa.

Per fare questo vediamo l'insieme $programmi$ come l'insieme dei programmi scritti in un certo linguaggio di programmazione.

=== Sistema di calcolo RAM

==== Introduzione

Come supporto alla dimostrazione usiamo il *sistema di calcolo RAM*: esso è formato dalla *macchina RAM* e dal *linguaggio RAM*. In generale, ogni sistema di calcolo ha la propria macchina e il proprio linguaggio.

#let ram = $text("RAM")$
#let mwhile = $text("while")$

Questo sistema è molto semplice e ci permette di definire rigorosamente:
- $programmi tilde NN$;
- la semantica dei programmi eseguibili, ovvero calcolo $cal(C)(P,\_)$ con $cal(C) = ram$ ottenendo $ram(P, \_)$;
- la potenza computazionale, ovvero calcolo $F(cal(C))$ con $cal(C) = ram$ ottenendo $F(ram)$.

Il linguaggio utilizzato è un assembly molto semplificato, immediato e semplice.

Dopo aver definito $F(ram)$ potremmo chiederci se questa definizione sia troppo stringente e riduttiva per definire tutti i sistemi di calcolo. In futuro introdurremo delle macchine più sofisticate, dette *macchine while*, che, a differenza delle macchine RAM, sono _strutturate_. In ultima istanza confronteremo $F(ram)$ e $F(mwhile)$ i due risultati possibili sono:
- _le potenze computazionali sono diverse_: ciò che è computazionale dipende dallo strumento, cioè dal linguaggio utilizzato;
- _le potenze computazionali sono uguali_: la computabilità è intrinseca dei problemi, non nello strumento. Cercheremo di dare una caratterizzazione teorica, ovvero cercheremo di _"recintare"_ tutti i problemi calcolabili.

==== Struttura

Una macchina RAM è una macchina semplicissima: è formata da un _processore_ e da una _memoria potenzialmente infinita_ divisa in *celle/registri*, contenenti dei numeri naturali (i nostri dati "naturalizzati").

Indichiamo i registri con $R_k$, con $k gt.eq 0$. Tra questi ci sono due registri particolari:
- $R_0$ contiene l'_output_;
- $R_1$ contiene l'_input_.

Un altro registro molto importante, che non rientra nei registri $R_k$, è il registro $L$, detto anche *program counter* (_PC_). Questo registro è essenziale in questa architettura perché indica l'indirizzo della prossima istruzione da eseguire, e viene posto a $1$ quando inizia l'esecuzione di un programma.

Dato un programma $P$, il numero di istruzione che contiene si indica con $|P|$.

#let inc(reg) = $reg arrow.long.l reg + 1$
#let subsus(reg) = $reg arrow.long.l reg overset(-,.) 1$
#let ifgoto(reg,m) = $"IF" reg = 0 "THEN GOTO" m$

Le istruzioni nel linguaggio RAM sono:
- *incremento* $inc(R_k)$;
- *decremento sus* $subsus(R_k)$;
- *salto condizionato* $ifgoto(R_k, m)$, con $m in {1, dots, |P|}$.

L'istruzione di decremento é tale che $ x overset(-,.) y = cases(x - y quad & "se" x gt.eq y, 0 & "altrimenti") quad . $

==== Fasi dell'esecuzione su macchina RAM

#let istr(index) = $"Istr"_index$

L'esecuzione di un programma su una macchina RAM segue i seguenti passi:
+ *inizializzazione*:
  + viene caricato il programma $P equiv istr(1), dots, istr(n)$ in memoria;
  + il PC viene posto a $1$ per indicare di eseguire la prima istruzione del programma;
  + nel registro $R_1$ viene caricato l'input;
  + ogni altro registro è azzerato.
+ *esecuzione*: si eseguono tutte le istruzioni _una dopo l'altra_, ovvero ad ogni iterazione passo da $L$ a $L+1$ a meno di istruzioni di salto. Essendo il linguaggio RAM _non strutturato_ il PC è necessario per indicare ogni volta l'istruzione da eseguire al passo successivo. Un linguaggio strutturato invece sa sempre quale istruzione eseguire dopo quella corrente, e infatti non è dotato di PC;
+ *terminazione*: per convenzione si mette $L = 0$ per indicare che l'esecuzione del programma è finita oppure è andata in loop. Questo segnale, nel caso il programma termini, è detto *segnale di halt* e arresta la macchina;
+ *output*: il contenuto di $R_0$, se vado in halt, è il risultato dell'esecuzione del programma $P$. Indichiamo con $phi_P (n)$ il contenuto del registro $R_0$ (in caso di halt) oppure $bot$ (in caso di loop). $ phi_P (n) = cases(op("contenuto")(R_0) quad & "se halt", bot & "se loop") quad . $

Con $phi_P: NN arrow.long NN_bot$ indichiamo la *semantica* del programma $P$.

Indichiamo con $ram(P, \_) = phi_P$ la semantica del programma $P$ nel sistema di calcolo $ram$, come indicavamo con $cal(C)(P, \_)$ la semantica del programma $P$ nel sistema di calcolo $cal(C)$.

==== Definizione formale della semantica di un programma RAM

Vogliamo dare una definizione formale della semantica di un programma RAM. Quello che faremo sarà dare una *semantica operazionale* alle istruzioni RAM, ovvero specificare il significato di ogni istruzione specificando l'*effetto* che quell'istruzione ha sui registri della macchina.

Per descrivere l'effetto di un'istruzione ci serviamo delle _foto_:
+ faccio una foto della macchina _prima_ dell'esecuzione dell'istruzione;
+ eseguo l'istruzione;
+ faccio una foto della macchina _dopo_ l'esecuzione dell'istruzione.

La foto della macchina si chiama *stato* e deve descrivere completamente la situazione della macchina in un certo istante. La coppia $("StatoPrima", "StatoDopo")$ è la semantica operazionale di una data istruzione del linguaggio RAM.

Cosa deve comparire nella foto per descrivere completamente la macchina che sto osservando? Sicuramente la situazione globale dei registri $R_k$ e il registro $L$. Il programma invece non è utile salvarlo nella foto, visto che rimane sempre uguale.

La *computazione* del programma $P$ è una sequenza di stati $S_i$, ognuno generato dall'esecuzione di un'istruzione del programma. Si dice che $P$ induce una sequenza di stati $S_i$. Se quest'ultima è formata da un numero infinito di stati allora il programma è andato in loop, altrimenti nel registro $R_0$ ho il risultato $y$ della computazionale di $P$. In poche parole: $ phi_P: NN arrow.long NN_bot "tale che" phi_P (n) = cases(y & "se" exists S_("finale"), bot quad & "altrimenti") quad . $

#let stati = $text("STATI")$
#let iniziale = $S_("iniziale")$
#let inizializzazione = $text("in")$

Definiamo ora come passiamo da uno stato all'altro. Per far ciò ci servono alcuni _ingredienti_:
- *stato*: foto istantanea di tutte le componenti della macchina, lo definiamo come una funzione $ S: {L,R_i} arrow.long NN $ tale che $S(R_k)$ restituisce il contenuto del registro $R_k$ quando la macchina si trova nello stato $S$. Gli stati appartengono all'insieme $ stati = {f : {L,R_i} arrow.long NN} = NN^({L,R_i}), $ che descrive tutti i possibili stati della macchina. Questa rappresentazione è molto comoda perché ho potenzialmente un numero di registri infinito. Se così non fosse avrei delle tuple per indicare tutti i possibili registri al posto dell'insieme ${L, R_i}$;
- *stato finale*: uno stato finale è un qualsiasi stato $S$ tale che $S(L) = 0$;
- *dati*: già dimostrato che $dati tilde NN$;
- *inizializzazione*: serve una funzione che, preso l'input, ci dia lo stato iniziale. La funzione è $ inizializzazione: NN arrow.long stati "tale che" inizializzazione(n) = iniziale. $ Lo stato $iniziale$ è tale che $ iniziale(R) = cases(1 quad & "se" R = L, n & "se" R = R_1, 0 & "altrimenti") quad ; $
- *programmi*: definisco $programmi$ come l'insieme dei programmi RAM.

L'ultimo ingrediente che si serve è l'*esecuzione*, la _parte dinamica_ del programma. Definiamo la *funzione di stato prossimo* $ delta: stati times programmi arrow.long stati_bot $ tale che $ delta(S, P) = S', $ dove $S$ rappresenta lo stato attuale e $S'$ rappresenta lo stato prossimo, ovvero lo stato che segue $S$ dopo l'esecuzione di un'istruzione di $P$.

Lo stato $S'$ dipende dall'istruzione che viene eseguita: in base al valore di $S(L)$ posso risalire all'istruzione da eseguire e calcolare lo stato prossimo.

La funzione $delta(S,P) = S'$ è tale che:
- se $S(L) = 0$ ho halt, ovvero deve terminare la computazione. Poniamo lo stato come indefinito, quindi $S' = bot$;
- se $S(L) > |P|$ vuol dire che $P$ non contiene istruzioni che bloccano esplicitamente l'esecuzione del programma. Lo stato $S'$ è tale che: $ S'(R) = cases(0 & "se" R = L, S(R_i) quad & "se" R = R_i space forall i) quad ; $
- se $1 lt.eq S(L) lt.eq |P|$ considero l'istruzione $S(L)$-esima:
  - se ho incremento/decremento sul registro $R_k$ definisco $S'$ tale che $ cases(S'(L) = S(L) + 1, S'(R_k) = S(R_k) plus.minus 1, S'(R_i) = S(R_i) "per" i eq.not k) quad ; $
  - se ho il GOTO sul registro $R_k$ che salta all'indirizzo $m$ definisco $S'$ tale che $ S'(L) &= cases(m & "se" S(R_k) = 0, S(L) + 1 quad & "altrimenti") quad , \ S'(R_i) &= S(R_i) quad forall i. $

L'esecuzione di un programma $P in programmi$ su input $n in NN$ genera una sequenza di stati $ S_0, S_1, dots, S_i, S_(i+1), dots $ tali che $ S_0 = inizializzazione(n) \ forall i quad delta(S_i, P) = S_(i+1). $

La sequenza è infinita quando $P$ va in loop, mentre se termina raggiunge uno stato $S_m$ tale che $S_m (L) = 0$, ovvero ha ricevuto il segnale di halt.

La semantica di $P$ è $ phi_P (n) = cases(y quad & "se" P "termina in" S_m", con" S_m (L) = 0 " e " S_m (R_0) = y, bot & "se" P "va in loop") quad . $

La potenza computazionale del sistema RAM è: $ F(ram) = {f in NN_bot^NN bar.v exists P in programmi bar.v phi_P = f} = {phi_P bar.v P in programmi} subset.neq NN_bot^NN. $ 

L'insieme è formato da tutte le funzioni $f: NN arrow.long NN_bot$ che hanno un programma che le calcola in un sistema RAM.


#pagebreak()

= Lezione 07

/* GIGI */
