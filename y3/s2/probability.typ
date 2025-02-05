#import "../../template.typ": *

#show: maths.with(title: "Probabilités", color: "#718355")

#set-maths(sequence: (ind: "n", dom: $NN$))

= Cadre général de la théorie des probabilités

== Espace probabilisé général

#definition([
  Soit $Omega$ un ensemble.
  On appelle _tribu_ sur $Omega$ une famille $cal(F)$ de parties de $Omega$ vérifiant :
  + $cal(F)$ est non-vide : $emptyset in cal(F)$,
  + la stabilité par passage au complémentaire : $forall A in cal(F), A^c in cal(F)$,
  + la stabilité par union dénombrable : $forall sequence(A) in cal(F)^NN, union.big_(n>=1) A_n in cal(F)$.
])

#definition([
  Soit $Omega$ un ensemble et $cal(F)$ une tribu sur $Omega$.
  On appelle _mesure de probabilité_ une mesure $func(PP, cal(F), RR_+)$ vérifiant $PP(Omega) = 1$.
])

#definition([
  Soit $Omega$ un ensemble, $cal(F)$ une tribu sur $Omega$ et $PP$ une mesure de probabilité sur $(Omega, cal(F))$.
  On appelle _espace probabilisé_ le triplet $(Omega, cal(F), PP)$, on dit que $Omega$ est l'univers et que $cal(F)$ sont les événements.
])

#remark([
  Dans le cadre discret, on avait souvent $cal(F) := cal(P)(Omega)$. Dans le cadre général, on aura souvent $cal(F) subset.neq cal(P)(Omega)$.
])

#definition([
  Soit $sequence(A)$ une suite d'événements sur $(Omega, cal(F), PP)$. On dit que $sequence(A)$ est un _système complet_ si elle vérifie :
  + les $A_n$ sont disjoints deux à deux,
  + la probabilité de l'union des $A_n$ est 1.
])

#proposition([
  Soit $sequence(A)$ un système complet sur $(Omega, cal(F), PP)$.
  Alors on a
  $ forall B in cal(F), PP(B) = sum_(n=1)^(+oo) PP(B sect A_n). $
])

#proof([
  On pose $C := union.big_(n>=1) A_n$, puisque $PP(C) = 1$, on a $PP(C^c) = 0$ d'où $PP(B sect C^c) = 0$. Soit $B in cal(F)$, on en déduit
  $
    PP(B) = PP(B sect C) + underbraced(PP(B sect C^c), = 0)
    = PP(union.big_(n>=1) B sect A_n)
    = sum_(n=1)^(+oo) PP(B sect A_n).
  $
])

#corollary([
  Soit $sequence(A)$ un système complet sur $(Omega, cal(F), PP)$.
  Alors pour tout $B in cal(F)$on a

  + $PP(B) = sum_(n=1)^(+oo) PP(A_n)P(B|A_n)$,

  + $forall i >= 1, PP(A_i|B) = display((PP(A_i)PP(B|A_i))/(sum_(n=1)^(+oo) PP(A_n)PP(B|A_n))).$
])

#theorem(
  title: "Continuité de la mesure de probabilité",
  [
    Soit $(Omega, cal(F), PP)$ un espace probabilisé.
    + Soit $sequence(A)$ une suite croissante d'événements. Alors on a
      $ lim_(n->+oo) PP(A_n) = PP(union.big_(n>=1) A_n). $
    + Soit $sequence(A)$ une suite décroissante d'événements. Alors on a
      $ lim_(n->+oo) PP(A_n) = PP(sect.big_(n>=1) A_n). $
  ],
)

#proof([
  + Pour tout $n >= 1$, on pose $B_n := A_n without A_(n-1)$ avec $A_0 = emptyset$, tel que les $sequence(B)$ forme un système complet sur $union.big_(n>=1) A_n$, on en déduit alors
    $
      PP(union.big_(n>=1) A_n) = PP(union.big_(n>=1) B_n) &= sum_(n=1)^(+oo) PP(B_n) = sum_(n=1)^(+oo) PP(A_n) - PP(A_(n-1))
    $
    on reconnait une somme téléscopique et on a donc
    $
      PP(union.big_(n>=1) A_n) = lim_(n->+oo) PP(A_n) - PP(A_0) = lim_(n->+oo) PP(A_n).
    $
  + On obtient directement le résultat par passage au complémentaire.
])

#definition([
  Soit $sequence(A)$ une suite d'événements de $(Omega, cal(F), PP)$.
  - On appelle _limite supérieure_ de la suite $sequence(A)$ la valeur
    $ limsup_(n->+oo) A_n := sect.big_(n>=1) union.big_(k>=n) A_k $
    intuitivement on considère les éléments qui appartiennent à une infinité d'événements.
  - On appelle _limite inférieure_ de la suite $sequence(A)$ la valeur
    $ limsup_(n->+oo) A_n := union.big_(n>=1) sect.big_(k>=n) A_k. $
])

#corollary([
  Soit $sequence(A)$ une suite d'événements de $(Omega, cal(F), PP)$.
  Alors on a
  $
    PP(limsup_(n->+oo) A_n) &= lim_(m->+oo) lim_(n->+oo) PP(union.big_(k = m)^n A_k) \
    PP(liminf_(n->+oo) A_n) &= lim_(m->+oo) lim_(n->+oo) PP(sect.big_(k = m)^n A_k)
  $
])

