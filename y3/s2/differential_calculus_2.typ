#import "../../template.typ": *

#show: maths.with(title: "Calcul différentiel 2", color: "#718355")

= Inversion locale et fonctions implicites

== Théorème d'inversion locale

#definition([
  Soit $k in NN without {0} union {+oo}$, $U$ et $V$ deux ouverts de $RR^n$, et $func(f, U, V)$ une application. On dit que $f$ est un _$C^k$-difféomorphisme_ de $U$ sur $V$ si
  + $f$ est bijective de $U$ sur $V$,
  + $f$ est de classe $C^k$ sur $U$,
  + $f^(-1)$ est de classe $C^k$ sur $V$.
])

#remark([
  Soit $func(f, U, V)$ un $C^k$-difféomorphisme, alors
  $
    forall x in U, f^(-1)(f(x)) &= x \
    forall y in V, f(f^(-1)(y)) &= y
  $
  de plus en appliquant le théorème de composition des différentielles
  $
    dif f^(-1)(f(x)) compose dif f(x) &= id_(RR^n) \
    dif f(f^(-1)(x)) compose dif f^(-1)(x) &= id_(RR^n)
  $
  donc $dif f(x)$ est inversible avec $dif f(x)^(-1) = dif f^(-1)(f(x))$.
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

#theorem(
  title: "Théorème d'inversion locale",
  [
    Soit $U$ un ouvert non-vide de $RR^n$ et $func(f, U, RR^n)$ une application de classe $C^k$.
    On suppose qu'il existe $x_0 in U$ tel que $dif f(x_0)$ soit inversible.
    Alors il existe un voisinage ouvert $U'$ de $x_0$ et un voisinage ouvert $V'$ de $f(x_0)$ tels que $func(f, U', V')$ est un $C^k$-difféomorphisme.
  ],
) <thm-inversion-locale>

#theorem(
  title: "Théorème d'inversion globale",
  [
    Soit $U$ un ouvert non-vide de $RR^n$ et $func(f, U, RR^n)$ une application.
    On suppose que
    + $f$ est de classe $C^k$ sur $U$,
    + $f$ est injective sur $U$,
    + $forall x in U, dif f(x)$ est inversible.
    Alors $f(U)$ est un ouvert de $RR^n$ et $func(f, U, f(U))$ est un $C^k$-difféomorphisme.
  ],
) <thm-inversion-globale>

#proof([
  Soit $x_0$ in $U$, alors d'après le théorème d'inversion locale il existe un voisinage ouvert $U_x_0$ de $x_0$ et un voisinage ouvert $V_f(x_0)$ de $f(x_0)$ tels que $func(f, U_x_0, V_f(x_0))$ est un $C^k$-difféomorphisme.
  En particulier $V_f(x_0) = f(U_x_0)$, et on a
  $ f(U) = union.big_(x in U) V_f(x) $
  est un ouvert de $RR^n$ comme union d'ouverts. De plus puisque $f$ est injective sur $U$, on en déduit que $f$ est bijective de $U$ sur $f(U)$. \
  Soit $y_0 in f(U)$, alors il existe un unique $x_0 in U$ tel que $y_0 = f(x_0)$, et d'après le théorème d'inversion locale $func(f, U_x_0, V_y_0)$ est un $C^k$-difféomorphisme, on en déduit que $f^(-1)$ est de classe $C^k$ sur $V_y_0$. Donc $f^(-1)$ est $C^k$ sur $f(U)$.
])

