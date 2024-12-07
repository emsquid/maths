#import "../template.typ": *

#show: maths.with(title: "Algèbre linéaire et bilinéaire", color: "#718355")

= Rappels d'algèbre linéaire

== Espaces vectoriels

#definition([
  Soit $KK$ un corps commutatif. On appelle _espace vectoriel sur $KK$_, ou _$KK$-espace vectoriel_, un ensemble $E$ muni de deux lois
  - une loi de composition interne $fun(+, E times E, E)$, telle que le couple $(E, +)$ forme un groupe commutatif,
  - et d'une loi de composition externe $fun(dot, KK times E, E)$, vérifiant les propriétés suivantes
    + la loi $dot$ est distributive à droite, $forall a, b in KK, forall x in E, (a + b) dot x = a dot x + b dot x$,
    + la loi $dot$ est distributive à gauche, $forall a in KK, forall x, y in E, a dot (x + y) = a dot x + a dot y$,
    + la loi $dot$ est associative mixte, $forall a, b in KK, forall x in E, a dot (b dot x) = (a b) dot x,$
    + le neutre de $KK$ est neutre à gauche pour $dot$, $forall x in E, 1 dot x = x$.
])

#definition([
  Soit $E$ un $KK$-espace vectoriel et $F$ un sous-ensemble de $E$. On dit que $F$ est un _sous-espace vectoriel de $E$_, s'il est non-vide et stable par combinaisons linéaires.
])

#proposition([
  Soit $E$ un $KK$-espace vectoriel, et $F$ et $G$ deux sous-espaces vectoriels de $E$. Alors $F sect G$ est un sous-espace vectoriel.
])

#definition([
  Soit $E$ un $KK$-espace vectoriel, et $F$ et $G$ deux sous-espaces vectoriels de $E$. On définit la somme de $F$ et $G$ par
  $ F + G := {x + y | x in F, y in G}. $
])

#proposition([
  Soit $E$ un $KK$-espace vectoriel, et $F$ et $G$ deux sous-espaces vectoriels de $E$. Alors $F + G$ est un sous-espace vectoriel.
])

#definition([
  Soit $E$ un $KK$-espace vectoriel et $x_1, ..., x_n in E$. On appelle _sous-espace vectoriel engendré par $x_1, ..., x_n$_, l'ensemble des combinaisons linéaires de $x_1, ..., x_n$, noté
  $
    "Vect"(x_1, ..., x_n) = {
      a_1 dot x_1 + ... + a_n dot x_n | a_1, ..., a_n in KK
    }.
  $
])

#definition([
  Soit $E$ un $KK$-espace vectoriel et $(E_k)_(1 <= k <= n)$ une famille de sous-espaces vectoriels de $E$. On dit qu'ils sont en _somme directe_ si
  $
    forall (
      x_1, ..., x_n
    ) in E_1 times ... times E_n, sum_(k = 1)^n x_k = 0 => forall 1 <= k <= n, x_k = 0
  $
  dans ce cas, on notera $E_1 plus.circle ... plus.circle E_n := E_1 + ... + E_n$.
])

#remark([
  Soit $E$ un $KK$-espace vectoriel, et $F$ et $G$ deux sous-espaces vectoriels de $E$. Alors $F$ et $G$ sont en somme directe si $F sect G = {0}$.
])

== Famille libre, famille génératrice et bases

#definition([
  Soit $E$ un $KK$-espace vectoriel et $x_1, ..., x_n in E$. On dit que $(x_1, ..., x_n)$ est une _famille libre_ si les droites $(KK x_k)_(1 <= k <= n)$ sont en somme directe, c'est-à-dire
  $
    forall a_1, ..., a_n in KK, a_1 dot x_1 + ... + a_n dot x_n = 0 => forall 1 <= k <= n, a_k = 0.
  $
])

#definition([
  Soit $E$ un $KK$-espace vectoriel et $x_1, ..., x_n in E$. On dit que $(x_1, ..., x_n)$ est une _famille génératrice_ si $"Vect"(x_1, ..., x_n) = E$, c'est-à-dire
  $
    forall x in E, exists a_1, ..., a_n in KK, a_1 dot x_1 + ... + a_1 dot x_n = x.
  $
])

