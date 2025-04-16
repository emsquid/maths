#import "../../template.typ": *

#set-maths(sequence: (ind: $n$, dom: $ZZ$))

#let cdot = $circle.filled.tiny$

#show: maths.with(
  title: "Problème du rectangle inscrit",
  authors: ("Emanuel Morille",),
  color: "#718355",
  date: true,
)

#pagebreak()

= Homologie

== Axiomes d'Eilenberg-Steenrod

#definition([
  Une _théorie de l'homologie_ sur la catégorie des paires d'espaces topologiques $sans("Top")_2$ dans la catégorie des groupes abéliens $sans("Ab")$ est une suite de foncteurs $sequence(func(H_n, sans("Top")_2, sans("Ab")))$ munie de transformations naturelles $sequence(func(partial_n, H_(n)(X, A), H_(n-1)(A) := H_(n-1)(A, emptyset)))$ vérifiant les axomes suivants pour toutes paires d'espaces topologiques $(X, A), (Y, B)$ et $n in ZZ$ :
  - _Homotopie_ : Soit $func(f_0 \, f_1, (X, A), (Y, B))$ deux applications homotopes.
    Alors les applications induites en homologie $func(f_(0*)\, f_(1*), H_(n)(X, A), H_(n)(Y, B))$ sont égales.
  - _Excision_ : Soit $U$ un sous-ensemble de $A$ tel que l'adhérence de $U$ est contenue dans l'intérieur de $A$.
    On note $func(i, (X without U, A without U), (X, A))$ l'inclusion canonique.
    Alors l'application induite en homologie $func(i_*, H_(n)(X without U, A without U), H_(n)(X, A))$ est un isomorphisme.
  - _Dimension_ : Soit $P$ l'espace constitué d'un unique point.
    Alors le groupe $H_(n)(P)$ est non-trivial si et seulement si $n = 0$.
  - _Exactitude_ : La suite :
    $
      ... -> H_(n+1)(X, A) ->^(partial_(n+1)) H_(n)(A) ->^(i_A) H_(n)(X) ->^(i_X) H_(n)(X, A) ->^(partial_n) H_(n-1)(A) -> ...
    $
    est exacte.
]) <def-theorie-homologie>

== Homologie singulière

=== Simplexes

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

=== Chaînes

#definition([
  Soit $X$ un espace topologique.
  On appelle _$n$-simplexe singulier sur $X$_ une application continue de $Delta^n$ dans $X$.
])

#definition([
  Soit $X$ un espace topologique. On note $C_(n)(X)$ le groupe abélien libre engendré par les $n$-simplexes singuliers sur $X$, on appelle _$n$-chaîne singulière_ un élément de $C_(n)(X)$.
])

#proposition([
  Soit $X$ et $Y$ deux espaces topologiques, $func(sigma, Delta^n, X)$ un $n$-simplexe singulier sur $X$ et $func(f, X, Y)$ une application continue.
  Alors la composition $func(f compose sigma, Delta^n, Y)$ est un $n$-simplexe singulier sur $Y$.
])

#definition([
  Soit $X$ et $Y$ deux espaces topologiques et $func(f, X, Y)$ une application continue.
  On appelle _implication induite par $f$_, notée $f_*$, le morphisme :
  $
    func(f_*, C_n (X), C_n (Y), sum_(k=0)^n lambda_k sigma_k, sum_(k=0)^n lambda_k (f compose sigma_k)).
  $

])

#proposition([
  Soit $X$, $Y$ et $Z$ trois espaces topologiques, $func(f, X, Y)$ et $func(g, Y, Z)$ deux applications continues.
  Alors $(g compose f)_* = g_* compose f_*$.

])

#definition([
  Soit $X$ un espace topologique et $func(sigma, Delta^n, X)$ un $n$-simplexe singulier sur $X$.
  On appelle _bord de $sigma$_, noté $partial_n sigma$, le $(n-1)$-simplexe singulier sur $X$ défini par :
  $
    partial_n sigma := sum_(k=0)^n (-1)^k sigma|_[e_0, ..., e_(k-1), e_(k+1), ..., e_n].
  $
  On appelle _morphisme bord_ l'application étendue $func(partial_n, C_n (X), C_(n-1)(X))$.
])

#proposition([
  Soit $X$ et $Y$ deux espaces topologiques et $func(f, X, Y)$ une application continue.
  Alors pour tout $n in NN$, on a $partial_n f_* = f_* partial_n$.
])

#proof([
  Soit $func(sigma, Delta^n, X)$ un $n$-simplexe singulier sur $X$. Alors on a :
  $
    partial_n f_(*)(sigma) = partial_n (f compose sigma) = f_* (partial_n sigma).
  $
])

#proposition([
  Soit $X$ un espace topologique. Alors pour tout $n in NN$, on a $partial_n compose partial_(n+1) = 0$.
])

