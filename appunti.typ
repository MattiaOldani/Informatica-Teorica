// Setup

#import "template.typ": project

#show: project.with(
  title: "Informatica teorica"
)

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

#pagebreak()

// Appunti

#include "lezioni/lezione_01.typ"

#pagebreak()

#include "lezioni/lezione_02.typ"

#pagebreak()

#include "lezioni/lezione_03.typ"

#pagebreak()

#include "lezioni/lezione_04.typ"

#pagebreak()

#include "lezioni/lezione_05.typ"

#pagebreak()

#include "lezioni/lezione_06.typ"

#pagebreak()

= Lezione 07

/* GIGI */