#definition([
  Soit $E$ un $KK$-espace vectoriel et $x_1, ..., x_n in E$. On dit que $(x_1, ..., x_n)$ est une _base_ si elle est libre et génératrice, c'est-à-dire
  $
    forall x in E, exists! a_1, ..., a_n in KK, a_1 dot x_1 + ... + a_1 dot x_n = x.
  $
])

#theorem([
  Soit $E$ un $KK$-espace vectoriel, et $(x_1, ..., x_n)$ et $(x_1, ..., x_m)$ deux bases de $E$. Alors elles ont le même nombre d'éléments $n = m$.
])

#definition([
  Soit $E$ un $KK$-espace vectoriel. On appelle _dimension de $E$_, notée $dim(E)$, le nombre d'éléments dans une base de $E$.
])

#theorem(
  title: "de la base incomplète",
  [
    Soit $E$ un $KK$-espace vectoriel de dimension finie et $(x_1, ..., x_m)$ une famille libre de $E$. Alors il existe $x_(m+1), ..., x_n in E$, tels que $(x_1, ..., x_n)$ soit une base de $E$.
  ],
)

#proposition([
  Soit $E$ un $KK$-espace vectoriel de dimension $n$ et $cal(E) = (e_1, ..., e_n)$ une famille d'éléments de $E$. Alors les énoncés suivants sont équivalents
  + $cal(E)$ est une base de $E$,
  + $cal(E)$ est une famille libre de $E$,
  + $cal(E)$ est une famille génératrice de $E$.
])

#theorem([
  Soit $E$ un $KK$-espace vectoriel, et $F$ et $G$ deux sous-espaces vectoriels de $E$. Alors
  $ dim(F) + dim(G) = dim(F + G) + dim(F sect G). $
])

#notation([
  Soit $E$ un $KK$-espace vectoriel, $x in E$, et $cal(E) = (e_1, ..., e_n)$ et $cal(F) = (f_1, ..., f_n)$ deux bases de $E$.
  - On note $[x]_cal(E)$ les coordonnées de $x$ dans la base $cal(E)$.
  - On note $cal(P)_cal(E)^cal(F) := ([f_1]_cal(E) med dots.c med [f_n]_cal(E))$ la matrice de passage de la base $cal(E)$ à la base $F$.
  Alors les coordonnées de $x$ dans les bases $cal(E)$ et $cal(F)$ sont liées par
  $ [x]_cal(E) = cal(P)_cal(E)^cal(F) [x]_cal(F) $
  ce qui entraîne
  $ cal(P)_cal(F)^cal(E) = (cal(P)_cal(E)^cal(F))^(-1). $
])

== Applications linéaires

#definition([
  Soit $E$ et $F$ deux $KK$-espaces vectoriels, et $fun(u, E, F)$ une application. On dit que $u$ est _linéaire_, si elle vérifie
  $
    forall a, b in KK, forall x, y in E, u(a dot x + b dot y) = a dot u(
      x
    ) + b dot u(y).
  $
  Si $E = F$, on dit que $u$ est un _endomorphisme_.
])

#notation([
  Soit $E$ et $F$ deux $KK$-espaces vectoriels. On note $cal(L)(E, F)$ l'ensemble des applications linéaires de $E$ dans $F$. Si $E = F$, on note $cal(L)(E) := cal(L)(E, E)$.
])

#definition([
  Soit $E$ et $F$ deux $KK$-espaces vectoriels, et $fun(u, E, F)$ une application linéaire.
  - On appelle _image_ de $u$ l'ensemble $im(u) := {u(x) | x in E}$.
  - On appelle _noyau_ de $u$ l'ensemble $ker(u) := {x in E| u(x) = 0}$.
])

#proposition([
  Soit $E$ et $F$ deux $KK$-espaces vectoriels, et $fun(u, E, F)$ une application linéaire.
  Alors $ker(u)$ et $im(u)$ sont des espaces vectoriels.
])

#definition([
  Soit $E$ et $F$ deux $KK$-espaces vectoriels, et $fun(u, E, F)$ une application linéaire.
  On appelle _rang_ de $u$, noté $"rg"(u)$, la dimension de $im(u)$.
])

