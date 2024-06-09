// Setup

#import "@preview/ouset:0.1.1": overset

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

#import "alias.typ": *

// Appunti

= Lezione 24

== $NP subset.eq P$?

Nella scorsa lezione abbiamo introdotto i problemi della classe _NP_, detti anche _problemi con botta di culo_ o _problemi con il fattore C_. Se per questi problemi non abbiamo ancora una soluzione efficiente vuol dire che non lo conosciamo ancora a fondo, o magari manca una solida base matematica che ci permetta di risolverli.

Per mostrare che $NP subset.eq P$ dovremmo prendere ogni problema in _NP_ e trovare per essi un algoritmo di soluzione _polinomiale_. Ovviamente questo approccio è impraticabile dato che _NP_ contiene infiniti problemi, del tutto eterogenei. Potremmo ovviare a questo problema agendo solo su un sottoinsieme dei problemi a nostra disposizione piuttosto che su tutti quanti.

Vediamo una strategia che permette di isolare un kernel di problemi in _NP_ :
+ stabiliamo una *relazione di difficoltà* tra problemi in _NP_ : dati $pi_1, pi_2 in NP$ allora $pi_1 lt.eq pi_2$ indica che, se riesco a trovare una soluzione efficiente per $pi_2$, allora ho automaticamente una soluzione efficiente per $pi_1$. In poche parole, $pi_1$ non è più difficile di $pi_2$, se sono bravo su $pi_2$ sono bravo anche su $pi_1$;
+ definita tale relazione, utilizziamola per trovare l'insieme dei problemi *più difficili* di _NP_ : $pi$ è difficile in _NP_ se $ pi in NP and forall overset(pi, tilde) in NP quad overset(pi, tilde) lt.eq pi. $ Questi possiamo definirli i _problemi bad boys_ di _NP_;
+ restringiamo la ricerca di algoritmi efficienti al kernel in _NP_ appena trovato: se possiamo risolvere questi in modo efficiente, allora possiamo trovare algoritmi efficienti per tutto _NP_.

=== Riduzione polinomiale

Iniziamo definendo formalmente una *relazione di difficoltà* necessaria a identificare un sottoinsieme di $NP$.

Dati due linguaggi $L_1, L_2 subset.eq Sigma^*$ (o due problemi di decisione) diciamo che $L_1$ si *riduce polinomialmente* a $L_2$, e lo indichiamo con $L_1 lt.eq_P L_2$, se e solo se esiste una funzione $f : Sigma^* arrow.long Sigma^*$ tale che:
+ $f$ è calcolabile su DTM in *tempo polinomiale*, quindi $f in fp$ ;
+ $forall x in Sigma^* quad x in L_1 arrow.double.long.l.r f(x) in L_2$.

Le funzioni di riduzione polinomiale sono anche dette *many-one-reduction* perché non sono per forza funzioni iniettive (e quindi biiettive).

#theorem(numbering:none)[
  Siano due linguaggi $A,B subset.eq Sigma^* bar.v A lt.eq_P B$. Allora $ B in P arrow.long.double A in P . $
]

#proof[
  \ Siccome $A lt.eq_P B$, sia $f in fp$ la funzione di riduzione polinomiale. Sappiamo inoltre che $B in P$. Consideriamo il seguente algoritmo: 
  
  $ P equiv & "input"(x) \ & y := f(x); \ & "if" (y in B) \ & quad "return" 1 \ & "else" \ & quad "return" 0 $

  // $ P equiv & "input"(x) \ & "return" f(x) in B $

  Questo algoritmo è sicuramente deterministico, perché tutte le procedure che lo compongono sono deterministiche. Inoltre, riconosce $A$, per via della seconda condizione della riducibilità.

  La sua complessità in tempo, dato un input $x$ di lunghezza $n$, è: $ t(n) = t_f (n) + t_(y in B) (|y|) = p(n) + q(|y|). $

  Notiamo che $|y| lt.eq p(n)$, in quanto output di una procedura che impiega $p(n)$ passi per generare $y$, quindi: $ t(n) lt.eq p(n) + q(p(n)) = "poly"(n), $ in quanto i polinomi sono chiusi per somma e composizione.

  In conclusione, l'algoritmo deterministico proposto riconosce $A$ in tempo polinomiale, quindi: $ A lt.eq_P B and B in P arrow.long.double A in P. $
]

