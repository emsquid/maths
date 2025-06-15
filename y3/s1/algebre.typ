#import "../../template.typ": *

#show: maths.with(title: "Algèbre linéaire et bilinéaire", color: "#718355")

#pagebreak()

= Rappels d'algèbre linéaire

== Espaces vectoriels

#definition([
  Soit $KK$ un corps commutatif. On appelle _espace vectoriel sur $KK$_, ou _$KK$-espace vectoriel_, un ensemble $E$ muni de deux lois
  - une loi de composition interne $func(+, E times E, E)$, telle que le couple $(E, +)$ forme un groupe commutatif,
  - et d'une loi de composition externe $func(dot, KK times E, E)$, vérifiant les propriétés suivantes
    + la loi $dot$ est distributive à droite, $forall a, b in KK, forall x in E, (a + b) dot x = a dot x + b dot x$,
    + la loi $dot$ est distributive à gauche, $forall a in KK, forall x, y in E, a dot (x + y) = a dot x + a dot y$,
    + la loi $dot$ est associative mixte, $forall a, b in KK, forall x in E, a dot (b dot x) = (a b) dot x,$
    + le neutre de $KK$ est neutre à gauche pour $dot$, $forall x in E, 1 dot x = x$.
])

#definition([
  Soit $E$ un $KK$-espace vectoriel et $F$ un sous-ensemble de $E$. On dit que $F$ est un _sous-espace vectoriel de $E$_, s'il est non-vide et stable par combinaisons linéaires.
])

#proposition([
  Soit $E$ un $KK$-espace vectoriel, et $F$ et $G$ deux sous-espaces vectoriels de $E$. Alors $F inter G$ est un sous-espace vectoriel.
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
    span(x_1, ..., x_n) := { a_1 dot x_1 + ... + a_n dot x_n | a_1, ..., a_n in KK }.
  $
])

#definition([
  Soit $E$ un $KK$-espace vectoriel et $(E_k)_(1 <= k <= n)$ une famille de sous-espaces vectoriels de $E$. On dit qu'ils sont en _somme directe_ si
  $
    forall ( x_1, ..., x_n ) in E_1 times ... times E_n, sum_(k = 1)^n x_k = 0 => forall 1 <= k <= n, x_k = 0
  $
  dans ce cas, on notera $E_1 plus.circle ... plus.circle E_n := E_1 + ... + E_n$.
])

#remark([
  Soit $E$ un $KK$-espace vectoriel, et $F$ et $G$ deux sous-espaces vectoriels de $E$. Alors $F$ et $G$ sont en somme directe si $F inter G = {0}$.
])

== Famille libre, famille génératrice et bases

#definition([
  Soit $E$ un $KK$-espace vectoriel et $x_1, ..., x_n in E$. On dit que $(x_1, ..., x_n)$ est une _famille libre_ si les droites $(KK x_k)_(1 <= k <= n)$ sont en somme directe, c'est-à-dire
  $
    forall a_1, ..., a_n in KK, a_1 dot x_1 + ... + a_n dot x_n = 0 => forall 1 <= k <= n, a_k = 0.
  $
])

#definition([
  Soit $E$ un $KK$-espace vectoriel et $x_1, ..., x_n in E$. On dit que $(x_1, ..., x_n)$ est une _famille génératrice_ si $span(x_1, ..., x_n) = E$, c'est-à-dire
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
  $ dim(F) + dim(G) = dim(F + G) + dim(F inter G). $
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
  Soit $E$ et $F$ deux $KK$-espaces vectoriels, et $func(u, E, F)$ une application. On dit que $u$ est _linéaire_, si elle vérifie
  $
    forall a, b in KK, forall x, y in E, u(a dot x + b dot y) = a dot u( x ) + b dot u(y).
  $
  Si $E = F$, on dit que $u$ est un _endomorphisme_.
])

#notation([
  Soit $E$ et $F$ deux $KK$-espaces vectoriels. On note $cal(L)(E, F)$ l'ensemble des applications linéaires de $E$ dans $F$. Si $E = F$, on note $cal(L)(E) := cal(L)(E, E)$.
])

#definition([
  Soit $E$ et $F$ deux $KK$-espaces vectoriels, et $func(u, E, F)$ une application linéaire.
  - On appelle _image_ de $u$ l'ensemble $im(u) := {u(x) | x in E}$.
  - On appelle _noyau_ de $u$ l'ensemble $ker(u) := {x in E| u(x) = 0}$.
])

#proposition([
  Soit $E$ et $F$ deux $KK$-espaces vectoriels, et $func(u, E, F)$ une application linéaire.
  Alors $ker(u)$ et $im(u)$ sont des espaces vectoriels.
])

#definition([
  Soit $E$ et $F$ deux $KK$-espaces vectoriels, et $func(u, E, F)$ une application linéaire.
  On appelle _rang_ de $u$, noté $"rg"(u)$, la dimension de $im(u)$.
])

#theorem(
  title: "du rang",
  [
    Soit $E$ et $F$ deux $KK$-espaces vectoriels, et $func(u, E, F)$ une application linéaire. Alors
    $ dim(E) = dim(im(u)) + dim(ker(u)). $
  ],
)

#corollary([
  Soit $E$ et $F$ deux $KK$-espaces vectoriels, et $func(u, E, F)$ une application linéaire. Alors les énoncés suivants sont équivalents
  + $u$ est bijective,
  + $u$ est injective,
  + $u$ est surjective.
])

== Matrice d'une application linéaire

