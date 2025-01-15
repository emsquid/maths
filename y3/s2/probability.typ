#import "../../template.typ": *

#show: maths.with(title: "Probabilités", color: "#718355")

= Cadre général de la théorie des probabilités

== Espace probabilisé général

#definition([
  Soit $Omega$ un ensemble.
  On appelle _tribu_ sur $Omega$ une famille $cal(F)$ de parties de $Omega$ vérifiant :
  + $cal(F)$ est non-vide : $emptyset in cal(F)$,
  + la stabilité par passage au complémentaire : $forall A in cal(F), A^c in cal(F)$,
  + la stabilité par union dénombrable : $forall seq(A) in cal(F)^NN, union.big_(n>=1) A_n in cal(F)$.
])

#definition([
  Soit $Omega$ un ensemble et $cal(F)$ une tribu sur $Omega$.
  On appelle _mesure de probabilité_ une mesure $fun(PP, cal(F), RR_+)$ vérifiant $PP(Omega) = 1$.
])

#definition([
  Soit $Omega$ un ensemble, $cal(F)$ une tribu sur $Omega$ et $PP$ une mesure de probabilité sur $(Omega, cal(F))$.
  On appelle _espace probabilisé_ le triplet $(Omega, cal(F), PP)$, on dit que $Omega$ est l'univers et que $cal(F)$ sont les événements.
])

#remark([
  Dans le cadre discret, on avait souvent $cal(F) := cal(P)(Omega)$. Dans le cadre général, on aura souvent $cal(F) subset.neq cal(P)(Omega)$.
])

#definition([
  Soit $seq(A)$ une suite d'événements sur $(Omega, cal(F), PP)$. On dit que $seq(A)$ est un _système complet_ si elle vérifie :
  + les $A_n$ sont disjoints deux à deux,
  + la probabilité de l'union des $A_n$ est 1.
])

#proposition([
  Soit $seq(A)$ un système complet sur $(Omega, cal(F), PP)$.
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
  Soit $seq(A)$ un système complet sur $(Omega, cal(F), PP)$.
  Alors pour tout $B in cal(F)$on a

  + $PP(B) = sum_(n=1)^(+oo) PP(A_n)P(B|A_n)$,

  + $forall i >= 1, PP(A_i|B) = display((PP(A_i)PP(B|A_i))/(sum_(n=1)^(+oo) PP(A_n)PP(B|A_n))).$
])

#theorem(
  title: "Continuité de la mesure de probabilité",
  [
    Soit $(Omega, cal(F), PP)$ un espace probabilisé.
    + Soit $seq(A)$ une suite croissante d'événements. Alors on a
      $ lim_(n->+oo) PP(A_n) = PP(union.big_(n>=1) A_n). $
    + Soit $seq(A)$ une suite décroissante d'événements. Alors on a
      $ lim_(n->+oo) PP(A_n) = PP(sect.big_(n>=1) A_n). $
  ],
)

#proof([
  + Pour tout $n >= 1$, on pose $B_n := A_n without A_(n-1)$ avec $A_0 = emptyset$, tel que les $seq(B)$ forme un système complet sur $union.big_(n>=1) A_n$, on en déduit alors
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
  Soit $seq(A)$ une suite d'événements de $(Omega, cal(F), PP)$.
  - On appelle _limite supérieure_ de la suite $seq(A)$ la valeur
    $ limsup_(n->+oo) A_n := sect.big_(n>=1) union.big_(k>=n) A_k $
    intuitivement on considère les éléments qui appartiennent à une infinité d'événements.
  - On appelle _limite inférieure_ de la suite $seq(A)$ la valeur
    $ limsup_(n->+oo) A_n := union.big_(n>=1) sect.big_(k>=n) A_k. $
])

#corollary([
  Soit $seq(A)$ une suite d'événements de $(Omega, cal(F), PP)$.
  Alors on a
  $
    PP(limsup_(n->+oo) A_n) &= lim_(m->+oo) lim_(n->+oo) PP(union.big_(k = m)^n A_k) \
    PP(liminf_(n->+oo) A_n) &= lim_(m->+oo) lim_(n->+oo) PP(sect.big_(k = m)^n A_k)
  $
])

#proposition([
  Soit $seq(A)$ une suite d'événements de $(Omega, cal(F), PP)$.
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
  Soit $seq(mu)$ une suite de mesures de probabilité sur $(Omega, cal(F))$ et $seq(lambda)$ une suite de nombres réels positifs telle que $sum_(n=1)^(+oo) lambda_n = 1$. Alors $mu = sum_(n=1)^(+oo) lambda_n mu_n$ est une mesure de probabilité sur $(Omega, cal(F))$.
])

