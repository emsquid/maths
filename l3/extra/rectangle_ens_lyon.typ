#import "../../template.typ": *

#set-maths(sequence: (ind: $n$, dom: $ZZ$))

#let cdot = $circle.filled.tiny$

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

#show: maths.with(
  title: "Le problème du rectangle inscrit",
  authors: ("Emanuel Morille",),
  color: "#718355",
)

#pagebreak()

#heading([Introduction], numbering: none)

L'origine de ce sujet est le _problème du carré inscrit_, énoncé par #link("https://fr.wikipedia.org/wiki/Otto_Toeplitz")[Otto Toeplitz] en 1911 :

#align(center)[_"Toute courbe de Jordan admet-elle un carré inscrit ?"_]

Cette question fut l'objet de nombreuses recherches, mais elle n'est toujours pas résolue, en revanche nous sommes capables de répondre à une version simplifiée :

#align(center)[_"Toute courbe de Jordan admet-elle un #strike("carré") rectangle inscrit ?"_]

Nous l'appellerons le _problème du rectangle inscrit_.

Dans le cas d'un cercle, on trouve une infinité de carrés inscrits, le problème est plus difficile lorsque la courbe est quelconque :

#grid(
  align: horizon,
  columns: (1fr, 1fr),
  rows: auto,
  [
    #figure(
      align(center)[#cetz.canvas({
          import cetz.draw: *

          let r = 1.58
          circle((0, 0), radius: r)
          line(
            (r * calc.cos(calc.pi / 4), r * calc.sin(calc.pi / 4)),
            (r * calc.cos(3 * calc.pi / 4), r * calc.sin(3 * calc.pi / 4)),
            (r * calc.cos(5 * calc.pi / 4), r * calc.sin(5 * calc.pi / 4)),
            (r * calc.cos(7 * calc.pi / 4), r * calc.sin(7 * calc.pi / 4)),
            (r * calc.cos(calc.pi / 4), r * calc.sin(calc.pi / 4)),
            stroke: green,
          )
          set-style(circle: (radius: 0.03, fill: red, stroke: red))
          circle((r * calc.cos(calc.pi / 4), r * calc.sin(calc.pi / 4)))
          circle((r * calc.cos(3 * calc.pi / 4), r * calc.sin(3 * calc.pi / 4)))
          circle((r * calc.cos(5 * calc.pi / 4), r * calc.sin(5 * calc.pi / 4)))
          circle((r * calc.cos(7 * calc.pi / 4), r * calc.sin(7 * calc.pi / 4)))
        })
      ],
    ) <fig-cercle-carre>
  ],
  [
    #figure(
      align(center)[#cetz.canvas({
          import cetz.draw: *

          line(..superformula(7, 3, 4, 10, samples: 1000), close: true)
          set-style(circle: (radius: 0.03, fill: red, stroke: red))
          line(
            (0.56, 1.17),
            (0.56, -0.85),
            (-0.89, -0.85),
            (-0.89, 1.17),
            (0.56, 1.17),
            stroke: green,
          )
          circle((0.56, 1.17))
          circle((0.56, -0.85))
          circle((-0.89, -0.85))
          circle((-0.89, 1.17))
        })
      ],
    ) <fig-courbe-rectangle>
  ],
)

Dans la suite, nous allons étudier l'homologie singulière et le plan projectif réel. Commençons par définir les notions du sujet.

#definition(
  number: none,
  [
    _Une courbe de Jordan_ est une partie $C$ de $RR^2$ pour laquelle il existe une application continue $func(gamma, [0, 1], RR^2)$ telle que :
    - $C$ est une courbe : $im(gamma) = C$.
    - $C$ est fermée : $gamma(0) = gamma(1)$.
    - $C$ est simple : $gamma$ est injective sur $[0, 1[$.
  ],
)

#example(
  number: none,
  [
    Le cercle $C$ de la @fig-cercle-carre est une courbe de Jordan. On pose :
    $ func(gamma, [0, 1], RR^2, t, (cos(2 pi t), sin(2 pi t))) $
    Alors $gamma$ est continue et :
    - On a $im(gamma) = C$.
    - On a $gamma(0) = (1, 0) = gamma(1)$.
    - Pour $x in [0, 1[$, on a $2pi x in [0, 2pi[$, donc $gamma$ est injective sur $[0, 1[$.
  ],
)

#definition(
  number: none,
  [
    Un rectangle $(a, b, c, d)$ de $RR^2$ est _inscrit dans une courbe de Jordan $C$_ si $a, b, c, d in C$.
  ],
)

#example(
  number: none,
  [
    Le carré
    #[
      #set text(10pt)
      $((sqrt(2) slash 2, sqrt(2) slash 2), (-sqrt(2) slash 2, sqrt(2) slash 2), (-sqrt(2) slash 2, -sqrt(2) slash 2), (sqrt(2) slash 2, -sqrt(2) slash 2))$
    ]
    est inscrit dans le cercle $C$ de la @fig-cercle-carre :

    - On a $(sqrt(2) slash 2, sqrt(2) slash 2) = gamma(1 slash 8) in C$.

    - On a $(-sqrt(2) slash 2, sqrt(2) slash 2) = gamma(3 slash 8) in C$.

    - On a $(-sqrt(2) slash 2, -sqrt(2) slash 2) = gamma(5 slash 8) in C$.

    - On a $(sqrt(2) slash 2, -sqrt(2) slash 2) = gamma(7 slash 8) in C$.
  ],
)

#theorem(
  number: none,
  [
    Toute courbe de Jordan admet un rectangle inscrit.
  ],
) <thm-rectangle-inscrit>

#pagebreak()

= Homologie singulière

Dans cette partie :
- $n in NN$ est un entier naturel.
- $E$ est un $RR$-espace vectoriel, $A$ une partie de $E$ et $f_0, ..., f_n$ des points de $A$.
- $X$, $Y$ et $Z$ sont trois espaces topologiques, $func(f, X, Y)$ et $func(g, Y, Z)$ deux applications continues.

== Simplexes


#definition([
  $A$ est _convexe_ si :
  $ forall p, q in A, [p, q] := {(1 - t)p + t q | t in [0, 1]} subset A. $
])

#definition([
  Une _combinaison convexe_ est une combinaison linéaire de la forme $t_0 f_0 + dots.c + t_n f_n$ où $t_0, ..., t_n in [0, 1]$ et $t_0 + dots.c + t_n = 1$.
])

#proposition([
  Si $A$ est convexe, toute combinaison convexe de $f_0, ..., f_n$ est dans $A$.
]) <prop-combinaison-convexe>

#proof([
  Soit $t_0, ..., t_n in [0, 1]$ tels que $t_0 + dots.c + t_n = 1$. Notons $H(n) : t_0 f_0 + dots.c + t_n f_n in A$. \
  Pour $n = 1$. On pose $t := t_1$, par convexité on a $t_0 f_0 + t_1 f_1 = (1 - t)f_0 + t f_1 in A$. \
  Soit $n > 1$. On suppose que $H(n - 1)$ est vérifiée. Sans perte de généralité, on suppose que $t_n != 1$, et on pose :
  $ f := (t_0) / (1 - t_n) f_0 + dots.c + (t_(n-1)) / (1 - t_n) f_(n-1) $
  d'après $H(n - 1)$ on a $f in A$. Par convexité on a $t_0 f_0 + dots.c + t_n f_n = (1 - t_n)f + t_n f_n in A$.
])

#definition([
  L'_enveloppe convexe de $A$_ est l'ensemble $"Conv"(A)$ des combinaisons convexes de points de $A$.
])

#proposition([
  $"Conv"(A)$ est le plus petit convexe contenant $A$.
])

#proof([
  Soit $p, q in "Conv"(A)$ et $t in [0, 1]$.
  Alors $p$ et $q$ sont des combinaisons convexes d'éléments de $A$, d'après la @prop-combinaison-convexe on a $(1 - t)p + t q in "Conv"(A)$.

  Soit $B$ un convexe contenant $A$.
  Soit $x in "Conv"(A)$.
  Alors $x$ est une combinaison convexe d'éléments de $A subset B$, d'après la @prop-combinaison-convexe on a $x in B$.
])

#definition([
  Si $F := (f_0, ..., f_n)$ est libre, le _$n$-simplexe généré par $F$_ est l'ensemble $"Conv"(F)$.
])

#notation([
  Le _$n$-simplexe standard_ $Delta^n$ est le $n$-simplexe généré par la base canonique de $RR^(n+1)$.
])

#definition([
  Si $F := (f_0, ..., f_n)$ et $G := (g_0, ..., g_m) subset F$ sont libres.
  On dit que $"Conv"(G)$ est une _$m$-face_ de $"Conv"(F)$.
])

// #figure(
//   align(center)[
//     #cetz.canvas({
//       import cetz.draw: *

//       set-style(
//         stroke: (cap: "round", join: "round"),
//         mark: (transform-shape: false, fill: black),
//       )
//       line((-2.5, 0, 0), (3.5, 0, 0), mark: (end: "stealth"))
//       line((0, -2, 0), (0, 3.5, 0), mark: (end: "stealth"))
//       line((0, 0, -3.5), (0, 0, 4), mark: (end: "stealth"))