#definition([
  Soit $E$ et $F$ deux $KK$-espaces vectoriels, $cal(E) = (e_1, ..., e_n)$ une base de $E$ et $cal(F)$ une base de $F$, et $func(u, E, F)$ une application linéaire. On appelle _matrice de $u$_ dans les bases $cal(E)$ et $cal(F)$, la matrice
  $ [u]_cal(E)^cal(F) := ([u(e_1)]_cal(F) med dots.c med [u(e_n)]_cal(F)). $
  Si $E = F$, on notera $[u]_cal(E) := [u]_cal(E)^cal(F)$, et on remarque $cal(P)_cal(E)^cal(F) = [id]_cal(F)^cal(E)$.
])

#proposition([
  Soit $E, F$ et $G$ trois $KK$-espaces vectoriels, $cal(E), cal(F)$ et $cal(G)$ des bases respectives de $E, F$ et $G$, et $func(u, E, F)$ et $func(v, F, G)$ deux applications linéaires. Alors
  $ [v compose u]_cal(E)^cal(G) = [v]_cal(F)^cal(G) [u]_cal(E)^cal(F). $
])

#corollary([
  Soit $E$ un $KK$-espace vectoriel, $cal(E)$ et $cal(F)$ deux bases de $E$, et $func(u, E, E)$ un endomorphisme sur $E$. Alors
  $
    [u]_(cal(F)) = cal(P)_(cal(F))^cal(E) [u]_cal(E) cal(P)_cal(E)^(cal(F)).
  $
])

== Déterminant d'une matrice

#definition([
  Soit $M$ une matrice carrée de taille $n$. On appelle _déterminant_ de $M$, le nombre
  $
    det(M) := sum_(sigma in S_n) "sign"( sigma ) m_(1, sigma(1)) ... m_(n, sigma(n)).
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
  Soit $E$ un $KK$-espace vectoriel, $cal(E)$ et $cal(F)$ deux bases de $E$, et $func(u, E, E)$ un endomorphisme sur $E$. Alors
  $ det([u]_cal(E)) = det([u]_cal(F)). $
])

#definition([
  Soit $E$ un $KK$-espace vectoriel et $func(u, E, E)$ un endomorphisme sur $E$. On appelle _déterminant_ de $u$, noté $det(u)$, le déterminant de la matrice de $u$ dans une base de $E$.
])

#proposition([
  Soit $E$ un $KK$-espace vectoriel et $func(u, E, E)$ un endomorphisme sur $E$. Alors $u$ est inversible si et seulement si son déterminant est non-nul.
])

#proposition([
  Soit $M$ une matrice carrée de la forme
  $ mat(A, C; 0, B; augment: #(hline: 1, vline: 1)) $
  où $A$ et $B$ sont des blocs carrés. Alors
  $ det(M) = det(A) det(B). $
])

= Diagonalisation

#definition([
  Soit $E$ un $KK$-espace vectoriel, $F$ un sous-espace vectoriel de $E$ et $u in cal(L)(E)$ un endomorphisme.
  On dit que $F$ est _stable_ par $u$ si $u(F) subset F$, dans ce cas on note $u_F := u|_F^F in cal(L)(F)$ l'endomorphisme induit.
])

#definition([
  Soit $E$ un $KK$-espace vectoriel, $u in cal(L)(E)$ un endomorphisme et $lambda in KK$.
  On dit que $lambda$ est une _valeur propre_ de $u$ s'il existe $x in E without {0}$ tel que $u(x) = lambda x$, on dit que $x$ est un _vecteur propre_ associé à $lambda$.
])

#definition([
  Soit $E$ un $KK$-espace vectoriel, $u in cal(L)(E)$ un endomorphisme et $lambda in KK$ une valeur propre de $u$. On appelle _espace propre_ associé à $lambda$, l'ensemble
  $ E_lambda (u) := ker(u - lambda id). $
])

#theorem([
  Soit $E$ un $KK$-espace vectoriel et $u in cal(L)(E)$ un endomorphisme.
  Alors les espaces propres de $u$ sont en somme directe.
])

#corollary([
  Soit $E$ un $KK$-espace vectoriel de dimension $n$ et $u in cal(L)(E)$ un endomorphisme.
  Alors $u$ a au plus $n$ valeurs propres.
])

#definition([
  Soit $E$ un $KK$-espace vectoriel de dimension $n$ et $u in cal(L)(E)$ un endomorphisme.
  On appelle _spectre_ de $u$, noté $spectrum(u)$, l'ensemble des valeurs propres de
])

#definition([
  Soit $E$ un $KK$-espace vectoriel et $u in cal(L)(E)$ un endomorphisme.
  On dit que $u$ est _diagonalisable_ si $E$ est la somme directe des espaces propres de $u$.

])

#proposition([
  Soit $E$ un $KK$-espace vectoriel et $u in cal(L)(E)$ un endomorphisme.
  Alors $u$ est diagonalisable si et seulement si il existe une base $cal(E)$ de $E$ telle que $[u]_cal(E)$ est diagonale.
])

#theorem([
  Soit $E$ un $KK$-espace vectoriel de dimension $n$ et $u in cal(L)(E)$ un endomorphisme.
  Alors si $u$ admet $n$ valeurs propres distinctes, $u$ est diagonalisable.
])

#definition([
  Soit $M in cal(M)_n (KK)$ une matrice carrée.
  On étend toutes les définitions précédentes à $M$ en l'associant à $func(u_M, KK^n, KK^n, X, M X)$.
])


= Polynôme caractéristique

#definition([
  Soit $M in cal(M)_n (KK)$ une matrice carrée.
  On appelle _polynôme caractéristique_, le polynôme $chi_M := det(X I_n - M)$.
])