#theorem(
  title: "du rang",
  [
    Soit $E$ et $F$ deux $KK$-espaces vectoriels, et $fun(u, E, F)$ une application linéaire. Alors
    $ dim(E) = dim(im(u)) + dim(ker(u)). $
  ],
)

#corollary([
  Soit $E$ et $F$ deux $KK$-espaces vectoriels, et $fun(u, E, F)$ une application linéaire. Alors les énoncés suivants sont équivalents
  + $u$ est bijective,
  + $u$ est injective,
  + $u$ est surjective.
])

== Matrice d'une application linéaire

#definition([
  Soit $E$ et $F$ deux $KK$-espaces vectoriels, $cal(E) = (e_1, ..., e_n)$ une base de $E$ et $cal(F)$ une base de $F$, et $fun(u, E, F)$ une application linéaire. On appelle _matrice de $u$_ dans les bases $cal(E)$ et $cal(F)$, la matrice
  $ [u]_cal(E)^cal(F) := ([u(e_1)]_cal(F) med dots.c med [u(e_n)]_cal(F)). $
  Si $E = F$, on notera $[u]_cal(E) := [u]_cal(E)^cal(F)$, et on remarque $cal(P)_cal(E)^cal(F) = [id]_cal(F)^cal(E)$.
])

#proposition([
  Soit $E, F$ et $G$ trois $KK$-espaces vectoriels, $cal(E), cal(F)$ et $cal(G)$ des bases respectives de $E, F$ et $G$, et $fun(u, E, F)$ et $fun(v, F, G)$ deux applications linéaires. Alors
  $ [v compose u]_cal(E)^cal(G) = [v]_cal(F)^cal(G) [u]_cal(E)^cal(F). $
])

#corollary([
  Soit $E$ un $KK$-espace vectoriel, $cal(E)$ et $cal(F)$ deux bases de $E$, et $fun(u, E, E)$ un endomorphisme sur $E$. Alors
  $
    [u]_(cal(F)) = cal(P)_(cal(F))^cal(E) [u]_cal(E) cal(P)_cal(E)^(cal(F)).
  $
])

== Déterminant d'une matrice

#definition([
  Soit $M$ une matrice carrée de taille $n$. On appelle _déterminant_ de $M$, le nombre
  $
    det(M) := sum_(sigma in S_n) "sign"(
      sigma
    ) m_(1, sigma(1)) ... m_(n, sigma(n)).
  $
])

#proposition([
  Soit $A$ et $B$ deux matrices carrées de même taille. Alors
  $ det(A B) = det(A) det(B). $
])

#corollary([
  Soit $P$ une matrice inversible. Alors
  $ det(P^(-1)) = det(P)^(-1) $
  et si $M$ est une matrice carrée de même taille, on a
  $ det(P^(-1) A P) = det(A). $
])

#corollary([
  Soit $E$ un $KK$-espace vectoriel, $cal(E)$ et $cal(F)$ deux bases de $E$, et $fun(u, E, E)$ un endomorphisme sur $E$. Alors
  $ det([u]_cal(E)) = det([u]_cal(F)). $
])

#definition([
  Soit $E$ un $KK$-espace vectoriel et $fun(u, E, E)$ un endomorphisme sur $E$. On appelle _déterminant_ de $u$, noté $det(u)$, le déterminant de la matrice de $u$ dans une base de $E$.
])

#proposition([
  Soit $E$ un $KK$-espace vectoriel et $fun(u, E, E)$ un endomorphisme sur $E$. Alors $u$ est inversible si et seulement si son déterminant est non-nul.
])

#proposition([
  Soit $M$ une matrice carrée de la forme
  $ mat(A, C; 0, B; augment: #(hline: 1, vline: 1)) $
  où $A$ et $B$ sont des blocs carrés. Alors
  $ det(M) = det(A) det(B). $
])

#pagebreak()

= Diagonalisation



= Polynôme caractéristique

= Trigonalisation

= Polynôme d'endomorphisme

= Réduction d'endomorphisme

#pagebreak()

= Formes bilinéaires

#definition([
  Soit $E$ un $KK$-espace vectoriel et $fun(Phi, E times E, E)$ une application. On dit que $Phi$ est une _forme bilinéaire_, si pour tout $x in E$, les applications $y |-> Phi(x, y)$ et $y |-> Phi(y, x)$ sont linéaires.
])