#proposition([
  Soit $sequence(A)$ une suite d'événements de $(Omega, cal(F), PP)$.
  Alors on a $ PP(union.big_(n>=1) A_n) <= sum_(n=1)^(+oo) A_n. $
])

#proof([
  On sait que le résultat est vérifié pour un nombre fini d'événements. Par passage à la limite et par continuité de la mesure $PP$ on a
  $
    PP(union.big_(n>=1) A_n) = lim_(m->+oo) PP(union.big_(n=1)^m A_n) <= lim_(m->+oo) sum_(n=1)^m PP(A_n) = sum_(n=1)^(+oo) PP(A_n).
  $
])

#definition([
  Soit $A$ un événement de $(Omega, cal(F), PP)$.
  - On dit que $A$ est _négligeable_ si $PP(A) = 0$.
  - On dit que $A$ est _presque-sûr_ si $PP(A) = 1$.
])

#corollary([
  Soit $(Omega, cal(F), PP)$ un espace probabilisé. Alors
  - L'union dénombrable d'événements négligeables est négligeable.
  - L'intersection dénombrable d'événements presque-sûrs est presque-sûre.
])

#proposition([
  Soit $cal(A)$ une famille d'événements de $(Omega, cal(F), PP)$.
  Alors il existe une unique tribu $sigma(cal(A))$ telle que $sigma(cal(A))$ soit la plus petite tribu contenant $cal(A)$.
]) <prop-tribu-engendree>

#proof([
  Il existe au moins une tribu contenant $cal(A)$, à savoir $cal(P)(Omega)$. Alors l'intersection de toutes les tribus contenant $cal(A)$ est une tribu et convient.
])

#definition([
  Soit $cal(A)$ une famille d'événements de $(Omega, cal(F), PP)$.
  On appelle _tribu engendrée_ par $cal(A)$, notée $sigma(cal(A))$, la tribu de la @prop-tribu-engendree.
])

#example([
  Soit $A$ un événement de $(Omega, cal(F), PP)$. Alors $sigma({A}) = {emptyset, A, A^c, Omega}$.
])

== Exemples d'espace probabilisés

#definition([
  Soit $(E, cal(O))$ un espace topologique. On appelle _tribu borélienne_ sur $E$, notée $borel(E)$, la tribu engendrée par les intervalles ouverts de $E$, c'est-à-dire $borel(E) := sigma(cal(O))$.
])

#lemma([
  Soit $sequence(mu)$ une suite de mesures de probabilité sur $(Omega, cal(F))$ et $sequence(lambda)$ une suite de nombres réels positifs telle que $sum_(n=1)^(+oo) lambda_n = 1$. Alors $mu = sum_(n=1)^(+oo) lambda_n mu_n$ est une mesure de probabilité sur $(Omega, cal(F))$.
])

=== Univers $Omega = NN$

Se référer au cours de _Probabilités_ de deuxième année.

=== Univers $Omega = RR$

#example(
  title: "Mesure de Dirac",
  [
    Soit $x in RR$, l'application $func(delta_x, borel(RR), RR_+)$ définie par
    $
      forall A in borel(RR), delta_x (A) = cases(0 "si" x in.not A, 1 "si" x in A)
    $
    est une mesure de probabilité sur $RR$.
  ],
)

#example(
  title: [Mesure uniforme sur ${1, ..., n}$],
  [
    L'application $mu = 1/n sum_(k = 1)^n delta_k$ est une mesure uniforme sur $RR$.
  ],
)

#example(
  title: "Mesure de Poisson",
  [
    Soit $lambda > 0$, l'application $mu = sum_(n=1)^(+oo) e^(-lambda) lambda^n/n! delta_n$ est une mesure de Poisson sur $RR$.
  ],
)

#definition([
  Soit $func(f, RR, RR)$ une fonction borélienne.
  On dit que $f$ est une _densité de probabilité_ sur $RR$ si elle vérifie :
  + pour $lambda$-presque tout $x in RR, f(x) >= 0$,
  + $integral_RR f(x) dif lambda(x) = 1$.
])

#lemma([
  Soit $f$ une densité de probabilité sur $RR$.
  Alors l'application $func(mu_f, borel(RR), RR_+)$ définie par
  $forall A in borel(RR), mu_f (A) = integral_A f(x) dif lambda(x)$
  est une mesure de probabilité sur $RR$.
])

#proof([
  On a bien $forall A in borel(RR), mu_f (A) >= 0$. De plus $mu_f (RR) = 1$. Soit $sequence(A)$ une suite d'éléments de $borel(RR)$ deux à deux disjoints. On pose $A := union.big_(n>=1) A_n$, alors $ind(A) = sum_(n=1)^(+oo) ind(A_n)$ et
  $
    mu_f (A) = integral_A f(x) dif lambda(x) = integral_RR ind(A) (x) f(x) dif lambda(x) = integral_RR sum_(n=1)^(+oo) ind(A_n) (x) f(x) dif lambda(x)
  $
  d'après le théorème de convergence monotone on a
  $
    mu_f (A) = lim_(m->+oo) integral_RR sum_(n=1)^(m) ind(A_n) f(x) dif lambda(x) = lim_(m->+oo) sum_(n=1)^(m) mu_f (A_n) = sum_(n=1)^(+oo) mu_f (A_n).
  $
  Donc $mu_f$ est bien une mesure de probabilité sur $RR$.
])

#remark([
  On dit que $mu_f$ est la _mesure de densité_ $f$.
])

