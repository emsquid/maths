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

#examples([
  - La catégorie $sans("Top")_2$, les objets sont les paires d'espaces topologiques et les morphismes sont les applications continues.
  - La catégorie $sans("Ab")$, les objets sont les groupes abéliens et les morphismes sont les morphismes de groupes.
])

#definition([
  Soit $cal(C)$ et $cal(D)$ deux catégories.
  Un _foncteur_ $func(F, cal(C), cal(D))$ est la donnée :
  - Pour tout objet $X in ob(cal(C))$, d'un objet $F(X) in ob(cal(D))$.
  - Pour tout objets $X, Y in ob(C)$ et morphisme $func(f, X, Y)$, d'un morphisme $func(F(f), F(X), F(Y))$.
  Vérifiant les propriétés suivantes pour tout objets $X, Y, Z in ob(cal(C))$ :
  - _Composition_ : Pour tout morphismes $func(f, X, Y)$ et $func(g, Y, Z)$, on a :
    $ F(g compose f) = F(g) compose F(f). $
  - _Identité_ : On a : $ F(id_X) = id_F(X). $
])


#example([
  - Pour toute catégorie $cal(C)$, l'identité $func(id_cal(C), cal(C), cal(C))$ est un foncteur.
])

#definition([
  Soit $cal(C)$ et $cal(D)$ deux catégories, $func(F, cal(C), cal(D))$ et $func(G, cal(C), cal(D))$ deux foncteurs.
  Une _transformation naturelle_ $partial$ est la donnée pour tout objet $X in ob(cal(C))$, d'un morphisme $func(partial_X, F(X), G(X))$,
  vérifiant la propriété suivante pour tout objet $Y in ob(cal(C))$ et pour tout morphisme $func(f, X, Y)$, on a :
  $ partial_Y compose F(f) = G(f) compose partial_X. $
])

#remark([
  Cette dernière égalité revient à ce que le diagramme suivant soit commutatif :
  #align(center)[#commutative-diagram(
      node-padding: (60pt, 50pt),
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

= Homologie singulière

La majorité des énoncés suivants sont issus de la source @algtop.

#definition([
  Une _théorie de l'homologie_ sur la catégorie des paires d'espaces topologiques $sans("Top")_2$ dans la catégorie des groupes abéliens $sans("Ab")$ est une suite de foncteurs $sequence(func(H_n, sans("Top")_2, sans("Ab")))$ munie de transformations naturelles $sequence(func(partial_n, H_(n)(X, A), H_(n-1)(A) := H_(n-1)(A, emptyset)))$ vérifiant les _axiomes d'Eilenberg-Steenrod_ pour toutes paires d'espaces topologiques $(X, A), (Y, B)$ et $n in ZZ$ :
  - _Dimension <axiome-dimension>_ : Soit $P$ un espace constitué d'un unique point.
    Alors le groupe $H_(n)(P)$ est non-trivial si et seulement si $n = 0$.
  - _Exactitude <axiome-exactitude>_ : En notant $func(i, A, X)$ et $func(j, X, (X, A))$ les inclusions canoniques, alors la suite suivante est exacte :
    $
      ... -> H_(n+1)(X, A) ->^(partial_(n+1)) H_(n)(A) ->^(H_(n)(i)) H_(n)(X) ->^(H_(n)(j)) H_(n)(X, A) ->^(partial_n) H_(n-1)(A) -> ...
    $
  - _Homotopie <axiome-homotopie>_ : Soit $func(f_0 \, f_1, (X, A), (Y, B))$ deux morphismes de paires homotopes.
    Alors les applications induites en homologie $func(H_(n)(f_(0))\, H_(n)(f_(1)), H_(n)(X, A), H_(n)(Y, B))$ sont égales.
  - _Excision <axiome-excision>_ : Soit $U$ un sous-ensemble de $A$ tel que l'adhérence de $U$ est contenue dans l'intérieur de $A$.
    En notant $func(i, (X without U, A without U), (X, A))$ l'inclusion canonique.
    Alors l'application induite en homologie $func(H_(n)(i), H_(n)(X without U, A without U), H_(n)(X, A))$ est un isomorphisme.
]) <def-theorie-homologie>

== Simplexes

