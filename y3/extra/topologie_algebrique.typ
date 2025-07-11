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
  title: "Topologie algébrique",
  authors: ("Emanuel Morille",),
  note: [Avec les conseils de Jean-Baptiste Campesato],
  color: "#718355",
  date: true,
)

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
  - On appelle _homologie_ le groupe abélien gradué $H_(cdot)(C_cdot) := plus.circle.big_(n in ZZ) H_(n)(C_cdot)$.
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
  On note $func(H_(cdot)(phi), H_(cdot)(C_cdot), H_(cdot)(D_cdot))$ le morphisme de groupes gradués $H_(cdot)(phi) := plus.circle.big_(n in ZZ) H_(n)(phi)$.
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
    Alors l'homologie $H_(cdot)(C_cdot) := plus.circle.big_(n in ZZ) H_(n)(C_cdot)$ est bien un groupe abélien gradué.
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
  Soit $E$ un $RR$-espace vectoriel, $A$ un sous-ensemble de $E$ et $f_0, ..., f_n$ des éléments de $A$.
  On appelle _combinaison convexe_ une combinaison linéaire de la forme $t_0 f_0 + dots.c + t_n f_n$ où $t_0, ..., t_n in [0, 1]$ et $t_0 + dots.c + t_n = 1$.
])

#proposition([
  Soit $E$ un $RR$-espace vectoriel, $A$ un sous-ensemble de $E$ et $f_0, ..., f_n$ des éléments de $A$. Si $A$ est convexe, alors toute combinaison convexe de $f_0, ..., f_n$ appartient à $A$.
]) <prop-combinaison-convexe>

#proof([
  Soit $t_0, ..., t_n in [0, 1]$ tels que $t_0 + dots.c + t_n = 1$. Notons $H(n) : t_0 f_0 + dots.c + t_n f_n in A$. \
  Pour $n = 1$. On pose $t := t_1$, alors puisque $A$ est convexe $t_0 f_0 + t_1 f_1 = (1 - t)f_0 + t f_1 in A$. \
  Pour $n > 1$. On suppose que $H(n - 1)$ est vérifiée. Sans perte de généralité, on suppose que $t_n != 1$, et on pose :
  $ p := (t_0) / (1 - t_n) f_0 + dots.c + (t_(n-1)) / (1 - t_n) f_(n-1) $
  alors d'après $H(n - 1)$ on a $p in A$. Par convexité on a $t_0 f_0 + dots.c + t_n f_n = (1 - t_n)p + t_n f_n in A$.
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
  De plus $Delta^n$ est compact, donc d'après le @thm-bijection-continue-compact $gensubgroup(f_0, ..., f_n)$ est un homéomorphisme.
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
        stroke: (cap: "round", join: "round"),
        mark: (transform-shape: false, fill: black),
      )
      line((-2.75, 0, 0), (4, 0, 0), mark: (end: "stealth"))
      line((0, -2, 0), (0, 3.5, 0), mark: (end: "stealth"))
      line((0, 0, -4), (0, 0, 4), mark: (end: "stealth"))

      line((2, 0, 0), (0, 2, 0), stroke: (paint: green))
      line((0, 2, 0), (0, 0, 2), stroke: (paint: green))
      line((0, 0, 2), (2, 0, 0), stroke: (paint: green))
      line(
        (2, 0, 0),
        (0, 2, 0),
        (0, 0, 2),
        fill: luma(50%, 40%),
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
  Soit $X$ et $Y$ deux espaces topologiques, $func(f, X, Y)$ une application continue et $func(sigma, Delta^n, X)$ un $n$-simplexe singulier sur $X$.
  Alors la composition $func(f compose sigma, Delta^n, Y)$ est un $n$-simplexe singulier sur $Y$.
])

#proof([
  Puisque $f$ est continue sur $X$ et $sigma$ est continue sur $Delta^n$, par composition $f compose sigma$ est continue de $Delta^n$ dans $Y$.
  Donc $f compose sigma$ est un $n$-simplexe singulier sur $X$.
])

#definition([
  Soit $X$ un espace topologique. Pour tout $n in ZZ$, on appelle _groupe des $n$-chaînes singulières_, noté $C_(n)(X)$, le groupe abélien libre engendré par les $n$-simplexes singuliers sur $X$.
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
  Il suffit de montrer le résultat pour un $n$-simplexe singulier $func(sigma, Delta^n, X)$.
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
  Il suffit de montrer le résultat pour un $(n+1)$-simplexe singulier $func(sigma, Delta^(n+1), X)$.
  Alors on a :
  $
    dif_(n+1) sigma = sum_(k=0)^(n+1) (-1)^k (sigma compose gensubgroup(e_0, ..., overshell(e_k), ..., e_(n+1)))
  $
  donc en appliquant $dif_n$, on obtient :
  $
    dif_n dif_(n+1) sigma
    &= &&dif_(n)(sum_(k=0)^(n+1) (-1)^k (sigma compose gensubgroup(e_0, ..., overshell(e_k), ..., e_(n+1)))) \
    &= &&sum_(k=0)^(n+1) (-1)^k dif_(n)(sigma compose gensubgroup(e_0, ..., overshell(e_k), ..., e_(n+1)))
  $
  on sépare la somme en deux selon les éléments enlevés :
  $
    dif_n dif_(n+1) sigma &= &&sum_(0 <= k < l <= n + 1) (-1)^(k + l) (sigma compose gensubgroup(e_0, ..., overshell(e_k), ..., overshell(e_l), ..., e_(n+1))) \
    & &&+ sum_(0 <= l < k <= n + 1) (-1)^(k + l - 1) (sigma compose gensubgroup(e_0, ..., overshell(e_l), ..., overshell(e_k), ..., e_(n+1))) \
    &= &&sum_(0 <= k < l <= n + 1) ((-1)^(k + l) + (-1)^(k + l + 1)) (sigma compose gensubgroup(e_0, ..., overshell(e_k), ..., overshell(e_l), ..., e_(n+1))) \
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

