#import "../alias.typ": *


= Potenza computazionale di un sistema di calcolo

== Validità dell'inclusione $F(cal(C)) subset.eq dati_bot^dati$

Ora che abbiamo una definizione "potente" di cardinalità, essendo basata su strutture matematiche, possiamo verificare la validità dell'inclusione $ F(cal(C)) subset.eq dati_bot^dati. $

Diamo prima qualche considerazione:
- $programmi tilde NN$: identifico ogni programma con un numero, ad esempio la sua codifica in binario;
- $dati tilde NN$: come prima, identifico ogni dato con la sua codifica in binario.

In poche parole, stiamo dicendo che programmi e dati non sono più dei numeri naturali $NN$.

Ma questo ci permette di dire che: $ F(cal(C)) tilde programmi tilde NN tilde.not NN_bot^NN tilde dati_bot^dati. $

== Conseguenze

Questo è un risultato importantissimo: abbiamo appena dimostrato con la relazione precedente che *esistono funzioni non calcolabili*. Le funzioni non calcolabili sono problemi pratici e molto sentiti al giorno d'oggi: un esempio di funzione non calcolabile è la funzione che, dato un software, dice se è corretto o no. Il problema è che _ho pochi programmi e troppe/i funzioni/problemi_.

Questo risultato però è arrivato considerando vere le due considerazioni precedenti: andiamo quindi a dimostrarle utilizzando le *tecniche di aritmetizzazione* (o _godelizzazione_) *di strutture*, ovvero delle tecniche che rappresentano delle strutture con un numero, così da avere la matematica e l'insiemi degli strumenti che ha a disposizione.
