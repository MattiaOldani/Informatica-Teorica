= Richiami matematici: teoria dei linguaggi formali

Dato un problema $P$, finora ci siamo chiesti _"*esiste* un programma per la sua soluzione automatica?"_ Tramite questa domanda abbiamo potuto indagare la *teoria della calcolabilità*, il cui oggetto di studio è l'esistenza (_o meno_) di un programma per un dato problema.

In questa parte del corso studieremo la *teoria della complessità*, in cui entra in gioco una seconda investigazione: _"*come* funzionano i programmi per P?"_

Per rispondere a questa domanda, vogliamo sapere quante *risorse computazionali* utilizziamo durante la sua esecuzione. Vediamo altre domande a cui la teoria della complessità cerca di rispondere:
- dato un programma per il problema $P$, quanto tempo impiega il programma nella sua soluzione? Quanto spazio di memoria occupa?
- dato un problema $P$, qual è il minimo tempo impiegato dai programmi per $P$? Quanto spazio in memoria al minimo posso occupare per programmi per $P$?
- in che senso possiamo dire che un programma è *efficiente* in termini di tempo e/o spazio?
- quali problemi possono essere efficientemente risolti per via automatica?

Prima di iniziare, diamo una breve introduzione alla *teoria dei linguaggi formali*.

== Alfabeto, stringhe e linguaggi

Un *alfabeto* è un insieme finito di simboli $Sigma = {sigma_1, dots, sigma_k}$. Un alfabeto binario è un qualsiasi alfabeto composto da due soli simboli.

Una *stringa* su $Sigma$ è una sequenza di simboli di $Sigma$ nella forma $x = x_1 space dots space x_n$, con $x_i in Sigma$.

La *lunghezza* di una stringa $x$ indica il numero di simboli che la costituiscono e si indica con $|x|$. Una stringa particolare è la *stringa nulla*, che si indica con $epsilon$ ed è tale che $|epsilon| = 0$.

Indichiamo con $Sigma^*$ l'insieme delle stringhe che si possono costruire sull'alfabeto $Sigma$, compresa la stringa nulla. L'insieme delle stringhe formate da almeno un carattere è definito da $Sigma^+ = Sigma^* slash {epsilon}$.

Un *linguaggio* $L$ su un alfabeto $Sigma$ è un sottoinsieme $L subset.eq Sigma^*$, che può essere finito o infinito.
