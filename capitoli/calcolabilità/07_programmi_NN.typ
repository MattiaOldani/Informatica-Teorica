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


= $programmi tilde NN$

La relazione interviene nella parte che afferma che $ F(cal(C)) tilde programmi tilde NN. $ 

In poche parole, la potenza computazionale, cioè l'insieme dei programmi che $cal(C)$ riesce a calcolare, è isomorfa all'insieme di tutti i programmi, a loro volta isomorfi a $NN$.

Per dimostrare l'ultima parte di questa catena di relazione dobbiamo esibire una legge che mi permetta di ricavare un numero dato un programma e viceversa.

Per fare questo vediamo l'insieme $programmi$ come l'insieme dei programmi scritti in un certo linguaggio di programmazione. Analizzeremo due sistemi diversi:
- Sistemi di calcolo RAM;
- Sistemi di calcolo while.
In generale, ogni sistema di calcolo ha la propria macchina e il proprio linguaggio.

== Sistema di calcolo RAM

Questo sistema è molto semplice e ci permette di definire rigorosamente:
- $programmi tilde NN$;
- la *semantica dei programmi eseguibili*, ovvero calcolo $cal(C)(P,\_)$ con $cal(C) = ram$ ottenendo $ram(P, \_)$;
- la *potenza computazionale*, ovvero calcolo $F(cal(C))$ con $cal(C) = ram$ ottenendo $F(ram)$.

Il linguaggio utilizzato è un assembly molto semplificato, immediato e semplice.

Dopo aver definito $F(ram)$ potremmo chiederci se questa definizione sia troppo stringente e riduttiva per definire tutti i sistemi di calcolo. In futuro introdurremo delle macchine più sofisticate, dette *macchine while*, che, a differenza delle macchine RAM, sono _strutturate_. Infine, confronteremo $F(ram)$ e $F(mwhile)$. I due risultati possibili sono:
- le potenze computazionali sono _diverse_: ciò che è computazionale dipende dallo strumento, cioè dal linguaggio utilizzato;
- le potenze computazionali sono _uguali_: la computabilità è intrinseca dei problemi, non dello strumento.
Il secondo è il caso più promettente e, in quel caso, cercheremo di trovare una caratterizzazione teorica, ovvero di _"recintare"_ tutti i problemi calcolabili.

=== Struttura

Una macchina RAM è una macchina formata da un processore e da una memoria _potenzialmente infinita_ divisa in *celle/registri*, contenenti dei numeri naturali (i nostri dati aritmetizzati).

Indichiamo i registri con $R_k$, con $k gt.eq 0$. Tra questi ci sono due registri particolari:
- $R_0$ contiene l'_output_;
- $R_1$ contiene l'_input_.

Un altro registro molto importante, che non rientra nei registri $R_k$, è il registro $L$, detto anche *program counter* (_PC_). Questo registro è essenziale in questa architettura, in quanto indica l'indirizzo della prossima istruzione da eseguire.

Dato un programma $P$, indichiamo con $|P|$ il numero di istruzioni che il programma contiene.

Le istruzioni nel linguaggio RAM sono:
- *incremento*: $inc(R_k)$;
- *decremento*: $subsus(R_k)$;
- *salto condizionato*: $ifgoto(R_k, m)$, con $m in {1, dots, |P|}$.

L'istruzione di decremento é tale che $ x overset(-,.) y = cases(x - y quad & "se" x gt.eq y, 0 & "altrimenti") quad . $

=== Esecuzione di un programma RAM

L'esecuzione di un programma su una macchina RAM segue i seguenti passi:
+ *Inizializzazione*:
  + viene caricato il programma $P equiv istr(1), dots, istr(n)$ in memoria;
  + il PC viene posto a $1$ per indicare di eseguire la prima istruzione del programma;
  + nel registro $R_1$ viene caricato l'input;
  + ogni altro registro è azzerato.
