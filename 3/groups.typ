#import "../template.typ": *

#show: maths.with(title: "Théorie des groupes", color: "#718355")

= Groupes

#definition[
  Soit $G$ un ensemble et $fun(star, G times G, G)$ une loi de composition interne. On dit que le couple $(G, star)$ forme un _groupe_ s'il vérifie les propriétes suivantes
  + la loi $star$ est associative, $forall x, y, z in G, (x star y) star z = x star (y star z)$,
  + il existe un neutre $e_G in G$, $forall x in G, x star e_G = e_G star x = x$,
  + existence d'un inverse, $forall x in G, exists x^(-1) in G, x star x^(-1) = x^(-1) star x = e_G$.
]

#example[
  Le couple $(ZZ, +)$ est un groupe, le neutre est $0$ et pour $n in ZZ$ un inverse est $-n$.
  Le couple $(RR, dot)$ n'est pas un groupe, $0$ n'admet pas d'inverses.
]

#proposition[
  Soit $(G, star)$ un groupe. Alors
  + le neutre $e_G$ est unique,
  + soit $x in G$, alors son inverse $x^(-1)$ est unique.
]

#proof[
  + Soit $e in G$ vérifiant $forall x in G, x star e = e star x = x$. Alors
    $ e = e star e_G = e_G. $
  + Soit $y in G$ vérifiant $x star y = y star x = e_G$. Alors
    $
      y = e_G star y = (x^(-1) star x) star y = x^(-1) star (
        x star y
      ) = x^(-1) star e_G = x^(-1).
    $
]

#definition[
  Soit $(G, star)$ un groupe. On dit qu'il est _commutatif_ ou _abélien_ s'il vérifie
  $ forall x, y in G, x star y = y star x. $
]

#example[
  Le groupe $(ZZ, +)$ est commutatif.
]

#definition[
  Soit $(G, star)$ un groupe. On appelle _ordre_ de $G$ le cardinal de $G$, si $G$ est un ensemble fini on dit que $G$ est d'_ordre fini_, sinon on dit que $G$ est d'_ordre infini_.
]

#remark[
  Soit $(G, star)$ un groupe d'ordre fini. On note $G = {e_G, g_1, ..., g_n}$, alors on peut donner sa table de multiplication
  #align(
    center,
    table(
      columns: 7,
      align: center,
      inset: 6pt,
      [$star$], [$e_G$], [$g_1$], [$dots.c$], [$g_j$], [$dots.c$], [$g_n$],
      [$e_G$], [$e_G$], [$g_1$], [$dots.c$], [$g_j$], [$dots.c$], [$g_n$],
      [$g_1$],
      [$g_1$],
      [$g_1 star g_1$],
      [$dots.c$],
      [$g_1 star g_j$],
      [$dots.c$],
      [$g_1 star g_n$],

      [$dots.v$],
      [$dots.v$],
      [$dots.v$],
      [$dots.down$],
      [$dots.v$],
      [$dots.up$],
      [$dots.v$],

      [$g_i$],
      [$g_i$],
      [$g_i star g_1$],
      [$dots.c$],
      [$g_i star g_j$],
      [$dots.c$],
      [$g_i star g_n$],

      [$dots.v$],
      [$dots.v$],
      [$dots.v$],
      [$dots.up$],
      [$dots.v$],
      [$dots.down$],
      [$dots.v$],

      [$g_n$],
      [$g_n$],
      [$g_n star g_1$],
      [$dots.c$],
      [$g_n star g_j #h(0.01em)$],
      [$dots.c$],
      [$g_n star g_n$],
    ),
  )
]
où chaque ligne et chaque colonne contient tous les éléments de $G$.

#notation[
  Soit $(G, star)$ un groupe. Lorsqu'il ne peut pas y avoir de confusions, on notera
  - $e := e_G$ pour le neutre,
  - $forall x, y in G, x y := x star y$ pour la loi $star$,
  - $forall x in G, forall n in ZZ, "si" n > 0, x^n := attach(limits(underbrace(x star ... star x)), b: "n fois"), "si" n= 0, x^0 := e, "si" n < 0, x^n := x^(-1) star ... star x^(-1).$
]

#pagebreak()

= Sous-groupes

== Définitions

#definition[
  Soit $(G, star)$ un groupe et $H$ un sous-ensemble de $G$. On dit que $H$ est un _sous-groupe_ de $G$, noté $H < G$, s'il vérifie les propriétés suivantes
  + le neutre appartient à $H$, $e in H$,
  + $H$ est stable par $star$, $forall x, y in H, x star y in H$,
  + $H$ est stable par inverse, $forall x in H, x^(-1) in H$.
]

#definition[
  Soit $(G, star)$ un groupe et $H$ un sous-groupe de $G$. On dit que $H$ est _distingué_ ou _normal_, noté $H lt.tri G$, s'il vérifie
  $ forall g in G, forall h in H, g star h star g^(-1) in H. $
]

#proposition[
  Soit $(G, star)$ un groupe et $H$ un sous-ensemble de $G$. Alors $H$ est un sous-groupe de $G$ si et seulement s'il vérifie les propriétés suivantes
  + le neutre appartient à $H$, $e in H$,
  + $H$ est stable par $star$ et par inverse, $forall x, y in H, x star y^(-1) in H$.
] <prop-sg-condense>

#proof[
  #linebreak()
  $arrow.r.double$ : Supposons que $H$ est un sous-groupe de $G$. Alors
  + le neutre appartient à $H$,
  + soit $x, y in H$, alors $y^(-1) in H$ et $x star y^(-1) in H$.
  $arrow.l.double$ : Supposons que $H$ vérifie les deux propriétés. Alors
  1. le neutre appartient à $H$,
  3. soit $x in H$, alors $x^(-1) = e star x^(-1) in H$,
  2. soit $x, y in H$, alors $y^(-1) in H$ et $x star y = x star (y^(-1))^(-1) in H$.
]

#proposition[
  Soit $(G, star)$ un groupe et $H$ un sous-ensemble de $G$. Alors $H$ est un sous-groupe de $G$ si et seulement s'il vérifie les propriétés suivantes
  + $H$ est stable par $star$, $forall x, y in H, x star y in H$,
  + le couple $(H, star)$ forme un groupe.
]

#proof[
  #linebreak()
  $arrow.r.double$ : Supposons que $H$ est un sous-groupe de $G$. Alors
  + $H$ est stable par $star$, $forall x, y in H, x star y in H$,
  + On considère le couple $(H, star)$,
    + soit $x, y, z in H$, alors $x, y, z in G$ donc $(x star y) star z = x star (y star z)$,
    + on pose $e_H = e_G$, alors $e_H in H$,
    + soit $x in H$, alors $x^(-1) in H$.
    #v(-5pt) Donc $(H, star)$ forme un groupe.
  $arrow.l.double$ : Supposons que $H$ vérifie les deux propriétés. Alors
  + soit $x in H$, alors $x in G$ et $x star e_G = x = x star e_H$, en multipliant à gauche par $x^(-1) in G$, on obtient donc $e_G = e_H in H$.
  + $H$ est stable par $star$,
  + soit $x in H$, alors $x^(-1) in H$.
]

#proposition[
  Soit $(G, star)$ un groupe et $H_1, H_2$ deux sous-groupes de $G$. Alors $H_1 sect H_2$ est un sous-groupe de $G$.
] <prop-sect-sg>


#proof[
  + $e in H_1$ et $e in H_2$, donc $e in H_1 sect H_2$,
  + soit $x, y in H_1 sect H_2$, alors $x, y in H_1$, puisque $H_1$ est un sous-groupe de $G$ on a $x star y^(-1) in H_1$, de la même manière on a $x star y^(-1) in H_2$, donc $x star y^(-1) in H_1 sect H_2$.
  Donc d'après la @prop-sg-condense, $H_1 sect H_2$ est un sous-groupe de $G$.
]

== Générateurs

#definition[
  Soit $(G, star)$ un groupe et $S$ un sous-ensemble non-vide de $G$. On appelle _sous groupe engendré par $S$_, noté $gen(S)$, le plus petit sous-groupe de $G$ contenant $S$.
]

#notation[
  Si $S = {x_1, ..., x_n}$, on note $gen(x_1, ..., x_n) := gen(S)$.
]

