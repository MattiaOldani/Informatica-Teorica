// Setup

#import "@preview/ouset:0.1.1": overset

#import "alias.typ": *

// Appunti

= Lezione 09

== Introduzione

Vogliamo dimostrare che $ F(mwhile) subset.eq F(ram), $ ovvero che ogni funzione programmabile in $mwhile$ lo è anche in $ram$.

Dobbiamo trovare un compilatore $ compilatore: wprogrammi arrow.long programmi $ che rispetti le caratteristiche di programmabilità, completezza e correttezza viste per i traduttori.

== Compilatore per il linguaggio $mwhile$

Per comodità andiamo ad usare un linguaggio $ram$ *etichettato*: esso aggiunge la possibilità di etichettare un'istruzione che indica un punto di salto o di arrivo. In altre parole, le etichette rimpiazzano gli indirizzi di salto, che erano indicati con un numero di istruzione.

Questa aggiunta non aumenta la potenza espressiva del linguaggio, essendo pura sintassi: il $ram$ etichettato si traduce facilmente nel $ram$ _puro_.

=== Forma del compilatore

Essendo $wprogrammi$ un insieme definito induttivamente, possiamo definire anche il compilatore induttivamente:
- *passo base*: mostro come compilare gli assegnamenti;
- *passo induttivo*:
  + per ipotesi induttiva, assumo di sapere $compilatore(C_1), dots, compilatore(C_m)$ e mostro come compilare il comando composto $composto$;
  + per ipotesi induttiva, assumo di sapere $compilatore(C)$ e mostro come compilare il comando while $comandowhile$.

Nelle traduzioni andremo a mappare la variabile $mwhile x_k$ nel registro $ram R_k$. Questo non mi crea problemi o conflitti, perché sto mappando un numero finito di registri ($21$) in un insieme infinito.

==== Assegnamento

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

==== Comando composto

Per ipotesi induttiva, sappiamo come compilare $C_1, dots, C_m$. Possiamo calcolare la compilazione del comando composto come $ compilatore(composto) = & compilatore(C_1) \  & dots \ & compilatore(C_m) quad . $

==== Comando while

Per ipotesi induttiva, sappiamo come compilare $C$. Possiamo calcolare la compilazione del comando while come $ compilatore(comandowhile) = "LOOP" : & ifgoto(R_k, "EXIT") \ & compilatore(C) \ & ifgoto(R_21, "LOOP") \ "EXIT" : & subsus(R_k) quad . $

=== Risultati ottenuti

La funzione $ compilatore : wprogrammi arrow.long programmi $ che abbiamo costruito soddisfa le tre proprietà che desideravamo, quindi $ F(mwhile) subset.eq F(ram). $

Questa inclusione appena dimostrata è propria?

== $F(ram) subset.eq F(mwhile)$

In questa sezione dimostriamo come $ F(ram) subset.eq F(mwhile). $

Allo stesso modo di prima, mostreremo l'esistenza di un compilatore _"inverso"_ che trasformi sorgenti $ram$ in sorgenti $mwhile$.

=== Interprete

Introduciamo il concetto di *interprete*. \ Chiamiamo $I_W$ l'interprete scritto in linguaggio $mwhile$, per programmi scritti in linguaggio $ram$.

$I_W$ prende in input un programma $P in programmi$ e un dato $x in NN$ e restituisce _"l'esecuzione"_ di $P$ sull'input $x$. Più formalmente, restituisce la semantica di $P$ su $x$, quindi $phi_P (x)$.

Notiamo come l'interprete non crei dei prodotti intermedi, ma si limita ad eseguire $P$ sull'input $x$.

Abbiamo due problemi principali: 
1. Il primo riguarda il tipo di input della macchina $mwhile$: questa non sa leggere il programma $P$ (listato di istruzioni $ram$), sa leggere solo numeri. Dobbiamo modificare $I_W$ in modo che non passi più $P$, piuttosto la sua codifica $cod(P) = n in NN$. Questo mi restituisce la semantica del programma codificato con $n$, che è $P$, quindi $phi_n (x) = phi_P (x)$.
2. Il secondo problema riguarda la quantità di dati di input della macchina $mwhile$: quest'ultima legge l'input da un singolo registro, mentre qui ne stiamo passando due. Dobbiamo modificare $I_W$ condensando l'input con la funzione coppia di Cantor, che diventa $<x,n>$.

La semantica di $I_W$ diventa $ forall x,n in NN quad Psi_I_W (<x,n>) = phi_n (x) = phi_P (x). $

==== Macro-$mwhile$

Come prima, per comodità di scrittura useremo un altro linguaggio, il *macro-$mwhile$*. Questo include alcune macro che saranno molto comode nella scrittura di $I_W$. Visto che viene modificata solo la sintassi, la potenza del linguaggio non $mwhile$ non aumenta.

Le macro utilizzate sono:
- $x_k := x_j + x_s$;
- $x_k := <x_j, x_s>$;
- $x_k := <x_1, dots, x_n>$;
- proiezione $x_k := proiezione(x_j, x_s) arrow$ estrae l'elemento $x_j$-esimo dalla lista codificata in $x_s$;
- incremento $x_k := macroincr(x_j, x_s) arrow$ codifica la lista $x_s$ con l'elemento in posizione $x_j$-esima aumentato di uno;
- decremento $x_k := macrodecr(x_j, x_s) arrow$ codifica la lista $x_s$ con l'elemento in posizione $x_j$-esima diminuito di uno;
- $x_k := #cantor_sin (x_j)$;
- $x_k := #cantor_des (x_j)$;
- costrutto $"if" dots "then" dots "else"$.