#proposition([
  Soit $f$ et $g$ deux densités de probabilités sur $RR$.
  Alors les mesures de densité $mu_f$ et $mu_g$ sont égales si et seulement si $f$ et $g$ sont égales presque partout.
])

#proof([
  #linebreak()
  $arrow.r.double$ : Supposons que $mu_f = mu_g$. On pose
  $
    A_+ &:= {x in RR | f(x) > g(x)} \
    A_- &:= {x in RR | f(x) < g(x)}
  $
  ces deux ensembles sont boréliens car $f$ et $g$ sont boréliennes. Par construction
  $
    integral_(A_+) f - g dif lambda &= mu_f (A_+) - mu_g (A_+) = 0 = integral_(A_-) f - g dif lambda
  $
  de plus $A := {x in RR | abs(f(x) - g(x)) > 0} = A_+ union A_-$, on en déduit
  $
    integral_A abs(f - g) dif lambda = integral_A (f - g)ind(A_+) + (g - f)ind(A_-) dif lambda = 0
  $
  donc $f - g = 0$ presque partout et $f = g$ presque partout.


  $arrow.l.double$ : Si $f = g$ presque partout, alors il est évident que $mu_f = mu_g$.
])

#example(
  title: "Loi uniforme",
  [
    Soit $c, d in RR$ avec $c < d$. Alors la fonction $func(f, RR, RR, x, (ind([c, d])(x))/(d - c))$ est une densité de probabilité. En particulier, pour tout $[a, b] subset [c, d]$
    $ mu_f ([a, b]) = integral_[a, b] f(x) dif lambda(x) = (b-a) / (d-c). $
    On note la probabilité associée $cal(U)([c, d])$.
  ],
)

#example(
  title: "Loi exponentielle",
  [
    Soit $lambda > 0$. Alors la fonction $func(f, RR, RR, x,  lambda e^(-lambda x) ind(RR_+)(x))$ est une densité de probabilité. On note la probabilité associée $cal(E)(lambda)$.
  ],
)

#example(
  title: "Loi normale",
  [
    La fonction $func(f, RR, RR, x,  1/sqrt(2pi) e^(-x^2/2))$ est une densité de probabilité. On note la probabilité associée $cal(N)(0, 1)$.
  ],
)

=== Univers $Omega = RR^d$

On peut étendre les exemples de $RR$, ainsi que les définitions de densité et de mesures de probabilité associée.

== Classe monotone

#definition([
  Soit $cal(C)$ une famille de parties d'un ensemble $Omega$. On dit que $cal(C)$ est une _classe monotone_ si elle vérifie :
  + $Omega in cal(C)$,
  + $forall A, B in cal(C), A subset B => B without A in cal(C)$,
  + $forall sequence(A) in cal(C)^NN "croissante", union.big_(n in NN) A_n in cal(C)$.
])

#remark([
  Une tribu est une classe monotone, la réciproque est fausse.
])

#lemma([
  Soit $cal(C)$ une classe monotone.
  Alors $cal(C)$ est une tribu si et seulement si elle est stable par intersection finie, c'est-à-dire :
  $ forall A_1, ..., A_n in cal(C), sect.big_(k=1)^n A_n in cal(C). $
]) <lem-classe-tribu>

#proof([
  #linebreak()
  $arrow.r.double$ : Si $cal(C)$ est une tribu elle est stable par intersection finie. \
  $arrow.l.double$ : Supposons que $cal(C)$ est stable par intersection finie.
  Soit $sequence(A)$ une suite d'éléments de $cal(C)$. Puisque $cal(C)$ est stable par passage au complémentaire, $cal(C)$ est aussi stable par union finie, en effet
  $
    A, B, in cal(C) => A^c, B^c in cal(C)
    => A^c sect B^c in cal(C)
    => A union B = (A^c sect B^c)^c in cal(C)
  $
  // FIXME attach
  on a donc pour tout $N in NN$, $union.big_(n=0)^N A_n in cal(C)$, et par union croissante
  $
    union.big_(n in NN) A_n = union.big_(N in NN) underbraced(union.big_(n=0)^N A_n, "croissante") in cal(C)
  $
  donc $cal(C)$ est bien une tribu.
])

#definition([
  Soit $cal(A)$ une famille de parties d'un ensemble $Omega$. On appelle _classe monotone engendrée_ par $cal(A)$, notée $cal(C)(cal(A))$, l'intersection de toutes les classes monotones contenant $cal(A)$.
])

#theorem(
  title: "Théorème de la classe monotone",
  [
    Soit $cal(A)$ une famille de partie d'un ensemble $Omega$. Si $cal(A)$ est stable par intersection finie, alors $cal(C)(cal(A)) = sigma(cal(A))$.
  ],
) <thm-classe-monotone>

#proof([
  Soit $A in cal(C)(cal(A))$, on pose $cal(C)_A := {B in cal(C)(cal(A)) | A sect B in cal(C)(cal(A))}$. Puisque $cal(C)_A$ est une classe monotone contenant $A$, on a $cal(C)_A = cal(C)(cal(A))$. Donc $cal(C)(cal(A))$ est stable par intersection finie. D'après le @lem-classe-tribu $cal(C)(cal(A))$ est une tribu.
])

#corollary([
  Soit $mu$ et $nu$ deux mesures de probabilités sur $(Omega, cal(F))$. S'il existe une famillesequence: (ind: "n") de parties $cal(A)$ stable par intersection finie sur laquelle $mu$ et $nu$ coïncident, alors elles coïncident sur $sigma(cal(A))$.
])