+ *Esecuzione*: si eseguono tutte le istruzioni _una dopo l'altra_, ovvero ad ogni iterazione passo da $L$ a $L+1$, a meno di istruzioni di salto. Essendo il linguaggio RAM _non strutturato_ il PC è necessario per indicare ogni volta l'istruzione da eseguire al passo successivo. Un linguaggio strutturato, invece, sa sempre quale istruzione eseguire dopo quella corrente, infatti non è dotato di PC;
+ *Terminazione*: per convenzione si mette $L = 0$ per indicare che l'esecuzione del programma è finita oppure è andata in loop. Questo segnale, nel caso il programma termini, è detto *segnale di halt* e arresta la macchina;
+ *Output*: il contenuto di $R_0$, se vado in halt, contiene il risultato dell'esecuzione del programma $P$. Indichiamo con $phi_P (n)$ il contenuto del registro $R_0$ (in caso di halt) oppure $bot$ (in caso di loop). $ phi_P (n) = cases(op("contenuto")(R_0) quad & "se halt", bot & "se loop") quad . $

Con $phi_P: NN arrow.long NN_bot$ indichiamo la *semantica* del programma $P$.

Come indicavamo con $cal(C)(P, \_)$ la semantica del programma $P$ nel sistema di calcolo $cal(C)$, indichiamo con $ram(P, \_) = phi_P$ la semantica del programma $P$ nel sistema di calcolo $ram$.

=== Esecuzione definita formalmente

Vogliamo dare una definizione formale della semantica di un programma RAM. Quello che faremo sarà dare una *semantica operazionale* alle istruzioni RAM, ovvero specificare il significato di ogni istruzione esplicitando l'*effetto* che quell'istruzione ha sui registri della macchina.

Per descrivere l'effetto di un'istruzione ci serviamo di una _foto_. L'idea che ci sta dietro è:
+ faccio una foto della macchina _prima_ dell'esecuzione dell'istruzione;
+ eseguo l'istruzione;
+ faccio una foto della macchina _dopo_ l'esecuzione dell'istruzione.

La foto della macchina si chiama *stato* e deve descrivere completamente la situazione della macchina in un certo istante. La coppia $("StatoPrima", "StatoDopo")$ rappresenta la semantica operazionale di una data istruzione del linguaggio RAM.

L'unica informazione da salvare dentro una foto è la situazione globale dei registri $R_k$ e il registro $L$. Il programma non serve, visto che rimane sempre uguale.

La *computazione* del programma $P$ è una sequenza di stati $S_i$, ognuno generato dall'esecuzione di un'istruzione del programma. Diciamo che $P$ induce una sequenza di stati $S_i$. Se quest'ultima è formata da un numero infinito di stati, allora il programma è andato in loop. In caso contrario, nel registro $R_0$ si trova il risultato $y$ della computazione di $P$. In poche parole: $ phi_P: NN arrow.long NN_bot "tale che" phi_P (n) = cases(y & "se" exists S_("finale"), bot quad & "altrimenti") quad . $

Definiamo ora come passiamo da uno stato all'altro. Per far ciò, definiamo:
- *stato*: istantanea di tutte le componenti della macchina, è una funzione $ S: {L,R_i} arrow.long NN $ tale che $S(R_k)$ restituisce il contenuto del registro $R_k$ quando la macchina si trova nello stato $S$. \ Gli stati possibili di una macchina appartengono all'insieme $ stati = {f : {L,R_i} arrow.long NN} = NN^({L,R_i}). $ Questa rappresentazione è molto comoda perché ho potenzialmente un numero di registri infinito. Se così non fosse avrei delle tuple per indicare tutti i possibili registri al posto dell'insieme ${L, R_i}$;
- *stato finale*: uno stato finale è un qualsiasi stato $S$ tale che $S(L) = 0$;
- *dati*: abbiamo già dimostrato come $dati tilde NN$;
- *inizializzazione*: serve una funzione che, preso l'input, ci dia lo stato iniziale della macchina. La funzione è $ inizializzazione: NN arrow.long stati "tale che" inizializzazione(n) = iniziale. $ Lo stato $iniziale$ è tale che $ iniziale(R) = cases(1 quad & "se" R = L, n & "se" R = R_1, 0 & "altrimenti") quad ; $
- *programmi*: definisco $programmi$ come l'insieme dei programmi RAM.

Ci manca da definire la _parte dinamica_ del programma, ovvero l'*esecuzione*. Definiamo la *funzione di stato prossimo* $ delta: stati times programmi arrow.long stati_bot $ tale che $ delta(S, P) = S', $ dove $S$ rappresenta lo stato attuale e $S'$ rappresenta lo stato prossimo dopo l'esecuzione di un'istruzione di $P$.

