#import "@preview/great-theorems:0.1.1": *
#import "@preview/rich-counters:0.2.2": *
#import "@preview/fletcher:0.5.2": *
#import "@preview/outrageous:0.3.0"

// Counter and blocks definitions
#let mathcounter = rich-counter(identifier: "maths", inherited_levels: 1)
#let mathblock = mathblock.with(
  breakable: false,
  counter: mathcounter,
)

#let definition = mathblock(blocktitle: "Définition")
#let notation = mathblock(blocktitle: "Notation")
#let theorem = mathblock(blocktitle: "Théorème")
#let lemma = mathblock(blocktitle: "Lemme")
#let corollary = mathblock(blocktitle: "Corollaire")
#let proposition = mathblock(blocktitle: "Proposition")
#let example = mathblock(blocktitle: "Exemple")
#let remark = mathblock(blocktitle: "Remarque")
#let proof = proofblock(prefix: [_Démonstration_.])

// Maths shortcuts
#let scr(it) = text(
  features: ("ss01",),
  box($cal(it)$),
)
#let gen(..generators) = $angle.l #generators.pos().join(", ") angle.r$
#let qt(numerator, denominator) = $#numerator slash #denominator$
#let qtr(numerator, denominator) = $#denominator thin backslash thin #numerator$
#let fun(f, E, F, x: none, fx: none) = (
  if x == none or fx == none {
    $#f : #E -> #F$
  } else {
    $#f : #E -> #F, #x |-> #fx$
  }
)
#let pgcd = "pgcd"
#let ppcm = "ppcm"
#let ord = "ord"
#let sign = "sign"
#let supp = "supp"
#let Vect = "Vect"
#let Sp = "Sp"
#let act = rotate(180deg, $arrow.cw$)
#let GL = "GL"
#let transpose(M) = $#M^upright(T)$
#let ind(E) = $bb(1)_#E$
#let sca(x, y) = $angle.l #x, #y angle.r$

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
  authors = if type(authors) == "string" {
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
    font: "TeX Gyre Pagella",
    size: 11pt,
    lang: "fr",
  )

  // Heading options
  set heading(numbering: "1.1.")

  // Paragraph options
  set par(justify: true)

  // Outline styling
  show outline.entry: it => {
    outrageous.show-entry(
      it,
      font: (auto, none),
      font-weight: ("bold", auto),
      body-transform: (level, body) => text(rgb(color), body),
      fill: (none, align(right, outrageous.repeat(gap: 5pt)[$dot$])),
    )
  }

  // Center maths block in list
  show math.equation.where(block: true): it => {
    block(width: 100%, inset: 0em, [#align(center)[#it]])
  }

  // Unbreakable math equation
  show math.equation.where(block: false): box

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
  outline(indent: auto)
  pagebreak()

  body
}
