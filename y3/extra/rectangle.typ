#import "../../template.typ": *
#import "@preview/wordometer:0.1.4": *

#set-maths(sequence: (ind: $n$, dom: $ZZ$))

#let cdot = $circle.filled.tiny$

#show: maths.with(
  title: "Problème du rectangle inscrit",
  authors: ("Emanuel Morille",),
  color: "#718355",
  date: true,
)

#show: word-count
#total-characters
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

== Transformations naturelles

#definition([
  Soit $cal(C)$ et $cal(D)$ deux catégories, $func(F, cal(C), cal(D))$ et $func(G, cal(C), cal(D))$ deux foncteurs covariants.
  Une _transformation naturelle $partial$ de $F$ vers $G$_ est la donnée pour tout objet $X in ob(cal(C))$, d'un morphisme $func(partial_X, F(X), G(X))$,
  vérifiant la propriété suivante pour tout objet $Y in ob(cal(C))$ et pour tout morphisme $func(f, X, Y)$, on a :
  $ partial_Y compose F(f) = G(f) compose partial_X $
  c'est-à-dire que le diagramme suivant est commutatif :
  #align(center)[#commutative-diagram(
      node-padding: (80pt, 60pt),
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
  Alors pour tout $n in ZZ$, $phi_n$ induit un morphisme de groupes de $H_(n)(C_cdot)$ dans $H_(n)(D_cdot)$.
])

#proof([
  Soit $n in ZZ$. \
  Soit $z in Z_(n)(C_cdot)$. Alors on a
  $dif_n phi_(n)(z) = phi_(n-1)(dif_n z) = phi_(n-1)(0) = 0$,
  donc $phi_(n)(z) in Z_(n)(D_cdot)$. \
  Soit $b in B_(n)(C_cdot)$. Alors il existe $c in C_(n+1)$ tel que $b = dif_(n+1) c$, et on a :
  $ phi_(n)(b) = phi_(n)(dif_(n+1) c) = dif_(n+1) phi_(n+1)(c) $
  donc $phi_(n)(b) in B_(n)(D_cdot)$.

  On considère $func(overline(phi_n), Z_(n)(C_cdot), H_(n)(D_cdot))$, alors $B_(n)(C_cdot) subset ker(overline(phi_n))$ et d'après la propriété universelle du groupe quotient le morphisme $overline(phi_n)$ induit bien un morphisme de $H_(n)(C_cdot)$ dans $H_(n)(D_cdot)$.
])

#definition([
  Soit $C_cdot$ et $D_cdot$ deux complexes de chaînes, $func(phi_cdot, C_cdot, D_cdot)$ un morphisme de complexes.
  Pour tout $n in ZZ$, on note $func(H_(n)(phi), H_(n)(C_cdot), H_(n)(D_cdot))$ le morphisme de groupes induit par $phi_n$.
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
    Alors la somme directe des morphismes induits $H_(cdot)(phi) := plus.circle.big_(n in ZZ) H_(n)(phi)$ définit bien un morphisme de groupes abéliens gradués.
  Les propriétés de composition et d'identité découlent du @thm-foncteur-comp-ab, donc $H_cdot$ est bien un foncteur de $sans("Comp")$ vers $sans("GrAb")$.
])

== Premières propriétés

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
  Alors pour tout $n in ZZ$, on a $H_(n)(phi) = H_(n)(psi)$.
])

#proof([
  Par définition il existe une suite de morphismes de groupes $sequence(func(h_n, C_n, D_(n+1)))$ telle que pour tout $n in ZZ$, on a $phi_n - psi_n = h_(n-1) dif_n + dif_n h_n$. \
  Soit $n in ZZ$ et $overline(c) in H_(n)(C_cdot)$.
  Alors on a $phi_(n)(c) - psi_(n)(c) = h_(n-1)(dif_n c) + dif_n h_(n)(c) = dif_n h_(n)(c) in B_(n)(D_cdot)$, on en déduit $H_(n)(phi)(c) - H_(n)(psi)(c) = 0 in H_(n)(D_cdot)$.
  Donc $H_(n)(phi) = H_(n)(psi)$.
])