#proposition[
  Soit $(G, star)$ un groupe et $S$ un sous-ensemble non-vide de $G$. Alors
  $ gen(S) = attach(limits(sect.big_(H < G)), b: S subset H) H $
  ou encore
  $gen(S) = {x_1 star ... star x_n | n in NN without {0}, forall i in {1, ..., n}, x_i in S "ou" x_i^(-1) in S}$.
]

#proof[
  Notons $F := {H < G | S subset H}$ et $H_S := sect.big_(H in F) H$. Puisque $G in F$, l'intersection est non-vide, et d'après la @prop-sect-sg, $H_S$ est un sous-groupe de $G$. De plus $H_S$ contient évidemment $S$. Enfin si $H_0$ est un sous-groupe de $G$ contenant $S$, on a $H_0 in F$, donc $H_0 subset H_S$. Donc $H_S$ est bien le plus petit sous-groupe de $G$ contenant $S$.

  Notons $K_S := {x_1 star ... star x_n | n in NN without {0}, forall i in {1, ..., n}, x_i in S "ou" x_i^(-1) in S}$. On remarque que $K_S$ est stable par multiplication, par inverse et contient le neutre de $G$, donc d'après la @prop-sg-condense, $K_S$ est un sous-groupe de $G$. De plus $G_S$ contient $S$, donc $gen(S) subset G_S$. Réciproquement, puisque $gen(S)$ est un groupe, on en déduit que $forall x in K_S, x in gen(S)$, donc $K_S subset gen(S)$. Par double inclusion $gen(S) = K_S$.
]

#definition[
  Soit $(G, star)$ un groupe et $S$ un sous-ensemble de $G$. Si $G = gen(S)$, on dit que $G$ est _engendré_ par $S$ et on appelle $S$ un _système de générateurs_ pour $G$.
  - Si $S$ est fini, on dit que $G$ est _finiment engendré_.
  - Si $S$ ne contient qu'un élément, on dit que $G$ est _monogène_, si de plus $G$ est fini, on dit que $G$ est _cyclique_.
]

#example[
  + Soit $(G, star)$ un groupe, $G$ a au moins un système de générateur $S := G$.
  + On considère le groupe $(ZZ, +)$, il est engendré par $NN$, et par ${1}$, donc il est monogène.
  + On considère le groupe $(qt(ZZ, n ZZ), +)$, il est engendré par ${overline(1)}$ et est fini, donc il est cyclique.
]

#proposition[
  On considère le groupe $(ZZ, +)$, alors
  + $forall n in ZZ, gen(n) = n ZZ$,
  + soit $H$ est un sous-groupe de $(ZZ, +)$, alors il existe $n in ZZ$ tel que $H = n ZZ$,
  + soit $a, b in ZZ$ avec $b != 0$, alors $b$ divise $a$ si et seulement si $gen(a) subset gen(b)$,
  + soit $a, b in ZZ without {0}$, alors $gen(a, b) = "pgcd"(a, b) ZZ$ et $gen(a) sect gen(b) = "ppcm"(a, b) ZZ$.
]

#proof[
  + Soit $n in ZZ$, alors $gen(n) = {k dot n | k in ZZ} = n ZZ$.
  +
    - Si $H = {0}$, alors $H = 0 ZZ$.
    - Sinon, $H without {0}$ est non-vide, on prend $n$ le plus petit entier strictement positif de $H$. \
      Puisque $n in H$, on a $n ZZ subset H$. Réciproquement, soit $m in H$, par division euclidienne il existe $q, r in ZZ$ tels que $m = n q + r$ et $0 <= r < n$, puisque $r = m - n q in H$, on a nécessairement $r = 0$, d'où $m in n ZZ$, donc $H subset n ZZ$.
      Donc $H = n ZZ$.
  + On sait que $b$ divise $a$ si et seulement il existe $q in ZZ$ tel que $a = b q$ si et seulement $a in gen(b)$ si et seulement si $gen(a) subset gen(b)$.
  + _TODO_ : Voir TD.
]

== Ordre d'un élément

#definition[
  Soit $(G, star)$ un groupe et $x in G$. On appelle _ordre de $x$_, noté $"ord"(x)$, le cardinal du sous-groupe engendré par ${x}$.
]

#proposition[
  Soit $(G, star)$ un groupe et $x in G$. Alors
  $ "ord"(x) = inf({d in NN without {0} | x^d = e}) $
  de plus si $n in ZZ$ vérifie $x^n = e$, alors $"ord"(x)$ divise $n$.
]

#proof[
  - Si $"ord"(x) = +oo$, supposons par l'absurde qu'il existe $d in NN without {0}$ tel que $x^d = e$. \
    Alors $gen(x) = {e, x, ..., x^(d-1)}$ est fini, d'où une contradiction.
  - Sinon $"ord"(x) in NN without {0}$. \
    Puisque $gen(x)$ est fini, il existe $m, n in NN without {0}$ tels que $n < m$ et $x^m = x^n$, alors $x^(m - n) = e$, donc l'ensemble ${d in NN without {0} | x^d = e}$ est non-vide.
    Posons $ d := inf({d in NN without {0} | x^d = e})$, puisque $x^d = e$, on obtient $gen(x) = {e, x, ..., x^(d - 1)}$, donc $"ord"(x) = |{e, x, ..., x^(d - 1)}| = d$.
  - Soit $n in ZZ$ tel que $x^n = e$. Par division euclidienne il existe $q, r in ZZ$ tels que $n = "ord"(x)q + r$ et $0 <= r < d$, alors $x^r = x^(n - "ord"(x)q) = x^n star x^"ord"(x)^(-q) = e$, par définition de $"ord"(x)$ on a nécessairement $r = 0$, donc $"ord"(x)$ divise $n$.
]

#pagebreak()

= Morphismes de groupes

== Définitions

#definition[
  Soit $(G, star)$ et $(H, dot)$ deux groupes. Une application $fun(phi, G, H)$ est un _morphisme de groupes_ si elle vérifie
  $ forall x, y in G, phi(x star y) = phi(x) dot phi(y). $
  - Si $H = G$, on dit que $phi$ est un _endomorphisme_.
  - Si $phi$ est une bijection, on dit que $phi$ est un _isomorphisme_, et $G$ et $H$ sont _isomorphes_, noté $G tilde.eq H$.
]

#proposition[
  Soit $(G, star)$ et $(H, dot)$ deux groupes, et $fun(phi, G, H)$ un morphisme de groupes.
  + le neutre est envoyé sur le neutre, $phi(e_G) = e_H$,
  + l'inverse est envoyé sur l'inverse, $forall x in G, phi(x^(-1)) = phi(x)^(-1)$.
]

#proof[
  + On a $phi(e_G) = phi(e_G star e_G) = phi(e_G) dot phi(e_G)$, donc $phi(e_G) = e_H$,
  + soit $x in G$, alors $e_H = phi(e_G) = phi(x star x^(-1)) = phi(x) dot phi(x^(-1))$, donc $phi(x^(-1)) = phi(x)^(-1)$.
]

#proposition[
  Soit $(G, star)$ et $(H, dot)$ deux groupes, et $fun(phi, G, H)$ un isomorphisme. Alors son inverse, noté $phi^(-1)$, est un isomorphisme.
]

#proof[
  Soit $x, y in H$. Puisque $phi$ est un morphisme de groupes on a
  $
    phi(phi^(-1)(x dot y)) = x dot y = phi(phi^(-1)(x)) dot phi(phi^(-1)(y)) = phi(phi^(-1)(x) star phi^(-1)(y))
  $
  et par injectivité de $phi$, on obtient $phi^(-1)(x dot y) = phi^(-1)(x) star phi^(-1)(y)$, donc $phi^(-1)$ est un morphisme.
]

#proposition[
  Soit $(G, star)$, $(H, dot)$ et $(K, square.tiny.filled)$ trois groupes, et $fun(phi, G, H)$ et $fun(psi, H, K)$ deux morphismes de groupes. Alors $psi compose phi$ est un morphisme de groupes.
]

#proof[
  Soit $x, y in G$. Alors
  $
    (psi compose phi)(x star y) &= psi(phi(x star y)) \
    &= psi(phi(x) dot phi(y)) \
    &= psi(phi(x)) med square.tiny.filled med psi(phi(y)) \
    &= (psi compose phi)(x) med square.tiny.filled med (psi compose phi)(y)
  $
  donc $psi compose phi$ est un morphisme de groupes.
]