#examples([
  + On considère $func(f, RR^2, RR^2, (r, theta), (f_1, f_2) = (r cos(theta), r sin(theta)))$, alors
    + $f$ est de classe $C^(oo)$ sur $RR^2$ puisque $cos$ et $sin$ sont de classe $C^(oo)$.
    + On pose $U := ]0, +oo[ times ]-pi, pi[$, qui est un ouvert de $RR^2$ sur lequel $f$ est injective.
    + Soit $(r, theta) in U$, alors
      $
        J_f (r, theta) =
        mat(
          (partial f_1)/(partial r), (partial f_1)/(partial theta);
          (partial f_2)/(partial r), (partial f_2)/(partial theta);
        ) =
        mat(
          cos(theta), -r sin(theta);
          sin(theta), r cos(theta)
        )
      $
      et $det(J_f (r, theta)) = r cos^2 (theta) + r sin^2 (theta) = r > 0$, donc $dif f_((r, theta))$ est inversible.
    Donc d'après le @thm-inversion-globale $func(f, U, f(U))$ est un $C^(oo)$-difféomorphisme.
  + On considère $func(f, RR^3, RR^3, (r, theta, phi), (f_1, f_2, f_3) = (r cos(theta) cos(phi), r sin(theta) cos(phi), r sin(phi)))$.
    + $f$ est de classe $C^(oo)$ sur $RR^3$ puisque $cos$ et $sin$ sont de classes $C^(oo)$.
    + On pose $U := ]0, +oo[ times ]-pi, pi[ times ]-pi/2, pi/2[$, qui est un ouvert de $RR^3$ sur lequel $f$ est injective.
    + Soit $(r, theta, phi) in U$, alors
      $
        J_f (r, theta, phi) = mat(
          cos(theta)cos(phi), -r sin(theta)cos(phi), -r cos(theta)sin(phi);
          sin(theta)cos(phi), r cos(theta)cos(phi), -r sin(theta) sin(phi);
          sin(phi), 0, r cos(phi)
        )
      $
      et le déterminant de cette matrice est
      $
        det(J_f (r, theta, phi)) &= &&sin(phi)(r^2 sin^2 (theta) cos(phi)sin(phi) + r^2 cos^2 (theta)cos(phi)sin(phi)) \
        & &&+ r cos(phi)(r cos^2 (theta) cos^2 (phi) + sin^2 (theta) cos^2 (phi)) \
        &= &&sin^2 (phi) r^2 cos(phi) + cos^2 (phi) r^2 cos(phi) = r^2 cos(phi) != 0
      $
      donc $dif f_(r, theta, phi)$ est inversible.
    Donc d'après le @thm-inversion-globale $func(f, U, f(U))$ est un $C^(oo)$-difféomorphisme.
  + On pose $U := R^2 without {(0, 0)}$ et on considère $func(f, U, RR^2, (x, y), (x^2 - y^2, 2x y))$, alors
    1. $f$ est de classe $C^oo$ sur $U$ puisque $f$ est polynômiale.
    3. Soit $(x, y) in U$, alors
      $ J_f (x, y) = mat(2x, -2y; 2y, 2x) $
      et $det(J_f (x, y)) = 4(x^2 + y^2) > 0$ sur $U$, donc $dif f_(x, y)$ est inversible.

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

== Théorème des fonctions implicites

#theorem(
  title: "Théorème des fonctions implicites",
  [
    Soit $U$ un ouvert de $RR^n times RR^p$, $(a, b) in U$ et $func(f = (f_1, ..., f_p), U, RR^p)$ une application de classe $C^k$.
    On suppose que $f(a, b) = 0$ et que la matrice jacobienne de $f$ par rapport à la deuxième variable en $(a, b)$ est inversible. Alors il existe un voisinage ouvert $V$ de $a$, un voisinage ouvert $W$ de $b$ avec $V times W subset U$ et une application $func(phi, V, W)$ qui est $C^oo$ avec $phi(a) = b$, tels que
    $ cases((x, y) in V times W, f(x, y) = 0) <==> cases(x in V, y = phi(x)) $
    de plus pour tout $x in V, dif phi(x) = -(dif_y f(x, phi(x)))^(-1) compose dif_x f(x, phi(x))$.
  ],
) <thm-fonctions-implicites>