La funzione $delta(S,P) = S'$ è tale che:
- se $S(L) = 0$ ho halt, ovvero deve terminare la computazione. Poniamo lo stato come indefinito, quindi $S' = bot$;
- se $S(L) > |P|$ vuol dire che $P$ non contiene istruzioni che bloccano esplicitamente l'esecuzione del programma. Lo stato $S'$ è tale che: $ S'(R) = cases(0 & "se" R = L, S(R_i) quad & "se" R = R_i space forall i) quad ; $
- se $1 lt.eq S(L) lt.eq |P|$ considero l'istruzione $S(L)$-esima:
  - se ho incremento/decremento sul registro $R_k$ definisco $S'$ tale che $ cases(S'(L) = S(L) + 1, S'(R_k) = S(R_k) plus.minus 1, S'(R_i) = S(R_i) "per" i eq.not k) quad ; $
  - se ho il GOTO sul registro $R_k$ che salta all'indirizzo $m$ definisco $S'$ tale che $ S'(L) &= cases(m & "se" S(R_k) = 0, S(L) + 1 quad & "altrimenti") quad , \ S'(R_i) &= S(R_i) quad forall i. $

L'esecuzione di un programma $P in programmi$ su input $n in NN$ genera una sequenza di stati $ S_0, S_1, dots, S_i, S_(i+1), dots $ tali che $ S_0 = inizializzazione(n) \ forall i quad S_(i+1) = delta(S_i, P). $

La sequenza è infinita quando $P$ va in loop, mentre se termina raggiunge uno stato $S_m$ tale che $S_m (L) = 0$, ovvero ha ricevuto il segnale di halt.

La semantica di $P$ è $ phi_P (n) = cases(y quad & "se" P "termina in" S_m", con" S_m (L) = 0 " e " S_m (R_0) = y, bot & "se" P "va in loop") quad . $

La potenza computazionale del sistema RAM è: $ F(ram) = {f in NN_bot^NN bar.v exists P in programmi bar.v phi_P = f} = {phi_P bar.v P in programmi} subset.neq NN_bot^NN. $ 

L'insieme è formato da tutte le funzioni $f: NN arrow.long NN_bot$ che hanno un programma che le calcola in un sistema RAM.

== Aritmetizzazione di un programma

Per verificare che vale $programmi tilde NN$ dobbiamo trovare un modo per codificare i programmi in numeri in modo biunivoco. Notiamo che, data la lista di istruzioni semplici $P equiv istr(1), dots, istr(m)$, se questa fosse codificata come una lista di interi potremmo sfruttare la funzione coppia di Cantor per ottenere un numero associato al programma $P$.

/* Su Godel mettere l'accento, anche nelle lezioni prima */

Quello che dobbiamo fare è trovare una funzione che trasforma le istruzioni in numeri, così da avere poi accesso alla funzione coppia per fare la codifica effettiva. In generale, il processo che associa biunivocamente un numero ad una struttura viene chiamato *aritmetizzazione* o *godelizzazione*.

Troviamo una funzione $ar$ che associ ad ogni istruzione $I_k$ la sua codifica numerica $c_k$. Se la funzione trovata è anche biunivoca siamo sicuri di trovare la sua inversa, ovvero quella funzione che ci permette di ricavare l'istruzione $I_k$ data la sua codifica $c_k$.

Riassumendo quanto detto finora, abbiamo deciso di trasformare ogni lista di istruzioni in una lista di numeri e, successivamente, applicare la funzione coppia di Cantor, ovvero $ [istr(1), dots, istr(n)] arrow.long.squiggly^(ar) [c_1, dots, c_n] arrow.long.squiggly^(cantor()) n. $ Vorremmo anche ottenere la lista di istruzioni originale data la sua codifica, ovvero $ n arrow.long.squiggly^(cantor()) [c_1, dots, c_n] arrow.long.squiggly^(ar^(-1)) [istr(1), dots, istr(n)]. $

La nostra funzione _"complessiva"_ è biunivoca se dimostriamo la biunivocità della funzione $ar$, avendo già dimostrato questa proprietà per $cantor()$. 