#definition([
  Soit $E$ un $RR$-espace vectoriel et $A$ un sous-ensemble de $E$.
  On dit que $A$ est _convexe_ si :
  $ forall p, q in A, [p, q] := {(1 - t)p + t q | t in [0, 1]} subset A. $
])

#definition([
  Soit $E$ un $RR$-espace vectoriel, $A$ un sous-ensemble de $E$ et $p_0, ..., p_n$ des éléments de $A$.
  On appelle _combinaison convexe_ une combinaison de la forme $t_0 p_0 + dots.c + t_n p_n$, telle que $t_0, ..., t_n in [0, 1]$ et $t_0 + dots.c + t_n = 1$.
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
  On appelle _enveloppe convexe de $A$_, notée $[A]$, l'ensemble des combinaisons convexes d'éléments de $A$.
])

#proposition([
  Soit $E$ un $RR$-espace vectoriel et $A$ un sous-ensemble de $E$.
  Alors l'enveloppe convexe de $A$ est le plus petit ensemble convexe contenant $A$.
])

#proof([
  Soit $p, q in [A]$ et $t in [0, 1]$.
  Puisque $p$ et $q$ sont des combinaisons convexes d'éléments de $A$, la combinaison $(1 - t)p + t q$ est aussi une combinaison convexe d'éléments de $A$, d'après la @prop-combinaison-convexe on a $(1 - t)p + t q in [A]$.
  Donc l'ensemble $[A]$ est convexe.

  Soit $B$ un sous-ensemble convexe de $E$ contenant $A$.
  Soit $x in [A]$. Puisque $x$ est une combinaison convexe d'éléments de $A subset B$, d'après la @prop-combinaison-convexe on a $x in B$.
  Donc $[A] subset B$.
])

#definition([
  Soit $E$ un $RR$-espace vectoriel et $F$ une famille libre de $n + 1$ éléments de $E$.
  On appelle _$n$-simplexe généré par $F$_ l'enveloppe convexe de $F$. On dit que les éléments de $F$ sont les _sommets_ de $[F]$ et que $n$ est la _dimension_ de $[F]$.
])

#definition([
  On appelle _$n$-simplexe standard_, noté $Delta^n$, le $n$-simplexe généré par la base canonique de $RR^(n+1)$.
])

#proposition([
  Soit $E$ un $RR$-espace vectoriel et $F := (f_0, ..., f_n)$ une famille libre de $n + 1$ éléments de $E$.
  Alors l'application :
  $
    func(gensubgroup(f_0, ..., f_n), Delta^n, [F], (t_0, ..., t_n), t_0 f_0 + ... + t_n f_n)
  $
  est un homéomorphisme.
]) <prop-coordonnees-barycentriques>

#proof([
  Soit $(s_0, ..., s_n), (t_0, ..., t_n) in Delta^n$ tels que $s_0 f_0 + ... + s_n f_n = t_0 f_0 + ... + t_n f_n$.
  En particulier on a $(s_0 - t_0)f_0 + ... + (s_n - t_n)f_n = 0$, et puisque la famille $(f_0, ..., f_n)$ est libre, on obtient $s_0 - t_0 = ... = s_n - t_n = 0$, c'est-à-dire $(s_0, ..., s_n) = (t_0, ..., t_n)$.
  Donc $gensubgroup(f_0, ..., f_n)$ est injective.

  Soit $x in [F]$.
  Alors par définition de $[F]$, il existe $(t_0, ..., t_n) in Delta^n$ tels que $x := t_0 f_0 + ... + t_n f_n$.
  Donc $gensubgroup(f_0, ..., f_n)$ est surjective.

  Puisque $gensubgroup(f_0, ..., f_n)$ est une application linéaire et que $Delta^n$ est de dimension finie, $gensubgroup(f_0, ..., f_n)$ est continue.
  De plus $Delta^n$ est compact et $[F]$ est séparé, donc $gensubgroup(f_0, ..., f_n)$ est un homéomorphisme.
])

#definition([
  Soit $E$ un $RR$-espace vectoriel, $F := (f_0, ..., f_n)$ une famille libre de $n + 1$ éléments de $E$ et $x := t_0 f_0 + ... + t_n f_n$ un élément de $[F]$.
  On appelle _coordonnées barycentriques de $x$_ les coefficients $t_0, ..., t_n in [0, 1]$.
])

