// Setup

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

= Lezione 08

== Semantica di un programma while

L'esecuzione di un programma while $W$ è composta dalle seguenti fasi:
+ *inizializzazione*: ogni registro $x_i$ viene posto a $0$ tranne $x_1$, che contiene l'input $n$;
+ *esecuzione*: essendo $mwhile$ un linguaggio con strutture di controllo, non serve un Program Counter, perché le istruzioni di $W$ vengono eseguite una dopo l'altra;
+ *terminazione*: l'esecuzione di $W$ può:
  - _arrestarsi_, se sono arrivato al termine delle istruzioni;
  - _non arrestarsi_, se si è entrati in un loop;
+ *output*: se il programma va in $mono("halt")$, l'output è contenuto nel registro $x_0$. Possiamo scrivere $ Psi_W (n) = cases(op("contenuto")(x_0) quad & "se halt", bot & "se loop") quad . $

La funzione $Psi_W : NN arrow.long NN_bot$ indica la semantica del programma $W$.

Diamo ora la $underline("definizione formale")$ della semantica di un programma $mwhile$. Come per i programmi RAM, abbiamo bisogno di una serie di elementi:
+ *stato*: usiamo una tupla grande quanto il numero di variabili, quindi $wstato(x) = (c_0, dots, c_20)$ rappresenta il nostro stato, con $c_i$ contenuto della variabile $i$;
+ $bold(wstati)$: insieme di tutti gli stati possibili, che è in $NN^21$, vista la definizione degli stati;
+ *dati*: sappiamo già che $dati tilde NN$;
+ *inizializzazione*: lo stato iniziale è descritto dalla seguente funzione $ winizializzazione(n) = (0,n,0,dots,0); $
+ *semantica operazionale*: vogliamo trovare una funzione che, presi il comando da eseguire e lo stato corrente, restituisce lo stato prossimo.

Soffermiamoci sull'ultimo punto. Vogliamo trovare la funzione $ [||](): wcomandi times wstati arrow.long wstati_bot $ che, dati un comando $C$ del linguaggio $mwhile$ e lo stato corrente $wstato(x)$, calcoli $ [|C|](wstato(x)) = wstato(y), $ con $wstato(y)$ stato prossimo. Quest'ultimo dipende dal comando $C$, ma essendo $C$ induttivo, possiamo provare a dare una definizione induttiva della funzione.

Partiamo dal passo base, quindi dagli *assegnamenti*: $ [|x_k := 0|](wstato(x)) &= wstato(y) = cases(x_i quad & "se" i eq.not k, 0 & "se" i = k) quad , \ [|x_k := x_j plus.minus 1|](wstato(x)) &= wstato(y) = cases(x_i & "se" i eq.not k, x_j plus.minus 1 quad & "se" i = k) quad . $

Proseguiamo con il passo induttivo, quindi:
- *comando composto*: vogliamo calcolare $ [|composto|](wstato(x)) $ conoscendo ogni $[|C_i|]$ per ipotesi induttiva. Calcoliamo allora la funzione: $ [|C_n|](dots([|C_2|]([|C_1|](wstato(x))))dots) = ([|C_n|] composizione dots composizione [|C_1|]) (wstato(x)), $ ovvero applichiamo in ordine i comandi $C_i$ presenti nel comando composto $C$.
- *comando while*: vogliamo calcolare $ [|comandowhile|](wstato(x)) $ conoscendo ogni $[|C_i|]$ per ipotesi induttiva. Calcoliamo allora la funzione: $ [|C|](dots([|C|](wstato(x)))dots). $ Dobbiamo capire quante volte eseguiamo il loop: dato $[|C|]^e$ (comando $C$ eseguito $e$ volte) vorremmo trovare il valore di $e$. Questo è uguale al minimo numero di iterazioni che portano in uno stato in cui $x_k = 0$, ovvero il mio comando while diventa: $ comandowhile = cases([|C|]^e (underline(x)) quad & "se" e = mu_t, bot & "altrimenti") quad . $ Il valore $e = mu_t$ è quel numero tale che $[|C|]^e (wstato(x))$ ha la $k$-esima componente dello stato uguale a $0$.

Definita la semantica operazionale, manca solo da definire cos'è la *semantica del programma* $W$ su input $n$. Quest'ultima è la funzione $ Psi_W : NN arrow.long NN_bot quad bar.v quad Psi_W (n) = op("Proj")(0, [|W|](winizializzazione(n))). $ Questo è valido in quanto $W$, programma $mwhile$, è un programma composto, e abbiamo definito come deve comportarsi la funzione $[||]()$ sui comandi composti.

