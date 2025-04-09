#import "../../template.typ": *

#show: maths.with(title: "Calcul différentiel 2", color: "#718355")

#pagebreak()

= Calcul différentiel

== Inversion et fonctions implicites

#definition([
  Soit $k in NN without {0} union {+oo}$, $U$ et $V$ deux ouverts de $RR^n$, et $func(f, U, V)$ une application. On dit que $f$ est un _$C^k$-difféomorphisme_ de $U$ sur $V$ si :
  + $f$ est bijective de $U$ sur $V$,
  + $f$ est de classe $C^k$ sur $U$,
  + $f^(-1)$ est de classe $C^k$ sur $V$.
])

#remark([
  Soit $func(f, U, V)$ un $C^k$-difféomorphisme, $x in U$ et $y in V$. Alors
  $
    &f^(-1)(f(x)) = x \
    &f(f^(-1)(y)) = y
  $
  de plus en appliquant le théorème de composition des différentielles
  $
    &(dd(f^(-1), f(x))) compose (dd(f, x)) = id \
    &(dd(f, f^(-1)(y))) compose (dd(f^(-1), y)) = id \
  $
  donc $dd(f, x)$ est inversible avec $(dd(f, x))^(-1) = dd(f^(-1), f(x))$.
])

#examples([
  + On considère $func(f, RR^n, RR^n, x, A x)$ où $A in GL_n (RR)$, alors $f$ est $C^(oo)$ comme fonction linéaire et bijective de réciproque $y |-> A^(-1) y$. On remarque que $f^(-1)$ est $C^(oo)$ comme fonction linéaire, donc $f$ est un $C^(oo)$-difféomorphisme.
  + On considère $func(f, U, V, (x, y), (x+y, x y))$ où $U$ et $V$ sont définis par
    $
      U &= {(x, y) in RR^2 | x > y} \
      V &= {(s, t) in RR^2 | s^2 - 4t > 0}
    $
    alors $f$ est un $C^(oo)$ difféomorphisme de $U$ sur $V$, en effet
    + $f$ est bijective de $U$ sur $V$, puisque pour $(x, y) in U$ on a
      $ (x+y)^2 - 4x y = x^2 -2x y + y^2 = (x-y)^2 > 0 $
      donc $f(U) subset V$, réciproquement pour $(s, t) in V$ on cherche $(x, y) in U$ tels que
      $ cases(x + y = s, x y = t) $
      c'est-à-dire $x$ et $y$ sont racines du polynôme $X^2 - s X + t$, comme $x > y$ on a
      $ cases(x = (s + sqrt(s^2 - 4t))/2, y = (s - sqrt(s^2 - 4t))/2) $
      donc $V subset f(U)$, $f$ est bijective,
    + $f$ est de classe $C^(oo)$ sur $U$ car polynômiale,
    + $f^(-1)$ est de classe $C^(oo)$ sur $V$ car $(s, t) |-> s^2 - 4t$ et $sqrt(dot)$ sont $C^(oo)$ sur $V$.
  + On considère $func(f, RR, RR, x, x^3)$, alors $f$ est de classe $C^oo$ sur $RR$ et bijective. Mais son inverse $func(f^(-1), RR, RR, y, root(3, y))$, n'est pas dérivable en $0$ donc $f$ n'est pas un $C^(oo)$-difféomorphisme.

])

=== Théorèmes d'inversion locale et globale

#theorem(
  title: "Théorème d'inversion locale",
  [
    Soit $U$ un ouvert de $RR^n$, $func(f, U, RR^n)$ une application de classe $C^k$ et $a$ un point de $U$.
    Si $dd(f, a)$ est un isomorphisme, alors il existe un voisinage ouvert $V$ de $a$ et un voisinage ouvert $W$ de $f(a)$ tels que $func(f, V, W)$ est un $C^k$-difféomorphisme.
  ],
) <thm-inversion-locale>

#theorem(
  title: "Théorème d'inversion globale",
  [
    Soit $U$ un ouvert de $RR^n$ et $func(f, U, RR^n)$ une application de classe $C^k$.
    Si :
    + $f$ est injective sur $U$,
    + $forall x in U, dd(f, x)$ est un isomorphisme.
    Alors $f(U)$ est un ouvert de $RR^n$ et $func(f, U, f(U))$ est un $C^k$-difféomorphisme.
  ],
) <thm-inversion-globale>

#proof([
  Soit $x in U$, alors d'après le théorème d'inversion locale il existe un voisinage ouvert $V_x$ de $x$ et un voisinage ouvert $W_f(x)$ de $f(x)$ tels que $func(f, V_x, W_f(x))$ est un $C^k$-difféomorphisme.
  En particulier $W_f(x) = f(V_x)$, et on en déduit que
  $ f(U) = union.big_(x in U) W_f(x) $
  est un ouvert de $RR^n$ comme union d'ouverts. De plus puisque $f$ est injective sur $U$, on en déduit que $f$ est bijective de $U$ sur $f(U)$. Enfin puisque la régularité est une notion locale $f$ et $f^(-1)$ sont respectivement de classe $C^k$ sur $U$ et $f(U)$. Donc $func(f, U, f(U))$ est un $C^k$-difféomorphisme.
])

