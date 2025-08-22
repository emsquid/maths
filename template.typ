#import "@preview/commute:0.3.0": *
#import "@preview/outrageous:0.4.0"
#import "@preview/headcount:0.1.0": *
#import "@preview/ez-today:1.1.0": *
#import "@preview/cetz:0.3.4"
#import "@preview/touying:0.6.1": *
#import "@local/touvlo:0.1.0": *
#import "@local/mathematica:0.1.0": *

// Counter and blocks definitions
#let mathscounter = counter("maths")
#let mathsbrick = brick.with(
  counter: mathscounter,
  numbering: dependent-numbering("1.1", levels: 1),
)
#let examplebrick = mathsbrick.with(bodyfmt: body => {
  set enum(numbering: "1.a.i.A.")
  body
})
#let questioncounter = counter("qst")
#let questionbrick = brick.with(
  counter: questioncounter,
  numbering: dependent-numbering("1.1", levels: 0),
)
#let exercisecounter = counter("ex")
#let exercisebrick = brick.with(
  counter: exercisecounter,
  numbering: dependent-numbering("1.1", levels: 0),
)

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
#let proof = proofbrick("Démonstration")

#let question = questionbrick("Question")
#let exercise = exercisebrick("Exercice")

// Maths shortcuts
#let scr(it) = text(features: ("ss01",), box($cal(it)$))

#let underbraced(body, text) = $attach(limits(underbrace(#body)), b: #text)$

#let maths(
  title: none,
  authors: (),
  note: none,
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
  set page(numbering: "1", header: context {
    if header and counter(page).get().first() > 1 {
      align(center, if title != "" and authors != "" {
        [#title -- #authors]
      } else if title != "" {
        title
      } else {
        ""
      })
      line(start: (0%, -8pt), length: 100%, stroke: 0.5pt)
      v(-10pt)
    }
  })

  // Text options
  set text(
    font: "STIX Two Text",
    size: 11pt,
    lang: "fr",
  )

  show math.equation: set text(font: "STIX Two Math")
  show math.equation.where(block: true): set block(above: 10pt, below: 10pt)
  // Center maths block in list
  show math.equation.where(block: true): it => {
    block(width: 100%, inset: 0em, [#align(center)[#it]])
  }

  // Heading options
  set heading(numbering: "1.")
  show heading: reset-counter(mathscounter, levels: 1)
  show heading: reset-counter(questioncounter, levels: 1)
  show heading: reset-counter(exercisecounter, levels: 1)

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


  // // Unbreakable math equation
  // show math.equation.where(block: false): box

  // Link colors
  show link: it => text(rgb(color), it)
  show ref: it => text(rgb(color), it)

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
  align(center, {
    text(size: 26pt)[#title]
    if authors != none {
      v(-12pt)
      text(size: 13pt)[#authors]
    }
    if note != none {
      v(0pt)
      text(size: 13pt)[#note]
    }
    v(0pt)
    if date {
      text(size: 12pt)[#today(lang: "fr", format: "d M Y")]
    }
  })

  // Contents
  outline()

  body
}

#let header(self) = {
  set align(top)
  show: components.cell.with(fill: self.colors.primary, inset: 1em)
  set align(horizon)
  set text(fill: self.colors.neutral-lightest, size: .7em)
  set text(size: 2em)
  if self.store.title != none {
    utils.call-or-display(self, self.store.title)
  } else {
    utils.display-current-heading(level: 2)
  }
}

#let footer(self) = {
  set align(bottom)
  show: components.side-by-side(
    gutter: 0em,
    {
      show: components.cell.with(fill: self.colors.primary, inset: 1em)
      set text(
        fill: self.colors.neutral-lightest,
        size: .7em,
        weight: "semibold",
      )
      set align(horizon)
      h(1fr)
      self.info.author
    },
    {
      show: components.cell.with(fill: self.colors.secondary, inset: 1em)
      set text(
        fill: self.colors.neutral-lightest,
        size: .7em,
        weight: "semibold",
      )
      set align(horizon)
      self.info.title
      h(1fr)
      context utils.slide-counter.display() + " / " + utils.last-slide-number
    },
  )
  utils.call-or-display(self, self.store.footer)
}

#let slide(title: auto, ..args) = touying-slide-wrapper(self => {
  if title != auto {
    self.store.title = title
  }
  self = utils.merge-dicts(self, config-page(
    header: header,
    footer: footer,
  ))
  touying-slide(self: self, ..args)
})

#let title-slide(..args) = touying-slide-wrapper(self => {
  let info = self.info + args.named()
  let body = {
    set align(center + horizon)
    v(-1em)
    block(fill: self.colors.secondary, inset: 2em, radius: 0.5em, text(
      size: 2em,
      fill: self.colors.neutral-lightest,
      weight: "bold",
      info.title,
    ))
    set text(fill: self.colors.neutral-darkest)
    if info.date != none {
      block(utils.display-info-date(self))
    }
  }
  self = utils.merge-dicts(self, config-page(footer: footer))
  touying-slide(self: self, body)
})

#let slide-brick(kind, col, body) = {
  align(center, block(width: 100%, radius: 7pt, align(left, grid(
    rows: 2,
    block(width: 100%, radius: (top: 7pt), inset: 0.5em, fill: col, text(
      kind,
      white,
    )),
    block(
      width: 100%,
      radius: (bottom: 7pt),
      inset: 0.5em,
      fill: rgb(..col.components().slice(0, 3), 15%),
      body,
    ),
  ))))
}

#let slide-definition(body) = slide-brick("Définition", rgb("#718355"), body)
#let slide-theorem(body) = slide-brick("Théorème", rgb("#A1534A"), body)
#let slide-lemma(body) = slide-brick("Lemme", rgb("#A1534A"), body)
#let slide-proposition(body) = slide-brick("Proposition", rgb("#4C6C8A"), body)
#let slide-remark(body) = slide-brick("Remarque", rgb("#C2A34A"), body)

#let touying-canvas = touying-reducer.with(
  reduce: cetz.canvas,
  cover: cetz.draw.hide.with(bounds: true),
)


#let beamer(
  aspect-ratio: "16-9",
  footer: none,
  ..args,
  body,
) = {
  set text(
    font: "Source Sans 3",
    size: 20pt,
    lang: "fr",
  )
  show math.equation: set text(font: "STIX Two Math")

  set par(justify: true)

  show: touying-slides.with(
    config-page(paper: "presentation-" + aspect-ratio, margin: (
      top: 3.5em,
      bottom: 1.5em,
      x: 1em,
    )),
    config-common(slide-fn: slide),
    config-methods(alert: utils.alert-with-primary-color),
    config-store(
      title: none,
      footer: footer,
    ),
    ..args,
  )

  title-slide()

  body
}