#definition([
  On dit qu'une suite courte de complexes de chaînes est _exacte_, notée :
  #align(center)[#commutative-diagram(
      node-padding: (40pt, 50pt),
      padding: 0pt,
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
      padding: 0pt,
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
      padding: 0pt,
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
      arr((0, 0), (0, 1), $partial_(n+1)$),
      arr((0, 1), (0, 2), $H_(n)(phi)$),
      arr((0, 2), (0, 3), $H_(n)(psi)$),
      arr((0, 3), (1, 1), $partial_(n)$),
      node((1, 1), $H_(n-1)(A_cdot)$),
      node((1, 2), $H_(n-1)(B_cdot)$),
      node((1, 3), $H_(n-1)(C_cdot)$),
      node((1, 4), $dots.c$),
      arr((1, 1), (1, 2), $H_(n-1)(phi)$, label-pos: right),
      arr((1, 2), (1, 3), $H_(n-1)(psi)$, label-pos: right),
      arr((1, 3), (1, 4), $partial_(n-1)$, label-pos: right),
    )]
  De plus pour tout diagramme commutatif :
  #align(center)[#commutative-diagram(
      node-padding: (40pt, 40pt),
      padding: 0pt,

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
      arr((1, 1), (1, 2), $phi'_cdot$),
      arr((1, 2), (1, 3), $psi'_cdot$),
      arr((1, 3), (1, 4), ""),

      arr((0, 1), (1, 1), $f_cdot$),
      arr((0, 2), (1, 2), $g_cdot$),
      arr((0, 3), (1, 3), $h_cdot$),
    )]
  la transformation $partial_n$ est naturelle dans le sens où le diagramme suivant est commutatif :
  #align(center)[#commutative-diagram(
      node-padding: (40pt, 40pt),
      padding: 2pt,
      node((0, 0), $H_(n)(C_cdot)$),
      node((0, 1), $H_(n-1)(A_cdot)$),
      node((1, 0), $H_(n)(C'_cdot)$),
      node((1, 1), $H_(n-1)(A'_cdot)$),
      arr((0, 0), (0, 1), $partial_n$),
      arr((1, 0), (1, 1), $partial_n$, label-pos: right),
      arr((0, 0), (1, 0), $H_(n)(h)$, label-pos: right),
      arr((0, 1), (1, 1), $H_(n-1)(f)$),
    )]

])

#proof([
  Soit $n in ZZ$. On commence par faire un diagramme en 3 dimensions pour la suite :
  #align(center)[#commutative-diagram(
      node-padding: (20pt, 15pt),
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
  Donc la suite longue est bien exacte.

  Vérifions que $partial_n$ est naturelle.
  Soit $overline(c) in H_(n)(C_cdot)$. \
  Par construction il existe $b in B_n$ tel que $psi_(n)(b) = c$ et il existe $a in Z_(n-1)(A_cdot)$ tel que $phi_(n-1)(a) = dif_n b$ et $partial_n overline(c) = overline(a) in H_(n-1)(A_cdot)$.
  Donc on a $H_(n-1)(f)(partial_n overline(c)) = overline(f_(n-1)(a)) in H_(n-1)(A'_cdot)$. \
  De plus $h_(n)(c) = h_(n)(psi_(n)(b)) = psi'_(n)(g_(n)(b))$ et $phi'_(n-1)(f_(n-1)(a)) = g_(n-1)(phi_(n-1)(a)) = g_(n-1)(dif_n b) = dif_n g_(n)(b)$, alors par construction on a $partial_n H_(n)(h)(overline(c)) = overline(f_(n-1)(a)) in H_(n-1)(A'_cdot)$.
  Donc $H_(n-1)(f)(partial_n) = partial_n H_(n)(h)$.
])

#definition([
  Soit $C_cdot$ et $D_cdot$ deux complexes de chaînes.
  On dit que $D_cdot$ est un _sous-complexe de chaînes de $C_cdot$_ si pour tout $n in ZZ$, on a $D_n subset C_n$.
])

