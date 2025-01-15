#import "../../template.typ": *

#show: maths.with(title: "Calcul différentiel 2", color: "#718355")

= Inversion locale et fonctions implicites

== Théorème d'inversion locale

#definition([
  Soit $k in NN without {0} union {+oo}$, $U$ et $V$ deux ouverts de $RR^n$, et $fun(f, U, V)$ une application. On dit que $f$ est un _$C^k$-difféomorphisme_ de $U$ sur $V$ si
  + $f$ est bijective de $U$ sur $V$,
  + $f$ est de classe $C^k$ sur $U$,
  + $f^(-1)$ est de classe $C^k$ sur $V$.
])

#remark([
  Soit $fun(f, U, V)$ un $C^k$-difféomorphisme, alors
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
  + On considère $fun(f, RR^n, RR^n, x: x, fx: A x)$ où $A in GL_n (RR)$, alors $f$ est $C^(oo)$ comme fonction linéaire et bijective de réciproque $y |-> A^(-1) y$. On remarque que $f^(-1)$ est $C^(oo)$ comme fonction linéaire, donc $f$ est un $C^(oo)$-difféomorphisme.
  + On considère $fun(f, U, V, x:(x, y), fx:(x+y, x y))$ où $U$ et $V$ sont définis par
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
  + On considère $fun(f, RR, RR, x: x, fx: x^3)$, alors $f$ est de classe $C^oo$ sur $RR$ et bijective. Mais son inverse $fun(f^(-1), RR, RR, x: y, fx: root(3, y))$, n'est pas dérivable en $0$ donc $f$ n'est pas un $C^(oo)$-difféomorphisme.
])

#theorem(
  title: "Théorème d'inversion locale",
  [
    Soit $U$ un ouvert non-vide de $RR^n$ et $fun(f, U, RR^n)$ une application de classe $C^k$.
    On suppose qu'il existe $x_0 in U$ tel que $dif f(x_0)$ soit inversible.
    Alors il existe un voisinage ouvert $U'$ de $x_0$ et un voisinage ouvert $V'$ de $f(x_0)$ tels que $fun(f, U', V')$ est un $C^k$-difféomorphisme.
  ],
) <thm-inversion-locale>

#theorem(
  title: "Théorème d'inversion globale",
  [
    Soit $U$ un ouvert non-vide de $RR^n$ et $fun(f, U, RR^n)$ une application.
    On suppose que
    + $f$ est de classe $C^k$ sur $U$,
    + $f$ est injective sur $U$,
    + $forall x in U, dif f(x)$ est inversible.
    Alors $f(U)$ est un ouvert de $RR^n$ et $fun(f, U, f(U))$ est un $C^k$-difféomorphisme.
  ],
) <thm-inversion-globale>

#proof([
  Soit $x_0$ in $U$, alors d'après le théorème d'inversion locale il existe un voisinage ouvert $U_x_0$ de $x_0$ et un voisinage ouvert $V_f(x_0)$ de $f(x_0)$ tels que $fun(f, U_x_0, V_f(x_0))$ est un $C^k$-difféomorphisme.
  En particulier $V_f(x_0) = f(U_x_0)$, et on a
  $ f(U) = union.big_(x in U) V_f(x) $
  est un ouvert de $RR^n$ comme union d'ouverts. De plus puisque $f$ est injective sur $U$, on en déduit que $f$ est bijective de $U$ sur $f(U)$. \
  Soit $y_0 in f(U)$, alors il existe un unique $x_0 in U$ tel que $y_0 = f(x_0)$, et d'après le théorème d'inversion locale $fun(f, U_x_0, V_y_0)$ est un $C^k$-difféomorphisme, on en déduit que $f^(-1)$ est de classe $C^k$ sur $V_y_0$. Donc $f^(-1)$ est $C^k$ sur $f(U)$.
])

#examples([
  + On considère $fun(f, RR^2, RR^2, x: (r, theta), fx: (f_1, f_2) = (r cos(theta), r sin(theta)))$, alors
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
    Donc d'après le @thm-inversion-globale $fun(f, U, f(U))$ est un $C^(oo)$-difféomorphisme.
  + On considère $fun(f, RR^3, RR^3, x: (r, theta, phi), fx:(f_1, f_2, f_3) = (r cos(theta) cos(phi), r sin(theta) cos(phi), r sin(phi)))$.
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
    Donc d'après le @thm-inversion-globale $fun(f, U, f(U))$ est un $C^(oo)$-difféomorphisme.
  + On pose $U := R^2 without {(0, 0)}$ et on considère $fun(f, U, RR^2, x:(x, y), fx:(x^2 - y^2, 2x y))$, alors
    1. $f$ est de classe $C^oo$ sur $U$ puisque $f$ est polynômiale.
    3. Soit $(x, y) in U$, alors
      $ J_f (x, y) = mat(2x, -2y; 2y, 2x) $
      et $det(J_f (x, y)) = 4(x^2 + y^2) > 0$ sur $U$, donc $dif f_(x, y)$ est inversible.

    Donc d'après le @thm-inversion-locale $fun(f, U, RR^2)$ est un $C^oo$-difféomorphisme local en tout point de $U$.
    Mais $f(-1, -1) = f(1, 1)$, donc $fun(f, U, RR^2)$ n'est pas $C^oo$-difféomorphisme global.

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
    Donc d'après le @thm-inversion-globale $fun(f, U', f(U'))$ est un $C^oo$-difféomorphisme.
])