#examples([
  + On considère $func(f, RR^2, RR^2, (r, theta), (f_1, f_2) = (r cos(theta), r sin(theta)))$, alors
    + $f$ est de classe $C^(oo)$ sur $RR^2$ puisque $cos$ et $sin$ sont de classe $C^(oo)$.
    + On pose $U := ]0, +oo[ times ]-pi, pi[$, qui est un ouvert de $RR^2$ sur lequel $f$ est injective.
    + Soit $(r, theta) in U$, alors
      $
        Jac(f)(r, theta) =
        mat(
          pdv(f_1, r), pdv(f_1, theta);
          pdv(f_2, r), pdv(f_2, theta);
        ) =
        mat(
          cos(theta), -r sin(theta);
          sin(theta), r cos(theta)
        )
      $
      et $det(Jac(f)(r, theta)) = r cos^2 (theta) + r sin^2 (theta) = r > 0$, donc $dd(f, (r, theta))$ est inversible.
    Donc d'après le @thm-inversion-globale $func(f, U, f(U))$ est un $C^(oo)$-difféomorphisme.
  + On considère $func(f, RR^3, RR^3, (r, theta, phi), (f_1, f_2, f_3) = (r cos(theta) cos(phi), r sin(theta) cos(phi), r sin(phi)))$.
    + $f$ est de classe $C^(oo)$ sur $RR^3$ puisque $cos$ et $sin$ sont de classes $C^(oo)$.
    + On pose $U := ]0, +oo[ times ]-pi, pi[ times ]-pi/2, pi/2[$, qui est un ouvert de $RR^3$ sur lequel $f$ est injective.
    + Soit $(r, theta, phi) in U$, alors
      $
        Jac(f)(r, theta, phi) = mat(
          cos(theta)cos(phi), -r sin(theta)cos(phi), -r cos(theta)sin(phi);
          sin(theta)cos(phi), r cos(theta)cos(phi), -r sin(theta) sin(phi);
          sin(phi), 0, r cos(phi)
        )
      $
      et le déterminant de cette matrice est
      $
        det(Jac(f)(r, theta, phi)) &= &&sin(phi)(r^2 sin^2 (theta) cos(phi)sin(phi) + r^2 cos^2 (theta)cos(phi)sin(phi)) \
        & &&+ r cos(phi)(r cos^2 (theta) cos^2 (phi) + sin^2 (theta) cos^2 (phi)) \
        &= &&sin^2 (phi) r^2 cos(phi) + cos^2 (phi) r^2 cos(phi) = r^2 cos(phi) != 0
      $
      donc $dd(f, (r, theta, phi))$ est inversible.
    Donc d'après le @thm-inversion-globale $func(f, U, f(U))$ est un $C^(oo)$-difféomorphisme.
  + On pose $U := R^2 without {(0, 0)}$ et on considère $func(f, U, RR^2, (x, y), (x^2 - y^2, 2x y))$, alors
    1. $f$ est de classe $C^oo$ sur $U$ puisque $f$ est polynômiale.
    3. Soit $(x, y) in U$, alors
      $ Jac(f) (x, y) = mat(2x, -2y; 2y, 2x) $
      et $det(Jac(f) (x, y)) = 4(x^2 + y^2) > 0$ sur $U$, donc $dd(f, (x, y))$ est inversible.

    Donc d'après le @thm-inversion-locale $func(f, U, RR^2)$ est un $C^oo$-difféomorphisme local en tout point de $U$.
    Mais $f(-1, -1) = f(1, 1)$, donc $func(f, U, RR^2)$ n'est pas $C^oo$-difféomorphisme global.

    2. On pose $U' := {(x, y) in U | x > 0}$, qui est un ouvert de $RR^2$ sur lequel $f$ est injective.
      En effet si $f(x_1, y_1) = f(x_2, y_2)$, alors on pose
      $
        cases((x_1, y_1) = r_1(cos(theta_1),sin(theta_1)),
          (x_2, y_2) = r_2(cos(theta_2),sin(theta_2))) quad "où" r_1, r_2 > 0 "et" theta_1, theta_2 in ]-pi / 2, pi / 2[
      $
      et on trouve
      $
        cases(r_1^2 cos(2 theta_1) = r_2^2 cos(2 theta_2), r_1^2 sin(2 theta_1) = r_2^2 sin(2 theta_2)) => cases(r_1 = r_2, theta_1 = theta_2 mod 2pi) => cases(r_1 = r_2, theta_1 = theta_2)
      $
      donc $(x_1, y_1) = (x_2, y_2)$ et $f$ est bien injective.
    Donc d'après le @thm-inversion-globale $func(f, U', f(U'))$ est un $C^oo$-difféomorphisme.
])

=== Théorème des fonctions implicites

#theorem(
  title: "Théorème des fonctions implicites",
  [
    Soit $U$ un ouvert de $RR^p times RR^q$, $(a, b)$ un point de $U$ et $func(f = (f_1, ..., f_q), U, RR^q)$ une application de classe $C^k$.
    Si :
    + $f(a, b) = 0$,
    + la jacobienne de $f$ par rapport à la deuxième variable en $(a, b)$ est inversible.
    Alors il existe un voisinage ouvert $V$ de $a$, un voisinage ouvert $W$ de $b$, avec $V times W subset U$, et une application $func(phi, V, W)$ de classe $C^oo$ qui vérifie $b = phi(a)$, tels que :
    $ cases((x, y) in V times W, f(x, y) = 0) <==> cases(x in V, y = phi(x)). $
    De plus pour tout $x in V, dv(phi, x)(x) = -(dv(f, y)(x, phi(x)))^(-1) compose dv(f, x)(x, phi(x))$.
  ],
) <thm-fonctions-implicites>

#proof([
  On considère l'application
  $ func(g, U, RR^p times RR^q, (x, y), (x, f(x, y))). $
  Alors la matrice jacobienne de $g$ en $(a, b)$ est
  $
    Jac(g)(a, b) = mat(I_p, 0_q; dot, dv(f, y)(a, b))
  $
  et son déterminant $det(Jac(g)(a, b))$ est non nul par hypothèse. \
  Donc d'après le @thm-inversion-locale il existe un voisinage ouvert $U_1$ de $(a, b)$ et un voisinage ouvert $U_2$ de $g(a, b) = (a, f(a, b))$ tels que $func(g, U_1, U_2)$ est un $C^k$-difféomorphisme. \
  En particulier il existe $func(psi, U_2, RR^q)$ telle que pour tout $(x, y) in U_2$ on a $g^(-1)(x, y) = (x, psi(x, y))$. \
  On prend $V times W subset U_1$ et on pose $func(phi, V, W, x, psi(x, 0))$, alors l'équivalence du théorème est bien vérifiée et il suffit de dériver pour obtenir l'égalité.
])

