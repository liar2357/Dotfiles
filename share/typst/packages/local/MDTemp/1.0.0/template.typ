// by BisNiki, VERSION as of May 2025
//
// Assumes Pandoc v3.6; Typst v0.13
//
// This template is for Typst with Pandoc
// The assumption is markdown source, with a
// YAML metadata block (title, author, date...)
// Usage:
//    pandoc article.md \
//      -o article.pdf \
//      --pdf-engine=typst \
//      -V template=@local/MDTemp:1.0.0
//
// This template is a modification of John Maxwell's great template.
// See Also: https://imaginarytext.ca/posts/2025/typst-templates-for-pandoc/



// This bit from Pandoc, to help parse incoming metadata

#let content-to-string(content) = {
  if content.has("text") {
    content.text
  } else if content.has("children") {
    content.children.map(content-to-string).join("")
  } else if content.has("body") {
    content-to-string(content.body)
  } else if content == [ ] {
    " "
  }
}

#let conf(
  title: none,
  subtitle: none,
  authors: (),
  keywords: (),
  date: none,
  abstract: none,

  font: ("Noto Serif CJK JP",),
  sansfont: ("Noto Sans CJK JP",),
  monofont: ("Noto Sans Mono CJK JP",),
  fontsize: 11pt,

  lang: "ja",
  region: "JP",

  paper: "a4",
  margin: (top: 26mm, bottom: 21mm, left: 18mm, right: 18mm),

  cols: 2,

  sectionnumbering: none,
  pagenumbering: "1",

  doc,
) = {  set document(
    title: title,
    author: authors.map(author => content-to-string(author.name)),
    keywords: keywords,
  )
  set page(
    paper: paper,
    margin: margin,
    numbering: pagenumbering,
    columns: cols,

    // header
    header-ascent: 35% + 0pt,
    header: context {
      set text(9pt)
      if (here().page()) > 1 {
        // skip first page
        [
          #if title != none {
            title
          }
          #if subtitle != none {
            subtitle
          }
          #h(1fr)
          #if date != none {
            date
          }
        ]
      }
    },
  )

  // Text defaults
  //
  set text(
    lang: lang,
    region: region,
    font: font, // see 'conf' above
    size: fontsize,
    weight: "regular",
    spacing: 90%, // tighter than normal is nice
    alternates: false,
    discretionary-ligatures: false,
    historical-ligatures: false,
    number-type: "old-style",
    number-width: "proportional",
    cjk-latin-spacing: none,
  )

  show strong: set text(font: font) // settings for strong

  // Paragraph defaults
  //
  set par(
    spacing: 0.7em,
    leading: 0.7em,
    // fist-line-indent and justify are set below, just ahead of 'doc'
  )

  // Block quotations
  //
  set quote(block: true)
  show quote: set block(spacing: 18pt)
  show quote: set pad(x: 1.5em)
  show quote: set par(leading: 8pt)
  show quote: set text(style: "normal", rgb("#2c2c2c"))

  // Code blocks:
  //
  show raw: set block(inset: (left: 2em, top: 0em, right: 1em, bottom: 0em), outset: (x: 0em))
  show raw: set text(font: monofont)

  // Images and figures:
  //
  set image(fit: "contain")
  show image: it => {
    align(center, it)
  }
  set figure(gap: 1em, supplement: none, placement: none)
  show figure.caption: set text(size: 9pt) // how to set space below?
  show figure: set block(below: 1.5em)

  // Footnote formatting
  //
  set footnote.entry(indent: 0em)
  show footnote.entry: set par(spacing: 0.5em, justify: false)
  show footnote.entry: set par(hanging-indent: 0.4em) // needs work
  show footnote.entry: set text(size: 9pt, weight: 200)


  // HEADINGS
  //
  show heading: set text(hyphenate: false)
  set heading(numbering: sectionnumbering)

  show heading.where(level: 1): it => align(
    left,
    block(above: 24pt, below: 6pt, width: 100%)[
      #v(12pt) // space above
      #set par(leading: 16pt)
      #set text(font: font, weight: 400, style: "normal", size: 22pt) // settings for heading 1
      #block(it.body)
      #v(-6pt) // Reduce the distance between the heading and the horizontal line
      #line(start: (0%, 0%), end: (100%, 0%), stroke: 1pt + gray)
      #v(6pt) // space below

    ],
  )

  show heading.where(level: 2): it => align(
    left,
    block(above: 20pt, below: 12pt, width: 80%)[
      #set text(font: sansfont, weight: 400, size: 14pt) // settings for heading 2
      #block(it.body)
    ],
  )

  show heading.where(level: 3): it => align(
    left,
    block(above: 20pt, below: 10pt)[
      #set text(font: sansfont, weight: 400, size: 12pt, rgb("#181818")) // settings for heading 3
      #block([#smallcaps(all: true)[#it.body]])
    ],
  )

  // STYLING LABELLED SECTIONS
  //
  show <epigraph>: set text(rgb("#777"))
  show <epigraph>: set par(justify: false)

  show <refs>: set par(
    justify: false,
    spacing: 16pt,
    first-line-indent: 0em,
    hanging-indent: 2em,
    leading: 8pt,
  )
  show <refs>: set text(black) // for testing


  // STYLING SPECIFIC STRINGS OF TEXT
  //
  show "LaTeX": smallcaps
  show regex("https?://\S+"): set text(style: "normal", rgb("#33d"))


  // THIS IS THE TITLE BLOCK
  //
  if title != none {
    v(1em)
    set par(justify: false)
    align(
      left,
      text(size: 18pt)[
        #title #if subtitle != none [#subtitle]
      ],
    )
    v(1em)
    if authors != none {
      align(left, text(size: 12pt)[#authors.first().name])
    }
    if date != none {
      v(0.5em)
      align(left, text(size: 12pt)[#date])
    }
    if abstract != none {
      v(0.5em)
      align(left, text(size: 11pt, tracking: 0.05em)[ABSTRACT: ] + text(size: 11pt, style: "italic")[#abstract])
    }
    v(1em)
    line(start: (1%, 0%), end: (99%, 0%), stroke: 1pt + gray)
    v(4em)
  }


  // THIS IS THE ACTUAL BODY:


  counter(page).update(1) // re-set page numbering

  set par(justify: false) // default for the rest of the doc
  set par(
    first-line-indent: (
      // 'Jisage' for Japanese.
      amount: 1em,
      all: true,
    ),
  )

  doc // HERE is the actual body content


  // COLOPHON at the end

  v(1fr)
  align(center, text(size: 8pt, style: "italic")[Typeset from Markdown with open-source tools Pandoc and Typst.])
} // end 'let conf'
