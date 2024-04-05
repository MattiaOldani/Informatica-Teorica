// Setup

#import "@preview/ouset:0.1.1": overset

#import "alias.typ": *

// Appunti

= Lezione 09

== Introduzione

Volevamo dimostrare che $ F(mwhile) subset.eq F(ram), $ ovvero che ogni funzione programmabile in WHILE lo è anche in RAM.

Dobbiamo quindi trovare un compilatore $ compilatore: wprogrammi arrow.long programmi $ che rispetti le caratteristiche di:
- *programmabilità*, ovvero è possibile scrivere il suddetto compilatore;
- *completezza*, ovvero compila qualsiasi programma WHILE, quindi è _funzione totale_;
- *correttezza*, ovvero mantiene la semantica del programma WHILE compilato.

== Compilatore per il linguaggio WHILE

Per comodità andiamo ad usare un linguaggio *RAM etichettato*: esso aggiunge un'etichetta opzionale prima di ogni istruzione che indica un punto di salto. In poche parole, le etichette rimpiazzano gli indirizzi di salto, che erano indicati con un numero di istruzione.

Questa aggiunte non aumenta la potenza espressiva del linguaggio, essendo pura sintassi: infatti, il RAM etichettato si traduce facilmente nel RAM _puro_.

=== Forma del compilatore

Essendo $wprogrammi$ un insieme definito induttivamente, definiamo il compilatore $compilatore$ induttivamente:
- *passo base*: mostro come compilare gli assegnamenti;
- *passo induttivo*:
  + per ipotesi induttiva assumo dati $compilatore(C_1), dots, compilatore(C_m)$ e mostro come compilare il comando composto $composto$;
  + per ipotesi induttiva assumo dati $compilatore(C)$ e mostro come compilare il comando while $comandowhile$.

Nelle traduzioni andremo a mappare la variabile WHILE $x_k$ nel registro RAM $R_k$. Questo non mi crea problemi o conflitti perché sto mappando su un insieme infinito di registri un numero finito ($21$) di variabili.

==== Assegnamento

Il primo assegnamento che mappiamo è $x_k := 0$.

$ compilatore(x_k := 0) = "LOOP" : & ifgoto(R_k, "EXIT") \ & subsus(R_k) \ & ifgoto(R_21, "LOOP") \ "EXIT" : & subsus(R_K) quad . $

Questo programma RAM azzera il valore di $R_k$ usando il registro $R_21$ per saltare al check della condizione iniziale. Viene fatto questo perché il registro $R_21$ sarà sempre nullo, non essendo mappato su nessuna variabile WHILE e quindi sempre nullo dopo la fase di inizializzazione.

Gli altri due assegnamenti da mappare sono $x_k := x_j + 1$ e $x_k := x_j overset(-,.) 1$.

Se $k = j$ la traduzione è immediata e banale ed l'istruzione RAM $ compilatore(x_k := x_k plus.minus 1) = R_k arrow.long.l R_k plus.minus 1. $

Se invece $k eq.not j$ la prima idea che viene in mente è quella di _migrare_ $x_j$ in $x_k$ e poi fare $plus.minus 1$, ma questa idea non va bene per due ragioni:
+ se $R_k eq.not 0$ la migrazione (quindi sommare $R_j$ a $R_k$) non mi genera $R_j$ dentro $R_k$. La soluzione per questo punto sarà azzerare prima il registro $R_k$;
+ $R_j$ dopo il trasferimento è ridotto a 0, ma questo non è il senso di quella istruzione: infatti, io vorrei solo _"fotocopiarlo"_ dentro $R_k$. La soluzione per questo punto sarà salvare $R_j$ in un altro registro, azzerare $R_k$, spostare $R_j$ e ripristinare il valore originale di $R_j$.

In ordine quindi:
+ #text(red)[salviamo $x_j$ in $R_22$, registro _sicuro_ perché mai coinvolto in altre istruzioni;]
+ #text(orange)[azzeriamo $R_k$;]
+ #text(green)[rigeneriamo $R_j$ e settiamo $R_k$ da $R_22$;]
+ #text(blue)[$plus.minus 1$ in $R_k$.]