#examples([
  + On considère $func(f, RR^2, RR, (x, y), x^2+y^2-1)$ et $SS^1 := {(x, y) in RR^2 | f(x, y) = 0}$. Les dérivées partielles de $f$ sont
    $
      pdv(f, x)(x, y) &= 2x "et"
      pdv(f, y)(x, y) &= 2y.
    $
    On remarque que pour $(x, y) in RR^2$ vérifiant
    $
      cases((x, y) in SS^1, pdv(f, y)(x, y) != 0)
      &<==> cases((x, y) in SS^1, y != 0)
    $
    on a $(x, y) in SS^1 without {(1, 0), (-1, 0)}$. On peut donc appliquer le @thm-fonctions-implicites, au voisinage $V$ de $x$, $SS^1$ est le graphe d'une application $func(phi, V, RR)$.
    De plus on a
    $ forall x in V, x^2 + phi(x)^2 - 1 = 0 $
    en dérivant on trouve
    $ forall x in V, 2x + 2phi(x)phi'(x) = 0 $
    et donc $phi'(x) = -x/phi(x)$.
  + On considère $func(f, RR^3, RR, (x, y, z), x^2 + y^2 + z^2 - 1)$, $SS^2 := {(x, y, z) in RR^3 | f(x, y, z) = 0}$. Les dérivées partielles de $f$ sont
    $ forall a in {x, y, z}, pdv(f, a) (x, y, z) = 2a. $
    On remarque que pour $(x, y, z) in RR^3$ vérifiant
    $
      cases((x, y, z) in SS^2, pdv(f, z)(x, y, z) != 0)
      &<==> cases((x, y, z) in SS^2, z != 0) \
      &<==> cases((x, y, z) in SS^2, (x, y, z) != (a, b, 0) "où" (a, b) in SS^1)
    $
    on a $(x, y, z) in SS^2 without (SS^1 times {0})$. On peut donc appliquer le @thm-fonctions-implicites, au voisinage $V$ de $(x, y)$, $SS^2$ est le graphe d'une application $func(phi, V, RR)$. De plus on a
    $ forall (x, y) in V, x^2 + y^2 + phi(x, y)^2 - 1 = 0 $
    en dérivant par rapport à $x$ on trouve
    $
      forall (x, y) in V, 2x + 2 pdv(f, x)(x, y) phi(x, y) = 0
    $
    donc $pdv(f, x)(x, y) = -x/phi(x, y)$, et en dérivant par rapport à $y$ on trouve
    $
      forall (x, y) in V, 2y + 2 pdv(f, y)(x, y) phi(x, y) = 0
    $
    donc $pdv(f, y)(x, y) = -y/phi(x, y)$.
])

#pagebreak()

== Sous-variétés de $RR^n$

=== Sous-variétés

#definition([
  Soit $X$ une partie de $RR^n$.
  On dit que $X$ est une _sous-variété de $RR^n$ de classe $C^k$ et de dimension $d in NN$_ si pour tout $x in X$, il existe un voisinage ouvert $U$ dans $RR^n$, un voisinage ouvert $V$ de $x$ et un $C^k$-difféomorphisme $func(phi, U, V)$ tels que :
  $ V inter X = phi(U inter (RR^d times {0})). $
  On appelle _codimension_ de $X$ l'entier $n - d$.
])

#remark([
  Une sous-variété de dimension 1 est une _courbe_, une sous-variété de dimension 2 est une _surface_, une sous-variété de dimension $n - 1$ (codimension 1) est une _hypersurface_
])

#examples([
  + Une courbe dans $RR^2$ est difféomorphe à un segment.
  + Un ouvert de $RR^n$ est une sous-variété de dimension $n$.
  + On considère le cercle $SS^1$, on pose $U' := ]0, +oo[ times ]-pi, pi[$, $V = RR^2 without {]-oo, 0] times {0}}$, ainsi que $func(psi, U', V, (r, theta), r (cos(theta), sin(theta)))$ qui est un difféomorphisme de classe $C^oo$. On a
    $
      V inter SS^1 &= SS^1 without {(-1, 0)} \
      &= psi({1} times bracket.r -pi, pi bracket.l) \
      &= psi(U' inter ({1} times RR))
    $
    on prend alors $U: ]-pi, pi[ times ]0, +oo[$ et $func(phi, U, V, (theta, r), psi(r+1, theta))$, donc $SS^1$ est bien une sous-variété de $RR^2$ de classe $C^oo$ et de dimension 1.
])

#definition([
  Soit $U$ un ouvert de $RR^n$, $a in U$ et $func(f, U, RR^p)$ une application de classe $C^k$.
  On dit que $f$ est une _immersion_ en $a$ si $dd(f, a)$ est injective.
])

#definition([
  Soit $U$ un ouvert de $RR^n$, $a in U$ et $func(f, U, RR^p)$ une application de classe $C^k$.
  On dit que $f$ est une _submersion_ en $a$ si $dd(f, a)$ est surjective.
])

#theorem([
  Soit $X$ une partie de $RR^n$. Alors les conditions suivantes sont équivalentes :
  + (_redressement_) $X$ est une sous-variété de $RR^n$ classe $C^k$ et de dimension $d in {0, ..., n}$.
  + (_implicite_) Pour tout $a in X$, il existe un voisinage ouvert $U$ de $a$ dans $RR^n$ et $func(f, U, RR^(n-d))$ une submersion en $a$ de classe $C^k$ tels que $U inter X = f^(-1)(f(a))$.
])

#proof([
  #linebreak()
  $(1) arrow.r.double (2)$ : Supposons que $X$ est une sous-variété de $RR^n$ de classe $C^k$ et de dimension $d$. \
  Soit $a in X$, alors il existe un voisinage ouvert $U$ dans $RR^n$, un voisinage ouvert $V$ de $a$ et un $C^k$-difféomorphisme $func(phi, U, V)$ tels que
  $ V inter X = phi(U inter (RR^d times {0})). $
  On écrit $phi^(-1) = (g_1, ..., g_d, f_1, ..., f_(n - d))$, alors
  $ V inter X = {x in V | f_1 (x) = ... = f_(n-d)(x) = 0}. $
  On pose $f := (f_1, ..., f_(n-d))$, puisque $phi$ est un difféomorphisme on en déduit que $dd(f, a)$ est surjective, donc $f$ est une submersion en $a$ de classe $C^k$.

  $(2) arrow.r.double (1)$ : Supposons que les hypothèses soient vérifiées.
  Sans perte de généralité, on suppose que $f(a) = 0$ et que $det(Jac(f)(a)) != 0$.
  On pose $func(psi, V, RR^n)$ définie par
  $
    psi(x_1, ..., x_n) = (x_1 - a_1, ..., x_d - a_d, f_1 (x_(d+1)), ..., f_(n-d)(x_n))
  $
  alors $det(Jac(psi)(a)) = det(Jac(f)(a)) != 0$, quitte à restreindre $V$, $psi$ est un $C^k$-difféomorphisme de $V$ sur $U := psi(V)$. En prenant $phi := psi^(-1)$, on a bien
  $ V inter X = phi(U inter (RR^d times {0})). $
])