== Ecriture dans une base

#definition([
  Soit $E$ un $KK$-espace vectoriel, $cal(E) = (e_1, ..., e_n)$ une base de $E$ et $fun(Phi, E times E, E)$ une forme bilinéaire. On appelle _matrice_ de $Phi$ dans la base $cal(E)$, la matrice
  $ [Phi]_cal(E) := (Phi(e_i, e_j))_(1 <= i, j <= n). $


])

#proposition([
  Soit $E$ un $KK$-espace vectoriel, $cal(E) = (e_1, ..., e_n)$ une base de $E$ et $fun(Phi, E times E, E)$ une forme bilinéaire. Alors par bilinéarité
  $
    forall x = (x_1, ..., x_n), y = (
      y_1, ..., y_n
    ) in E, Phi(x, y) = sum_(1 <= i, j <= n) x_i y_j Phi(e_i, e_j) = transpose([x]_cal(E)) [
      Phi
    ]_cal(E) [y]_cal(E).
  $
])

#proposition([
  Soit $E$ un $KK$-espace vectoriel, $cal(E)$ et $cal(F)$ deux bases de $E$, et $fun(Phi, E times E, E)$ une forme bilinéaire. Alors
  $
    [Phi]_(cal(F)) = transpose(cal(P)_(cal(E))^cal(F)) [
      Phi
    ]_cal(E) cal(P)_cal(E)^(cal(F)).
  $
])

== Dualité

#definition([
  Soit $E$ un $KK$-espace vectoriel de dimension $n$. On appelle _dual_ de $E$, noté $E^*$, l'ensemble des formes linéaires sur $E$. Si $cal(E) = (e_1, ..., e_n)$ est une base de $E$, on appelle _base duale_, la famille $cal(E)^* = (e_1^*, ..., e_n^*)$ telle que
  $
    forall i, j in {1, ..., n}, e_i^* (
      e_j
    ) := delta_(i, j) = cases(1 "si" i = j, 0 "sinon").
  $
])

#proposition([
  Soit $E$ un $KK$-espace vectoriel de dimension $n$. Soit $fun(u, E, E)$ une forme linéaire, alors
  $ u = sum_(i=0)^n u(e_i) e_i^* $
  Soit $f$ un élément de $E$, alors
  $ f = sum_(i=0)^n e_i^* (f) e_i. $
])

#definition([
  Soit $E$ un $KK$-espace vectoriel et $cal(F) = (f_1, ..., f_n)$ une base de $E^*$. On appelle _base antéduale_, l'unique base $cal(E) = (e_1, ..., e_n)$ de $E$ telle que $cal(E)^* = cal(F)$.
])

#definition([
  Soit $E$ un $KK$-espace vectoriel et $fun(Phi, E times E, KK)$ une forme bilinéaire. On appelle _application linéaire associée_ à $Phi$, l'application
  $ fun(u_Phi, E, E^*, x:x, fx: (y |-> Phi(x, y))). $
])

== Forme bilinéaire symétrique et forme quadratique

#definition([
  Soit $E$ un $KK$-espace vectoriel et $fun(Phi, E times E, KK)$ une forme bilinéaire. On dit que $Phi$ est _symétrique_, si
  $ forall (x, y) in E times E, Phi(x, y) = Phi(y, x). $
])

#definition([
  Soit $E$ un $KK$-espace vectoriel et $fun(Q, E, KK)$ une application. On dit que $Q$ est une _forme quadratique_, s'il existe une forme bilinéaire $fun(Phi, E times E, KK)$ telle que
  $ forall x in E, Q(x) = Phi(x, x) $
  dans ce cas, on dit que $Q$ est la _forme quadratique associée_ à $Phi$.
])

#proposition(
  title: "Formule de polarisation",
  [
    Soit $E$ un $KK$-espace vectoriel, $fun(Phi, E times E, KK)$ une forme bilinéaire et $fun(Q, E, KK)$ la forme quadratique associée à $Phi$. Alors
    $
      forall (x, y) in E times E, Phi(x, y) = 1 / 2(
        Q(x + y) - Q(x) - Q(y)
      ) = 1 / 4(Q(x + y) + Q(x - y)).
    $
  ],
) <prop-form-polar>