#proposition[
  Soit $(G, star)$ et $(H, dot)$ deux groupes isomorphes. Alors
  + $G$ et $H$ ont le même ordre,
  + $G$ est abélien si et seulement si $H$ est abélien,
  + $G$ est monogène si et seulement si $H$ est monogène,
  + $forall fun(phi, G, H)$ isomorphisme, $forall x in G, "ord"(x) = "ord"(phi(x))$.
]

#proof[
  Soit $fun(phi, G, H)$ un isomorphisme.
  + $G$ et $H$ sont en bijection, donc $|G| = |H|$.
  + $arrow.r.double$ : Supposons que $G$ est abélien. Soit $x, y in H$, puisque $phi$ est un isomorphisme
    $
      phi^(-1)(x) star phi^(-1)(y) = phi^(-1)(y) star phi^(-1)(
        x
      ) => x dot y = y dot x
    $
    donc $H$ est abélien. \
    $arrow.l.double$ : On montre la réciproque de la même manière.
  + $arrow.r.double$ : Supposons que $G$ est monogène. Alors il existe $x in G$ tel que $G = gen(x)$, ainsi
    $ H = phi(G) = phi(gen(x)) = gen(phi(x)) $
    donc $H$ est monogène. \
    $arrow.r.double$ : On montre la réciproque de la même manière.
  + Soit $x in G$, alors $forall d in NN without {0}, x^d = e_G <=> phi(x)^d = e_H$, donc $"ord"(x) = "ord"(phi(x))$.
]

== Image et noyau

#definition[
  Soit $(G, star)$ et $(H, dot)$ deux groupes, et $fun(phi, G, H)$ un morphisme de groupes.
  - On appelle _image_ de $phi$ l'ensemble $im(phi) := phi(G)$.
  - On appelle _noyau_ de $phi$ l'ensemble $ker(phi) := phi^(-1)(e_H)$.
]

#proposition[
  Soit $(G, star)$ et $(H, dot)$ deux groupes, et $fun(phi, G, H)$ un morphisme de groupes. Alors $im(phi)$ est un sous-groupe de $H$ et $ker(phi)$ est un sous-groupe de $G$. Plus généralement si $G'$ est un sous groupe de $G$ et $H'$ un sous-groupe de $H$, alors $phi(G')$ est un sous-groupe de $H$ et $phi^(-1)(H')$ est un sous-groupe de $G$.
]

#proof[
  On considère $phi(G')$,
  + $e_H = phi(e_G)$, donc $e_H in phi(G')$,
  + soit $x, y in phi(G')$, il existe $u, v in G'$ tels que $x = phi(u)$ et $y = phi(v)$, alors
    $ x dot y^(-1) = phi(u) dot phi(y)^(-1) = phi(u star v^(-1)) $
    puisque $G'$ est un sous-groupe de $G$, on a $u star v^(-1) in G'$, donc $x dot y^(-1) in phi(G')$.
  D'après la @prop-sg-condense, $phi(G')$ est un sous-groupe de $H$.

  On considère $phi^(-1)(H')$,
  + $e_G = phi(e_H)$, donc $e_G in phi^(-1)(H')$.
  + soit $x, y in phi^(-1)(H')$, alors $phi(x), phi(y) in H'$ et
    $
      x star y^(-1) in phi^(-1)(
        H'
      ) <=> phi(x star y^(-1)) in H' <=> phi(x) dot phi(y)^(-1) in H'
    $
    puisque $H'$ est un sous-groupe de $H$, on a $phi(x) dot phi(y)^(-1) in H'$, donc $x star y^(-1) in phi^(-1)(H')$.
  D'après la @prop-sg-condense, $phi^(-1)(H')$ est un sous-groupe de $G$.
]

#proposition[
  Soit $(G, star)$ et $(H, dot)$ deux groupes, et $fun(phi, G, H)$ un morphisme de groupes.
  - $phi$ est surjectif si et seulement si $im(phi) = H$.
  - $phi$ est injectif si et seulement si $ker(phi) = {e_G}$.
]

#proof[
  - Par définition.
  - $arrow.r.double$ : Supposons que $phi$ est injectif. Soit $x in ker(phi)$, alors $phi(x) = e_H$, donc $x = e_G$. \
    $arrow.l.double$ : Supposons que $ker(phi) = {e_G}$. Soit $x, y in G$ tels que $f(x) = f(y)$, puisque $phi$ est un morphisme on a $f(x star y^(-1)) = e_H$, et $ker(phi) = e_G$ d'où $x star y^(-1) = e_G$, donc $x = y$ et $phi$ est injectif.
]

#pagebreak()

= Groupes symétriques

== Définitions

#definition[
  Soit $n in NN$. On appelle _groupe symétrique_, noté $S_n$, l'ensemble de toutes les bijections de ${1, ..., n}$ dans lui-même muni de la composition.
  - On appelle _permutations_ les éléments de $S_n$.
  - Soit $sigma$ une permutation, on la note
    $ sigma := mat(1, ..., n; sigma(1), ..., sigma(n)). $
]

#definition[
  Soit $sigma in S_n$ une permutation. On appelle _support_ de $sigma$ l'ensemble
  $ "supp"(sigma) := {i in {1, ..., n} | sigma(i) != i}. $
]

#lemma[
  Soit $sigma_1, sigma_2 in S_n$ deux permutations. Si $sigma_1$ et $sigma_2$ sont de supports disjoints, alors elles commutent.
]

#proof[
  Soit $i in {1, ..., n}$. Alors
  - si $i in.not "supp"(sigma_1) union "supp"(sigma_2)$, on a $(sigma_1 compose sigma_2)(i) = (sigma_2 compose sigma_1)(i) = i$,
  - si $i in "supp"(sigma_1)$, alors $i in.not "supp"(sigma_2)$ et $sigma_1 (i) in.not "supp"(sigma_2)$, et on a $(sigma_1 compose sigma_2)(i) = (sigma_2 compose sigma_1)(i) = i$,
  - si $i in "supp"(sigma_2)$, de la même manière $(sigma_1 compose sigma_2)(i) = (sigma_2 compose sigma_1)(i) = i$.
  Donc $sigma_1$ et $sigma_2$ commutent.
]

== $k$-cycles

#definition[
  Soit $a_1, ..., a_k in {1, ..., n}$ deux à deux distincts. On appelle _$k$-cycle_, noté $(a_1, ..., a_k)$, la permutation définie par
  $
    forall i in {1, ..., n}, (a_1, ..., a_k)(i) :=
    cases(
      a_(j+1) quad &"si" j in {1, ..., k - 1} "avec" i = a_j,
      a_1 quad &"si" i = a_k,
      i quad &"sinon"
      )
  $
  - On dit que $k$ est sa _longueur_.
  - On appelle _transposition_ un $2$-cycle.
]

#proposition[
  Soit $(a_1, ..., a_k) in S_n$ un $k$-cycle. Alors l'inverse de $(a_1, ..., a_k)$ est $(a_k, ..., a_1)$.
]

#proof[
  Soit $i in {1, ..., n}$. Alors
  - s'il existe $j in {1, ..., k - 1}$ tel que $i = a_j$, on a
    $
      (a_k, ..., a_1)((a_1, ..., a_k)(a_j)) = (a_k, ..., a_1)(
        a_(j+1)
      ) = a_j = i,
    $
  - si $i = a_k$, on a
    $ (a_k, ..., a_1)((a_1, ..., a_k)(a_k)) = (a_k, ..., a_1)(a_1) = a_k = i, $
  - sinon on a
    $ (a_k, ..., a_1)((a_1, ..., a_k)(i)) = (a_k, ..., a_1)(i) = i. $
  Donc $(a_k, ..., a_1)$ est l'inverse de $(a_1, ..., a_k)$.
]

#proposition[
  Soit $(a_1, ..., a_k) in S_n$ un $k$-cycle. Alors on peut l'écrire comme une composition de $k - 1$ transpositions.
]

#proof[
  On écrit $(a_1, ..., a_k) = (a_1, a_2) compose ... compose (a_(k-1), a_k)$.
]

== Permutations conjuguées

#definition[
  Soit $sigma_1, sigma_2 in S_n$ deux permutations. On dit que $sigma_1$ et $sigma_2$ sont conjuguées s'il existe $tau in S_n$ telle que $sigma_1 = tau compose sigma_2 compose tau^(-1)$.
]