Dobbiamo quindi trovare una funzione biunivoca $ar : istruzioni arrow.long NN$ con la sua funzione inversa $ar^(-1) : NN arrow.long istruzioni$ tali che $ ar(I) = n arrow.long.double.l.r ar^(-1)(n) = I. $

=== Applicazione ai programmi RAM

Dovendo codificare tre istruzioni nel linguaggio RAM, definiamo la funzione $ar$ tale che: $ ar(I) = cases(3k & "se" I equiv inc(R_k), 3k + 1 & "se" I equiv subsus(R_k), 3 cantor(k,m) - 1 quad & "se" I equiv ifgoto(R_k, m)) quad . $

Come è fatta l'inversa $ar^(-1)$? In base al modulo tra $n$ e $3$ ottengo una certa istruzione: $ ar^(-1)(n) = cases(inc(R_(n/3)) & "se" n mod 3 = 0, subsus(R_(frac(n-1,3))) & "se" n mod 3 = 1, "IF" R_(cantorsin(frac(n+1,3))) = 0 "THEN GOTO" cantordes(frac(n+1,3)) quad & "se" n mod 3 = 2) quad . $

La codifica del programma $P$ è quindi $ cod(P) = cantor(ar(istr(1)), dots, ar(istr(n))). $ Per tornare indietro devo prima invertire la funzione coppia di Cantor e poi invertire la funzione $ar$.

La lunghezza del programma $P$, indicata con $|P|$, si calcola come $listlength(cod(P))$.

Abbiamo quindi dimostrato che $programmi tilde NN$.

=== Osservazioni

Vediamo una serie di osservazioni importanti:
- avendo $n = cod(P)$ si può scrivere $ phi_P (t) = phi_n (t), $ ovvero la semantica di $P$ è uguale alla semantica della sua codifica;
- i numeri diventano un _linguaggio di programmazione_;
- posso scrivere l'insieme $ F(ram) = {phi_P : P in programmi} $ come $ F(ram) = {phi_i}_(i in NN). $ L'insieme, grazie alla dimostrazione di $programmi tilde NN$, è numerabile;
- ho dimostrato rigorosamente che $ F(ram) tilde NN tilde.not NN_bot^NN, $ quindi anche nel sistema di calcolo RAM esistono funzioni non calcolabili;
- la RAM è troppo elementare affinche $F(ram)$ rappresenti formalmente la "classe dei problemi risolubili automaticamente", quindi considerando un sistema di calcolo $cal(C)$ più sofisticato, ma comunque trattabile rigorosamente come il sistema RAM, potremmo dare un'idea formale di "ciò che è calcolabile automaticamente";
- se riesco a dimostrare che $F(ram) = F(cal(C))$ allora cambiare la tecnologia non cambia ciò che è calcolabile, ovvero la calcolabilità è intrinseca ai problemi, quindi possiamo _"catturarla"_ matematicamente.

== Sistema di calcolo WHILE

Introduciamo bla bla bla.

=== Struttura

La macchina WHILE, come quella RAM, è molto semplice, essendo formata da una serie di *registri*, detti *variabili*. Al contrario delle macchine RAM, questi ultimi non sono _potenzialmente infiniti_, ma sono esattamente $21$. Il registro $R_0$ è il *registro di output*, mentre $R_1$ è il *registro di input*. Inoltre, non esiste il registro del program counter in quanto il linguaggio è _strutturato_ e ogni istruzione di questo linguaggio va eseguita in ordine.

Il linguaggio WHILE prevede una *definizione induttiva*: vengono definiti alcuni comandi base e i comandi più complessi sono una concatenazione dei comandi base.

Il comando di base è l'*assegnamento*. In questo linguaggio ne esistono di tre tipi: $ x_k &:= 0, \ x_k &:= x_j + 1, \ x_k &:= x_j overset(-,.) 1. $ Vediamo come queste istruzioni siamo molto più complete rispetto alle istruzioni RAM $ inc(R_k) \ subsus(R_k) $ in quanto con una sola istruzione possiamo azzerare il valore di una variabile o assegnare ad una variabile il valore di un'altra aumentata/diminuita di $1$.

I comandi "induttivi" sono invece il comando while e il comando composto.

Il *comando while* è un comando nella forma $ comandowhile, $ dove $C$ è detto *corpo* e può essere un assegnamento, un comando while o un comando composto.