TODO : Complexe quotient.

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

#example([
  Un $2$-simplexe standard, il s'agit d'un triangle, les arêtes en vert sont des $1$-faces du triangle, les sommets en rouge sont des $0$-faces du triangle et des arêtes :
  #align(center)[
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
  ]
])

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
  Soit $X$ et $Y$ deux espaces topologiques et $func(f, X, Y)$ une application continue.
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

#proposition([
  La suite $sequence(C_n)$ où pour tout $n < 0$, on pose $C_n := 0$, munie des morphismes des bords $sequence(func(dif_n, C_n, C_(n-1)))$ est un foncteur de $sans("Top")$ vers $sans("Comp")$.
]) <prop-foncteur-top-comp>

#proof([
  Soit $n in ZZ$.
  - Soit $X$ un espace topologique.
    Alors la suite $sequence(C_(n)(X))$ munie des morphismes de bords $sequence(func(dif_n, C_(n)(X), C_(n-1)(X)))$ est bien un complexe de chaînes d'après la @prop-bord-composition.
  - Soit $X$ et $Y$ deux espaces topologiques, $func(f, X, Y)$ une application continue.
    Alors la suite des applications induites $sequence(func(C_(n)(f), C_(n)(X), C_(n)(Y)))$ est bien un morphisme de complexes d'après la @prop-continue-commute.
  La propriété de composition découle de la @prop-top-composition et la propriété d'identité découle directement de la définition, donc $C_n$ est bien un foncteur de $sans("Top")$ vers $sans("Ab")$.
])

== Définitions de l'homologie singulière

=== D'un espace topologique

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

#corollary([
  Pour tout $n in ZZ$, le $n$#super("e") groupe d'homologie singulière $H_n$ est un foncteur de $sans("Top")$ vers $sans("Ab")$
])

#proof([
  Soit $n in ZZ$.
  D'après la @prop-foncteur-top-comp $C_cdot$ est un foncteur de $sans("Top")$ vers $sans("Comp")$ et d'après le @thm-foncteur-comp-ab $H_n$ est un foncteur de $sans("Comp")$ vers $sans("Ab")$, par composition $H_n = H_(n)(C_cdot)$ est bien un foncteur de $sans("Top")$ vers $sans("Ab")$.
])

#corollary([
  L'homologie singulière $H_cdot$ est un foncteur de $sans("Top")$ vers $sans("GrAb")$.
])

#proof([
  D'après la @prop-foncteur-top-comp $C_cdot$ est un foncteur de $sans("Top")$ vers $sans("Comp")$ et d'après le @cor-foncteur-comp-grab $H_cdot$ est un foncteur de $sans("Comp")$ vers $sans("GrAb")$, par composition $H_cdot = H_(cdot)(C_cdot)$ est bien un foncteur de $sans("Top")$ vers $sans("Ab")$.
])

#theorem(
  title: "Axiome de dimension",
  [
    Soit $P$ un espace topologie constitué d'un unique point.
    Alors le groupe $H_(n)(P)$ est non-trivial si et seulement $n = 0$.
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

TODO

=== D'une paire d'espace topologique

#definition([
  Soit $C_(cdot)(X)$ et $C_(cdot)(Y)$ deux complexes de chaînes singulières, et $func(f, X, Y)$ une application continue.
  Pour tout $n in ZZ$, on note $func(H_(n)(f), H_(n)(X), H_(n)(Y))$ le morphisme de groupes induit par $C_(n)(f)$.
])

// == Paires d'espaces topologiques

// #proposition([
//   Soit $(X, A)$ une paire d'espaces topologiques.
//   Alors pour tout $n in ZZ$, $dif_n$ induit un morphisme $overline(dif)_n$ de $lquotient(C_(n)(X), C_(n)(A))$ dans $lquotient(C_(n-1)(X), C_(n-1)(A))$ tel que $overline(dif)_n overline(dif)_(n+1) = 0$.
// ])