#remark([
  Soit $E$ un $KK$-espace vectoriel et $fun(Q, E, KK)$ une forme quadratique. Alors d'après la @prop-form-polar, $Q$ détermine une forme bilinéaire symétrique, on l'appelle _forme polaire associée_ à $Q$.
])

#remark([
  Soit $E$ un $KK$-espace vectoriel et $fun(Phi, E times E, KK)$ une forme bilinéaire. Alors sa matrice dans la base canonique est symétrique.
])

== Forme quadratique définie

#definition([
  Soit $E$ un $KK$-espace vectoriel et $fun(Phi, E times E, KK)$ une forme bilinéaire.
  On dit que $Phi$ est _non-dégénérée_ si
  $ forall x in E, (forall y in E, Phi(x, y) = 0) => x = 0. $
])

#definition([
  Soit $E$ un $KK$-espace vectoriel et $fun(Phi, E times E, KK)$ une forme bilinéaire.
  On dit que $Phi$ est _définie_ si
  $ forall x in E, Phi(x, x) = 0 => x = 0. $
])

#proposition([
  Soit $E$ un $KK$-espace vectoriel et $fun(Phi, E times E, KK)$ une forme bilinéaire.
  Alors si $Phi$ est définie, elle est non-dégénérée.
])

#definition([
  Soit $E$ un $KK$-espace vectoriel et $fun(Phi, E times E, KK)$ une forme bilinéaire définie.
  - On dit que $Phi$ est _définie positive_ si
    $ forall x in E without {0}, Phi(x, x) > 0. $
  - On dit que $Phi$ est _définie négative_ si
    $ forall x in E without {0}, Phi(x, x) < 0. $
])

#proposition([
  Soit $E$ un $KK$-espace vectoriel et $fun(Phi, E times E, KK)$ une forme bilinéaire définie.
  Alors $Q$ est soit définie positive, soit définie négative.
])

#remark([
  On étend toutes les énoncés précédents aux formes quadratiques avec leur forme polaire associée.
])


== Réduction d'une forme quadratique

#theorem([
  Soit $E$ un $KK$-espace vectoriel de dimension $n$ et $fun(Q, E, KK)$ une forme quadratique.
  Alors il existe des formes linéaires indépendantes $f_1, ..., f_m$ sur $E$ et des éléments non-nuls $a_1, ..., a_m in KK$ tels que
  $ forall x in E, Q(x) = a_1 f_1 (x)^2 + ... + a_m f_m (x)^2. $
]) <thm-redu-quad>

#proof([
  On applique l'algorithme de #link("https://www.bibmath.net/dico/index.php?action=affiche&quoi=./g/gaussdecompo.html")[réduction de Gauss].
])

#remark([
  La famille de formes linéaires indépendantes qui intervient dans le @thm-redu-quad n'est pas nécessairement unique.
])

== Invariants d'une forme quadratique

#theorem(
  title: "d'inertie de Sylvester",
  [
    Soit $E$ un $KK$-espace vectoriel de dimension $n$ et $fun(Q, E, KK)$ une forme quadratique.
    Alors le nombre $m$ de formes linéaires indépendantes qui interviennent dans une décomposition de $Q$ est égal au rang de $Q$.

  ],
)

#theorem(
  title: [d'inertie de Sylvester dans $RR$],
  [
    Soit $E$ un $KK$-espace vectoriel de dimension $n$ et $fun(Q, E, KK)$ une forme quadratique.
    Soit
    $
      Q = a_1 f_1^2 + ... + a_s f_s^2 - a_(s+1) f_(s+1)^2 - ... - a_(s+t) f_(s+t)^2
    $
    une décomposition de $Q$ en sommes de carrés telle que $forall i in {1, ..., s+t}, a_i > 0$.
    Alors les nombres $s$ et $t$ ne dépendent que de $Q$.
  ],
) <thm-sylv-r>

#definition([
  Soit $E$ un $KK$-espace vectoriel de dimension $n$ et $fun(Q, E, KK)$ une forme quadratique.
  On appelle _signature_ de $Q$, le couple $(s, t)$ du @thm-sylv-r.
])