#pagebreak()

== Variables et vecteurs aléatoires

#definition([
  Soit $(Omega, cal(F))$ un espace probabilisable. On appelle _vecteur aléatoire_ une application borélienne $func(X, (Omega, cal(F)), (RR^d, borel(RR^d)))$. Dans le cas $d = 1$, on dit que $X$ est une _variable aléatoire_.
])

#proposition([
  Soit $(Omega, cal(F))$ un espace probabilisable.
  + Une application $func(X, Omega, RR)$ est une variable aléatoire si et seulement si
    $ forall t in RR, X^(-1)(]-oo, t]) in cal(F) $
  + Une application $func(X = (X_1, ..., X_d), Omega, RR^d)$ est un vecteur aléatoire si et seulement si $X_1, ..., X_d$ sont des variables aléatoires.
  + Soit $func(X, Omega, RR^d)$ un vecteur aléatoire et $func(phi, RR^d, RR^n)$ une application borélienne. Alors $phi compose X$ est un vecteur aléatoire.
])

#proof([
  + $arrow.r.double$ : Si $X$ est une variable aléatoire, alors $X$ est mesurable et le résultat est évident. \
    $arrow.l.double$ : Si pour tout $t in RR$ on a $X^(-1)(]-oo, t]) in cal(F)$. Alors puisque la famille ${]-oo, t] | t in RR}$ engendre $borel(RR)$, $X$ est mesurable. Donc $X$ est une variable aléatoire.
  + On obtient le résultat par projection en appliquant (1) à $X_1, ..., X_n$.
  + On obtient le résultat par composition de fonctions boréliennes.
])

#proposition([
  Soit $sequence(X)$ une suite de variables aléatoires sur $(Omega, cal(F))$.
  + Si les applications $S := sup_(n in NN) X_n$ et $I := inf_(n in NN) X_n$ sont finies, alors $S$ et $I$ sont des variables aléatoires.
  + Si $sequence(X)$ converge simplement vers une limite finie $X$, alors $X$ est une variable aléatoire.
])

#proof([
  + On remarque que pour tout $t in RR$ on a $S^(-1)(]-oo, t]) = sect.big_(n in NN) X^(-1)(]-oo, t])$ et que l'on peut écrire de la même manière pour $I$.
  + On remarque que $X = lim_(n->+oo) X_n = limsup_(n->+oo) X_n = inf_(m->+oo) (sup_(n >= m) X_n)$.
])

=== Loi d'un vecteur aléatoire

#proposition([
  Soit $(Omega, cal(F), PP)$ un espace probabilisé et $func(X, Omega, RR^d)$ un vecteur aléatoire.
  Alors l'application $func(PP_X, borel(RR^d), RR_+,  A,  PP(X^(-1)(A)))$ est une mesure de probabilité sur $RR^d$.
]) <prop-loi>

#definition([
  Soit $(Omega, cal(F), PP)$ un espace probabilisé et $func(X, Omega, RR^d)$ un vecteur aléatoire.
  On appelle _loi de $X$_, notée $PP_X$, la mesure de probabilité de la @prop-loi. On dit aussi que $X$ suit la loi $PP_X$.
])

#definition([
  Soit $(Omega, cal(F), PP)$ un espace probabilisé et $func(X, Omega, RR^d)$ un vecteur aléatoire. On appelle _atomes de X_, noté $cal(V)_X$, l'ensemble
  $ cal(V)_X := {x in RR^d | PP_X ({x}) > 0}. $

])

#example(
  title: "Loi de Bernoulli",
  [
    On considère $(Omega, cal(F), PP)$ avec $Omega = RR$, $cal(F) = borel(RR)$ et $PP$ la mesure uniforme sur $[0, 1]$. On prend $X = ind([0, p])$ avec $p in [0, 1]$. Soit $A in borel(RR)$, alors
    $
      PP_X (A) &= PP(X^(-1) (A)) = PP(X^(-1)(A sect {0})) + PP(X^(-1)(A sect {1})) \
      &= delta_0 (A) PP(X^(-1)(0)) + delta_1 (A) PP(X^(-1)(1)) = delta_0 (A) (1 - p) + delta_1 (A) p
    $
    donc $PP_X = delta_0 (1-p) + delta_1 p$.
  ],
)

#proposition([
  Soit $(Omega, cal(F), PP)$ un espace probabilisé et $func(X = (X_1, ..., X_d), Omega, RR^d)$ un vecteur aléatoire. Si $X$ admet une densité $func(f, RR^d, RR_+)$, alors les variables aléatoires $X_1, ..., X_d$ admettent des densités $func(f_1","... "," f_d, RR, RR_+)$ avec
  $
    forall i in {1, ..., d}, f_i (x) := integral_(RR^(d-1)) f(x_1, ..., x_(i-1), x, x_(i+1), ..., x_d) dif lambda(x_1, ..., x_(i-1), x_(i+1), ..., x_n).
  $
])

#proof([
  Il suffit d'appliquer le théorème de Fubini.
])

== Fonction de répartition

#definition([
  Soit $mu$ une mesure de probabilité sur $(RR, borel(RR))$. On appelle _fonction de répartition_, notée $F_mu$, la fonction $func(F_mu, RR, RR_+,  t,  mu(]-oo, t]))$.
])

#definition([
  Soit $(RR, borel(RR), PP)$ un espace probabilisé, et $X$ une variable aléatoire. On appelle _fonction de répartition de $X$_, notée $F_X$, la fonction de répartition liée à $PP_X$.
])

