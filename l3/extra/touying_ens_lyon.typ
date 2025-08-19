#import "../../template.typ": *

#show: beamer.with(
  aspect-ratio: "16-9",
  footer: self => self.info.institution,
  config-colors(
    primary: rgb("#718355"),
    secondary: rgb("#5A6B44"),
  ),
  config-info(
    title: [Le problème du rectangle inscrit],
    author: [Emanuel Morille],
    date: [7 Juillet 2025],
  ),
)

#let superformula(
  m,
  n1,
  n2,
  n3,
  samples: 100,
) = (
  for x in range(0, samples + 1) {
    let x = 2 * calc.pi * x / samples
    let r = calc.pow(
      calc.pow(calc.abs(calc.cos(m * x / 4)), n2)
        + calc.pow(calc.abs(calc.sin(m * x / 4)), n3),
      -1 / n1,
    )

    ((r * calc.cos(x), r * calc.sin(x)),)
  }
)

#let superformula-3d(
  m,
  n1,
  n2,
  n3,
  samples: 100,
) = (
  for x in range(0, samples + 1) {
    let x = 2 * calc.pi * x / samples
    let r = calc.pow(
      calc.pow(calc.abs(calc.cos(m * x / 4)), n2)
        + calc.pow(calc.abs(calc.sin(m * x / 4)), n3),
      -1 / n1,
    )

    ((r * calc.cos(x), 0, r * calc.sin(x)),)
  }
)

== Introduction

#slide([
  #align(center + horizon)[
    _"Toute courbe de Jordan admet-elle un #alternatives[carré][#strike("carré") rectangle] inscrit ?"_
  ]
])

== Définitions

#slide([
  #alternatives[
    #slide-definition([
      Une partie $C$ de $RR^2$ est une _courbe de Jordan_ s'il existe une application continue $func(gamma, [0, 1], RR^2)$ :
      - $C$ est une courbe : $im(gamma) = C$.
      - $C$ est fermée : $gamma(0) = gamma(1)$.
      - $C$ est simple : $gamma$ est injective sur $[0, 1[$.
    ])

  ][
    #slide-definition([
      Un rectangle $(a, b, c, d)$ de $RR^2$ est _inscrit dans une courbe de Jordan $C$_ si $a, b, c, d in C$.
    ])
  ]

  #place(center + bottom, dy: -20pt)[
    #touying-canvas({
      import cetz.draw: *

      let r = 3
      circle((0, 0), radius: r, stroke: 1.5pt)

      let j = superformula(7, 3, 4, 10, samples: 1000).map(it => (
        10.5 + 2 * it.at(0),
        2 * it.at(1),
      ))
      line(
        ..j,
        stroke: 1.5pt,
        close: true,
      )

      (pause,)

      set-style(circle: (radius: 0.05, fill: red, stroke: red))
      line(
        (r * calc.cos(calc.pi / 4), r * calc.sin(calc.pi / 4)),
        (r * calc.cos(3 * calc.pi / 4), r * calc.sin(3 * calc.pi / 4)),
        (r * calc.cos(5 * calc.pi / 4), r * calc.sin(5 * calc.pi / 4)),
        (r * calc.cos(7 * calc.pi / 4), r * calc.sin(7 * calc.pi / 4)),
        (r * calc.cos(calc.pi / 4), r * calc.sin(calc.pi / 4)),
        stroke: 1.5pt + green,
        close: true,
      )
      circle((r * calc.cos(calc.pi / 4), r * calc.sin(calc.pi / 4)))
      circle((r * calc.cos(3 * calc.pi / 4), r * calc.sin(3 * calc.pi / 4)))
      circle((r * calc.cos(5 * calc.pi / 4), r * calc.sin(5 * calc.pi / 4)))
      circle((r * calc.cos(7 * calc.pi / 4), r * calc.sin(7 * calc.pi / 4)))

      let a = j.at(179)
      let b = j.at(353)
      let c = j.at(622)
      let d = j.at(841)
      line(a, b, c, d, a, stroke: 1.5pt + green, close: true)
      circle(a)
      circle(b)
      circle(c)
      circle(d)
    })
  ]
])

== Théorème

#slide([
  #align(horizon)[
    #slide-theorem([
      Toute courbe de Jordan admet un rectangle inscrit.
    ])
    Dans la suite on considère une courbe de Jordan $C$.
  ]
])

== Reformulation