#pagebreak()

= Espaces euclidiens

#definition([
  Soit $E$ un $RR$-espace vectoriel.
  On appelle _produit scalaire_ sur $E$, noté $sca(dot, dot)$, une forme bilinéaire symétrique définie positive.
  On appelle _espace euclidien_ le couple $(E, sca(dot, dot))$.
])

#definition([
  Soit $(E, sca(dot, dot))$ un espace euclidien.
  On appelle _norme associée au produit scalaire_, l'application $fun(||dot||, E, RR_+, x: x, fx: sqrt(sca(x, x)))$.
])

== Norme d'un vecteur

#theorem(
  title: "Inégalité de Cauchy-Schwarz",
  [
    Soit $(E, sca(dot, dot))$ un espace euclidien.
    Alors
    $ forall x, y in E, |sca(x, y)| <= ||x||||y|| $
    avec égalité si et seulement si les deux éléments sont liés.
  ],
)

#proposition([
  Soit $(E, sca(dot, dot))$ un espace euclidien.
  Alors l'application $||dot||$ est une norme.
])

== Orthogonalité, base orthogonale et base orthonormée

#definition([
  Soit $(E, sca(dot, dot))$ un espace euclidien et $x, y in E$.
  On dit que $x$ et $y$ sont _orthogonaux_, noté $x perp y$, si $sca(x, y) = 0$.
])

#definition([
  Soit $(E, sca(dot, dot))$ un espace euclidien et $F$ un sous-ensemble de $E$.
  On appelle _orthogonal_ de $F$, noté $F^perp$, l'ensemble
  $ F^perp := {x in E | forall y in F, sca(x, y) = 0}. $
])

#notation([
  Soit $(E, sca(dot, dot))$ un espace euclidien et $x in E$.
  On note $x^perp := {x}^perp$.
])

#proposition([
  Soit $(E, sca(dot, dot))$ un espace euclidien et $F$ un sous-ensemble de $E$.
  Alors $F^perp$ est un sous-espace vectoriel de $E$.
])

#proposition([
  Soit $(E, sca(dot, dot))$ un espace euclidien et $x, y in E$. Alors
  $
    x perp y <=> ||x+y||^2 = ||x||^2 + ||y||^2 <=> ||x-y||^2 = ||x||^2 + ||y||^2.
  $
])

#proposition([
  Soit $(E, sca(dot, dot))$ un espace euclidien et $x in E without {0}$. Alors $Vect(x)^perp = x^perp$ et
  $ E = Vect(x) plus.circle x^perp. $
])

#definition([
  Soit $(E, sca(dot, dot))$ un espace euclidien et $cal(E) = (e_1, ..., e_n)$ une base de $E$.
  - On dit que $cal(E)$ est _orthogonale_ si elle vérifie
    $ forall i, j in {1, ..., n}, i != j => sca(e_i, e_j). $
  - On dit que $cal(E)$ est _orthonormée_ si elle vérifie
    $ forall i, j in {1, ..., n}, sca(e_i, e_j) = delta_(i, j). $
])

#remark([
  Soit $(E, sca(dot, dot))$ un espace euclidien et $cal(E) = (e_1, ..., e_n)$ une base orthogonale de $E$.
  Alors la famille $(e_1/(||e_1||), ..., e_n/(||e_n||))$ est une base orthonormée de $E$.
])

#theorem([
  Soit $(E, sca(dot, dot))$ un espace euclidien.
  Alors il existe une base orthonormée de $E$.
])

#proposition([
  Soit $(E, sca(dot, dot))$ un espace euclidien et $F$ un sous-espace vectoriel de $E$. Alors
  + $E = F plus.circle F^perp$,
  + $dim(F^perp) = dim(E) - dim(F)$,
  + $(F^perp)^perp = F$.
])

#theorem(
  title: "Procédé d'orthogonalisation de Gram-Schmidt",
  [
    Soit $(E, sca(dot, dot))$ un espace euclidien et $(e_1, ..., e_n)$ une base de $E$. 
    Alors il existe une base orthonormée $(f_1, ..., f_n)$ de $E$ telle que
    $ forall k in {1, ..., n}, Vect(e_1, ..., e_k) = Vect(f_1, ..., f_k). $
  ],
)