//       line((2, 0, 0), (0, 2, 0), stroke: (paint: green))
//       line((0, 2, 0), (0, 0, 2), stroke: (paint: green))
//       line((0, 0, 2), (2, 0, 0), stroke: (paint: green))
//       line(
//         (2, 0, 0),
//         (0, 2, 0),
//         (0, 0, 2),
//         fill: luma(50%, 40%),
//         stroke: none,
//       )

//       set-style(circle: (radius: 0.03, fill: red, stroke: red))
//       circle((2, 0, 0), name: "e_0")
//       circle((0, 2, 0), name: "e_1")
//       circle((0, 0, 2), name: "e_2")

//       set-style(content: (padding: 0.1))
//       content("e_0", [$e_0$], anchor: "south-west")
//       content("e_1", [$e_1$], anchor: "south-east")
//       content("e_2", [$e_2$], anchor: "south-east")
//     })
//   ],
//   caption: [$2$-simplexe standard et ses faces.],
// )

== Chaînes singulières

#definition([
  Un _$n$-simplexe singulier sur $X$_ est une application continue $func(sigma, Delta^n, X)$.
])

#proposition([
  Soit $func(sigma, Delta^n, X)$ un $n$-simplexe singulier.
  Alors $func(f compose sigma, Delta^n, Y)$ est un #box([$n$-simplexe]) singulier.
])

#proof([
  Par composition $func(f compose sigma, Delta^n, Y)$ est continue.
])

#definition([
  Le _groupe des $n$-chaînes singulières de $X$_ est le groupe abélien libre $C_(n)(X)$ engendré par les $n$-simplexes singuliers sur $X$.
])

#definition([
  L'_application induite par $f$_ est le morphisme de groupes :
  $
    func(C_(n)(f), C_(n)(X), C_(n)(Y), sum_(k=0)^m lambda_k sigma_k, sum_(k=0)^m lambda_k (f compose sigma_k)).
  $
])

#proposition([
  On a $C_(n)(g compose f) = C_(n)(g) compose C_(n)(f)$.
]) <prop-top-composition>

#proof([
  Les $n$-chaînes singulières sont engendrées par les $n$-simplexes singuliers, il suffit de montrer le résultat pour un $n$-simplexe singulier $func(sigma, Delta^n, X)$ :
  $
    C_(n)(g compose f)(sigma) = (g compose f) compose sigma = g compose (f compose sigma) = g compose C_(n)(f)(sigma) = C_(n)(g)(C_(n)(f)(sigma))
  $
])

#definition([
  Soit $func(sigma, Delta^n, X)$ un $n$-simplexe singulier.
  Le _bord de $sigma$_ est la $(n-1)$-chaîne singulière :
  $
    dif_n sigma := sum_(k=0)^n (-1)^k (sigma compose gensubgroup(e_0, ..., overshell(e_k),... e_n)).
  $
  où $overshell(dot)$ signifie que l'élément est retiré.
  Par convention on pose $dif_0 := 0$.
])

#definition([
  Le _morphisme bord_ est le morphisme de groupes :
  $
    func(dif_n, C_n (X), C_(n-1)(X), sum_(k=0)^m lambda_k sigma_k, sum_(k=0)^m lambda_k dif_n sigma_k).
  $
])

#proposition([
  On a $dif_n C_(n)(f) = C_(n-1)(f) dif_n$.
]) <prop-continue-commute>

#proof([
  On montre le résultat pour un $n$-simplexe singulier $func(sigma, Delta^n, X)$ :
  $
    dif_n C_(n)(f)(sigma) &= sum_(k=0)^n (-1)^k ((f compose sigma) compose gensubgroup(e_0, ..., overshell(e_k), ..., e_n))
    &= C_(n-1)(f)(dif_n sigma).
  $
])

#proposition([
  On a $dif_n dif_(n+1) = 0$.
]) <prop-bord-composition>

#proof([
  On montre le résultat pour un $(n+1)$-simplexe singulier $func(sigma, Delta^(n+1), X)$ :
  $
    dif_(n+1) sigma = sum_(k=0)^(n+1) (-1)^k (sigma compose gensubgroup(e_0, ..., overshell(e_k), ..., e_(n+1)))
  $
  puis en appliquant $dif_n$, on sépare en deux selon les éléments retirés :
  $
    dif_n dif_(n+1) sigma
    &= &&sum_(k=0)^(n+1) (-1)^k dif_(n)(sigma compose gensubgroup(e_0, ..., overshell(e_k), ..., e_(n+1))) \
    &= &&sum_(0 <= k < l <= n + 1) (-1)^(k + l) (sigma compose gensubgroup(e_0, ..., overshell(e_k), ..., overshell(e_l), ..., e_(n+1))) \
    & &&+ sum_(0 <= l < k <= n + 1) (-1)^(k + l - 1) (sigma compose gensubgroup(e_0, ..., overshell(e_l), ..., overshell(e_k), ..., e_(n+1))) \
    &= &&sum_(0 <= k < l <= n + 1) ((-1)^(k + l) + (-1)^(k + l + 1)) (sigma compose gensubgroup(e_0, ..., overshell(e_k), ..., overshell(e_l), ..., e_(n+1))) \
    &= &&0
  $
  car les puissances de $-1$ s'annulent :
])

== Définition et principales propriétés

#definition([
  - Un _$n$-cycle singulier sur $X$_ est un élément de $Z_(n)(X) := ker(dif_n)$.
  - Un _$n$-bord singulier sur $X$_ est un élément de $B_(n)(X) := im(dif_(n+1))$.
])

#proposition([
  On a $B_(n)(X) subset Z_(n)(X)$.
])

#proof([
  On a $dif_n dif_(n+1) = 0$, donc $B_(n)(X) = im(dif_(n+1)) subset ker(dif_n) = Z_(n)(X)$.
])

#definition([
  Le _$n$#super("e") groupe d'homologie singulière de $X$_ est le quotient $H_(n)(X) := lquotient(Z_(n)(X), B_(n)(X))$.
])

#proposition([
  $C_(n)(f)$ induit un morphisme $func(H_(n)(f), H_(n)(X), H_(n)(Y))$.
])

#proof([
  Soit $z in Z_(n)(X)$. On a
  $dif_n C_(n)(f)(z) = C_(n-1)(f)(dif_n z) = 0$,
  donc $C_(n)(f)(z) in Z_(n)(Y)$. \
  Réciproquement, soit $b in B_(n)(X)$. Alors par définition il existe $c in C_(n+1)(X)$ tel que $b = dif_(n+1) c$, et on a
  $C_(n)(f)(b) = C_(n)(f)(dif_(n+1) c) = dif_(n+1) C_(n+1)(f)(c)$
  donc $C_(n)(f)(b) in B_(n)(X)$.

  On considère $func(overline(C_(n)(f)), Z_(n)(X), H_(n)(Y))$, alors $B_(n)(X) subset ker(overline(C_(n)(f)))$ et d'après la propriété universelle du groupe quotient le morphisme $overline(C_(n)(f))$ induit un morphisme $func(H_(n)(f), H_(n)(X), H_(n)(Y))$.
])

=== Homotopie

#definition([
  $f$ et $g$ sont _homotopes_ s'il existe une application $func(h, X times [0, 1], Y)$ continue telle que pour tout $x in X$, on a $f(x) = h(x, 0)$ et $g(x) = h(x, 1)$.
])

#theorem([
  Si $f$ et $g$ sont homotopes, on a $H_(n)(f) = H_(n)(g)$.
]) <thm-homotopie>

#proof([
  Il existe une application $func(h, X times [0, 1], Y)$ continue telle que $f(x) = h(x, 0)$ et $g(x) = h(x, 1)$.
  Pour tout $n$-simplexe singulier $func(sigma, Delta^n, X)$, on pose :
  $
    h_(n)(sigma) := sum_(k=0)^n (-1)^k (h compose (sigma times id) compose gensubgroup(f_0, ..., f_k, g_k, ..., g_n)) in C_(n+1)(Y)
  $
  où $(f_0, ..., f_n) := (e_0 times {1}, ..., e_n times {1})$ et $(g_0, ..., g_n) := (e_0 times {0}, ..., e_n times {0})$.
  Calculons :
  $
    h_(n-1)(dif_n sigma) &= &&h_(n)(sum_(l=0)^n (-1)^l (sigma compose gensubgroup(e_0, ..., overshell(e_l), ..., e_n))) \
    &= &&sum_(0<=k<l<=n) (-1)^(k+l) (h compose (sigma times id) compose gensubgroup(f_0, ..., f_k, g_k, ..., overshell(g_l), ..., g_n)) \
    & &&+ sum_(0<=l<k<=n) (-1)^(k+l-1) (h compose (sigma times id) compose gensubgroup(f_0, ..., overshell(f_l), ..., f_k, g_k, ..., g_n)) \
    dif_n h_(n)(sigma) &= &&sum_(0<=l<=k<=n) (-1)^(k+l) (h compose (sigma times id) compose gensubgroup(f_0, ..., overshell(f_l), ..., f_k, g_k, ..., g_n)) \
    & &&+ sum_(0<=k<=l<=n) (-1)^(k+l-1) (h compose (sigma times id) compose gensubgroup(f_0, ..., f_k, g_k, ..., overshell(g_l), ..., g_n)) \
  $
  en faisant la somme des deux expressions les termes d'indices différents s'annulent deux à deux :
  $
    h_(n-1)(dif_n sigma) + dif_n h_(n)(sigma) &= &&sum_(k=0)^n (h compose (sigma times id) compose gensubgroup(f_0, ..., f_(k-1), g_k, ..., g_n)) \
    & &&-sum_(k=0)^n (h compose (sigma times id) compose gensubgroup(f_0, ..., f_k, g_(k+1), ..., g_n)) \
    &= &&(h compose (sigma times id) compose gensubgroup(g_0, ..., g_n)) - (h compose (sigma times id) compose gensubgroup(f_0, ..., f_n)) \
    &= &&(h compose (sigma times {0})) - (h compose (sigma times {1})) \
    &= &&(f compose sigma) - (g compose sigma) \
    &= &&C_(n)(f)(sigma) - C_(n)(g)(sigma)
  $
  Alors pour tout $z in Z_(n)(X)$, on a :
  $
    C_(n)(f)(z) - C_(n)(g)(z) = h_(n-1)(dif_n z) + dif_n h_(n)(z) = dif_n h_(n)(z) in B_(n)(X)
  $
  on en déduit $H_(n)(f)(overline(z)) - H_(n)(f)(overline(z)) = 0 in H_(n)(X)$.
  Donc $H_(n)(f) = H_(n)(g)$.
])


