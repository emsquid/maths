#import "../../template.typ": *

#show: maths.with(title: "Homologie singulière", color: "#718355")

= Premières définitions

== Simplexe

#definition([
  Soit $E$ un $RR$-espace vectoriel et $A$ un sous-ensemble de $E$.
  On dit que $A$ est _convexe_ si
  $ forall p, q in A, [p, q] := {(1 - t)p + t q | t in [0, 1]} subset A. $
])

#definition([
  Soit $E$ un $RR$-espace vectoriel, $A$ un sous-ensemble de $E$ et $p_0, ..., p_n$ des éléments de $A$.
  On appelle _combinaison (linéaire) convexe_ une combinaison de la forme $t_0 p_0 + dots.c + t_n p_n$, telle que $t_0, ..., t_n in [0, 1]$ et $t_0 + dots.c + t_n = 1$.
])

#proposition([
  Soit $E$ un $RR$-espace vectoriel, $A$ un sous-ensemble de $E$ et $p_0, ..., p_n$ des éléments de $A$. Alors si $A$ est convexe toute combinaison convexe de $p_0, ..., p_n$ appartient à $A$.
]) <prop-combinaison-convexe>

#proof([
  Soit $t_0, ..., t_n in [0, 1]$ tels que $t_0 + dots.c + t_n = 1$. Notons $H(n) : t_0 p_0 + dots.c + t_n p_n in A$. \
  Pour $n = 1$. On pose $t := t_1$, alors puisque $A$ est convexe $t_0 p_0 + t_1 p_1 = (1 - t)p_0 + t p_1 in A$. \
  Pour $n > 1$. On suppose que $H(n - 1)$ est vérifiée. Sans perte de généralité, on suppose que $t_n != 0$, et on pose
  $ p := (t_0) / (1 - t_n) p_0 + dots.c + (t_(n-1)) / (1 - t_n) p_(n-1) $
  alors d'après $H(n - 1)$ on a $p in A$. Par convexité on a $t_0 p_0 + dots.c + t_n p_n = (1 - t_n)p + t_n p_n in A$.
])

#definition([
  Soit $E$ un $RR$-espace vectoriel et $A$ un sous-ensemble de $E$.
  On appelle _enveloppe convexe de $A$_, notée $[A]$, l'ensemble des combinaisons convexes de sous-ensembles finis de $A$.
])

#proposition([
  Soit $E$ un $RR$-espace vectoriel et $A$ un sous-ensemble de $E$.
  Alors l'enveloppe convexe de $A$ est le plus petit ensemble convexe contenant $A$.
])

#proof([
  Soit $p, q in [A]$ et $t in [0, 1]$.
  Puisque $(1 - t)p + t q$ est une combinaison convexe d'un sous-ensemble fini de $A$, on a bien $(1 - t)p + t q in [A]$.
  Donc $[A]$ est convexe.

  Soit $B$ un sous-ensemble convexe de $E$ contenant $A$.
  Soit $x in [A]$, alors il existe $p_0, ..., p_n in A$ et $t_0, ..., t_n in [0, 1]$ tels que $t_0 + dots.c + t_n = 1$ et $x = t_0 p_0 + dots.c + t_n p_n $. D'après la @prop-combinaison-convexe on a bien $x in B$.
  Donc $[A] subset B$.
])

#definition([
  Soit $E$ un $RR$-espace vectoriel et $F$ une famille libre de $n + 1$ éléments de $E$.
  On appelle _$n$-simplexe généré par $F$_ l'enveloppe convexe de $F$. On dit que les éléments de $F$ sont les _sommets_ de $[F]$ et que $n$ est la _dimension_ de $[F]$.
])

#definition([
  On appelle _$n$-simplexe standard_, noté $Delta^n$, le $n$-simplexe généré par la base canonique de $RR^(n+1)$.
])

#definition([
  Soit $E$ un $RR$-espace vectoriel, $[F]$ un $n$-simplexe et $x = t_0 p_0 + dots.c + t_n p_n$ un élément de $[F]$.
  On appelle _coordonnées barycentriques de $x$_ les coefficients $t_0, ..., t_n$.
])

== Chaine singulière

#definition([
  Soit $X$ un espace topologique.
  On appelle _$n$-simplexe singulier sur $X$_ une application continue $func(sigma, Delta^n, X)$.
])

#definition([
  Soit $X$ un espace topologique, $a_0, ..., a_k$ des entiers et $sigma_0, ..., sigma_k$ des $n$-simplexes singuliers sur $X$.
  On appelle _$n$-chaîne_ l'application $a_0 sigma_0 + dots.c + a_k sigma_k$.
  On note $C_(n)(X)$ l'ensemble des $n$-chaînes.
])

#proposition([
  Soit $X$ et $Y$ deux espaces topologiques, $sigma$ un $n$-simplexe singulier sur $X$ et #box($func(f, X, Y)$) une application continue.
  Alors la composition $func(f compose sigma, Delta^n, Y)$ est un $n$-simplexe.
])

#definition([
  Soit $X$ un espace topologique et $sigma$ un $n$-simplexe singulier sur $X$.
  On appelle _bord de $sigma$_, noté $partial_n$, le $(n-1)$-simplexe singulier sur $X$ défini par :
  $
    partial_n sigma := sum_(k=0)^n (-1)^k sigma_i
  $
  où $sigma_i := sigma|_[e_1, ..., e_(k-1), e_(k+1), ..., e_n]$. // TODO

])