== Théorème des fonctions implicites

#theorem(
  title: "Théorème des fonctions implicites",
  [
    Soit $U$ un ouvert de $RR^n times RR^p$, $(a, b) in U$ et $fun(f = (f_1, ..., f_p), U, RR^p)$ une application de classe $C^k$.
    On suppose que $f(a, b) = 0$ et que la matrice jacobienne de $f$ par rapport à la deuxième variable en $(a, b)$ est inversible. Alors il existe un voisinage ouvert $V$ de $a$, un voisinage ouvert $W$ de $b$ avec $V times W subset U$ et une application $fun(phi, V, W)$ qui est $C^oo$ avec $phi(a) = b$, tels que
    $ cases((x, y) in V times W, f(x, y) = 0) <==> cases(x in V, y = phi(x)) $
    de plus pour tout $x in V, dif phi(x) = -(dif_y f(x, phi(x)))^(-1) compose dif_x f(x, phi(x))$.
  ],
) <thm-fonctions-implicites>

#examples([
  + On considère $fun(f, RR^2, RR, x: (x, y), fx: x^2+y^2-1)$ et $SS^1 := {(x, y) in RR^2 | f(x, y) = 0}$. Les dérivées partielles de $f$ sont
    $
      (partial f) / (partial x) (x, y) &= 2x "et"
      (partial f) / (partial y) (x, y) &= 2y.
    $
    On remarque que pour $(x, y) in RR^2$ vérifiant
    $
      cases((x, y) in SS^1, (partial f)/(partial y) (x, y) != 0)
      &<==> cases((x, y) in SS^1, y != 0)
    $
    on a $(x, y) in SS^1 without {(1, 0), (-1, 0)}$. On peut donc appliquer le @thm-fonctions-implicites, au voisinage $V$ de $x$, $SS^1$ est le graphe d'une application $fun(phi, V, RR)$.
    De plus on a
    $ forall x in V, x^2 + phi(x)^2 - 1 = 0 $
    en dérivant on trouve
    $ forall x in V, 2x + 2phi(x)phi'(x) = 0 $
    et donc $phi'(x) = -x/phi(x)$.
  + On considère $fun(f, RR^3, RR, x: (x, y, z), fx: x^2 + y^2 + z^2 - 1)$, $SS^2 := {(x, y, z) in RR^3 | f(x, y, z) = 0}$. Les dérivées partielles de $f$ sont
    $ forall a in {x, y, z}, (partial f) / (partial a) (x, y, z) = 2a. $
    On remarque que pour $(x, y, z) in RR^3$ vérifiant
    $
      cases((x, y, z) in SS^2, (partial f)/(partial z) (x, y, z) != 0)
      &<==> cases((x, y, z) in SS^2, z != 0) \
      &<==> cases((x, y, z) in SS^2, (x, y, z) != (a, b, 0) "où" (a, b) in SS^1)
    $
    on a $(x, y, z) in SS^2 without (SS^1 times {0})$. On peut donc appliquer le @thm-fonctions-implicites, au voisinage $V$ de $(x, y)$, $SS^2$ est le graphe d'une application $fun(phi, V, RR)$. De plus on a
    $ forall (x, y) in V, x^2 + y^2 + phi(x, y)^2 - 1 = 0 $
    en dérivant par rapport à $x$ on trouve
    $ forall (x, y) in V, 2x + 2 (partial f) / (partial x) (x, y) phi(x, y) = 0 $
    donc $(partial f)/(partial x) (x, y) = -x/phi(x, y)$, et en dérivant par rapport à $y$ on trouve
    $ forall (x, y) in V, 2y + 2 (partial f) / (partial y) (x, y) phi(x, y) = 0 $
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
  + On considère le cercle $SS^1$, on pose $U' := ]0, +oo[ times ]-pi, pi[$, $V = RR^2 without {]-oo, 0] times {0}}$, ainsi que $fun(psi, U', V, x: (r, theta), fx: r (cos(theta), sin(theta)))$ qui est un difféomorphisme de classe $C^oo$. On a
    $ V sect SS^1 &= SS^1 without {(-1, 0)} \
      &= psi({1} times bracket.r -pi, pi bracket.l) \
      &= psi(U' sect ({1} times RR)) $
    on prend alors $U: ]-pi, pi[ times ]0, +oo[$ et $fun(phi, U, V, x: (theta, r), fx: psi(r+1, theta))$, donc $SS^1$ est bien une sous-variété de $RR^2$ de classe $C^oo$ et de dimension 1.
])