#examples([
  + On considère $func(f, RR^2, RR, (x, y), x^2+y^2-1)$ et $SS^1 := {(x, y) in RR^2 | f(x, y) = 0}$. Les dérivées partielles de $f$ sont
    $
      (partial f) / (partial x) (x, y) &= 2x "et"
      (partial f) / (partial y) (x, y) &= 2y.
    $
    On remarque que pour $(x, y) in RR^2$ vérifiant
    $
      cases((x, y) in SS^1, (partial f)/(partial y) (x, y) != 0)
      &<==> cases((x, y) in SS^1, y != 0)
    $
    on a $(x, y) in SS^1 without {(1, 0), (-1, 0)}$. On peut donc appliquer le @thm-fonctions-implicites, au voisinage $V$ de $x$, $SS^1$ est le graphe d'une application $func(phi, V, RR)$.
    De plus on a
    $ forall x in V, x^2 + phi(x)^2 - 1 = 0 $
    en dérivant on trouve
    $ forall x in V, 2x + 2phi(x)phi'(x) = 0 $
    et donc $phi'(x) = -x/phi(x)$.
  + On considère $func(f, RR^3, RR, (x, y, z), x^2 + y^2 + z^2 - 1)$, $SS^2 := {(x, y, z) in RR^3 | f(x, y, z) = 0}$. Les dérivées partielles de $f$ sont
    $ forall a in {x, y, z}, (partial f) / (partial a) (x, y, z) = 2a. $
    On remarque que pour $(x, y, z) in RR^3$ vérifiant
    $
      cases((x, y, z) in SS^2, (partial f)/(partial z) (x, y, z) != 0)
      &<==> cases((x, y, z) in SS^2, z != 0) \
      &<==> cases((x, y, z) in SS^2, (x, y, z) != (a, b, 0) "où" (a, b) in SS^1)
    $
    on a $(x, y, z) in SS^2 without (SS^1 times {0})$. On peut donc appliquer le @thm-fonctions-implicites, au voisinage $V$ de $(x, y)$, $SS^2$ est le graphe d'une application $func(phi, V, RR)$. De plus on a
    $ forall (x, y) in V, x^2 + y^2 + phi(x, y)^2 - 1 = 0 $
    en dérivant par rapport à $x$ on trouve
    $
      forall (x, y) in V, 2x + 2 (partial f) / (partial x) (x, y) phi(x, y) = 0
    $
    donc $(partial f)/(partial x) (x, y) = -x/phi(x, y)$, et en dérivant par rapport à $y$ on trouve
    $
      forall (x, y) in V, 2y + 2 (partial f) / (partial y) (x, y) phi(x, y) = 0
    $
    donc $(partial f)/(partial y) (x, y) = -y/phi(x, y)$.
])

#pagebreak()

= Sous-variétés de $RR^n$

== Sous-variétés

#definition([
  Soit $X$ une partie de $RR^n$.
  On dit que $X$ est une _sous-variété de $RR^n$ de classe $C^k$ et de dimension $d in NN$_, si pour tout $x in X$ il existe un voisinage ouvert $V$ de $x$ dans $RR^n$ et un $C^k$-difféomorphisme $phi$ d'un ouvert $U$ de $RR^n$ dans $V$, tels que
  $ V sect X = phi(U sect (RR^d times {0})). $
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
      V sect SS^1 &= SS^1 without {(-1, 0)} \
      &= psi({1} times bracket.r -pi, pi bracket.l) \
      &= psi(U' sect ({1} times RR))
    $
    on prend alors $U: ]-pi, pi[ times ]0, +oo[$ et $func(phi, U, V, (theta, r), psi(r+1, theta))$, donc $SS^1$ est bien une sous-variété de $RR^2$ de classe $C^oo$ et de dimension 1.
])

#definition([
  Soit $U$ un ouvert de $RR^n$ et $func(f, U, RR^p)$ une application de classe $C^k$.
  On dit que $f$ est une _submersion_ en $x_0 in U$ si $dif_x_0 f$ est surjective.
])

#theorem([
  Soit $X$ une partie de $RR^n$.
  Alors $X$ est une sous-variété de $RR^n$ classe $C^k$ et de dimension $d in {0, ..., n}$ si et seulement si pour tout $a in X$, il existe un voisinage ouvert $V$ de $a$ dans $RR^n$ et une submersion en $a$ $func(f, V, RR^(n-d))$ de classe $C^k$ vérifiant $V sect X = f^(-1)(f(a))$.
])