#definition([
  $X$ et $Y$ sont _homotopiquement équivalents_ s'il existe deux applications continues $func(a, X, Y)$ et $func(b, Y, X)$ telles que $b compose a$ est homotope à $id_X$ et $a compose b$ est homotope à $id_Y$.
])

#corollary([
  Si $X$ et $Y$ sont homotopiquement équivalents, on a $H_(n)(X) tilde.eq H_(n)(Y)$.
]) <cor-homotopie-equ>

#proof([
  Il existe deux applications continues $func(a, X, Y)$ et #box($func(b, Y, X)$) telles que $b compose a$ est homotope à $id_X$ et $a compose b$ est homotope à $id_Y$.
  D'après le @thm-homotopie on a $H_(n)(b) compose H_(n)(a) = id_(H_(n)(X))$ et $H_(n)(a) compose H_(n)(b) = id_(H_(n)(Y))$.
  Donc $H_(n)(X) tilde.eq H_(n)(Y)$.
])

=== Connexité par arcs

#proposition([
  Soit $sequence(X_i, ind: i, dom: I)$ les composantes connexes par arcs de $X$. On a $H_(n)(X) tilde.eq plus.circle.big_(i in I) H_(n)(X_i)$.
]) <prop-somme-composantes-connexes>

#proof([
  Toute $n$-chaîne singulière $func(sigma, Delta^n, X)$ est continue et $Delta^n$ est convexe, en particulier connexe par arcs, donc il existe un unique $i in I$ tel que $im(sigma) subset X_i$. \
  On en déduit que $C_(n)(X) tilde.eq plus.circle.big_(i in I) C_(n)(X_i)$, de plus $dif_n$ préserve cette décomposition et par passage au quotient on a $H_(n)(X) tilde.eq plus.circle.big_(i in I) H_(n)(X_i)$.
])

#proposition([
  Soit $sequence(X_i, ind: i, dom: I)$ les composantes connexes par arcs de $X$. On a $H_(0)(X) tilde.eq plus.circle.big_(i in I) ZZ$.
]) <prop-h0-abelien-libre>

#proof([
  On a $ker(dif_0) = C_(0)(X)$.
  Supposons que $X$ est non-vide et connexe par arcs.
  Alors on pose $func(phi, C_(0)(X), ZZ, sum_(k=0)^m lambda_k sigma_k, sum_(k=0)^m lambda_k)$.
  Alors $phi$ est un morphisme de groupes surjectif. \

  Pour tout $1$-simplexe singulier $func(sigma, Delta^1, X)$, on a $phi(dif_1 sigma) = phi(sigma compose gensubgroup(overshell(e_0), e_1) - sigma compose gensubgroup(e_0, overshell(e_1))) = 1 - 1 = 0$, donc $im(dif_1) subset ker(phi)$. \

  Réciproquement on considère $sum_(k=0)^m lambda_k sigma_k in ker(phi)$.
  Pour tout $k in {0, ..., n}$, on note $func(gamma_k, Delta^1, X)$ un chemin d'un point $x in X$ au point $sigma_(k)(e_1) in X$ et on considère $func(sigma, Delta^0, X)$ un $0$-simplexe singulier d'image $x$, on a $dif_1 gamma_k = sigma_k - sigma$.
  Alors en considérant la $n$-chaîne singulière $sum_(k=0)^m lambda_k gamma_k$, on a $dif_1 sum_(k=0)^m lambda_k gamma_k = sum_(k=0)^m lambda_k sigma_k - sum_(k=0)^m lambda_k sigma = sum_(k=0)^m lambda_k sigma_k$, donc $ker(phi) subset im(dif_1)$. \

  D'après le premier théorème d'isomorphisme on a $H_(0)(X) = lquotient(C_(0)(X), ker(phi)) tilde.eq ZZ$.

  Dans le cas général, d'après la @prop-somme-composantes-connexes on a $H_(0)(X) tilde.eq plus.circle.big_(i in I) H_(n)(X_i) tilde.eq plus.circle.big_(i in I) ZZ$.
])

=== Calculs d'homologie

#theorem(
  title: "Théorème de Mayer-Vietoris",
  [
    Soit $U$ et $V$ deux parties de $X$ tels que $circle(U) union circle(V) = X$.
    Il existe un morphisme de groupes $func(partial_n, H_(n)(U union V), H_(n-1)(U inter V))$ tel que la suite suivante est exacte :
    #align(center)[
      #set text(10pt)
      #commutative-diagram(
        node-padding: (40pt, 40pt),
        padding: 10pt,
        node((0, 0), $dots.c$),
        node((0, 1), $H_(n)(U inter V)$),
        node((0, 2), $H_(n)(U) plus.circle H_(n)(V)$),
        node((0, 3), $H_(n)(X)$),
        node((0, 4), $H_(n-1)(U inter V)$),
        node((0, 5), $dots.c$),

        arr((0, 0), (0, 1), $partial_(n+1)$, label-pos: 13pt),
        arr((0, 1), (0, 2), $(H_(n)(i), H_(n)(j))$, label-pos: 13pt),
        arr((0, 2), (0, 3), $H_(n)(k) - H_(n)(l)$, label-pos: 13pt),
        arr((0, 3), (0, 4), $partial_n$, label-pos: 13pt),
        arr((0, 4), (0, 5), $(H_(n-1)(i), H_(n-1)(j))$, label-pos: 13pt),
      )]
    #v(-7pt)
    où $func(i, U inter V, U)$, $func(j, U inter V, V)$, $func(k, U, U union V)$ et $func(l, V, U union V)$ sont les inclusions canoniques.
  ],
) <thm-mayer-vietoris>

#proof([
  Temporairement admise.
])

#proposition([
  Soit $P$ un espace topologique constitué d'un point. On a :
  $ H_(n)(P) tilde.eq cases(ZZ &"si" n = 0, 0 &"sinon") $
]) <prop-homologie-point>

#proof([
  Il existe un unique $n$-simplexe singulier $func(sigma_n, Delta^n, P)$ et on a :
  $
    dif_n sigma_n = sum_(k=0)^n (-1)^k sigma_(n-1) = cases(0 &"si" n = 0 "ou" n "est impair", sigma_(n-1) &"si" n != 0 "et" n "est pair")
  $
  si $n = 0$, on a $H_(0)(P) = lquotient(gensubgroup(sigma_0), 0) tilde.eq ZZ $, \
  si $n != 0 $ et $n$ est impair, on a $H_(n)(P) = lquotient(gensubgroup(sigma_n), gensubgroup(sigma_n)) tilde.eq 0$, \
  si $n != 0 $ et $n$ est pair, on a $H_(n)(P) = lquotient(0, 0) tilde.eq 0$.
])

#remark([
  On note $BB^n$ une boule fermé de dimension $n$ et $SS^n$ une sphère de dimension $n$.
])

#proposition([
  On a :
  $ H_(n)(SS^0) tilde.eq cases( ZZ plus.circle ZZ &"si" n=0, 0 &"sinon") $
]) <prop-homologie-s0>

#proof([
  $SS^0$ est composé de deux points et a donc deux composantes connexes par arcs, il suffit d'appliquer les @prop-somme-composantes-connexes et @prop-homologie-point.
])

#proposition([
  On a :
  $ H_(n)(SS^1) tilde.eq cases(ZZ &"si" n in {0, 1}, 0 &"sinon") $
]) <prop-homologie-s1>