// #remark([
//   Dans le cas de la paire d'espaces topologiques $(X, emptyset)$, on trouve $C_(cdot)(X, emptyset) tilde.eq C_(cdot)(X)$ et $H_(cdot)(X, emptyset) tilde.eq H_(cdot)(X)$.
// ])

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

== Principales propriétés

=== Axiomes d'Eilenberg-Steenrod

#theorem(
  title: "Axiome de dimension",
  [
    Soit $P$ un espace topologique constitué d'un unique point.
    Alors pour tout $n in ZZ$, on a :
    $ H_(n)(P) tilde.eq cases(ZZ &"si" n = 0, 0 &"sinon") $
  ],
) <thm-homologie-point>

#proof([
  Soit $n in ZZ$.
  Si $n < 0$, on a clairement $H_(n)(P) tilde.eq 0$. \
  Si $n >= 0$, il existe un unique $n$-simplexe singulier $func(sigma_n, Delta^n, P)$, alors on a :
  $
    dif_n sigma_n = sum_(k=0)^n (-1)^k sigma_(n-1) = cases(0 &"si" n = 0 "ou" n "est impair", sigma_(n-1) &"si" n != 0 "et" n "est pair")
  $
  dans le cas $n = 0$, alors $H_(0)(P) = lquotient(gensubgroup(sigma_0), 0) tilde.eq ZZ $, \
  dans le cas $n != 0 $ et $n$ est impair, alors $H_(n)(P) = lquotient(gensubgroup(sigma_n), gensubgroup(sigma_n)) tilde.eq 0$, \
  dans le cas $n != 0 $ et $n$ est pair, alors $H_(n)(P) = lquotient(0, 0) tilde.eq 0$.
])

#definition([
  Soit $X$ et $Y$ deux espaces topologiques, $func(f, X, Y)$ et $func(g, X, Y)$ deux applications continues.
  On dit que $f$ et $g$ sont _homotopes_ s'il existe une application continue $func(h, X times [0, 1], Y)$ telle que pour tout $x in X$, on a $f(x) = h(x, 0)$ et $g(x) = h(x, 1)$.
])

#lemma([
  Soit $X$ et $Y$ deux espaces topologiques, $func(f, X, Y)$ et $func(g, X, Y)$ deux applications continues homotopes.
  Alors les morphismes de complexes $func(f_cdot, C_(cdot)(X), C_(cdot)(Y))$ et $func(g, C_(cdot)(X), C_(cdot)(Y))$ sont homotopes.

]) <lem-homotopie-chaine>

#proof([
  Par définition de l'homotopie il existe une application continue $func(h, X times [0, 1], Y)$ telle que $f(x) = h(x, 0)$ et $g(x) = h(x, 1)$.

  Soit $n in ZZ$.
  Il suffit de définir une homotopie pour un $n$-simplexe singulier $func(sigma, Delta^n, X)$.
  On pose :
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
) <thm-homotopie>

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

#definition([
  Une _théorie de l'homologie_ sur la catégorie des paires d'espaces topologiques $sans("Top")_2$ dans la catégorie des groupes abéliens $sans("Ab")$ est une suite de foncteurs $sequence(func(H_n, sans("Top")_2, sans("Ab")))$ munie de transformations naturelles $sequence(func(partial_n, H_(n)(X, A), H_(n-1)(A) := H_(n-1)(A, emptyset)))$ vérifiant les _axiomes d'Eilenberg-Steenrod_ pour toutes paires d'espaces topologiques $(X, A), (Y, B)$ et $n in ZZ$ :
  - _Dimension_ : Soit $P$ un espace constitué d'un unique point.
    Alors le groupe $H_(n)(P)$ est non-trivial si et seulement si $n = 0$.
  - _Homotopie_ : Soit $func(f, (X, A), (Y, B))$ et $func(g, (X, A), (Y, B))$ deux morphismes de paires homotopes.
    Alors on a $H_(n)(f) = H_(n)(g)$
  - _Exactitude_ : La suite longue suivante est exacte :
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
  - _Excision_ : Soit $U$ une partie de $A$ telle que $overline(U) subset circle(A)$ et $func(i, (X without U, A without U), (X, A))$ l'inclusion canonique.
    Alors le morphisme induit $func(H_(n)(i), H_(n)(X without U, A without U), H_(n)(X, A))$ est un isomorphisme.
]) <def-theorie-homologie>

#corollary([
  La suite des $n$#super("e") groupe d'homologie singulière de paires $sequence(func(H_n, sans("Top")_2, sans("Ab")))$ munie des morphismes $sequence(func(partial_n, H_(n)(X, A), H_(n-1)(A)))$ est une théorie de l'homogie vérifiant les @def-theorie-homologie[axiomes d'Eilenberg-Steenrod].
])