#proof([
  On raisonne par récurrence sur le cardinal $k$ de la famille.
  - Pour $k = 1$, on pose $f_1 := e_1/(||e_1||)$.
  - Pour $k > 1$, supposons qu'il existe une famille orthonormée $(f_1, ..., f_(k-1))$ telle que
    $ Vect(e_1, ..., e_(k-1)) = Vect(f_1, ..., f_(k-1)) $
    alors on pose $f'_k := e_k - sum_(i=1)^(k-1) sca(e_k, f_i) f_i$. Soit $j in {1, ..., k-1}$, alors
    $ sca(f'_k, f_j) &= sca(e_k - sum_(i=1)^(k-1) sca(e_k, f_i) f_i, f_j) $
    et par bilinéarité du produit scalaire 
    $ sca(f'_k, f_j) &= sca(e_k, f_j) - sum_(i=0)^(k-1) sca(e_k, f_i) sca(f_i, f_j) \
      &= sca(e_k, f_j) - sum_(i=0)^(k-1) sca(e_k, f_i) delta_(i, j) \
      &= sca(e_k, f_j) - sca(e_k, f_j) = 0. $
    Enfin on pose $f_k := (f'_k)/(||f'_k||)$, donc la famille $(f_1, ..., f_k)$ est orthonormée et vérifie l'égalité.
])

== Le groupe orthogonal

#definition([
  Soit $A in GL_n (RR)$ une matrice inversible. On dit que $A$ est _orthogonale_ si $transpose(A) = A^(-1)$. On appelle _groupe orthogonal_, le sous-groupe
  $ O_n (RR) := {A in GL_n (RR) | A transpose(A) = transpose(A) A = I_n}. $
])

#remark([
  Soit $A in O_n (RR)$ une matrice orthogonale. Alors on remarque que $det(A) = plus.minus 1$, on appelle _groupe spécial orthogonal_, le sous-groupe
  $ S O_n (RR) := O_n (RR) sect "det"^(-1)(1). $
])

#definition([
  Soit $(E, sca(dot, dot))$ un espace euclidien et $f in cal(L)(E)$ un endomorphisme. 
  On dit que $f$ est un _endomorphisme orthogonal_ si
  $ forall x, y in E, sca(f(x), f(y)) = sca(x, y). $
  On appelle _groupe orthogonal_, noté $O(E)$, le sous-groupe des endomorphismes orthogonaux.
])

#proposition([
  Soit $(E, sca(dot, dot))$ un espace euclidien et $f in cal(L)(E)$ un endomorphisme. Alors les énoncés suivants sont équivalents
  + $f$ est orthogonal.
  + Soit $x in E$, alors $||f(x)|| = ||x||$.
  + Soit $cal(E)$ une base orthonormée de $E$, alors $[f]_cal(E) in O_n (RR)$.
  + Il existe $cal(E)$ une base orthonormée de $E$, telle que $[f]_cal(E) in O_n (RR)$.
])

#remark([
  Soit $(E, sca(dot, dot))$ un espace euclidien et $f in cal(L)(E)$ un endomorphisme orthogonal. 
  Alors on remarque que $det(f) = plus.minus 1$, on appelle _groupe spécial orthogonal_ le sous-groupe
  $ S O(E) := O(E) sect "det"^(-1)(1). $
])

== Polynômes orthogonaux

#proposition([
  Soit $[a, b]$ un intervalle fermé de $RR$ et $fun(w, [a, b], R_+ without {0})$. Alors la forme bilinéaire symétrique définie par
  $ forall P, Q in RR[X], sca(P, Q) := integral_a^b P(t)Q(t)w(t) dif t $
  est non-dégénérée.
])

#proof([
  Soit $P in RR[X]$, alors
  $ sca(P, P) = 0 &=> integral_a^b P^2 (t) w(t) = 0 \
    &=> forall t in [a, b], P^2 (t) w(t) = 0 \
    &=> forall t in [a, b], P(t) = 0 \
    &=> P = 0 $
  donc $sca(dot, dot)$ est non-dégénérée.
])