#proof([
  On recouvre $SS^1$ par deux arcs ouverts $U$ et $V$ recouvrant chacun un demi-cercle :
  #figure(
    cetz.canvas({
      import cetz.draw: *

      set-style(
        stroke: (cap: "round", join: "round"),
        mark: (transform-shape: false, anchor: "center"),
      )

      let circle-2d(center, radius, start, stop, stroke) = {
        line(
          ..range(start, stop).map(x => (
            center.at(0) + radius * calc.cos(2 * calc.pi * x / 100),
            center.at(1) + radius * calc.sin(2 * calc.pi * x / 100),
          )),
          stroke: stroke,
        )
      }

      circle-2d((0, 0), 1.25, -5, 55, red)
      circle-2d((0, 0), 1.25, 45, 105, blue)
      circle-2d((0, 0), 1.25, 45, 55, green)
      circle-2d((0, 0), 1.25, -5, 5, green)

      content((1.1, 0.9), $U$, anchor: "south", padding: 0.1)
      content((1.1, -0.9), $V$, anchor: "north", padding: 0.1)
      content((-1.25, 0), $U inter V$, anchor: "east", padding: 0.1)
    }),
    caption: [Recouvrement de $SS^1$.],
  )
  Les arcs $U$ et $V$ sont homotopiquement équivalents à un point, et l'intersection $U inter V$ est homotopiquement équivalente à $SS^0$.
  D'après le @cor-homotopie-equ, les @prop-homologie-point et @prop-homologie-s0 on a :
  $
    H_(n)(U) tilde.eq H_(n)(V) tilde.eq cases(ZZ &"si" n = 0, 0 &"sinon")
    quad "et" quad
    H_(n)(U inter V) tilde.eq cases(ZZ plus.circle ZZ &"si" n = 0, 0 &"sinon")
  $
  et d'après le @thm-mayer-vietoris la suite suivante est exacte :
  #align(
    center,
    [
      #commutative-diagram(
        node-padding: (25pt, 40pt),
        padding: 5pt,
        node((0, 0), $dots.c$),
        node((0, 1), $0$),
        node((0, 2), $H_(1)(SS^1)$),
        node((0, 3), $ZZ plus.circle ZZ$),
        node((0, 4), $ZZ plus.circle ZZ$),
        node((0, 5), $H_(0)(SS^1)$),
        node((0, 6), $0$),

        arr((0, 0), (0, 1), $$),
        arr((0, 1), (0, 2), $$),
        arr((0, 2), (0, 3), $partial_1$),
        arr((0, 3), (0, 4), $phi_0$),
        arr((0, 4), (0, 5), $psi_0$),
        arr((0, 5), (0, 6), $$),
      )],
  )
  On en déduit directement que si $n >= 2$, on a $H_(n)(SS^1) tilde.eq 0$. \

  En étudiant $func(phi_0 := (H_(0)(i), H_(0)(j)), ZZ plus.circle ZZ, ZZ plus.circle ZZ)$ où $func(i, U inter V, U)$ et $func(j, U inter V, V)$ sont les inclusions canoniques, on trouve que $phi_(0)(1, 0) = phi_(0)(0, 1) = (1, 1)$. 

  Alors $ker(phi_0) = {(a, -a) | a in ZZ} tilde.eq ZZ$ et $im(phi_0) = {(a+b, a+b) | a, b in ZZ} tilde.eq ZZ$.
  Par exactitude $partial_1$ est injective et on a $H_(1)(SS^1) tilde.eq im(partial_1) = ker(phi_0) tilde.eq ZZ$.
  De même, par exactitude $psi_0$ est surjective et on a $H_(0)(SS^1) tilde.eq lquotient((ZZ plus.circle ZZ), ker(psi_0)) tilde.eq lquotient((ZZ plus.circle ZZ), im(phi_0)) tilde.eq lquotient((ZZ plus.circle ZZ), ZZ) tilde.eq ZZ$.
])

#proposition([
  On a :
  $ H_(n)(SS^2) tilde.eq cases(ZZ &"si" n in {0, 2}, 0 &"sinon") $
]) <prop-homologie-s2>

#proof([
  On recouvre $SS^2$ par deux ouverts $U$ et $V$ recouvrant chacun un hémisphère :
  #figure(
    cetz.canvas({
      import cetz.draw: *

      set-style(
        stroke: (cap: "round", join: "round"),
        mark: (transform-shape: false, anchor: "center"),
      )

      let circle-2d(center, radius) = {
        range(101).map(x => (
          center.at(0) + radius.at(0) * calc.cos(2 * calc.pi * x / 100),
          center.at(1) + radius.at(1) * calc.sin(2 * calc.pi * x / 100),
        ))
      }

      let circ1 = circle-2d((0, 0), (1.25, 1.25))
      let circ2 = circle-2d((0, 0), (1.25, 1.25 / 2))

      line(..circ1)
      line(
        ..circ1.slice(49, 101),
        ..circ2.slice(0, 51),
        stroke: blue,
        fill: rgb("#0074d9bb"),
      )
      line(..circ2, stroke: green)
      line(
        ..circ1.slice(0, 51),
        ..circ2.slice(49, 101),
        stroke: red,
        fill: rgb("#ff4136bb"),
      )
      line(..circ2.slice(50, 101), stroke: green)

      content((1.1, 0.9), $U$, anchor: "south", padding: 0.1)
      content((1.1, -0.9), $V$, anchor: "north", padding: 0.1)
      content((-1.25, 0), $U inter V$, anchor: "east", padding: 0.1)
    }),
    caption: [Recouvrement de $SS^2$.],
  )
  Alors on peut calculer $H_(n)(SS^2)$ de la même manière que dans la @prop-homologie-s0.
])

#proposition([
  Soit $X$ un sous-espace de $SS^p$ homéomorphe à $BB^q$. On a :
  $ H_(n)(SS^p without X) tilde.eq cases(ZZ &"si" n = 0, 0 &"sinon") $
]) <prop-homologie-sp-bq>

#proof([
  Soit $func(f, BB^q, X)$ un homéomorphisme, on raisonne par récurrence sur $q < p$ avec :
  $
    P(q) : H_(n)(SS^p without f(BB^q)) tilde.eq cases(ZZ &"si" n=0, 0 &"sinon")
  $
  Pour $q = 0$. L'espace $BB^0$ est réduit à un unique point, par projection stéréographique $SS^p without f(BB^0)$ est homéomorphe à $RR^p$, qui est homotopiquement équivalent à un point.
  D'après le @cor-homotopie-equ et la @prop-homologie-point on a :

  $
    H_(n)(SS^p without f(BB^0)) tilde.eq H_(n)(RR^p) tilde.eq cases(ZZ &"si" n=0, 0 &"sinon")
  $

  Soit $q > 0$. On suppose que $P(q - 1)$ est vérifiée.
  L'espace $BB^q$ est homéomorphe à $BB^(q-1) times [0, 1]$.
  On recouvre $BB^(q-1) times [0, 1]$ par deux fermés $BB^- := BB^(q-1) times [0, 1 slash 2]$ et $BB^+ := BB^(q-1) times [1 slash 2, 1]$, ils sont homéomorphes à $BB^q$, et l'intersection $BB^- inter BB^+ = BB^(q-1) times {1 slash 2}$ est homéomorphe à $BB^(q-1)$.
  Alors on recouvre $SS^p without f(BB^(q-1) times {1 slash 2})$ par les ouverts $U := SS^p without f(BB^-)$ et $V := SS^p without f(BB^+)$, et l'intersection vaut $U inter V = SS^p without f(BB^q)$. D'après le @thm-mayer-vietoris la suite suivante est exacte :
  #align(center)[
    #commutative-diagram(
      node-padding: (30pt, 40pt),
      padding: 7pt,
      node((0, -1), $dots.c$),
      node((0, 0), $H_(n+1)(U union V)$),
      node((0, 1), $H_(n)(U inter V)$),
      node((0, 2), $H_(n)(U) plus.circle H_(n)(V)$),
      node((0, 3), $H_(n)(U union V)$),
      node((0, 4), $dots.c$),

      arr((0, -1), (0, 0), $psi_(n+1)$),
      arr((0, 0), (0, 1), $partial_(n+1)$),
      arr((0, 1), (0, 2), $phi_n$),
      arr((0, 2), (0, 3), $psi_n$),
      arr((0, 3), (0, 4), $partial_n$),
    )]
  #v(-4pt)
  où $func(phi_n := (i_0, j_0), H_(n)(U inter V), H_(n)(U) plus.circle H_(n)(V))$ est induite par les inclusions canoniques.

  Si $n = 0$. $SS^p without f(BB^q)$ est connexe par arcs, d'après la @prop-h0-abelien-libre on a $H_(0)(SS^p without f(BB^q)) tilde.eq ZZ$.

  Si $n >= 1$. On suppose par l'absurde qu'il existe $alpha_0 in H_(n)(U inter V)$ non-nul.
  D'après $P(q-1)$ on a $H_(n)(U union V) tilde.eq 0$, par exactitude $phi_n$ est injective et on peut supposer sans perte de généralité qu'il existe $alpha_1 in H_(n)(U)$ non-nul tel que $i_(0)(alpha_0) = alpha_1$ (sinon on prend $alpha_1 in H_(n)(V)$ et $j_(0)(alpha_0) = alpha_1$).

  Puisque $BB^-$ est homéomorphe à $BB^q$, on peut refaire le même raisonnement avec $SS^p without f(BB^-)$ à la place de $SS^p without f(BB^q)$, alors il existe $alpha_2 in H_(n)(SS^p without f(BB^(q-1) times [0, 1 slash 4]))$ non-nul tel que $i_(1)(alpha_1) = alpha_2$, où $func(i_1, H_(n)(SS^p without f(BB^-)), H_(n)(SS^p without f(B times [0, 1 slash 4])))$ est induite par l'inclusion canonique. \

  En itérant ce raisonnement on obtient une suite $sequence(alpha_k, ind:k, dom: NN)$ où pour tout $k in NN$, on a $alpha_k in H_(n)(A_k) := H_(n)(SS^p without f(BB^(q-1) times [0, 1 slash 2^k]))$ non-nul tel que $i_(k)(alpha_k) = alpha_(k+1)$, où $func(i_k, H_(n)(A_k), H_(n)(A_(k+1)))$ est induite par l'inclusion canonique.

  Soit $func(sigma, Delta^n, A_0)$ un $n$-cycle singulier représentant $alpha_0$.
  Puisque pour tout $k in NN$, on a $i_(k)(alpha_k) = alpha_(k+1)$, on en déduit que $sigma$ est un représentant de tous les $alpha_k$. \

  On note $Y := union.big_(k in NN) A_k = SS^p without f(BB^(q-1) times {0})$.
  Alors puisque $BB^(q-1) times {0}$ est homéomorphe à $BB^(q-1)$, d'après $P(q-1)$ on a $H_(n)(Y) tilde.eq 0$.
  De plus $sigma in Z_(n)(Y)$ et $overline(sigma) = 0 in H_(n)(Y)$. \

  Alors $sigma in B_(n)(Y)$ et il existe une $(n+1)$-chaîne singulière $func(tau, Delta^(n+1), Y)$ telle que $dif_(n+1) tau = sigma$.
  Puisque $tau$ est continue et $Delta^(n+1)$ est compact, $im(tau)$ est compacte.
  Or $Y := union.big_(k in NN) A_k$ est un recouvrement ouvert de $im(tau)$, donc par définition il existe $k_0 in NN$ tel que $im(tau) subset A_k_0$. \

  Enfin $sigma = dif_(n+1) tau in B_(n+1)(A_k_0)$ et $a_k_0 = overline(sigma) = 0 in H_(n)(A_k_0)$, d'où une contradiction.

  Donc $H_(n)(SS^p without f(BB^q)) tilde.eq 0$.
])