=== Équivalence d'homotopie

#definition([
  Soit $X$ et $Y$ deux espaces topologiques.
  On dit que $X$ et $Y$ sont _homotopiquement équivalents_ s'il existe deux applications continues $func(f, X, Y)$ et $func(g, Y, X)$ telles que $g compose f$ est homotope à $id_X$ et $f compose g$ est homotope à $id_Y$.
])

#corollary([
  Soit $X$ et $Y$ deux espaces topologiques homotopiquement équivalents.
  Alors les homologies $H_(cdot)(X)$ et $H_(cdot)(Y)$ sont isomorphes.
]) <cor-homotopie-equ>

#proof([
  Par définition il existe deux applications continues $func(f, X, Y)$ et $func(g, Y, X)$ telles que $g compose f$ est homotope à $id_X$ et $f compose g$ est homotope à $id_Y$.
  Alors d'après l'@thm-homotopie on a bien $H_(cdot)(g) compose H_(cdot)(f) = id_(H_(cdot)(X))$ et $H_(cdot)(f) compose H_(cdot)(g) = id_(H_(cdot)(Y))$, donc $H_(cdot)(X) tilde.eq H_(cdot)(Y)$.
])

#definition([
  Soit $X$ un espace topologique et $A$ un sous-ensemble de $X$.
  On dit que $A$ est un _rétract par déformation de $X$_ s'il existe une application continue $func(f, X, X)$ homotope à $id_X$ telle que pour tout $x in X$, on a $f(x) in A$ et pour tout $a in A$, on a $f(a) = a$.
])

#corollary([
  Soit $X$ un espace topologique et $A$ un rétract par déformation de $X$.
  Alors les homologies $H_(cdot)(X)$ et $H_(cdot)(A)$ sont isomorphes.
]) <cor-retract-deformation>

#proof([
  Notons $func(i, A, X)$ l'inclusion canonique.
  Par définition il existe une application continue $func(f, X, X)$ homotope à $id_X$ telle que pour tout $x in X$, on a $f(x) in A$ et pour tout $a in A$, on a $f(a) = a$.
  Alors on a $f compose i = id_A$ et $i compose f$ est homotope à $id_X$, donc d'après le @cor-homotopie-equ on a bien $H_(cdot)(X) tilde.eq H_(cdot)(A)$.
])

=== Connexité par arcs

#proposition([
  Soit $X$ un espace topologique.
  Alors, en notant $sequence(X, ind: i, dom: I)$ les composantes connexes par arcs de $X$, pour tout $n in ZZ$, on a $H_(n)(X) tilde.eq plus.circle.big_(i in I) H_(n)(X_i)$.
]) <prop-somme-composantes-connexes>

#proof([
  Soit $n in ZZ$.
  Pour toute $n$-chaîne singulière $func(sigma, Delta^n, X)$, puisque $Delta^n$ est convexe, et en particulier connexe par arcs, par continuité de $sigma$ il existe un unique $i in I$ tel que $im(sigma) subset X_i$.
  Alors on en déduit que $C_(n)(X) tilde.eq plus.circle.big_(i in I) C_(n)(X_i)$.
  De plus $dif_n$ préserve cette décomposition en somme directe, par passage au quotient on a bien $H_(n)(X) tilde.eq plus.circle.big_(i in I) H_(n)(X_i)$.
])

#proposition([
  Soit $X$ un espace topologique.
  Alors, en notant $sequence(X, ind: i, dom: I)$ les composantes connexes par arcs de $X$, on a $H_(0)(X) tilde.eq plus.circle.big_(i in I) ZZ$.
]) <prop-h0-abelien-libre>

#proof([
  On a déjà $ker(dif_0) = C_(0)(X)$.

  Supposons que $X$ est non-vide et connexe par arcs.
  On pose $func(phi, C_(0)(X), ZZ, sum_(k=0)^n lambda_k sigma_k, sum_(k=0)^n lambda_k)$.
  Alors $phi$ est un morphisme de groupes surjectif. Vérifions que $im(dif_1) = ker(phi)$. \

  Les $1$-chaînes singulières sont engendrées par les $1$-simplexes singuliers et pour tout $1$-simplexe singulier $func(sigma, Delta^1, X)$, on a $phi(dif_1 sigma) = phi(sigma compose gensubgroup(overshell(e_0), e_1) - sigma compose gensubgroup(e_0, overshell(e_1))) = 1 - 1 = 0$, donc $im(dif_1) subset ker(phi)$. \

  Réciproquement on considère $sum_(k=0)^n lambda_k sigma_k in ker(phi)$.
  Pour tout $k in {0, ..., n}$, on note $func(gamma_k, [0, 1], X)$ un chemin d'un point $x in X$ au point $sigma_(k)(e_1) in X$ et on pose $func(sigma, Delta^0, X)$ un $0$-simplexe singulier d'image $x$, en considérant $gamma_k$ comme un $1$-simplexe singulier on a $dif_1 gamma_k = sigma_k - sigma$.
  Alors en considérant la $n$-chaîne singulière $sum_(k=0)^n lambda_k gamma_k$, on a $dif_1 sum_(k=0)^n lambda_k gamma_k = sum_(k=0)^n lambda_k sigma_k - sum_(k=0)^n lambda_k sigma = sum_(k=0)^n lambda_k sigma_k$, donc $ker(phi) subset im(dif_1)$.

  Alors d'après le premier théorème d'isomorphisme on a bien $H_(0)(X) = lquotient(C_(0)(X), ker(phi)) tilde.eq ZZ$.

  Dans le cas général, d'après la @prop-somme-composantes-connexes on a $H_(n)(X) tilde.eq plus.circle.big_(i in I) H_(n)(X_i) tilde.eq plus.circle.big_(i in I) ZZ$.
])