#slide([
  On représente un rectangle par 2 paires de sommets de $C times C$ formant les diagonales :

  #v(-15pt)

  #align(center)[
    #touying-canvas({
      import cetz.draw: *

      set-style(
        stroke: (cap: "round", join: "round"),
        mark: (transform-shape: false, anchor: "center"),
      )
      line((0, 0), (8, 3), stroke: 1.5pt + red)
      line((0, 3), (8, 0), stroke: 1.5pt + blue)
      line((0, 0), (8, 0), (8, 3), (0, 3), (0, 0), stroke: 1.5pt)

      set-style(content: (padding: 0.4))
      content((0, 3), text($a$, blue), anchor: "east")
      content((8, 3), text($b$, red), anchor: "west")
      content((8, 0), text($c$, blue), anchor: "west")
      content((0, 0), text($d$, red), anchor: "east")

      set-style(circle: (radius: 0.05))
      circle((0, 0), fill: red, stroke: red)
      circle((8, 3), fill: red, stroke: red)
      circle((8, 0), fill: blue, stroke: blue)
      circle((0, 3), fill: blue, stroke: blue)

      (pause,)

      line((2, 2.1), (2.1, 2.35), stroke: 1.5pt + green)
      line((2.1, 2.06), (2.2, 2.31), stroke: 1.5pt + green)
      line((5.8, 0.69), (5.9, 0.94), stroke: 1.5pt + green)
      line((5.9, 0.65), (6, 0.90), stroke: 1.5pt + green)

      line((2, 0.9), (2.1, 0.65), stroke: 1.5pt + green)
      line((2.1, 0.94), (2.2, 0.69), stroke: 1.5pt + green)
      line((5.8, 2.31), (5.9, 2.06), stroke: 1.5pt + green)
      line((5.9, 2.35), (6, 2.1), stroke: 1.5pt + green)

      circle((4, 1.5), fill: green, stroke: green)
    })
  ]

  #v(-15pt)

  #slide-proposition([
    2 paires de sommets de $C times C$ #underline([non-ordonnées]) forment un rectangle si et seulement si elles sont distinctes, ont le même milieu et ont la même distance.
  ])

  #pause

  #slide-remark([
    2 paires de sommets ordonnées pourraient être distinctes et former la même diagonale,
    pour éviter ça on étudie le quotient $Q$ de $C times C$ par la relation d'équivalence $(a, b) tilde (b, a)$.
  ])
])

== Réinterprétation

#slide([
  On définit une application qui regroupe ces informations :
  $
    func(f, C times C, RR^2 times RR tilde.eq RR^3, (u, v), ((u + v)/2, d(u, v)))
  $

  #pause

  Elle décrit une surface dans $RR^3$ :
  #align(center)[
    #touying-canvas({
      import cetz.draw: *

      set-style(
        stroke: (cap: "round", join: "round"),
        mark: (transform-shape: false, anchor: "center", fill: black),
      )
      line((-3.5, 0, 0), (3.5, 0, 0), mark: (end: "stealth"), stroke: 1.5pt)
      line((0, -2, 0), (0, 3.5, 0), mark: (end: "stealth"), stroke: 1.5pt)
      line((0, 0, -3.5), (0, 0, 3.5), mark: (end: "stealth"), stroke: 1.5pt)
      let jc = superformula-3d(
        7,
        3,
        4,
        10,
        samples: 1000,
      ).map(it => it.map(e => 1.75 * e))
      line(..jc, close: true, stroke: 1.5pt)

      line(
        (-1.9, 0, -0.44),
        (1.15, 0, 1.33),
        stroke: (dash: "dashed", paint: red, thickness: 1.5pt),
      )
      line(
        (-0.375, 0, 0.445),
        (-0.375, 3.18, 0.445),
        stroke: (dash: "dashed", paint: blue, thickness: 1.5pt),
      )

      set-style(circle: (radius: 0.05, fill: red, stroke: red))
      circle((-1.9, 0, -0.44))
      circle((1.15, 0, 1.33))
      circle((-0.375, 0, 0.445), fill: blue, stroke: blue)
      circle((-0.375, 3.18, 0.445), fill: blue, stroke: blue)

      set-style(content: (padding: 0.2))
      content((-1.9, 0, -0.44), $u$, anchor: "south-east")
      content((1.15, 0, 1.33), $v$, anchor: "north-west")
      content(
        (-0.375, 3.18, 0.445),
        $f(u, v)$,
        anchor: "south-east",
      )
    })
  ]
  #pause

  - $f$ est continue.
  - $f$ passe au quotient pour $~$ et induit une application continue $func(phi, Q, RR^3)$.
])