#definition([
  Soit $E$ un $RR$-espace vectoriel, $F$ une famille libre de $n+1$ éléments de $E$ et $G$ une famille non-vide d'éléments de $F$.
  On dit que $[G]$ est une _face_ de $[F]$.
  // Si $G$ contient $n$ éléments, on dit que $[G]$ est une _face_ de $[F]$.
])

== Chaînes

#definition([
  Soit $X$ un espace topologique.
  On appelle _$n$-simplexe singulier sur $X$_ une application continue de $Delta^n$ dans $X$.
])

#example([
  L'application $gensubgroup(e_0, ..., e_n)$ de la @prop-coordonnees-barycentriques, où $(e_0, ..., e_n)$ est la base canonique de $RR^(n+1)$, est un $n$-simplexe singulier sur $RR^(n+1)$.
])

#definition([
  Soit $X$ un espace topologique. On note $C_(n)(X)$ le groupe abélien libre engendré par les $n$-simplexes singuliers sur $X$, on appelle _$n$-chaîne singulière_ un élément de $C_(n)(X)$.
])

#proposition([
  Soit $X$ et $Y$ deux espaces topologiques, $func(sigma, Delta^n, X)$ un $n$-simplexe singulier sur $X$ et $func(f, X, Y)$ une application continue.
  Alors la composition $func(f compose sigma, Delta^n, Y)$ est un $n$-simplexe singulier sur $Y$.
])

#proof([
  Puisque $f$ est continue sur $X$ et $sigma$ est continue sur $Delta^n$, par composition $f compose sigma$ est continue de $Delta^n$ dans $Y$.
  Donc $f compose sigma$ est un $n$-simplexe singulier sur $X$.
])

#definition([
  Soit $X$ et $Y$ deux espaces topologiques et $func(f, X, Y)$ une application continue.
  On appelle _application induite par $f$_, notée $f_*$, le morphisme de groupes :
  $
    func(f_*, C_n (X), C_n (Y), sum_(k=0)^m lambda_k sigma_k, sum_(k=0)^m lambda_k (f compose sigma_k)).
  $
])

#proposition([
  Soit $X$, $Y$ et $Z$ trois espaces topologiques, $func(f, X, Y)$ et $func(g, Y, Z)$ deux applications continues.
  Alors $(g compose f)_* = g_* compose f_*$.
])

#proof([
  Soit $n in NN$.
  Puisque les $n$-chaînes singulières sont engendrées par les $n$-simplexes singuliers, il suffit de montrer le résultat pour un $n$-simplexe singulier $func(sigma, Delta^n, X)$.
  Alors on a :
  $
    (g compose f)_(*)(sigma) = (g compose f) compose sigma = g compose (f compose sigma) = g compose f_(*)(sigma) = g_(*)(f_(*)(sigma))
  $
])

#definition([
  Soit $X$ un espace topologique et $func(sigma, Delta^n, X)$ un $n$-simplexe singulier sur $X$.
  On appelle _bord de $sigma$_, noté $dif_n sigma$, la $(n-1)$-chaîne singulière sur $X$ définie par :
  $
    dif_n sigma := sum_(k=0)^n (-1)^k (sigma compose gensubgroup(e_0, ..., overshell(e_k),... e_n)).
  $
  où le symbole $overshell(dot)$ signifie que l'élément est enlevé.
])

#definition([
  Soit $X$ un espace topologique et $n in NN$.
  On appelle _morphisme de bord_, noté $dif_n$, le morphisme de groupes induit:
  $
    func(dif_n, C_n (X), C_(n-1)(X), sum_(k=0)^m lambda_k sigma_k, sum_(k=0)^m lambda_k d_n sigma_k).
  $
])

#proposition([
  Soit $X$ et $Y$ deux espaces topologiques et $func(f, X, Y)$ une application continue.
  Alors pour tout $n in NN$, on a $dif_n f_* = f_* dif_n$.
]) <prop-continue-commute>

#proof([
  Soit $n in NN$.
  Puisque les $n$-chaînes singulières sont engendrées par les $n$-simplexes singuliers, il suffit de montrer le résultat pour un $n$-simplexe singulier $func(sigma, Delta^n, X)$.
  Alors on a :
  $
    dif_n f_(*)(sigma) &= sum_(k=0)^n (-1)^k ((f compose sigma) compose gensubgroup(e_0, ..., overshell(e_k), ..., e_n)) \
    &= sum_(k=0)^n (-1)^k (f compose (sigma compose gensubgroup(e_0, ..., overshell(e_k), ..., e_n)))\
    &= f_*(d_n sigma).
  $
])