Il *comando composto* è un comando nella forma $ composto, $ dove i vari $C_i$ sono, come prima, assegnamenti, comandi while o comandi composti.

Un *programma WHILE* è un comando composto, e l'insieme di tutti i programmi WHILE è l'insieme $ wprogrammi = {programmi "scritti in linguaggio" mwhile}. $

Chiamiamo $ Psi_W : NN arrow NN_bot $ la *semantica* del programma $W in wprogrammi$.

Per dimostrare una proprietà $P$ di un programma $W in wprogrammi$ procederemo induttivamente:
1. dimostro $P$ vera sugli assegnamenti;
2. suppongo $P$ vera sul comando $C$ e la dimostro vera per $comandowhile$;
3. suppongo $P$ vera sui comandi $C_1, dots, C_n$ e la dimostro vera per $composto$.

=== Esecuzione di un programma WHILE

L'esecuzione di un programma while $W$ è composta dalle seguenti fasi:
+ *inizializzazione*: ogni registro $x_i$ viene posto a $0$ tranne $x_1$, che contiene l'input $n$;
+ *esecuzione*: essendo $mwhile$ un linguaggio con strutture di controllo, non serve un Program Counter, perché le istruzioni di $W$ vengono eseguite una dopo l'altra;
+ *terminazione*: l'esecuzione di $W$ può:
  - _arrestarsi_, se sono arrivato al termine delle istruzioni;
  - _non arrestarsi_, se si è entrati in un loop;
+ *output*: se il programma va in $mono("halt")$, l'output è contenuto nel registro $x_0$. Possiamo scrivere $ Psi_W (n) = cases(op("contenuto")(x_0) quad & "se halt", bot & "se loop") quad . $

La funzione $Psi_W : NN arrow.long NN_bot$ indica la semantica del programma $W$.

=== Esecuzione definita formalmente

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

== Confronto tra macchina RAM e macchina WHILE

Viene naturale andare a confrontare i due sistemi di calcolo descritti, cercando di capire quale è "più potente" dell'altro, sempre che ce ne sia uno.

Ci sono quattro possibili situazioni:
- $F(ram) subset.neq F(mwhile)$, che sarebbe anche comprensibile vista l'estrema semplicità del sistema $ram$;
- $F(ram) sect F(mwhile)$ vuota (_insiemi disgiunti_) o abbia elementi (_insiemi sghembi_). Questo scenario sarebbe preoccupante, perché il concetto di calcolabile dipenderebbe dalla macchina che si sta utilizzando;
- $F(mwhile) subset.eq F(ram)$, che sarebbe sorprendente dato che il sistema $mwhile$ sembra più sofisticato del sistema $ram$, ma la relazione decreterebbe che il sistema $mwhile$ non è più potente del sistema $ram$; 
- $F(mwhile) = F(ram)$, sarebbe il risultato migliore, perché il concetto di _calcolabile_ non dipenderebbe dalla tecnologia utilizzata, ma sarebbe intrinseco nei problemi.

Poniamo di avere $C_1$ e $C_2$ sistemi di calcolo con programmi in $c1programmi$ e $c2programmi$ e potenze computazionali $ F(C_1) = {f: NN arrow.long NN_bot bar.v exists P_1 in c1programmi bar.v f = Psi_P_1} = {Psi_P_1 : P_1 in c1programmi}, $ $ F(C_2) = {f: NN arrow.long NN_bot bar.v exists P_2 in c2programmi bar.v f = Psi_P_2} = {Psi_P_2 : P_2 in c2programmi}. $

Come mostro che $F(C_1) subset.eq F(C_2)$, ovvero che il primo sistema di calcolo non è più potente del secondo? Devo dimostrare che ogni elemento nel primo insieme deve stare anche nel secondo $ forall f in F(C_1) arrow.long.double f in F(C_2). $ Se _espandiamo_ la definizione di $f in F(C)$ allora la relazione diventa: $ exists P_1 in c1programmi bar.v f = Psi_P_1 arrow.long.double exists P_2 in c2programmi bar.v f = Psi_P_2 . $

In poche parole, per ogni programma calcolabile nel primo sistema di calcolo ne esiste uno con la stessa semantica nel secondo sistema. Quello che vogliamo trovare è un *compilatore*, ovvero una funzione che trasformi un programma del primo sistema in un programma del secondo sistema. Useremo il termine *traduttore* al posto di _compilatore_.