#slide([
  #align(horizon)[
    #slide-proposition([
      2 paires de sommets $p, q in Q$ forment un rectangle si et seulement si $p != q$ et $phi(p) = phi(q)$.
    ])

    Donc la courbe de Jordan $C$ admet un rectangle inscrit si et seulement si $phi$ n'est pas injective.
  ]
])

== Paramétrage

#slide([
  Dans la suite on suppose par l'absurde que $phi$ est injective.

  Puisque $Q$ est compact et que la restriction $func(phi, Q, phi(Q))$ est une bijection continue, on en déduit que $func(phi, Q, phi(Q))$ est un homéomorphisme.

  #pause

  Par définition $C$ est paramétrée par une application continue $func(gamma, [0, 1], RR^2)$, donc on peut paramétrer $Q$ par l'application continue $func(mu := overline((gamma, gamma)), [0, 1]^2, lquotient((RR^2 times RR^2), thin~))$ :
  #align(center)[
    #touying-canvas({
      import cetz.draw: *

      let j = superformula(7, 3, 4, 10, samples: 1000).map(it => (
        13 + 2 * it.at(0),
        2 * it.at(1),
      ))

      line(
        (0, -2.5),
        (0, 2.5),
        (5, 2.5),
        (5, -2.5),
        (0, -2.5),
        fill: luma(50%, 30%),
        stroke: 1.5pt,
        close: true,
      )

      line(
        (6, 0),
        (9, 0),
        mark: (end: "stealth", fill: black, scale: 1.5),
        stroke: 1.5pt,
      )

      line(..j, stroke: 1.5pt, close: true)

      set-style(circle: (radius: 0.05, fill: red, stroke: red))

      circle((1, 0.5))
      circle(j.at(185))
      circle(j.at(600))

      set-style(content: (padding: 0.2))
      content((0, -2.5), $0$, anchor: "north-east", padding: 0.1)
      content((5, -2.5), $1$, anchor: "north")
      content((0, 2.5), $1$, anchor: "east")

      content((7.5, 0), $mu$, anchor: "south")

      content((1, 0.5), $(0.2, 0.6)$, anchor: "north-west")
      content(j.at(185), $gamma(0.2)$, anchor: "west")
      content(j.at(600), $gamma(0.6)$, anchor: "east")
    })
  ]
])

#slide([
  Mais il y a 2 problèmes avec ce paramétrage :
  - Puisque $gamma(0) = gamma(1)$, on a $mu(0, t) = mu(1, t)$ et $mu(t, 0) = mu(t, 1)$.
  - Puisque les paires sont non-ordonnées, on a $mu(a, b) = mu(b, a)$.

  #pause

  Pour régler ces problèmes on étudie le quotient de $[0, 1]^2$ par les relations d'équivalences :
  - $(0, t) attach(~, br: 1) (1, t)$ et $(t, 0) attach(~, br: 1) (t, 1)$,
  #uncover("3-")[- et $(a, b) attach(~, br: 2) (b, a).$]

  #alternatives[#v(-11pt)][]

  #align(center)[
    #touying-canvas({
      import cetz.draw: *

      set-style(
        stroke: (cap: "round", join: "round", thickness: 1.5pt),
        mark: (anchor: "center", fill: black, scale: 1.5),
        content: (padding: 0.2),
      )

      line((0, 0), (0, 5), (5, 5), (5, 0), (0, 0), fill: luma(50%, 30%))

      content((0, 0), $0$, anchor: "north-east", padding: 0.1)
      content((0, 5), $1$, anchor: "east")
      content((5, 0), $1$, anchor: "north")

      line(
        (5.5, 2.5),
        (8.5, 2.5),
        mark: (end: "stealth"),
        stroke: 1.5pt,
      )
      content((7, 2.5), $attach(~, br: 1)$, anchor: "south")

      line(
        (9, 0),
        (9, 5),
        (14, 5),
        (14, 0),
        (9, 0),
        fill: luma(50%, 30%),
        stroke: none,
      )
      line((9, 0), (9, 5), stroke: (dash: "dashed", paint: blue))
      line((14, 5), (14, 0), stroke: (dash: "dashed", paint: blue))
      line((9, 5), (14, 5), stroke: (dash: "dashed", paint: red))
      line((14, 0), (9, 0), stroke: (dash: "dashed", paint: red))

      content((9, 0), $0$, anchor: "north-east", padding: 0.1)
      content((9, 5), $1$, anchor: "east")
      content((14, 0), $1$, anchor: "north")

      set-style(mark: (symbol: "stealth"))
      mark((9, 2.5), 90deg, stroke: blue, fill: blue)
      mark((14, 2.5), 90deg, stroke: blue, fill: blue)
      mark((11.5, 0), 0deg, stroke: red, fill: red)
      mark((11.5, 5), 0deg, stroke: red, fill: red)

      (pause,)

      set-style(mark: (symbol: none))
      line(
        (14.5, 2.5),
        (17.5, 2.5),
        mark: (end: "stealth"),
        stroke: 1.5pt,
      )
      content((16, 2.5), $attach(~, br: 2)$, anchor: "south")

      line((18, 0), (23, 0), (23, 5), fill: luma(50%, 30%))
      line((18, 0), (23, 5), stroke: (dash: "dashed", paint: red))

      content((18, 0), $0$, anchor: "north")
      content((23, 0), $1$, anchor: "north")

      set-style(mark: (symbol: "stealth", scale: 1.5))
      mark((20.5, 0), 0deg, stroke: purple, fill: purple)
      mark((23, 2.5), 90deg, stroke: purple, fill: purple)
    })
  ]
])

