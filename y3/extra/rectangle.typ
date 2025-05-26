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

#show: maths.with(
  title: "Problème du rectangle inscrit",
  authors: ("Emanuel Morille",),
  note: [Avec les conseils de Jean-Baptiste Campesato],
  color: "#718355",
  date: true,
)

#pagebreak()

#heading([Introduction], numbering: none)

Le questionnement à l'origine de ce sujet est le _problème du carré inscrit_, énoncé par #link("https://fr.wikipedia.org/wiki/Otto_Toeplitz")[Otto Toeplitz] en 1911 de la manière suivante :

#align(center)[_"Toute courbe de Jordan admet-elle un carré inscrit ?"_]

Bien que cette question fut l'objet de nombreuses recherches, elle n'est toujours pas résolue, en revanche nous sommes capables d'en démontrer une version simplifiée :

#align(center)[_"Toute courbe de Jordan admet-elle un #strike("carré") rectangle inscrit ?"_]

C'est donc cet énoncé que nous appellerons le _problème du rectangle inscrit_.

Par exemple dans le cas d'un cercle, on peut évidemment toujours trouver une infinité de carrés et de rectangles inscrits, le problème devient plus difficile lorsque la courbe est quelconque.

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
      caption: [Un carré inscrit.],
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
      caption: [Un rectangle inscrit.],
    ) <fig-courbe-rectangle>
  ],
)

Dans la suite nous allons étudier l'homologie singulière qui nous permettra de démontrer un résultat très important dans la résolution du problème. Commençons d'abord par définir quelques notions du sujet.

#definition([
  Soit $C$ une partie de $RR^2$.
  On dit que $C$ est une _courbe de Jordan_ s'il existe une fonction continue $func(gamma_C, [0, 1], RR^2)$ telle que :
  - $C$ est l'image de $gamma_C$ : $im(gamma_C) = C$.
  - $C$ est fermée : $gamma_(C)(0) = gamma_(C)(1)$.
  - $C$ est simple : $gamma_C$ est injective sur $[0, 1[$, c'est-à-dire $forall x, y in [0, 1[, gamma_(C)(x) = gamma_(C)(y) => x = y$.
])

#example([
  Le cercle $C$ de la @fig-cercle-carre est bien une courbe de Jordan, en effet on pose :
  $ func(gamma_C, [0, 1], RR^2, (x, y), (cos(2 pi x), sin(2 pi x))) $
  Alors $gamma_C$ est bien continue, de plus :
  - On a clairement $im(gamma_C) = C$.
  - On a $gamma_(C)(0) = (1, 0) = gamma_(C)(1)$.
  - Pour $x in [0, 1[$, on a $2pi x in [0, 2pi[$, donc $gamma_C$ est injective sur $[0, 1[$.
])

#definition([
  Soit $C$ une courbe de Jordan de $RR^2$ et $R := {a, b, c, d}$ un rectangle de $RR^2$.
  On dit que le rectangle $R$ est _inscrit dans $C$_ si $a, b, c, d in C$.
])

#example([
  Le carré $R := {(sqrt(2)  slash  2, sqrt(2)  slash  2), (-sqrt(2)  slash  2, sqrt(2)  slash  2), (-sqrt(2)  slash  2, -sqrt(2)  slash  2), (sqrt(2)  slash  2, -sqrt(2)  slash  2)}$ est bien inscrit dans le cercle $C$ de la @fig-cercle-carre, en effet :
  - On a $gamma_(C)(1 slash 8) = (sqrt(2) slash 2, sqrt(2) slash 2)$, donc $(sqrt(2) slash 2, sqrt(2) slash 2) in C$.

  - On a $gamma_(C)(3 slash 8) = (-sqrt(2) slash 2, sqrt(2) slash 2)$, donc $(-sqrt(2) slash 2, sqrt(2) slash 2) in C$.

  - On a $gamma_(C)(5 slash 8) = (-sqrt(2) slash 2, -sqrt(2) slash 2)$, donc $(-sqrt(2) slash 2, -sqrt(2) slash 2) in C$.

  - On a $gamma_(C)(7 slash 8) = (sqrt(2) slash 2, -sqrt(2) slash 2)$, donc $(sqrt(2) slash 2, -sqrt(2) slash 2) in C$.
])

#theorem([
  Soit $C$ une courbe de Jordan de $RR^2$.
  Alors il existe un rectangle inscrit dans $C$.
]) <thm-rectangle-inscrit>

#pagebreak()

= Bases de théorie des catégories

== Catégories

#definition([
  Une _catégorie_ $cal(C)$ est la donnée de :
  - Une classe $ob(cal(C))$ dont les éléments sont appelés les _objets de $cal(C)$_.
  - Une classe $hom(cal(C))$ dont les éléments sont appelés les _morphismes de $cal(C)$_. \
    Un morphisme $func(f) in hom(cal(C))$ a un _domaine_ $X in ob(cal(C))$ et un _codomaine_ $Y in ob(cal(C))$.
    On note alors ce morphisme $func(f, X, Y)$ et $hom(X, Y)$ l'ensemble des morphismes de $X$ dans $Y$.
  - Pour tout objets $X, Y, Z in ob(cal(C))$, une _composition_ :
    $ func(compose, hom(Y, Z) times hom(X, Y), hom(X, Z)). $
  - Pour tout objet $X in ob(cal(C))$, un morphisme _identité_ :
    $ func(id_X, X, X). $
  Vérifiant les propriétés suivantes pour tout objets $X, Y, Z, T in ob(cal(C))$ :
  - _Associativité_ : Pour tout morphismes $func(f, X, Y)$, $func(g, Y, Z)$ et $func(h, Z, T)$, on a :
    $ h compose (g compose f) = (h compose g) compose f. $
  - _Identité_ : Pour tout morphisme $func(f, X, Y)$, on a :
    $ id_Y compose f = f = f compose id_X. $
])

#example([
  La catégorie $sans("Ab")$ des groupes abéliens :
  - Les objets de $sans("Ab")$ sont les groupes abéliens.
  - Les morphismes de $sans("Ab")$ sont les morphismes de groupes.
])

#example([
  Un _groupe gradué_ est un groupe $G$ muni d'une famille de sous-groupes $sequence(G_i, ind: i, dom: I)$ telle que $G = plus.circle.big_(i in I) G_i$.
  Pour tout $i in I$, un élément non-nul de $G_i$ est dit _homogène de degré $i$_.

  Soit $G := plus.circle.big_(i in I) G_i$ et $H := plus.circle.big_(i in I) H_i$ deux groupes gradués.
  Un _morphisme de groupes gradués_ est un morphisme de groupes $func(phi, G, H)$ tel que pour tout $i in I$, on a $phi(G_i) subset H_i$.

  On définit ainsi la catégorie $sans("GrAb")$ des groupes abéliens gradués :
  - Les objets de $sans("GrAb")$ sont les groupes abéliens gradués. \
  - Les morphismes de $sans("GrAb")$ sont les morphismes de groupes gradués. \
])

#example([
  La catégorie $sans("Top")$ des espaces topologiques :
  - Les objets de $sans("Top")$ sont les espaces topologiques.
  - Les morphismes de $sans("Top")$ sont les applications continues.
])

#example([
  Une paire d'espaces topologiques est un espace topologique $X$ muni d'une partie $A$ de lui-même.
  On la note $(X, A)$.

  Soit $(X, A)$ et $(Y, B)$ deux paires d'espaces topologiques.
  Un _morphisme de paires_ est une application continue $func(f, X, Y)$ telle que $f(A) subset B$.
  On le note $func(f, (X, A), (Y, B))$.

  On définit ainsi catégorie $sans("Top")_2$ des paires d'espaces topologiques :
  - Les objets de $sans("Top")_2$ sont les paires d'espaces topologiques.
  - Les morphismes de $sans("Top")_2$ sont les morphismes de paires.
])

#example([
  Soit $(X, <=)$ un ensemble partiellement ordonné. On définit la catégorie $cal(C)(X, <=)$ :
  - Les objets de $cal(C)(X, <=)$ sont les éléments de $X$.
  - Pour tout $x, y in X$, si $x <= y$, on a un morphisme $func(f_(x, y), x, y)$.
  - Pour tout $x, y, z in X$, si $x <= y$ et $y <= z$, on a bien $x <= z$ et une composition $f_(y, z) compose f_(x, y) = f_(x, z)$.
  - Pour tout $x in X$, on a bien $x <= x$ et un morphisme identité $f_(x, x)$.
])

#definition([
  Soit $cal(C)$ une catégorie.
  La _catégorie opposée (ou duale) de $cal(C)$_, notée $cal(C)^sans("op")$, est la catégorie dont les objets sont les objets $cal(C)$ et dont les morphismes sont les morphismes de $cal(C)$ dont le domaine et le codomaine sont inversés.
])

#example([
  Soit $(X, <=)$ un ensemble partiellement ordonné.
  Alors on a $cal(C)(X, <=)^sans("op") = cal(C)(X, prec.eq)$ où pour tout $x, y in X$, on a $x prec.eq y$ si et seulement si $y <= x$.
])

== Foncteurs

#definition([
  Soit $cal(C)$ et $cal(D)$ deux catégories.
  Un _foncteur (covariant) $F$ de $cal(C)$ vers $cal(D)$_ est la donnée :
  - Pour tout objet $X in ob(cal(C))$, d'un objet $F(X) in ob(cal(D))$.
  - Pour tout objets $X, Y in ob(C)$ et morphisme $func(f, X, Y)$, d'un morphisme $func(F(f), F(X), F(Y))$.
  Vérifiant les propriétés suivantes pour tout objets $X, Y, Z in ob(cal(C))$ :
  - _Composition_ : Pour tout morphismes $func(f, X, Y)$ et $func(g, Y, Z)$, on a :
    $ F(g compose f) = F(g) compose F(f). $
  - _Identité_ : On a : $ F(id_X) = id_F(X). $
])

#example([
  Soit $cal(C)$ et $cal(D)$ deux catégories. On définit le foncteur covariant constant $func(C, cal(C), cal(D))$ :
  - On prend $D in cal(D)$, pour tout objet $X in ob(cal(C))$, on a $C(X) := D$.
  - Pour tout objets $X, Y in ob(cal(C))$ et morphisme $func(f, X, Y)$, on a $C(f) := id_D$.
])

#example([
  Soit $cal(C)$ une catégorie. On définit le foncteur covariant identité $func(id_cal(C), cal(C), cal(C))$ :
  - Pour tout objet $X in ob(cal(C))$, on a $id_cal(C)(X) := X$.
  - Pour tout objets $X, Y in ob(cal(C))$ et morphisme $func(f, X, Y)$, on a $id_cal(C)(f) := f$.
])

#definition([
  Soit $cal(C)$ et $cal(D)$ deux catégories. Un _foncteur contravariant_ est un foncteur covariant de la catégorie opposée $cal(C)^sans("op")$ vers $cal(D)$.
])

#example([
  Soit $KK$ un corps et $sans("Vect")$ la catégorie des $KK$-espaces vectoriels.
  On définit un foncteur contravariant $func(F, sans("Vect")^sans("op"), sans("Vect"))$ :
  - Pour tout $KK$-espace vectoriel $E in sans("Vect")$, on a $F(E) := E^*$.
  - Pour tout $KK$-espaces vectoriels $E, F in sans("Vect")$ et application linéaire $func(u, E, F)$, on a :
    $ func(F(u) := transpose(u), F^*, E^*). $
])

== Transformations naturelles <sec-transformation-naturelle>