#lemma[
  Soit $(a_1, ... , a_k) in S_n$ un $k$-cycle. Alors
  $
    forall sigma in S_n, sigma compose (a_1, ..., a_k) compose sigma^(-1) = (
      sigma(a_1), ..., sigma(a_k)
    )
  $
] <lem-cycle-conj>

#proof[
  Soit $sigma in S_n$. Soit $i in {1, ..., n}$, alors
  - s'il existe $j in {1, ..., k - 1}$ tel que $i = sigma(a_j)$, alors $sigma^(-1)(i) = a_j$ et on a
    $
      sigma((a_1, ..., a_k)(sigma^(-1)(i))) = sigma((a_1, ..., a_k)(a_j)) = sigma(a_(j+1)),
    $
  - si $i = sigma(a_k)$, alors $sigma^(-1)(i) = a_k$ et on a
    $
      sigma((a_1, ..., a_k)(sigma^(-1)(i))) = sigma((a_1, ..., a_k)(a_k)) = sigma(a_(1)),
    $
  - sinon on a
    $ sigma((a_1, ..., a_k)(sigma^(-1)(i))) = sigma(sigma^(-1)(i)) = i. $
  Donc $sigma compose (a_1, ..., a_k) compose sigma^(-1) = (sigma(a_1), ..., sigma(a_k))$.
]

#corollary[
  Soit $(a_1, ..., a_k) in S_n$ un $k$-cycle. Alors il est conjugué à $(1, ..., k)$.
] <cor-cycle-conj>

#proof[
  On prend $sigma in S_n$ telle que $forall i in {1, ..., k}, sigma(a_i) = i$.
]

#theorem[
  Soit $sigma in S_n$ une permutation. On peut écrire $sigma$ comme une composition de cycles à supports disjoints $tau_1, ..., tau_m in S_n$. De plus cette écriture est unique à l'ordre des cycles près, et leurs longueurs $k_1, ..., k_m$ vérifient $sum_(l=1)^(m) k_l = n$.
]

#proof[
  On raisonne par récurrence sur le cardinal de $"supp"(sigma)$.
  - Pour $|"supp"(sigma)| = 0$, on a $sigma = id$.
  - Pour $|"supp"(sigma)| > 0$, supposons que la propriété soit vérifiée pour toute permutation dont le cardinal du support est inférieur. \
    Soit $i in "supp"(sigma)$, puisque $sigma in S_n$, il existe $p in {1, ..., n}$ minimal tel que $sigma^(p)(i) = i$, alors on pose $tau_1 = (i, sigma(i), ..., sigma^(p-1)(i))$. Alors $tau_1$ agit comme $sigma$ sur l'ensemble ${i, sigma(i), ..., sigma^(p-1)(i)}$, donc on a $|"supp"(tau_1^(-1) compose sigma)| < |"supp"(sigma)|$. Par hypothèse de récurrence, on peut écrire $tau_1^(-1) compose sigma$ comme une composition de cycles à supports disjoints $tau_2, ..., tau_m in S_n$, et $sigma = tau_1 compose tau_2 compose ... compose tau_m$.
  Soit $i in {1, ..., n}$, puisques les supports sont disjoints, $i$ se trouve dans le support d'un seul des cycles, d'où l'unicité de l'écriture et $sum_(l=1)^m k_l = n$.
]

#definition[
  Soit $sigma in S_n$ et $tau_1, ..., tau_m in S_n$ la décomposition de $sigma$ en cycles à supports disjoints, ordonnés par longueur $k_1 <= ... <= k_m$. On appelle $(k_1, ..., k_m)$ le _type_ de $sigma$.
]

#theorem[
  Soit $sigma_1, sigma_2 in S_n$ deux permutations. Alors $sigma_1$ et $sigma_2$ sont conjuguées si et seulement si elles ont le même type.
]

#proof[
  #linebreak()
  $arrow.r.double$ : Supposons que $sigma_1$ et $sigma_2$ sont conjuguées. D'après le @lem-cycle-conj, $sigma_1$ et $sigma_2$ ont le même type. \
  $arrow.l.double$ : Supposons que $sigma_1$ et $sigma_2$ ont le même type $(k_1, ..., k_m)$. \
  D'après le @cor-cycle-conj, $sigma_1$ et $sigma_2$ sont conjuguées à
  $
    sigma_3 := (1, ..., k_1) compose (
      k_1 + 1, ..., k_1 + k_2
    ) compose ... compose (k_1 + ... + k_(m - 1) + 1, ..., k_m)
  $
  donc il existe $tau_1, tau_2 in S_n$ telles que $sigma_1 = tau_1 compose sigma_3 compose tau_1^(-1)$ et $sigma_2 = tau_2 compose sigma_3 compose tau_2^(-1)$. \
  Alors $sigma_1 = (tau_1 compose tau_2^(-1)) compose sigma_2 compose (tau_2 compose tau_1^(-1))$, donc $sigma_1$ et $sigma_2$ sont conjuguées.
]

#corollary[
  Soit $sigma in S_n$ une permutation. On peut écrire $sigma$ comme une composition de transpositions.
]

#proof[
  On peut écrire $sigma$ comme une composition de cycles à supports disjoints, et chaque cycle comme une composition de transpositions.
]

== Signature d'une permutation

#definition[
  Soit $sigma in S_n$ une permutation. On appelle _signature_ de $sigma$ le nombre rationnel
  $
    "sign"(sigma) := product_(1 <= i < j <= n) (sigma(j) - sigma(i)) / (j - i).
  $
]

#example[
  On calcule la signature de la transposition $(1, 2)$
  $
    "sign"(
      (1, 2)
    ) &= (sigma(2) - sigma(1)) / (2 - i) dot product_(2 < j <= n) (sigma(j) - sigma(1)) / (j - 1) dot product_(2 < j <= n) (sigma(j) - sigma(2)) / (j - 2) dot product_(3 <= i < j <= n) (sigma(j) - sigma(i)) / (j - i) \
    &= (2 - 1) / (1 - 2) dot product_(2 < j <= n) (j - 2) / (j - 1) (j - 1) / (j - 2) dot 1 \
    &= -1
  $
]

#theorem[
  L'application $fun("sign", (S_n, compose), ({-1, 1}, dot))$ est un morphisme de groupes.
]

#proof[
  Soit $sigma in S_n$. Alors on calcule
  $
    |"sign"(
      sigma
    )| = product_(1 <= i < j <= n) (|sigma(j) - sigma(i)|) / (|j - i|)
  $
  puisque $sigma$ est une bijection, on a ${{sigma(i), sigma(j)} | 1 <= i < j <= n} = {{i, j} | 1 <= i < j <= n}$, alors
  $ |"sign"(sigma)| = product_(1 <= i < j <= n) (|j - i|) / (|j - i|) = 1 $
  donc $"sign"(sigma) in {-1, 1}$. \
  Soit $tau in S_n$. Alors
  $
    "sign"(
      sigma compose tau
    ) &= product_(1 <= i < j <= n) (sigma(tau(j)) - sigma(tau(i))) / (j - i) \
    &= product_(1 <= i < j <= n) (sigma(tau(j)) - sigma(tau(i))) / (tau(j) - tau(i)) dot product_(1 <= i < j <= n) (tau(j) - tau(i)) / (j - i)
  $
  puisque $tau$ est une bijection, de la même manière on a
  $
    "sign"(
      sigma compose tau
    ) &= product_(1 <= i < j <= n) (sigma(j) - sigma(i)) / (j - i) dot product_(1 <= i < j <= n) (tau(j) - tau(i)) / (j - i) \
    &= "sign"(sigma) dot "sign"(tau)
  $
  donc $"sign"$ est un morphisme de groupes.
]

#corollary[
  - Soit $(a, b) in S_n$ une transposition. Alors $"sign"((a, b)) = -1$.
  - Soit $(a_1, ..., a_k) in S_n$ un $k$-cycle. Alors $"sign"((a_1, ..., a_k)) = (-1)^(k - 1)$.
  - Soit $sigma in S_n$ une permutation de type $(k_1, ..., k_m)$. Alors $"sign"(sigma) = product_(l = 1)^m (-1)^(k_l - 1)$.
]