#lemma([
  Soit $M, N in cal(M)_n (KK)$ deux matrices carrées.
  Alors si $M$ et $N$ sont semblables, elles ont le même polynôme caractéristique.
])

#definition([
  Soit $E$ un $KK$-espace vectoriel et $u in cal(L)(E)$ un endomorphisme.
  On étend la définition de _polynôme caractéristique_ en lui associant la matrice de $u$ dans une base de $E$.
])

#proposition([
  Soit $E$ un $KK$-espace vectoriel, $u in cal(L)(E)$ un endomorphisme, et $lambda in KK$.
  Alors $lambda$ est une valeur propre de $u$ si et seulement si $chi_u (lambda) = 0$.
])

#proposition([
  Soit $E$ un $KK$-espace vectoriel, $F$ un sous-espace vectoriel de $E$ et $u in cal(L)(E)$ un endomorphisme.
  Alors si $F$ est stable par $u$, le polynôme $chi_u_F$ divise $chi_u$.
])

#proposition([
  Soit $E$ un $KK$-espace vectoriel de dimension $n$ et $u in cal(L)(E)$ un endomorphisme nilpotent.
  Alors $chi_u = X^n$
])

#theorem([
  Soit $E$ un $KK$-espace vectoriel de dimension $n$ et $u in cal(L)(E)$ un endomorphisme.
  Alors $u$ est diagonalisable si et seulement si son polynôme caractéristique est scindé et si la multiplicité de chaque valeur propre en tant que racine est égale à la dimension de son espace propre associé, c'est-à-dire
  $ chi_u = product_(lambda in spectrum(u)) (X - lambda)^(dim(E_lambda (u))). $
])

= Trigonalisation

#definition([
  Soit $E$ un $KK$-espace vectoriel et $u in cal(L)(E)$ un endomorphisme.
  On dit que $u$ est _trigonalisable_ s'il existe une base $cal(E)$ de $E$ telle que $[u]_cal(E)$ est triangulaire supérieure.
])

#theorem([
  Soit $E$ un $KK$-espace vectoriel et $u in cal(L)(E)$ un endomorphisme.
  Alors $u$ est trigonalisable si et seulement si $chi_u$ est scindé.
])

#corollary([
  Tout endomorphisme sur un $CC$-espace vectoriel est trigonalisable.
])

= Polynôme d'endomorphisme

#definition([
  Soit $E$ un $KK$-espace vectoriel, $u in cal(L)(E)$ un endomorphisme et $P = sum_(k=0)^n a_k X^k$ un polynôme.
  On note
  $ P(u) := sum_(k=0)^n a_k u^k. $
])

#proposition([
  Soit $E$ un $KK$-espace vectoriel, $u in cal(L)(E)$ un endomorphisme et $P, Q$ deux polynômes.
  Alors $P(u) + Q(u) = (P + Q)(u)$ et $P(u) compose Q(u) = (P Q)(u) = (Q P)(u)$.
])

#proposition([
  Soit $E$ un $KK$-espace vectoriel, $u in cal(L)(E)$ un endomorphisme et $P$ un polynôme.
  Alors si $P(u) = 0$, les valeurs propres de $u$ sont racines de $P$.
])

== Décomposition des noyaux

#theorem(
  title: "Lemme des noyaux",
  [
    Soit $E$ un $KK$-espace vectoriel, $u in cal(L)(E)$ un endomorphisme et $(P_i)_(1 <= i <= n)$ une famille de polynômes deux à deux premiers entre eux. Alors
    $ ker((P_1 ... P_n)(u)) = plus.circle.big_(i = 1)^n ker(P_i (u)) $
  ],
)

#theorem([
  Soit $E$ un $KK$-espace vectoriel et $u in cal(L)(E)$ un endomorphisme.
  Alors $u$ est diagonalisable si et seulement s'il existe un polynôme $P$ simplement scindé tel que $P(u) = 0$.
])

#corollary([
  Soit $E$ un $KK$-espace vectoriel, $F$ un sous-espace vectoriel de $E$ et $u in cal(L)(E)$ un endomorphisme diagonalisable. Alors si $F$ est stable par $u$, $u_F$ est diagonalisable.

])

== Théorème de Cayley-Hamilton

#definition([
  Soit $E$ un $KK$-espace vectoriel et $u in cal(L)(E)$ un endomorphisme.
  On appelle _polynômes annulateurs_ de $u$ l'ensemble
  $ I_u := {P in KK[X] | P(u) = 0}. $
])

#proposition([
  Soit $E$ un $KK$-espace vectoriel et $u in cal(L)(E)$ un endomorphisme.
  Alors $I_u$ est un idéal de $KK[X]$, c'est-à-dire qu'il vérifie les propriétés suivantes
  + $0 in I_u$,
  + $forall P, Q in I_u, P + Q in I_u$,
  + $forall P in I_u, Q in KK[X], P Q in I_u$.
])

#theorem(
  title: "de Cayley-Hamilton",
  [
    Soit $E$ un $KK$-espace vectoriel de dimension $n$ et $u in cal(L)(E)$ un endomorphisme.
    Alors $chi_u (u) = 0$.
  ],
)

== Polynôme minimal

#definition([
  Soit $E$ un $KK$-espace vectoriel et $u in cal(L)(E)$ un endomorphisme.
  On appelle _polynôme minimal_ de $u$, noté $mu_u$, le polynôme unitaire non-nul de degré minimal dans $I_u$.
])

