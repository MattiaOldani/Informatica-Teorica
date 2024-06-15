#import "../alias.typ": *


= Potenza computazionale di un sistema di calcolo

== Validità dell'inclusione $F(cal(C)) subset.eq dati_bot^dati$

Ora che abbiamo una definizione più robusta di cardinalità, essendo basata su strutture matematiche, possiamo studiare la natura dell'inclusione $ F(cal(C)) subset.eq dati_bot^dati. $

Vediamo prima due intuizioni (che saranno da dimostrare):
- $programmi tilde NN$: identifichiamo ogni programma con un numero, ad esempio la sua codifica in binario;
- $dati tilde NN$: anche qui, identifichiamo ogni dato con la sua codifica in binario.

In altre parole, i programmi e i dati non sono più dei numeri naturali $NN$.

Questo ci permette di dire che: $ F(cal(C)) tilde programmi tilde NN tilde.not NN_bot^NN tilde dati_bot^dati. $

Con questa relazione, abbiamo appena dimostrato che *esistono funzioni non calcolabili*.\
Queste funzioni sono problemi molto pratici e molto utili al giorno d'oggi: un esempio è la funzione che, dato un software, ci dica se è corretto o no.\

Il problema è che _esistono pochi programmi e troppe/i funzioni/problemi_.

Quello che ci resta fare è dimostrare le due assunzioni
- $programmi tilde NN$;
- $dati tilde NN$.
Lo faremo utilizzando le *tecniche di aritmetizzazione* (o _godelizzazione_) *di strutture*, tecniche che rappresentano delle strutture tramite un numero, così da poter utilizzare la matematica e tutti gli strumenti di cui essa dispone.