#proof[
  Puisque $"sign"$ est un morphisme de groupes.
  - Comme $(a, b)$ est conjuguée à $(1, 2)$, $"sign"((a, b)) = "sign"((1, 2)) = -1$.
  - Comme $(a_1, ..., a_k) = (a_1, a_2) compose ... compose (a_(k - 1), a_k)$, on a
    $
      "sign"((a_1, ..., a_k)) = "sign"((a_1, a_2)) ... "sign"(
        (a_(k - 1), a_k)
      ) = (-1)^(k - 1).
    $
  - De la même manière, $sigma$ se décompose en cycles à supports disjoints, $"sign"(sigma) = product_(l = 1)^m (-1)^(k_l - 1)$.
]

== Groupes alternés

#definition[
  Soit $sigma in S_n$ une permutation. On dit que $sigma$ est _paire_ si $"sign"(sigma) = 1$, ou _impaire_ si $"sign"(sigma) = -1$. On appelle _groupe alterné_ l'ensemble
  $ A_n := {sigma in S_n | sigma "est paire"} = ker("sign"). $
]

#proposition[
  Soit $sigma in S_n$ une permutation. Alors $sigma$ est paire si et seulement si elle peut s'écrire comme une composition de $3$-cycles.
]

#proof[
  #linebreak()
  $arrow.r.double$ : Supposons que $sigma$ est paire. Alors $sigma$ est la composition d'un nombre pair de transpositions. On considère la permutation $(a, b) compose (c, d) in S_n$,
  - si ${a, b} = {c, d}$, alors $(a, b) compose (c, d) = id$,
  - si ${a, b} sect {c, d} = {b} = {c}$, alors $(a, b) compose (c, d) = (a, b, d)$,
  - si ${a, b} sect {c, d} = emptyset$, alors $(a, b) compose (c, d) = (a, b, c) compose (b, c, d)$,
  donc $(a, b) compose (b, c)$ est un produit de $3$-cycles. \
  $arrow.l.double$ : Supposons que $sigma$ est une composition de $3$-cycles. Alors $"sign"(sigma) = 1$, donc $sigma$ est paire.
]

#pagebreak()

= Groupes quotients

== Relations d'équivalence

#definition[
  Soit $E$ un ensemble. On appelle _relation_ sur $E$ un sous-ensemble $R$ de $E times E$. \
  Si $(x, y) in R$, on écrit $x R y$.
]

#definition[
  Soit $R$ une relation sur un ensemble $E$. On dit que $R$ est une _relation d'équivalence_ si elle vérifie les propriétés suivantes
  + $R$ est réflexive, $forall x in E, x R x$,
  + $R$ est symétrique, $forall x, y in E, x R y => y R x$,
  + $R$ est transitive, $forall x, y z in E, x R y "et" y R z => x R z$.
  Dans ce cas, on notera $tilde$ pour $R$.
]

#example[
  Soit $n in NN without {0}$, on pose $R_n := {(a, b) in ZZ^2 | n|a - b}$.
  + Soit $x in ZZ$, alors $n|0 = x - x$, donc $x R_n x$,
  + soit $x, y in ZZ$, si $x R_n y$, alors $n|x - y$, d'où $n|y - x$, donc $y R_n x$,
  + soit $x, y, z in ZZ$, si $x R_n y$ et $y R_n z$, alors $n|x - y$ et $n|y - z$, d'où
    $n|(x - y) + (y - z) = x - z$, donc $x R_n z$.
  Donc $R_n$ est une relation d'équivalence, si $(a, b) in ZZ^2$ on notera $a equiv b mod n$ pour $a R_n b$.
]

#definition[
  Soit $tilde$ une relation d'équivalence sur un ensemble $E$.
  - Soit $x in E$. On appelle _classe d'équivalence_ de $x$, notée $overline(x)$, l'ensemble
    $overline(x) := {y in E | x tilde y}$.
  - Soit $x in E$. On appelle _représentant_ de $x$ tout élément de $overline(x)$.
  - On appelle _espace quotient_ de E modulo $tilde$ l'ensemble
    $qt(E, tilde) := {overline(x) | x in E}$.
  - On appelle _projection canonique_ de $E$ sur $qt(E, tilde)$ l'application
    $fun(pi, E, qt(E, tilde), x:x, fx:overline(x))$.
]

#example[
  Soit $n in NN$, on considère de nouveau la relation d'équivalence $R_n$. Alors
  $
    forall x in ZZ, overline(x) = {y in ZZ | x equiv y mod n} = {
      x + n k | k in ZZ
    }
  $
  on notera $qt(ZZ, n ZZ)$ pour $qt(ZZ, R_n)$.
]

#definition[
  Soit $E$ un ensemble. On appelle _partition_ de $E$ une famille $(E_i)_(i in I)$ de sous-ensembles de $E$ qui vérifie les propriétés suivantes
  + les sous-ensembles sont deux à deux disjoints, $forall i, j in I, i != j => E_i sect E_j = emptyset$,
  + l'union des sous-ensembles forme $E$, $union.sq.big_(i in I) E_i := union.big_(i in I) E_i = E$.
]

#proposition[
  Soit $E$ un ensemble et $tilde$ une relation d'équivalence sur $E$.
  + Soit $x, y in E$, alors les énoncés suivants sont équivalents
    #enum(
      numbering: "(a)",
      enum.item(1)[$overline(x) = overline(y)$,],
      enum.item(2)[$x in overline(y)$,],
      enum.item(3)[$x tilde y$.],
    )
  + L'espace quotient de $E$ modulo $tilde$ forme une partition de $E$.
  + Soit $(E_i)_(i in I)$ une partition de $E$. Alors $R := {(x, y) in E | exists i in I, x, y in E_i}$ est une relation d'équivalence.
]

#proof[
  + $(a) => (b)$ : Supposons que $overline(x) = overline(y)$, alors $x in overline(x)$, donc $x in overline(y)$. \
    $(b) => (c)$ : Supposons que $x in overline(y)$, alors $y in overline(y)$, donc $x tilde y$. \
    $(c) => (a)$ : Supposons que $x tilde y$. Soit $z in overline(x)$, alors $z tilde x$, et par transitivité $z tilde y$, donc $z in overline(y)$. Réciproquement si $z in overline(y)$, alors $z in overline(x)$, donc $overline(x) = overline(y)$.
  + Soit $x, y in E$. Si $overline(x) sect overline(y) != emptyset$, il existe $z in overline(x) sect overline(y)$ tel que $z tilde x$ et $z tilde y$, donc $x tilde y$ et $overline(x) = overline(y)$. \
    Soit $x in E$, alors $x in overline(x) subset union.sq.big_(x in E) overline(x)$, donc $E = union.sq.big_(x in E) overline(x)$.
  +
    + Soit $x in E$, alors il existe $i in I$ tel que $x in E_i$, donc $x R x$.
    + Soit $x, y in E$, alors si $x R y$, il existe $i in I$ tel que $x, y in E_i$, donc $y R x$.
    + Soit $x, y in E$, alors si $x R y$ et $y R z$, il existe $i, j in I$ tels que $x, y in E_i$ et $y, z in E_j$, mais puisque $(E_i)_(i in I)$, alors $y in E_i sect E_j$, puisqu'il s'agit d'une partition on a $i = j$, donc $x R z$.
    Donc $R$ est une relation d'équivalence.
]

#definition[
  Soit $E$ un ensemble et $tilde$ une relation d'équivalence sur $E$. On appelle _système de représentants_ pour $tilde$ un sous-ensemble $F$ de $E$ tel que
  $ forall alpha in qt(E, tilde), exists! x in F, x in alpha $
  c'est-à-dire $fun(pi_(|F), F, qt(E, tilde))$ est bijective.
]

#definition[
  Soit $E$ et $F$ deux ensembles, et $fun(f, E, F)$ une fonction. On dit que $f$ est _bien définie_ si
  $ forall x, y in E, x = y => f(x) = f(y) $
]

#proposition[
  Soit $E$ et $F$ deux ensembles, et $tilde$ une relation d'équivalence.
  Soit $fun(f, E, F)$ une application, $fun(pi, E, qt(E, tilde))$ la projection canonique. Alors il existe $fun(overline(f), qt(E, tilde), F)$ bien définie telle que $overline(f) compose pi = f$ si et seulement si
  $ forall x, y in E, x tilde y => f(x) = f(y). $
]

