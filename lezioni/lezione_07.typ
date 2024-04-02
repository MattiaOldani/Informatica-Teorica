// Setup

#import "@preview/ouset:0.1.1": overset

#import "@preview/lemmify:0.1.5": *

#let (
  theorem, lemma, corollary,
  remark, proposition, example,
  proof, rules: thm-rules
) = default-theorems("thm-group", lang: "it")

#show: thm-rules

#show thm-selector("thm-group", subgroup: "proof"): it => block(
  it,
  stroke: green + 1pt,
  inset: 1em,
  breakable: true
)

#import "alias.typ": *

// Appunti

= Lezione 07

== Aritmetizzare un programma

Per verificare che $programmi tilde NN$ dobbiamo trovare un modo per codificare i programmi in numeri in modo biunivoco.

Notiamo che se la lista di istruzioni fosse una lista di interi, potremmo sfruttare la funzione di Cantor per ottenere un numero associato al programma.

/* Diagramma, Tia mi devi far vedere non sono proprio capace... */

In generale, il processo che associa biunivocamente un numero ad una qualsiasi struttura viene chiamato *aritmetizzazione* o *godelizzazione*.

Se trovo $ar$ invertibile, sono sicuro che lo sia anche l'intero processo $arrow.double$ siamo interessati ad aritmetizzare le istruzioni $ram$. $ ar : "ISTR" arrow NN, ar^-1 : NN arrow "ISTR" | ar("istr") = n arrow.l.r.double.long ar(n) = "istr". $

Un esempio è quello di codificare le istruzioni in questo modo:
- $ar(inc(R_k)) = 3k$
- $ar(subsus(R_k)) = 3k + 1$
- $ar(ifgoto(R_k, m)) = 3 <k,m> - 1$
Le inverse sono facilmente ricavabili (eventualmente sfruttando $#cantor_sin$ e $#cantor_des$ della funzione di Cantor).

Siamo, quindi, capaci di trovare una corrispondenza biunivoca tra $programmi$ e $NN arrow.double underline(programmi tilde NN)$.

== Osservazioni
- I numeri diventano un linguaggio di programmazione;
- Possiamo scrivere $F(ram) = {phi_P : P in programmi}$ in questo modo $F(ram)={phi_i}_(i in NN)$;
- Per sistema $ram$ vale (come già potevamo intuire) $F(ram) tilde NN tilde.not NN^NN$;
- $ram$ potrebbe essere troppo elementare per poter rappresentare la classe di tutti i  problemi risolubili automaticamente. 

Considerando un sistema di calcolo $cal(C)$ più sofisticato dare un'idea formale di "ciò che è calcolabile automaticamente" come $F(cal(C))$ che sia più ampia di $F(ram)$.

Se si dimostrasse che $F(cal(C)) = F(ram)$, significherebbe che cambiare tecnologia non aumenta ciò che è calcolabile $arrow.double$ potremmo cercare di "catturare" la calcolabilità matematicamente.

== Sistema di calcolo $mwhile$

=== Macchina $mwhile$

La macchina $mwhile$, come quella $ram$, è molto semplice: consiste solo in una serie di *registri*, detti *variabili*. Al contrario delle macchine $ram$, qui i registri non sono fissati, bensì sono esattamente $21$ e non esiste il registro dedicato al $"PC"$ in quanto il linguaggio è _strutturato_.

=== Linguaggio $mwhile$

Il linugaggio $mwhile$ prevede una definizione induttiva: vengono definiti alcuni comandi base e i comandi più complessi sono una concatenazione dei comandi base.

- $underline("passo base")$ \ *assegnamento* : $x_k arrow.l 0, inc(x_k), subsus(x_j)$;
- $underline("passo induttivo")$ \ *while* : $comandowhile$, dove $"C"$ è un comando composto; \ *composto* : $composto$.

Detto ciò, ci viene facile definire i programmi $mwhile$, in quanto essi sono dei semplici comandi composti.
$ wprogrammi = {"programmi" mwhile}. $

Chiamiamo $Psi_w : NN arrow NN_bot$ la semantica di $w$ programma $mwhile$. Per dimostrare una proprietà $P$ su $wprogrammi$, procedo induttivamente:
1. dimostro $P$ su assegnamenti;
2. suppongo $P$ vera su $C$ e la dimostro per $comandowhile$;
3. suppongo $P$ vera su $C$ e la dimostro per $composto$.