== Calculs d'homologie singulière

#theorem(
  title: "Théorème de Mayer-Vietoris",
  [
    Soit $X$ un espace topologique, $U$ et $V$ deux parties de $X$ tels que $circle(U) union circle(V) = X$.
    Alors pour tout $n in ZZ$, il existe un morphisme de groupes $func(partial_n, H_(n)(U union V), H_(n-1)(U inter V))$ tel que la suite longue suivante est exacte :
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
        arr((0, 1), (0, 2), $(-H_(n)(i), H_(n)(j))$, label-pos: 13pt),
        arr((0, 2), (0, 3), $H_(n)(k) + H_(n)(l)$, label-pos: 13pt),
        arr((0, 3), (0, 4), $partial_n$, label-pos: 13pt),
        arr((0, 4), (0, 5), $(-H_(n-1)(i), H_(n-1)(j))$, label-pos: 13pt),
      )]
    où $func(i, U inter V, U)$, $func(j, U inter V, V)$, $func(k, U, U union V)$ et $func(l, V, U union V)$ sont les inclusions canoniques.
  ],
) <thm-mayer-vietoris>

#proof([
  Admise.
])

#remark([
  Dans la suite on note $BB^n$ une boule de dimension $n$ et $SS^n := partial BB^(n+1)$ une sphère de dimension $n$.
])

#proposition([
  Pour tout $n in ZZ$, on a :
  $ H_(n)(SS^0) tilde.eq cases( ZZ plus.circle ZZ &"si" n=0, 0 &"sinon") $
]) <prop-homologie-s0>

#proof([
  $SS^0$ est composé de deux points et a deux composantes connexes par arcs, donc d'après la @prop-somme-composantes-connexes et l'@thm-homologie-point on a bien le résultat.
])

#proposition([
  Pour tout $n in ZZ$, on a :
  $ H_(n)(SS^1) tilde.eq cases( ZZ &"si" n in {0, 1}, 0 &"sinon") $
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
  D'après le @cor-homotopie-equ, l'@thm-homologie-point la et @prop-homologie-s0 on a :
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
  Pour tout $n in ZZ$, on a :
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

TODO : $SS^n$.

#proposition([
  Soit $X$ un sous-espace de $SS^p$ homéomorphe à $BB^q$. Alors pour tout $n in ZZ$, on a :
  $ H_(n)(SS^p without X) tilde.eq cases(ZZ &"si" n = 0, 0 &"sinon") $
]) <prop-homologie-sp-bq>

#proof([
  Soit $func(f, BB^q, X)$ un homéomorphisme, on raisonne par récurrence sur $q < p$ avec :
  $
    P(q) : H_(n)(SS^p without f(BB^q)) tilde.eq cases(ZZ &"si" n=0, 0 &"sinon")
  $
  Pour $q = 0$. L'espace $BB^0$ est réduit à un unique point, d'après le @thm-projection-stereographique l'espace $SS^p without f(BB^0)$ est homéomorphe à $RR^p$, qui est homotopiquement équivalent à un point.
  D'après le @cor-homotopie-equ et l'@thm-homologie-point on a :

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
  Alors pour tout $n in ZZ$, on a :
  $
    H_(n)(RR^3 without X) tilde.eq H_(n)(SS^2) tilde.eq cases(ZZ &"si" n in {0, 2}, 0 &"sinon")
  $
]) <prop-homologie-complementaire-b2>

#proof([
  D'après le @thm-projection-stereographique et par compactification d'Alexandrov $RR^3 union {oo}$ est homéomorphe à $SS^3$, en particulier la restriction $(RR^3 without X) union {oo}$ est homéomorphe à $SS^3 without X$.
  On recouvre $(RR^3 without X) union {oo}$ par deux ouverts $U := RR^3 without X$ et $V$ une boule au voisinage de $oo$ qui n'intersecte pas $X$ (qui est compact). \

  Alors on peut calculer $H_(n)(SS^3 without X)$ de la même manière que dans la @prop-homologie-s1.
])

#proposition([
  Soit $X$ un sous-espace de $SS^3$ homéomorphe à $SS^1$.
  Alors pour tout $n in ZZ$, on a :
  $
    H_(n)(SS^3 without X) tilde.eq H_(n)(SS^1) tilde.eq cases(ZZ &"si" n in {0, 1}, 0 &"sinon")
  $
]) <prop-homologie-s3-s1>

