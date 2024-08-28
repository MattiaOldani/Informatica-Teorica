= Richiami matematici: relazioni di equivalenza

Prima di dare una definizione formale e utile di cardinalità andiamo a riprendere alcuni concetti sulle relazioni di equivalenza.

== Relazioni di equivalenza

Dati due insiemi $A,B$, una *relazione binaria* $R$ è un sottoinsieme $R subset.eq A times B$ di coppie ordinate.

Consideriamo una relazione $R subset.eq A^2$. Due elementi $a,b in A$ sono in *relazione* $R$ se e solo se $(a,b) in R$. Indichiamo la relazione tra due elementi tramite la notazione infissa $a R b$.

Una classe di relazioni molto importante è quella delle *relazioni di equivalenza*. Una relazione $R subset.eq A^2$ è una relazione di equivalenza se e solo se rispetta le seguenti proprietà:
- *riflessiva*: $forall a in A quad a R a$;
- *simmetrica*: $forall a,b in A quad a R b arrow.long.double b R a$;
- *transitiva*: $forall a,b,c in A quad a R b and b R c arrow.long.double a R c$.

== Partizione indotta dalla relazione di equivalenza

Ad ogni relazione di equivalenza si può associare una *partizione*, ovvero un insieme di sottoinsiemi $A_i$ tali che: 
- $forall i in NN^+ quad A_i eq.not emptyset$;
- $forall i,j in NN^+ bar.v i eq.not j$ allora $A_i sect A_j = emptyset$;
- $limits(union.big)_(i in NN^+) A_i = A$.
Diremo che $R$ definita su $A^2$ _induce_ una partizione ${A_1, A_2, dots}$ su $A$.

== Classi di equivalenza e insieme quoziente

Dato un elemento $a in A$, chiamiamo l'insieme $ [a]_R = {b in A bar.v a R b} $ *classe di equivalenza* di $a$, ovvero tutti gli elementi che sono in relazione con esso. L'elemento $a$ prende il nome di *rappresentante della classe*.

Si può dimostrare che:
- non esistono classi di equivalenza vuote, garantito dalla riflessività;
- dati $a,b in A$ allora $[a]_R sect [b]_R = emptyset$ oppure $[a]_R = [b]_R$, garantito dal fatto che due elementi o sono in relazione o non lo sono;
- $limits(union.big)_(a in A) [a]_R = A$.

Notiamo che, per definizione, l'insieme delle classi di equivalenza è una partizione indotta dalla relazione $R$ sull'insieme $A$. Questa partizione è detta *insieme quoziente* di $A$ rispetto a $R$ ed è denotato con $A slash.big R$.
