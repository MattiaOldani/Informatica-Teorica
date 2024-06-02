// Setup

#import "@preview/ouset:0.1.1": overset, underset

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

#show thm-selector("thm-group", subgroup: "corollary"): it => block(
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

#import "alias.typ": *

// Appunti

// gigi: potrebbero essere da sistemare "P" e "NP" o simili che non capivo più se metterli fra $-$ o no (tipo: "$P$" piuttosto che "P").

= Lezione 24

== $NP subset.eq P$?

Per mostrare che $NP subset.eq P$ potrei prendere ogni problema in $NP$ e trovare per esso un algoritmo di soluzione _polinomiale_. Ovviamente questo approccio è impraticabile dato che $NP$ contiene infiniti problemi del tutto eterogenei.\
Potremmo ovviare a questo problema agendo solo su un sottoinsieme dei problemi in $NP$ piuttosto che su tutti quanti.

Vediamo una strategia che permette di isolare un kernel di problemi in $NP$:
+ stabiliamo una *relazione di difficoltà* tra problemi in $NP$ : dati $pi_1, pi_2 in NP$, allora scrivere $pi_1 lt.eq pi_2$ mi dice che se riesco a trovare una soluzione efficiente per $pi_2$, allora ho automaticamente una soluzione efficiente per $pi_1$ ($pi_1$ non è più difficile di $pi_2$);
+ definita la relazione, troviamo l'insieme di problemi *più difficili* in $NP$, secondo la relazione definita: $pi$ è difficile in $NP$ se $pi in NP and forall overset(pi, tilde) in NP : overset(pi, tilde) lt.eq pi$;
+ restringiamo la ricerca di algoritmi efficienti al kernel in $NP$ appena trovato: se possiamo risolvere questi in modo efficiente, allora possiamo trovare algoritmi efficienti per tutto $NP$.

=== Riduzione polinomiale

Iniziamo definendo formalmente una *relazione di difficoltà*, necessaria a identificare un sottoinsieme di $NP$.

// gigi: da sistemare il simbolo di "polinomialmente riducibile"
*Definizione*: Dati due linguaggi $L_1, L_2 subset.eq Sigma^*$ (o dei problemi di decisione) diciamo che $L_1$ si *riduce polinomialmente* a $L_2$ (e scriviamo $L_1 lt.eq_P L_2$) sse esiste una funzione $f : Sigma^* arrow Sigma^*$ tale che:
+ $f$ è calcolabile su DTM in *tempo polinomiale*;
+ $forall x in Sigma^* : x in L_1 arrow.double.long.l.r f(x) in L_2$.

#theorem(numbering:none)[
  Siano due linguaggi $A,B subset.eq Sigma^* : A lt.eq_P B$. Allora, $B in P arrow.double A in P$.
]

#proof[
  Siccome $A lt.eq_P B$, sia $f in fp$ la riduzione polinomiale. Consideriamo il seguente algoritmo: 
  
  // gigi: da rivedere come tutti gli altri
  $ P equiv & "input"(x); \ & y arrow.l f(x); \ & "if"(y in B) \ & quad "return" 1; \ & "else" \ & quad "return" 0; $

  Questo algoritmo è sicuramente deterministico, perché tutte le procedure che lo compongono sono deterministiche.
  
  Inoltre, riconosce $A$, per via della seconda condizione della riducibilità: $ forall x in A arrow.double.long.l.r f(x) in B. $

  La sua complessità in tempo, dato un input $x : |x| = n$, è: $ t(n) = t_f (n) + t_(y in B) (|y|) = p(n) + q(|y|) $

  Notiamo che $|y| lt.eq p(n)$, in quanto output di una procedura che impiega $p(n)$ passi. Quindi: $ t(n) = p(n) + q(p(n)) = "poly"(n), $ in quanto i polinomi sono chiusi per somme e composizione.

  In conclusione, l'algoritmo deterministico proposto riconosce $A$ in tempo polinomiale, quindi: $ A lt.eq B and B in P arrow.double A in P. $
]

=== Problemi _NP-completi_

Possiamo identificare ora il sottoinsieme di problemi tali che sono alla destra della relazione di riducibilità polinomiale per almeno un altro problema.

*Definizione*: Un problema di decisione $Pi$ è $NP$-completo sse:
  + $Pi in NP$;
  + $forall overset(Pi, tilde) in NP arrow.double.long overset(Pi, tilde) lt.eq_P Pi$;

Sia $NPC$ la sottoclasse di $NP$ dei problemi $NP$-completi.\
Per provare che $NP subset.eq P$ posso restringere la mia ricerca di algoritmi di soluzione efficiente ai soli membri di $NPC$ e ce lo conferma il seguente teorema.

