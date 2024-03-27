// Setup alias

#import "@preview/ouset:0.1.1": overset

#let quarter = $space.quarter$

#let dominio(funzione) = $op("Dom")_funzione$
#let immagine(funzione) = $op("Im")_(funzione)$

#let composizione = $circle.stroked.tiny$

#let dati = $text("DATI")$
#let programmi = $text("PROG")$

#let cantor_sin = $text("sin")$
#let cantor_des = $text("des")$

#let ram = $text("RAM")$
#let mwhile = $text("while")$

#let inc(reg) = $reg arrow.long.l reg + 1$
#let subsus(reg) = $reg arrow.long.l reg overset(-,.) 1$
#let ifgoto(reg,m) = $"IF" reg = 0 "THEN GOTO" m$

#let istr(index) = $"Istr"_index$

#let stati = $text("STATI")$
#let iniziale = $S_("iniziale")$
#let inizializzazione = $text("in")$
