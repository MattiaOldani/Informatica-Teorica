#let project(title: "", body) = {
    set document(title: title)

    set text(font: "Source Sans Pro", lang: "it")
    set text(hyphenate: false)

    set par(justify: true)

    set heading(numbering: "1.")

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

    outline(indent: auto)

    body
}