=== Univers $Omega = NN$

Se référer au cours de _Probabilités_ de deuxième année.

=== Univers $Omega = RR$

#example(
  title: "Mesure de Dirac",
  [
    Soit $x in RR$, l'application $fun(delta_x, borel(RR), RR_+)$ définie par
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
  Soit $fun(f, RR, RR)$ une fonction borélienne.
  On dit que $f$ est une _densité de probabilité_ sur $RR$ si elle vérifie :
  + pour $lambda$-presque tout $x in RR, f(x) >= 0$,
  + $integral_RR f(x) dif lambda(x) = 1$.
])

#lemma([
  Soit $f$ une densité de probabilité sur $RR$.
  Alors l'application $fun(mu_f, borel(RR), RR_+)$ définie par
  $forall A in borel(RR), mu_f (A) = integral_A f(x) dif lambda(x)$
  est une mesure de probabilité sur $RR$.
])

#proof([
  On a bien $forall A in borel(RR), mu_f (A) >= 0$. De plus $mu_f (RR) = 1$. Soit $seq(A)$ une suite d'éléments de $borel(RR)$ deux à deux disjoints. On pose $A := union.big_(n>=1) A_n$, alors $ind(A) = sum_(n=1)^(+oo) ind(A_n)$ et
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
  $ integral_A abs(f - g) dif lambda = integral_A (f - g)ind(A_+) + (g - f)ind(A_-) dif lambda = 0 $
  donc $f - g = 0$ presque partout et $f = g$ presque partout.


  $arrow.l.double$ : Si $f = g$ presque partout, alors il est évident que $mu_f = mu_g$.
])

#example(
  title: "Loi uniforme",
  [
    Soit $c, d in RR$ avec $c < d$. Alors la fonction $fun(f, RR, RR, x:x, fx: (ind([c, d])(x))/(d - c))$ est une densité de probabilité. En particulier, pour tout $[a, b] subset [c, d]$
    $ mu_f ([a, b]) = integral_[a, b] f(x) dif lambda x = (b-a) / (d-c). $
    On note la probabilité associée $cal(U)([c, d])$.
  ],
)

#example(
  title: "Loi exponentielle",
  [
    Soit $lambda > 0$. Alors la fonction $fun(f, RR, RR, x:x, fx: lambda e^(-lambda x) ind(RR_+)(x))$ est une densité de probabilité. On note la probabilité associée $cal(E)(lambda)$.
  ],
)

#example(
  title: "Loi normale",
  [
    La fonction $fun(f, RR, RR, x:x, fx: 1/sqrt(2pi) e^(-x^2/2))$ est une densité de probabilité. On note la probabilité associée $cal(N)(0, 1)$.
  ],
)

=== Univers $Omega = RR^d$

On peut étendre les exemples de $RR$, ainsi que les définitions de densité et de mesures de probabilité associée.

== Classe monotone

#definition([
  Soit $cal(C)$ une famille de parties d'un ensemble $Omega$. On dit que $cal(C)$ est une _classe monotone_ si elle vérifie :
  + $Omega in cal(C)$,
  + $forall A, B in cal(C), A subset B => B without A in cal(C)$,
  + $forall seq(A) in cal(C)^NN "croissante", union.big_(n in NN) A_n in cal(C)$.
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
  Soit $seq(A)$ une suite d'éléments de $cal(C)$. Puisque $cal(C)$ est stable par passage au complémentaire, $cal(C)$ est aussi stable par union finie, en effet
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
  Soit $mu$ et $nu$ deux mesures de probabilités sur $(Omega, cal(F))$. S'il existe une famille de parties $cal(A)$ stable par intersection finie sur laquelle $mu$ et $nu$ coïncident, alors elles coïncident sur $sigma(cal(A))$.
])

#pagebreak()

= Variables et vecteurs aléatoires

#definition([
  Soit $(Omega, cal(F))$ un espace probabilisable. On appelle _vecteur aléatoire_ une application borélienne $fun(X, (Omega, cal(F)), (RR^d, borel(RR^d)))$. Dans le cas $d = 1$, on dit que $X$ est une _variable aléatoire_.
])