#slide([
  On découpe le triangle pour recoller les flèches :
  #align(center)[
    #touying-canvas({
      import cetz.draw: *

      set-style(
        stroke: (cap: "round", join: "round", thickness: 1.5pt),
        mark: (
          transform-shape: false,
          anchor: "center",
          fill: black,
          scale: 1.5,
        ),
        content: (padding: 0.2),
      )

      line((2.5, 2.5), (5, 0), stroke: (dash: "dashed", paint: blue))
      line((0, 0), (5, 0), (5, 5), (0, 0), fill: luma(50%, 30%))

      content((0, 0), $0$, anchor: "north")
      content((5, 0), $1$, anchor: "north")

      line((5.5, 2.5), (8.5, 2.5), mark: (symbol: "stealth"), stroke: 1.5pt)

      line(
        (14, 2.5),
        (11.5, 5),
        (9, 2.5),
        (11.5, 0),
        fill: luma(50%, 30%),
        stroke: none,
      )
      line((14, 2.5), (11.5, 5), stroke: (dash: "dashed", paint: blue))
      line((9, 2.5), (11.5, 5))
      line((14, 2.5), (11.5, 0))
      line((9, 2.5), (11.5, 0), stroke: (dash: "dashed", paint: blue))
      line((11.5, 0), (11.5, 5))

      set-style(mark: (symbol: "stealth"))
      mark((3.75, 1.25), -45deg, stroke: blue, fill: blue)
      mark((5, 2.5), 90deg, stroke: purple, fill: purple)
      mark((2.5, 0), 0deg, stroke: purple, fill: purple)

      mark((11.5, 2.5), 90deg, stroke: purple, fill: purple)
      mark((10.25, 1.25), -45deg, stroke: blue, fill: blue)
      mark((12.75, 3.75), 135deg, stroke: blue, fill: blue)

      (pause,)

      let mobius(rt) = {
        for t in range(rt + 1) {
          t = 4 * calc.pi * t / rt
          (
            (
              (2 - 1 * calc.sin(t / 2)) * calc.sin(t),
              (2 - 1 * calc.sin(t / 2)) * calc.cos(t),
              1 * calc.cos(t / 2),
            ),
          )
        }
      }

      let m = mobius(1000).map(it => (
        it.at(0) * 0.75 + 20.5,
        it.at(1) * 0.75 + 2.5,
        it.at(2) * 0.75,
      ))

      set-style(mark: (symbol: none))

      line((14.5, 2.5), (17.5, 2.5), mark: (symbol: "stealth"), stroke: 1.5pt)

      line(m.at(200), m.at(720), stroke: (dash: "dashed", paint: blue))
      line(
        ..m.slice(435, 950),
        m.at(480),
        ..m.slice(435, 480).rev(),
        ..m.slice(0, 435).rev(),
        ..m.slice(992, 1001).rev(),
        fill: luma(50%, 30%),
      )
      set-style(mark: (symbol: "stealth"))
      mark((21.12, 1.10), -65deg, stroke: blue, fill: blue)
    })
  ]
  et on obtient une bande de Möbius $M$.
  #pause
  - Les déformations sont continues.
  - $mu$ passe au quotient pour $attach(~, br:1)$ et $attach(~, br: 2) thin$, et induit un homéomorphisme $func(lambda, M, Q)$.
  Par composition $func(phi compose lambda, M, phi(Q))$ est un homéomorphisme.
])