#proposition([
  Soit $E$ un $KK$-espace vectoriel et $u in cal(L)(E)$ un endomorphisme.
  Alors le polynôme minimal de $u$ divise tout élément de $I_u$.
])

#theorem([
  Soit $E$ un $KK$-espace vectoriel de dimension $n$ et $u in cal(L)(E)$ un endomorphisme.
  Alors $u$ est diagonalisable si et seulement si son polynôme minimal est simplement scindé.
])

= Réduction d'endomorphisme

== Décomposition de Dunford

#lemma([
  Soit $E$ un $KK$-espace vectoriel de dimension $n$ et $u, v in cal(L)(E)$ deux endomorphismes diagonalisables.
  Alors si $u$ et $v$ commutent, il existe une base $cal(E)$ de $E$ telle que $[u]_cal(E)$ et $[v]_cal(E)$ soient diagonales. On dit que $u$ et $v$ sont _codiagonalisables_.
])

#definition([
  Soit $E$ un $KK$-espace vectoriel de dimension $n$, $u in cal(L)(E)$ un endomorphisme, $lambda in KK$ une valeur propre de $u$ et $n_lambda$ sa multiplicité en tant que racine.
  On appelle _sous-espace caractéristique_ associé à $lambda$ l'ensemble
  $ N_lambda (u) := ker((u - lambda id)^(n_lambda)). $
])

#proposition([
  Soit $E$ un $KK$-espace vectoriel de dimension $n$ et $u in cal(L)(E)$ un endomorphisme de polynôme caractéristique scindé.
  Alors
  $ E = plus.circle.big_(lambda in spectrum(u)) N_lambda (u). $
])

#theorem(
  title: "Décomposition de Dunford",
  [
    Soit $E$ un $KK$-espace vectoriel de dimension $n$ et $u in cal(L)(E)$ un endomorphisme de polynôme caractéristique scindé.
    Alors il existe $d, v in cal(L)(E)$ tels que $u = d + v$ vérifiant les propriétés suivantes
    - $d$ est diagonalisable,
    - $v$ est nilpotent,
    - $d$ et $v$ commutent.
  ],
)

== Réduction de Jordan

#proposition([
  Soit $E$ un $KK$-espace vectoriel de dimension $n$ et $u in cal(L)(E)$ un endomorphisme.
  Alors il existe un unique $r in NN$ tel que
  $
    { 0 } = ker(u^0) subset.neq ker(u) subset.neq ... subset.neq ker(u^r) = ker(u^(r+1)) = ...
  $
]) <prop-indice>

#definition([
  Soit $E$ un $KK$-espace vectoriel de dimension $n$ et $u in cal(L)(E)$ un endomorphisme.
  On appelle _indice_ de $u$ l'entier vérifiant la @prop-indice.
])

#remark([
  L'indice de $u$ est aussi
  - le plus petit $r in NN$ vérifiant $ker(u^r) = ker(u^(r+1))$,
  - si $u$ est nilpotent, le plus petit $r in NN$ vérifiant $u^r = 0$,
  - le nombre $r in NN$ vérifiant $E = im(u^r) plus.circle ker(u^r)$ et
    $
      E = im(u^0) supset.neq im(u) supset.neq ... supset.neq im(u^r) = im(u^(r+1)) = ...
    $
])

#theorem([
  Soit $E$ un $KK$-espace vectoriel de dimension $n$, $u in cal(L)(E)$ un endomorphisme de polynôme caractéristique scindé et $lambda in KK$ une valeur propre de $u$.
  Alors la multiplicité de $lambda$ en tant que racine est donnée par l'indice de l'endomorphisme $u - lambda id$.
])

#definition([
  Soit $lambda in KK$ et $k in NN$. On appelle _bloc de Jordan_ la matrice de la forme
  $
    J_(k)( lambda ) := mat(
      lambda, 1, 0, dots.c, 0;
      0, lambda, dots.down, dots.down, dots.v;
      dots.v, dots.down, dots.down, dots.down, 0;
      dots.v, dots.down, dots.down, lambda, 1;
      0, dots.c, dots.c, 0, lambda
    ).
  $
  Soit $lambda_1, ..., lambda_r in KK$ et $k_1, ..., k_r in NN$. On appelle _matrice de Jordan_ la matrice de la forme
  $
    J := mat(
      J_(k_1)(lambda_1), 0, dots.c, 0;
      0, J_(k_2)(lambda_2), dots.down, dots.v;
      dots.v, dots.down, dots.down, 0;
      0, dots.c, 0, J_(k_r)(lambda_r)
    ).
  $
])

#theorem(
  title: "Réduction de Jordan d'un endomorphisme nilpotent",
  [
    Soit $E$ un $KK$-espace vectoriel de dimension $n$ et $u in cal(L)(E)$ un endomorphisme nilpotent.
    Alors il existe une base $cal(E)$ de $E$ et des entiers $k_1, ..., k_r in NN$ tels que
    $
      [ u ]_cal(E) = mat(
      J_(k_1)(0), 0, dots.c, 0;
      0, J_(k_2)(0), dots.down, dots.v;
      dots.v, dots.down, dots.down, 0;
      0, dots.c, 0, J_(k_r)(0)
    ).
    $
  ],
)