#example([
  On considère le cercle $SS^2$ décrit par $func(f, RR^3, RR, (x, y, z), x^2 + y^2 + z^2)$.
  Alors $f$ est de classe $C^k$ sur $RR^3$ et $det("Jac"_f) != 0$ sur $SS^2$, donc $f$ est une submersion en tout point de $SS^2$. On en déduit que $SS^2$ est une sous-variété de $RR^3$ de classe $C^k$ et de dimension $3 - 1 = 2$.
])

=== Espace tangent à une sous-variété

#definition([
  Soit $X$ une sous-variété de $RR^n$ de classe $C^k$ et de dimension $d$, $a in X$ un point et $v$ un vecteur de $RR^n$.
  On dit que $v$ est _tangent_ à $X$ en $a$ s'il existe $epsilon > 0$ et une courbe $func(gamma, bracket.r -epsilon\, epsilon bracket.l, RR^n)$ de classe $C^k$ vérifiant :
  + $gamma(0) = a$,
  + $gamma'(0) = v$,
  + $im(gamma) subset X$.
  On appelle _espace tangent_ à $X$ en $a$, noté $T_a X$, l'ensemble des vecteurs tangents à $X$ en $a$.
])

#examples([
  Soit $X$ une sous-variété de $RR^n$ de classe $C^k$ et de dimension $d$ et $a in X$ un point.
  + Le vecteur nul est tangent à $X$ en tout point, avec $gamma: t |-> a$.
  + Pour tout vecteur $v$ tangent à $X$ en $a$, pour tout $lambda in RR, lambda v$ est tangent à $X$ en $a$.
  + Si $X$ est un ouvert de $RR^n$, alors pour tout $v in RR^n$, $v$ est tangent à $X$ en $a$.
  + Si $X$ est un point, alors le seul vecteur tangent à $X$ en $a$ est $0$.
])

#theorem([
  Soit $X$ une sous-variété de $RR^n$ classe $C^k$ et de dimension $d$ et $a in X$ un point.
  Alors l'espace tangent $T_a X$ est un espace vectoriel de dimension $d$ et on a les caractérisations :
  + S'il existe un voisinage ouvert $U$ de $RR^n$, un voisinage ouvert $V$ de $a$ et un $C^k$-difféomorphisme $func(phi, U, V)$ vérifiant $V inter X = phi(U inter (RR^d times {0}))$, alors $T_a X = dd(phi, phi^(-1)(a)) (RR^d times {0})$.
  + S'il existe un voisinage ouvert $V$ de $a$ et une submersion en $a$ $func(f, V, RR^(n-d))$ de classe $C^k$ vérifiant $V inter X = f^(-1)(f(a))$, alors $T_a X = ker(dd(f, a))$.
])

#proof([
  + Supposons sans perte de généralité que $phi^(-1)(a) = 0$.
    Soit $v in T_a X$, alors il existe $epsilon > 0$ et une courbe $func(gamma, bracket.r -epsilon\, epsilon bracket.l, V inter X)$ de classe $C^k$ vérifiant $gamma(0) = a$ et $gamma'(0) = v$.
    On pose $delta := phi^(-1)(gamma)$, alors on a $im(delta) subset U inter (RR^d times {0})$, $delta(0) = 0$ et
    $ delta'(t) = dd(phi^(-1), gamma(t))(gamma'(t)) $
    d'où $ delta'(0) = dd(phi^(-1), a)(v)$ et $v = dd(phi^(-1), a) phi (delta'(0))$, donc $T_a X subset dd(phi^(-1), a) phi (RR^d times {0})$. \
    Réciproquement, on montre de la même manière que $dd(phi^(-1), a) phi (RR^d times {0}) subset T_a X$. \
    Donc $T_a X = dd(phi^(-1), a) phi (RR^d times {0})$, on en déduit que $T_a X$ est un espace vectoriel de dimension $d$.
  + Soit $v in T_a X$, alors il existe $epsilon > 0$ et une courbe $func(gamma, bracket.r -epsilon\, epsilon bracket.l, V inter X)$ de classe $C^k$ vérifiant $gamma(0) = a$ et $gamma'(0) = v$. Soit $t in ]-epsilon, epsilon[$, alors
    $
      gamma(t) in V inter X => (f compose gamma)(t) = f(a) => (f compose gamma)'(t) = 0
    $
    or $(f compose gamma)(t) = dd(f, gamma(t))(gamma'(t))$ et $dd(f, a)(v) = 0$, donc $T_a X subset ker(dd(f, a))$. L'égalité des dimensions entraine l'égalité des espaces.
])

#remark([
  S'il existe un voisinage ouvert $V$ de $a$ et une submersion en $a$ $func(f, V, RR^(n-d))$ de classe $C^k$ vérifiant $V inter X = f^(-1)(f(a))$, alors $T_a X = span(gradient_f_1 (a), ..., gradient_f_(n-d) (a))^perp$.
])

=== Extrema liés

#theorem(
  title: "Théorèmes des extrema liés",
  [
    Soit $X$ une sous-variété de $RR^n$ de classe $C^k$ et de dimension $d$, $a in X$ un point, $U$ un ouvert de $RR^n$ et $func(f, U, RR)$ une fonction de classe $C^k$. \
    Si $f$ restreinte à $X$ admet un extremum local en $a$ et s'il existe une submersion $func(g, U, RR^(n-d))$ de classe $C^k$ telle que, en notant $g = (g_1, ..., g_(n-d))$, on ait
    $ X = {x in U | g_(1)(x) = ... = g_(n-d)(x) = 0}. $
    Alors il existe des uniques $lambda_1, ..., lambda_(n-d) in RR$ tels que
    $
      gradient_f (a) = lambda_1 gradient_g_1 (a) + dots.c + lambda_(n-d) gradient_g_(n-d) (a).
    $
    Ces réels sont appellés les _multiplicateurs de Lagrange_.
  ],
)