#definition([
  Soit $sca(dot, dot)$ un produit scalaire sur $RR[X]$. On appelle _famille de polynômes orthogonaux_, une famille $(P_n)_(n in NN)$ de polynômes qui vérifie
  $ cases(forall i"," j in NN"," i != j => sca(P_i, P_j) = 0, forall n in NN"," deg(P_n) = n) $
])

#proposition([
  Soit $(P_n)_(n in NN)$ et $(Q_n)_(n in NN)$ deux familles de polynômes orthogonaux.
  Soit $n in NN$, alors $P_n$ et $Q_n$ sont colinéaires.
])

#definition([
  Soit $n in NN$ et $p_n in cal(L)(RR_n [X])$ la projection orthogonale sur $RR_(n-1) [X]$. On appelle _?_, l'application $fun(T_n, RR_(n-1) [X], RR_(n-1) [X], x: P, fx: p_n (X P))$.
])

#proposition([
  Soit $(P_n)_(n in NN)$ une famille de polynômes orthogonaux. 
  Soit $n in NN$, alors $T_n$ est symétrique et son spectre est de cardinal $n$. 
  Soit $lambda$ une valeur propre de $T_n$, alors $lambda$ est racine de $P_n$ et l'espace propre associé est la droite engendrée par le quotient de $P_n$ par $X - lambda$. 
])

#proof([
  Soit $P, Q in RR_(n-1) [X]$, alors
  $ sca(T_n (P), Q) = sca(p_n (X P), Q) $
])

#pagebreak()

= Endomorphisme symétrique d'un espace euclidien

#notation([
  Soit $(E, sca(dot, dot))$ un espace euclidien et $u in cal(L)(E)$ un endomorphisme. 
  On note $fun(theta_u, E, E^*)$, l'application définie par
  $ forall y in E, theta_u (y) := x |-> sca(u(x), y). $
])

#definition([
  Soit $(E, sca(dot, dot))$ un espace euclidien et $u in cal(L)(E)$ un endomorphisme. 
  On appelle _application transposée_ (ou _adjoint_) de $u$, l'application définie par $u^* := theta^(-1)_id compose theta_u$.  
])

#proposition([
  Soit $(E, sca(dot, dot))$ un espace euclidien et $u in cal(L)(E)$ un endomorphisme. 
  Alors
  $ forall x, y in E, sca(x, u^*(y)) = sca(u(x), y). $
  Soit $cal(E)$ une base orthonormée de $E$, on a $[u^*]_cal(E) = transpose([u]_cal(E))$.
])

#proof([
  Soit $x, y in E$. Alors
  $ sca(x, u^*(y)) = theta_id (u^*(y))(x) = (theta_id compose u^*)(y)(x) = theta_u (y)(x) = sca(u(x), y). $
])

#definition([
  Soit $(E, sca(dot, dot))$ un espace euclidien et $u in cal(L)(E)$ un endomorphisme. 
  On dit que $u$ est _symétrique_ (ou _auto-adjoint_), si $u^* = u$.
])

#proposition([
  Soit $(E, sca(dot, dot))$ un espace euclidien et $u in cal(L)(E)$ un endomorphisme. 
  Alors $u$ est symétrique si et seulement si sa matrice dans une base orthonormée de $E$ est symétrique.
])

#proposition([
  Soit $M in cal(M)_n (RR)$ une matrice symétrique. 
  Alors toutes les valeurs propres complexes de $M$ sont réelles.
])

#theorem([
  Soit $(E, sca(dot, dot))$ un espace euclidien et $u in cal(L)(E)$ un endomorphisme. 
  Alors $u$ est diagonalisable dans une base orthonormée de $E$.
])

#theorem([
  Soit $M in cal(M)_n (RR)$ une matrice symétrique. Alors il existe une matrice orthogonale $P$ telle que $transpose(P) M P$ soit diagonale.
])

#corollary([
  Soit $(E, sca(dot, dot))$ un espace euclidien, $Q$ une forme quadratique définie positive sur $E$ et $lambda_1 <= ... <= lambda_n$ ses valeurs propres ordonnées. Alors 
  $ forall x in E, lambda_1||x||^2 <= Q(x) <= lambda_n||x||^2 $ 
  et ces inégalités sont optimales.
])