#proof([
  On recouvre $SS^1$ par deux arcs fermés $A_+$ et $A_-$, ils sont homéomorphes à $BB^1$, et leur intersection vaut $A_+ inter A_- = SS^0$. On considère un homéomorphisme $func(f, SS^1, X)$ et on pose deux ouverts $U := SS^3 without f(A_+)$ et $V := SS^3 without f(A_-)$.
  D'après le @thm-projection-stereographique l'union $U union V = SS^3 without f(SS^0)$ est homéomorphe à $RR^3 without {0}$, qui est homotopiquement équivalent à $SS^(2)$. \

  Alors on peut calculer $H_(n)(SS^3 without X)$ de la même manière que dans la @prop-homologie-s1.
])

#proposition([
  Soit $X$ un sous-espace de $RR^3$ homéomorphe à $SS^1$.
  Alors pour tout $n in ZZ$, on a :
  $ H_(n)(RR^3 without X) tilde.eq cases(ZZ &"si" n in {0, 1, 2}, 0 &"sinon") $
]) <prop-homologie-complementaire-s1>

#proof([
  On peut recouvrir de la même manière que dans la @prop-homologie-complementaire-b2 et
  calculer $H_(n)(SS^3 without X)$ de la même manière que dans la @prop-homologie-s1
])


#pagebreak()

= Droite et plan projectifs réels

== La droite projective réelle

#let equ(e) = $attach(~, br: #e)$

#definition([
  On appelle _droite projective réelle_, noté $PP^1_RR$, le quotient de $RR^2 without {0}$ par la relation d'équivalence $equ(PP^1)$ où pour tout $u, v in RR^2 without {0}$, on a $u equ(PP^1) v$ s'il existe $lambda in RR without {0}$ tel que $u = lambda v$. \
  Soit $(x, y) in RR^2 without {0}$.
  On appelle _coordonnées homogènes de $(x, y)$_ le point associé sur la droite projective réelle $[x:y] := overline((x, y)) in PP^1_RR$.
])

#remark([
  Formellement un point de $PP^1_RR$ est induit par une droite linéaire de $RR^2$.
])

#definition([
  On appelle _cartes affines de $PP^1_RR$_ les sous-ensembles suivants :
  - $A_x := {[x:y] in PP^1_RR | x!=0} = {[1:y] in PP^1_RR}$.
  - $A_y := {[x:y] in PP^1_RR | y!=0} = {[x:1] in PP^1_RR}$.
])

#remark([
  Les cartes affines $A_x$ et $A_y$ sont homéomorphes à $RR$. \
  On a $PP^1_RR = A_x union A_y$, mais surtout $PP^1_RR = A_y union.sq {oo}$ où $oo := [1:0]$. \
  Intuitivement $PP^1_RR$ s'obtient donc à partir de $RR$ auquel on ajoute un point à l'infini.
])

#remark([
  La proposition suivante est naturelle puisque $PP^1_RR$ est donnée par les droites linéaires de $RR^2$ et $SS^1$ par les demi-droites linéaires de $RR^2$.
])

#proposition([
  La droite projective réelle $PP^1_RR$ est homéomorphe au quotient du cercle $SS^1$ par la relation d'équivalence $equ(SS^1)$ où pour tout $u, v in SS^1$, on a $u equ(SS^1) v$ si $u = plus.minus v$.
]) <prop-homeo-p1-s1>

#proof([
  On pose $func(i, SS^1, PP^1_RR, (x, y), [x:y])$.
  Alors $i$ est bien définie, pour tout $u, v in SS^1$, si $u equ(SS^1) v$, alors $u = plus.minus v$, d'où $i(u) = i(v)$.
  De plus $i$ est continue par composition de fonctions continues.
  Donc l'application $func(I, lquotient(SS^1, equ(SS^1)), PP^1_RR)$ telle que $I compose pi = i$ est continue.

  Réciproquement on pose $func(j, RR^2 without {0}, lquotient(SS^1, equ(SS^1)), u, overline(u slash norm(u)))$.
  Alors $j$ est bien définie, en effet pour tout $u, v in RR^2 without {0}$, si $u equ(PP^1) v$, alors il existe $lambda in RR without {0}$ tel que $u = lambda v$, d'où $j(u) = j(lambda v) = j(v)$.
  De plus $j$ est continue par composition de fonctions continues.
  Donc l'application $func(J, PP^1_RR, lquotient(SS^1, equ(SS^1)))$ telle que $J compose pi = j$ est continue.

  Enfin il est clair que $J compose I = id$ et $I compose J = id$, donc $I$ et $J$ sont bien des homéomorphisme de la droite projective réelle $PP^1_RR$ dans $lquotient(SS^1, equ(SS^1))$.
])

== Le plan projectif réel

#definition([
  On appelle _plan projectif réel_, noté $PP^2_RR$, le quotient de $RR^3 without {0}$ par la relation d'équivalence $equ(PP^2)$ où pour tout $u, v in RR^3 without {0}$, on a $u equ(PP^2) v$ s'il existe $lambda in RR without {0}$ tel que $u = lambda v$. \
  Soit $(x, y, z) in RR^3 without {0}$.
  On appelle _coordonnées homogènes de $(x, y, z)$_ le point associé sur le plan projectif réel $[x:y:z] := overline((x, y, z)) in PP^2_RR$.
])

#remark([
  Formellement un point de $PP^2_RR$ est induit par une droite linéaire de $RR^3$ et une droite de $PP^2_RR$ est induite par un plan linéaire de $RR^3$.
  On déduit de la formule de Grassmann que deux droites distinctes de $PP^2_RR$ (même parallèles) s'intersectent en un point de $PP^2_RR$. \
]) <rem-inter-droites>