#proposition([
  Soit $X$ un espace topologique. Alors pour tout $n in NN$, on a $dif_n compose dif_(n+1) = 0$.
])

#proof([
  Soit $n in NN$.
  Puisque les $n$-chaînes singulières sont engendrées par les $n$-simplexes singuliers, il suffit de montrer le résultat pour un $n$-simplexe singulier $func(sigma, Delta^n, X)$.
  Alors on a :
  $
    dif_(n+1)(sigma) = sum_(k=0)^(n+1) (-1)^k (sigma compose gensubgroup(e_0, ..., overshell(e_k), ..., e_n))
  $
  donc en appliquant $dif_n$, on obtient :
  $
    (dif_n compose dif_(n+1))(sigma)
    &= &&dif_(n)(sum_(k=0)^(n+1) (-1)^k (sigma compose gensubgroup(e_0, ..., overshell(e_k), ..., e_n))) \
    &= &&sum_(k=0)^(n+1) (-1)^k dif_(n)(sigma compose gensubgroup(e_0, ..., overshell(e_k), ..., e_n))) \
    &= &&sum_(0 <= k < l <= n + 1) (-1)^(k + l) (sigma compose gensubgroup(e_0, ..., overshell(e_k), ..., overshell(e_l), ..., e_n)) \
    & &&+ sum_(0 <= l < k <= n + 1) (-1)^(k + l - 1) (sigma compose gensubgroup(e_0, ..., overshell(e_l), ..., overshell(e_k), ..., e_n)) \
    &= &&sum_(0 <= k < l <= n + 1) ((-1)^(k + l) + (-1)^(k + l + 1)) (sigma compose gensubgroup(e_0, ..., overshell(e_k), ..., overshell(e_l), ..., e_n)) \
    &= &&0
  $
  car les puissances de $-1$ s'annulent.
])

== Complexes de chaînes

#definition([
  Soit $X$ un espace topologique.
  On appelle _complexe de chaînes singulières_, noté $C_(cdot)(X)$, la suite de groupes abéliens libres $sequence(C_(n)(X))$ munie des morphismes de bords $sequence(func(dif_n, C_(n)(X), C_(n-1)(X)))$, avec pour convention $C_(n)(X)$ trivial si $n < 0$.
])

#definition([
  Soit $C_(cdot)(X)$ un complexe de chaînes singulières et $n in ZZ$.
  - On appelle _$n$-cycle singulier_ un élément de $Z_(n)(X) := ker(dif_n)$.
  - On appelle _$n$-bord singulier_ un élément de $B_(n)(X) := im(dif_(n+1))$.
  - On appelle _$n$#super("e") groupe d'homologie singulière_ le groupe quotient $H_(n)(X) := lquotient(Z_(n)(X), B_(n)(X))$.
])

#remark([
  Soit $C_(cdot)(X)$ un complexe de chaînes singulières et $n in ZZ$.
  Puisque $d_n compose d_(n+1) = 0$, on a $B_(n)(X) = im(d_(n+1)) subset ker(d_n) = Z_(n)(X)$.
])

#remark([
  Soit $C_(cdot)(X)$ un complexe de chaînes singulières et $n in ZZ$.
  Si $n < 0$, alors $Z_(n)(X)$ et $B_(n)(X)$ sont triviaux, donc $H_(n)(X)$ est trivial.
])

#definition([
  Soit $C_(cdot)(X)$ un complexe de chaînes singulières et $n in ZZ$.
  - On dit que $C_(cdot)(X)$ est _exact en $C_(n)(X)$_ si $H_(n)(X)$ est trivial, c'est-à-dire, $im(d_(n+1)) = ker(d_n)$.
  - On dit que $C_(cdot)(X)$ est _exact_ s'il est exact en tout $sequence(C_(n)(X))$.
  - On dit que $C_(cdot)(X)$ est _acyclique_ s'il est exact en tout $sequence(C_(n)(X))$ avec $n != 0$.
])

#definition([
  Soit $C_(cdot)(X)$ un complexe de chaînes singulières et $n in ZZ$.
  On appelle _$n$#super("e") nombre de Betti de X_ le rang de $H_(n)(X)$ s'il est fini.
])

