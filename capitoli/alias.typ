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
#let cantor(..params) = {
  let add = params.pos().join(", ")
  $angle.l add angle.r$
}
#let cantorsin = $op("sin")$
#let cantordes = $op("des")$
#let listlength = $op("length")$

// Sistemi di calcolo
#let ram = $"RAM"$
#let mwhile = $"WHILE"$

// Sistema ram
#let inc(reg) = $reg arrow.long.l reg + 1$
#let subsus(reg) = $reg arrow.long.l reg overset(-,.) 1$
#let ifgoto(reg,number) = $"IF" reg = 0 "THEN GOTO" number$
#let istr(index) = $"Istr"_index$
#let istruzioni = $"ISTR"$
#let stati = $"STATI"$
#let iniziale = $S_("iniziale")$
#let inizializzazione = $"in"$
#let cod = $op("cod")$
#let ar = $"Ar"$

// Sistema while
#let composto = $"begin" C_1";"dots";"C_n "end"$
#let comandowhile = $"while" x_k eq.not 0 "do" C$
#let wstato(nome) = $underline(nome)$
#let wstati = $W"-STATI"$
#let winizializzazione = $"w-in"$
#let wcomandi = $"W-COM"$
#let wprogrammi = $W"-"programmi$

// Traduttori
#let c1programmi = $C_1"-"programmi$
#let c2programmi = $C_2"-"programmi$
#let compilatore = $op("Comp")$
#let colorcode(color,code) = text(fill: color)[$#code$]
#let proiezione(index,lista) = $op("Proj")(index,lista)$
#let macroincr(index,lista) = $op("incr")(index,lista)$
#let macrodecr(index,lista) = $op("decr")(index,lista)$

// Definizione formale di calcolabilità
#let elem = $"ELEM"$
#let comp = $"COMP"$
#let rp = $"RP"$
#let ricprim = $"RICPRIM"$
#let lfor = $"FOR"$
#let min = $"MIN"$
#let arresto(programma) = $"AR"_programma$
#let ristretto = $overset(P,§)$

// DTM
#let blank = "blank"

// Classi di complessità
#let dtime = $italic("DTIME")$
#let ftime = $italic("FTIME")$
#let dspace = $italic("DSPACE")$
#let fspace = $italic("FSPACE")$
#let fp = $italic("FP")$
#let fl = $italic("FL")$
#let exptime = $italic("EXPTIME")$
#let cent = $¢$

// Classi di complessità non deterministiche
#let ntime = $italic("NTIME")$
#let NP = $italic("NP")$
#let NPC = $italic("NPC")$
#let PC = $italic("PC")$