#definition([
  On appelle _cartes affines de $PP^2_RR$_ les sous-ensembles suivants :
  - $A_x := {[x:y:z] in PP^1_RR | x!=0} = {[1:y:z] in PP^2_RR}$.
  - $A_y := {[x:y:z] in PP^1_RR | y!=0} = {[x:1:z] in PP^2_RR}$.
  - $A_z := {[x:y:z] in PP^1_RR | z!=0} = {[x:y:1] in PP^2_RR}$.
])

#remark([
  Les cartes affines $A_x$, $A_y$ et $A_z$ sont homéomorphes à $RR^2$. \
  On a $PP^2_RR = A_x union A_y union A_z$, mais surtout $PP^2_RR = A_z union.sq cal(l)_oo$ où $cal(l)_oo := {[x:y:0] in RR^2}$. \
  De plus l'ensemble $cal(l)_oo$ est homéomorphe à $PP^1_RR$, intuitivement $PP^2_RR$ s'obtient donc à partir de $RR^2$ auquel on ajoute une copie de $PP^1_RR$ à l'infini.
])

#remark([
  Pour être exact dans la @rem-inter-droites, une droite de $A_z$ intersecte $cal(l)_oo$ en un point dépendant uniquement de son vecteur directeur.
  En effet, soit $D := {(x_0 +t a, y_0 + t b) | t in RR}$ une droite de $RR^2 tilde.eq A_z$ passant par un point $(x_0, y_0) in RR^2$ et de vecteur directeur $(a, b) in RR^2 without {0}$.
  Alors l'image de $D$ dans $A_z$ est donnée par $D_z := {[x_0+t a:y_0 + t b:1] | t in RR}$, et on a :
  $
    [x_0 + t a: y_0 + t b:1] = [x_0 / t + a:y_0 / t+b:1 / t] ->_(t->+oo) [a:b:0] in cal(l)_oo
  $
  Donc $D_z$ intersecte $cal(l)_oo$ en $[a:b:0]$.

  Soit $D_1$ et $D_2$ deux droites distinctes de $PP^2_RR$, on note $A_1 := D_1 inter A_z$ et $A_2 := D_2 inter A_z$.
  - Si $D_1 != cal(l)_oo$ et $D_2 != cal(l)_oo$, alors $A_1 != emptyset$ et $A_2 != emptyset$. \
    Si $A_1$ et $A_2$ sont parallèles, elles ont le même vecteur directeur, donc $D_1$ et $D_2$ s'intersectent en $cal(l)_oo$. \
    Sinon $A_1$ et $A_2$ s'intersectent, donc $D_1$ et $D_2$ s'intersectent en $A_z$.
  - Si $D_1 = cal(l)_oo$, alors $D_2$ intersecte bien $D_1 = cal(l)_oo$.
])

#remark([
  La proposition suivante est naturelle puisque $PP^2_RR$ est donné par les droites linéaires de $RR^3$ et $SS^2$ par les demi-droites linéaires de $RR^3$.
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
  On peut déformer continûment cette demi-sphère sur le disque en identifiant toujours les points antipodaux du cercle :
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
  On peut de nouveau déformer continûment ce disque sur le carré en identifiant les points sur le bord du carré et en conservant l'orientation :
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
  Puisque les déformations à chaque étapes sont continues et préservent les points identifiés, on a bien construit un homéomorphisme du plan projectif réel $PP^2_RR$ dans $lquotient([0, 1]^2, equ([0, 1]))$.
])

#proposition([
  Le plan projectif réel $PP^2_RR$ se décompose en l'union de deux ensembles $M union D$ tels que $M$ est homéomorphe une bande de Möbius, $D$ est homéomorphe à un disque fermé, et l'intersection $M inter D = partial M = partial D$ est homéomorphe à $SS^1$.
]) <prop-homeo-p2-mobius-disque>

#proof([
  D'après la @prop-homeo-p2-carre le plan projectif $PP^2_RR$ est homéomorphe à $lquotient([0, 1]^2, equ([0, 1]))$, ensuite on peut découper dans ce carré une bande de Möbius :
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
  On peut recoller les parties restantes en suivant l'orientation des flèches bleues, puis l'orientation des flèches rouges pour obtenir un disque fermé :
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
  De plus $M inter D = partial M = partial D$ est homéomorphe au bord du disque, donc à $SS^1$.

  Puisque les déformations à chaque étapes sont continues et préservent les points identifiés, on a bien décomposé le plan projectif réel $PP^2_RR$ comme l'union $M union D$ de deux ensembles tels que $M$ est homéomorphe à une bande de Möbius, $D$ est homéomorphe à un disque fermé et $M inter D$ est homéomorphe à $SS^1$.
])

=== Non-plongement dans $RR^3$

#definition([
  Soit $X$ et $Y$ deux espaces topologiques, $func(f, X, Y)$ une application.
  On dit que $f$ est un _plongement de $X$ dans $Y$_ si elle induit un homéomorphisme de $X$ dans $f(X)$.
])

#theorem([
  Il n'existe pas de plongement du plan projectif réel $PP^2_RR$ dans $RR^3$.
]) <thm-non-plongement-p2-r3>