// #proof([
//   Soit $n in ZZ$.
//   Alors on a $C_(n)(A) subset C_(n)(X)$, on peut donc former le quotient $lquotient(C_(n)(X), C_(n)(A))$.

//   On pose $func(delta_n := overline(dif_n), C_(n)(X), lquotient(C_(n-1)(X), C_(n-1)(A)))$, alors $C_(n)(A) subset ker(delta_n)$ et d'après la propriété universelle du groupe quotient $delta_n$ induit bien un morphisme $overline(dif)_n$ de $lquotient(C_(n)(X), C_(n)(A))$ dans $lquotient(C_(n-1)(X), C_(n-1)(A))$.
//   Enfin puisque $dif_n dif_(n+1) = 0$, on a $overline(dif)_n overline(dif)_(n+1) = overline(dif_n dif_(n+1)) = 0$.
// ])

// #remark([
//   Soit $(X, A)$ une paire d'espaces topologiques.
//   La suite $sequence(lquotient(C_(n)(X), C_(n)(A)))$ munie des morphismes de bords induits $sequence(func(overline(dif)_n, lquotient(C_(n)(X), C_(n)(A)), lquotient(C_(n-1)(X), C_(n-1)(A))))$ forme un complexe de chaînes singulières.
// ])

// #definition([
//   Soit $(X, A)$ une paire d'espaces topologiques.
//   On appelle _complexe de chaînes singulières de la paire $(X, A)$_ le complexe de chaînes singulières quotient $C_(cdot)(X, A) := lquotient(C_(cdot)(X), C_(cdot)(A))$.
// ])

// #remark([
//   Dans le cas de la paire d'espaces topologiques $(X, emptyset)$, on trouve $C_(cdot)(X, emptyset) tilde.eq C_(cdot)(X)$ et $H_(cdot)(X, emptyset) tilde.eq H_(cdot)(X)$.
// ])


// #proposition([
//   Soit $C_(cdot)(X, A)$ et $C_(cdot)(Y, B)$ deux complexes de chaînes singulières, et $func(f, (X, A), (Y, B))$ un morphisme de paires.
//   Alors l'application induite $func(f_*, C_(n)(X), C_(n)(Y))$ détermine un morphisme de complexes.
// ])

// #proof([
//   Pour tout $n in ZZ$,
//   on pose $func(phi_n := overline(f_*), C_(n)(X), C_(n)(Y, B))$, alors puisque $f(A) subset B$, on en déduit $f_* (C_(n)(A)) subset ker(phi_n)$ et d'après la propriété universelle du groupe quotient $phi_n$ induit un morphisme $overline(phi_n)$ de $C_(n)(X, A)$ dans $C_(n)(Y, B)$.

//   Soit $n in ZZ$. Alors d'après la @prop-continue-commute puisque $dif_n f_* = f_* dif_n$, on a $overline(dif_n phi_n) = overline(phi_(n-1) dif_n)$.
//   Donc $phi_n$ est bien un morphisme de complexes.
// ])

// #definition([
//   Soit $C_(cdot)(X, A)$ et $C_(cdot)(Y, B)$ deux complexes de chaînes singulières, et $func(f, (X, A), (Y, B))$ un morphisme de paires.
//   Pour tout $n in ZZ$, on note $func(H_(n)(f), H_(n)(X, A), H_(n)(Y, B))$ le morphisme induit par le morphisme de complexes déterminé par $f_*$.
// ])

// #theorem([
//   Pour tout $n in ZZ$, le $n$#super("e") groupe d'homologie singulière des paires d'espaces topologiques $func(H_n, sans("Top")_2, sans("Ab"))$ est un foncteur.
// ])

