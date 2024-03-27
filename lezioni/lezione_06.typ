// Setup

#import "@preview/ouset:0.1.1": overset

// Appunti

= Lezione 06

#let dati = $text("DATI")$
#let programmi = $text("PROG")$

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