#proof([
  Soit $func(sigma, Delta^(n+1), X)$ un $(n+1)$-simplexe singulier sur $X$. Alors on a :
  $
    partial_(n+1)(sigma) = sum_(k=0)^(n+1) (-1)^k sigma|_[e_0, ..., e_(k-1), e_(k+1), ..., e_(n+1)]
  $
  donc en appliquant $partial_n$, on obtient :
  $
    (partial_n compose partial_(n+1))(sigma)
    &= &&partial_(n)(sum_(k=0)^(n+1) (-1)^k sigma|_[e_0, ..., e_(k-1), e_(k+1), ..., e_(n+1)]) \
    &= &&sum_(k=0)^(n+1) (-1)^k partial_(n)(sigma|_[e_0, ..., e_(k-1), e_(k+1), ..., e_(n+1)]) \
    &= &&sum_(0 <= k < l <= n + 1) (-1)^(k + l) sigma|_[e_0, ..., e_(k-1), e_(k+1), ..., e_(l-1), e_(l+1), ..., e_(n+1)] \
    & &&+ sum_(0 <= l < k <= n + 1) (-1)^(k + l - 1) sigma|_[e_0, ..., e_(l-1), e_(l+1), ..., e_(k-1), e_(k+1), ..., e_(n+1)]) \
    &= &&0
  $
  car les termes s'annulent deux à deux.
])

=== Complexes de chaînes

#definition([
  Soit $X$ un espace topologique.
  On appelle _complexe de chaînes singulières_, noté $C_(cdot)(X)$, la suite de groupes abéliens libres $sequence(C_(n)(X))$ munie des morphismes de bords $sequence(func(partial_n, C_(n)(X), C_(n-1)(X)))$, avec pour convention $C_(n)(X)$ trivial si $n < 0$.
])

#definition([
  Soit $C_(cdot)(X)$ un complexe de chaînes singulières et $n in ZZ$.
  - On appelle _$n$-cycle singulier_ un élément de $Z_(n)(X) := ker(partial_n)$.
  - On appelle _$n$-bord singulier_ un élément de $B_(n)(X) := im(partial_(n+1))$.
  - On appelle _$n$#super("e")-groupe d'homologie singulière_ le groupe quotient $H_(n)(X) := lquotient(Z_(n)(X), B_(n)(X))$.
])

#definition([
  Soit $C_(cdot)(X)$ un complexe de chaînes singulières et $n in ZZ$.
  - On dit que $C_(cdot)(X)$ est _exact en $C_(n)(X)$_ si $H_(n)(X)$ est trivial.
  - On dit que $C_(cdot)(X)$ est _exact_ s'il est exact en tout $sequence(C_(n)(X))$.
  - On dit que $C_(cdot)(X)$ est _acyclique_ s'il est exact en tout $sequence(C_(n)(X))$ avec $n != 0$.
])

=== Morphismes de chaînes

#definition([
  Soit $C_(cdot)(X)$ et $C_(cdot)(Y)$ deux complexes de chaînes singulières.
  On appelle _morphisme de chaînes_, noté $func(phi_cdot, C_(cdot)(X), C_(cdot)(Y))$, une suite de morphismes $sequence(func(phi_n, C_(n)(X), C_(n)(Y)))$ telle que pour tout $n in ZZ$, on a $partial_n phi_n = phi_(n-1) partial_n$.
])

#proposition([
  Soit $C_(cdot)(X)$ et $C_(cdot)(Y)$ deux complexes de chaînes singulières, $func(phi_cdot, C_(cdot)(X), C_(cdot)(Y))$ un morphisme de chaînes.
  Alors pour tout $n in ZZ$, le morphisme $phi_n$ induit un morphisme entre les $n$#super("e")-groupes d'homologie $func(H_(n)(phi), H_(n)(X), H_(n)(Y))$.
])

#proposition([
  Soit $C_(cdot)(X)$ et $C_(cdot)(Y)$ deux complexes de chaînes singulières, et $func(f, X, Y)$ une application continue.
  Alors l'application induite $f_*$ est un morphisme de chaînes.
])

=== Paires d'espaces topologiques

#definition([
  Soit $(X, A)$ une paire d'espaces topologiques.
  On appelle _complexe de chaînes singulières de la paire $(X, A)$_ le complexe de chaînes singulières quotient $C_(cdot)(X, A) := lquotient(C_(cdot)(X), C_(cdot)(A))$.
])

#definition([
  Soit $(X, A)$ et $(Y, B)$ deux paires d'espaces topologiques, et $func(f, X, Y)$ une application continue.
  On dit que $f$ est un _morphisme de paires_, noté $func(f, (X, A), (Y, B))$, si $f(A)$ est contenue dans $B$.
])

#proposition([
  Soit $C_(cdot)(X, A)$ et $C_(cdot)(Y, B)$ deux complexes de chaînes singulières, et $func(f, (X, A), (Y, B))$ un morphisme de paires.
  Alors l'application induite $f_*$ est un morphisme de chaînes.
])

#theorem([
  La suite des $n$#super("e")-groupe d'homologie singulière des paires d'espaces topologiques $sequence(func(H_n, sans("Top")_2, sans("Ab")))$ munie des morphismes de bords $sequence(func(partial_n, H_(n)(X, A), H_(n-1)(A, emptyset)))$ est une @def-theorie-homologie[théorie de l'homologie].
])