#definition([
  Soit $cal(C)$ et $cal(D)$ deux catégories, $func(F, cal(C), cal(D))$ et $func(G, cal(C), cal(D))$ deux foncteurs covariants.
  Une _transformation naturelle $partial$ de $F$ vers $G$_ est la donnée pour tout objet $X in ob(cal(C))$, d'un morphisme $func(partial_X, F(X), G(X))$,
  vérifiant la propriété suivante pour tout objet $Y in ob(cal(C))$ et pour tout morphisme $func(f, X, Y)$, on a :
  $ partial_Y compose F(f) = G(f) compose partial_X $
  c'est-à-dire que le diagramme suivant est commutatif :
  #align(center)[#commutative-diagram(
      node-padding: (50pt, 40pt),
      padding: 10pt,
      node((0, 0), $F(X)$),
      node((0, 1), $F(Y)$),
      node((1, 0), $G(X)$),
      node((1, 1), $G(Y)$),
      arr((0, 0), (0, 1), $F(f)$),
      arr((1, 0), (1, 1), $G(f)$, label-pos: right),
      arr((0, 0), (1, 0), $partial_X$, label-pos: right),
      arr((0, 1), (1, 1), $partial_Y$),
    )]
])

#pagebreak()

= Catégorie $sans("Comp")$ des complexes de chaînes

== Complexes de chaînes

#definition([
  On appelle _complexe de chaînes_, noté $C_cdot$, une suite de groupes abéliens $sequence(C_(n))$ munie de morphismes de groupes $sequence(func(dif_n, C_(n), C_(n-1)))$ tels que pour tout $n in ZZ$, on a $dif_n dif_(n+1) = 0$.
])

#definition([
  Soit $C_cdot$ un complexe de chaînes et $n in ZZ$.
  - On appelle _$n$-cycle_ un élément de $Z_(n)(C_cdot) := ker(dif_n)$.
  - On appelle _$n$-bord_ un élément de $B_(n)(C_cdot) := im(dif_(n+1))$.
])

#proposition([
  Soit $C_cdot$ un complexe de chaînes.
  Alors pour tout $n in ZZ$, on a $B_(n)(C_cdot) subset Z_(n)(C_cdot)$.
])

#proof([
  Soit $n in ZZ$. Alors $dif_n dif_(n+1) = 0$, donc $B_(n)(C_cdot) = im(dif_(n+1)) subset ker(dif_n) = Z_(n)(C_cdot)$.
])

#definition([
  Soit $C_cdot$ un complexe de chaînes et $n in ZZ$.
  - On appelle _$n$#super("e") groupe d'homologie_ le groupe quotient $H_(n)(C_cdot) := lquotient(Z_(n)(C_cdot), B_(n)(C_cdot))$.
  - On appelle _homologie_ la somme directe des groupes $H_(cdot)(C_cdot) := plus.circle.big_(n in ZZ) H_(n)(C_cdot)$.
])

#definition([
  Soit $C_cdot$ un complexe de chaînes et $n in ZZ$.
  - On dit que $C_cdot$ est _exact en $C_(n)$_ si $H_(n)(C_cdot)$ est trivial, c'est-à-dire, $im(dif_(n+1)) = ker(dif_n)$.
  - On dit que $C_cdot$ est _exact_ si pour tout $n in ZZ$, il est exact en $C_(n)$.
  - On dit que $C_cdot$ est _acyclique_ si pour tout $n in ZZ without {0}$, il est exact en $C_(n)$.
])

== Morphismes de complexes

#definition([
  Soit $C_cdot$ et $D_cdot$ deux complexes de chaînes.
  On appelle _morphisme de complexes_, noté $func(phi_cdot, C_cdot, D_cdot)$, une suite de morphismes de groupes $sequence(func(phi_n, C_(n), D_(n)))$ telle que pour tout $n in ZZ$, on a $dif_n phi_n = phi_(n-1) dif_n$.
])

#proposition([
  Soit $C_cdot$, $D_cdot$ et $E_cdot$ trois complexes de chaînes, $func(phi_cdot, C_cdot, D_cdot)$ et $func(psi_cdot, D_cdot, E_cdot)$ deux morphismes de complexes.
  Alors la composition $func(psi_cdot compose phi_cdot, C_cdot, E_cdot)$ est un morphisme de complexes.
]) <prop-comp-composition>

#proof([
  Soit $n in ZZ$. Alors on a :
  $
    dif_n (psi_n compose phi_n) = psi_(n-1) dif_n phi_n = (psi_(n-1) compose phi_(n-1)) dif_n.
  $
  Donc $sequence(psi_n compose phi_n)$ est bien un morphisme de complexes.
])

#proposition([
  Soit $C_cdot$ un complexe de chaînes.
  Alors le morphisme identité $func(id_C_cdot, C_cdot, C_cdot)$ est un morphisme de complexes.
]) <prop-comp-identite>

#proof([
  Soit $n in ZZ$. Alors on a :
  $
    dif_n id_n = dif_n = id_(n-1) dif_n.
  $
  Donc $sequence(id_C_n)$ est bien un morphisme de complexes.
])

#proposition([
  Soit $C_cdot$ et $D_cdot$ deux complexes de chaînes, $func(phi_cdot, C_cdot, D_cdot)$ un morphisme de complexes.
  Alors pour tout $n in ZZ$, $phi_n$ induit un morphisme de groupes $func(H_(n)(phi), H_(n)(C_cdot), H_(n)(D_cdot))$.
])

#proof([
  Soit $n in ZZ$. \
  Soit $z in Z_(n)(C_cdot)$. Alors on a
  $dif_n phi_(n)(z) = phi_(n-1)(dif_n z) = phi_(n-1)(0) = 0$,
  donc $phi_(n)(z) in Z_(n)(D_cdot)$. \
  Soit $b in B_(n)(C_cdot)$. Alors il existe $c in C_(n+1)$ tel que $b = dif_(n+1) c$, et on a :
  $ phi_(n)(b) = phi_(n)(dif_(n+1) c) = dif_(n+1) phi_(n+1)(c) $
  donc $phi_(n)(b) in B_(n)(D_cdot)$.

  On considère $func(overline(phi_n), Z_(n)(C_cdot), H_(n)(D_cdot))$, alors $B_(n)(C_cdot) subset ker(overline(phi_n))$ et d'après la propriété universelle du groupe quotient le morphisme $overline(phi_n)$ induit bien un morphisme $func(H_(n)(phi), H_(n)(C_cdot), H_(n)(D_cdot))$.
])

#definition([
  Soit $C_cdot$ et $D_cdot$ deux complexes de chaînes, $func(phi_cdot, C_cdot, D_cdot)$ un morphisme de complexes.
  On note $func(H_(cdot)(phi), H_(cdot)(C_cdot), H_(cdot)(D_cdot))$ la somme directe $H_(cdot)(phi) := plus.circle.big_(n in ZZ) H_(n)(phi)$.
])

== La catégorie $sans("Comp")$

#definition([
  On appelle $sans("Comp")$ la catégorie des complexes de chaînes :
  - Les objets de $sans("Comp")$ sont les complexes de chaînes.
  - Les morphismes de $sans("Comp")$ sont les morphismes de complexes.
  - La composition de $sans("Comp")$ découle de la @prop-comp-composition.
  - Le morphisme identité de $sans("Comp")$ découle de @prop-comp-identite.
])

#theorem([
  Pour tout $n in ZZ$, le $n$#super("e") groupe d'homologie $H_n$ est un foncteur de $sans("Comp")$ vers $sans("Ab")$.
]) <thm-foncteur-comp-ab>

#proof([
  Soit $n in ZZ$.
  - Soit $C_cdot in ob(sans("Comp"))$ un complexe de chaînes.
    Alors le $n$#super("e") groupe d'homologie $H_(n)(C_cdot)$ est bien un groupe abélien.
  - Soit $C_cdot, D_cdot in ob(sans("Comp"))$ deux complexes de chaînes et $func(phi_cdot, C_cdot, D_cdot)$ un morphisme de complexes.
    Alors le morphisme induit $func(H_(n)(phi), H_(n)(C_cdot), H_(n)(D_cdot))$ est bien un morphisme de groupes.
  La propriété de composition découle de la @prop-comp-composition et la propriété d'identité découle de la @prop-comp-identite, donc $H_n$ est bien un foncteur de $sans("Comp")$ vers $sans("Ab")$.
])

#corollary([
  L'homologie $H_cdot$ est un foncteur de $sans("Comp")$ vers $sans("GrAb")$.
]) <cor-foncteur-comp-grab>

#proof([
  - Soit $C_cdot in ob(sans("Comp"))$ un complexe de chaînes.
    Alors l'homologie $H_(cdot)(C_cdot) := plus.circle.big_(n in ZZ) H_(n)(C_cdot)$ définit bien un groupe abélien gradué.
  - Soit $C_cdot, D_cdot in ob(sans("Comp"))$ deux complexes de chaînes et $func(phi_cdot, C_cdot, D_cdot)$ un morphisme de complexes.
    Alors le morphisme induit $func(H_(cdot)(phi), H_(cdot)(C_cdot), H_(cdot)(D_cdot))$ est bien un morphisme de groupes abéliens gradués.
  Les propriétés de composition et d'identité découlent du @thm-foncteur-comp-ab, donc $H_cdot$ est bien un foncteur de $sans("Comp")$ vers $sans("GrAb")$.
])

== Premières propriétés

=== Homotopie

#definition([
  Soit $C_cdot$ et $D_cdot$ deux complexes de chaînes, $func(phi_cdot, C_cdot, D_cdot)$ et $func(psi_cdot, C_cdot, D_cdot)$ deux morphismes de complexes.
  On dit que $phi_cdot$ et $psi_cdot$ sont _homotopes_ s'il existe une suite de morphismes de groupes $sequence(func(h_n, C_(n), D_(n+1)))$ telle que pour tout $n in ZZ$, on a $phi_n - psi_n = h_(n-1) dif_n + dif_n h_n$.
])

#proposition([
  L'homotopie est une relation d'équivalence sur les morphismes de complexes.
])

#proof([
  Notons $~$ la relation d'homotopie. Soit $C_cdot$ et $D_cdot$ deux complexes de chaînes.
  - _Réflexivité_ : Soit $func(phi_cdot, C_cdot, D_cdot)$ un morphisme de complexes.
    Alors pour tout $n in ZZ$, on peut écrire $phi_n - phi_n = 0 = 0 dif_n + dif_n 0$.
    Donc on a bien $phi_cdot ~ phi_cdot$.
  - _Symétrie_ : Soit $func(phi_cdot, C_cdot, D_cdot)$ et $func(psi_cdot, C_cdot, D_cdot)$ deux morphismes de complexes tels que $phi_cdot ~ psi_cdot$.
    Alors pour tout $n in ZZ$, on a $psi_n - phi_n = -(phi_n - psi_n)$.
    On en déduit bien $psi_cdot ~ phi_cdot$.
  - _Transitivité_ : Soit $func(phi_cdot, C_cdot, D_cdot)$, $func(psi_cdot, C_cdot, D_cdot)$ et $func(xi_cdot, C_cdot, D_cdot)$ trois morphismes de complexes tels que $phi_cdot ~ psi_cdot$ et $psi_cdot ~ xi_cdot$.
    Alors pour tout $n in ZZ$, on a $phi_n - xi_n = phi_n - psi_n + psi_n - xi_n$.
    On en déduit bien que $phi_cdot ~ xi_cdot$.
  Donc l'homotopie est bien une relation d'équivalence sur les morphismes de complexes.
])