#proof[
  #linebreak()
  $arrow.r.double$ : Supposons que $overline(f)$ soit bien définie et que $overline(f) compose pi = f$. Soit $x, y in E$ tels que $x tilde y$, alors $pi(x) = pi(y)$, d'où $overline(f)(pi(x)) = overline(f)(pi(y))$, donc $f(x) = f(y)$.

  $arrow.l.double$ : Supposons que $forall x, y in E, x tilde y => f(x) = f(y)$. \
  Soit $alpha in qt(E, tilde)$, on pose $x_alpha in E$ un représentant de $alpha$, on définit $overline(f)(alpha) = f(x_alpha)$.
  Soit $beta in qt(E, tilde)$, si $beta = alpha$, alors $x_beta tilde x_alpha$, d'où $f(x_beta) = f(x_alpha)$, donc $overline(f)(beta) = overline(f)(alpha)$, c'est-à-dire $overline(f)$ est bien définie.
]

== Classes modulo un sous-groupe

#definition[
  Soit $(G, star)$ un groupe et $H$ un sous-groupe de $G$. On appelle _relation modulo $H$ à gauche_, la relation $attach(tilde, br: H)$ sur $G$ définie par
  $
    forall x, y in G, x attach(tilde, br:H) y <=> y in x H <=> x^(-1) star y in H
  $
  où $x H = {x star y | y in H}$.
]

#remark[
  On peut définir la _relation modulo $H$ à droite_ $attach(tilde, bl: H)$ d'une manière similaire.
]

#proposition[
  Soit $(G, star)$ un groupe et $H$ un sous-groupe de $G$. Alors $attach(tilde, br: H)$ est une relation d'équivalence sur $G$, dont les classes d'équivalences sont $forall x in G, overline(x) = x H$.
]

#proof[
  + Soit $x in G$, alors $x star e in x H$, donc $x attach(tilde, br: H) x$.
  + Soit $x, y in G$, alors si $x attach(tilde, br: H) y$, on a $x^(-1) star y in H$, d'où $y^(-1) star x = (x^(-1) star y)^(-1) in H$, donc $y attach(tilde, br: H) x$.
  + Soit $x, y, z in G$, alors si $x attach(tilde, br: H) y$ et $y attach(tilde, br: H) z$, on a $y in x H$ et $z in y H$, d'où $z in x H$, donc $x attach(tilde, br:H) z$.
]

#notation[
  Soit $(G, star)$ un groupe et $H$ un sous-groupe de $G$. Alors on note les espaces quotients $qt(G, H) := qt(G, attach(tilde, br: H))$ et $qtr(G, H) := qt(G, attach(tilde, bl: H))$.
]


#proposition[
  Soit $(G, star)$ un groupe et $H$ un sous-groupe de $G$. Alors les ensembles $qt(G, H)$ et $qtr(G, H)$ sont isomorphes. En particulier si $G$ est fini, on a $|qt(G, H)| = |qtr(G, H)|$.
]

#proof[
  On considère le morphisme $fun(phi, qt(G, H), qtr(G, H), x:x H, fx: H x^(-1))$, il est bien définie et admet pour inverse $fun(psi, qtr(G, H), qt(G, H), x: H x, fx: x^(-1) H)$, donc c'est un isomorphisme.
]

== Théorème du nombre de classes et théorème de Lagrange

#definition[
  Soit $(G, star)$ un groupe et $H$ un sous-groupe de $G$. On appelle _indice_ de $H$ dans $G$
  $ [G:H] := |qt(G, H)|. $
]

#theorem(title: "Théorème du nombre de classes")[
  Soit $(G, star)$ un groupe et $H$ un sous-groupe de $G$. Alors si $G$ est fini
  $ |G| = [G:H]|H| $
] <thm-classes>

#proof[
  On pose $n := [G:H]$ et on considère ${x_1, ..., x_n}$ un système de représentants pour $attach(tilde, br: H)$. On sait que la famille $(x_i H)_(i in {1, ..., n})$ forme une partition de $G$, d'où
  $ |G| = sum_(i=1)^n |x_i H| = sum_(i=1)^n |H| = n|H| $
  c'est-à-dire $|G| = [G:H]|H|$.
]

#corollary(title: "Théorème de Lagrange")[
  Soit $(G, star)$ un groupe et $H$ un sous-groupe de $G$. Alors si $G$ est fini, $|H|$ divise $|G|$, en particulier si $x in G$, $"ord"(x)$ divise $|G|$.
] <thm-lagrange>

#corollary[
  + Soit $(G, star)$ un groupe fini d'ordre $n$ et $x in G$. Alors $x^n = e$.
  + Soit $(G, star)$ un groupe fini, $H$ un sous-groupe de $G$ et $K$ un sous-groupe de $H$. Alors $K$ est un sous-groupe de $G$ et
    $ [G:K] = [G:H][H:K]. $
]

#proof[
  + D'après le @thm-lagrange, $"ord"(x)$ divise $n$, donc $x^n = e$.
  + D'après le @thm-classes, $ [G:K] = (|G|)/(|K|) = ([G:H]|H|)/(|K|) = ([G:H][H:K]|K|)/(|K|) = [G:H][H:K]. $
]

== Sous-groupes distingués et groupes quotients

#theorem[
  Soit $(G, star)$ un groupe et $H$ un sous-groupe de $G$. Alors les énoncés suivants sont équivalents
  + $H$ est distingué.
  + Il existe un morphisme $fun(phi, G, G)$ tel que $H = ker(phi)$.
  + $qt(G, H)$ a une structure de groupes.
]

#proof[
  #linebreak()
  $1. => 3.$ : Supposons que $H$ est distingué. \
  On considère l'application $fun(dot, qt(G, H) times qt(G, H), qt(G, H), x:(x H, y H), fx: x y H)$, alors elle est bien définie et $(qt(G, H), dot)$ forme un groupe.

  $3. => 2.$ : Supposons que $qt(G, H)$ a une structure de groupe. \
  Alors la projection canonique $fun(pi, G, qt(G, H))$ est un morphisme de groupes et $ker(pi) = H$.

  $2. => 1.$ : Supposons qu'il existe un tel morphisme $phi$. \
  Soit $h in H$ et $g in G$, alors
  $
    phi(g star h star g^(-1)) = phi(g) star phi(h) star phi(g)^(-1) = phi(x) star phi(x)^(-1) = e
  $
  puisque $H = ker(phi)$, on a $g star h star g^(-1) in H$.
]

#corollary[
  Soit $(G, star)$ un groupe et $H$ un sous-groupe de $G$. Si $G$ est abélien, alors $qt(G, H)$ a une structure de groupes.
]

#theorem(title: "Propriété d'universalité du groupe quotient")[
  Soit $(G, star)$ un groupe et $H$ un sous-groupe distingué de $G$. Soit $(K, dot)$ un groupe, $fun(pi, G, qt(G, H))$ la projection canonique et $fun(phi, G, K)$ un morphisme de groupes. Alors il existe un morphisme $fun(overline(phi), qt(G, H), K)$ tel que $overline(phi) compose pi = phi$, si et seulement si $H subset ker(phi)$. Dans ce cas $im(overline(phi)) = im(phi)$ et $ker(overline(phi)) = ker(pi(phi))$.
] <thm-prop-univ-groupes>

#proof[
  #linebreak()
  $arrow.r.double$ : Supposons qu'il existe un tel morphisme $overline(phi)$. \
  Soit $x in H$, alors $phi(x) = overline(phi)(pi(x)) = overline(phi)({e}) = H$, donc $H subset ker(phi)$.

  $arrow.l.double$ : Supposons que $H subset ker(phi)$. \
  Soit $x in H$, on définit $overline(phi)(x H) = phi(x)$, alors $overline(phi)$ est bien définie. Puisque $overline(phi) compose pi = phi$ et $pi$ est surjectif, on a $im(overline(phi)) = im(phi)$on a $ker(overline(phi)) = pi(ker(phi))$.
]

#corollary(title: "Théorème d'isomorphisme")[
  Soit $(G, star)$ et $(K, dot)$ deux groupes, et $fun(phi, G, K)$ un morphisme de groupes. Alors il existe un isomorphisme $fun(overline(phi), qt(G, ker(phi)), im(phi))$.
] <thm-iso>

#proof[
  On pose $H := ker(phi)$, alors par le @thm-prop-univ-groupes, il existe $fun(overline(phi), qt(G, ker(phi)), im(phi))$ telle que $overline(phi) compose pi = phi$.
  Puisque $ker(overline(phi)) = pi(ker(phi)) = pi(H) = {e}$, $overline(phi)$ est injectif, et par définition $overline(phi)$ est surjectif. Donc $overline(phi)$ est un isomorphisme.
]