$ compilatore(x_k := x_j plus.minus 1) = colorcode(#red, "LOOP" : & ifgoto(R_j, "EXIT1") \ & subsus(R_j) \ & inc(R_22) \ & ifgoto(R_21, "LOOP")) \ colorcode(#orange, "EXIT1" : & ifgoto(R_k, "EXIT2") \ & subsus(R_k) \ & ifgoto(R_21, "EXIT1")) \ colorcode(#green, "EXIT2" : & ifgoto(R_22, "EXIT3") \ & inc(R_k) \ & inc(R_j) \ & subsus(R_22) \ & ifgoto(R_21, "EXIT2")) \ colorcode(#blue, "EXIT3" : & R_k arrow.long.l R_k plus.minus 1) quad . $

==== Comando composto

Per ipotesi induttiva sappiamo come compilare $C_1, dots, C_m$. Dato questo, possiamo calcolare la compilazione del comando composto come $ compilatore(composto) = & compilatore(C_1) \  & dots \ & compilatore(C_m) quad . $

==== Comando while

Per ipotesi induttiva sappiamo come compilare $C$. Dato questo, possiamo calcolare la compilazione del comando while come $ compilatore(comandowhile) = "LOOP" : & ifgoto(R_k, "EXIT") \ & compilatore(C) \ & ifgoto(R_21, "LOOP") \ "EXIT" : & subsus(R_k) quad . $

=== Risultati ottenuti

La funzione $ compilatore : wprogrammi arrow.long programmi $ che abbiamo costruito soddisfa le tre proprietà che abbiamo definito sopra, quindi $ F(mwhile) subset.eq F(ram). $

Questa inclusione appena dimostrata è propria?

== $F(ram) subset.eq F(mwhile)$

Mostriamo adesso che $ F(ram) subset.eq F(mwhile). $

Come prima, mostreremo l'esistenza di un compilatore _"inverso"_ che trasforma i sorgenti in linguaggio RAM in sorgenti in linguaggio WHILE.

=== Interprete

Introduciamo il concetto di *interprete*. Chiamiamo $I_W$ l'interprete, scritto in linguaggio WHILE, per i programmi scritti in linguaggio RAM.

$I_W$ prende in input un programma $P in programmi$ e l'input del programma $x in NN$ e restituisce _"l'esecuzione"_ di $P$ sull'input $x$. In poche parole, restituisce la semantica di $P$ su $x$, quindi $phi_P (x)$.

Notiamo come l'interprete non crei dei prodotti intermedi, ma si limita ad eseguire $P$ sull'input $x$.

Notiamo subito due problemi. Il primo riguarda il tipo di input della macchina WHILE: quest'ultima infatti non sa leggere il programma $P$, il listato di istruzioni RAM, sa leggere solo numeri. Modifichiamo quindi $I_W$ passando non più $P$ ma bensì la sua codifica $cod(P) = n in NN$. Questo mi restituisce la semantica del programma codificato con $n$, che è $P$, quindi $phi_n (x) = phi_P (x)$.

Il secondo problema riguarda la quantità di dati di input della macchina WHILE: quest'ultima infatti legge l'input da un singolo registro, mentre qui ne sto passando due di input. Modifichiamo quindi $I_W$ condensando l'input con la funzione coppia di Cantor, che diventa $<x,n>$.

La semantica di $I_W$ diventa $ forall x,n in NN quad Psi_I_W (<x,n>) = phi_n (x) = phi_P (x). $

==== Macro-WHILE

Come prima, per comodità di scrittura useremo un altro linguaggio, in questo caso il *macro-WHILE*. Questo linguaggio include alcune macro che saranno molto comode nella scrittura di $I_W$. Essendo pura sintassi, questo non aumenta la potenza del linguaggio WHILE, questo perché tutte le macro possono essere tradotte facilmente in WHILE puro.

Le macro utilizzate sono:
- $x_k := x_j + x_s$;
- $x_k := <x_j, x_s>$;
- $x_k := <x_1, dots, x_n>$;
- proiezione $x_k := proiezione(x_j, x_s)$ che estrae l'elemento $x_j$-esimo dalla lista codificata in $x_s$;
- incremento $x_k := macroincr(x_j, x_s)$ che codifica la lista $x_s$ con l'elemento in posizione $x_j$-esima aumentato di uno;
- decremento $x_k := macrodecr(x_j, x_s)$ che codifica la lista $x_s$ con l'elemento in posizione $x_j$-esima diminuito di uno;
- $x_k := #cantor_sin (x_j)$;
- $x_k := #cantor_des (x_j)$;
- costrutto $"if" dots "then" dots "else"$.