#example([
  On cherche les extrema de la fonction $func(f, RR^2, RR, (x, y), x+y)$, que l'on restreint à l'ensemble $M := {(x, y) in RR^2 | x^4 + y^4 = 1}$. \
  On remarque que $M$ est une sous-variété de $RR^2$ de classe $C^oo$, en effet $func(f, RR^2, RR, (x, y), x^4 + y^4)$ est une submersion en tout point de $M$. Si $f|_M$ admet un extremum local en un point $(a, b) in M$, alors il existe $lambda in RR$ tel que $gradient(f)(a, b) = lambda gradient(g)(a, b)$. On a donc le système suivant
  $ cases(1 = lambda 4a^3, 1 = lambda 4b^3) $
  et on en déduit que $lambda != 0$ et $a^3 = b^3 = 1/(4 lambda)$, d'où $a = b$. \
  Comme $(a, b) in M$ on a $a^4 + b^4 = 1$, d'où $2a^4 = 1$, donc $a = b = plus.minus 1/(root(4, 2))$. On a deux extrema possibles
  $
    m_1 := (1 / root(4, 2), 1 / root(4, 2)) "et" m_2 := (-1 / root(4, 2), -1 / root(4, 2))
  $
  comme $f$ est continue et $M$ est compact (comme fermé borné de $RR^2$), $f$ admet au moins un minimum global et un maximum global, elle en a donc exactement deux : $m_1$ et $m_2$. \
  On a $f(m_1) = -f(m_2) = 2/root(4, 2) $, donc $f$ atteint son minimum en $m_2$ et son maximum en $m_1$.
])

#pagebreak()

= Équations différentielles

== Équations différentielles du premier ordre

#definition([
  Soit $U$ un ouvert de $RR times RR^n$ et $func(f, U, RR^n)$ une fonction continue.
  On appelle _équation différentielle d'ordre 1 dans $RR^n$_, notée $(E)$, une équation de la forme suivante :
  $ y' = f(t, y) $
  on dit que $t$ est la _variable de temps_ et que $y$ est la _variable d'état_.
])

#definition([
  Soit $(E)$ une équation différentielle d'ordre 1.
  On appelle _solution_ de $(E)$ sur un intervalle $I$ de $RR$ une fonction $func(y, I, RR^n)$ dérivable vérifiant :
  + $forall t in I, (t, y(t)) in U$,
  + $forall t in I, y'(t) = f(t, y(t))$.
])

#remark([
  Dans le cas où $I$ n'est pas ouvert, la dérivabilité s'entend comme la dérivabilité à droite ou à gauche (selon l'extrémité).
])

#examples([
  + On considère l'équation différentielle d'ordre 1 donnée par $y' = y$. La fonction $t |-> e^t$ est une solution de cette équation sur $]1, 2[$.
  + L'équation donnée par $y' = y^2 + t$ est une équation différentielle d'ordre 1 sur $RR$.
  + L'équation donnée par $y' = (y + 1)/(t ln(t))$ est une équation différentielle d'ordre 1 sur $RR$. La fonction $t |-> -1 + ln(t)$ est une solution de cette équation sur $]0, 1[$.
])

#definition([
  Soit $(E)$ une équation différentielle d'ordre 1 et $(t_0, y_0) in RR times RR^n$.
  On appelle _problème de Cauchy_ avec donnée $(t_0, y_0)$ le système composé des équations $(E)$ et $y(t_0) = y_0$. On dit que l'équation $y(t_0) = y_0$ est la _condition initiale_ (ou de Cauchy).
])

#example([
  La fonction $func(y, RR, RR, t, 2e^(-t))$ est une solution de l'équation différentielle $y' = -y$ de condition initiale $y(0) = 2$.
])

#definition([
  Soit $(E)$ une équation différentielle d'ordre 1. Soit $M$ un point de $U$, on note $cal(D)_M$ la droite passant par $M$ et de coefficient directeur $f(M)$.
  On appelle _champ des tangentes_ l'application $M |-> cal(D)_M$ associée à $(E)$.
  On appelle _courbe intégrale_ une courbe $cal(C)$ de $RR times RR$ qui a pour tangente en chaque point $M$ la droite $cal(D)_M$ du champ des tangentes.
])

#remark([
  Soit $(x_0, y_0) in RR times RR$. Alors $cal(D)_((x_0, y_0))$ a pour équation $y - y_0 = f(x_0, y_0)(x - x_0)$.
])

#examples([
  + On considère l'équation différentielle $y' = 0$, ici $f equiv 0$.
    Soit $M := (x_0, y_0) in RR times RR$. Alors $cal(D)_M$ est la droite d'équation $y = y_0$ et les courbes intégrales sont les droites $cal(D)_M$.
  + On considère l'équation différentielle $y' = y$, ici $f(x, y) = y$.
    Soit $M := (x_0, y_0) in RR times RR$. Alors $cal(D)_M$ est la droite d'équation $y = y_0 + y_0 (x - x_0)$.

])

#proposition([
  Soit $(E)$ une équation différentielle d'ordre 1 et $func(y, I, RR^n)$ une solution de $(E)$.
  Alors le graphe de $y$ est une courbe intégrale.
])

#proof([
  Soit $M = (x_0, y_0)$ un point du graphe de $y$.
  L'équation de la tangente au graphe en $M$ est donnée par :
  $ y - y_0 = y'(x_0)(x - x_0) = f(x_0, y_0)(x - x_0) $
  on reconnait l'équation de $cal(D)_M$.
])

#definition([
  Soit $(E)$ une équation différentielle d'ordre 1 et $m in RR$.
  On appelle _isocline de pente $m$ associée à $(E)$_, l'ensemble :
  $ Gamma_m := {(x, y) in U | f(x, y) = m}. $
])

=== Solutions maximales et solutions globales

#definition([
  Soit $(E)$ une équation différentielle d'ordre 1, et $func(y_1, I_1, RR^n)$ et $func(y_2, I_2, RR^n)$ deux solutions de $(E)$.
  On dit que $y_2$ est un _prolongement de $y_1$_ si $I_1 subset I_2$ et $y_2|_I_1 = y_1$.
])

#definition([
  Soit $(E)$ une équation différentielle d'ordre 1 et $func(y, I, RR^n)$ une solution de $(E)$.
  On dit que $y$ est _maximale_ si elle n'admet pas de prolongement.
])

#example([
  On considère l'équation différentielle d'ordre 1 donnée par $y' = y^2$.
  Alors une solution maximale est $t |-> 1/(1-t)$ sur $]-oo, 1[$.
])

#theorem([
  Soit $(E)$ une équation différentielle d'ordre 1 et $func(y, I, RR^n)$ une solution de $(E)$.
  Alors $y$ admet un prolongement maximal.
])


#definition([
  Soit $(E)$ une équation différentielle d'ordre 1 et $func(y, I, RR^n)$ une solution de $(E)$.
  On suppose que $U$ s'écrit $U = J times K$ où $J$ est un ouvert de $RR$ et $K$ un ouvert de $RR^n$.
  Alors on dit que $y$ est _globale_ si $I = J$.
])