Questo teorema è ottimo per la nostra _"missione"_: infatti, se trovo una soluzione efficiente per i _"problemi difficili"_ allora ce l'ho anche per i _"problemi meno difficili"_, visto che dovrei aggiungere solo la parte di riduzione polinomiale, che abbiamo mostrato essere efficiente.

=== Problemi _NP_-completi

Possiamo identificare ora il sottoinsieme di problemi che sono _alla destra_ della relazione di riducibilità polinomiale per almeno un altro problema, i problemi _cattivi_ e _difficili_.

Un problema di decisione $Pi$ è *_NP_-completo* se e solo se:
+ $Pi in NP$ ;
+ $forall overset(Pi, tilde) in NP quad overset(Pi, tilde) lt.eq_P Pi$.

Sia $NPC$ la sottoclasse di _NP_ dei problemi _NP_-completi. Per provare che $NP subset.eq P$ posso restringere la mia ricerca di algoritmi di soluzione efficiente ai soli membri di $NPC$ grazie al seguente teorema.

#theorem(numbering:none)[
  Sia $Pi in NPC$ e $Pi in P$. Allora, $NP subset.eq P$, e quindi $P = NP$.
]

#proof[
  \ Dato che $Pi in NPC$, vale $ forall overset(Pi, tilde) in NP quad overset(Pi, tilde) lt.eq_P Pi. $
  
  Visto che $Pi in P$, abbiamo dimostrato prima che $ overset(Pi, tilde) lt.eq_P Pi and Pi in P arrow.long.double overset(Pi, tilde) in P, $ otteniamo che ogni problema $overset(Pi, tilde) in NP$ appartiene anche a $P$, quindi $ NP subset.eq P $ e quindi anche che $ P = NP. $
]

Sorgono spontanee due domande:
- _esistono problemi in NP-C?_
- _se sì, sono state trovate soluzioni efficienti?_

Alla prima domanda rispondiamo *SI*: il primo problema _NP_-completo è proprio _CNF-SAT_, dimostrato nel 1970 con il teorema di Cooke-Levin. L'appartenenza a _NP_ è banale, mentre la sua completezza è _noiosa da leggere_ (cit. Mereghetti).

Una prima variante di questo problema è _K-CNF-SAT_: viene limitata la cardinalità delle clausole $C_i$, formate da _or_ e _not_, a $k$ letterali. Ad esempio, se $k = 4$ una clausola può essere $(a or overline(b) or c or d)$. Con questa variante:
- se $k = 1$ il problema ammette soluzioni in tempo lineare;
- se $k = 2$ il problema ammette soluzioni in tempo quadratico, dimostrato in un articolo del 1975;
- se $k gt.eq 3$ il problema è _NP_-completo.

Una seconda variante limita invece il soddisfacimento di _al massimo k clausole_.

Infine, una terza variante è quella che considera le _CNF con clausole di Horn_, ovvero clausole in cui esiste al più un letterale negato. In questo caso particolare, il problema torna ad essere efficientemente risolubile.

Come vediamo, quando ho un problema difficile cerco delle varianti interessanti con la speranza di gestire almeno questi sotto-problemi significativi.

Un altro problema _NP_-completo è _HC_ (_Hamiltonian Circuit_), allo stesso modo di altri migliaia di problemi interessanti sui grafi e altri di svariati ambiti.

La comunità scientifica, dopo anni di tentativi e svariate ragioni, tende ormai a credere che $P eq.not NP$, di conseguenza dimostrare l'_NP_-completezza di un problema implica sancirne l'inefficienza di qualunque algoritmo di soluzione.

Dopo aver stabilito l'NP-completezza, l'indagine sui problemi però non si ferma: si provano restrizioni, algoritmi probabilistici efficienti (con margine di errore), euristiche veloci di soluzione, eccetera. Questo perché questi problemi sono estremamente comuni e utili, quindi stabilire la loro inefficienza darebbe il via alla ricerca del _miglior algoritmo che più si approssima a quella che consideriamo efficienza_. 

=== Dimostrare la _NP_-completezza