#theorem(
  title: "Réduction de Jordan d'un endomorphisme",
  [
    Soit $E$ un $KK$-espace vectoriel de dimension $n$ et $u in cal(L)(E)$ un endomorphisme de polynôme caractéristique simplement scindé.
    Alors il existe une base $cal(E)$ de $E$, des nombres $lambda_1, ..., lambda_r in KK$ et $k_1, ..., k_r in NN$ tels que
    $
      [ u ]_cal(E) = mat(
      J_(k_1)(lambda_1), 0, dots.c, 0;
      0, J_(k_2)(lambda_2), dots.down, dots.v;
      dots.v, dots.down, dots.down, 0;
      0, dots.c, 0, J_(k_r)(lambda_r)
    ).
    $

  ],
)


#pagebreak()

= Formes bilinéaires

#definition([
  Soit $E$ un $KK$-espace vectoriel et $func(Phi, E times E, E)$ une application. On dit que $Phi$ est une _forme bilinéaire_, si pour tout $x in E$, les applications $y |-> Phi(x, y)$ et $y |-> Phi(y, x)$ sont linéaires.
])

== Ecriture dans une base

#definition([
  Soit $E$ un $KK$-espace vectoriel, $cal(E) = (e_1, ..., e_n)$ une base de $E$ et $func(Phi, E times E, E)$ une forme bilinéaire. On appelle _matrice_ de $Phi$ dans la base $cal(E)$, la matrice
  $ [Phi]_cal(E) := (Phi(e_i, e_j))_(1 <= i, j <= n). $
])

#proposition([
  Soit $E$ un $KK$-espace vectoriel, $cal(E) = (e_1, ..., e_n)$ une base de $E$ et $func(Phi, E times E, E)$ une forme bilinéaire. Alors par bilinéarité
  $
    forall x = (x_1, ..., x_n), y = ( y_1, ..., y_n ) in E, Phi(x, y) = sum_(1 <= i, j <= n) x_i y_j Phi(e_i, e_j) = transpose([x]_cal(E)) [ Phi ]_cal(E) [y]_cal(E).
  $
])

#proposition([
  Soit $E$ un $KK$-espace vectoriel, $cal(E)$ et $cal(F)$ deux bases de $E$, et $func(Phi, E times E, E)$ une forme bilinéaire. Alors
  $
    [Phi]_(cal(F)) = transpose(cal(P)_(cal(E))^cal(F)) [ Phi ]_cal(E) cal(P)_cal(E)^(cal(F)).
  $
])

== Dualité

#definition([
  Soit $E$ un $KK$-espace vectoriel de dimension $n$. On appelle _dual_ de $E$, noté $E^*$, l'ensemble des formes linéaires sur $E$. Si $cal(E) = (e_1, ..., e_n)$ est une base de $E$, on appelle _base duale_, la famille $cal(E)^* = (e_1^*, ..., e_n^*)$ telle que
  $
    forall i, j in {1, ..., n}, e_i^* ( e_j ) := delta_(i, j) = cases(1 "si" i = j, 0 "sinon").
  $
])

#proposition([
  Soit $E$ un $KK$-espace vectoriel de dimension $n$. Soit $func(u, E, KK)$ une forme linéaire, alors
  $ u = sum_(i=1)^n u(e_i) e_i^* $
  Soit $f$ un élément de $E$, alors
  $ f = sum_(i=1)^n e_i^* (f) e_i. $
])

#definition([
  Soit $E$ un $KK$-espace vectoriel et $cal(F) = (f_1, ..., f_n)$ une base de $E^*$. On appelle _base antéduale_, l'unique base $cal(E) = (e_1, ..., e_n)$ de $E$ telle que $cal(E)^* = cal(F)$.
])

#definition([
  Soit $E$ un $KK$-espace vectoriel et $func(Phi, E times E, KK)$ une forme bilinéaire. On appelle _application linéaire associée_ à $Phi$, l'application
  $ func(u_Phi, E, E^*, x, (y |-> Phi(x, y))). $
])

== Forme bilinéaire symétrique et forme quadratique

#definition([
  Soit $E$ un $KK$-espace vectoriel et $func(Phi, E times E, KK)$ une forme bilinéaire. On dit que $Phi$ est _symétrique_, si
  $ forall (x, y) in E times E, Phi(x, y) = Phi(y, x). $
])

#definition([
  Soit $E$ un $KK$-espace vectoriel et $func(Q, E, KK)$ une application. On dit que $Q$ est une _forme quadratique_, s'il existe une forme bilinéaire symétrique $func(Phi, E times E, KK)$ telle que
  $ forall x in E, Q(x) = Phi(x, x) $
  dans ce cas, on dit que $Q$ est la _forme quadratique associée_ à $Phi$.
])

#proposition(
  title: "Formule de polarisation",
  [
    Soit $E$ un $KK$-espace vectoriel, $func(Phi, E times E, KK)$ une forme bilinéaire et $func(Q, E, KK)$ la forme quadratique associée à $Phi$. Alors
    $
      forall (x, y) in E times E, Phi(x, y) = 1 / 2( Q(x + y) - Q(x) - Q(y) ) = 1 / 4(Q(x + y) - Q(x - y)).
    $
  ],
) <prop-form-polar>

#remark([
  Soit $E$ un $KK$-espace vectoriel et $func(Q, E, KK)$ une forme quadratique. Alors d'après la @prop-form-polar, $Q$ détermine une forme bilinéaire symétrique, on l'appelle _forme polaire associée_ à $Q$.
])

#remark([
  Soit $E$ un $KK$-espace vectoriel et $func(Phi, E times E, KK)$ une forme bilinéaire symétrique. Alors sa matrice dans la base canonique est symétrique.
])

== Forme quadratique définie

#definition([
  Soit $E$ un $KK$-espace vectoriel et $func(Phi, E times E, KK)$ une forme bilinéaire symétrique.
  On dit que $Phi$ est _non-dégénérée_ si
  $ forall x in E, (forall y in E, Phi(x, y) = 0) => x = 0. $
])