#proposition([
  Soit $X$ un sous-espace de $RR^3$ homéomorphe à $BB^2$.
  On a :
  $
    H_(n)(RR^3 without X) tilde.eq H_(n)(SS^2) tilde.eq cases(ZZ &"si" n in {0, 2}, 0 &"sinon")
  $
]) <prop-homologie-complementaire-b2>

#proof([
  Par projection stéréographique et compactification d'Alexandrov $RR^3 union {oo}$ est homéomorphe à $SS^3$, en particulier la restriction $(RR^3 without X) union {oo}$ est homéomorphe à $SS^3 without X$.
  On recouvre $(RR^3 without X) union {oo}$ par deux ouverts $U := RR^3 without X$ et $V$ une boule au voisinage de $oo$ qui n'intersecte pas $X$ (qui est compact). \

  Alors on peut calculer $H_(n)(SS^3 without X)$ de la même manière que dans la @prop-homologie-s1.
])

#proposition([
  Soit $X$ un sous-espace de $SS^3$ homéomorphe à $SS^1$.
  On a :
  $
    H_(n)(SS^3 without X) tilde.eq H_(n)(SS^1) tilde.eq cases(ZZ &"si" n in {0, 1}, 0 &"sinon")
  $
]) <prop-homologie-s3-s1>

#proof([
  On recouvre $SS^1$ par deux arcs fermés $A_+$ et $A_-$, ils sont homéomorphes à $BB^1$, et leur intersection vaut $A_+ inter A_- = SS^0$. On considère un homéomorphisme $func(f, SS^1, X)$ et on pose deux ouverts $U := SS^3 without f(A_+)$ et $V := SS^3 without f(A_-)$.
  Par projection stéréographique $U union V = SS^3 without f(SS^0)$ est homéomorphe à $RR^3 without {0}$, qui est homotopiquement équivalent à $SS^(2)$. \

  Alors on peut calculer $H_(n)(SS^3 without X)$ de la même manière que dans la @prop-homologie-s1.
])

#proposition([
  Soit $X$ un sous-espace de $RR^3$ homéomorphe à $SS^1$.
  On a :
  $ H_(n)(RR^3 without X) tilde.eq cases(ZZ &"si" n in {0, 1, 2}, 0 &"sinon") $
]) <prop-homologie-complementaire-s1>

#proof([
  On peut recouvrir de la même manière que dans la @prop-homologie-complementaire-b2 et
  calculer $H_(n)(SS^3 without X)$ de la même manière que dans la @prop-homologie-s1
])

#pagebreak()

#let equ(a) = $attach(~, br: #a)$

= Le plan projectif réel $PP^2_RR$

== Représentations

#definition([
  Le _plan projectif réel_ $PP^2_RR$ est le quotient de $RR^3 without {0}$ par la relation d'équivalence $equ(PP^2)$, muni de la topologie quotient, où pour tout $u, v in RR^3 without {0}$, on a $u equ(PP^2) v$ s'il existe $lambda in RR without {0}$ tel que $u = lambda v$. \
  Soit $(x, y, z) in RR^3 without {0}$.
  Les _coordonnées homogènes de $(x, y, z)$_ sont celles du point associé sur le plan projectif réel $[x:y:z] := overline((x, y, z)) in PP^2_RR$.
])

#proposition([
  $PP^2_RR$ est homéomorphe au quotient de $SS^2$ par la relation d'équivalence $equ(SS^2)$ où pour tout $u, v in SS^2$, on a $u equ(SS^2) v$ si $u = plus.minus v$.
]) <prop-homeo-p2-s2>

#proof([
  On pose $func(i, SS^2, PP^2_RR, (x, y, z), [x:y:z])$.
  Alors $i$ est bien définie, de plus pour tout $u, v in SS^2$, si $u equ(SS^2) v$, on a $u = plus.minus v$, d'où $i(u) = i(v)$, et $i$ est continue.
  Donc $i$ passe au quotient et induit une application continue $func(I, lquotient(SS^2, equ(SS^2)), PP^2_RR)$.

  On pose $func(j, RR^3 without {0}, lquotient(SS^2, equ(SS^2)), u, overline(u slash norm(u)))$.
  Alors $j$ est bien définie, de plus pour tout $u, v in RR^3 without {0}$, si $u equ(PP^2) v$, alors il existe $lambda in RR without {0}$ tel que $u = lambda v$, d'où $j(u) = j(lambda v) = j(v)$, et $j$ est continue par composition d'applications continues.
  Donc $j$ passe au quotient et induit une application continue $func(J, PP^2_RR, lquotient(SS^2, equ(SS^2)))$.

  Enfin $J compose I = id_(lquotient(SS^2, equ(SS^2)))$ et $I compose J = id_(PP^2_RR)$, donc $I$ est un homéomorphisme de $PP^2_RR$ dans $lquotient(SS^2, equ(SS^2))$.
])

#proposition([
  $PP^2_RR$ se décompose en une union $M union D$ tels que $M$ est homéomorphe une bande de Möbius, $D$ est homéomorphe à $BB^2$, et l'intersection $M inter D = partial M = partial D$ est homéomorphe à $SS^1$.
]) <prop-homeo-p2-mobius-disque>