#theorem(numbering:none)[
  Sia $Pi in NPC$ e $Pi in P$. Allora, $NP subset.eq P$.
]

#proof[
  Dato che $Pi in NPC$, vale che per ogni $overset(Pi, tilde) in NP, overset(Pi, tilde) lt.eq_P Pi$.\
  Assumendo che $Pi in P$ e considerando il teorema $A lt.eq_P B and B in P arrow.double A in P$, otteniamo che per ogni problema $overset(Pi, tilde) in NP$ vale $overset(Pi, tilde) in P$ e quindi possiamo concludere che $NP subset.eq P$ e $P = NP$.\ 
]

Ora, le domande che vengono spontanee sono: _esistono problemi in $NPC$?_ _Se sì, sono state trovate soluzioni efficienti?_

- Il primo problema NP-completo è stato _CNF-SAT_. Mostrare che sta in NP è banale, mentre la sua completezza è dimostrata nel teorema di Cooke-Levin del 1970.

  Una variante interessante di questo problema è _K-CNF-SAT_, in cui si limita la cardinalità delle clausole a $k$ letterali. In questa variante, se $k lt.eq 2$, allora il problema ammette soluzioni efficienti; se $k gt.eq 3$, il problema diventa NP-completo.

  Un'altra variante è quella che considera solo le _CNF_ con clausole di Horn e in questo caso particolare il problema torna efficientemente risolubile.
- Un altro problema NP-completo è _HC_ (_Hamiltonian Circuit_), allo stesso modo di altri migliaia di problemi interessanti sui grafi.
- Migliaia di problemi in svariati ambiti sono NP-completi.

La comunità scientifica tende ormai a credere che $P eq.not NP$, di conseguenza dimostrare l'NP-completezza di un problema implica sancire l'inefficienza di qualunque algoritmo di soluzione.

Dopo aver stabilito l'NP-completezza, l'indagine sui problemi non si ferma: si prova a inserire restrizioni, a trovare algoritmi probabilistici efficienti, si cercano euristiche veloci di soluzione, etc. Questo perché questi problemi sono estremamente comuni e utili, quindi stabilire la loro inefficienza darebbe il via alla ricerca del miglior algoritmo che più si approssima a quella che consideriamo efficienza. 

Vediamo ora una tecnica per mostrare che $Pi in NPC$:
+ dimostrare che $Pi in NP$, solitamente è il punto più semplice;
+ scegliere un problema $X$ notoriamente $in NPC$;
+ dimostrare che $X lt.eq_P Pi$;
+ per la transitività di $lt.eq_P$, si ottiene che $Pi in NPC$.

== $P subset.eq L$?

C'è un'inclusione che abbiamo lasciato in sospeso, ed è proprio quella che coinvolge $L$ e $P$. Ricordiamo che $ L = dspace(log n), \ P = union.big_(k gt.eq 0) dtime( n^k). $

Abbiamo mostrato che $L subset.eq P$, _ma l'inclusione è propria? Oppure $P subset.eq L$?_

Possiamo procedere in maniera simile a quanto fatto per $NP subset.eq P$:
+ stabilire una relazione tra problemi $pi_1 lt.eq pi_2$ che voglia dire: se esiste una soluzione efficiente in spazio per $pi_2$, allora esiste automaticamente una soluzione efficiente per $pi_1$;
+ trovare i problemi *massimali* in $P$ secondo la relazione definita al punto precedente;
+ restringere la ricerca di algoritmi efficienti in spazio a questi problemi massimali. Se la ricerca porta un successo su un problema massimale, allora $P subset.eq L$.

=== Riduzione in spazio logaritmico

Definiamo una riduzione utile al procedimento appena spiegato.

// gigi: da sistemare il simbolo di log-space riduce nelle equazioni, come per la riducibilità polinomiale
*Definizione*: Dati due linguaggi $L_1, L_2 subset.eq Sigma^*$ (o due problemi di decisione), diciamo che $L_1$ si *$bold(log)$-space riduce* a $L_2$ (e scriviamo $L_1 lt.eq_l L_2$) sse esiste una funzione $f : Sigma^* arrow Sigma^*$ tale che:
+ $f$ è calcolabile su una DTM in *spazio logaritmico*;
+ $forall x in Sigma^*, x in L_1 arrow.long.double.l.r f(x) in L_2$.

Similmente a quanto vista prima, esiste un teorema che dimostra una sorta di transitività per due linguaggi tra cui esiste una relazione di riducibilità.