Vediamo ora una tecnica per mostrare che un problema $Pi$ è _NP_-completo:
+ dimostrare che $Pi in NP$, solitamente il punto più semplice;
+ scegliere un problema $X$ notoriamente _NP_-completo;
+ dimostrare che $X lt.eq_P Pi$;
+ per la transitività di $lt.eq_P$ si ottiene che $Pi in NPC$.

Infatti:
+ $Pi in NP$ per il punto 1;
+ $forall overset(Pi,tilde) in NP$ abbiamo che $ overset(Pi,tilde) lt.eq_P^((2)) X lt.eq_P^((3)) Pi . $ Ma quindi per la transitività di $lt.eq_P$ del punto 4 abbiamo che $forall overset(Pi,tilde) in NP$ allora $overset(Pi,tilde) lt.eq Pi$, quindi $Pi$ è _NP_-completo.

== $P subset.eq L$?

C'è un'inclusione che abbiamo lasciato in sospeso, ed è proprio quella che coinvolge le classi $L$ e $P$. Ricordiamo che $ L = dspace(log(n)), \ P = union.big_(k gt.eq 0) dtime( n^k). $

Abbiamo mostrato che $L subset.eq P$, _ma l'inclusione è propria? Oppure $P subset.eq L$?_

Possiamo procedere in maniera simile a quanto fatto per $NP subset.eq P$:
+ stabiliamo una *relazione di difficoltà* tra problemi $pi_1 lt.eq pi_2$ che voglia dire: _se esiste una soluzione efficiente in spazio per $pi_2$, allora esiste automaticamente una soluzione efficiente per $pi_1$_;
+ trovare i problemi *massimali* in $P$ secondo la relazione definita al punto precedente;
+ restringere la ricerca di algoritmi efficienti in spazio a questi problemi massimali. Se la ricerca porta un successo su un problema massimale, allora $P subset.eq L$ e quindi $P = L$.

=== Riduzione in spazio logaritmico

Definiamo una riduzione utile al procedimento appena spiegato.

Dati due linguaggi $L_1, L_2 subset.eq Sigma^*$ (o due problemi di decisione), diciamo che $L_1$ si *log-space riduce* a $L_2$, e lo indichiamo con $L_1 lt.eq_l L_2$, se e solo se esiste una funzione $f : Sigma^* arrow.long Sigma^*$ tale che:
+ $f$ è calcolabile su una DTM in *spazio logaritmico*, ovvero $f in fl$;
+ $forall x in Sigma^* quad x in L_1 arrow.long.double.l.r f(x) in L_2$.

Similmente a quanto vista prima, esiste un teorema che dimostra una sorta di transitività per due linguaggi tra cui esiste una relazione di riducibilità.

#theorem(numbering:none)[
  Siano due linguaggi $A, B in Sigma^* bar.v A lt.eq_l B$. Allora $ B in L arrow.long.double A in L . $
]

#proof[
  \ Sappiamo che $A lt.eq_l B$, quindi esiste $f in fl$ funzione di log-space riduzione. Consideriamo il seguente algoritmo: $ P equiv & "input"(x) \ & y := f(x); \ & "if" (y in B) \ & quad "return" 1 \ & "else" \ & quad "return" 0 . $

  Questo è sicuramente un algoritmo deterministico, in quanto è composto da _"moduli"_ a loro volta deterministici. Inoltre, riconosce $A$ per via della seconda condizione della riducibilità.

  La sua complessità in spazio, dati input $x$ di lunghezza $n$, è descritta dalla seguente complessità: $ s(n) = s_f (n) + s_(y in B) (|y|) = O(log(n)) + O(log(|y|)). $

  _Quanto sarà la lunghezza di $y$?_ 
  
  Notiamo che $|y| lt.eq p(n)$, perché è output di una procedura che impiega spazio logaritmico e quindi un numero polinomiale di passi. Questo deriva dalla relazione $fl subset.eq fp$. Quindi: $ s(n) = O(log(n)) + O(log(p(n))) = O(log(n)). $

  In conclusione, l'algoritmo deterministico proposto riconosce $A$ in spazio logaritmico, dunque: $ A lt.eq_l B and B in L arrow.long.double A in L. $
]