#proposition([
  Soit $A_cdot$, $B_cdot$ et $C_cdot$ trois complexes de chaînes, $func(phi_cdot, A_cdot, B_cdot)$ et $func(psi_cdot, A_cdot, B_cdot)$, ainsi que $func(alpha_cdot, B_cdot, C_cdot)$ et $func(beta_cdot, B_cdot, C_cdot)$ deux paires de morphismes de complexes homotopes.
  Alors les compositions $func(alpha_cdot compose phi_cdot, A_cdot, C_cdot)$ et $func(beta_cdot compose psi_cdot, A_cdot, C_cdot)$ sont homotopes.
])

#proof([
  Par définition il existe deux suites de morphismes de groupes $sequence(func(f_n, A_n, B_(n+1)))$ et $sequence(func(g_n, B_n, C_(n+1)))$ telles que pour tout $n in ZZ$, on a $phi_n - psi_n = f_(n-1) dif_n + dif_n f_n$ et $alpha_n - beta_n = g_(n-1) dif_n + dif_n g_n$.
  Soit $n in ZZ$. Alors on a:
  $
    alpha_n compose phi_n - beta_n compose psi_n
    &= alpha_n compose phi_n - alpha_n compose psi_n + alpha_n compose psi_n - beta_n compose psi_n \
    &= alpha_n compose (phi_n - psi_n) + (alpha_n - beta_n) compose psi_n \
    &= alpha_n compose (f_(n-1) dif_n + dif_n f_n) + (g_(n-1) dif_n + dif_n f_n) compose psi_n \
    &= (a_n compose f_(n-1)) dif_n + dif_n (a_(n+1) compose f_n) + (g_(n-1) compose psi_(n-1)) dif_n + dif_n (f_n compose psi_n) \
    &= (a_n compose f_(n-1) + g_(n-1) compose psi_(n-1)) dif_n + dif_n (a_(n+1) compose f_n + f_n compose psi_n)
  $
  En posant $h_n := a_(n+1) compose f_n + g_n compose psi_n$, on obtient l'égalité voulue $alpha_n compose phi_n - beta_n compose psi_n = h_(n-1) dif_n + dif_n h_n$.
  Donc $alpha_cdot compose phi_cdot$ et $beta_cdot compose psi_cdot$ sont bien homotopes.
])

#lemma([
  Soit $C_cdot$ et $D_cdot$ deux complexes de chaînes, $func(phi_cdot, C_cdot, D_cdot)$ et $func(psi_cdot, C_cdot, D_cdot)$ deux morphismes de complexes homotopes.
  Alors on a $H_(cdot)(phi) = H_(cdot)(psi)$.
]) <lem-homotopie>

#proof([
  Par définition il existe une suite de morphismes de groupes $sequence(func(h_n, C_n, D_(n+1)))$ telle que pour tout $n in ZZ$, on a $phi_n - psi_n = h_(n-1) dif_n + dif_n h_n$. \
  Soit $n in ZZ$ et $overline(c) in H_(n)(C_cdot)$.
  Alors on a $phi_(n)(c) - psi_(n)(c) = h_(n-1)(dif_n c) + dif_n h_(n)(c) = dif_n h_(n)(c) in B_(n)(D_cdot)$, on en déduit $H_(n)(phi)(c) - H_(n)(psi)(c) = 0 in H_(n)(D_cdot)$.
  Donc $H_(cdot)(phi) = H_(cdot)(psi)$.
])

=== Complexe de chaînes quotient

#definition([
  Soit $C_cdot$ et $D_cdot$ deux complexes de chaînes.
  On dit que $D_cdot$ est un _sous-complexe de chaînes de $C_cdot$_ si pour tout $n in ZZ$, on a $D_n subset C_n$.
])

#proposition([
  Soit $C_cdot$ un complexe de chaînes et $D_cdot$ un sous-complexe de chaînes de $C_cdot$.
  Alors pour tout $n in ZZ$, $dif_n$ induit un morphisme $func(overline(dif)_n, lquotient(C_(n), D_(n)), lquotient(C_(n-1), D_(n-1)))$ tel que $overline(dif)_n overline(dif)_(n+1) = 0$.
]) <prop-bord-quotient>

#proof([
  Soit $n in ZZ$.
  Alors on a $D_n subset C_n$, on peut donc former le quotient $lquotient(C_n, D_n)$. \
  On pose $func(delta_n := overline(dif_n), C_n, lquotient(C_(n-1), D_(n-1)))$, alors $D_(n) subset ker(delta_n)$ et d'après la propriété universelle du groupe quotient $delta_n$ induit bien un morphisme $func(overline(dif)_n, lquotient(C_n, D_n), lquotient(C_(n-1), D_(n-1)))$. \
  Enfin puisque $dif_n dif_(n+1) = 0$, on a bien $overline(dif)_n overline(dif)_(n+1) = overline(dif_n dif_(n+1)) = 0$.
])

#proposition([
  Soit $C_cdot$ un complexe de chaînes et $D_cdot$ un sous-complexe de chaînes de $C_cdot$.
  Alors la suite $sequence(lquotient(C_n, D_n))$ munie des morphismes de bords induits $sequence(func(overline(dif)_n, lquotient(C_n, D_n), lquotient(C_(n-1), D_(n-1))))$ forme un complexe de chaînes.
])

#definition([
  Soit $C_cdot$ un complexe de chaînes et $D_cdot$ un sous-complexe de chaînes de $C_cdot$.
  On appelle _complexe de chaînes quotient_ le complexe de chaînes $lquotient(C_(cdot), D_(cdot))$.
])

#proposition([
  Soit $lquotient(A_cdot, B_cdot)$ et $lquotient(C_cdot, D_cdot)$ deux complexes de chaînes et $func(phi_cdot, A_cdot, C_cdot)$ un morphisme de complexes.
  Si $phi_(cdot)(B_cdot) subset D_cdot$, alors $phi_cdot$ induit un morphisme de complexes $func(overline(phi)_cdot, lquotient(A_cdot, B_cdot), lquotient(C_cdot, D_cdot))$.
]) <prop-morphisme-quotient>

#proof([
  Pour tout $n in ZZ$,
  on considère $func(overline(phi_n), A_n, lquotient(C_n, D_n))$, alors puisque $phi_(n)(B_n) subset D_n$, on en déduit $B_n subset ker(overline(phi_n))$ et d'après la propriété universelle du groupe quotient $overline(phi_n)$ induit un morphisme $func(overline(phi)_n, lquotient(A_n, B_n), lquotient(C_n, D_n))$.
  On pose $overline(phi)_cdot := sequence(overline(phi)_n)$

  Soit $n in ZZ$. Alors par définition $overline(dif)_n overline(phi)_n = overline(dif_n phi_n) = overline(phi_(n-1) dif_n) = overline(phi)_(n-1) overline(dif)_n$.
  Donc $phi_cdot$ est bien un morphisme de complexes.
])

=== Exactitude

#definition([
  On dit qu'une suite courte de complexes de chaînes est _exacte_, notée :
  #align(center)[#commutative-diagram(
      node-padding: (40pt, 50pt),
      padding: 5pt,
      node((0, 0), $0$),
      node((0, 1), $A_cdot$),
      node((0, 2), $B_cdot$),
      node((0, 3), $C_cdot$),
      node((0, 4), $0$),
      arr((0, 0), (0, 1), ""),
      arr((0, 1), (0, 2), $phi_cdot$),
      arr((0, 2), (0, 3), $psi_cdot$),
      arr((0, 3), (0, 4), ""),
    )]
  si pour tout $n in ZZ$, la suite courte suivante est exacte :
  #align(center)[#commutative-diagram(
      node-padding: (40pt, 50pt),
      padding: 5pt,
      node((0, 0), $0$),
      node((0, 1), $A_n$),
      node((0, 2), $B_n$),
      node((0, 3), $C_n$),
      node((0, 4), $0$),
      arr((0, 0), (0, 1), ""),
      arr((0, 1), (0, 2), $phi_n$),
      arr((0, 2), (0, 3), $psi_n$),
      arr((0, 3), (0, 4), ""),
    )]
  c'est-à-dire que $phi_n$ est injectif, $im(phi_n) = ker(psi_n)$ et $psi_n$ est surjectif.
])


