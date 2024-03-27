// Setup

#import "@preview/ouset:0.1.1": overset

// Alias

// Spazi
#let quarter = $space.quarter$

// Matematica
#let dominio(funzione) = $op("Dom")_funzione$
#let immagine(funzione) = $op("Im")_(funzione)$
#let composizione = $circle.stroked.tiny$

// Dati e programmi
#let dati = $"DATI"$
#let programmi = $"PROG"$

// Funzione coppia di Cantor
#let cantor_sin = $"sin"$
#let cantor_des = $"des"$

// Sistemi di calcolo
#let ram = $"RAM"$
#let mwhile = $"WHILE"$

// Sistema ram
#let inc(reg) = $reg arrow.long.l reg + 1$
#let subsus(reg) = $reg arrow.long.l reg overset(-,.) 1$
#let ifgoto(reg,m) = $"IF" reg = 0 "THEN GOTO" m$
#let istr(index) = $"Istr"_index$
#let stati = $"STATI"$
#let iniziale = $S_("iniziale")$
#let inizializzazione = $"in"$

// Sistema while
#let composto = $"begin" C_1";"dots";"C_m "end"$
#let comandowhile = $"while" x_k eq.not 0 "do" C$
#let wstato(nome) = $underline(nome)$
#let wstati = $W"-STATI"$
#let winizializzazione = $"w-in"$
#let wcomandi = $"W-COM"$
#let wprogrammi = $W"-"programmi$

// Traduttori
#let c1programmi = $C_1"-"programmi$
#let c2programmi = $C_2"-"programmi$