=== Traduzioni

Dati $C_1$ e $C_2$ due sistemi di calcolo, definiamo *traduzione* da $C_1$ a $C_2$ una funzione $ T : c1programmi arrow.long c2programmi $ con le seguenti proprietà:
- *programmabile* $arrow$ esiste un modo per programmarla;
- *completa* $arrow$ sappia tradurre *ogni* programma in $c1programmi$ in un programma in $c2programmi$; 
- *corretta* $arrow$ mantiene la semantica del programma di partenza $ forall P in c1programmi quarter : quarter Psi_P = phi_T(P), $ dove $Psi$ rappresenta la semantica dei programmi in $c1programmi$ e $phi$ rappresenta la semantica dei programmi in $c2programmi$.

#theorem(numbering: none)[
  Se esiste $T : c1programmi arrow.long c2programmi$ allora $F(C_1) subset.eq F(C_2)$.
]

#proof[
  \ Se $f in F(C_1)$ allora esiste un programma $P_1 in c1programmi$ tale che $Psi_P_1 = f$.
  
  A questo programma $P_1$ applico $T$, ottenendo $T(P_1) = P_2 in c2programmi$ (per _completezza_) tale che $phi_P_2 = Psi_P_1 = f$ (per _correttezza_).
  
  Ho trovato un programma $P_2 in c2programmi$ la cui semantica è $f$, allora $F(C_1) subset.eq F(C_2)$.
]

Mostreremo che $F(mwhile) subset.eq F(ram)$, ovvero il sistema $mwhile$ non è più potente del sistema $ram$. Quello che faremo sarà costruire un compilatore $ op("Comp") : wprogrammi arrow.long programmi. $

Vogliamo dimostrare che $ F(mwhile) subset.eq F(ram), $ ovvero che ogni funzione programmabile in $mwhile$ lo è anche in $ram$.

Dobbiamo trovare un compilatore $ compilatore: wprogrammi arrow.long programmi $ che rispetti le caratteristiche di programmabilità, completezza e correttezza viste per i traduttori.

=== Compilatore da WHILE a RAM

Per comodità andiamo ad usare un linguaggio $ram$ *etichettato*: esso aggiunge la possibilità di etichettare un'istruzione che indica un punto di salto o di arrivo. In altre parole, le etichette rimpiazzano gli indirizzi di salto, che erano indicati con un numero di istruzione.

Questa aggiunta non aumenta la potenza espressiva del linguaggio, essendo pura sintassi: il $ram$ etichettato si traduce facilmente nel $ram$ _puro_.

Essendo $wprogrammi$ un insieme definito induttivamente, possiamo definire anche il compilatore induttivamente:
- *passo base*: mostro come compilare gli assegnamenti;
- *passo induttivo*:
  + per ipotesi induttiva, assumo di sapere $compilatore(C_1), dots, compilatore(C_m)$ e mostro come compilare il comando composto $composto$;
  + per ipotesi induttiva, assumo di sapere $compilatore(C)$ e mostro come compilare il comando while $comandowhile$.

Nelle traduzioni andremo a mappare la variabile $mwhile x_k$ nel registro $ram R_k$. Questo non mi crea problemi o conflitti, perché sto mappando un numero finito di registri ($21$) in un insieme infinito.

Il primo assegnamento che mappiamo è $x_k := 0$.

$ compilatore(x_k := 0) = "LOOP" : & ifgoto(R_k, "EXIT") \ & subsus(R_k) \ & ifgoto(R_21, "LOOP") \ "EXIT" : & subsus(R_K) quad . $

Questo programma $ram$ azzera il valore di $R_k$ usando il registro $R_21$ per saltare al check della condizione iniziale. Viene utilizzato il registro $R_21$ perché, non essendo mappato su nessuna variabile $mwhile$, sarà sempre nullo dopo la fase di inizializzazione.

Gli altri due assegnamenti da mappare sono $x_k := x_j + 1$ e $x_k := x_j overset(-,.) 1$.

Se $k = j$,la traduzione è immediata e banale e l'istruzione $ram$ è $ compilatore(x_k := x_k plus.minus 1) = R_k arrow.long.l R_k plus.minus 1. $