#proposition[
  Soit $(G, star)$ un groupe. Alors si $(G, star)$ est monogène, il existe $n in NN$ tel qu'il est isomorphe à $(ZZ, +)$ ou à $(qt(ZZ, n ZZ), +)$.
]

#proof[
  Soit $x in G$ un générateur et $fun(phi, ZZ, G, x:m, fx:x^m)$. \
  Alors $phi$ est un morphisme de groupes et $im(phi) = gen(x) = G$, donc $phi$ est surjectif. Soit $d := "ord"(x)$
  - si $d = +oo$, alors $phi$ est injectif, et par le @thm-iso, $qt(ZZ, ker(phi)) tilde.eq im(phi)$, c'est-à-dire $ZZ tilde.eq G$,
  - sinon $ker(phi) = d ZZ$, et par le @thm-iso, $qt(ZZ, ker(phi)) tilde.eq im(phi)$, c'est-à-dire $qt(ZZ, d ZZ) tilde.eq G$.
]

#proposition[
  Soit $(G, star)$ un groupe et $x, y in G$ tels que $x star y = y star x$. Notons $a := "ord"(x)$ et $b := "ord"(y)$, alors $"ord"(x star y)$ divise $"ppcm"(a, b)$. De plus si $gen(x) sect gen(y) = {e}$, on a $"ord"(x star y) = "ppcm"(a, b)$
]

#proof[
  Posons $m := "ppcm"(a, b)$ et $d := "pgcd"(a, b)$. \
  Alors il existe $a', b' in ZZ$ tels que $a = d a'$ et $b = d b'$, d'où $m = d a' b'$. Alors
  $ (x star y)^m = x^m star y^m = (x^(d a'))^(b') star (y^(d b'))^(a') = e $

  donc $"ord"(x star y)$ divise $"ppcm"(a, b)$.
]

#proposition[
  Soit $n, m in ZZ$. Alors $qt(ZZ, n ZZ) times qt(ZZ, m ZZ)$ est isomorphe à $ qt(ZZ, n m ZZ)$ si et seulement si $"pgcd"(n, m) = 1$.
]

#proof[
  Soit $x in ZZ$.
  Notons $overline(x) "et" [x]$ les classes respectives de $x$ modulo $n "et" m$. \
  $arrow.r.double$ : Supposons que $qt(ZZ, n ZZ) times qt(ZZ, m ZZ)$ est isomorphe à $qt(ZZ, n m ZZ) med$. Alors $qt(ZZ, n ZZ) times qt(ZZ, m ZZ)$ est cyclique. \
  Soit $(a, b)$ un générateur de $qt(ZZ, n ZZ) times qt(ZZ, m ZZ)$, c'est-à-dire $"ord"((a, b)) = n m$, alors
  $ "ppcm"("ord"(a), "ord"(b)) dot (a, b) = (overline(0), [0]) $
  donc $n m|"ppcm"("ord"(a), "ord"(b))$, on en déduit $n m|"ppcm"(n, m)$, d'où $"pcgd"(n, m) = 1$.

  $arrow.l.double$ : Supposons que $"pgcd"(n, m) = 1$. Posons $fun(phi, ZZ, qt(ZZ, n ZZ)times qt(ZZ, m ZZ), x:x, fx:(overline(x), [x]))$. \
  Alors $phi$ est bien un morphisme, et on a
  $
    ker(phi) &= {k in ZZ | (overline(k), [k]) = (overline(0), [0])} \
    &= {k in ZZ | n|k "et" m|k} \
    &= {k in ZZ | n m|k} = n m ZZ
  $

  d'après le @thm-prop-univ-groupes, il existe un morphisme $fun(overline(phi), qt(ZZ, n m ZZ), qt(ZZ, n ZZ) times qt(ZZ, m ZZ))$ injectif. Enfin puisque $|qt(ZZ, n m ZZ)| = |qt(ZZ, n ZZ) times qt(ZZ, m ZZ)|$, on en déduit que $overline(phi)$ est un isomorphisme.
]

#pagebreak()

= Actions de groupes

== Définitions

#definition[
  Soit $(G, star)$ un groupe et $X$ un ensemble. On appelle _action_ de $G$ sur $X$ une application $fun(psi, G times X, X)$ qui vérifie les propriétés suivantes
  + $forall x in X, psi(e, x) = x$,
  + $forall g, h in G, forall x in X, psi(g, psi(h, X)) = psi(g h, x)$.
  Dans ce cas, on notera $forall g in G, forall x in X, g star x := psi(g, x)$.
]

#notation[
  Soit $(G, star)$ un groupe et $X$ un ensemble. Si $G$ agit sur $X$, on note $G act X$.
]

#definition([
  Soit $(G, star)$ un groupe qui agit sur un ensemble $X$ et $x in X$.
  + On appelle _stabilisateur_ de $x$, l'ensemble $G_x := {g in G | g star x = x}$.
  + On appelle _orbite_ de $x$, l'ensemble $O_x := {g star x | g in G}$.
])

#lemma([
  Soit $(G, star)$ un groupe qui agit sur un ensemble $X$ et $x in X$. Alors le stabilisateur de $x$ est un sous-groupe de $G$. De plus
  $ forall g in G, G_(g star x) = g (G_x) g^(-1). $
])

#proof([
  On vérifie facilement que $G_x$ est un sous-groupe de $G$. Soit $g in G$, alors $h in G_(g star x)$ si et seulement si $h star (g star x) = g star x$, si et seulement si $(g^(-1) star h star g) star x = x$, si et seulement si $g^(-1) star h star g in G_x$, si et seulement si $h in g (G_x) g^(-1)$.
])

== Espace des orbites

#definition([
  Soit $(G, star)$ un groupe qui agit sur un ensemble $X$ et $x, y in X$. Alors on définit la relation $tilde$ par
  $ x tilde y <=> y in O_x. $
])

#proposition([
  Soit $(G, star)$ un groupe qui agit sur un ensemble $X$. Alors $tilde$
  est une relation d'équivalence sur $X$, dont les classes d'équivalences sont $forall x in X, overline(x) = O_x$.
])

#proof([
  + Soit $x in X$, alors $x = e star x$, d'où $x in O_x$, donc $x tilde x$.
  + Soit $x, y in X$, alors si $x tilde y$, il existe $g in G$ tel que $y = g star x$, d'où $x = g^(-1) star y$, donc $y tilde x$.
  + Soit $x, y, z in X$, alors si $x tilde y$ et $y tilde z$, il existe $g, h in G$ tels que $y = g star x$ et $z = h star y$, d'où $z = (h star g) star x$, donc $x tilde z$.
])

#definition([
  Soit $(G, star)$ un groupe qui agit sur un ensemble $X$. On dit que l'action est
  + _transitive_, si $forall x, y in X, exists g in G, y = g star x$,
  + _fidèle_, si $forall g in G without {e}, exists x in X, g star x != x$,
  + _libre_, si $forall g in G without {e}, forall x in X, g star x != x$.
  Dans ce cas, on dit que $G$ agit respectivement _transitivement_, _fidèlement_ et _librement_ sur $X$.
])

#proposition([
  Soit $(G, star)$ un groupe qui agit transitivement sur un ensemble $X$ et $x in X$. Alors l'application $fun(f_x, qt(G, G_x), X, x: g G_x, fx: g star x)$, est bien définie et est bijective.
])

#proof([
  Soit $g, h in G$ tels que $g tilde h$. Alors $g G_x = h G_x$, d'où $h^(-1) star g in G_x$, c'est-à-dire $g star x = h star x$, donc $f_x$ est bien définie. De plus $f_x$ est injective puisque $g star x = h star x$ donne $g G_x = h G_x$. Enfin $f_x$ est surjective puisque $G$ agit transitivement sur $X$.
])

#theorem(
  title: "Formule des classes",
  [
    Soit $(G, star)$ un groupe fini qui agit sur un ensemble fini $X$ et $x_1, ..., x_n in X$ un système de représentant pour $tilde$. Alors
    $ |X| = sum_(i = 0)^n |O_x_i| = sum_(i = 0)^n [G: G_x_i]. $
  ],
)

// #theorem(
//   title: "Formule de Burnside",
//   []
// )

= Classification des groupes abéliens finis