#proposition([
  Soit $(RR, borel(RR), PP)$ un espace probabilisé, et $func(X\, Y, RR, RR)$ deux variables aléatoires. Alors $X$ et $Y$ ont la même loi si et seulement si elles ont la même fonction de répartition.
])

#proof([
  #linebreak()
  $arrow.r.double$ : Supposons que $PP_X = PP_Y$. Alors on a
  $ forall t in RR, F_X (t) = PP_X (]-oo, t]) = PP_Y (]-oo, t]) = F_Y (t) $
  donc $F_X = F_Y$.

  $arrow.l.double$ : Supposons que $F_X = F_Y$. Alors on pose $cal(A) := {]-oo, t] | t in RR}$ qui est stable par intersection avec $sigma(cal(A)) = borel(RR)$, on pose $cal(C) := {A in borel(RR) | P_X (A) = P_Y (A)}$ qui est une classe monotone, alors d'après le théorème de la classe monotone $cal(C) = borel(RR)$. Donc $P_X = P_Y$
])

=== Reconnaitre une densité de probabilité

#proposition([
  Soit $(RR, borel(RR), PP)$ un espace probabilisé et $func(X, RR, RR)$ une variable aléatoire.
  Alors si la fonction de répartition de $X$ est $C^1$ par morceaux, $X$ admet une densité de probabilité définie par $f = F'_X$ si $F_X$ est dérivable et $f = 0$ sinon.
])

#proof([
  Puisque $F_X$ est $C^k$ par morceaux, il existe une suite croissante $(a_n)_(n in ZZ)$ telle que
  $ lim_(n->+oo) a_n = -lim_(n->-oo) a_k = +oo $
  et pour tout $n in ZZ$, $F_X$ soit dérivable sur $]a_(n), a_(n+1)[$. Soit $n in ZZ$, alors
  $ forall s, t in ]a_n, a_(n+1)[, integral_s^t f(x) dif x = F_X (t) - F_X (s) $
  et par passage à la limite pour $s --> a_n$ et $t --> a_(n+1)$ on a
  $ integral_(a_n)^(a_(n+1)) f(x) dif x = F_X (a_n) - F_X (a_(n+1)). $
  Soit $t in RR$, alors il existe $n in ZZ$ tel que $t in ]a_n, a_(n+1)[$ et
  $
    integral_(-oo)^t f(x) dif x = sum_(k=-oo)^(n) integral_(a_n)^(a_(n+1)) f(x) dif x + integral_(a_n)^t f(x) dif x
  $
  on reconnait une somme téléscopique et on a donc
  $
    integral_(-oo)^t f(x) dif x = F_X (t) - underbraced(lim_(k -> -oo) F_X (a_k), =0) = F_X (t) = PP_X (]-oo, t]).
  $
])

=== Reconnaitre une loi discrète

#definition([
  Soit $(RR, borel(RR), PP)$ un espace probabilisé et $func(X, RR, RR)$ une variable aléatoire.
  On appelle _saut_ de la fonction de répartition de $X$, noté $Delta_X$, la fonction définie par
  $ forall t in RR, Delta_X (t) := F_X (t) - lim_(x -> t^-) F_X (x). $
])

#lemma([
  Soit $(RR, borel(RR), PP)$ un espace probabilisé et $func(X, RR, RR)$ une variable aléatoire.
  Alors l'ensemble des points de discontinuités, noté $cal(D)_X := {t in RR | Delta_X (t) > 0 }$, est dénombrable avec
  $sum_(t in cal(D_X)) Delta_X (t) <= 1$
  de plus $X$ est discrète si et seulement si
  $sum_(t in cal(D_X)) Delta_X (t) = 1$.
])

// #proof([
//   On pose pour tout $n in NN without {0}$, $I_n := {t in RR mid(|) Delta_X (t) >= 1/n}$.
// ])

#pagebreak()

= Espérance

== Calculs de l'espérance

=== Définition et formule de transfert

#definition([
  Soit $(Omega, cal(F), PP)$ un espace probabilisable et $func(X, Omega, RR_d)$ un vecteur aléatoire.
  On appelle _espérance_ de $X$, notée $EE[X]$, la valeur
  $
    EE[X] := integral_Omega X(omega) dif PP(omega) = integral_(RR^d) x dif PP_X (x).
  $
])

#remark([
  Pour que l'intégrale précédente ait du sens dans $RR$ on a besoin que :
  - $X >= 0$ presque sûrement,
  - $X$ soit intégrable sur $(Omega, cal(F), PP)$.
])

#theorem(
  title: "Formule de transfert",
  [
    Soit $(Omega, cal(F), PP)$ un espace probabilisable, $func(X, Omega, RR_d)$ un vecteur aléatoire et $func(phi, RR^d, RR_+ union {+oo})$ une application mesurable. Alors
    $
      EE[phi(X)] = integral_Omega phi(X(omega)) dif PP(omega) = integral_(RR^d) phi(x) dif PP_X (x).
    $
  ],
)

#remark([
  Pour que l'intégrale précédente ait du sens on a besoin que :
  - $phi(X)$ soit intégrable sur $(Omega, cal(F), PP)$, c'est-à-dire que $phi$ soit intégrable sur $(RR^d, borel(RR^d), PP_X)$.
])