#proof([
  Supposons par l'absurde qu'il existe un plongement $func(f, PP^2_RR, RR^3)$. \
  D'après la @prop-homeo-p2-mobius-disque on peut écrire $PP^2_RR = M union D$ où $M$ est homéomorphe à une bande de Möbius, $D$ est homéomorphe à un disque fermé et $M inter D = partial M = partial D$ est homéomorphe à $SS^1$,
  dans la suite on identifie $PP^2_RR$, $M$ et $D$ avec leur images $f(PP^2_RR)$, $f(M)$ et $f(D)$ dans $RR^3$.

  Le complémentaire de la bande de Möbius $RR^3 without M$ est homotopiquement équivalent à $RR^3 without C$ où $C$ le cercle central de $M$ est homéomorphe à $SS^1$. D'après le @cor-retract-deformation et la @prop-homologie-complementaire-s1, on a :
  $
    H_(1)(RR^3 without M) tilde.eq H_(1)(RR^3 without C) tilde.eq ZZ
  $
  et on en déduit qu'un générateur de $H_(1)(RR^3 without M) tilde.eq H_(1)(SS^1)$ est donné par la classe d'un $1$-simplexe singulier $func(sigma, Delta^1, RR^3 without M)$ dont l'image est un cercle enlacé autour de $M$.

  De plus le bord de la bande Möbius $partial M$ est homéomorphe à $SS^1$. D'après la @prop-homologie-complementaire-s1, on a :
  $
    H_(1)(RR^3 without partial M) tilde.eq ZZ
  $

  On considère $func(i, RR^3 without M, RR^3 without partial M)$ l'inclusion canonique.
  Alors la composition $i compose sigma$ est homotope à deux cercles enlacés autour de $partial M$ avec la même orientation que $sigma$ et ayant un point d'intersection :

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
    caption: [Homotopie de l'inclusion de $sigma$ dans $RR^3 without M$.],
  )

  Alors puisque leur orientation est la même, la classe des deux cercles dans $H_(1)(RR^3 without partial M)$ est le même générateur de $H_(1)(RR^3 without partial M)$, donc $H_(1)(i)$ est la multiplication par 2.

  Le disque fermé $D$ est homéomorphe à $BB^2$. D'après la @prop-homologie-complementaire-b2, on a :

  $
    H_(1)(RR^3 without D) tilde.eq H_(1)(SS^2) tilde.eq 0
  $

  Alors d'après le @thm-mayer-vietoris la suite suivante est exacte en $H_(1)(RR^3 without partial M)$ :
  #align(
    center,
    [
      #commutative-diagram(
        node-padding: (40pt, 40pt),
        padding: 10pt,
        node((0, 2), $H_(1)(RR^3 without M) tilde.eq ZZ plus.circle H_(1)(RR^3 without D) tilde.eq 0$),
        node((0, 3), $H_(1)(RR^3 without partial M) tilde.eq ZZ$),
        node((0, 4), $H_(0)(RR^3 without PP^2_RR)$),

        arr((0, 2), (0, 3), $H_(1)(i)$),
        arr((0, 3), (0, 4), $partial_0$),
      )],
  )
  Par exactitude de la suite, on a $ker(partial_0) = im(H_(1)(i)) = 2ZZ$, d'où $partial_(0)(1) != 0$ et $2 partial_(0)(1) = partial_(0)(2) = 0$, donc $partial_(0)(1)$ est un élément non-nul d'ordre 2 de $H_(0)(RR^3 without PP^2_RR)$.

  Mais d'après la @prop-h0-abelien-libre $H_(0)(RR^3 without PP^2_RR)$ est un groupe abélien libre, donc il n'existe aucun élément non-nul d'ordre 2 de $H_(0)(RR^3 without PP^2_RR)$, d'où une contradiction.

  Donc il n'existe pas de plongement du plan projectif réel $PP^2_RR$ dans $RR^3$.
])

#pagebreak()

= Applications

== Le problème du rectangle inscrit

L'origine de cette application est le _problème du carré inscrit_, énoncé par #link("https://fr.wikipedia.org/wiki/Otto_Toeplitz")[Otto Toeplitz] en 1911 de la manière suivante :

#align(center)[_"Toute courbe de Jordan admet-elle un carré inscrit ?"_]

Cette question fut l'objet de nombreuses recherches, mais elle n'est toujours pas résolue, en revanche nous sommes capables d'en démontrer une version simplifiée :

#align(center)[_"Toute courbe de Jordan admet-elle un #strike("carré") rectangle inscrit ?"_]

C'est ce que nous appellerons le _problème du rectangle inscrit_.

Par exemple dans le cas d'un cercle, on peut évidemment toujours trouver une infinité de carrés et de rectangles inscrits, le problème devient plus difficile lorsque la courbe est quelconque.

#grid(
  align: horizon,
  columns: (1fr, 1fr),
  rows: auto,
  [
    #figure(
      align(center)[#cetz.canvas({
          import cetz.draw: *

          let r = 2.25
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

          let j = superformula(7, 3, 4, 10, samples: 1000).map(it => (
            it.at(0) * 1.5,
            it.at(1) * 1.5,
          ))
          line(
            ..j,
            close: true,
          )
          set-style(circle: (radius: 0.03, fill: red, stroke: red))
          let a = j.at(179)
          let b = j.at(353)
          let c = j.at(622)
          let d = j.at(841)
          line(a, b, c, d, a, stroke: green, close: true)
          circle(a)
          circle(b)
          circle(c)
          circle(d)
        })
      ],
      caption: [Un rectangle inscrit.],
    ) <fig-courbe-rectangle>
  ],
)