== Morphismes de chaînes

#definition([
  Soit $C_(cdot)(X)$ et $C_(cdot)(Y)$ deux complexes de chaînes singulières.
  On appelle _morphisme de chaînes_, noté $func(phi_cdot, C_(cdot)(X), C_(cdot)(Y))$, une suite de morphismes $sequence(func(phi_n, C_(n)(X), C_(n)(Y)))$ telle que pour tout $n in ZZ$, on a $dif_n phi_n = phi_(n-1) dif_n$.
])

#proposition([
  Soit $C_(cdot)(X)$ et $C_(cdot)(Y)$ deux complexes de chaînes singulières, $func(phi_cdot, C_(cdot)(X), C_(cdot)(Y))$ un morphisme de chaînes.
  Alors pour tout $n in ZZ$, $phi_n$ induit un morphisme de $H_(n)(X)$ dans $H_(n)(Y)$.
])

#proof([
  Soit $n in ZZ$. \
  Soit $sigma in Z_(n)(X)$. Alors on a
  $d_n phi_(n)(sigma) = phi_(n-1)(d_n sigma) = phi_(n-1)(0) = 0$,
  donc $phi_(n)(sigma) in Z_(n)(Y)$. \
  Soit $beta in B_(n)(X)$. Alors il existe $sigma in C_(n+1)(X)$ tel que $beta = d_(n+1) sigma$, et on a :
  $ phi_(n)(beta) = phi_(n)(d_(n+1) sigma) = d_(n+1) phi_(n+1)(sigma) $
  donc $phi_(n)(beta) in B_(n)(Y)$.

  On pose $func(psi_n := overline(phi_n), Z_(n)(X), H_(n)(Y))$, alors $B_(n)(X) subset ker(psi_n)$ et d'après la propriété universelle du groupe quotient le morphisme $psi_n$ induit bien un morphisme de $H_(n)(X)$ dans $H_(n)(Y)$.
])

#definition([
  Soit $C_(cdot)(X)$ et $C_(cdot)(Y)$ deux complexes de chaînes singulières, $func(phi_cdot, C_(cdot)(X), C_(cdot)(Y))$ un morphisme de chaînes.
  Pour tout $n in ZZ$, on note $func(H_(n)(phi), H_(n)(X), H_(n)(Y))$ le morphisme induit par $phi_n$.
])

#proposition([
  Soit $C_(cdot)(X)$, $C_(cdot)(Y)$ et $C_(cdot)(Z)$ trois complexes de chaînes singulières, $func(phi_cdot, C_(cdot)(X), C_(cdot)(Y))$ et $func(psi_cdot, C_(cdot)(Y), C_(cdot)(Z))$ deux morphismes de chaînes.
  Alors la composition $func(psi_cdot compose phi_cdot, C_(cdot)(X), C_(cdot)(Z))$ est un morphisme de chaînes.
])

#proof([
  Soit $n in ZZ$. Alors on a :
  $
    dif_n (psi_n compose phi_n) = psi_(n-1) dif_n phi_n = (psi_(n-1) compose phi_(n-1)) dif_n.
  $
  Donc $sequence(psi_n compose phi_n)$ est bien un morphisme de chaînes.
])

#proposition([
  Soit $C_(cdot)(X)$ et $C_(cdot)(Y)$ deux complexes de chaînes singulières, et $func(f, X, Y)$ une application continue.
  Alors l'application induite $f_*$ détermine un morphisme de chaînes.
])

#proof([
  Pour tout $n in ZZ$, on considère le morphisme défini par $phi_n := f_*$.
  Soit $n in ZZ$. Alors d'après la @prop-continue-commute on a :
  $ dif_n phi_n = dif_n f_* = f_* dif_n = phi_(n-1) dif_n. $
  Donc $sequence(phi_n)$ est bien un morphisme de chaînes.
])

#definition([
  Soit $C_(cdot)(X)$ et $C_(cdot)(Y)$ deux complexes de chaînes singulières, et $func(f, X, Y)$ une application continue.
  Pour tout $n in ZZ$, on note $func(H_(n)(f), H_(n)(X), H_(n)(Y))$ le morphisme induit par le morphisme de chaînes déterminé par $f_*$.
])

== Paires d'espaces topologiques

#definition([
  Soit $X$ un espace topologique et $A$ un sous-ensemble de $X$.
  On appelle _paire d'espaces topologiques_ le couple $(X, A)$.
])