#proposition(
  title: "Cas discret",
  [
    Soit $(Omega, cal(F), PP)$ un espace probabilisable, $func(X, Omega, RR_d)$ un vecteur aléatoire et $func(phi, RR^d, RR_+ union {+oo})$ une application mesurable. Alors
    $ EE[phi(X)] = sum_(omega in cal(V_X)) phi(omega) PP(X = omega). $
  ],
)

#proposition(
  title: "Cas à densité",
  [
    Soit $(Omega, cal(F), PP)$ un espace probabilisable, $func(X, Omega, RR_d)$ un vecteur aléatoire à densité $func(f, RR^d, RR_+)$ et $func(phi, RR^d, RR_+ union {+oo})$ une application mesurable. Alors
    $ EE[phi(X)] = integral_(RR^d) phi(x) f(x) dif lambda(x). $
  ],
)

=== Variance

#definition([
  Soit $(Omega, cal(F), PP)$ un espace probabilisable et $func(X, Omega, RR_d)$ un vecteur aléatoire.
  On appelle _variance_ de $X$, notée $V(X)$, la valeur
  $ V(X) := EE[(X - EE[X])^2]. $
])

#proposition([
  Soit $(Omega, cal(F), PP)$ un espace probabilisable et $func(X, Omega, RR_d)$ un vecteur aléatoire.
  Alors la variance de $X$ vérifie les propriétés suivantes :
  + $V(X)$ ne dépend que de $X$.
  + $V(X) >= 0$, avec égalité si et seulement si $X$ est constante.
  + $forall a, b in RR, V(a X + b) = a^2 V(X)$.
  + $V(X) = EE[X^2] - EE[X]^2$.
])

=== Covariance

#definition([
  Soit $(Omega, cal(F), PP)$ un espace probabilisable et $func(X\, Y, Omega, RR_d)$ deux vecteurs aléatoires.
  On appelle _covariance_ de $X$ et $X$, notée $"Cov"(X, Y)$, la valeur
  $ "Cov"(X, Y) := EE[(X - EE[X])(Y - EE[Y])]. $
])

#proposition([
  Soit $(Omega, cal(F), PP)$ un espace probabilisable et $func(X\, Y, Omega, RR_d)$ deux vecteurs aléatoires.
  Alors la covariance vérifie les propriétés suivantes :
  + $"Cov"$ est bilinéaire symetrique.
  + $"Cov"(X, X) = V(X)$.
  + $"Cov"(X, Y) = EE[X Y] - EE[X]EE[Y]$.
  + $"Cov"(X, Y) <= sqrt(V(X)V(Y))$, avec égalité si et seulement si $X$ et $Y$ sont en relation affine.
  + $V(X + Y) = V(X) + V(Y) + 2 "Cov"(X, Y)$.
])

=== Concentration

#definition([
  Soit $(Omega, cal(F), PP)$ un espace probabilisable et $func(X\, Y, Omega, RR_d)$ deux vecteurs aléatoires.
  Alors si $"Cov"(X, Y) = 0$ on dit que $X$ et $Y$ sont _non correlées_.
])

#corollary([
  Soit $(Omega, cal(F), PP)$ un espace probabilisable et $func(X\, Y, Omega, RR_d)$ deux vecteurs aléatoires.
  Alors si $X$ et $Y$ sont non-correlées, on a $V(X + Y) = V(X) + V(Y)$.
])

#definition([
  Soit $(Omega, cal(F), PP)$ un espace probabilisable et $func(X_1\, ...\, X_n, Omega, RR_d)$ des vecteurs aléatoires.
  On appelle _moyenne empirique_ de $X_1, ..., X_n$, notée $overline(X)_n$, le vecteur aléatoire
  $ overline(X)_n := 1 / n sum_(k=1)^n X_k. $
])

#proposition([
  Soit $(Omega, cal(F), PP)$ un espace probabilisable et $func(X_1\, ...\, X_n, Omega, RR_d)$ des vecteurs aléatoires. Alors l'espérance de $overline(X)_n$ est donnée par
  $ EE[overline(X)_n] = 1 / n sum_(k=1)^n EE[X_k] $
  et sa variance par
  $ V(overline(X)_n) = 1 / (n^2) sum_(k=1)^n V(X_k) $
])

#proposition(
  title: "Inégalité de Markov et de Bienaymé-Chebychev",
  [
    Soit $(Omega, cal(F), PP)$ un espace probabilisable et $func(X, Omega, RR)$ une variable aléatoire.
    + Si $X >= 0$ presque sûrement, alors on a
      $ forall epsilon > 0, PP(X > epsilon) <= EE[X] / epsilon. $
    + Si $X$ est intégrable, alors on a
      $ forall epsilon > 0, PP(abs(X - EE[X]) > epsilon) <= V(X) / epsilon^2. $
  ],
)linebreak()
+ Soit $epsilon > 0$, on remarque que l'on a toujours l'inégalité
  $ epsilon ind({X >= epsilon}) <= X $
  par passage à l'espérance on trouve
  $ epsilon EE[ind({X >= epsilon})] <= EE[X] $
  ce qui donne bien l'inégalité de Markov.
+ On applique l'inégalité de Markov à $(X - EE[X])^2$.
])(
title: "Inégalité de Jensen",
[
Soit $(Omega, cal(F), PP)$ un espace probabilisable, $func(X, Omega, RR)$ une variable aléatoire intégrable et $func(phi, RR, RR)$ une fonction convexe bornée inférieurement.
Alors
$ phi(EE[X]) <= EE[phi(X)]. $
],
)