#definition([
  Soit $E$ un $KK$-espace vectoriel et $func(Phi, E times E, KK)$ une forme bilinéaire symétrique.
  On dit que $Phi$ est _définie_ si
  $ forall x in E, Phi(x, x) = 0 => x = 0. $
])

#proposition([
  Soit $E$ un $KK$-espace vectoriel et $func(Phi, E times E, KK)$ une forme bilinéaire symétrique.
  Alors si $Phi$ est définie, elle est non-dégénérée.
])

#definition([
  Soit $E$ un $KK$-espace vectoriel et $func(Phi, E times E, KK)$ une forme bilinéaire symétrique définie.
  - On dit que $Phi$ est _définie positive_ si
    $ forall x in E without {0}, Phi(x, x) > 0. $
  - On dit que $Phi$ est _définie négative_ si
    $ forall x in E without {0}, Phi(x, x) < 0. $
])

#proposition([
  Soit $E$ un $KK$-espace vectoriel et $func(Phi, E times E, KK)$ une forme bilinéaire symétrique définie.
  Alors $Q$ est soit définie positive, soit définie négative.
])

#remark([
  On étend toutes les énoncés précédents aux formes quadratiques avec leur forme polaire associée.
])


== Réduction d'une forme quadratique

#theorem([
  Soit $E$ un $KK$-espace vectoriel de dimension $n$ et $func(Q, E, KK)$ une forme quadratique.
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
    Soit $E$ un $KK$-espace vectoriel de dimension $n$ et $func(Q, E, KK)$ une forme quadratique.
    Alors le nombre $m$ de formes linéaires indépendantes qui interviennent dans une décomposition de $Q$ est égal au rang de la forme polaire de $Q$.

  ],
)

#theorem(
  title: [d'inertie de Sylvester dans $RR$],
  [
    Soit $E$ un $RR$-espace vectoriel de dimension $n$ et $func(Q, E, RR)$ une forme quadratique.
    Soit
    $
      Q = a_1 f_1^2 + ... + a_s f_s^2 - a_(s+1) f_(s+1)^2 - ... - a_(s+t) f_(s+t)^2
    $
    une décomposition de $Q$ en sommes de carrés telle que $forall i in {1, ..., s+t}, a_i > 0$.
    Alors les nombres $s$ et $t$ ne dépendent que de $Q$.
  ],
) <thm-sylv-r>

#definition([
  Soit $E$ un $KK$-espace vectoriel de dimension $n$ et $func(Q, E, KK)$ une forme quadratique.
  On appelle _signature_ de $Q$, le couple $(s, t)$ du @thm-sylv-r.
])

#pagebreak()

= Espaces euclidiens

#definition([
  Soit $E$ un $RR$-espace vectoriel.
  On appelle _produit scalaire_ sur $E$, noté $innerproduct(dot, dot)$, une forme bilinéaire symétrique définie positive.
  Si $E$ est de dimension finie, on appelle _espace euclidien_ le couple $(E, innerproduct(dot, dot))$.
])

#definition([
  Soit $(E, innerproduct(dot, dot))$ un espace euclidien.
  On appelle _norme associée au produit scalaire_, l'application $func(||dot||, E, RR_+, x, sqrt(innerproduct(x, x)))$.
])

== Norme d'un vecteur

#theorem(
  title: "Inégalité de Cauchy-Schwarz",
  [
    Soit $(E, innerproduct(dot, dot))$ un espace euclidien.
    Alors
    $ forall x, y in E, |innerproduct(x, y)| <= ||x||||y|| $
    avec égalité si et seulement si les deux éléments sont liés.
  ],
)

#proposition([
  Soit $(E, innerproduct(dot, dot))$ un espace euclidien.
  Alors l'application $||dot||$ est une norme.
])

== Orthogonalité, base orthogonale et base orthonormée

#definition([
  Soit $(E, innerproduct(dot, dot))$ un espace euclidien et $x, y in E$.
  On dit que $x$ et $y$ sont _orthogonaux_, noté $x perp y$, si $innerproduct(x, y) = 0$.
])

#definition([
  Soit $(E, innerproduct(dot, dot))$ un espace euclidien et $F$ un sous-ensemble de $E$.
  On appelle _orthogonal_ de $F$, noté $F^perp$, l'ensemble
  $ F^perp := {x in E | forall y in F, innerproduct(x, y) = 0}. $
])

#notation([
  Soit $(E, innerproduct(dot, dot))$ un espace euclidien et $x in E$.
  On note $x^perp := {x}^perp$.
])

#proposition([
  Soit $(E, innerproduct(dot, dot))$ un espace euclidien et $F$ un sous-ensemble de $E$.
  Alors $F^perp$ est un sous-espace vectoriel de $E$.
])

#proposition([
  Soit $(E, innerproduct(dot, dot))$ un espace euclidien et $x, y in E$. Alors
  $
    x perp y <=> ||x+y||^2 = ||x||^2 + ||y||^2 <=> ||x-y||^2 = ||x||^2 + ||y||^2.
  $
])

#proposition([
  Soit $(E, innerproduct(dot, dot))$ un espace euclidien et $x in E without {0}$. Alors $span(x)^perp = x^perp$ et
  $ E = span(x) plus.circle x^perp. $
])

