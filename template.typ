#import "@preview/great-theorems:0.1.1": *
#import "@preview/rich-counters:0.2.1": *
#import "@preview/outrageous:0.3.0"

// Counter and blocks definitions
#let mathcounter = rich-counter(
  identifier: "mathblocks",
  inherited_levels: 1
)
#let mathblock = mathblock.with(breakable: false, counter: mathcounter)

#let definition = mathblock(blocktitle: "Définition")
#let notation = mathblock(blocktitle: "Notation")
#let theorem = mathblock(blocktitle: "Théoreme")
#let lemma = mathblock(blocktitle: "Lemme")
#let corollary = mathblock(blocktitle: "Corollaire")
#let proposition = mathblock(blocktitle: "Proposition")
#let example = mathblock(blocktitle: "Exemple")
#let remark = mathblock(blocktitle: "Remarque")
#let proof = mathblock(
  blocktitle: "Démonstration",
  prefix: [_Démonstration._],
  suffix: [#h(1fr) $square$],
  counter: none,
)

#let maths(title: none, authors: (), color: "#1C4C2D", header: false, date: false, body) = {
  // Document metadata
  set document(title: title, author: authors)

  // String for authors
  let authors = if type(authors) == "string" {
    authors
  } else {
    authors.join(" -- ")
  }

  // Page options
  set page(
    numbering: "1", 
    header: context { 
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
    }
  )

  // Text options
  set text(
    font: "TeX Gyre Pagella", 
    size: 11pt, 
    lang: "fr"
  )

  // Heading options
  set heading(numbering: "1.")

  // Paragraph options
  set par(justify: true)

  // Outline styling
  show outline.entry: it => {
    outrageous.show-entry(
      it, 
      font: (auto, none),
      font-weight: ("bold", auto),
      body-transform: (level, body) => text(rgb(color), body),
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
        text(size: 13pt)[#lower(datetime.today().display("[day] [month repr:long] [year]"))]
      }  
    ]
  )

  // Contents
  outline(indent: auto)
  pagebreak()

  body
}