#proposition([
  Soit $(X, A)$ une paire d'espaces topologiques.
  Alors pour tout $n in ZZ$, $d_n$ induit un morphisme $overline(d)_n$ de $lquotient(C_(n)(X), C_(n)(A))$ dans $lquotient(C_(n-1)(X), C_(n-1)(A))$ tel que $overline(d)_n compose overline(d)_(n+1) = 0$.
])

#proof([
  Soit $n in ZZ$. 
  Alors on a $C_(n)(A) subset C_(n)(X)$, on peut donc former le quotient $lquotient(C_(n)(X), C_(n)(A))$.

  On pose $func(delta_n := overline(d_n), C_(n)(X), lquotient(C_(n-1)(X), C_(n-1)(A)))$, alors $C_(n)(A) subset ker(delta_n)$ et d'après la propriété universelle du groupe quotient $delta_n$ induit bien un morphisme $overline(d)_n$ de $lquotient(C_(n)(X), C_(n)(A))$ dans $lquotient(C_(n-1)(X), C_(n-1)(A))$.
  Enfin puisque $d_n compose d_(n+1) = 0$, on a $overline(d)_n compose overline(d)_(n+1) = 0$.
])

#remark([
  Soit $(X, A)$ une paire d'espaces topologiques.
  La suite $sequence(lquotient(C_(n)(X), C_(n)(A)))$ munie des morphismes de bords induits $sequence(func(overline(d)_n, lquotient(C_(n)(X), C_(n)(A)), lquotient(C_(n-1)(X), C_(n-1)(A))))$ forme un complexe de chaînes singulières.
])

#definition([
  Soit $(X, A)$ une paire d'espaces topologiques.
  On appelle _complexe de chaînes singulières de la paire $(X, A)$_ le complexe de chaînes singulières quotient $C_(cdot)(X, A) := lquotient(C_(cdot)(X), C_(cdot)(A))$.
])

#remark([
  Dans le cas de la paire d'espaces topologiques $(X, emptyset)$, on trouve $C_(cdot)(X, emptyset) = C_(cdot)(X)$ et $H_(cdot)(X, emptyset) = H_(cdot)(X)$.
])

#definition([
  Soit $(X, A)$ et $(Y, B)$ deux paires d'espaces topologiques, et $func(f, X, Y)$ une application continue.
  On dit que $f$ est un _morphisme de paires_, noté $func(f, (X, A), (Y, B))$, si $f(A)$ est contenue dans $B$.
])

#proposition([
  Soit $C_(cdot)(X, A)$ et $C_(cdot)(Y, B)$ deux complexes de chaînes singulières, et $func(f, (X, A), (Y, B))$ un morphisme de paires.
  Alors l'application induite $func(f_*, C_(n)(X), C_(n)(Y))$ détermine un morphisme de chaînes.
])

#proof([
  Pour tout $n in ZZ$,
  on pose $func(phi_n := overline(f_*), C_(n)(X), C_(n)(Y, B))$, alors puisque $f(A) subset B$, on en déduit $f_* (C_(n)(A)) subset ker(phi_n)$ et d'après la propriété universelle du groupe quotient $phi_n$ induit un morphisme $overline(phi_n)$ de $C_(n)(X, A)$ dans $C_(n)(Y, B)$.

  Soit $n in ZZ$. Alors d'après la @prop-continue-commute puisque $d_n f_* = f_* d_n$, on a $overline(d_n phi_n) = overline(phi_(n-1) d_n)$.
  Donc $phi_n$ est bien un morphisme de chaînes.
])

#definition([
  Soit $C_(cdot)(X, A)$ et $C_(cdot)(Y, B)$ deux complexes de chaînes singulières, et $func(f, (X, A), (Y, B))$ un morphisme de paires.
  Pour tout $n in ZZ$, on note $func(H_(n)(f), H_(n)(X, A), H_(n)(Y, B))$ le morphisme induit par le morphisme de chaînes déterminé par $f_*$.
])

#theorem([
  La suite des $n$#super("e") groupe d'homologie singulière des paires d'espaces topologiques $sequence(func(H_n, sans("Top")_2, sans("Ab")))$ est un foncteur.
])