== Décomposition en $p$-groupes

#definition([
  Soit $(G, star)$ un groupe abélien d'ordre $n$ et $p$ un nombre premier qui divise $n$.
  On appelle composante _$p$-primaire_ de $G$, l'ensemble
  $ G_p := {x in G | exists q in NN, ord(x) = p^q}. $
])

#remark([
  Soit $(G, star)$ un groupe abélien d'ordre $n$ et $p_1^(r_1)...p_k^(r_k)$ la décomposition de $n$ en facteurs premiers.
  Alors
  $ forall i in {1, ..., k}, G_p_i = {x in G | x^(p_i^r_i) = e}. $
])

#lemma([
  Soit $(G, star)$ un groupe abélien d'ordre $n = a b$ tels que $pgcd(a, b) = 1$. Soit $k in NN$,
  $ G(k) := {x in G | x^k = e} $
  alors $G(k)$ est un sous-groupe de $G$ et $G$ est isomorphe à $G(a) times G(b)$.
]) <lem-comp-group>

#proof([
  Puisque $G$ est abélien, l'application $fun(phi_k, NN, G, x:x, fx:x^k)$ est un morphisme de groupes, donc $G(k) = ker(phi_k)$ est un sous-groupe de $G$.

  Posons $fun(phi, G(a) times G(b), G, x: (x, y), fx:x star y)$, $G$ est abélien donc c'est un morphisme de groupes. Soit $x in G$, puisque $pgcd(a, b) = 1$, il existe $u, v in ZZ$ tels que $a u + b v = 1$, alors
  $ x = x^(a u + b v) = x^(a u) star x^(b v) $
  or $(x^(b v))^a = (x^v)^n = e$ et $(x^(a u))^b = (x^u)^n = e$, d'où $x^(b v) in G(a)$ et $x^(a u) in G(b)$, on en déduit que $phi$ est surjectif puisque $x = phi(x^(b v), x^(a u))$. \
  Soit $(x, y) in G(a) times G(b)$ tel que $phi(x, y) = e$, alors $x = y^(-1) in G(a) sect G(b)$, on en déduit $ord(x)|a$ et $ord(x)|b$, d'où $ord(x)|pgcd(a, b)=1$ et $x = y = e$, donc $phi$ est injectif. Donc $G$ est isomorphe à $G(a) times G(b)$
])

#definition([
  Soit $(G, star)$ un groupe d'ordre $n$ et $p$ un nombre premier. On dit que $G$ est un _$p$-groupe_ s'il existe $k in NN$ tel $n = p^k$.
])

#lemma([
  Soit $(G, star)$ un groupe abélien d'ordre $n$ et $p$ un nombre premier tel que
  $ forall x in G, exists l_x in NN, ord(x) = p^(l_x). $
  Alors $G$ est un $p$-groupe.
]) <lem-p-group>

#proof([
  Notons $G := {x_1, ..., x_n}$. \
  Posons $fun(phi, H = gen(x_1) times ... times gen(x_n), G, x:(y_1, ..., y_n), fx: y_1...y_n)$, puisque $G$ est abélien $phi$ est un morphisme de groupes. Il est évidemment surjectif, alors d'après le @thm-iso, $G$ est isomorphe à $qt(H, ker(phi))$. De plus $|H| = product_(i = 1)^n p^(l_x_i) = p^(sum_(i=1)^n l_x_i)$, et $|G|$ divise $|qt(H, ker(phi))| dot |ker(phi)| = |H|$, donc $G$ est un $p$-groupe.
])

#theorem([
  Soit $(G, star)$ un groupe abélien d'ordre $n$ et $p_1^(r_1)...p_k^(r_k)$ la décomposition de $n$ en facteurs premiers.
  Soit $i in {1, ..., k}$, alors la composante $p_i$-primaire de $G$ est un groupe à $p_i^(r_i)$ éléments et $G$ est isomorphe à $G_p_1 times ... times G_p_k$.
])

#proof([
  Soit $i in {1, ..., k}$, on a d'après les @lem-comp-group et @lem-p-group, avec $G_p_i = G(p_i^(r_i))$ est bien un sous-groupe de $G$, et donc un $p_i$-groupe.
  Par récurrence directe sur le @lem-comp-group, $G$ est isomorphe à $G_p_1 times ... times G_p_k$, en comparant l'ordre des deux groupes, on en déduit que $G_p_i$ est d'ordre $p_i^(r_i)$.
])

#example([
  On considère $G := qt(ZZ, 2ZZ) times qt(ZZ, 5ZZ) times qt(ZZ, 5^2ZZ) times qt(ZZ, 7^3ZZ)$. Alors les composantes $p$-primaires de $G$ sont
  $
    G_2 &= qt(ZZ, 2ZZ) times {overline(0)} times {overline(0)} times {
      overline(0)
    } \
    G_5 &= {overline(0)} times qt(ZZ, 5ZZ) times qt(ZZ, 5^2ZZ) times {
      overline(0)
    } \
    G_7 &= {overline(0)} times {overline(0)} times {
      overline(0)
    } times qt(ZZ, 7^3ZZ).
  $
  On considère $H := qt(ZZ, 6ZZ) times qt(ZZ, 60ZZ)$. On a $|H| = 6 dot 60 = (2 dot 3)(2^2 dot 3 dot 5)$, alors les composantes $p$-primaires de $H$ sont
  $
    H_2 &= {(overline(a), [b]) in H | 2^3 a in 6ZZ "et" 2^3 b in 60ZZ} \
    &= {(overline(a), [b]) in H | 2^2 a in 3ZZ "et" 2 b in 15ZZ} \
    &= {(overline(a), [b]) in H | a in 3ZZ "et" b in 15ZZ} \
    &tilde.eq qt(ZZ, 2ZZ) times qt(ZZ, 4ZZ) \
    H_3 &tilde.eq qt(ZZ, 3ZZ) times qt(ZZ, 3ZZ) \
    H_5 &tilde.eq {overline(0)} times qt(ZZ, 5ZZ).
  $
])

== Décomposition des $p$-groupes en produit de groupes cycliques

#theorem([
  Soit $p$ un nombre premier et $(G, star)$ un $p$-groupe abélien.
  Alors il existe $n_1, ..., n_k in NN$, uniquement déterminés par $G$, tels que $G$ est isomorphe à $ (qt(ZZ, p^k ZZ))^(n_k) times ... times (qt(ZZ, p ZZ))^(n_1). $
])

#proof([
  Admis.
])

#corollary([
  Soit $(G, star)$ un groupe abélien fini. Alors $G$ est isomorphe à un produit de groupes cycliques
])

#corollary([
  Soit $(G, star)$ un groupe abélien fini.
  Alors il existe $n_1, ..., n_k in NN$, uniquement déterminés par $G$, tels que $n_1|...|n_k$ et $G$ est isomorphe à
  $ qt(ZZ, n_1 ZZ) times ... times qt(ZZ, n_k ZZ). $
])

#example([
  Considérons le groupe
  $
    G = qt(ZZ, 4ZZ) times (
      qt(ZZ, 8ZZ)
    )^2 times qt(ZZ, 3ZZ) times qt(ZZ, 9ZZ) times (qt(ZZ, 5ZZ))^2
  $
  dans lequel 3 est le nombre maximal de facteurs dans la décomposition d'un $p$-groupe ($p = 2$). On fait donc un tableau avec 3 colonnes
  #align(
    center,
    table(
      align: center,
      columns: 4,
      inset: 6pt,
      [$p = 2$], [$2^2$], [$2^3$], [$2^3$],
      [$p = 3$], [$1$], [$3$], [$3^2$],
      [$p = 5$], [$1$], [$5$], [$5$],
      [], [$4$], [$120$], [$360$],
    ),
  )
  et on en déduit que
  $ G tilde.eq qt(ZZ, 4ZZ) times qt(ZZ, 120ZZ) times qt(ZZ, 360ZZ). $
])

== Facteurs invariants d'un groupe

#definition([
  Soit $(G, star)$ un groupe abélien fini. On appelle _facteurs invariants_ de $G$, les $n_1, ..., n_k in NN$ de sa décomposition en groupes cycliques
])

#corollary([
  Soit $(G, star)$ et $(H, dot)$ deux groupes abéliens finis. Alors $G$ et $H$ sont isomorphes si et seulement si ils ont les mêmes facteurs invariants.
])