#proposition([
  Soit $(E)$ une équation différentielle d'ordre 1 et $func(y, I, RR^n)$ une solution de $(E)$.
  Si $y$ est une solution globale, alors $y$ est une solution maximale.
])

#proposition([
  Soit $(E)$ une équation différentielle d'ordre 1 et $func(y, I, RR^n)$ une solution de $(E)$.
  Si $f$ est de classe $C^k$, alors $y$ est de classe $C^(k+1)$.
])

=== Équations intégrales et cylindre de sécurité

#lemma([
  Soit $(E)$ une équation différentielle d'ordre 1 et $func(y, I, RR^n)$ une fonction.
  Alors $y$ est une solution du problème de Cauchy de condition initiale $(t_0, y_0)$ si et seulement si :
  + $y$ est continue et $forall t in I, (t, y(t)) in U$,
  + $forall t in I, y(t) = y_0 + rintegral(f(x, y(x)), t_0, t, x)$.
])

#definition([
  Soit $(E)$ une équation différentielle d'ordre 1, $(t_0, y_0)$ un point de $U$ et $C = [t_0 - T, t_0 + T] times B(y_0, r)$ un cylindre dans $U$.
  On dit que $C$ est un _cylindre de sécurité_ si toute solution $func(y, I, RR^n)$ du problème de Cauchy de condition initiale $(t_0, y_0)$ avec $I subset [t_0 - T, t_0 + T]$ reste contenue dans $overline(B)(y_0, r)$.
])

#proposition([
  Soit $(E)$ une équation différentielle d'ordre 1 et $(t_0, y_0)$ un point de $U$.
  Alors il existe $T > 0$ tel que $C = [t_0 - T, t_0 + T] times B(y_0, r)$ soit un cylindre de sécurité.
])

=== Théorème de Cauchy-Péano-Arzéla

#theorem([
  Soit $(E)$ une équation différentielle d'ordre 1, $(t_0, y_0)$ un point de $U$ et $C = [t_0 - T, t_0 + T] times B(y_0, r)$ un cylindre de sécurité. // avec T <= min(T_0, r_0/M)
  Alors il existe une solution $func(y, I, RR^n)$ du problème de Cauchy de condition initiale $(t_0, y_0)$telle que $y(I) subset B(y_0, r)$
])

#corollary([
  Soit $(E)$ une équation différentielle d'ordre 1 et $(t_0, y_0)$ un point de $U$.
  Alors il existe une solution maximale $func(y, I, RR^n)$ du problème de Cauchy de condition initiale $(t_0, y_0)$ définie sur un ouvert $I$.
])

=== Théorème de Cauchy-Lipschitz

#definition([
  Soit $(E)$ une équation différentielle d'ordre 1.
  On dit que $f$ est _localement lipschitzienne_ par rapport à la deuxième variable si pour tout point $(t_0, y_0)$ dans $U$, il existe un cylindre $C = [t_0 - T, t_0 + T] times B(y_0, r)$ dans $U$ et une constante $k >= 0$ tels que $f$ soit $k$-lipschitzienne par rapport à la deuxième variable sur $C$ :
  $
    forall (t, y_1), (t_, y_2) in C, norm(f(t, y_1) - f(t, y_2)) <= k abs(y_1 - y_2).
  $
])

#remark([
  On considère $f = (f_1, ..., f_n)$.
  Si $f$ admet des dérivées partielles par rapport à la deuxième variable continues sur $U$.
  Alors en appliquant le théorème des accroissements finis on obtient que $f$ est localement lipschitzienne par rapport à la deuxième variable.
  Cela est vrai en particulier si $f$ est $C^1$.
])

#lemma([
  Soit $(E)$ une équation différentielle d'ordre 1, $(t_0, y_0)$ un point de $U$ et $C_0 = [t_0 - T_0, t_0 + T_0] times B(y_0, r_0)$ un cylindre sur lequel $f$ est $k$-lipschitzienne par rapport à la deuxième variable.
  Posons $M := sup_C_0 norm(f)$, $T := min(T_0, r_0 / M)$ et $C := [t_0 - T, t_0 + T] times B(y_0, r_0)$.
  Alors pour tout couple $func(y_1, I_1, RR^n), func(y_2, I_2, RR^n)$ de solutions du problème de Cauchy de condition initiale $(t_0, y_0)$, on a
  $ forall t in [t_0 - T, t_0 + T], y_1 (t) = y_2 (t). $
])

#theorem(
  title: "Théorème de Cauchy-Lipschitz",
  [
    Soit $(E)$ une équation différentielle d'ordre 1 et $(t_0, y_0)$ un point de $U$.
    Si $f$ est localement lipschitzienne par rapport à la deuxième variable, alors pour tout cylindre de sécurité $C = [t_0 - T, t_0 + T] times B(y_0, r)$, le problème de Cauchy de condition initiale $(t_0, y_0)$ admet une unique solution sur $[t_0 - T, t_0 + T]$.
  ],
) <thm-cauchy-lipschitz>

#theorem([
  Soit $(E)$ une équation différentielle d'ordre 1, $func(y_1, I_1, RR^n)$ et $func(y_2, I_2, RR^n)$ deux solutions de $(E)$.
  Si $f$ est localement lipschitzienne par rapport à la deuxième variable et s'il existe $t_0 in I$ tel que $y_1 (t_0) = y_2 (t_0)$, alors $y_1 = y_2$.
])

#corollary([
  Soit $(E)$ une équation différentielle d'ordre 1 et $(t_0, y_0)$ un point de $U$.
  Si $f$ est localement lipschitzienne par rapport à la deuxième variable, alors il existe une unique solution maximale du problème de Cauchy de condition initiale $(t_0, y_0)$.
])

=== Théorème des bouts

#theorem([
  Soit $(E)$ une équation différentielle d'ordre 1 et $func(y, \]c\, d\[, RR^n)$ une solution maximale de $(E)$.
  Si $f$ est localement lipschitzienne par rapport à la deuxième variable, alors pour tout compact $K subset U$, il existe un voisinage $V subset ]c, d[$ de $d$ tel que :
  $ forall t in V, (t, y(t)) in.not K $
  et un voisinage $W subset ]c, d[$ de $c$ tel que :
  $ forall t in W, (t, y(t)) in.not K. $
]) <thm-sortie-compact>