== Absurdité

#slide([
  L'application $phi compose lambda$ vérifie $(phi compose lambda)(partial M) = C subset RR^3$ :
  #align(center)[
    #touying-canvas({
      import cetz.draw: *

      set-style(
        stroke: (cap: "round", join: "round", thickness: 1.5pt),
        mark: (
          transform-shape: false,
          anchor: "center",
          fill: black,
          scale: 1.5,
        ),
        content: (padding: 0.2),
      )

      let mobius(rt) = {
        for t in range(rt + 1) {
          t = 4 * calc.pi * t / rt
          (
            (
              (2 - 1 * calc.sin(t / 2)) * calc.sin(t),
              (2 - 1 * calc.sin(t / 2)) * calc.cos(t),
              1 * calc.cos(t / 2),
            ),
          )
        }
      }

      let m = mobius(1000).map(it => (
        it.at(0) * 0.75 + 3.5,
        it.at(1) * 0.75 + 2.5,
        it.at(2) * 0.75,
      ))

      line(
        ..m.slice(435, 950),
        m.at(480),
        ..m.slice(435, 480).rev(),
        ..m.slice(0, 435).rev(),
        ..m.slice(992, 1001).rev(),
        fill: luma(50%, 30%),
        stroke: (dash: "dashed", paint: red),
      )

      line((6.5, 2.5), (9.5, 2.5), mark: (symbol: "stealth"))

      line((9, 0), (14, 0), (14, 5), fill: luma(50%, 30%))
      line((9, 0), (14, 5), stroke: (dash: "dashed", paint: red))

      content((9, 0), $0$, anchor: "north")
      content((14, 0), $1$, anchor: "north")


      line((14.5, 2.5), (17.5, 2.5), mark: (symbol: "stealth"))

      line((18.5, 2, 0), (24.5, 2, 0), mark: (end: "stealth"))
      line((22, 0, 0), (22, 5.5, 0), mark: (end: "stealth"))
      line((22, 2, -3.5), (22, 2, 3.5), mark: (end: "stealth"))

      let jc = superformula-3d(
        7,
        3,
        4,
        10,
        samples: 1000,
      ).map(it => (it.at(0) * 1.75 + 22, it.at(1) * 1.75 + 2, it.at(2) * 1.75))
      line(..jc, close: true, stroke: (dash: "dashed", paint: red))

      set-style(circle: (radius: 0.05, fill: red, stroke: red))

      set-style(mark: (symbol: "stealth"))

      mark((14, 2.5), 90deg, stroke: purple, fill: purple)
      mark((11.5, 0), 0deg, stroke: purple, fill: purple)

      content((2, 4.25), $partial M$)
      content((20.25, 2.75), $C$)
    })
  ]

  #pause

  De plus $C$ est homéomorphe à $SS^1$ et la partie $D$ de $RR^2$ délimitée par $C$ est homéomorphe à $BB^2$. \
  L'espace obtenu en recollant la bande de Möbius $M$ à $D$ le long de leur bord $C$ est homéomorphe au plan projectif réel $PP^2_RR$.
  Donc $phi compose lambda$ induit un plongement du plan projectif réel $PP^2_RR$ dans $RR^3$.

  Mais il n'existe pas de plongement du plan projectif réel $PP^2_RR$ dans $RR^3$, d'où une contradiction !
])

== Conclusion

#slide([
  Donc $phi$ n'est pas injective et la courbe de Jordan $C$ admet un rectangle inscrit.
  #align(center + horizon)[

    #touying-canvas({
      import cetz.draw: *

      let j = superformula(7, 3, 4, 10, samples: 1000).map(it => (
        3 * it.at(0),
        3 * it.at(1),
      ))

      line(
        ..j,
        stroke: 1.5pt,
        close: true,
      )

      let a = j.at(179)
      let b = j.at(353)
      let c = j.at(622)
      let d = j.at(841)

      set-style(circle: (radius: 0.05, fill: red, stroke: red))

      line(a, b, c, d, a, stroke: 1.5pt + green, close: true)
      circle(a)
      circle(b)
      circle(c)
      circle(d)
    })
  ]
])
