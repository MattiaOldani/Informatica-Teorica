= Richiami matematici: simboli di Landau

Quello che facciamo nella teoria della complessità è chiederci _"quanto costa questo programma?"_

Per capire il costo di un dato programma valuteremo delle funzioni nella forma $f(n)$, dove $n$ indica la grandezza dell'input della DTM. Nel fare il confronto tra due algoritmi per uno stesso problema, bisogna tenere in considerazione che a fare la differenza (_in termini di prestazioni_) sono gli input di dimensione "ragionevolmente grande", dove con questa espressione intendiamo una dimensione significativa nel contesto d'applicazione del problema.

Siano ad esempio $t_1$ e $t_2$ due funzioni tali che $ t_1 (n) = 2n quad bar.v quad t_2 (n) = 1/100 n^2 + 1/2 n + 1 . $

Quale delle due è migliore? La risposta è _dipende_: se considero $n$ abbastanza piccoli allora $t_2$ è migliore perché i coefficienti ammortizzano il valore di $n^2$, mentre se considero $n$ sufficientemente grandi è migliore $t_1$.

Date due funzioni, non le devo valutare per precisi valori di $n$, ma devo valutare il loro *andamento asintotico*, ovvero quando $n$ tende a $+infinity$.

== Simboli di Landau principali

I *simboli di Landau* sono utili per stabilire degli *ordini di grandezza* fra le funzioni, in modo da poterle paragonare. I più utilizzati sono i seguenti tre:
+ $O$: letto _"O grande"_, date due funzioni $f,g : NN arrow.long NN$ diciamo che $ f(n) = O(g(n)) $ se e solo se $ exists c > 0 quad exists n_0 in NN bar.v forall n gt.eq n_0 quad f(n) lt.eq c dot g(n) . $ Questo simbolo dà un *upper bound* alla funzione $f$.
+ $Omega$: letto _"Omega grande"_, date due funzioni $f,g : NN arrow.long NN$ diciamo che $ f(n) = Omega(g(n)) $ se e solo se $ exists c > 0 quad exists n_0 in NN bar.v forall n gt.eq n_0 quad f(n) gt.eq c dot g(n). $ Questo simbolo dà un *lower bound* alla funzione $f$.
+ $Theta$: letto _"teta grande"_, date due funzioni $f,g : NN arrow.long NN$ diciamo che $ f(n) = Theta(g(n)) $ se e solo se $ exists c_1, c_2 > 0 quad exists n_0 in NN bar.v forall n gt.eq n_0 quad c_1 dot g(n) lt.eq f(n) lt.eq c_2 dot g(n). $

Si può notare facilmente che valgono le proprietà $ f(n) = O(g(n)) arrow.l.r.long.double g(n) = Omega(f(n)) \ f(n) = Theta(g(n)) arrow.l.r.long.double f(n) = O(g(n)) and f(n) = Omega(g(n)) . $

Noi useremo spesso $O$ perché ci permette di definire il _worst case_.