#proof([
  #linebreak()
  $arrow.r.double$ : Supposons que $X$ est une sous-variété de $RR^n$ de classe $C^k$ et de dimension $d$.
  Soit $a in X$, alors il existe un voisinage ouvert $V$ de $a$ et un $C^k$-difféomorphisme $phi$ d'un ouvert $U$ de $RR^n$ dans $V$, tels que
  $ V sect X = phi(U sect (RR^d times {0})). $
  On écrit $phi^(-1) = (g_1, ..., g_d, f_1, ..., f_(n - d))$, alors
  $ V sect X = {x in V | f_1 (x) = ... = f_(n-d)(x) = 0}. $
  On pose $f := (f_1, ..., f_(n-d))$, puisque $phi$ est un difféomorphisme on en déduit que $dif_a f$ est surjective, donc $f$ est une submersion en $a$.

  $arrow.l.double$ : Supposons que les hypothèses soient vérifiées.
  Sans perte de généralité on suppose que $f(a) = 0$ et que $det("Jac"_f (a)) != 0$.
  On pose $func(psi, V, RR^n)$ définie par
  $
    psi(x_1, ..., x_n) = (x_1 - a_1, ..., x_d - a_d, f_1 (x_(d+1)), ..., f_(n-d)(x_n))
  $
  alors $det("Jac"_psi (a)) = det("Jac"_f (a)) != 0$, quitte à restreindre $V$, $psi$ est un $C^k$-difféomorphisme de $V$ sur $U := psi(V)$. En prenant $phi := psi^(-1)$, on a bien
  $ V sect X = phi(U sect (RR^d times {0})). $
])

#example([
  On considère le cercle $SS^2$ décrit par $func(f, RR^3, RR, (x, y, z), x^2 + y^2 + z^2)$.
  Alors $f$ est de classe $C^k$ sur $RR^3$ et $det("Jac"_f) != 0$ sur $SS^2$, donc $f$ est une submersion en tout point de $SS^2$. On en déduit que $SS^2$ est une sous-variété de $RR$ de classe $C^k$ et de dimension $3 - 1 = 2$.
])

== Espace tangent à une sous-variété

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
  + S'il existe un voisinage ouvert $V$ de $a$ et un $C^k$-difféomorphisme $phi$ d'un ouvert $U$ de $RR^n$ dans $V$ vérifiant $V sect X = phi(U sect (RR^d times {0}))$, alors $T_a X = dif_(phi^(-1)(a)) phi (RR^d times {0})$.
  + S'il existe un voisinage ouvert $V$ de $a$ et une submersion en $a$ $func(f, V, RR^(n-d))$ de classe $C^k$ vérifiant $V sect X = f^(-1)(f(a))$, alors $T_a X = ker(dif_a f)$.
])

#proof([
  + Supposons sans perte de généralité que $phi^(-1)(a) = 0$. \
    Soit $v in T_a X$, alors il existe $epsilon > 0$ et une courbe $func(gamma, bracket.r -epsilon\, epsilon bracket.l, V sect X)$ de classe $C^k$ vérifiant $gamma(0) = a$ et $gamma'(0) = v$.
    On pose $delta := phi^(-1)(gamma)$, alors on a $im(delta) subset U sect (RR^d times {0})$, $delta(0) = 0$ et
    $ delta'(t) = dif_(gamma(t)) phi^(-1)(gamma'(t)) $
    d'où $ delta'(0) = dif_(a) phi^(-1) (v)$ et $v = dif_(phi^(-1)(a)) phi (delta'(0))$, donc $T_a X subset dif_(phi^(-1)(a)) phi (RR^d times {0})$. \
    Réciproquement on montre de la même manière que $dif_(phi^(-1)(a)) phi (RR^d times {0}) subset T_a X$.
    Donc $T_a X = dif_(phi^(-1)(a)) phi (RR^d times {0})$, on en déduit que $T_a X$ est un espace vectoriel de dimension $d$.
  + Soit $v in T_a X$, alors il existe $epsilon > 0$ et une courbe $func(gamma, bracket.r -epsilon\, epsilon bracket.l, V sect X)$ de classe $C^k$ vérifiant $gamma(0) = a$ et $gamma'(0) = v$. Soit $t in ]-epsilon, epsilon[$, alors
    $
      gamma(t) in V sect X => (f compose gamma)(t) = f(a) => (f compose gamma)'(t) = 0
    $
    or $(f compose gamma)(t) = dif_gamma(t) f (gamma'(t))$ et $dif_a f (v) = 0$, donc $T_a X subset ker(dif _a f)$. L'égalité des dimensions entraine l'égalité des espaces.
])

#remark([
  S'il existe un voisinage ouvert $V$ de $a$ et une submersion en $a$ $func(f, V, RR^(n-d))$ de classe $C^k$ vérifiant $V sect X = f^(-1)(f(a))$, alors $T_a X = span(gradient_f_1 (a), ..., gradient_f_(n-d) (a))^perp$
])

#pagebreak()

= Extrema liés