#proof([
  Soit $n in ZZ$.
  - Soit $(X, A)$ une paire d'espaces topologiques.
    Alors le $n$#super("e") groupe d'homologie singulière $H_(n)(X, A)$ est bien un groupe abélien libre.
  - Soit $(X, A)$ et $(Y, B)$ deux paires d'espaces topologiques, et $func(f, (X, A), (Y, B))$ un morphisme de paires.
    Alors l'application $func(H_(n)(f), H_(n)(X, A), H_(n)(Y, B))$ est un bien morphisme de groupes.
  Soit $(X, A), (Y, B)$ et $(Z, C)$ trois paires d'espaces topologiques.
  - Soit $func(f, (X, A), (Y, B))$ et $func(g, (Y, B), (Z, C))$ deux morphismes de paires.
    Alors la composition $func(g compose f, (X, A), (Z, C))$ est un morphisme de paires qui passe au quotient et vérifie :
    $ H_(n)(g compose f) = H_(n)(g) compose H_(n)(f). $
  - On considère $func(id_((X, A)))$. Soit $func(sigma, Delta^n, (X, A))$ un $n$-simplexe singulier, alors :
    $ id_((X, A)*)(sigma) = id_((X, A)) compose sigma = sigma $
    puisque les $n$-chaînes singulières sont engendrées par les $n$-simplexes singuliers, on en déduit que $id_((X, A)*) = id_(C_(n)(X, A))$, par passage au quotient on a :
    $ H_(n)(id_((X, A))) = id_(H_(n)(X, A)). $
  Donc $H_(n)$ est un foncteur.
])

// #definition([
//   Soit $C_(cdot)(X, A)$ un complexe de chaînes singulières.
//   On appelle _morphisme connectant_, noté $func(partial_n, H_(n)(X, A), H_(n-1)(A))$, la transformation naturelle induite par le morphisme de bord.
// ])

#theorem([
  La suite des $n$#super("e") groupe d'homologie singulière des paires d'espaces topologiques $sequence(func(H_n, sans("Top")_2, sans("Ab")))$ munie des morphismes ? (à définir) $sequence(func(partial_n, H_(n)(X, A), H_(n-1)(A)))$ est une théorie de l'homogie vérifiant les @def-theorie-homologie[axiomes d'Eilenberg-Steenrod].
])

#proof(
  of: [de @axiome-dimension[l'axiome de dimension]],
  [
    Si $n < 0$, on a clairement $H_(n)(P) tilde.eq {0}$. \
    Si $n >= 0$, il existe un unique $n$-simplexe singulier $func(sigma_n, Delta^n, P)$, alors on a :
    $
      partial_n sigma_n = cases(0 &"si" n = 0 "ou" n "est impair", sigma_(n-1) &"si" n != 0 "et" n "est pair")
    $
    dans le cas $n = 0$, alors $H_(0)(P) = lquotient(gensubgroup(sigma_0), {0}) tilde.eq ZZ $, \
    dans le cas $n != 0 $ et $n$ est impair, alors $H_(n)(P) = lquotient(gensubgroup(sigma_n), gensubgroup(sigma_n)) tilde.eq {0}$, \
    dans le cas $n != 0 $ et $n$ est pair, alors $H_(n)(P) = lquotient({0}, {0}) tilde.eq {0}$.
  ],
)


#proof(
  of: [de @axiome-exactitude[l'axiome d'exactitude]],
  [
    TODO.
  ],
)

#proof(
  of: [de @axiome-homotopie[l'axiome d'homotopie]],
  [
    TODO.
  ],
)

#proof(
  of: [de @axiome-excision[l'axiome d'excision]],
  [
    TODO.
  ],
)

#theorem(
  title: "Théorème de Mayer-Vietoris",
  [
    Soit $U$ et $V$ deux ouverts d'un espace topologique.
    En notant $func(i_U, U inter V, U)$, $func(i_V, U inter V, V)$, $func(j_U, U, U union V)$ et $func(j_V, V, U union V)$ les inclusions canoniques, alors la suite suivante est exacte :
    $
      ... -> H_(n+1)(U union V) ->^(partial_(n+1)) H_(n)(U inter V) ->^((-i_(U*), i_(V*))) directsum(H_(n)(U), H_(n)(V)) ->^(j_(U*) + j_(V*)) H_(n)(U union V) -> ...
    $
  ],
)

#proof([
  TODO.
])

#bibliography("biblio.yml")