#proof([
  D'après la @prop-homeo-p2-s2 $PP^2_RR$ est homéomorphe à $lquotient(SS^2, equ(SS^2))$, puisque l'on identifie les points antipodaux de $SS^2$, on peut considérer seulement l'hémisphère nord en identifiant les points antipodaux du cercle de l'équateur :
  #figure(
    cetz.canvas({
      import cetz.draw: *

      set-style(
        stroke: (cap: "round", join: "round"),
        mark: (transform-shape: false, anchor: "center"),
      )
      circle((0, 0), radius: 2)
      circle((0, 0), radius: (2, 1), stroke: (dash: "dashed"))

      arc-through((4, 0), (6, 2), (8, 0))
      circle((6, 0), radius: (2, 1), stroke: (dash: "dashed"))

      line((2.5, 0), (3.5, 0), mark: (end: "stealth", fill: black))

      set-style(mark: (start: "stealth", end: "stealth"))
      mark(
        (2 * calc.cos(calc.pi / 4), calc.sin(calc.pi / 4)),
        -30deg,
        fill: red,
        stroke: red,
      )
      mark(
        (-2 * calc.cos(calc.pi / 4), -calc.sin(calc.pi / 4)),
        150deg,
        fill: red,
        stroke: red,
      )
      mark(
        (-2 * calc.cos(calc.pi / 4), calc.sin(calc.pi / 4)),
        25deg,
        fill: blue,
        stroke: blue,
      )
      mark(
        (2 * calc.cos(calc.pi / 4), -calc.sin(calc.pi / 4)),
        -155deg,
        fill: blue,
        stroke: blue,
      )
      mark((0, 2), 0deg, fill: green, stroke: green)
      mark((0, -2), 180deg, fill: green, stroke: green)

      mark(
        (6 + 2 * calc.cos(calc.pi / 4), calc.sin(calc.pi / 4)),
        -30deg,
        fill: red,
        stroke: red,
      )
      mark(
        (6 - 2 * calc.cos(calc.pi / 4), -calc.sin(calc.pi / 4)),
        150deg,
        fill: red,
        stroke: red,
      )
      mark(
        (6 - 2 * calc.cos(calc.pi / 4), calc.sin(calc.pi / 4)),
        25deg,
        fill: blue,
        stroke: blue,
      )
      mark(
        (6 + 2 * calc.cos(calc.pi / 4), -calc.sin(calc.pi / 4)),
        -155deg,
        fill: blue,
        stroke: blue,
      )
    }),
    caption: "Passage de la sphère à la demi-sphère.",
  )
  On peut déformer continûment cette demi-sphère sur un disque en identifiant les points antipodaux du cercle :
  #figure(
    cetz.canvas({
      import cetz.draw: *

      set-style(
        stroke: (cap: "round", join: "round"),
        mark: (transform-shape: false, anchor: "center"),
      )

      arc-through((-2, 0), (0, 2), (2, 0))
      circle((0, 0), radius: (2, 1), stroke: (dash: "dashed"))

      circle((6, 0), radius: 2)

      line((2.5, 0), (3.5, 0), mark: (end: "stealth", fill: black))

      set-style(mark: (start: "stealth", end: "stealth"))
      mark(
        (2 * calc.cos(calc.pi / 4), calc.sin(calc.pi / 4)),
        -30deg,
        fill: red,
        stroke: red,
      )
      mark(
        (-2 * calc.cos(calc.pi / 4), -calc.sin(calc.pi / 4)),
        150deg,
        fill: red,
        stroke: red,
      )
      mark(
        (-2 * calc.cos(calc.pi / 4), calc.sin(calc.pi / 4)),
        25deg,
        fill: blue,
        stroke: blue,
      )
      mark(
        (2 * calc.cos(calc.pi / 4), -calc.sin(calc.pi / 4)),
        -155deg,
        fill: blue,
        stroke: blue,
      )

      circle((6, 0), radius: 2, stroke: none, fill: luma(50%, 40%))
      mark((6, 2), 0deg, fill: red, stroke: red)
      mark((8, 0), -90deg, fill: blue, stroke: blue)
      mark((6, -2), 180deg, fill: red, stroke: red)
      mark((4, 0), 90deg, fill: blue, stroke: blue)
    }),
    caption: "Passage de la demi-sphère au disque.",
  )
  On peut déformer continûment ce disque sur le carré en identifiant les points sur le bord du carré et en conservant l'orientation :
  #figure(
    cetz.canvas({
      import cetz.draw: *

      set-style(
        stroke: (cap: "round", join: "round"),
        mark: (transform-shape: false, anchor: "center"),
      )
      circle((0, 0), radius: 2)
      line((4, 2), (8, 2), (8, -2), (4, -2), (4, 2))

      line((2.5, 0), (3.5, 0), mark: (end: "stealth", fill: black))

      set-style(mark: (start: "stealth", end: "stealth", symbol: "stealth"))

      circle((0, 0), radius: 2, stroke: none, fill: luma(50%, 40%))
      mark((0, 2), 0deg, fill: red, stroke: red)
      mark((2, 0), -90deg, fill: blue, stroke: blue)
      mark((0, -2), 180deg, fill: red, stroke: red)
      mark((-2, 0), 90deg, fill: blue, stroke: blue)

      line(
        (4, 2),
        (8, 2),
        (8, -2),
        (4, -2),
        (4, 2),
        stroke: none,
        fill: luma(50%, 40%),
        mark: none,
      )
      mark((6, 2), 0deg, fill: red, stroke: red)
      mark((8, 0), -90deg, fill: blue, stroke: blue)
      mark((6, -2), 180deg, fill: red, stroke: red)
      mark((4, 0), 90deg, fill: blue, stroke: blue)
    }),
    caption: "Passage du disque au carré.",
  )
  On peut extraire dans ce carré une bande de Möbius :
  #figure(
    cetz.canvas({
      import cetz.draw: *

      set-style(
        stroke: (cap: "round", join: "round"),
        mark: (transform-shape: false, anchor: "center"),
      )
      line((-2, 2), (2, 2), (2, -2), (-2, -2), (-2, 2), fill: luma(50%, 40%))
      line((4, 2), (8, 2), (8, -2), (4, -2), (4, 2))
      line(
        (5.5, 2),
        (6.5, 2),
        (6.5, -2),
        (5.5, -2),
        (5.5, 2),
        fill: luma(50%, 40%),
        stroke: (dash: "dashed"),
      )
      line(
        (5, -1.985),
        (5, 1.83),
        stroke: green,
        mark: (end: "stealth", fill: green),
      )
      line(
        (7, -1.985),
        (7, 1.83),
        stroke: green,
        mark: (end: "stealth", fill: green),
      )

      content((6, 0), $M$)
      // content((4.5, 0), $D$)

      line((2.5, 0), (3.5, 0), mark: (end: "stealth", fill: black))

      set-style(mark: (start: "stealth", end: "stealth", symbol: "stealth"))

      mark((0, 2), 0deg, fill: red, stroke: red)
      mark((2, 0), -90deg, fill: blue, stroke: blue)
      mark((0, -2), 180deg, fill: red, stroke: red)
      mark((-2, 0), 90deg, fill: blue, stroke: blue)

      mark((6, 2), 0deg, fill: red, stroke: red)
      mark((8, 0), -90deg, fill: blue, stroke: blue)
      mark((6, -2), 180deg, fill: red, stroke: red)
      mark((4, 0), 90deg, fill: blue, stroke: blue)
    }),
    caption: "Découpage d'une bande de Möbius.",
  )
  On peut recoller les parties restantes en suivant l'orientation des flèches bleues, puis celle des flèches rouges pour vérifier que $D$ est homéomorphe à $BB^2$ :
  #figure(
    cetz.canvas({
      import cetz.draw: *

      set-style(
        stroke: (cap: "round", join: "round"),
        mark: (transform-shape: false, anchor: "center"),
      )
      line(
        (-2, 2),
        (-0.5, 2),
        (-0.5, -2),
        (-2, -2),
        (-2, 2),
        fill: luma(50%, 40%),
      )
      line((0.5, 2), (2, 2), (2, -2), (0.5, -2), (0.5, 2), fill: luma(50%, 40%))

      line(
        (-1, -1.985),
        (-1, 1.83),
        stroke: green,
        mark: (end: "stealth", fill: green),
      )
      line(
        (1, -1.985),
        (1, 1.83),
        stroke: green,
        mark: (end: "stealth", fill: green),
      )

      line((4, 2), (7, 2), (7, -2), (4, -2), (4, 2), fill: luma(50%, 40%))
      line((5.5, 2), (5.5, -2))

      line(
        (6.5, -1.985),
        (6.5, 1.83),
        stroke: green,
        mark: (end: "stealth", fill: green),
      )
      line(
        (4.5, 1.985),
        (4.5, -1.83),
        stroke: green,
        mark: (end: "stealth", fill: green),
      )

      circle((11, 0), radius: 2, fill: luma(50%, 40%))
      circle((11, 0), radius: 1.65, stroke: green)
      line((11, 2), (11, -2))

      line((2.5, 0), (3.5, 0), mark: (end: "stealth", fill: black))
      line((7.5, 0), (8.5, 0), mark: (end: "stealth", fill: black))

      content((-1.5, 0), $D$)

      set-style(mark: (start: "stealth", end: "stealth", symbol: "stealth"))

      mark((-1.25, 2), 0deg, fill: red, stroke: red)
      mark((1.25, 2), 0deg, fill: red, stroke: red)
      mark((2, 0), -90deg, fill: blue, stroke: blue)
      mark((-1.25, -2), 180deg, fill: red, stroke: red)
      mark((1.25, -2), 180deg, fill: red, stroke: red)
      mark((-2, 0), 90deg, fill: blue, stroke: blue)

      mark((6.25, 2), 0deg, fill: red, stroke: red)
      mark((4.75, 2), 180deg, fill: red, stroke: red)
      mark((5.5, 0), 90deg, fill: blue, stroke: blue)
      mark((6.25, -2), 180deg, fill: red, stroke: red)
      mark((4.75, -2), 0deg, fill: red, stroke: red)

      mark((11, 0), 90deg, fill: blue, stroke: blue)
      mark((11, 1.5), 90deg, fill: red, stroke: red)
      mark((11, -1.5), 90deg, fill: red, stroke: red)
    }),
    caption: "Recollage du disque fermé.",
  )
  De plus $M inter D = partial M = partial D$ est homéomorphe à $partial BB^2 = SS^1$.

  Puisque les déformations à chaque étapes sont continues et préservent les points identifiés, on a décomposé $PP^2_RR$ comme une union $M union D$ tels que $M$ est homéomorphe à une bande de Möbius, $D$ est homéomorphe à $BB^2$ et $M inter D$ est homéomorphe à $SS^1$.
])