// #proof([
//   Soit $n in ZZ$.
//   - Soit $(X, A)$ une paire d'espaces topologiques.
//     Alors le $n$#super("e") groupe d'homologie singulière $H_(n)(X, A)$ est bien un groupe abélien libre.
//   - Soit $(X, A)$ et $(Y, B)$ deux paires d'espaces topologiques, et $func(f, (X, A), (Y, B))$ un morphisme de paires.
//     Alors l'application $func(H_(n)(f), H_(n)(X, A), H_(n)(Y, B))$ est un bien morphisme de groupes.
//   Soit $(X, A), (Y, B)$ et $(Z, C)$ trois paires d'espaces topologiques.
//   - Soit $func(f, (X, A), (Y, B))$ et $func(g, (Y, B), (Z, C))$ deux morphismes de paires.
//     Alors la composition $func(g compose f, (X, A), (Z, C))$ est un morphisme de paires qui passe au quotient et vérifie :
//     $ H_(n)(g compose f) = H_(n)(g) compose H_(n)(f). $
//   - On considère $func(id_((X, A)))$. Soit $func(sigma, Delta^n, (X, A))$ un $n$-simplexe singulier, alors :
//     $ id_((X, A)*)(sigma) = id_((X, A)) compose sigma = sigma $
//     puisque les $n$-chaînes singulières sont engendrées par les $n$-simplexes singuliers, on en déduit que $id_((X, A)*) = id_(C_(n)(X, A))$, par passage au quotient on a :
//     $ H_(n)(id_((X, A))) = id_(H_(n)(X, A)). $
//   Donc $H_(n)$ est un foncteur.
// ])

// #proposition([
//   Soit $C_(cdot)(X, A)$ un complexe de chaînes singulières.
//   Alors pour tout $n in ZZ$, les groupes $H_(n)(X, A)$ et $lquotient(dif_(n)^(-1)(C_(n-1)(A)), (dif_(n+1)(C_(n+1)(X)) + C_(n)(A)))$ sont isomorphes.
// ]) <prop-iso-homologie-paire>

// #proof([
//   Soit $n in ZZ$. \
//   Soit $tau in dif_(n+1)(C_(n+1)(X)) + C_(n)(A)$, il existe $sigma_1 in C_(n+1)(X)$ et $sigma_2 in C_(n)(A)$ tels que $tau = dif_(n+1) sigma_1 + sigma_2$.
//   Alors d'après la @prop-bord-composition on a :
//   $
//     dif_(n) tau = dif_(n)(dif_(n+1) sigma_1 + sigma_2) = (dif_(n) dif_(n+1)) sigma_1 + dif_(n) sigma_2 = dif_(n) sigma_2
//   $
//   donc $tau in dif_(n)^(-1)(C_(n-1)(A))$, on peut donc former le quotient $lquotient(dif_(n)^(-1)(C_(n-1)(A)), (dif_(n+1)(C_(n+1)(X)) + C_(n)(A)))$.

//   On pose $func(phi, dif_(n)^(-1)(C_(n-1)(A)), H_(n)(X, A), sigma, overline(sigma))$, qui est bien un morphisme de groupes.
//   - Soit $eta in H_(n)(X, A)$, il existe $zeta in Z_(n)(X, A)$ et $z in C_(n)(X)$ tels que $eta = overline(zeta)$ et $zeta = overline(z)$. \
//     Puisque $overline(dif_(n) z) = overline(dif)_(n) zeta = 0 in C_(n)(X, A)$, il existe $sigma in C_(n-1)(A)$ tel que $dif_n z = sigma$, d'où $z in dif_(n)^(-1)(C_(n-1)(A))$.
//     Donc $phi(z) = eta$ et $phi$ est surjectif.
//   - Soit $sigma in ker(phi)$.
//     Puisque $overline(tau) = 0 in H_(n)(X, A)$, il existe $b in B_(n)(X, A)$ tel que $overline(tau) = overline(b)$.
//     C'est-à-dire qu'il existe $c in C_(n+1)(X, A)$ et $sigma in C_(n+1)(X)$ tels que $b = overline(dif)_(n+1) c$ et $c = overline(sigma)$. \
//     On peut écrire $overline(tau) = overline(dif)_(n+1) overline(sigma) = overline(dif_(n+1) sigma) in C_(n)(X, A)$, donc $tau in dif_(n+1)(C_(n+1)(X)) + C_(n)(A)$.