#lemma([
  Soit une suite exacte courte de complexes de chaînes :
  #align(center)[#commutative-diagram(
      node-padding: (40pt, 50pt),
      padding: 5pt,
      node((0, 0), $0$),
      node((0, 1), $A_cdot$),
      node((0, 2), $B_cdot$),
      node((0, 3), $C_cdot$),
      node((0, 4), $0$),
      arr((0, 0), (0, 1), ""),
      arr((0, 1), (0, 2), $phi_cdot$),
      arr((0, 2), (0, 3), $psi_cdot$),
      arr((0, 3), (0, 4), ""),
    )]
  Alors pour tout $n in ZZ$, il existe un morphisme de groupes $func(partial_n, H_(n)(C_cdot), H_(n-1)(A_cdot))$ telle que la suite longue des groupes d'homologie est exacte :
  #align(center)[#commutative-diagram(
      node-padding: (40pt, 40pt),
      padding: 5pt,
      node((0, 0), $dots.c$),
      node((0, 1), $H_(n)(A_cdot)$),
      node((0, 2), $H_(n)(B_cdot)$),
      node((0, 3), $H_(n)(C_cdot)$),
      node((0, 4), $H_(n-1)(A_cdot)$),
      node((0, 5), $dots.c$),

      arr((0, 0), (0, 1), $partial_(n+1)$),
      arr((0, 1), (0, 2), $H_(n)(phi)$),
      arr((0, 2), (0, 3), $H_(n)(psi)$),
      arr((0, 3), (0, 4), $partial_n$),
      arr((0, 4), (0, 5), $H_(n-1)(phi)$),
    )]
  De plus pour tout diagramme commutatif :
  #align(center)[#commutative-diagram(
      node-padding: (40pt, 40pt),
      padding: 5pt,

      node((0, 0), $0$),
      node((0, 1), $A_cdot$),
      node((0, 2), $B_cdot$),
      node((0, 3), $C_cdot$),
      node((0, 4), $0$),
      arr((0, 0), (0, 1), ""),
      arr((0, 1), (0, 2), $phi_cdot$),
      arr((0, 2), (0, 3), $psi_cdot$),
      arr((0, 3), (0, 4), ""),

      node((1, 0), $0$),
      node((1, 1), $A'_cdot$),
      node((1, 2), $B'_cdot$),
      node((1, 3), $C'_cdot$),
      node((1, 4), $0$),
      arr((1, 0), (1, 1), ""),
      arr((1, 1), (1, 2), $phi'_cdot$, label-pos: right),
      arr((1, 2), (1, 3), $psi'_cdot$, label-pos: right),
      arr((1, 3), (1, 4), ""),

      arr((0, 1), (1, 1), $f_cdot$),
      arr((0, 2), (1, 2), $g_cdot$),
      arr((0, 3), (1, 3), $h_cdot$),
    )]
  la transformation $partial_n$ est naturelle dans le sens où le diagramme suivant est commutatif :
  #align(center)[#commutative-diagram(
      node-padding: (40pt, 40pt),
      padding: 5pt,
      node((0, 0), $H_(n)(C_cdot)$),
      node((1, 0), $H_(n-1)(A_cdot)$),
      node((0, 1), $H_(n)(C'_cdot)$),
      node((1, 1), $H_(n-1)(A'_cdot)$),
      arr((0, 0), (0, 1), $H_(n)(h)$),
      arr((1, 0), (1, 1), $H_(n-1)(f)$, label-pos: right),
      arr((0, 0), (1, 0), $partial_n$, label-pos: right),
      arr((0, 1), (1, 1), $partial_n$),
    )]

]) <lem-courte-longue-homologie>

#remark([
  La naturalité de $partial_n$ coïncide bien avec la notion introduite dans le @sec-transformation-naturelle si on considère la catégorie des suites exactes courtes de complexes.
])

#proof([
  Soit $n in ZZ$. On commence par faire un diagramme en 3 dimensions pour la suite :
  #align(center)[#commutative-diagram(
      node-padding: (20pt, 13pt),
      padding: 0pt,

      node((-1, 2), $dots.v$),
      node((-1, 4), $dots.v$),
      node((-1, 6), $dots.v$),
      node((-2, 3), $dots.v$),
      node((-2, 5), $dots.v$),
      node((-2, 7), $dots.v$),
      node((7, 2), $dots.v$),
      node((7, 4), $dots.v$),
      node((7, 6), $dots.v$),
      node((6, 3), $dots.v$),
      node((6, 5), $dots.v$),
      node((6, 7), $dots.v$),

      node((1, 0), $0$),
      node((1, 2), $A_(n+1)$),
      node((1, 4), $B_(n+1)$),
      node((1, 6), $C_(n+1)$),
      node((1, 8), $0$),

      node((3, 0), $0$),
      node((3, 2), $A_n$),
      node((3, 4), $B_n$),
      node((3, 6), $C_n$),
      node((3, 8), $0$),

      node((5, 0), $0$),
      node((5, 2), $A_(n-1)$),
      node((5, 4), $B_(n-1)$),
      node((5, 6), $C_(n-1)$),
      node((5, 8), $0$),

      arr((1, 0), (1, 2), ""),
      arr((1, 2), (1, 4), ""),
      arr((1, 4), (1, 6), ""),
      arr((1, 6), (1, 8), ""),

      arr((3, 0), (3, 2), ""),
      arr((3, 2), (3, 4), ""),
      arr((3, 4), (3, 6), ""),
      arr((3, 6), (3, 8), ""),

      arr((5, 0), (5, 2), ""),
      arr((5, 2), (5, 4), ""),
      arr((5, 4), (5, 6), ""),
      arr((5, 6), (5, 8), ""),

      arr((-1, 2), (1, 2), ""),
      arr((1, 2), (3, 2), ""),
      arr((3, 2), (5, 2), ""),
      arr((5, 2), (7, 2), ""),

      arr((-1, 4), (1, 4), ""),
      arr((1, 4), (3, 4), ""),
      arr((3, 4), (5, 4), ""),
      arr((5, 4), (7, 4), ""),

      arr((-1, 6), (1, 6), ""),
      arr((1, 6), (3, 6), ""),
      arr((3, 6), (5, 6), ""),
      arr((5, 6), (7, 6), ""),

      node((0, 1), $0$),
      node((0, 3), $A'_(n+1)$),
      node((0, 5), $B'_(n+1)$),
      node((0, 7), $C'_(n+1)$),
      node((0, 9), $0$),

      node((2, 1), $0$),
      node((2, 3), $A'_n$),
      node((2, 5), $B'_n$),
      node((2, 7), $C'_n$),
      node((2, 9), $0$),

      node((4, 1), $0$),
      node((4, 3), $A'_(n-1)$),
      node((4, 5), $B'_(n-1)$),
      node((4, 7), $C'_(n-1)$),
      node((4, 9), $0$),

      arr((0, 1), (0, 3), ""),
      arr((0, 3), (0, 5), ""),
      arr((0, 5), (0, 7), ""),
      arr((0, 7), (0, 9), ""),

      arr((2, 1), (2, 3), ""),
      arr((2, 3), (2, 5), ""),
      arr((2, 5), (2, 7), ""),
      arr((2, 7), (2, 9), ""),

      arr((4, 1), (4, 3), ""),
      arr((4, 3), (4, 5), ""),
      arr((4, 5), (4, 7), ""),
      arr((4, 7), (4, 9), ""),

      arr((-2, 3), (0, 3), ""),
      arr((0, 3), (2, 3), ""),
      arr((2, 3), (4, 3), ""),
      arr((4, 3), (6, 3), ""),

      arr((-2, 5), (0, 5), ""),
      arr((0, 5), (2, 5), ""),
      arr((2, 5), (4, 5), ""),
      arr((4, 5), (6, 5), ""),

      arr((-2, 7), (0, 7), ""),
      arr((0, 7), (2, 7), ""),
      arr((2, 7), (4, 7), ""),
      arr((4, 7), (6, 7), ""),

      arr((1, 2), (0, 3), ""),
      arr((1, 4), (0, 5), ""),
      arr((1, 6), (0, 7), ""),

      arr((3, 2), (2, 3), ""),
      arr((3, 4), (2, 5), ""),
      arr((3, 6), (2, 7), ""),

      arr((5, 2), (4, 3), ""),
      arr((5, 4), (4, 5), ""),
      arr((5, 6), (4, 7), ""),
    )]
  Soit $overline(c) in H_(n)(C_cdot)$.
  Puisque $psi_n$ est surjective par exactitude, il existe $b in B_n$ tel que $psi_(n)(b) = c$.
  De plus on a $psi_(n-1)(dif_(n) b) = dif_n psi_(n)(b) = dif_n c = 0$, donc $dif_(n) b in ker(psi_(n-1))$ et par exactitude il existe $a in A_(n-1)$ tel que $phi_(n-1)(a) = dif_n b$.
  De plus on a $phi_(n-2)(dif_(n-1) a) = dif_(n-1) phi_(n-1)(a) = dif_(n-1) dif_n b = 0$, puisque $phi_(n-2)$ est injective par exactitude, on a $dif_(n-1) a = 0$, donc $a in Z_(n-1)(A_cdot)$. Donc on pose $partial_n overline(c) := overline(a) in H_(n-1)(A_cdot)$.

  Vérifions que $partial_n overline(c)$ ne dépend pas des choix réalisés.
  Soit $b' in B_(n)$ tel que $psi_(n)(b') = c$ et $a' in A_(n-1)$ tel que $dif_n b' = phi_(n-1)(a')$.
  Alors on a $psi_(n)(b - b') = c - c = 0$, donc $b-b' in ker(psi_(n))$ et par exactitude il existe $hat(a) in A_(n)$ tel que $phi_(n)(hat(a)) = b - b'$. Alors
  $phi_(n-1)(dif_n hat(a)) = dif_n b - dif_n b' = phi_(n-1)(a - a')$,
  puisque $phi_(n-1)$ est injective par exactitude, on a $dif_n hat(a) = a - a'$, donc $a - a' in B_(n-1)(A_cdot)$ et $overline(a) = overline(a') in H_(n-1)(A_cdot)$.

  Vérifions que la suite longue est exacte.
  - Soit $overline(a) in im(partial_(n+1))$.
    Par construction il existe $b in B_(n+1)$ tel que $phi_(n)(a) = dif_(n+1) b$, d'où $phi_(n)(a) in B_(n)(B_cdot)$ et $H_(n)(phi)(overline(a)) = 0 in H_(n)(B_cdot)$.
    Donc $overline(a) in ker(H_(n)(phi))$.

    Soit $overline(a) in ker(H_(n)(phi))$.
    Alors $phi_(n)(a) in B_(n)(B_cdot)$ et il existe $b in B_(n+1)$ tel que $phi_(n)(a) = dif_(n+1) b$.
    De plus par exactitude on a $d_(n+1) psi_(n+1)(b) = psi_(n)(dif_(n+1)(b)) = psi_(n)(phi_(n)(a)) = 0$, d'où $psi_(n+1)(b) in Z_(n+1)(C_cdot)$, et par construction on retrouve bien $partial_n overline(psi_(n+1)(b)) = overline(a) in H_(n)(A_cdot)$.
    Donc $overline(a) in im(partial_(n+1))$.
  - Soit $overline(b) in im(H_(n)(phi))$.
    Il existe $a in A_n$ tel que $phi_(n)(a) = b$.
    Alors on a $b in im(phi_n)$ et par exactitude $b in ker(psi_n)$.
    Donc $overline(b) in ker(H_(n)(psi))$.

    Soit $overline(b) in ker(H_(n)(psi))$.
    Alors $psi_(n)(b) in B_(n)(C_cdot)$ et il existe $c in C_(n+1)$ tel que $psi_(n)(b) = dif_(n+1) c$.
    Puisque $psi_(n+1)$ est surjective par exactitude, il existe $b' in B_(n+1)$ tel que $psi_(n+1)(b') = c$.
    De plus on a $psi_(n)(d_(n+1) b') = dif_(n+1) psi_(n+1)(b') = dif_(n+1) c = psi_(n)(b)$, donc $b - dif_(n+1) b' in ker(psi_n)$ et par exactitude il existe $a in A_n$ tel que $phi_(n)(a) = b - dif_(n+1) b'$.
    Alors $phi_(n-1)(dif_n a) = dif_n b - dif_n dif_(n+1) b' = dif_n b = 0$, puisque $phi_(n-1)$ est injective par exactitude, on a $dif_n a = 0$, donc $a in Z_(n)(A_cdot)$.
    De plus $H_(n)(phi)(overline(a)) = overline(b) in H_(n)(B_cdot)$.
    Donc $overline(b) in im(H_(n)(phi))$.
  - Soit $overline(c) in im(H_(n)(psi))$.
    Il existe $b in Z_(n)(B_cdot)$ tel que $psi_(n)(b) = c$.
    De plus on a $dif_n b = 0 in ker(psi_(n-1))$, par exactitude il existe $a in A_(n-1)$ tel que $phi_(n-1)(a) = dif_n b = 0$, puisque $phi_(n-1)$ est injective par exactitude, on a $a = 0$ et par construction $partial_n overline(c) = overline(a) = 0 in H_(n-1)(A_cdot)$.
    Donc $overline(c) in ker(partial_n)$.

    Soit $overline(c) in ker(partial_n)$.
    Alors $c in Z_(n)(C_cdot)$, puisque $psi_n$ est surjective par exactitude, il existe $b in B_n$ tel que $psi_(n)(b) = c$, d'où $H_(n)(psi)(overline(b)) = overline(c)$.
    Donc $overline(c) in im(H_(n)(psi))$.


  Vérifions que $partial_n$ est naturelle.
  Soit $overline(c) in H_(n)(C_cdot)$. \
  Par construction il existe $b in B_n$ tel que $psi_(n)(b) = c$ et il existe $a in Z_(n-1)(A_cdot)$ tel que $phi_(n-1)(a) = dif_n b$ et $partial_n overline(c) = overline(a) in H_(n-1)(A_cdot)$.
  Donc on a $H_(n-1)(f)(partial_n overline(c)) = overline(f_(n-1)(a)) in H_(n-1)(A'_cdot)$. \
  De plus $psi'_(n)(g_(n)(b)) = h_(n)(psi_(n)(b)) = h_(n)(c)$ et $phi'_(n-1)(f_(n-1)(a)) = g_(n-1)(phi_(n-1)(a)) = g_(n-1)(dif_n b) = dif_n g_(n)(b)$, alors par construction on a $partial_n H_(n)(h)(overline(c)) = overline(f_(n-1)(a)) in H_(n-1)(A'_cdot)$.
  Donc $H_(n-1)(f)(partial_n) = partial_n H_(n)(h)$.
])

#lemma([
  Soit $lquotient(C_cdot, D_cdot)$ un complexe de chaînes.
  Alors pour tout $n in ZZ$, il existe un morphisme de groupes $func(partial_n, H_(n)(lquotient(C_cdot, D_cdot)), H_(n-1)(D_cdot))$ telle que la suite longue suivante est exacte :
  #align(center)[#commutative-diagram(
      node-padding: (40pt, 40pt),
      padding: 5pt,
      node((0, 0), $dots.c$),
      node((0, 1), $H_(n)(D_cdot)$),
      node((0, 2), $H_(n)(C_cdot)$),
      node((0, 3), $H_(n)(lquotient(C_cdot, D_cdot))$),
      node((0, 4), $H_(n-1)(D_cdot)$),
      node((0, 5), $dots.c$),

      arr((0, 0), (0, 1), $partial_(n+1)$),
      arr((0, 1), (0, 2), $H_(n)(i)$),
      arr((0, 2), (0, 3), $H_(n)(pi)$),
      arr((0, 3), (0, 4), $partial_n$),
      arr((0, 4), (0, 5), $H_(n-1)(i)$),
    )]
  où $func(i_cdot, D_cdot, C_cdot)$ est l'inclusion canonique et $func(pi_cdot, C_cdot ,lquotient(C_cdot, D_cdot))$ est la projection canonique.

]) <lem-courte-longue-homologie-quotient>

#proof([
  Soit $n in ZZ$. Par définition l'inclusion $func(i_n, D_n, C_n)$ est injective, de plus on a clairement $im(i_n) = D_n = ker(pi_n)$ et par définition la projection $func(pi_n, C_n, lquotient(C_n, D_n))$ est surjective. \
  Donc on a une suite exacte courte de complexe de chaînes :
  #align(center)[#commutative-diagram(
      node-padding: (40pt, 50pt),
      padding: 5pt,
      node((0, 0), $0$),
      node((0, 1), $D_cdot$),
      node((0, 2), $C_cdot$),
      node((0, 3), $lquotient(C_cdot, D_cdot)$),
      node((0, 4), $0$),
      arr((0, 0), (0, 1), ""),
      arr((0, 1), (0, 2), $i_cdot$),
      arr((0, 2), (0, 3), $pi_cdot$),
      arr((0, 3), (0, 4), ""),
    )]
  Alors d'après le @lem-courte-longue-homologie il existe bien un morphisme de groupes $func(partial_n, H_(n)(lquotient(C_cdot, D_cdot)), H_(n-1)(D_cdot))$ tel que la suite longue est exacte.
])