#theorem(
  title: "Inégalité de Hoeffding",
  [
    Soit $(Omega, cal(F), PP)$ un espace probabilisable et $func(X_1\, ...\, X_n, Omega, RR)$ des variables aléatoires indépendantes de sorte que pour tout $k in {1, ..., n}$, il existe $a_k, b_k in RR$ tels que $a_k <= X_k <= b_k$ presque sûrement.
    Si on note $S_n := X_1 + ... + X_n$, alors
    $
      forall t > 0, max(PP(S_n - EE[S_n] >= t), PP(S_n - EE[S_n] < t)) < exp(-(t^2)/(sum_(k=1)^n (b_k - a_k)^2)).
    $
  ],
)

== Application au calcul de lois

=== Méthode de la fonction muette

#proposition(
  title: "Méthode",
  [
    Soit $(Omega, cal(F), PP)$ un espace probabilisable et $func(X, Omega, RR_d)$ un vecteur aléatoire de densité $func(f, RR^d, RR_+)$.
    Alors pour toute fonction borélienne positive
    $ EE[h(X)] = integral_(RR^d) h(x) f(x) dif lambda(x) $
    en particulier pour tout $A in cal(F)$ en prenant $h := ind(A)$ on trouve
    $ PP(X in A) = EE[ind(A)(X)] = integral_A f(x) dif lambda(x). $
    ce qui montre que $X$ est de densité $f$.
  ],
)
#set-maths()


#pagebreak()

= Indépendance

== Vecteurs aléatoires indépendants

#definition([
  Soit $(Omega, cal(F), PP)$ un espace probabilisable et $func(X_1\, ...\, X_n, Omega, RR^(d_i))$ des vecteurs aléatoires.
  On dit que $X_1, ..., X_n$ sont _indépendants_, noté $X_1 tack.t.double ... tack.t.double X_n$, si
  $
    forall A_1, ..., A_n in borel(RR^(d_1)) times ... times borel(RR^(d_n)), PP(X_1 in A_1, ..., X_n in A_n) = product_(i = 1)^n P(X_i in A_i).
  $
])

#lemma([
  Soit $(Omega, cal(F), PP)$ un espace probabilisable, et $func(X, Omega, RR^p)$ et $func(Y, Omega, RR^q)$ deux vecteurs aléatoires.
  Alors les assertions suivantes sont équivalentes :
  #set-maths()

  + $X$ et $Y$ sont indépendants.
  + $PP_((X, Y)) = PP_X times.circle PP_Y$.
  + Pour toutes fonctions boréliennes positives $g$ et $h$, $EE[g(X)h(Y)] = EE[g(X)]EE[h(Y)]$
]) <lem-independance>

#proof([
  #linebreak()
  (1) $=>$ (2) : Soit $A in borel(RR^p)$ et $B in borel(RR^q)$.
  Puisque $X$ et $Y$ sont indépendants on a
  $
    PP_((X, Y))(A times B) &= PP((X, Y) in A times B) \
    &= PP(X in A, Y in B) \
    &= PP(X in A) PP(Y in B) \
    &= PP_X (A) PP_Y (B) = (PP_X times.circle PP_Y)(A times B)
  $
  par unicité de la mesure produit $PP_((X, Y)) = PP_X times.circle PP_Y$.

  (2) $=>$ (3) : Soit $g$ et $h$ deux fonctions boréliennes positives.
  Alors par la formule de transfert, en posant $func(phi, RR^p times RR^q, RR_+, (x, y), g(x)h(y))$, on a
  #set-maths()

  $
    EE[phi(X, Y)] &= integral_(RR^p times RR^q) phi(x, y) dif PP_((X, Y))(x, y) \
    &= integral_(RR^p times RR^q) g(x)h(y) dif (PP_X times.circle PP_Y)(x, y)
#set-maths()
  $
  en appliquant Fubini, on trouve
  $
    EE[phi(X, Y)] &= integral_(RR^q) integral_(RR^p) g(x) h(y) dif PP_X (x) dif PP_Y (y) \
    &= integral_(RR^q) h(y) integral_(RR^p) g(x) dif PP_X (x) dif PP_Y (y) \
    &= integral_(RR^p) g(x) dif PP_X (x) integral_(RR^q) h(y) dif PP_Y (y) \
    &= EE[g(H)]EE[h(y)].
  $

  (3) $=>$ (1) : Soit $A in borel(RR^p)$ et $B in borel(RR^q)$.
  Il suffit de prendre $g := ind(A)$ et $h := ind(B)$ pour obtenir l'indépendance.
])

#set-maths()

#proposition([
  Soit $(Omega, cal(F), PP)$ un espace probabilisable.
  #set-maths()

  + Soit $func(X, Omega, RR^p)$ et $func(Y, Omega, RR^q)$ deux vecteurs aléatoires indépendants. Alors pour toutes fonction boréliennes $f$ et $g$, $f(X)$ et $g(Y)$ sont indépendants.
  + Soit $func(X_1\, ...\, X_m, Omega, RR^(d_i))$ des vecteurs aléatoires indépendants. Alors pour tout $1 <= n < m$, $(X_1, ..., X_n)$ et $(X_(n+1), ..., X_m)$ sont indépendants.
])

#proof([
  + Soit $f$ et $g$ deux fonctions boréliennes. Alors il suffit d'appliquer le point (3) du @lem-independance aux compositions de $f$ et $g$ avec des fonctions boréliennes positives pour obtenir l'indépendance de $f(X)$ et $g(Y)$.
  + Soit $1 <= n < m$. Alors il suffit d'appliquer le point (2) du @lem-independance pour obtenir l'indépendance de $(X_1, ..., X_n)$ et $(X_(n+1), ..., X_m)$.
])