#corollary(
  title: "Théorème des bouts",
  [
    Soit $(E)$ une équation différentielle d'ordre 1 sur $U := ]a, b[ times RR^n$ et $func(y, \]c\, d\[, RR^n)$ une solution maximale de $(E)$.
    Si $c > a$, alors on a :
    $ lim_(t -> c^+) norm(y(t)) = +oo $
    et si $d < b$, alors on a :
    $ lim_(t -> d^-) norm(y(t)) = +oo. $
    En particulier si $y$ est bornée, alors $a = c$ et $d = b$.
  ],
) <thm-bouts>

#proposition([
  Soit $(E)$ une équation différentielle d'ordre 1 sur $U := ]a, b[ times RR^n$ et $func(y, \]c\, d\[, RR^n)$ une solution maximale de $(E)$.
  Si $f$ est bornée, alors $y$ est une solution globale.
])

== Équations différentielles linéaires du premier ordre

#definition([
  Soit $I$ un intervalle de $RR$, $func(A, I, M_n (RR))$ et $func(A, I, M_n (RR))$ deux fonctions continues.
  On appelle _équation différentielle linéaire d'ordre 1_, notée $(L)$, une équation différentielle d'ordre 1 de la forme suivante :
  $ y' = A(t)y + B(t). $
])

#theorem([
  Soit $(L)$ une équation différentielle linéaire d'ordre 1 et $(t_0, y_0)$ un point de $I times RR^n$.
  Alors il existe une unique solution maximale du problème de Cauchy de condition initiale $(t_0, y_0)$, de plus cette solution est globale.
])

#definition([
  Soit $(L)$ une équation différentielle linéaire d'ordre 1.
  On dit que $(L)$ est _homogène_ si $B = 0$.
])

#proposition([
  Soit $(L)$ une équation différentielle linéaire d'ordre 1 homogène.
  Alors l'ensemble des solutions maximales de l'équation est un $RR$-espace vectoriel de dimension $n$.
])

#corollary([
  Soit $(L)$ une équation différentielle linéaire d'ordre 1 et $func(y_0, I, RR^n)$ une solution globale de $(L)$.
  On note $S$ l'ensemble des solutions maximales de l'équation homogène associée à $(L)$.
  Alors l'ensemble des solutions de $(L)$ est $y_0 + S$.
])

== Équations différentielles d'ordre supérieur

#definition([
  Soit $U$ un ouvert de $RR times (RR^n)^p$ et $func(f, U, RR^n)$ une fonction continue.
  On appelle _équation différentielle d'ordre $p$_, notée $(E_p)$, une équation de la forme suivante :
  $ y^((p)) = f(t, y, y', ..., y^((p-1))). $
])

#definition([
  Soit $(E_p)$ une équation différentielle d'ordre $p$.
  On appelle _solution_ de $(E_p)$ sur un intervalle $I$ de $RR$ une fonction $func(y, I, RR^n)$ $p$-fois dérivable vérifiant :
  + $forall t in I, (t, y(t), y'(t), ..., y^((p-1))(t)) in U$,
  + $forall t in I, y^((p)) = f(t, y(t), y'(t), ..., y^((p-1))(t))$.
])

#proposition([
  Soit $(E_p)$ une équation différentielle d'ordre $p$ et $func(y, I, RR^n)$ une solution de $(E_p)$.
  Si $f$ est de classe $C^k$, alors $y$ est de classe $C^(k + p)$.
])

#proposition([
  Soit $(E_p)$ une équation différentielle d'ordre $p$ et $func(y, I, RR^n)$ une fonction.
  Posons :
  $ Y := vec(Y_0, Y_1, ..., Y_(p-1)) = vec(y, y', ..., y^((p-1))) $
  Alors $y$ est une solution de $(E_p)$ si et seulement $Y$ est une solution de $(E)$ l'équation différentielle d'ordre 1 donnée par :
  $ Y' = vec(Y_1, ..., Y_(p-1), f(t, Y)) $
])

#theorem([
  Soit $(E_p)$ une équation différentielle d'ordre $p$ et $(t_0, y_0, ..., y_(p-1))$ un point de $U$.
  Alors il existe une solution maximale $func(y, I, RR^n)$ du problème de Cauchy de condition initiale $(t_0, y_0, ..., y_(p-1))$ définie sur un ouvert $I$.
])

#theorem([
  Soit $(E_p)$ une équation différentielle d'ordre $p$ et $(t_0, y_0, ..., y_(p-1))$ un point de $U$.
  Si $f$ est localement lipschitzienne par rapport à la deuxième variable, alors il existe une unique solution maximale $func(y, I, RR^n)$ du problème de Cauchy de condition initiale $(t_0, y_0, ..., y_(p-1))$ définie sur un ouvert $I$.

])

== Solutions d'équations différentielles linéaires à coefficients constants

#definition([
  Soit $(L)$ une équation différentielle linéaire d'ordre 1.
  On dit que $(L)$ est à _coefficients constants_ si $A in M_n (RR)$.
])

=== Solutions exponentielles d'équations homogènes

#proposition([
  Soit $(L)$ une équation différentielle linéaire d'ordre 1 homogène à coefficients constants.
  Alors la fonction $func(y, I, RR^n, t, e^(lambda t) v)$ est solution de $(L)$ si et seulement si $lambda$ est une valeur propre de $A$ et $v$ est un vecteur propre de $A$ associé à $lambda$.
])

==== Cas diagonalisable

#proposition([
  Soit $(L)$ une équation différentielle linéaire d'ordre 1 homogène à coefficients constants.
  Si $A$ est diagonalisable, il existe une base $(v_1, ..., v_n)$ de $RR^n$ de vecteurs propres de $A$ associées aux valeurs propres $(lambda_1, ..., lambda_n)$ de $A$.
  Alors pour tout $i in {1, ..., n}$, la fonction #box($func(y_i, I, RR^n, t, e^(lambda_i t) v_i)$) est une solution de $(L)$, de plus ces solutions sont indépendantes.
])

#corollary([
  Soit $(L)$ une équation différentielle linéaire d'ordre 1 homogène à coefficients constants.
  Si $A$ est diagonalisable, il existe une base $(v_1, ..., v_n)$ de $RR^n$ de vecteurs propres de $A$ associées aux valeurs propres $(lambda_1, ..., lambda_n)$ de $A$.
  Alors la solution générale de $(L)$ est donnée par :
  $ func(y, I, RR^n, t, c_1 e^(lambda_1 t)) v_1 + ... + c_n e^(lambda_n t) v_n $
  où $c_1, ..., c_n in RR$.
])

==== Cas général