//     Soit $tau in dif_(n+1)(C_(n+1)(X)) + C_(n)(A)$, il existe $sigma_1 in C_(n+1)(X)$ et $sigma_2 in C_(n)(A)$ tels que $tau = dif_(n+1) sigma_1 + sigma_2$.
//     Alors $overline(tau) = overline(dif_(n+1) sigma_1) = overline(dif)_(n+1) overline(sigma) in C_(n)(X, A) $, d'où $overline(tau) in B_(n)(X, A)$ et $overline(tau) = 0 in H_(n)(X, A)$, donc $tau in ker(phi)$.
//   D'après le premier théorème d'isomorphisme $phi$ induit un isomorphisme entre les groupes
//   $H_(n)(X, A)$ et $lquotient(dif_(n)^(-1)(C_(n-1)(A)), (dif_(n+1)(C_(n+1)(X)) + C_(n)(A)))$.
// ])

// #proposition([
//   Soit $C_(cdot)(X, A)$ un complexe de chaînes singulières.
//   Alors pour tout $n in ZZ$, $dif_n$ induit un morphisme $partial_n$ de $H_(n)(X, A)$ dans $H_(n-1)(A)$.
// ])

// #proof([
//   Soit $n in ZZ$.
//   D'après la @prop-iso-homologie-paire il existe un isomorphisme :
//   $
//     func(psi, H_(n)(X, A), lquotient(dif_(n)^(-1)(C_(n-1)(A)), (dif_(n+1)(C_(n+1)(X)) + C_(n)(A)))).
//   $
//   Pour tout $eta in H_(n)(X, A)$, il existe $tau in dif_(n)^(-1)(C_(n-1)(A))$ tel que $overline(tau) = psi(eta)$.
//   Alors d'après la @prop-bord-composition on a $dif_(n-1) dif_n tau = 0$, donc $dif_n tau in Z_(n-1)(A)$.
//   On pose $partial_(n) eta := overline(dif_(n) tau) in H_(n-1)(A)$.

//   Supposons que $eta = 0$, c'est-à-dire $tau in dif_(n+1)(C_(n+1)(X)) + C_(n)(A)$, alors $dif_n tau in B_(n)(A)$, d'où $partial_(n) eta = 0$.
//   Donc $partial_n$ est un morphisme bien défini.
// ])

// #theorem([
//   Soit $C_(cdot)(X, A)$ et $C_(cdot)(Y, B)$ deux complexes de chaînes singulières. Alors pour tout $n in ZZ$, le morphisme $partial_n$ est une transformation naturelle, c'est-à-dire, pour tout morphisme de paires $func(f, (X, A), (Y, B))$, on a :
//   $ partial_n H_(n)(f) = H_(n-1)(f) partial_n. $
// ])

// #proof([
//   Soit $n in ZZ$.
//   Puisque $partial_n$ est induit par $dif_n$, d'après la @prop-continue-commute on a bien :
//   $
//     partial_n H_(n)(f) = overline(dif_n f_*) = overline(f_* dif_n) = H_(n-1)(f) partial_n.
//   $
//   Donc $partial_n$ est bien une transformation naturelle. TODO.
// ])


// #definition([
//   Soit $C_(cdot)(X)$ un complexe de chaînes singulières et $n in ZZ$.
//   On appelle _$n$#super("e") nombre de Betti de X_ le rang de $H_(n)(X)$ s'il est fini.
// ])