La *potenza computazionale* del sistema di calcolo $mwhile$ è l'insieme $ F(mwhile) = {f in NN_bot^NN bar.v exists W in wprogrammi bar.v f = Psi_W} = {Psi_W : W in wprogrammi}, $ ovvero l'insieme formato da tutte le funzioni che possono essere calcolate con un programma in $wprogrammi$.

== Confronto macchina $ram$ e macchina $mwhile$

Viene naturale andare a confrontare i due sistemi di calcolo descritti, cercando di capire quale è "più potente" dell'altro, sempre che ce ne sia uno.

Ci sono quattro possibili situazioni:
- $F(ram) subset.neq F(mwhile)$, che sarebbe anche comprensibile vista l'estrema semplicità del sistema $ram$;
- $F(ram) sect F(mwhile)$ vuota (_insiemi disgiunti_) o abbia elementi (_insiemi sghembi_). Questo scenario sarebbe preoccupante, perché il concetto di calcolabile dipenderebbe dalla macchina che si sta utilizzando;
- $F(mwhile) subset.eq F(ram)$, che sarebbe sorprendente dato che il sistema $mwhile$ sembra più sofisticato del sistema $ram$, ma la relazione decreterebbe che il sistema $mwhile$ non è più potente del sistema $ram$; 
- $F(mwhile) = F(ram)$, sarebbe il risultato migliore, perché il concetto di _calcolabile_ non dipenderebbe dalla tecnologia utilizzata, ma sarebbe intrinseco nei problemi.

Poniamo di avere $C_1$ e $C_2$ sistemi di calcolo con programmi in $c1programmi$ e $c2programmi$ e potenze computazionali $ F(C_1) = {f: NN arrow.long NN_bot bar.v exists P_1 in c1programmi bar.v f = Psi_P_1} = {Psi_P_1 : P_1 in c1programmi}, $ $ F(C_2) = {f: NN arrow.long NN_bot bar.v exists P_2 in c2programmi bar.v f = Psi_P_2} = {Psi_P_2 : P_2 in c2programmi}. $

Come mostro che $F(C_1) subset.eq F(C_2)$, ovvero che il primo sistema di calcolo non è più potente del secondo? Devo dimostrare che ogni elemento nel primo insieme deve stare anche nel secondo $ forall f in F(C_1) arrow.long.double f in F(C_2). $ Se _espandiamo_ la definizione di $f in F(C)$ allora la relazione diventa: $ exists P_1 in c1programmi bar.v f = Psi_P_1 arrow.long.double exists P_2 in c2programmi bar.v f = Psi_P_2 . $

In poche parole, per ogni programma calcolabile nel primo sistema di calcolo ne esiste uno con la stessa semantica nel secondo sistema. Quello che vogliamo trovare è un *compilatore*, ovvero una funzione che trasformi un programma del primo sistema in un programma del secondo sistema. Useremo il termine *traduttore* al posto di _compilatore_.

== Traduzioni

Dati $C_1$ e $C_2$ due sistemi di calcolo, definiamo *traduzione* da $C_1$ a $C_2$ una funzione $ T : c1programmi arrow.long c2programmi $ con le seguenti proprietà:
- *programmabile* $arrow$ esiste un modo per programmarla;
- *completa* $arrow$ sappia tradurre *ogni* programma in $c1programmi$ in un programma in $c2programmi$; 
- *corretta* $arrow$ mantiene la semantica del programma di partenza $ forall P in c1programmi quarter : quarter Psi_P = phi_T(P), $ dove $Psi$ rappresenta la semantica dei programmi in $c1programmi$ e $phi$ rappresenta la semantica dei programmi in $c2programmi$.

\

#theorem(numbering: none)[
  Se esiste $T : c1programmi arrow.long c2programmi$ allora $F(C_1) subset.eq F(C_2)$.
]<thm>

#proof[
  \ Se $f in F(C_1)$ allora esiste un programma $P_1 in c1programmi$ tale che $Psi_P_1 = f$.
  
  A questo programma $P_1$ applico $T$, ottenendo $T(P_1) = P_2 in c2programmi$ (per _completezza_) tale che $phi_P_2 = Psi_P_1 = f$ (per _correttezza_).
  
  Ho trovato un programma $P_2 in c2programmi$ la cui semantica è $f$, allora $F(C_1) subset.eq F(C_2)$.
]<proof>

Mostreremo che $F(mwhile) subset.eq F(ram)$, ovvero il sistema $mwhile$ non è più potente del sistema $ram$. Quello che faremo sarà costruire un compilatore $ op("Comp") : wprogrammi arrow.long programmi. $