#proposition([
  Soit $(Omega, cal(F))$ un espace probabilisable.
  + Une application $fun(X, Omega, RR)$ est une variable aléatoire si et seulement si
    $ forall t in RR, X^(-1)(]-oo, t]) in cal(F) $
  + Une application $fun(X = (X_1, ..., X_d), Omega, RR^d)$ est un vecteur aléatoire si et seulement si $X_1, ..., X_d$ sont des variables aléatoires.
  + Soit $fun(X, Omega, RR^d)$ un vecteur aléatoire et $fun(phi, RR^d, RR^n)$ une application borélienne. Alors $phi compose X$ est un vecteur aléatoire.
])

#proof([
  + $arrow.r.double$ : Si $X$ est une variable aléatoire, alors $X$ est mesurable et le résultat est évident. \
    $arrow.l.double$ : Si pour tout $t in RR$ on a $X^(-1)(]-oo, t]) in cal(F)$. Alors puisque la famille ${]-oo, t] | t in RR}$ engendre $borel(RR)$, $X$ est mesurable. Donc $X$ est une variable aléatoire.
  + On obtient le résultat par projection en appliquant (1) à $X_1, ..., X_n$.
  + On obtient le résultat par composition de fonctions boréliennes.
])

#proposition([
  Soit $seq(X)$ une suite de variables aléatoires sur $(Omega, cal(F))$.
  + Si les applications $S := sup_(n in NN) X_n$ et $I := inf_(n in NN) X_n$ sont finies, alors $S$ et $I$ sont des variables aléatoires.
  + Si $seq(X)$ converge simplement vers une limite finie $X$, alors $X$ est une variable aléatoire.
])

#proof([
  + On remarque que pour tout $t in RR$ on a $S^(-1)(]-oo, t]) = sect.big_(n in NN) X^(-1)(]-oo, t])$ et que l'on peut écrire de la même manière pour $I$.
  + On remarque que $X = lim_(n->+oo) X_n = limsup_(n->+oo) X_n = liminf_(n->+oo) X_n$.
])

== Loi d'un vecteur aléatoire

#proposition([
  Soit $(Omega, cal(F), PP)$ un espace probabilisé et $fun(X, Omega, RR^d)$ un vecteur aléatoire.
  Alors l'application $fun(PP_X, borel(RR^d), RR_+, x: A, fx: PP(X^(-1)(A)))$ est une mesure de probabilité sur $RR^d$.
]) <prop-loi>

#definition([
  Soit $(Omega, cal(F), PP)$ un espace probabilisé et $fun(X, Omega, RR^d)$ un vecteur aléatoire.
  On appelle _loi de $X$_, notée $PP_X$, la mesure de probabilité de la @prop-loi. On dit aussi que $X$ suit la loi $PP_X$.
])

#definition([
  Soit $(Omega, cal(F), PP)$ un espace probabilisé et $fun(X, Omega, RR^d)$ un vecteur aléatoire. On appelle _atomes de X_, noté $cal(V)_X$, l'ensemble
  $ cal(V)_X := {x in RR^d | PP_X ({x}) > 0}. $
  
])

#example(
  title: "Loi de Bernoulli",
  [
    On considère $(Omega, cal(F), PP)$ avec $Omega = RR$, $cal(F) = borel(RR)$ et $PP$ la mesure uniforme sur $[0, 1]$. On prend $X = ind([0, p])$ avec $p in [0, 1]$. Soit $A in borel(RR)$, alors
    $ PP_X (A) &= PP(X^(-1) (A)) = PP(X^(-1)(A sect {0})) + PP(X^(-1)(A sect {1})) \
      &= delta_0 (A) PP(X^(-1)(0)) + delta_1 (A) PP(X^(-1)(1)) = delta_0 (A) (1 - p) + delta_1 (A) p $
    donc $PP_X = delta_0 (1-p) + delta_1 p$.
  ],
)

#proposition([
  Soit $(Omega, cal(F), PP)$ un espace probabilisé et $fun(X = (X_1, ..., X_d), Omega, RR^d)$ un vecteur aléatoire. Si $X$ admet une densité $fun(f, RR^d, RR_+)$, alors les variables aléatoires $X_1, ..., X_d$ admettent des densités $fun(f_1","... "," f_d, RR, RR_+)$ avec
  $ forall i in {1, ..., d}, f_i (x) := integral_(RR^(d-1)) f(x_1, ..., x_(i-1), x, x_(i+1), ..., x_d) dif lambda(x_1, ..., x_(i-1), x_(i+1), ..., x_n). $
])

#proof([
  Il suffit d'appliquer le théorème de Fubini.
])