#definition([
  Soit $C$ une partie de $RR^2$.
  On dit que $C$ est une _courbe de Jordan_ s'il existe une fonction continue $func(gamma_C, [0, 1], RR^2)$ telle que :
  - $C$ est l'image de $gamma_C$ : $im(gamma_C) = C$.
  - $C$ est fermée : $gamma_(C)(0) = gamma_(C)(1)$.
  - $C$ est simple : $gamma_C$ est injective sur $[0, 1[$, c'est-à-dire $forall x, y in [0, 1[, gamma_(C)(x) = gamma_(C)(y) => x = y$.
])

#example([
  Le cercle $C$ de la @fig-cercle-carre est bien une courbe de Jordan, en effet, on pose :
  $ func(gamma_C, [0, 1], RR^2, (x, y), (cos(2 pi x), sin(2 pi x))) $
  Alors $gamma_C$ est bien continue, de plus :
  - On a clairement $im(gamma_C) = C$.
  - On a $gamma_(C)(0) = (1, 0) = gamma_(C)(1)$.
  - Pour $x in [0, 1[$, on a $2pi x in [0, 2pi[$, donc $gamma_C$ est injective sur $[0, 1[$.
])

#definition([
  Soit $C$ une courbe de Jordan et $R := (a, b, c, d)$ un rectangle de $RR^2$.
  On dit que le rectangle $R$ est _inscrit dans $C$_ si $a, b, c, d in C$.
])

#example([
  Le carré $R := ((sqrt(2)  slash  2, sqrt(2)  slash  2), (-sqrt(2)  slash  2, sqrt(2)  slash  2), (-sqrt(2)  slash  2, -sqrt(2)  slash  2), (sqrt(2)  slash  2, -sqrt(2)  slash  2))$ est bien inscrit dans le cercle $C$ de la @fig-cercle-carre, en effet :
  - On a $gamma_(C)(1 slash 8) = (sqrt(2) slash 2, sqrt(2) slash 2)$, donc $(sqrt(2) slash 2, sqrt(2) slash 2) in C$.

  - On a $gamma_(C)(3 slash 8) = (-sqrt(2) slash 2, sqrt(2) slash 2)$, donc $(-sqrt(2) slash 2, sqrt(2) slash 2) in C$.

  - On a $gamma_(C)(5 slash 8) = (-sqrt(2) slash 2, -sqrt(2) slash 2)$, donc $(-sqrt(2) slash 2, -sqrt(2) slash 2) in C$.

  - On a $gamma_(C)(7 slash 8) = (sqrt(2) slash 2, -sqrt(2) slash 2)$, donc $(sqrt(2) slash 2, -sqrt(2) slash 2) in C$.
])

#theorem([
  Soit $C$ une courbe de Jordan.
  Alors il existe un rectangle inscrit dans $C$.
]) <thm-rectangle-inscrit>

#proof([
  Pour commencer, au lieu de représenter un rectangle par 4 sommets, on le représente par 2 paires de sommets formant les diagonales :
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
  Pour éviter ça, on étudie le quotient $Q$ de $P$ par la relation d'équivalence $~$ où pour tout $(u, v) in P$, on a $(u, v) ~ (v, u)$.

  Alors pour regrouper ces informations, on définit l'application :
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
])

#pagebreak()

#heading([Annexe], numbering: none)

#theorem(
  number: "A",
  [$SS^n without {N}$ est homéomorphe à $RR^n$ où $N := (0, ..., 0, 1)$ est le pôle nord de $SS^n$.],
) <thm-projection-stereographique>

#proof([
  On définit une application :
  $
    func(f, SS^n without {N}, RR^n, (x_1, ..., x_(n+1)), (x_1/(1-x_(n+1)), ..., x_n/(1-x_(n+1))))
  $
  elle est bien définie, continue, et son inverse est donnée par :
  $
    func(f, RR^n, SS^n without {N}, y := (y_1, ...y_n), ((2 y_1)/(norm(y)^2 + 1), ..., (2 y_n)/(norm(y)^2 + 1), (norm(y)^2 - 1)/(norm(y)^2 + 1)))
  $
  qui est bien définie et continue.
  Donc $f$ est bien un homéomorphisme entre $SS^n without {N}$ et $RR^n$.
])

#theorem(
  number: "B",
  [
    Soit $K$ un compact de $RR^n$, $L$ une partie de $RR^n$ et $func(f, K, L)$ une bijection continue.
    Alors $f$ est un homéomorphisme.
  ],
) <thm-bijection-continue-compact>

#proof([
  Notons $g := f^(-1)$.
  Soit $F$ un fermé de $K$.
  Puisque $K$ est compact et $F$ est fermé, $F$ est compact.
  Puisque $f$ est continue et $F$ est compact, $g^(-1)(F) = f(F)$ est compact.
  Puisque $g^(-1)(F)$ est compact, $g^(-1)(F)$ est fermé.
  Donc $f^(-1) = g$ est continue et $f$ est bien un homéomorphisme.
])

#pagebreak()

#bibliography("biblio.yml", full: true)