// FIXME
#theorem(
  title: "Théorèmes des extrema liés",
  [
    Soit $X$ une sous-variété de $RR^n$ de classe $C^k$ et de dimension $d$, $U$ un ouvert de $RR^n$ et $func(f, U, RR)$ une fonction de classe $C^k$. Alors s'il existe une submersion $func(g, U, RR^(n-d))$ de classe $C^k$ et $a in RR^(n-d)$ tels que $X = g^(-1)(a)$, et si $f|_X$ admet un extremum local en $x_0 in X$, il existe des uniques $lambda_1, ..., lambda_(n-d) in RR$, appelés _multiplicateurs de Lagrange_, tels que $gradient_f (x_0) = sum_(i=1)^(n-d) lambda_i gradient_g_i (x_0)$.
  ],
)

#proof([
  // TODO
])

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

= Équations différentielles

== Résultats fondamentaux

=== Équations différentielles du premier ordre

#definition([
  Soit $U$ un ouvert de $RR times RR^n$ et $func(f, U, RR^n)$ une fonction continue.
  On appelle _équation différentielle d'ordre 1 dans $RR^n$_ une équation de la forme suivante :
  $ y' = f(t, y) $
  on dit que $t$ est la variable de temps et que $y$ est la variable d'état.
])

#definition([
  Soit $(E)$ une équation différentielle d'ordre 1.
  On appelle _solution_ de $(E)$ un couple de la forme $(I, y)$ où $I$ est un intervalle de $RR$ et $func(y, I, RR^n)$ est une fonction dérivable sur $I$ vérifiant :
  + $forall t in I, (t, y(t)) in I$,
  + $forall t in I, y'(t) = f(t, y(t))$.
])

#remark([
  Dans le cas où $I$ n'est pas ouvert, la dérivabilité s'entend comme la dérivabilité à droite ou à gauche (selon l'extrémité).
])

#examples([
  + On considère l'équation différentielle d'ordre 1 donnée par $y' = y$. Le couple $(]1, 2[, t |-> e^t)$ est une solution de cette équation.
  + L'équation donnée par $y' = y^2 + t$ est une équation différentielle d'ordre 1 sur $RR$.
  + L'équation donnée par $y' = (y + 1)/(t ln(t))$ est une équation différentielle d'ordre 1 sur $RR$. Le couple $(]0, 1[, t |-> -1 + ln(t))$ est une solution de cette équation.
])

=== Problème de Cauchy

#definition([
  Soit $(E)$ une équation différentielle et $(t_0, y_0) in RR times RR^n$.
  On appelle _problème de Cauchy_ avec donnée $(t_0, y_0)$ l'équation $(E)$ à laquelle on impose la condition $y(t_0) = y_0$. On dit que la condition $y(t_0) = y_0$ est la condition initiale (ou de Cauchy).
])

#example([
  La fonction $func(y, RR, RR, t, 2e^(-t))$ est une solution de l'équation différentielle $y' = -y$ de condition initiale $y(0) = 2$.
])

#definition([
  Soit $U$ un ouvert de $RR times RR$ et $y' = f(x, y)$ une équation différentielle d'ordre 1. Soit $M$ un point de $U$, on note $cal(D)_M$ la droite passant par $M$ et de coefficient directeur $f(M)$.
  On appelle _champ des tangentes_ l'application $M |-> cal(D)_M$ associée à l'équation $y' = f(x, y)$.
  On appelle _courbe intégrale_ une courbe $cal(C)$ de $RR times RR$ qui a pour tangente en chaque point $M$ la droite $cal(D)_M$ du champ des tangentes.
])

#remark([
  Soit $(x_0, y_0) in RR times RR$. Alors $cal(D)_((x_0, y_0))$ a pour équation $y - y_0 = f(x_0, y_0)(x - y_0)$.
])

#examples([
  + On considère l'équation différentielle $y' = 0$, ici $f equiv 0$.
    Soit $M := (x_0, y_0) in RR times RR$. Alors $cal(D)_M$ est la droite d'équation $y = y_0$ et les courbes intégrales sont les droites $cal(D)_M$.
  + On considère l'équation différentielle $y' = y$, ici $f(x, y) = y$.
    Soit $M := (x_0, y_0) in RR times RR$. Alors $cal(D)_M$ est la droite d'équation $y = y_0 + y_0 (x - x_0)$.

])