Prima di continuare dobbiamo fare attenzione ad un dettaglio: la generazione di $y$ è sì logaritmica in spazio ma serve comunque spazio per salvare il valore di questa variabile, che può essere polinomiale. Si utilizza allora la *computazione on demand*: viene generata $y$ bit per bit, non tutta insieme. Il dato che viene salvato è l'indice del bit richiesto dalla funzione che controlla l'appartenenza a $B$, ma l'indice è logaritmico se lo consideriamo in binario, quindi stiamo utilizzando spazio logaritmico.

=== Problemi _P_-completi

Come prima, identifichiamo il sottoinsieme di problemi di $P$ che andremo a studiare.

Un problema di decisione $Pi$ è *_P_-completo* se e solo se:
+ $Pi in P$;
+ $forall overset(Pi, tilde) in P quad overset(Pi, tilde) lt.eq_l Pi$.

Chiamiamo $PC$ la sottoclasse di _P_ dei problemi _P_-completi.

#theorem(numbering:none)[
  Sia $Pi in PC$ e $Pi in L$. Allora $P subset.eq L$.
]

#proof[
  \ Sappiamo che $Pi in PC$, quindi $ forall overset(Pi, tilde) in P quad overset(Pi, tilde) lt.eq_l Pi . $

  Se assumiamo che $Pi in L$ otteniamo che $ forall overset(Pi, tilde) in P quad overset(Pi, tilde) in L, $ quindi possiamo concludere che $P subset.eq L$ e, di conseguenza, $P = L$.
]

Un esempio di problema _P_-completo è quello che si chiede se una stringa $x$ appartiene a una certa grammatica context-free.

- Nome: context-free membership.
- Istanza: grammatica-context-free $G$, stringa $x$.
- Domanda: $x in L(G)$?

Questo problema viene risolto in tempo $t(n) = n^2 log(n)$ e in spazio $s(n) = O(log^2 (n))$.

Un altro problema _P_-completo è il seguente.

- Nome: circuit value (_circuito con porte logiche_).
- Istanza: circuito booleano $cal(C)(x_1, dots, x_n)$, valori in input $a_1, dots, a_n in {0,1}^*$.
- Domanda: $cal(C)(a_1, dots, a_n) = 1$?

Anche in questo caso lo spazio utilizzato è $s(n) = log^2 (n)$.

Come per $P subset.eq NP$, è universale assumere che l'inclusione $L subset.eq P$ sia propria, ma questo non frena gli studi su questi problemi, che sono attuali e molto utili. Si può anche dimostrare che i problemi _P_-completi non ammettono (_quasi certamente_) algoritmi paralleli efficienti.

=== Dimostrare la _P_-completezza

Infine, vediamo anche per questi problemi una tecnica per mostrare che un problema $Pi$ è _P_-completo:
+ dimostrare che $Pi in P$;
+ scegliere un problema $X$ notoriamente _P_-completo;
+ dimostrare che $X lt.eq_l Pi$;
+ per la transitività di $lt.eq_l$ si ottiene che $Pi in PC$.

== Problemi _NP_-hard

_Ma i problemi *NP-hard*? Cosa sono e dove si posizionano?_

Un problema $Pi$ _NP_-completo è tale che:
- $Pi in NP$;
- se $Pi in P$ allora $P = NP$.

Se invece $Pi$ è _NP_-hard vale solo che:
- se $Pi in P$ allora $P = NP$.

Sono problemi che _creano il collasso_ di _P_ e _NP_ ma non sono per forza problemi di decisione: ad esempio, _NP_-hard contiene tutti i *problemi di ottimizzazione* (_number-CNF-SAT_, quanti assegnamenti sono soddisfatti) oppure i *problemi enumerativi*.

== Situazione finale

Dopo tutto ciò che è stato visto in queste dispense, ecco un'illustrazione che mostra qual è la situazione attuale per quanto riguarda la classificazione di problemi.

#v(12pt)

#figure(
  image("../assets/situazione-finale.svg", width: 100%)
)

#v(12pt)

_NC_ è la classe di problemi risolti da *algoritmi paralleli efficienti*, ovvero algoritmi che hanno tempo parallelo _o piccolo_ del tempo sequenziale e un buon numero di processori.

L'unica inclusione propria dimostrata e nota è $P subset.neq exptime$, grazie al problema di decidere se una DTM si arresta entro $n$ passi. In tutti gli altri casi è universalmente accettato (_ma non dimostrato_) che le inclusioni siano proprie.
