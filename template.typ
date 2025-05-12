#let project(title: "", body) = {
  set document(title: title)

  set text(font: "New Computer Modern Math", lang: "it")

  set par(justify: true)

  set page(numbering: "1")

  set heading(numbering: "1.")

  set list(indent: 1.2em)
  set enum(indent: 1.2em)

  align(center + horizon)[
    #block(text(weight: 700, 4.35em, title))
  ]

  pagebreak()

  show figure.where(kind: "parte"): it => {
    counter(heading).update(0)
    set page(footer: { })
    if it.numbering != none {
      set text(size: 20pt)
      align(
        center + horizon,
        strong(it.supplement + [ ] + it.counter.display(it.numbering)) + [ --- ] + strong(it.body),
      )
    }
  }

  show outline.entry: it => {
    if it.element.func() == figure {
      let res
      if it.element.numbering != none {
        res = link(
          it.element.location(),
          it.indented(it.prefix(), [ --- ] + it.element.body + h(1fr) + it.page()),
        )
      } else {
        res = link(
          it.element.location(),
          it.indented(it.prefix(), it.element.body + h(1fr) + it.page()),
        )
      }

      v(2.3em, weak: true)
      strong(text(size: 16pt, res))
    } else {
      it
    }
  }

  show outline.entry.where(level: 1): it => {
    v(12pt, weak: true)
    strong(it)
  }

  let chapters-and-headings = figure.where(kind: "parte", outlined: true).or(heading.where(outlined: true))

  outline(indent: 2em, target: chapters-and-headings)

  show link: underline

  body
}

#let parte = figure.with(
  kind: "parte",
  numbering: none,
  supplement: "Parte",
  caption: [],
)

#let parte = parte.with(numbering: "I")
