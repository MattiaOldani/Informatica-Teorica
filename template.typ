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

    show outline.entry.where(
        level: 1
    ): it => {
        v(12pt, weak: true)
        strong(it)
    }

    show link: underline

    pagebreak()

    outline(indent: auto)

    body
}

#let parte(it) = {
    set page(
        footer: {
        set text(weight: "regular", size: 11pt)
        counter(page).display()
        }
    )
    //#set text(size: 28pt)
    align(
        center + horizon,
        heading(numbering: none, level: 1, it)
    )
}