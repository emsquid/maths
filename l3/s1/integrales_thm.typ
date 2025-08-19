#import "../../template.typ": *

#show: maths.with(title: "Calcul intégral et applications", color: "#718355")

#pagebreak()

= Intégrale de Lebesgue et intégrale de Riemann

#theorem([
  Soit $a, b in overline(RR)$ et $func(f, lr(\]a, b\[), RR)$ une fonction. Alors $f$ est *Lebesgue-intégrable* si et seulement si $f$ est *localement Riemann-intégrable* et que son intégrale impropre est *absolument convergente* sur $lr(\]a, b\[)$. Dans ce cas
  $ integral_lr(\]a, b\[) f(x) dif lambda(x) = integral_a^b f(x) dif x. $ 
])

= Théorèmes

== Convergence monotone (ou Beppo-Levi)

#theorem([
  Soit $(f_n)_(n in NN)$ une suite de fonctions *mesurables positives*. 
  Si $(f_n)_(n in NN)$ est une suite *croissante*, alors $lim_(n -> +oo) f_n$ est mesurable positive et 
  $ lim_(n -> +oo) integral f_n dif mu = integral_E lim_(n -> +oo) f_n dif mu. $
])

#corollary([
  Soit $(f_n)_(n in NN)$ une suite de fonctions *mesurables positives*. 
  Alors
  $ sum_(n = 0)^(+oo) integral_E f_n dif mu = integral_E sum_(n = 0)^(+oo) f_n dif mu. $
])

== Lemme de Fatou

#theorem([
  Soit $(f_n)_(n in NN)$ une suite de fonctions *mesurables positives*. 
  Alors 
  $ liminf_(n -> +oo) integral_E f_n dif mu >= integral_E liminf_(n -> +oo) f_n dif mu. $
])

#corollary([
  Soit $(f_n)_(n in NN)$ une suite de fonctions *mesurables positives*. 
  S'il existe une fonction positive $g$ *intégrable* telle que pour tout $x in E, forall n in NN, f_n (x) <= g(x)$ alors
  $ limsup_(n -> +oo) integral_E f_n dif mu <= integral_E limsup_(n -> +oo) f_n dif mu. $
])

== Convergence dominée

#theorem([
  Soit $(f_n)_(n in NN)$ et $f$ des fonctions *mesurables*. Si
  + pour $mu$-presque tout $x in E, lim_(n -> +oo) f_n (x) =f(x)$,
  + il existe une fonction $g$ *intégrable* avec pour $mu$-presque tout $x in E, forall n in NN, |f_n (x)| <= g(x)$,
  alors $forall n in NN, f_n$ et $f$ sont *intégrables* et
  $ lim_(n -> +oo) integral f_n dif mu = integral_E lim_(n -> +oo) f_n dif mu. $
])

#corollary([
  Soit $(f_n)_(n in NN)$ une suite de fonctions *mesurables*. 
  Si $sum_(n = 0)^(+oo) integral_E abs(f_n) dif mu$ est finie, alors $sum_(n = 0)^(+oo) f_n$ est *définie $mu$-presque partout* et *intégrable*, et
  $ sum_(n = 0)^(+oo) integral_E f_n dif mu = integral_E sum_(n = 0)^(+oo) f_n dif mu. $
])

== Continuité et dérivabilité sous le signe intégral

#theorem([
  Soit $func(f, E times RR, overline(RR))$ une fonction et $y_0$ in $RR$. S'il existe une fonction $g$ *intégrable* telle que
  + pour tout $y in RR, x |-> f(x, y)$ est *mesurable*,
  + pour $mu$-presque tout $x in E, y |-> f(x, y)$ est *continue en $y_0$*,
  + pour $mu$-presque tout $x in E$ et pour tout $y in RR, |f(x, y)| <= g(x)$,
  alors la fonction $y |-> integral_E f(x, y) dif mu(x)$ est *définie sur $RR$* et *continue en $y_0$*.
])

#theorem([
  Soit $I$ un intervalle de $RR$, $func(f, E times I, RR)$ une fonction. S'il existe une fonction $g$ *intégrable* telle que
  + pour tout $y in RR, x |-> f(x, y)$ est *intégrable*,
  + pour $mu$-presque tout $x in E, y |-> f(x, y)$ est *dérivable sur $I$*,
  + pour $mu$-presque tout $x in E$ et pour tout $y in RR, |partial_y f(x, y)| <= g(x)$,
  alors la fonction $F$ $: y |-> integral_E f(x, y) dif mu(x)$ est *définie* et *dérivable sur $I$* avec
    $ forall y in I, F'(y) = integral_E partial_y f(x, y) dif mu(x). $
])

== Fubini

#theorem([
  Soit $mu$ et $nu$ deux mesures *$sigma$-finies*, et $func(f, E times F, overline(RR)_+)$ une fonction *mesurable positive*. Alors
  + Les fonctions $x |-> integral_F f(x, y) dif nu(y)$ et $y |-> integral_E f(x, y) dif mu(x)$ sont *mesurables*,
  + on a l'égalité
    $ integral_(E times F) f(x, y) dif (mu times.circle nu)(x, y) = integral_E integral_F f(x, y) dif nu(y) dif mu(x) = integral_F integral_E f(x, y) dif mu(x) dif nu(y). $
])

#theorem([
  Soit $mu$ et $nu$ deux mesures *$sigma$-finies*, et $func(f, E times F, RR)$ une fonction *intégrable*.
  + pour $mu$-presque tout $x in E$, $y |-> f(x, y)$ et pour $mu$-presque tout $y in F$, $x |-> f(x, y)$ sont *intégrables*,
  + Les fonctions $x |-> integral_F f(x, y) dif nu(y)$ et $y |-> integral_E f(x, y) dif mu(x)$ sont *intégrables*,
  + on a l'égalité
    $ integral_(E times F) f(x, y) dif (mu times.circle nu)(x, y) = integral_E integral_F f(x, y) dif nu(y) dif mu(x) = integral_F integral_E f(x, y) dif mu(x) dif nu(y). $
])