#pagebreak()

= Homologie singulière

== Simplexes

#definition([
  Soit $E$ un $RR$-espace vectoriel et $A$ un sous-ensemble de $E$.
  On dit que $A$ est _convexe_ si :
  $ forall p, q in A, [p, q] := {(1 - t)p + t q | t in [0, 1]} subset A. $
])

#definition([
  Soit $E$ un $RR$-espace vectoriel, $A$ un sous-ensemble de $E$ et $p_0, ..., p_n$ des éléments de $A$.
  On appelle _combinaison convexe_ une combinaison linéaire de la forme $t_0 p_0 + dots.c + t_n p_n$ où $t_0, ..., t_n in [0, 1]$ et $t_0 + dots.c + t_n = 1$.
])

#proposition([
  Soit $E$ un $RR$-espace vectoriel, $A$ un sous-ensemble de $E$ et $p_0, ..., p_n$ des éléments de $A$. Si $A$ est convexe, alors toute combinaison convexe de $p_0, ..., p_n$ appartient à $A$.
]) <prop-combinaison-convexe>

#proof([
  Soit $t_0, ..., t_n in [0, 1]$ tels que $t_0 + dots.c + t_n = 1$. Notons $H(n) : t_0 p_0 + dots.c + t_n p_n in A$. \
  Pour $n = 1$. On pose $t := t_1$, alors puisque $A$ est convexe $t_0 p_0 + t_1 p_1 = (1 - t)p_0 + t p_1 in A$. \
  Pour $n > 1$. On suppose que $H(n - 1)$ est vérifiée. Sans perte de généralité, on suppose que $t_n != 0$, et on pose :
  $ p := (t_0) / (1 - t_n) p_0 + dots.c + (t_(n-1)) / (1 - t_n) p_(n-1) $
  alors d'après $H(n - 1)$ on a $p in A$. Par convexité on a $t_0 p_0 + dots.c + t_n p_n = (1 - t_n)p + t_n p_n in A$.
])

#definition([
  Soit $E$ un $RR$-espace vectoriel et $A$ un sous-ensemble de $E$.
  On appelle _enveloppe convexe de $A$_, notée $"Conv"(A)$, l'ensemble des combinaisons convexes d'éléments de $A$.
])

#proposition([
  Soit $E$ un $RR$-espace vectoriel et $A$ un sous-ensemble de $E$.
  Alors l'enveloppe convexe de $A$ est le plus petit ensemble convexe contenant $A$.
])

#proof([
  Soit $p, q in "Conv"(A)$ et $t in [0, 1]$.
  Puisque $p$ et $q$ sont des combinaisons convexes d'éléments de $A$, d'après la @prop-combinaison-convexe on a $(1 - t)p + t q in "Conv"(A)$.
  Donc l'ensemble $"Conv"(A)$ est convexe.

  Soit $B$ un sous-ensemble convexe de $E$ contenant $A$.
  Soit $x in "Conv"(A)$. Puisque $x$ est une combinaison convexe d'éléments de $A subset B$, d'après la @prop-combinaison-convexe on a $x in B$.
  Donc $"Conv"(A) subset B$.
])

#definition([
  Soit $E$ un $RR$-espace vectoriel et $F$ une famille libre de $n + 1$ éléments de $E$.
  On appelle _$n$-simplexe généré par $F$_ l'enveloppe convexe de $F$. On dit que les éléments de $F$ sont les _sommets_ de $"Conv"(F)$ et que $n$ est la _dimension_ de $"Conv"(F)$.
])

#definition([
  On appelle _$n$-simplexe standard_, noté $Delta^n$, le $n$-simplexe généré par la base canonique de $RR^(n+1)$.
])

#proposition([
  Soit $E$ un $RR$-espace vectoriel et $F := (f_0, ..., f_n)$ une famille libre de $n + 1$ éléments de $E$.
  Alors l'application :
  $
    func(gensubgroup(f_0, ..., f_n), Delta^n, "Conv"(F), (t_0, ..., t_n), t_0 f_0 + ... + t_n f_n)
  $
  est un homéomorphisme.
]) <prop-coordonnees-barycentriques>

#proof([
  Soit $(s_0, ..., s_n), (t_0, ..., t_n) in Delta^n$ tels que $s_0 f_0 + ... + s_n f_n = t_0 f_0 + ... + t_n f_n$.
  En particulier on a $(s_0 - t_0)f_0 + ... + (s_n - t_n)f_n = 0$, et puisque la famille $(f_0, ..., f_n)$ est libre, on obtient $s_0 - t_0 = ... = s_n - t_n = 0$, c'est-à-dire $(s_0, ..., s_n) = (t_0, ..., t_n)$.
  Donc $gensubgroup(f_0, ..., f_n)$ est injective. \
  Soit $x in "Conv"(F)$.
  Alors il existe $(t_0, ..., t_n) in Delta^n$ tels que $x := t_0 f_0 + ... + t_n f_n$.
  Donc $gensubgroup(f_0, ..., f_n)$ est surjective.
  Puisque $gensubgroup(f_0, ..., f_n)$ est une application linéaire et que $Delta^n$ est de dimension finie, $gensubgroup(f_0, ..., f_n)$ est continue.
  De plus $Delta^n$ est compact et $"Conv"(F)$ est séparé, donc $gensubgroup(f_0, ..., f_n)$ est un homéomorphisme.
])

#definition([
  Soit $E$ un $RR$-espace vectoriel, $F := (f_0, ..., f_n)$ une famille libre de $n + 1$ éléments de $E$ et $x := t_0 f_0 + ... + t_n f_n$ un élément de $"Conv"(F)$.
  On appelle _coordonnées barycentriques de $x$_ les coefficients $t_0, ..., t_n in [0, 1]$.
])

#definition([
  Soit $E$ un $RR$-espace vectoriel, $F$ une famille libre de $n+1$ éléments de $E$ et $G$ une famille non-vide d'éléments de $m + 1$ éléments de $F$.
  On dit que $"Conv"(G)$ est une _$m$-face_ de $"Conv"(F)$.
])

#figure(
  align(center)[
    #cetz.canvas({
      import cetz.draw: *

      set-style(
        stroke: (cap: "round"),
        mark: (transform-shape: false, fill: black),
      )
      line((-2.75, 0, 0), (4, 0, 0), mark: (end: "stealth"))
      line((0, -2.5, 0), (0, 4, 0), mark: (end: "stealth"))
      line((0, 0, -4), (0, 0, 4), mark: (end: "stealth"))

      line((2, 0, 0), (0, 2, 0), stroke: (paint: green))
      line((0, 2, 0), (0, 0, 2), stroke: (paint: green))
      line((0, 0, 2), (2, 0, 0), stroke: (paint: green))
      line(
        (2, 0, 0),
        (0, 2, 0),
        (0, 0, 2),
        fill: luma(50%, 50%),
        stroke: none,
      )

      set-style(circle: (radius: 0.03, fill: red, stroke: red))
      circle((2, 0, 0), name: "e_0")
      circle((0, 2, 0), name: "e_1")
      circle((0, 0, 2), name: "e_2")

      set-style(content: (padding: 0.1))
      content("e_0", [$e_0$], anchor: "south-west")
      content("e_1", [$e_1$], anchor: "south-east")
      content("e_2", [$e_2$], anchor: "south-east")
    })
  ],
  caption: [Un $2$-simplexe standard. \
    En vert les arêtes sont des $1$-faces du triangle. \
    En rouge les sommets sont des $0$-faces du triangle et des arêtes.],
)

== Chaînes singulières

#definition([
  Soit $X$ un espace topologique.
  On appelle _$n$-simplexe singulier sur $X$_ une application continue de $Delta^n$ dans $X$.
])

#example([
  L'application $gensubgroup(e_0, ..., e_n)$ de la @prop-coordonnees-barycentriques, où $(e_0, ..., e_n)$ est la base canonique de $RR^(n+1)$, est un $n$-simplexe singulier sur $RR^(n+1)$.
])

#proposition([
  Soit $X$ et $Y$ deux espaces topologiques, $func(sigma, Delta^n, X)$ un $n$-simplexe singulier sur $X$ et $func(f, X, Y)$ une application continue.
  Alors la composition $func(f compose sigma, Delta^n, Y)$ est un $n$-simplexe singulier sur $Y$.
])

#definition([
  Soit $X$ un espace topologique. Pour tout $n in ZZ$, on appelle _groupe des $n$-chaînes singulières_, noté $C_(n)(X)$, le groupe abélien libre engendré par les $n$-simplexes singuliers sur $X$.
])

#proof([
  Puisque $f$ est continue sur $X$ et $sigma$ est continue sur $Delta^n$, par composition $f compose sigma$ est continue de $Delta^n$ dans $Y$.
  Donc $f compose sigma$ est un $n$-simplexe singulier sur $X$.
])

