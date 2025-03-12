#import "@preview/fletcher:0.5.2": *
#import "@preview/great-theorems:0.1.2": *
#import "@preview/outrageous:0.4.0"
#import "@preview/rich-counters:0.2.2": *
#import "@local/mathematica:0.1.0": *

// Counter and blocks definitions
#let coursecounter = rich-counter(identifier: "maths", inherited_levels: 1)
#let courseblock = mathblock.with(
  breakable: false,
  counter: coursecounter,
)
#let exampleblock = mathblock.with(
  breakable: true,
  counter: coursecounter,
  bodyfmt: body => {
    set enum(numbering: "1.a.i.A.")
    body
  },
)
#let exercisecounter = rich-counter(identifier: "ex", inherited_levels: 0)
#let exerciseblock = mathblock.with(
  breakable: false,
  counter: exercisecounter,
)

#let definition = courseblock(blocktitle: "Définition")
#let notation = courseblock(blocktitle: "Notation")
#let theorem = courseblock(blocktitle: "Théorème")
#let lemma = courseblock(blocktitle: "Lemme")
#let corollary = courseblock(blocktitle: "Corollaire")
#let proposition = courseblock(blocktitle: "Proposition")
#let example = exampleblock(blocktitle: "Exemple")
#let examples = exampleblock(blocktitle: "Exemples")
#let remark = courseblock(blocktitle: "Remarque")
#let proof = proofblock(prefix: [_Démonstration_.])

#let exercise = exerciseblock(blocktitle: "Exercice")

// Maths shortcuts
#let scr(it) = text(
  features: ("ss01",),
  box($cal(it)$),
)

#let underbraced(body, text) = $attach(limits(underbrace(#body)), b: #text)$

#let maths(
  title: none,
  authors: (),
  color: none,
  header: false,
  date: false,
  body,
) = {
  // Document metadata
  set document(title: title, author: authors)

  // String for authors
  authors = if type(authors) == str {
    authors
  } else {
    authors.join(" -- ")
  }

  if color == none {
    color = black
  }

  // Page options
  set page(
    numbering: "1",
    header: context {
      if header and counter(page).get().first() > 1 {
        align(
          center,
          if title != "" and authors != "" {
            [#title -- #authors]
          } else if title != "" {
            title
          } else {
            ""
          },
        )
        line(start: (0%, -8pt), length: 100%, stroke: 0.5pt)
        v(-10pt)
      }
    },
  )

  // Text options
  set text(
    font: "STIX Two Text",
    size: 11pt,
    lang: "fr",
  )

  show math.equation: set text(font: "STIX Two Math")

  // Heading options
  set heading(numbering: "1.")

  // Enum options
  set enum(numbering: "(1.a.i.A)")

  // Paragraph options
  set par(justify: true)

  // Outline styling
  show outline.entry: it => {
    outrageous.show-entry(
      it,
      font: (auto,),
      font-weight: ("bold", auto),
      fill: (none, align(right, outrageous.repeat(text(black, $dot$), gap: 5pt))),
      body-transform: (level, prefix, body) => text(rgb(color), body),
      page-transform: (level, page) => text(black, page),
    )
  }

  // Center maths block in list
  show math.equation.where(block: true): it => {
    block(width: 100%, inset: 0em, [#align(center)[#it]])
  }

  // // Unbreakable math equation
  // show math.equation.where(block: false): box

  // Link colors
  show link: it => text(rgb(color), it)

  // Maths
  show: great-theorems-init

  // Title
  align(
    center,
    [
      #text(size: 26pt)[#title]
      #if authors != none {
        v(-12pt)
        text(size: 13pt)[#authors]
      }
      #v(0pt)
      #if date {
        text(size: 13pt)[#lower(
            datetime.today().display("[day] [month repr:long] [year]"),
          )]
      }
    ],
  )

  // Contents
  outline()
  pagebreak()

  body
}
