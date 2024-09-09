#let project(title: "", body) = {
    set document(title: title)

    set text(font: "Source Sans Pro", lang: "it")

    set par(justify: true)

    set heading(numbering: "1.")

    set list(indent: 1.2em)
    set enum(indent: 1.2em)

    set page(numbering: "1")

    align(center)[
        #block(text(weight: 700, 1.75em, title))
    ]

    v(1.75em)

    show figure.where(kind: "parte"): it => {
        counter(heading).update(0)
        set page(
            footer: {
            set text(weight: "regular", size: 11pt)
            counter(page).display()
            }
        )
        if it.numbering != none {
            set text(size: 20pt)
            align(center + horizon, 
            strong(it.supplement + [ ] + it.counter.display(it.numbering)) + [ --- ] + strong(it.body)
            )
        }
    }

    show outline.entry: it => {
        if it.element.func() == figure {
            // https://github.com/typst/typst/issues/2461
            let res = link(it.element.location(), 
                if it.element.numbering != none {
                    it.element.supplement + [ ] 
                    numbering(it.element.numbering, ..it.element.counter.at(it.element.location()))
                } + [ --- ] + it.element.body
            )
            
            res += h(1fr)

            res += link(it.element.location(), it.page)
            v(2.3em, weak: true)
            strong(text(size: 13pt, res))
        } else {
            h(1em * (it.level - 1)) + it
        }
    }

    show outline.entry.where(
        level: 1
    ): it => {
        v(12pt, weak: true)
        strong(it)
    }

    let chapters-and-headings = figure.where(kind: "parte", outlined: true).or(heading.where(outlined: true))

    pagebreak()

    outline(indent: auto, target: chapters-and-headings)
    
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
