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
  Soit $E$ un $KK$-espace vectoriel, $cal(E) = (e_1, ..., e_n)$ une base de $E$ et $fun(Phi, E times E, E)$ une application bilinéaire. On appelle _matrice_ de $Phi$ dans la base $cal(E)$, la matrice
  $ [Phi]_cal(E) := (Phi(e_i, e_j))_(1 <= i, j <= n). $


])

#proposition([
  Soit $E$ un $KK$-espace vectoriel, $cal(E) = (e_1, ..., e_n)$ une base de $E$ et $fun(Phi, E times E, E)$ une application bilinéaire. Alors par bilinéarité
  $
    forall x = (x_1, ..., x_n), y = (y_1, ..., y_n) in E, Phi(x, y) = sum_(1 <= i, j <= n) x_i y_j Phi(e_i, e_j) = transpose([x]_cal(E)) [
      Phi
    ]_cal(E) [y]_cal(E).
  $
])

#proposition([
  Soit $E$ un $KK$-espace vectoriel, $cal(E)$ et $cal(F)$ deux bases de $E$, et $fun(Phi, E times E, E)$ une application bilinéaire. Alors
  $
    [Phi]_(cal(F)) = transpose(cal(P)_(cal(E))^cal(F)) [Phi]_cal(E) cal(P)_cal(E)^(cal(F)).
  $
])

== Dualité

#definition([
  Soit $E$ un $KK$-espace vectoriel de dimension $n$. On appelle _dual_ de $E$, noté $E^*$, l'ensemble des formes linéaires sur $E$. Si $cal(E) = (e_1, ..., e_n)$ est une base de $E$, on appelle _base duale_, la famille $(e_1^*, ..., e_n^*)$ telle que
  $ forall i, j in {1, ..., n}, e_i^* (e_j) := delta_(i, j) = cases(1 "si" i = j, 0 "sinon"). $
])