#remark([
  Même si les figures de la démonstration précédente ne semblent pas rigoureuses, les flèches qui indiquent l'orientation et la continuité réciproque des déformations effectuées permettent de s'assurer que l'on a bien construit un homéomorphisme.
])

== Non-plongement dans $RR^3$

#definition([
  Soit $X$ et $Y$ deux espaces topologiques, $func(f, X, Y)$ une application.
  On dit que $f$ est un _plongement de $X$ dans $Y$_ si elle induit un homéomorphisme de $X$ dans $f(X)$.
])

#theorem([
  Il n'existe pas de plongement de $PP^2_RR$ dans $RR^3$.
]) <thm-non-plongement-p2-r3>

#proof([
  Supposons par l'absurde qu'il existe un plongement $func(f, PP^2_RR, RR^3)$. \
  D'après la @prop-homeo-p2-mobius-disque $PP^2_RR = M union D$ où $M$ est homéomorphe à une bande de Möbius, $D$ est homéomorphe à $BB^2$ et $M inter D = partial M = partial D$ est homéomorphe à $SS^1$, on identifie $PP^2_RR$, $M$ et $D$ avec leurs images $f(PP^2_RR)$, $f(M)$ et $f(D)$ dans $RR^3$.

  L'espace $RR^3 without M$ est homotopiquement équivalent à $RR^3 without C$ où $C$ le cercle central de $M$ est homéomorphe à $SS^1$. D'après le @cor-homotopie-equ et la @prop-homologie-complementaire-s1 on a :
  $
    H_(1)(RR^3 without M) tilde.eq H_(1)(RR^3 without C) tilde.eq ZZ
  $
  et on déduit des propositions menant à la @prop-homologie-complementaire-s1 qu'un générateur de $H_(1)(RR^3 without M)$ est donné par un $1$-simplexe singulier $func(sigma, Delta^1, RR^3 without M)$ dont l'image est un cercle enlacé autour de $M$.

  De plus $partial M$ est homéomorphe à $SS^1$. D'après la @prop-homologie-complementaire-s1 on a :
  $
    H_(1)(RR^3 without partial M) tilde.eq ZZ
  $
  de la même manière un générateur de $H_(1)(RR^3 without partial M)$ est donné par un $1$-simplexe singulier $func(tau, Delta^1, RR^3 without partial M)$ dont l'image est un cercle enlacé autour de $partial M$ avec la même orientation que $sigma$.

  Soit $func(i, RR^3 without M, RR^3 without partial M)$ l'inclusion canonique.
  Alors $i compose sigma$ est homotope à deux cercles enlacés autour de $partial M$ avec la même orientation que $sigma$ et qui s'intersectent en un point :

  #figure(
    cetz.canvas({
      import cetz.draw: *

      set-style(
        stroke: (cap: "round", join: "round"),
        mark: (transform-shape: false, anchor: "center"),
      )

      let circle-3d(center, radius, ran: (0, 101)) = {
        range(..ran).map(x => (
          center.at(0) + radius * calc.cos(2 * calc.pi * x / 100),
          center.at(1),
          center.at(2) + radius * calc.sin(2 * calc.pi * x / 100),
        ))
      }

      let mobius(rt) = {
        for t in range(rt + 1) {
          t = 4 * calc.pi * t / rt
          (
            (
              (1 - 1 / 2 * calc.sin(t / 2)) * calc.sin(t),
              (1 - 1 / 2 * calc.sin(t / 2)) * calc.cos(t),
              1 / 2 * calc.cos(t / 2),
            ),
          )
        }
      }

      let mob = mobius(1000)
      let circ1 = circle-3d((-0.97, -0.2, 0), 0.7)
      let circ2 = circle-3d((3.65, -0.2, 0), 0.35)
      let circ3 = circle-3d((4.43, 0, 0), 0.35)

      line(..circ1, stroke: red)
      line(
        ..mob.slice(435, 950),
        mob.at(480),
        ..mob.slice(435, 480).rev(),
        ..mob.slice(0, 435).rev(),
        ..mob.slice(992, 1001).rev(),
        fill: rgb("#0074d9bb"),
      )
      line(..circ1.slice(0, 30), stroke: red)

      line((2, 0), (3, 0), mark: (end: "stealth", fill: black))

      line(..circ2, stroke: red)
      line(..circ3, stroke: red)
      line(..mob.map(it => (it.at(0) + 5, it.at(1), it.at(2))))
      line(..circ2.slice(0, 30), stroke: red)
      line(..circ3.slice(0, 30), stroke: red)


      set-style(mark: (stroke: red, fill: red, symbol: "stealth"))
      mark((-0.97, -0.51), 12deg)
      mark((3.65, -0.35), 13deg)
      mark((4.43, -0.15), 12deg)
    }),
    caption: [Homotopie de $i compose sigma$.],
  )

  Puisque leur orientation est la même, la classe des deux cercles dans $H_(1)(RR^3 without partial M)$ est $overline(tau)$, on en déduit que $H_(1)(i)(overline(sigma)) = 2 overline(tau)$, donc $H_(1)(i)$ est la multiplication par 2.

  Enfin $D$ est homéomorphe à $BB^2$. D'après la @prop-homologie-complementaire-b2 on a :
  $
    H_(1)(RR^3 without D) tilde.eq H_(1)(SS^2) tilde.eq 0
  $
  et d'après le @thm-mayer-vietoris la suite suivante est exacte en $H_(1)(RR^3 without partial M)$ :
  #align(
    center,
    [
      #commutative-diagram(
        node-padding: (40pt, 40pt),
        padding: 7pt,
        node(
          (0, 2),
          $ZZ tilde.eq H_(1)(RR^3 without M) plus.circle 0 tilde.eq H_(1)(RR^3 without D)$,
        ),
        node((0, 3), $ZZ tilde.eq H_(1)(RR^3 without partial M)$),
        node((0, 4), $H_(0)(RR^3 without PP^2_RR)$),

        arr((0, 2), (0, 3), $H_(1)(i)$),
        arr((0, 3), (0, 4), $partial_0$),
      )],
  )
  Par exactitude $ker(partial_0) = im(H_(1)(i)) tilde.eq 2ZZ$, d'où $partial_(0)(1) != 0$ et $2 partial_(0)(1) = partial_(0)(2) = 0$, donc $partial_(0)(1)$ est non-nul et d'ordre 2 dans $H_(0)(RR^3 without PP^2_RR)$.

  D'après la @prop-h0-abelien-libre $H_(0)(RR^3 without PP^2_RR)$ est un groupe abélien libre, il n'existe aucun élément non-nul d'ordre 2, d'où une contradiction.

  Donc il n'existe pas de plongement de $PP^2_RR$ dans $RR^3$.
])

#pagebreak()

#heading([Conclusion], numbering: none)