// #definition([
//   Une _théorie de l'homologie_ sur la catégorie des paires d'espaces topologiques $sans("Top")_2$ dans la catégorie des groupes abéliens $sans("Ab")$ est une suite de foncteurs $sequence(func(H_n, sans("Top")_2, sans("Ab")))$ munie de transformations naturelles $sequence(func(partial_n, H_(n)(X, A), H_(n-1)(A) := H_(n-1)(A, emptyset)))$ vérifiant les _axiomes d'Eilenberg-Steenrod_ pour toutes paires d'espaces topologiques $(X, A), (Y, B)$ et $n in ZZ$ :
//   - _Dimension <axiome-dimension>_ : Soit $P$ un espace constitué d'un unique point.
//     Alors le groupe $H_(n)(P)$ est non-trivial si et seulement si $n = 0$.
//   - _Exactitude <axiome-exactitude>_ : En notant $func(i, A, X)$ et $func(j, X, (X, A))$ les inclusions canoniques, alors la suite suivante est exacte :
//     $
//       ... -> H_(n+1)(X, A) ->^(partial_(n+1)) H_(n)(A) ->^(H_(n)(i)) H_(n)(X) ->^(H_(n)(j)) H_(n)(X, A) ->^(partial_n) H_(n-1)(A) -> ...
//     $
//   - _Homotopie <axiome-homotopie>_ : Soit $func(f_0 \, f_1, (X, A), (Y, B))$ deux morphismes de paires homotopes.
//     Alors les applications induites en homologie $func(H_(n)(f_(0))\, H_(n)(f_(1)), H_(n)(X, A), H_(n)(Y, B))$ sont égales.
//   - _Excision <axiome-excision>_ : Soit $U$ un sous-ensemble de $A$ tel que l'adhérence de $U$ est contenue dans l'intérieur de $A$.
//     En notant $func(i, (X without U, A without U), (X, A))$ l'inclusion canonique.
//     Alors l'application induite en homologie $func(H_(n)(i), H_(n)(X without U, A without U), H_(n)(X, A))$ est un isomorphisme.
// ]) <def-theorie-homologie>


// #theorem([
//   La suite des $n$#super("e") groupe d'homologie singulière des paires d'espaces topologiques $sequence(func(H_n, sans("Top")_2, sans("Ab")))$ munie des morphismes $sequence(func(partial_n, H_(n)(X, A), H_(n-1)(A)))$ est une théorie de l'homogie vérifiant les @def-theorie-homologie[axiomes d'Eilenberg-Steenrod].
// ])


// #proof(
//   of: [de @axiome-exactitude[l'axiome d'exactitude]],
//   [
//     Soit $n in ZZ$.
//     - Soit $alpha in ker(H_(n)(i))$, il existe $tau in C_(n)(A)$ tel que $alpha = overline(tau)$. \
//       Puisque $alpha in ker(H_(n)(i))$, on a $tau in B_(n)(X)$, il existe $sigma in C_(n+1)(X)$ tel que $tau = dif_(n+1) sigma$. \
//       Puisque $overline(d)_(n+1) overline(sigma) = overline(dif_(n+1) sigma) = overline(tau) = 0 in C_(n)(X, A)$, on a $overline(sigma) in Z_(n)(X, A)$. \
//       Alors d'après la définition de $partial_(n+1)$, on a $partial_(n+1)(overline(sigma)) = alpha$.
//     - TODO.
//     - TODO.
//   ],
// )

// #proof(
//   of: [de @axiome-homotopie[l'axiome d'homotopie]],
//   [
//     TODO.
//   ],
// )

// #proof(
//   of: [de @axiome-excision[l'axiome d'excision]],
//   [
//     TODO.
//   ],
// )

// #theorem(
//   title: "Théorème de Mayer-Vietoris",
//   [
//     Soit $U$ et $V$ deux ouverts d'un espace topologique.
//     En notant $func(i_U, U inter V, U)$, $func(i_V, U inter V, V)$, $func(j_U, U, U union V)$ et $func(j_V, V, U union V)$ les inclusions canoniques, alors la suite suivante est exacte :
//     $
//       ... -> H_(n+1)(U union V) ->^(partial_(n+1)) H_(n)(U inter V) ->^((-i_(U*), i_(V*))) directsum(H_(n)(U), H_(n)(V)) ->^(j_(U*) + j_(V*)) H_(n)(U union V) -> ...
//     $
//   ],
// )

// #proof([
//   TODO.
// ])

#bibliography("biblio.yml", full: true)