=== Critère d'indépendance pour des vecteurs discrets

#proposition([
  Soit $(Omega, cal(F), PP)$ un espace probabilisable, et $func(X, Omega, RR^p)$ et $func(Y, Omega, RR^q)$ deux vecteurs aléatoires discrets.
  Alors s'ils existent des fonctions $func(f, cal(V)_X, RR_+)$ et $func(g, cal(V)_Y, RR_+)$ telles que
  $ forall (x, y) in cal(V)_X times cal(V)_Y, PP(X = x, Y = y) = f(x)g(y) $
  alors $X$ et $Y$ sont indépendants, et il existe $c > 0$ tel que
  $ PP_X ({x}) = c f(x) "et" PP_Y ({y}) = 1 / c g(y). $
])

#proof([
  Soit $A in borel(RR^q)$ et $B in borel(RR^q)$ alors
  $
    PP(X in A, Y in B) &= sum_(x in cal(V)_X sect A) sum_(y in cal(V)_Y sect B) P(X = x, Y = y) \
#set-maths()

    &= sum_(x in cal(V)_X sect A) sum_(y in cal(V)_Y sect B) f(x)g(y) \
    &= sum_(x in cal(V)_X sect A) f(x) sum_(y in cal(V)_Y sect B) g(y)
  $
  en particulier si on pose $B := RR^q$ et $c := sum_(y in cal(V)_Y sect B) g(y)$, on trouve
  $ PP_X (A) = PP(X in A, Y in RR^q) = c sum_(x in cal(V)_X sect A) f(x) $
  d'où pour tout $x in cal(V)_X, PP_X ({x}) = c f(x)$. On fait la même chose avec $A := RR^p$ et $d := sum_(x in cal(V)_X sect A) f(x)$. Mais $PP(X in RR^p, Y in RR^q) = c times d = 1$, donc $d = 1/c$. Enfin
  $
    PP(X in a, Y in B) &= sum_(x in cal(V)_X sect A) PP(X = x) sum_(y in cal(V)_Y sect B) PP(Y = y) \
    &= PP(X in A)PP(X in B)
  $
  donc $X$ et $Y$ sont indépendants.
  #set-maths()

])

=== Critère d'indépendance pour des vecteurs à densité

#proposition([
  Soit $(Omega, cal(F), PP)$ un espace probabilisable, et $func(X, Omega, RR^p)$ et $func(Y, Omega, RR^q)$ deux vecteurs aléatoires à densités respectives $f_X$ et $f_Y$.
  + Si $X$ et $Y$ sont indépendantes. Alors le vecteur $(X, Y)$ admet une densité $f$ vérifiant :
    $ forall (x, y) in RR^p times RR^q, f(x, y) = f_X (x) f_Y (y) $
  + Si $(X, Y)$ admet une densité $f$ de la forme :
    $ forall (x, y) in RR^p times RR^q, f(x, y) = g(x) h(y) $
    où $g$ et $h$ sont boréliennes. Alors $X$ et $Y$ sont indépendantes et il existe $c > 0$ tel que
    $ f_X = c g "et" f_Y = c h. $
])

#proof([
  + Supposons que $X$ et $Y$ sont indépendantes.
    Soit $func(phi, RR^(p+q), RR_+)$ une fonction borélienne, alors par la formule de transfert
    $ EE[phi(X, Y)] &= integral_(RR^(p+q)) phi(x, y) dif PP_((X, Y))(x, y) $
    puisque $X$ et $Y$ sont indépendantes on a
    $
      EE[phi(X, Y)] &= integral_(RR^p times RR^q) phi(x, y) dif PP_X (x) times.circle PP_Y (y) \
#set-maths()

      &= integral_(RR^q) integral_(RR^p) phi(x, y) dif PP_X (x) dif PP_Y (y)
    $
    et puisque $X$ et $Y$ admettent des densités
    $
      EE[phi(X, Y)] &= integral_(RR^q) integral_(RR^p) phi(x, y) f_X (x) dif lambda(x) f_Y (y) dif lambda(y) \
      &= integral_(RR^(p + q)) phi(x, y) f_X (x) f_Y (y) dif lambda(x, y).
    $
    Donc $(X, Y)$ admet bien une densité $(x, y) |-> f_X (x) f_Y (y)$.
  #set-maths()

  + La réciproque se montre une nouvelle fois en appliquant le théorème de Fubini // TODO

])

== Somme de variables aléatoires indépendantes

=== Cas de variables aléatoires discrètes

#proposition([
  Soit $(Omega, cal(F), PP)$ un espace probabilisable, et $func(X\, Y, Omega, NN)$ deux variables aléatoires discrètes indépendantes à valeurs entières.
  On pose $S := X + Y$. Alors on a
  $ forall n in NN, PP(S = n) = sum_(k in NN) PP(X = k)P(Y = n - k) $
])

=== Cas de variables aléatoires à densité

#proposition([
  Soit $(Omega, cal(F), PP)$ un espace probabilisable, et $func(X\, Y, Omega, RR)$ deux variables aléatoires à densités respectives $f_X$ et $f_Y$.
  On pose $S := X + Y$. Alors la densité de $S$ est donnée par
  $ forall t in RR, f(t) := integral_RR f_X (x) f_Y (t - x) dif lambda(x). $
])