#definition([
  Soit $X$ et $Y$ deux espaces topologiques et $func(f, X, Y)$ une application continue.
  Pour tout $n in NN$, on appelle _application induite par $f$_, notée $C_(n)(f)$, le morphisme de groupes :
  $
    func(C_(n)(f), C_(n)(X), C_(n)(Y), sum_(k=0)^m lambda_k sigma_k, sum_(k=0)^m lambda_k (f compose sigma_k)).
  $
])

#proposition([
  Soit $X$, $Y$ et $Z$ trois espaces topologiques, $func(f, X, Y)$ et $func(g, Y, Z)$ deux applications continues.
  Alors pour tout $n in NN$, on a $C_(n)(g compose f) = C_(n)(g) compose C_(n)(f)$.
]) <prop-top-composition>

#proof([
  Soit $n in NN$.
  Puisque les $n$-chaînes singulières sont engendrées par les $n$-simplexes singuliers, il suffit de montrer le résultat pour un $n$-simplexe singulier $func(sigma, Delta^n, X)$.
  Alors on a :
  $
    C_(n)(g compose f)(sigma) = (g compose f) compose sigma = g compose (f compose sigma) = g compose C_(n)(f)(sigma) = C_(n)(g)(C_(n)(f)(sigma))
  $
])

#proposition([
  Pour tout $n in NN$, le groupe des $n$-chaînes singulières $C_n$ est un foncteur de $sans("Top")$ vers $sans("Ab")$.
]) <prop-foncteur-top-ab>

#proof([
  Soit $n in NN$.
  - Soit $X$ un espace topologique.
    Alors le groupe des $n$-chaînes singulières $C_(n)(X)$ est bien un groupe abélien.
  - Soit $X$ et $Y$ deux espaces topologiques, $func(f, X, Y)$ une application continue.
    Alors l'application induite $func(C_(n)(f), C_(n)(X), C_(n)(Y))$ est bien un morphisme de groupes.
  La propriété de composition découle de la @prop-top-composition et la propriété d'identité découle directement de la définition, donc $C_n$ est bien un foncteur de $sans("Top")$ vers $sans("Ab")$.
])

#definition([
  Soit $X$ un espace topologique et $func(sigma, Delta^n, X)$ un $n$-simplexe singulier sur $X$.
  On appelle _bord de $sigma$_, noté $dif_n sigma$, la $(n-1)$-chaîne singulière sur $X$ définie par :
  $
    dif_n sigma := sum_(k=0)^n (-1)^k (sigma compose gensubgroup(e_0, ..., overshell(e_k),... e_n)).
  $
  où le symbole $overshell(dot)$ signifie que l'élément est enlevé.
])

#remark([
  Le bord d'un $n$-simplexe singulier est la somme alternée de ses $(n-1)$-faces.
])

#definition([
  Soit $X$ un espace topologique et $n in NN$.
  On appelle _morphisme de bord_, noté $dif_n$, le morphisme de groupes induit :
  $
    func(dif_n, C_n (X), C_(n-1)(X), sum_(k=0)^m lambda_k sigma_k, sum_(k=0)^m lambda_k dif_n sigma_k).
  $
])

#proposition([
  Soit $X$ et $Y$ deux espaces topologiques, $func(f, X, Y)$ une application continue.
  Alors pour tout $n in NN$, on a $dif_n C_(n)(f) = C_(n-1)(f) dif_n$.
]) <prop-continue-commute>

#proof([
  Soit $n in NN$.
  Puisque les $n$-chaînes singulières sont engendrées par les $n$-simplexes singuliers, il suffit de montrer le résultat pour un $n$-simplexe singulier $func(sigma, Delta^n, X)$.
  Alors on a :
  $
    dif_n C_(n)(f)(sigma) &= sum_(k=0)^n (-1)^k ((f compose sigma) compose gensubgroup(e_0, ..., overshell(e_k), ..., e_n)) \
    &= sum_(k=0)^n (-1)^k (f compose (sigma compose gensubgroup(e_0, ..., overshell(e_k), ..., e_n)))\
    &= C_(n-1)(f)(dif_n sigma).
  $
])

#proposition([
  Soit $X$ un espace topologique. Alors pour tout $n in NN$, on a $dif_n dif_(n+1) = 0$.
]) <prop-bord-composition>

#proof([
  Soit $n in NN$.
  Puisque les $n$-chaînes singulières sont engendrées par les $n$-simplexes singuliers, il suffit de montrer le résultat pour un $n$-simplexe singulier $func(sigma, Delta^n, X)$.
  Alors on a :
  $
    dif_(n+1) sigma = sum_(k=0)^(n+1) (-1)^k (sigma compose gensubgroup(e_0, ..., overshell(e_k), ..., e_n))
  $
  donc en appliquant $dif_n$, on obtient :
  $
    dif_n dif_(n+1) sigma
    &= &&dif_(n)(sum_(k=0)^(n+1) (-1)^k (sigma compose gensubgroup(e_0, ..., overshell(e_k), ..., e_n))) \
    &= &&sum_(k=0)^(n+1) (-1)^k dif_(n)(sigma compose gensubgroup(e_0, ..., overshell(e_k), ..., e_n)))
  $
  on sépare la somme en deux selon les éléments enlevés :
  $
    dif_n dif_(n+1) sigma &= &&sum_(0 <= k < l <= n + 1) (-1)^(k + l) (sigma compose gensubgroup(e_0, ..., overshell(e_k), ..., overshell(e_l), ..., e_n)) \
    & &&+ sum_(0 <= l < k <= n + 1) (-1)^(k + l - 1) (sigma compose gensubgroup(e_0, ..., overshell(e_l), ..., overshell(e_k), ..., e_n)) \
    &= &&sum_(0 <= k < l <= n + 1) ((-1)^(k + l) + (-1)^(k + l + 1)) (sigma compose gensubgroup(e_0, ..., overshell(e_k), ..., overshell(e_l), ..., e_n)) \
    &= &&0
  $
  car les puissances de $-1$ s'annulent.
])

== Définitions de l'homologie singulière

=== D'un espace topologique

#proposition([
  La suite $sequence(C_n)$ où pour tout $n < 0$, on pose $C_n := 0$, munie des morphismes des bords $sequence(func(dif_n, C_n, C_(n-1)))$ est un foncteur de $sans("Top")$ vers $sans("Comp")$.
]) <prop-foncteur-top-comp>

#proof([
  Soit $n in ZZ$.
  - Soit $X$ un espace topologique.
    Alors la suite $sequence(C_(n)(X))$ munie des morphismes de bords $sequence(func(dif_n, C_(n)(X), C_(n-1)(X)))$ est bien un complexe de chaînes d'après la @prop-bord-composition.
  - Soit $X$ et $Y$ deux espaces topologiques, $func(f, X, Y)$ une application continue.
    Alors la suite des applications induites $sequence(func(C_(n)(f), C_(n)(X), C_(n)(Y)))$ est bien un morphisme de complexes d'après la @prop-continue-commute.
  La propriété de composition découle de la @prop-top-composition et la propriété d'identité découle directement de la définition, donc $C_n$ est bien un foncteur de $sans("Top")$ vers $sans("Comp")$.
])

#definition([
  Soit $X$ un espace topologique.
  On appelle _complexe de chaînes singulières de $X$_, noté $C_(cdot)(X)$, le complexe de chaînes déterminé par la suite $sequence(C_(n)(X), dom: NN)$ munie des morphismes de bords $sequence(func(dif_n, C_(n)(X), C_(n-1)(X)), dom: NN)$.
])

#definition([
  Soit $C_(cdot)(X)$ un complexe de chaînes singulières et $n in ZZ$.
  - On appelle _$n$-cycle singulier_ un élément de $Z_(n)(X) := Z_(n)(C_(cdot)(X))$.
  - On appelle _$n$-bord singulier_ un élément de $B_(n)(X) := B_(n)(C_(cdot)(X))$.
  - On appelle _$n$#super("e") groupe d'homologie singulière de $X$_ le groupe $H_(n)(X) := H_(n)(C_(cdot)(X))$.
  - On appelle _homologie singulière de $X$_ le groupe $H_(cdot)(X) := H_(cdot)(C_(cdot)(X))$.
])

#definition([
  Soit $X$ et $Y$ deux espaces topologiques, $func(f, X, Y)$ une application continue.
  On appelle _morphisme de complexes induit par $f$_, notée $func(f_cdot, C_(cdot)(X), C_(cdot)(Y))$, la suite des applications induites $f_cdot := sequence(func(C_(n)(f), C_(n)(X), C_(n)(Y)))$
])

#corollary([
  Pour tout $n in ZZ$, le $n$#super("e") groupe d'homologie singulière $H_n$ est un foncteur de $sans("Top")$ vers $sans("Ab")$.
])

#proof([
  Soit $n in ZZ$.
  D'après la @prop-foncteur-top-comp $C_cdot$ est un foncteur de $sans("Top")$ vers $sans("Comp")$ et d'après le @thm-foncteur-comp-ab $H_n$ est un foncteur de $sans("Comp")$ vers $sans("Ab")$, par composition $H_n = H_(n)(C_cdot)$ est bien un foncteur de $sans("Top")$ vers $sans("Ab")$.
])

#corollary([
  L'homologie singulière $H_cdot$ est un foncteur de $sans("Top")$ vers $sans("GrAb")$.
])

#proof([
  D'après la @prop-foncteur-top-comp $C_cdot$ est un foncteur de $sans("Top")$ vers $sans("Comp")$ et d'après le @cor-foncteur-comp-grab $H_cdot$ est un foncteur de $sans("Comp")$ vers $sans("GrAb")$, par composition $H_cdot = H_(cdot)(C_cdot)$ est bien un foncteur de $sans("Top")$ vers $sans("GrAb")$.
])


// #definition([
//   Soit $C_(cdot)(X)$ un complexe de chaînes singulières et $n in ZZ$.
//   On appelle _$n$#super("e") nombre de Betti de X_ le rang de $H_(n)(X)$ s'il est fini.
// ])

=== D'une paire d'espace topologique

#proposition([
  La suite $sequence(lquotient(C_n, C_n))$ où pour tout $n < 0$, on pose $C_n := 0$, munie des morphismes des bords induits $sequence(func(overline(dif)_n, lquotient(C_(n), C_(n)), lquotient(C_(n-1), C_(n-1))))$ est un foncteur de $sans("Top")_2$ vers $sans("Comp")$.
]) <prop-foncteur-top2-comp>

#proof([
  Soit $n in ZZ$.
  - Soit $(X, A)$ une paire d'espaces topologiques.
    Alors il est clair que $C_(cdot)(A)$ est un sous-complexe de chaînes de $C_(cdot)(X)$, donc la suite $sequence(lquotient(C_(n)(X), C_(n)(A)))$ munie des morphismes de bords induits $sequence(func(overline(dif)_n, lquotient(C_(n)(X), C_(n)(A)), lquotient(C_(n-1)(X), C_(n-1)(A))))$ est bien un complexe de chaînes d'après la @prop-bord-quotient.
  - Soit $(X, A)$ et $(Y, B)$ deux paires d'espaces topologiques, $func(f, (X, A), (Y, B))$ un morphisme de paires.
    Alors il est clair que $f_(cdot)(C_(cdot)(A)) subset C_(cdot)(B)$, donc le morphisme induit $func(overline(f)_cdot, lquotient(C_(n)(X), C_(n)(A)), lquotient(C_(n)(Y), C_(n)(B)))$ est bien un morphisme de complexes d'après la @prop-morphisme-quotient.
  La propriété de composition découle de la @prop-top-composition par passage au quotient et la propriété d'identité découle directement de la définition, donc $C_n$ est bien un foncteur de $sans("Top")$ vers $sans("Comp")$.
])