#proof(
  of: [du @thm-rectangle-inscrit[Théorème]],
  [
    Soit $C$ une courbe de Jordan. \
    On représente un rectangle par 2 paires de sommets formant les diagonales :
    #figure(
      cetz.canvas({
        import cetz.draw: *

        set-style(
          stroke: (cap: "round", join: "round"),
          mark: (transform-shape: false, anchor: "center"),
        )
        line((0, 0), (4, 2), stroke: red)
        line((0, 2), (4, 0), stroke: blue)
        line((0, 0), (4, 0), (4, 2), (0, 2), (0, 0))

        set-style(content: (padding: 0.1))
        content((0, 2), text($a$, blue), anchor: "south-east")
        content((4, 2), text($b$, red), anchor: "south-west")
        content((4, 0), text($c$, blue), anchor: "north-west")
        content((0, 0), text($d$, red), anchor: "north-east")
      }),
      caption: [2 paires de sommets formant un rectangle.],
    )
    On note $P := C times C$.
    Cette représentation nous permet de caractériser un rectangle de la manière suivante : 2 paires #underline("non-ordonnées") de $P$ forment un rectangle si et seulement si elles sont distinctes, ont le même milieu et ont la même distance.

    2 paires ordonnées pourraient être distinctes et décrire la même diagonale.
    On étudie $Q$ le quotient de $P$ par la relation d'équivalence $~$ où pour tout $(u, v) in P$, on a $(u, v) ~ (v, u)$.

    Alors on définit l'application :
    $
      func(f, P, RR^2 times RR, (u, v), ((u+v)/2, d(u, v)))
    $
    elle décrit une surface dans $RR^2 times RR tilde.eq RR^3$ :
    #figure(
      cetz.canvas({
        import cetz.draw: *

        set-style(
          stroke: (cap: "round", join: "round"),
          mark: (transform-shape: false, anchor: "center", fill: black),
        )
        line((-3.5, 0, 0), (3.5, 0, 0), mark: (end: "stealth"))
        line((0, -2, 0), (0, 3.5, 0), mark: (end: "stealth"))
        line((0, 0, -3.5), (0, 0, 3.5), mark: (end: "stealth"))
        let jc = superformula-3d(
          7,
          3,
          4,
          10,
          samples: 1000,
        ).map(it => it.map(e => 1.75 * e))
        line(..jc, close: true)

        line(
          (-1.9, 0, -0.44),
          (1.15, 0, 1.33),
          stroke: (dash: "dashed", paint: red),
        )
        line(
          (-0.375, 0, 0.445),
          (-0.375, 3.18, 0.445),
          stroke: (dash: "dashed", paint: blue),
        )

        set-style(circle: (radius: 0.03, fill: red, stroke: red))
        circle((-1.9, 0, -0.44))
        circle((1.15, 0, 1.33))
        circle((-0.375, 0, 0.445), fill: blue, stroke: blue)
        circle((-0.375, 3.18, 0.445), fill: blue, stroke: blue)

        set-style(content: (padding: 0.1))
        content((-1.9, 0, -0.44), $u$, anchor: "south-east")
        content((1.15, 0, 1.33), $v$, anchor: "north-west")
        content(
          (-0.375, 3.18, 0.445),
          $f(u, v)$,
          anchor: "south-east",
        )
      }),
      caption: [Image d'une paire par l'application $f$.],
    )
    Pour tout $(u, v) in P$, on a $f(u, v) = f(v, u)$, de plus $f$ est continue, donc $f$ passe au quotient pour $~$ et induit une application continue $func(phi, Q, RR^3)$.

    Alors $p, q in Q$ forment un rectangle si et seulement si $p != q$ et $phi(p) = phi(q)$.
    Il existe un rectangle inscrit dans $C$ si et seulement $phi$ n'est pas injective.

    Supposons par l'absurde que $phi$ est injective. \

    Alors $Q$ est compact et la restriction $func(phi, Q, phi(Q))$ est une bijection continue, d'après le @thm-bijection-continue-compact $func(phi, Q, phi(Q))$ est un homéomorphisme.

    Puisque $C$ est paramétrée par une application continue $func(gamma, [0, 1], RR^2)$, on peut paramétrer $Q$ par l'application $func(mu := overline((gamma, gamma)), [0, 1]^2, lquotient((RR^2 times RR^2), thin~))$.
    Mais par définition $gamma(0) = gamma(1)$, pour tout $t in [0, 1]$, on a $mu(0, t) = mu(1, t)$ et $mu(t, 0) = mu(t, 1)$, de plus pour tout $(a, b) in [0, 1]^2$, on a $mu(a, b) = mu(b, a)$.

    Pour éviter ça, on étudie le quotient de $[0, 1]^2$ par la relation d'équivalence $equ(1)$ où pour tout $t in [0, 1]$, on a $(0, t) equ(1) (1, t)$ et $(t, 0) equ(1) (t, 1)$, et par la relation d'équivalence $equ(2)$ où pour tout $(a, b) in [0, 1]^2$, on a $(a, b) equ(2) (b, a)$ :
    #figure(
      cetz.canvas({
        import cetz.draw: *

        set-style(
          stroke: (cap: "round", join: "round"),
          mark: (transform-shape: false, anchor: "center", fill: black),
          content: (padding: 0.1),
        )

        line((0, 0), (0, 3), (3, 3), (3, 0), (0, 0), fill: luma(50%, 40%))

        content((0, 0), $0$, anchor: "north-east")
        content((0, 3), $1$, anchor: "east")
        content((3, 0), $1$, anchor: "north")

        line((3.5, 1.5), (4.5, 1.5), mark: (end: "stealth"))
        content((4, 1.5), $equ(1)$, anchor: "south")

        line(
          (5, 0),
          (5, 3),
          (8, 3),
          (8, 0),
          (5, 0),
          fill: luma(50%, 40%),
          stroke: none,
        )
        line((5, 0), (5, 3), stroke: (dash: "dashed", paint: blue))
        line((8, 3), (8, 0), stroke: (dash: "dashed", paint: blue))
        line((5, 3), (8, 3), stroke: (dash: "dashed", paint: red))
        line((8, 0), (5, 0), stroke: (dash: "dashed", paint: red))

        content((5, 0), $0$, anchor: "north-east")
        content((5, 3), $1$, anchor: "east")
        content((8, 0), $1$, anchor: "north")

        line((8.5, 1.5), (9.5, 1.5), mark: (end: "stealth"))
        content((9, 1.5), $equ(2)$, anchor: "south")

        line((10, 0), (13, 0), (13, 3), fill: luma(50%, 40%))
        line((10, 0), (13, 3), stroke: (dash: "dashed", paint: red))

        content((10, 0), $0$, anchor: "north-east")
        content((13, 0), $1$, anchor: "north")

        set-style(mark: (start: "stealth", end: "stealth", symbol: "stealth"))
        mark((5, 1.5), 90deg, stroke: blue, fill: blue)
        mark((8, 1.5), 90deg, stroke: blue, fill: blue)
        mark((6.5, 0), 0deg, stroke: red, fill: red)
        mark((6.5, 3), 0deg, stroke: red, fill: red)
        mark((11.5, 0), 0deg, stroke: purple, fill: purple)
        mark((13, 1.5), 90deg, stroke: purple, fill: purple)
      }),
      caption: [Quotient de $[0, 1]^2$ par $equ(1)$ et $equ(2)$],
    )
    On découpe le triangle pour recoller les flèches et obtenir une bande de Möbius $M$ :
    #figure(
      cetz.canvas({
        import cetz.draw: *

        set-style(
          stroke: (cap: "round", join: "round"),
          mark: (transform-shape: false, anchor: "center", fill: black),
          content: (padding: 0.1),
        )

        line((1.5, 1.5), (3, 0), stroke: (dash: "dashed", paint: blue))
        line((0, 0), (3, 0), (3, 3), (0, 0), fill: luma(50%, 40%))

        content((0, 0), $0$, anchor: "north-east")
        content((3, 0), $1$, anchor: "north")

        line((3.5, 1.5), (4.5, 1.5), mark: (end: "stealth"))

        line(
          (8, 1.5),
          (6.5, 3),
          (5, 1.5),
          (6.5, 0),
          fill: luma(50%, 40%),
          stroke: none,
        )
        line((8, 1.5), (6.5, 3), stroke: (dash: "dashed", paint: blue))
        line((5, 1.5), (6.5, 3))
        line((8, 1.5), (6.5, 0))
        line((5, 1.5), (6.5, 0), stroke: (dash: "dashed", paint: blue))
        line((6.5, 0), (6.5, 3))

        set-style(mark: (start: "stealth", end: "stealth", symbol: "stealth"))

        mark((2.25, 0.75), -45deg, stroke: blue, fill: blue)
        mark((3, 1.5), 90deg, stroke: purple, fill: purple)
        mark((1.5, 0), 0deg, stroke: purple, fill: purple)

        mark((6.5, 1.5), 90deg, stroke: purple, fill: purple)
        mark((5.75, 0.75), -45deg, stroke: blue, fill: blue)
        mark((7.25, 2.25), 135deg, stroke: blue, fill: blue)
      }),
      caption: [Recollement d'une bande de Möbius.],
    )

    Alors $mu$ passe au quotient pour $equ(1)$ et $equ(2)$, et la déformation est continue, donc $mu$ induit un homéomorphisme $func(lambda, M, Q)$.
    Par composition $func(phi compose lambda, M, phi(Q))$ est un homéomorphisme.

    Il vérifie $(phi compose lambda)(partial M) = C subset RR^3$.
    En effet $partial M$ est identifié avec la diagonale de $[0, 1]^2$, donc avec les points $(a, a) in [0, 1]^2$, ils sont envoyés sur $overline((u, u)) in Q$ par $mu$, puis sur les $(u, 0) in C subset RR^3$ par $phi$.

    D'après le théorème de Jordan $C$ est homéomorphe à $SS^1$ et $D$ la partie de $RR^2$ délimitée par $C$ est homéomorphe à $BB^2$, d'après la @prop-homeo-p2-mobius-disque en collant $M$ à $D$ le long de leur bord $partial M = partial D = C$, on obtient $PP^2_RR$.
    Donc $phi compose lambda$ induit un plongement de $PP^2_RR$ dans $RR^3$.

    Mais d'après le @thm-non-plongement-p2-r3 il n'existe pas de plongement de $PP^2_RR$ dans $RR^3$, d'où une contradiction.

    Donc $phi$ n'est pas injective et il existe un rectangle inscrit dans $C$.
  ],
)

#pagebreak()

#heading([Annexe], numbering: none)

#theorem(
  number: [A],
  [
    Soit $K$ un compact de $RR^n$, $L$ une partie de $RR^p$ et $func(f, K, L)$ une bijection continue.
    Alors $f$ est un homéomorphisme.
  ],
) <thm-bijection-continue-compact>

#proof([
  Notons $g := f^(-1)$.
  Soit $F$ un fermé de $K$.
  Puisque $K$ est compact et $F$ est fermé, $F$ est compact.
  Puisque $f$ est continue et $F$ est compact, $g^(-1)(F) = f(F)$ est compact.
  Puisque $g^(-1)(F)$ est compact, $g^(-1)(F)$ est fermé.
  Donc $f^(-1) = g$ est continue et $f$ est un homéomorphisme.
])

#bibliography("biblio.yml", full: true)

#v(1fr)

Document contenant 19873 caractères.
