= Lezione 18

== Teoria della complessità

=== Complessità vs calcolabilità

Dato un problema $P$, finora ci siamo chiesti _"*esiste* un programma per la sua soluzione automatica?"_\
Tramite questa domanda abbiamo potuto indagare la *teoria della calcolabilità*, il cui oggetto di studio è l'esistenza (o meno) di un programma per un dato problema.

In questa parte del corso, studieremo la *teoria della complessità*, in cui entra in gioco una seconda investigazione: _"*come* funzionano i programmi per P?"_\
Per rispondere a questa domanda, vogliamo sapere quante *risorse computazionali* utilizziamo durante la sua esecuzione.

Definiamo _risorse computazionali_ qualsiasi risorsa venga utilizzata durante il processo di calcolo, ad esempio:
- elettricità;
- numero di processori in un sistema parallelo;
- numero di entanglement in un sistema quantistico.

Le risorse principali che consideriamo per un sistema di calcolo mono-processore sono  *tempo* e *spazio di memoria*.

=== Domande Teoria della Complessità

Vediamo alcune domande a cui la teoria della complessità cerca di rispondere:
- dato un programma per il problema $P$, quanto tempo impiega il programma nella sua soluzione? Quanto spazio di memoria occupa?
- dato un problema $P$, qual è il minimo tempo impiegato dai programmi per $P$? Quanto spazio in memoria al minimo posso occupare per programmi per $P$?
- in che senso possiamo dire che un programma è *efficiente* in termini di tempo e/o spazio?
- quali problemi possono essere efficientemente risolti per via automatica? $arrow$ _versione quantitativa_ della tesi di Church-Turing.

=== Risorse computazionali

Il punto di partenza dello studio della teoria della complessità è la definizione rigorosa delle risorse di calcolo e di come possono essere misurate.

Il modello di calcolo che useremo nel nostro studio è la *Macchina di Turing*, ideata da Alan Turing nel 1936.\
Essa è un modello *teorico* di calcolatore che consente di definire rigorosamente:
- i passi di computazione e la computazione stessa;
- tempo e spazio di calcolo dei programmi;

Di conseguenza, ci fornisce strumenti matematici per:
- misurare tempo e spazio di calcolo;
- definire il concetto di _efficiente in tempo e/o spazio_;
- caratterizzare i problemi che hanno soluzione automatica efficiente, quindi vedere quali problemi aderiscono alla *tesi di Church-Turing ristretta*.

== Richiami di teoria dei linguaggi formali

Prima di iniziare il nostro studio, richiamiamo alcuni concetti della teoria dei linguaggi formali.

Un *alfabeto* è un insieme finito di simboli $Sigma = {sigma_1, dots, sigma_k}$. Un alfabeto binario è un qualsiasi alfabeto composto da due soli simboli.

Una *stringa* su $Sigma$ è una sequenza di simboli di $Sigma$ nella forma $x = x_1 space dots space x_n$, con $x_i in Sigma$.\
La *lunghezza* di una stringa $x$ indica il numero di simboli che la costituiscono e si indica con $|x|$.\
Una stringa particolare è la *stringa nulla*, che si indica con $epsilon$ ed è tale che $|epsilon| = 0$.

Indichiamo con $Sigma^*$ l'insieme delle stringhe che si possono costruire sull'alfabeto $Sigma$, compresa la stringa nulla. L'insieme delle stringhe formate da almeno un carattere è definito da $Sigma^+ = Sigma^* \/ {epsilon}$.

Un *linguaggio* $L$ su un alfabeto $Sigma$ è un sottoinsieme $L subset.eq Sigma^*$, che può essere finito o infinito.