#theorem(numbering:none)[
  Siano due linguaggi $A, B in Sigma^* : A lt.eq_l B$. Allora, $B in L arrow.double A in L$.
]

#proof[
  Siccome $A lt.eq_l B$, esiste $f in fl$ tale che è la $log$-space riduzione.

  // gigi: da sistemare come tutti gli altri
  Consideriamo il seguente algoritmo: $ P equiv & "input"(x); \ & y arrow.l f(x); \ & "if"(y in B) \ & quad "return" 1; \ & "else" \ & quad "return" 0; $

  Sicuramente è un algoritmo deterministico, in quanto è composto da "moduli" a loro volta deterministici.

  Inoltre, riconosce A per via della seconda condizione della riducibilità.

  La sua complessità in spazio, dato input $x$ con $|x| = n$, è descritta dalla seguente: $ s(n) = s_f(n) + s_(y in B) (|y|) = O(log n) + O(log |y|). $

  _Quanto sarà la lunghezza di $y$?_\
  Notiamo che $|y| lt.eq p(n)$, perché è output di una procedura che impiega spazio logaritmico e quindi un numero polinomiale di passi (infatti $fl subset.eq fp$). Quindi: $ s(n) = O(log n) + O(log p(n)) = O(log n). $

  In conclusione, l'algoritmo deterministico proposto riconosce $A$ in spazio logaritmico. Dunque: $ A lt.eq_l B and B in L arrow.double A in L. $
]

=== Probelmi _P-completi_

Abbiamo identificato il sottoinsieme di problemi che andremo ad analizzare.

*Definizione*: Un problema di decisione $Pi$ è P-completo sse:
  + $Pi in P$;
  + $forall overset(Pi, tilde) in P, overset(Pi, tilde) lt.eq_l Pi$.

Chiamiamo $PC$ la sottoclasse di P dei problemi P-completi.

#theorem(numbering:none)[
  Sia $Pi in PC$ e $Pi in L$. Allora $P subset.eq L$.
]

#proof[
  Poiché $Pi in PC$, abbiamo che per ogni problema $overset(Pi, tilde) in P$ vale $overset(Pi, tilde) lt.eq_l Pi$.\
  Ma assumendo anche che $Pi in L$, otteniamo che per ogni $overset(Pi, tilde) in P$ vale anche $overset(Pi, tilde) in L$, quindi possiamo concludere che $P subset.eq L$ e, di conseguenza, $P = L$.
]

- Un esempio di problema P-completo è quello che si chiede se una stringa x appartiene a una certa grammatica context-free:
  - Nome: $"Context-free-membership"$;
  - Istanza: Grammatica-context-free $G$, stringa $x$;
  - Domanda: $x in L(G)$?

- Un altro problema P-completo è il seguente:
  - Nome: $"Circuit value"$;
  - Istanza: Circuito booleano $cal(C)(x_1, dots, x_n)$, valori in input $a_1, dots, a_n in {0,1}^*$;
  - Domanda: $cal(C)(a_1, dots, a_n) = 1$?

Come per $P subset.eq NP$, è universale assumere che l'inclusione $L subset.eq P$ sia propria.\
Come prima, stabilire questa assunzione non chiuse definitivamente lo studio di questi problemi, anzi: bisogna trovare comunque delle soluzioni efficienti in tempo, perché sono tutti problemi estremamente pratici e importanti.

Si può anche dimostrare che i problemi P-completi non ammettono (quasi certamente) algoritmi paralleli efficienti.

Una buona tecnica per mostrare che un problema $Pi$ è P-completo è la seguente:
+ dimostrare che $Pi in P$;
+ scegliere un problema $X$ notoriamente P-completo;
+ dimostrare che $X lt.eq_l Pi$;
+ per la transitività di $lt.eq_l$, si ottiene che qualunque problema $overset(Pi, tilde) in P$ sia $log$-space riducibile a Pi;
+ per (1) e (4) si conclude che $Pi in PC$.

// gigi: da levare quando si uniranno le lezioni
#pagebreak()

== Situazione finale

Dopo tutto ciò che è stato visto in queste dispense, ecco un'illustrazione che mostra qual è la situazione attuale per quanto riguarda la classificazione di problemi.

#v(12pt)

#figure(
    image("../assets/situazione-finale.svg", width: 90%)
)

#v(12pt)

- $"NC" =$ classe di problemi risolti da *algoritmi paralleli efficienti*.

L'unica inclusione propria dimostrata e nota è $P subset.eq exptime$, in tutti gli altri casi è universalmente accettato (anche se non dimostrato) che le inclusioni siano proprie.