#definition([
  Soit $(X, A)$ une paire d'espaces topologiques.
  On appelle _complexe de chaînes singulières de la paire $(X, A)$_, noté $C_(cdot)(X, A)$, le complexe de chaînes quotient $C_(cdot)(X, A) := lquotient(C_(cdot)(X), C_(cdot)(A))$.
])

#definition([
  Soit $C_(cdot)(X, A)$ un complexe de chaînes singulières et $n in ZZ$.
  - On appelle _$n$-cycle singulier_ un élément de $Z_(n)(X, A) := Z_(n)(lquotient(C_(cdot)(X), C_(cdot)(A)))$.
  - On appelle _$n$-bord singulier_ un élément de $B_(n)(X, A) := B_(n)(lquotient(C_(cdot)(X), C_(cdot)(A)))$.
  - On appelle _$n$#super("e") groupe d'homologie singulière de $X$_ le groupe $H_(n)(X, A) := H_(n)(lquotient(C_(cdot)(X), C_(cdot)(A)))$.
  - On appelle _homologie singulière de $X$_ le groupe $H_(cdot)(X, A) := H_(cdot)(lquotient(C_(cdot)(X), C_(cdot)(A)))$.
])

#remark([
  Dans le cas de la paire d'espaces topologiques $(X, emptyset)$, on trouve $C_(cdot)(X, emptyset) tilde.eq C_(cdot)(X)$ et $H_(cdot)(X, emptyset) tilde.eq H_(cdot)(X)$.
])

#corollary([
  Pour tout $n in ZZ$, le $n$#super("e") groupe d'homologie singulière de paires $H_n$ est un foncteur de $sans("Top")_2$ vers $sans("Ab")$.
])

#proof([
  Soit $n in ZZ$.
  D'après la @prop-foncteur-top2-comp $C_cdot$ est un foncteur de $sans("Top")_2$ vers $sans("Comp")$ et d'après le @thm-foncteur-comp-ab $H_n$ est un foncteur de $sans("Comp")$ vers $sans("Ab")$, par composition $H_n = H_(n)(C_cdot)$ est bien un foncteur de $sans("Top")_2$ vers $sans("Ab")$.
])

#corollary([
  L'homologie singulière de paires $H_cdot$ est un foncteur de $sans("Top")_2$ vers $sans("GrAb")$.
])

#proof([
  D'après la @prop-foncteur-top2-comp $C_cdot$ est un foncteur de $sans("Top")_2$ vers $sans("Comp")$ et d'après le @cor-foncteur-comp-grab $H_cdot$ est un foncteur de $sans("Comp")$ vers $sans("GrAb")$, par composition $H_cdot = H_(cdot)(C_cdot)$ est bien un foncteur de $sans("Top")_2$ vers $sans("GrAb")$.
])

== Principales propriétés et axiomes d'Eilenberg-Steenrod

#theorem(
  title: "Axiome de dimension",
  [
    Soit $P$ un espace topologique constitué d'un unique point.
    Alors pour tout $n in ZZ$, on a $H_(n)(P) = ZZ$ si $n = 0$ et $H_(n)(P) = {0}$ sinon.
  ],
)

#proof([
  Si $n < 0$, on a clairement $H_(n)(P) tilde.eq {0}$. \
  Si $n >= 0$, il existe un unique $n$-simplexe singulier $func(sigma_n, Delta^n, P)$, alors on a :
  $
    dif_n sigma_n = sum_(k=0)^n (-1)^k sigma_(n-1) = cases(0 &"si" n = 0 "ou" n "est impair", sigma_(n-1) &"si" n != 0 "et" n "est pair")
  $
  dans le cas $n = 0$, alors $H_(0)(P) = lquotient(gensubgroup(sigma_0), {0}) tilde.eq ZZ $, \
  dans le cas $n != 0 $ et $n$ est impair, alors $H_(n)(P) = lquotient(gensubgroup(sigma_n), gensubgroup(sigma_n)) tilde.eq {0}$, \
  dans le cas $n != 0 $ et $n$ est pair, alors $H_(n)(P) = lquotient({0}, {0}) tilde.eq {0}$.
])

#definition([
  Soit $X$ et $Y$ deux espaces topologies, $func(f, X, Y)$ et $func(g, X, Y)$ deux applications continues.
  On dit que $f$ et $g$ sont _homotopes_ s'il existe une application continue $func(h, X times [0, 1], Y)$ telle que pour tout $x in X$, on a $f(x) = h(x, 0)$ et $g(x) = h(x, 1)$.
])


#lemma([
  Soit $X$ et $Y$ deux espaces topologiques, $func(f, X, Y)$ et $func(g, X, Y)$ deux applications continues homotopes.
  Alors les morphismes de complexes $func(f_cdot, C_(cdot)(X), C_(cdot)(Y))$ et $func(g, C_(cdot)(X), C_(cdot)(Y))$ sont homotopes.

]) <lem-homotopie-chaine>

#proof([
  Par définition de l'homotopie il existe une application continue $func(h, X times [0, 1], Y)$ telle que $f(x) = h(x, 0)$ et $g(x) = h(x, 1)$.

  Soit $n in ZZ$.
  Puisque les $n$-chaînes singulières sont engendrées par les $n$-simplexes singuliers, il suffit de définir une homotopie pour un $n$-simplexe singulier $func(sigma, Delta^n, X)$.
  Alors on pose :
  $
    h_(n)(sigma) := sum_(k=0)^n (-1)^k (h compose (sigma times id) compose gensubgroup(f_0, ..., f_k, g_k, ..., g_n)) in C_(n+1)(Y)
  $
  où $(f_0, ..., f_n) := (e_0 times {1}, ..., e_n times {1})$ et $(g_0, ..., g_n) := (e_0 times {0}, ..., e_n times {0})$.
  Calculons maintenant les deux expressions qui nous intéressent :
  $
    h_(n-1)(dif_n sigma) &= &&h_(n)(sum_(l=0)^n (-1)^l (sigma compose gensubgroup(e_0, ..., overshell(e_l), ..., e_n))) \
    &= &&sum_(0<=k<l<=n) (-1)^(k+l) (h compose (sigma times id) compose gensubgroup(f_0, ..., f_k, g_k, ..., overshell(g_l), ..., g_n)) \
    & &&+ sum_(0<=l<k<=n) (-1)^(k+l-1) (h compose (sigma times id) compose gensubgroup(f_0, ..., overshell(f_l), ..., f_k, g_k, ..., g_n)) \
  $
  et :
  $
    dif_n h_(n)(sigma) &= &&dif_n sum_(k=0)^n (-1)^k (h compose (sigma times id) compose gensubgroup(f_0, ..., f_k, g_k, ..., g_n)) \
    &= &&sum_(0<=l<=k<=n) (-1)^(k+l) (h compose (sigma times id) compose gensubgroup(f_0, ..., overshell(f_l), ..., f_k, g_k, ..., g_n)) \
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
  Donc les morphismes de complexes $f_cdot$ et $g_cdot$ sont bien homotopes.
])

#theorem(
  title: "Axiome d'homotopie",
  [
    Soit $X$ et $Y$ deux espaces topologiques, $func(f, X, Y)$ et $func(g, X, Y)$ deux applications continues homotopes.
    Alors on a $H_(cdot)(f) = H_(cdot)(g)$.
  ],
)

#proof([
  Puisque $f$ et $g$ sont homotopes, d'après le @lem-homotopie-chaine $f_cdot$ et $g_cdot$ sont homotopes. Donc d'après le @lem-homotopie on a bien $H_(cdot)(f) = H_(cdot)(g)$.
])

#theorem(
  title: "Axiome d'exactitude",
  [
    Soit $C_(cdot)(X, A)$ un complexe de chaînes singulières.
    Alors pour tout $n in ZZ$, il existe un morphisme de groupes $func(partial_n, H_(n)(X, A), H_(n-1)(A))$ telle que la suite longue suivante est exacte :
    #align(center)[#commutative-diagram(
        node-padding: (40pt, 40pt),
        padding: 5pt,
        node((0, 0), $dots.c$),
        node((0, 1), $H_(n)(A)$),
        node((0, 2), $H_(n)(X)$),
        node((0, 3), $H_(n)(X, A)$),
        node((0, 4), $H_(n-1)(A)$),
        node((0, 5), $dots.c$),

        arr((0, 0), (0, 1), $partial_(n+1)$),
        arr((0, 1), (0, 2), $H_(n)(i)$),
        arr((0, 2), (0, 3), $H_(n)(j)$),
        arr((0, 3), (0, 4), $partial_n$),
        arr((0, 4), (0, 5), $H_(n-1)(i)$),
      )]
    où $func(i, A, X)$ et $func(j, (X, emptyset), (X, A))$ sont les inclusions canoniques.
  ],
)

#proof([
  On remarque que $func(i_cdot, C_(cdot)(A), C_(cdot)(X))$ est l'inclusion canonique et qu'en passant au quotient $func(overline(j)_cdot, C_(cdot)(X, emptyset) tilde.eq C_(cdot)(X), C_(cdot)(X, A))$ devient la projection canonique. \
  Donc d'après le @lem-courte-longue-homologie-quotient il existe bien un morphisme de groupes $func(partial_n, H_(n)(X, A), H_(n-1)(A))$ tel que la suite longue est exacte.
])

#theorem(
  title: "Axiome d'excision",
  [
    Soit $(X, A)$ une paire d'espaces topologiques, $U$ une partie de $A$ telle que $overline(U) subset circle(A)$ et $func(i, (X without U, A without U), (X, A))$ l'inclusion canonique.
    Alors pour tout $n in ZZ$, le morphisme induit $func(H_(n)(i), H_(n)(X without U, A without U), H_(n)(X, A))$ est un isomorphisme.
  ],
)

#proof([
  Admise.
])


#theorem(
  title: "Théorème de Mayer-Vietoris",
  [
    Soit $U$ et $V$ deux ouverts d'un espace topologique.
    Alors pour tout $n in ZZ$, il existe un morphisme de groupes $func(partial_n, H_(n)(U union V), H_(n-1)(U inter V))$ tel que la suite longue suivante est exacte :
    #align(center)[
      #commutative-diagram(
        node-padding: (40pt, 40pt),
        padding: 10pt,
        node((0, 0), $dots.c$),
        node((0, 1), $H_(n)(U inter V)$),
        node((0, 2), $H_(n)(U) plus.circle H_(n)(V)$),
        node((0, 3), $H_(n)(U union V)$),
        node((0, 4), $H_(n-1)(U inter V)$),
        node((0, 5), $dots.c$),

        arr((0, 0), (0, 1), $partial_(n+1)$, label-pos: 13pt),
        arr((0, 1), (0, 2), $(-H_(n)(i_0), H_(n)(i_1))$, label-pos: 13pt),
        arr((0, 2), (0, 3), $H_(n)(j_0) + H_(n)(j_1)$, label-pos: 13pt),
        arr((0, 3), (0, 4), $partial_n$, label-pos: 13pt),
        arr((0, 4), (0, 5), $(-H_(n-1)(i_0), H_(n-1)(i_1))$, label-pos: 13pt),
      )]
    où $func(i_0, U inter V, U)$, $func(i_1, U inter V, V)$, $func(j_0, U, U union V)$ et $func(j_1, V, U union V)$ sont les inclusions canoniques
  ],
)

#proof([
  Admise.
])