#definition([
  Soit $(E, innerproduct(dot, dot))$ un espace euclidien et $cal(E) = (e_1, ..., e_n)$ une base de $E$.
  - On dit que $cal(E)$ est _orthogonale_ si elle vérifie
    $ forall i, j in {1, ..., n}, i != j => innerproduct(e_i, e_j) = 0. $
  - On dit que $cal(E)$ est _orthonormée_ si elle vérifie
    $ forall i, j in {1, ..., n}, innerproduct(e_i, e_j) = delta_(i, j). $
])

#remark([
  Soit $(E, innerproduct(dot, dot))$ un espace euclidien et $cal(E) = (e_1, ..., e_n)$ une base orthogonale de $E$.
  Alors la famille $(e_1/(||e_1||), ..., e_n/(||e_n||))$ est une base orthonormée de $E$.
])

#theorem([
  Soit $(E, innerproduct(dot, dot))$ un espace euclidien.
  Alors il existe une base orthonormée de $E$.
])

#proposition([
  Soit $(E, innerproduct(dot, dot))$ un espace euclidien et $F$ un sous-espace vectoriel de $E$. Alors
  + $E = F plus.circle F^perp$,
  + $dim(F^perp) = dim(E) - dim(F)$,
  + $(F^perp)^perp = F$.
])

#theorem(
  title: "Procédé d'orthogonalisation de Gram-Schmidt",
  [
    Soit $(E, innerproduct(dot, dot))$ un espace euclidien et $(e_1, ..., e_n)$ une base de $E$.
    Alors il existe une base orthonormée $(f_1, ..., f_n)$ de $E$ telle que
    $ forall k in {1, ..., n}, span(e_1, ..., e_k) = span(f_1, ..., f_k). $
  ],
)

#proof([
  On raisonne par récurrence sur le cardinal $k$ de la famille.
  - Pour $k = 1$, on pose $f_1 := e_1/(||e_1||)$.
  - Pour $k > 1$, supposons qu'il existe une famille orthonormée $(f_1, ..., f_(k-1))$ telle que
    $ span(e_1, ..., e_(k-1)) = span(f_1, ..., f_(k-1)) $
    alors on pose $f'_k := e_k - sum_(i=1)^(k-1) innerproduct(e_k, f_i) f_i$. Soit $j in {1, ..., k-1}$, alors
    $
      innerproduct(f'_k, f_j) &= innerproduct(e_k - sum_(i=1)^(k-1) innerproduct(e_k, f_i) f_i, f_j)
    $
    et par bilinéarité du produit scalaire
    $
      innerproduct(f'_k, f_j) &= innerproduct(e_k, f_j) - sum_(i=1)^(k-1) innerproduct(e_k, f_i) innerproduct(f_i, f_j) \
      &= innerproduct(e_k, f_j) - sum_(i=1)^(k-1) innerproduct(e_k, f_i) delta_(i, j) \
      &= innerproduct(e_k, f_j) - innerproduct(e_k, f_j) = 0.
    $
    Enfin on pose $f_k := (f'_k)/(||f'_k||)$, donc la famille $(f_1, ..., f_k)$ est orthonormée et vérifie l'égalité.
])

== Le groupe orthogonal

#definition([
  Soit $A in GL_n (RR)$ une matrice inversible. On dit que $A$ est _orthogonale_ si $transpose(A) = A^(-1)$. On appelle _groupe orthogonal_, le sous-groupe
  $ O_n (RR) := {A in GL_n (RR) | A transpose(A) = transpose(A) A = I_n}. $
])

#remark([
  Soit $A in O_n (RR)$ une matrice orthogonale. Alors on remarque que $det(A) = plus.minus 1$, on appelle _groupe spécial orthogonal_, le sous-groupe
  $ S O_n (RR) := O_n (RR) inter "det"^(-1)(1). $
])

#definition([
  Soit $(E, innerproduct(dot, dot))$ un espace euclidien et $f in cal(L)(E)$ un endomorphisme.
  On dit que $f$ est un _endomorphisme orthogonal_ si
  $ forall x, y in E, innerproduct(f(x), f(y)) = innerproduct(x, y). $
  On appelle _groupe orthogonal_, noté $O(E)$, le sous-groupe des endomorphismes orthogonaux.
])

#proposition([
  Soit $(E, innerproduct(dot, dot))$ un espace euclidien et $f in cal(L)(E)$ un endomorphisme. Alors les énoncés suivants sont équivalents
  + $f$ est orthogonal.
  + Soit $x in E$, alors $||f(x)|| = ||x||$.
  + Soit $cal(E)$ une base orthonormée de $E$, alors $[f]_cal(E) in O_n (RR)$.
  + Il existe $cal(E)$ une base orthonormée de $E$, telle que $[f]_cal(E) in O_n (RR)$.
])

#remark([
  Soit $(E, innerproduct(dot, dot))$ un espace euclidien et $f in cal(L)(E)$ un endomorphisme orthogonal.
  Alors on remarque que $det(f) = plus.minus 1$, on appelle _groupe spécial orthogonal_ le sous-groupe
  $ S O(E) := O(E) inter "det"^(-1)(1). $
])

== Polynômes orthogonaux

#proposition([
  Soit $[a, b]$ un intervalle fermé de $RR$ et $func(w, [a, b], R_+ without {0})$. Alors la forme bilinéaire symétrique définie par
  $ forall P, Q in RR[X], innerproduct(P, Q) := integral_a^b P(t)Q(t)w(t) dif t $
  est un produit scalaire.
])