#theorem([
  Soit $(L)$ une équation différentielle linéaire d'ordre 1 homogène à coefficients constants.
  Alors la solution générale de $(L)$ est donnée par :
  $ func(y, I, RR^n, t, e^(t A) v) $
  où $v in RR^n$.
])


#theorem([
  Soit $(L)$ une équation différentielle linéaire d'ordre 1 homogène à coefficients constants et $(t_0, v_0)$ un point de $U$.
  Alors la solution du problème de Cauchy de condition initiale $(t_0, v_0)$ est donnée par :
  $ func(y, I, RR^n, t, e^((t - t_0)A) v_0) $
])

=== Solutions exponentielles

#theorem([
  Soit $(L)$ une équation différentielle linéaire d'ordre 1 à coefficients constants.
  Alors la solution générale de $(L)$ est donnée par :
  $ func(y, I, RR^n, t, e^(t A) v + T(t)) $
  où $v in RR^n$ et $func(T, I, RR^n)$ est une solution particulière de $(L)$.
])

#remark([
  Soit $(L)$ une équation différentielle linéaire d'ordre 1 à coefficients constants.
  Pour trouver une solution particulière, on applique la méthode de _variation de la constante_.\
  Pour tout $t in I$, on pose :
  $ T(t) = e^(t A) v(t) $
  et on dérive pour obtenir :
  $ T'(t) = e^(t A) A v(t) + e^(t A) v'(t) = A T(t) + e^(t A) v'(t) $
  on cherche donc $e^(t A) v'(t) = B(t)$, c'est-à-dire $v'(t) = e^(-t A) B(t)$, et on intègre pour trouver :
  $ v(t) = rintegral(e^(-x A) B(x), t_0, t, x) $
  donc :
  $ T(t) = e^(t A) rintegral(e^(-x A) B(x), t_0, t, x) $
  est une solution particulière de $(L)$, qui vérifie le problème de Cauchy $T(t_0) = 0$.
])

#examples([
  + On considère le système différentiel linéaire à coefficients constants $(S)$ donné par :
    $ cases(x'=x+2y, y'=2x+y) $
    On écrit le système sous la forme $Y' = A Y$, où :
    $ Y := vec(x, y) quad "et" quad A := mat(1, 2; 2, 1) $
    La matrice $A$ est diagonalisable car symétrique, avec comme polynôme caractéristique :
    $ chi_A = (X+1)(X-3) $
    donc ses valeurs propres sont $-1$ et $3$. Et ses espaces propres sont donnés par :
    $ E_(-1) = span(vec(1, -1)) quad "et" quad E_3 = span(vec(1, 1)) $
    Les solutions de $(S)$ sont donc de la forme :
    $ Y(t) = a e^(-t) vec(1, -1) + b e^(3t) vec(1, 1) $
    c'est-à-dire :
    $ cases(x = a e^(-t) + b e^(3t), y = -a e^(-t) + b e^(3t)) $
    où $a, b in RR$.
  + On considère le système différentiel linéaire à coefficients constants $(S)$ donné par :
    $ cases(x'=2x+y, y'=2y) $
    On écrit le système sous la forme $Y' = A Y$, où :
    $ Y := vec(x, y) quad "et" quad A := mat(2, 1; 0, 2) $
    La matrice $A$ n'est pas diagonalisable. On écrit $A = 2I_2 + R$, où :
    $ R:= mat(0, 1; 0, 0) $
    en passant à l'exponentielle on trouve :
    $ e^(t A) = e^(2t) e^(t R) $
    mais $R^2 = 0$, d'où $e^(t R) = I_2 + t R$, et on obtient :
    $ e^(t A) = mat(e^(2t), t e^(2t); 0, e^(2t)) $
    Les solutions de $(S)$ sont donc de la forme :
    $ Y(t) = e^(t A) vec(a, b) = vec(a e^(2t) + b t e^(2t), b e^(2t)) $
    c'est-à-dire :
    $ cases(x = a e^(2t) + b t e^(2t), y = b e^(2t)) $
    où $a, b in RR$.
  + On considère le système différentiel linéaire à coefficients constants $(S)$ donné par :
    $ cases(x'=6x+3y-3t+4e^(3t), y'=-4x-y+4t-4e^(3t)) $
    On écrit le système sous la forme $Y' = A Y + B(t)$, où :
    $
      Y := vec(x, y), quad A := mat(6, 3; -4, -1) quad "et" quad B(t) = vec(-3t + 4e^(3t), 4t - 4e^(3t))
    $
    On trouve que les solutions du système homogène associé à $(S)$ sont de la forme :
    $ Y(t) = a e^(3t) vec(1, -1) + b e^(2t) vec(3, -4) $
    c'est-à-dire :
    $ cases(x = a e^(3t) + 3b e^(2t), y = -a e^(3t) - 4b e^(2t)) $
    où $a, b in RR$. On cherche une solution particulière de $(S)$ en appliquant la méthode de variation de la constante :
    $
      cases(
        x = alpha(t) e^(3t) + 3beta(t) e^(2t),
        y = -alpha(t) e^(3t) - 4beta(t) e^(2t))
    $
    et on dérive pour obtenir :
    $
      cases(
        x' = 3 alpha(t) e^(3t) + alpha'(t) e^(3t) + 6beta(t) e^(2t) + 3beta'(t) e^(2t),
        y' = -3 alpha(t) e^(3t) - alpha'(t) e^(3t) - 8beta(t) e^(2t) - 4beta'(t) e^(2t),
      )
    $
    on cherche donc :
    $
      cases(
        alpha'(t) e^(3t) + 3beta'(t) e^(2t) = -3t + 4e^(3t),
        -alpha'(t) e^(3t) - 4beta'(t) e^(2t) = 4t - 4e^(3t)
      )
    $
    on voit que $alpha'(t) = 4$ et $beta'(t) = -t e^(-2t)$ conviennent, et on intègre pour obtenir $alpha(t) = 4t$ et :
    $
      beta(t) = rintegral(-x e^(-2x), -1/2, t, x) = [(1 / 2 x + 1 / 4)e^(-2x)]_(-1 / 2)^t = (1 / 2 t + 1 / 4) e^(-2t)
    $
    Les solutions de $(S)$ sont donc de la forme :
    $
      cases(
        x = a e^(3t) + 3b e^(2t) + 4t e^(3t) + 3/2 t + 3/4,
        y = -a e^(3t) - 4b e^(2t) - 4t e^(3t) -2t - 1
      )
    $
    où $a, b in RR$.
])