Se invece $k eq.not j$ la prima idea che viene in mente è quella di "migrare" $x_j$ in $x_k$ e poi fare $plus.minus 1$, ma non funziona per due ragioni:
+ se $R_k eq.not 0$, la migrazione (quindi sommare $R_j$ a $R_k$) non mi genera $R_j$ dentro $R_k$. Possiamo risolvere azzerando il registro $R_k$ prima della migrazione;
+ $R_j$ dopo il trasferimento è ridotto a 0, ma questo non è il senso di quella istruzione: infatti, io vorrei solo _"fotocopiarlo"_ dentro $R_k$. Questo può essere risolto salvando $R_j$ in un altro registro, azzerare $R_k$, spostare $R_j$ e ripristinare il valore originale di $R_j$.

Ricapitolando:
+ #text(red)[salviamo $x_j$ in $R_22$, registro _sicuro_ perché mai coinvolto in altre istruzioni;]
+ #text(orange)[azzeriamo $R_k$;]
+ #text(green)[rigeneriamo $R_j$ e settiamo $R_k$ da $R_22$;]
+ #text(blue)[$plus.minus 1$ in $R_k$.]

$ compilatore(x_k := x_j plus.minus 1) = colorcode(#red, "LOOP" : & ifgoto(R_j, "EXIT1") \ & subsus(R_j) \ & inc(R_22) \ & ifgoto(R_21, "LOOP")) \ colorcode(#orange, "EXIT1" : & ifgoto(R_k, "EXIT2") \ & subsus(R_k) \ & ifgoto(R_21, "EXIT1")) \ colorcode(#green, "EXIT2" : & ifgoto(R_22, "EXIT3") \ & inc(R_k) \ & inc(R_j) \ & subsus(R_22) \ & ifgoto(R_21, "EXIT2")) \ colorcode(#blue, "EXIT3" : & R_k arrow.long.l R_k plus.minus 1) quad . $

Per ipotesi induttiva, sappiamo come compilare $C_1, dots, C_m$. Possiamo calcolare la compilazione del comando composto come $ compilatore(composto) = & compilatore(C_1) \  & dots \ & compilatore(C_m) quad . $

Per ipotesi induttiva, sappiamo come compilare $C$. Possiamo calcolare la compilazione del comando while come $ compilatore(comandowhile) = "LOOP" : & ifgoto(R_k, "EXIT") \ & compilatore(C) \ & ifgoto(R_21, "LOOP") \ "EXIT" : & subsus(R_k) quad . $

La funzione $ compilatore : wprogrammi arrow.long programmi $ che abbiamo costruito soddisfa le tre proprietà che desideravamo, quindi $ F(mwhile) subset.eq F(ram). $

Questa inclusione appena dimostrata è propria?

In questa sezione dimostriamo come $ F(ram) subset.eq F(mwhile). $

Allo stesso modo di prima, mostreremo l'esistenza di un compilatore _"inverso"_ che trasformi sorgenti $ram$ in sorgenti $mwhile$.

=== Interprete in WHILE per RAM

Introduciamo il concetto di *interprete*. Chiamiamo $I_W$ l'interprete scritto in linguaggio $mwhile$, per programmi scritti in linguaggio $ram$.

$I_W$ prende in input un programma $P in programmi$ e un dato $x in NN$ e restituisce _"l'esecuzione"_ di $P$ sull'input $x$. Più formalmente, restituisce la semantica di $P$ su $x$, quindi $phi_P (x)$.

Notiamo come l'interprete non crei dei prodotti intermedi, ma si limita ad eseguire $P$ sull'input $x$.

Abbiamo due problemi principali: 
1. Il primo riguarda il tipo di input della macchina $mwhile$: questa non sa leggere il programma $P$ (listato di istruzioni $ram$), sa leggere solo numeri. Dobbiamo modificare $I_W$ in modo che non passi più $P$, piuttosto la sua codifica $cod(P) = n in NN$. Questo mi restituisce la semantica del programma codificato con $n$, che è $P$, quindi $phi_n (x) = phi_P (x)$.
2. Il secondo problema riguarda la quantità di dati di input della macchina $mwhile$: quest'ultima legge l'input da un singolo registro, mentre qui ne stiamo passando due. Dobbiamo modificare $I_W$ condensando l'input con la funzione coppia di Cantor, che diventa $cantor(x,n)$.

La semantica di $I_W$ diventa $ forall x,n in NN quad Psi_I_W (cantor(x,n)) = phi_n (x) = phi_P (x). $

Come prima, per comodità di scrittura useremo un altro linguaggio, il *macro-$mwhile$*. Questo include alcune macro che saranno molto comode nella scrittura di $I_W$. Visto che viene modificata solo la sintassi, la potenza del linguaggio non $mwhile$ non aumenta.

Le macro utilizzate sono:
- $x_k := x_j + x_s$;
- $x_k := cantor(x_j, x_s)$;
- $x_k := cantor(x_1, dots, x_n)$;
- proiezione $x_k := proiezione(x_j, x_s) arrow$ estrae l'elemento $x_j$-esimo dalla lista codificata in $x_s$;
- incremento $x_k := macroincr(x_j, x_s) arrow$ codifica la lista $x_s$ con l'elemento in posizione $x_j$-esima aumentato di uno;
- decremento $x_k := macrodecr(x_j, x_s) arrow$ codifica la lista $x_s$ con l'elemento in posizione $x_j$-esima diminuito di uno;
- $x_k := cantorsin(x_j)$;
- $x_k := cantordes(x_j)$;
- costrutto $"if" dots "then" dots "else"$.

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

=== Conseguenze

Il risultato appena ottenuto ci permette di definire un teorema molto importante.

#theorem(
  name: "Teorema di Böhm-Jacopini (1970)",
  numbering: none
)[
  Per ogni programma con GOTO (RAM) ne esiste uno equivalente in un linguaggio strutturato (WHILE).
]