#proof([
  Soit $P in RR[X]$, alors $P^2 w$ est continue et positive, de plus
  $
    innerproduct(P, P) = 0 &=> integral_a^b P^2 (t) w(t) = 0 \
    &=> forall t in [a, b], P^2 (t) w(t) = 0 \
    &=> forall t in [a, b], P(t) = 0 \
    &=> P = 0
  $
  donc $innerproduct(dot, dot)$ est un produit scalaire.
])

#definition([
  Soit $innerproduct(dot, dot)$ un produit scalaire sur $RR[X]$. On appelle _famille de polynômes orthogonaux_, une famille $(P_n)_(n in NN)$ de polynômes qui vérifie
  $
    cases(forall i"," j in NN"," i != j => innerproduct(P_i, P_j) = 0, forall n in NN"," deg(P_n) = n)
  $
])

#proposition([
  Soit $(P_n)_(n in NN)$ et $(Q_n)_(n in NN)$ deux familles de polynômes orthogonaux.
  Soit $n in NN$, alors $P_n$ et $Q_n$ sont colinéaires.
])

#proof([
  $P_n$ et $Q_n$ appartiennent à la même droite $RR_n [X] inter RR_n [X]^perp$.
])

#definition([
  Soit $n in NN$ et $p_n in cal(L)(RR_n [X])$ la projection orthogonale sur $RR_(n-1) [X]$. On pose l'application $func(T_n, RR_(n-1) [X], RR_(n-1) [X], P, p_n (X P))$.
])

#proposition([
  Soit $(P_n)_(n in NN)$ une famille de polynômes orthogonaux.
  Soit $n in NN$, alors $T_n$ est symétrique et son spectre est de cardinal $n$.
  Soit $lambda$ une valeur propre de $T_n$, alors $lambda$ est racine de $P_n$ et l'espace propre associé est la droite engendrée par le quotient de $P_n$ par $X - lambda$.
])

#proof([
  Soit $P, Q in RR_(n-1) [X]$, alors
  $
    innerproduct(T_n (P), Q) &= innerproduct(p_n (X P), Q) \
    &= innerproduct(x P, p_n (Q)) \
    &= innerproduct(x P, Q) \
    &= innerproduct(P, X Q)
    = innerproduct(P, T_n (Q))
  $
  donc $T_n$ est symétrique.
])


== Endomorphismes symétriques

#notation([
  Soit $(E, innerproduct(dot, dot))$ un espace euclidien et $u in cal(L)(E)$ un endomorphisme.
  On note $func(theta_u, E, E^*)$, l'application définie par
  $ forall y in E, theta_u (y) := x |-> innerproduct(u(x), y). $
])

#definition([
  Soit $(E, innerproduct(dot, dot))$ un espace euclidien et $u in cal(L)(E)$ un endomorphisme.
  On appelle _application transposée_ (ou _adjoint_) de $u$, l'application définie par $u^* := theta^(-1)_id compose theta_u$.
])

#proposition([
  Soit $(E, innerproduct(dot, dot))$ un espace euclidien et $u in cal(L)(E)$ un endomorphisme.
  Alors
  $ forall x, y in E, innerproduct(x, u^*(y)) = innerproduct(u(x), y). $
  Soit $cal(E)$ une base orthonormée de $E$, on a $[u^*]_cal(E) = transpose([u]_cal(E))$.
])

#proof([
  Soit $x, y in E$. Alors
  $
    innerproduct(x, u^*(y)) = theta_id (u^*(y))(x) = (theta_id compose u^*)(y)( x ) = theta_u (y)(x) = innerproduct(u(x), y).
  $
])

#definition([
  Soit $(E, innerproduct(dot, dot))$ un espace euclidien et $u in cal(L)(E)$ un endomorphisme.
  On dit que $u$ est _symétrique_ (ou _auto-adjoint_), si $u^* = u$.
])

#proposition([
  Soit $(E, innerproduct(dot, dot))$ un espace euclidien et $u in cal(L)(E)$ un endomorphisme.
  Alors $u$ est symétrique si et seulement si sa matrice dans une base orthonormée de $E$ est symétrique.
])

#proposition([
  Soit $M in cal(M)_n (RR)$ une matrice symétrique.
  Alors toutes les valeurs propres complexes de $M$ sont réelles.
])

#proof([
  Soit $lambda in CC$ une valeur propre de $M$ et $X$ un vecteur propre associé.
  On a $M X = lambda X$, en passant au conjugué $M overline(X) = overline(lambda) thin overline(X)$, et en passant à la transposée $transpose(overline(X)) M = overline(lambda) thin transpose(overline(X))$. En multipliant par $X$ on obtient
  $
    lambda transpose(overline(X)) X
    = transpose(overline(X)) (M X)
    = (transpose(overline(X)) M) X
    = overline(lambda) thin transpose(overline(X)) X
  $
  or $transpose(overline(X)) X > 0$, on en déduit que $lambda = overline(lambda)$ est un nombre réel.
])

#theorem([
  Soit $(E, innerproduct(dot, dot))$ un espace euclidien et $u in cal(L)(E)$ un endomorphisme.
  Alors $u$ est diagonalisable dans une base orthonormée de $E$.
])

#theorem([
  Soit $M in cal(M)_n (RR)$ une matrice symétrique. Alors il existe une matrice orthogonale $P$ telle que $transpose(P) M P$ soit diagonale.
])

#corollary([
  Soit $(E, innerproduct(dot, dot))$ un espace euclidien, $Q$ une forme quadratique définie positive sur $E$ et $lambda_1 <= ... <= lambda_n$ ses valeurs propres ordonnées. Alors
  $ forall x in E, lambda_1||x||^2 <= Q(x) <= lambda_n||x||^2 $
  et ces inégalités sont optimales.
])
