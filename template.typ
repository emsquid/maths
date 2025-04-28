#import "@preview/fletcher:0.5.2": *
#import "@preview/outrageous:0.4.0"
#import "@preview/rich-counters:0.2.2": *
#import "@preview/ez-today:1.1.0": *
#import "@local/touvlo:0.1.0": *
#import "@local/mathematica:0.1.0": *

// Counter and blocks definitions
#let mathscounter = rich-counter(identifier: "maths", inherited_levels: 1)
#let mathsbrick = brick.with(counter: mathscounter)
#let examplebrick = mathsbrick.with(
  bodyfmt: body => {
    set enum(numbering: "1.a.i.A.")
    body
  },
)
#let exercisecounter = rich-counter(identifier: "ex", inherited_levels: 0)
#let exercisebrick = brick.with(counter: exercisecounter)

#let axiom = mathsbrick("Axiome")
#let axioms = mathsbrick("Axiomes")
#let definition = mathsbrick("Définition")
#let notation = mathsbrick("Notation")
#let theorem = mathsbrick("Théorème")
#let lemma = mathsbrick("Lemme")
#let corollary = mathsbrick("Corollaire")
#let proposition = mathsbrick("Proposition")
#let remark = mathsbrick("Remarque")
#let example = examplebrick("Exemple")
#let examples = examplebrick("Exemples")
#let proof = proofbrick(
  [_Démonstration_.],
  of => [_Démonstration de #of._],
)

#let exercise = exercisebrick("Exercice")

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
      fill: (
        none,
        align(right, outrageous.repeat(text(black, $dot$), gap: 5pt)),
      ),
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

  // List/enum references
  show ref: it => {
    if (it.element != none and it.element.func() == enum.item) {
      let supplement = if it.citation.supplement != none {
        it.citation.supplement
      } else {
        context numbering(enum.numbering, it.element.number)
      }

      link(it.element.location(), supplement)
    } else if (it.element != none and it.element.func() == list.item) {
      let supplement = it.citation.supplement
      link(it.element.location(), supplement)
    } else if (it.element != none and it.element.func() == text) {
      let supplement = it.citation.supplement
      link(it.element.location(), supplement)
    } else {
      it
    }
  }

  // Maths
  show: touvlo-init

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
        text(size: 12pt)[#today(lang: "fr", format: "d M Y")]
      }
    ],
  )

  // Contents
  outline()

  body
}