Questo teorema è fondamentale perché lega la programmazione a basso livello con quella ad alto livello. In poche parole, il GOTO può essere eliminato e la programmazione a basso livello può essere sostituita da quella ad alto livello.

Grazie alle due inclusioni dimostrate in precedenza abbiamo dimostrato anche che $ F(mwhile) subset.eq F(ram) \ F(ram) subset.eq F(mwhile) \ arrow.double.b \ F(ram) = F(mwhile) \ arrow.double.b \ F(ram) = F(mwhile) tilde programmi tilde NN tilde.not NN^NN_bot. $

Quindi, seppur profondamente diversi, i sistemi $ram$ e $mwhile$ calcolano le stesse cose. Viene naturale chiedersi quindi quale sia la vera natura della calcolabilità.

Un altro risultato che abbiamo dimostrato _formalmente_ è che nei sistemi di programmazione RAM e WHILE esistono funzioni *non calcolabili*, che sono nella _parte destra_ della catena scritta sopra.

=== Interprete universale

Facciamo una mossa esotica: usiamo il compilatore da WHILE a RAM $compilatore : wprogrammi arrow programmi$ sul programma $I_w$. Lo possiamo fare? Certo, posso compilare $I_W$ perché è un programma WHILE.

Chiamiamo questo risultato $ cal(U) = compilatore(I_W) in programmi. $ La sua semantica è $ phi_(cal(U)) (cantor(x,n)) = Psi_(I_W) (cantor(x,n)) = phi_n (x) $ dove $n$ è la codifica del programma RAM e $x$ il dato di input.

Cosa abbiamo fatto vedere? Abbiamo appena mostrato che esiste un programma RAM in grado di simulare tutti gli altri programmi RAM.

Questo programma viene detto *interprete universale*.

Considereremo _"buono"_ un linguaggio se esiste un interprete universale per esso.

=== Concetto di calcolabilità generale

Ricordiamo che il nostro obiettivo è andare a definire la regione delle funzioni calcolabili e, di conseguenza, anche quella delle funzioni non calcolabili. Abbiamo visto che RAM e WHILE permettono di calcolare le stesse cose.

_Possiamo definire ciò che è calcolabile a prescindere dalle macchine che usiamo per calcolare?_

Come disse *Kleene*, vogliamo definire ciò che è calcolabile in termini più astratti, matematici, lontani dall'informatica. Se riusciamo a definire il concetto di calcolabile senza che siano nominate macchine calcolatrici, linguaggi e tecnologie ma utilizzando la matematica potremmo usare tutta la potenza di quest'ultima.