#definition([
  Une _théorie de l'homologie_ sur la catégorie des paires d'espaces topologiques $sans("Top")_2$ dans la catégorie des groupes abéliens $sans("Ab")$ est une suite de foncteurs $sequence(func(H_n, sans("Top")_2, sans("Ab")))$ munie de transformations naturelles $sequence(func(partial_n, H_(n)(X, A), H_(n-1)(A) := H_(n-1)(A, emptyset)))$ vérifiant les _axiomes d'Eilenberg-Steenrod_ pour toutes paires d'espaces topologiques $(X, A), (Y, B)$ et $n in ZZ$ :
  - _Dimension <axiome-dimension>_ : Soit $P$ un espace constitué d'un unique point.
    Alors le groupe $H_(n)(P)$ est non-trivial si et seulement si $n = 0$.
  - _Homotopie <axiome-homotopie>_ : Soit $func(f, (X, A), (Y, B))$ et $func(g, (X, A), (Y, B))$ deux morphismes de paires homotopes.
    Alors on a $H_(n)(f) = H_(n)(g)$
  - _Exactitude <axiome-exactitude>_ : La suite longue suivante est exacte :
    #align(center)[#commutative-diagram(
        node-padding: (40pt, 40pt),
        padding: 5pt,
        node((0, 0), $dots.c$),
        node((0, 1), $H_(n)(A)$),
        node((0, 2), $H_(n)(X)$),
        node((0, 3), $H_(n)(X, A)$),
        node((0, 4), $H_(n-1)(A)$),
        node((0, 5), $dots.c$),

        arr((0, 0), (0, 1), $partial_(n+1)$),
        arr((0, 1), (0, 2), $H_(n)(i)$),
        arr((0, 2), (0, 3), $H_(n)(j)$),
        arr((0, 3), (0, 4), $partial_n$),
        arr((0, 4), (0, 5), $H_(n-1)(i)$),
      )]
    où $func(i, A, X)$ et $func(j, (X, emptyset), (X, A))$ sont les inclusions canoniques.
  - _Excision <axiome-excision>_ : Soit $U$ une partie de $A$ telle que $overline(U) subset circle(A)$ et $func(i, (X without U, A without U), (X, A))$ l'inclusion canonique.
    Alors le morphisme induit $func(H_(n)(i), H_(n)(X without U, A without U), H_(n)(X, A))$ est un isomorphisme.
]) <def-theorie-homologie>


#corollary([
  La suite des $n$#super("e") groupe d'homologie singulière de paires $sequence(func(H_n, sans("Top")_2, sans("Ab")))$ munie des morphismes $sequence(func(partial_n, H_(n)(X, A), H_(n-1)(A)))$ est une théorie de l'homogie vérifiant les @def-theorie-homologie[axiomes d'Eilenberg-Steenrod].
])

#pagebreak()

= Espaces projectifs réels

== La droite projective réelle

#let equ(e) = $attach(~, br: #e)$

#definition([
  On appelle _droite projective réelle_, noté $PP^1_RR$, le quotient de $RR^2 without {(0, 0)}$ par la relation d'équivalence $equ(PP^1)$ où pour tout $u, v in RR^2 without {(0, 0)}$, on a $u equ(PP^1) v$ s'il existe $lambda in RR$ tel que $u = lambda v$. \
  Soit $(x, y) in RR^2 without {(0, 0)}$.
  On appelle _coordonnées homogènes de $(x, y)$_ le point associé sur la droite projective réelle $[x:y] := overline((x, y)) in PP^1_RR$.
])

#remark([
  Formellement un point de $PP^1_RR$ est induit par une droite de $RR^2$.
])

#definition([
  On appelle _cartes affines de $PP^1_RR$_ les ensembles suivants :
  - $A_x := {[x:y] in PP^1_RR|x!=0} = {[1:y] in PP^1_RR}$.
  - $A_y := {[x:y] in PP^1_RR|y!=0} = {[x:1] in PP^1_RR}$.
])

#remark([
  On a $PP^1_RR = A_x union A_y$, cette union n'est pas disjointe. \
  On a aussi $PP^1_RR = A_y union cal(l)_oo$ où $cal(l)_oo := {[x:0] in RR^2} = {[1:0]}$, cette union est disjointe.
  On peut dire que $A_y$ est une copie de $RR$ et $cal(l)_oo$ un point à l'infini.
])

#proposition([
  La droite projective réelle $PP^1_RR$ est homéomorphe au quotient du cercle $SS^1$ par la relation d'équivalence $equ(SS^1)$ où pour tout $u, v in SS^1$, on a $u equ(SS^1) v$ si $u = plus.minus v$.
]) <prop-homeo-p1-s1>

#proof([
  On pose $func(i, SS^1, PP^1_RR, (x, y), [x:y])$.
  Alors $i$ est bien définie, pour tout $u, v in SS^1$, si $u equ(SS^1) v$, alors $u = plus.minus v$, d'où $i(u) = i(v)$.
  Et $i$ est continue par composition de fonctions continues.
  Donc $func(I, lquotient(SS^1, equ(SS^1)), PP^1_RR)$ telle que $I compose pi = i$ est continue.

  Réciproquement on pose $func(j, RR^2, lquotient(SS^1, equ(SS^1)), u, overline(u slash norm(u)))$.
  Alors $j$ est bien définie, en effet pour tout $u, v in RR^2$, si $u equ(PP^1) v$, alors il existe $lambda in RR$ tel que $u = lambda v$, d'où $j(u) = j(lambda v) = j(v)$.
  Et $j$ est continue par composition de fonctions continues.
  Donc $func(J, PP^1_RR, lquotient(SS^1, equ(SS^1)))$ telle que $J compose pi = j$ est continue.

  De plus il est clair que $J compose I = id$, donc $I$ est bien un homéomorphisme entre $PP^1_RR$ et $lquotient(SS^1, equ(SS^1))$.
])

== Le plan projectif réel

#definition([
  On appelle _plan projectif réel_, noté $PP^2_RR$, le quotient de $RR^3 without {(0, 0, 0)}$ par la relation d'équivalence $equ(PP^2)$ où pour tout $u, v in RR^3 without {(0, 0, 0)}$, on a $u equ(PP^2) v$ s'il existe $lambda in RR$ tel que $u = lambda v$. \
  Soit $(x, y, z) in RR^3 without {(0, 0, 0)}$.
  On appelle _coordonnées homogènes de $(x, y, z)$_ le point associé sur le plan projectif réel $[x:y:z] := overline((x, y, z)) in PP^2_RR$.
])

#remark([
  Formellement un point de $PP^2_RR$ est induit par une droite de $RR^3$ et une droite de $PP^2_RR$ est induite par un plan de $RR^3$.
  On déduit de la formule de Grassmann. que deux droites de $PP^2_RR$ non-confondues s'intersectent toujours en un point de $PP^2_RR$.
])

#definition([
  On appelle _cartes affines de $PP^2_RR$_ les ensembles suivants :
  - $A_x := {[x:y:z] in PP^1_RR|x!=0} = {[1:y:z] in PP^2_RR}$.
  - $A_y := {[x:y:z] in PP^1_RR|y!=0} = {[x:1:z] in PP^2_RR}$.
  - $A_z := {[x:y:z] in PP^1_RR|z!=0} = {[x:y:1] in PP^2_RR}$.
])

#remark([
  On a $PP^2_RR = A_x union A_y union A_z$, cette union n'est pas disjointe. \
  On a aussi $PP^2_RR = A_z union cal(l)_oo$ où $cal(l)_oo := {[x:y:0] in RR^2}$, cette union est disjointe.
  On peut dire que $A_z$ est une copie de $RR^2$ et $cal(l)_oo$ une copie de $PP^1_RR$.
])

#proposition([
  Le plan projectif réel $PP^2_RR$ est homéomorphe au quotient de la sphère $SS^2$ par la relation d'équivalence $equ(SS^2)$ où pour tout $u, v in SS^2$, on a $u equ(SS^2) v$ si $u = plus.minus v$.
]) <prop-homeo-p2-s2>

#proof([
  La démonstration est similaire à celle de la @prop-homeo-p1-s1, on identifie chaque élément de $PP^2_RR$ à deux éléments antipodaux de $SS^2$.
])

#proposition([
  Le plan projectif réel $PP^2_RR$ est homéomorphe au quotient du carré $[0, 1]^2$ par la relation d'équivalence $equ([0, 1])$ où pour tout $t in [0, 1]$, on a $(t, 0) equ([0, 1]) (1-t, 1)$ et $(0, t) equ([0, 1]) (1, 1-t)$.
]) <prop-homeo-p2-carre>

#proof([
  D'après la @prop-homeo-p2-s2 le plan projectif $PP^2_RR$ est homéomorphe à $lquotient(SS^2, equ(SS^2))$, ensuite puisque l'on identifie les points antipodaux de $SS^2$, on peut considérer seulement l'hémisphère nord de $SS^2$ en identifiant les points antipodaux du cercle de l'équateur :
  #figure(
    cetz.canvas({
      import cetz.draw: *

      set-style(
        stroke: (cap: "round"),
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
  On peut déformer continûment cette demi-sphère sur le disque en identifiant toujours les points antipodaux du cercle :
  #figure(
    cetz.canvas({
      import cetz.draw: *

      set-style(
        stroke: (cap: "round"),
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
  On peut de nouveau déformer continûment ce disque sur le carré en identifiant les points sur le bord du carré et en conservant l'orientation :
  #figure(
    cetz.canvas({
      import cetz.draw: *

      set-style(
        stroke: (cap: "round"),
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
  Puisque les déformations à chaque étapes sont continues et préservent les points identifiés, on a bien construit un homéomorphisme entre $PP^2_RR$ et $[0, 1]^2$.
])

#proposition([
  Le plan projectif réel $PP^2_RR$ est homéomorphe à l'union d'un ruban de Möbius $M$ et d'un disque $D$ tels que $M inter D$ est homéomorphe à un cercle.
]) <prop-homeo-p2-mobius-disque>

#proof([
  D'après la @prop-homeo-p2-carre le plan projectif $PP^2_RR$ est homéomorphe à $lquotient([0, 1]^2, equ([0, 1]))$, ensuite on peut découper dans ce carré un ruban de Möbius.
  #figure(
    cetz.canvas({
      import cetz.draw: *

      set-style(
        stroke: (cap: "round"),
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

      content((6, 0), $M$)

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
    caption: "Découpage d'un ruban de Möbius.",
  )
  On peut recoller les parties restantes en suivant l'orientation des flèches bleues, puis l'orientation des flèches rouges pour obtenir un disque :
  #figure(
    cetz.canvas({
      import cetz.draw: *

      set-style(
        stroke: (cap: "round"),
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

      line((4, 2), (7, 2), (7, -2), (4, -2), (4, 2), fill: luma(50%, 40%))
      line((5.5, 2), (5.5, -2))

      circle((11, 0), radius: 2, fill: luma(50%, 40%))
      line((11, 2), (11, -2))

      line((2.5, 0), (3.5, 0), mark: (end: "stealth", fill: black))
      line((7.5, 0), (8.5, 0), mark: (end: "stealth", fill: black))

      content((10, 0), $D$)

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
    caption: "Recollage du disque.",
  )
  De plus l'intersection $M inter D$ est homéomorphe au bord du disque, donc à un cercle.
  Puisque les déformations à chaque étapes sont continues et préservent les points identifiés, on a bien construit un homéomorphisme entre $PP^2_RR$ et $M union D$.
])

#pagebreak()

#bibliography("biblio.yml", full: true)
