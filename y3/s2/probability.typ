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
  On appelle _mesure de probabilité_ une mesure $fun(P, cal(F), RR_+)$ vérifiant $P(Omega) = 1$.
])

#definition([
  Soit $Omega$ un ensemble, $cal(F)$ une tribu sur $Omega$ et $P$ une mesure de probabilité sur $(Omega, cal(F))$.
  On appelle _espace probabilisé_ le triplet $(Omega, cal(F), P)$, on dit que $Omega$ est l'univers et que $cal(F)$ sont les événements.
])

#remark([
  Dans le cadre discret, on avait souvent $cal(F) := cal(P)(Omega)$. Dans le cadre général, on aura souvent $cal(F) subset.neq cal(P)(Omega)$.
])

#definition([
  Soit $seq(A)$ une suite d'événements sur $(Omega, cal(F), P)$. On dit que $seq(A)$ est un _système complet_ si elle vérifie :
  + les $A_n$ sont disjoints deux à deux,
  + la probabilité de l'union des $A_n$ est 1.
])

#proposition([
  Soit $seq(A)$ un système complet sur $(Omega, cal(F), P)$.
  Alors on a
  $ forall B in cal(F), P(B) = sum_(n=1)^(+oo) P(B sect A_n). $  
])

#proof([
  On pose $C := union.big_(n>=1) A_n$, puisque $P(C) = 1$, on a $P(C^c) = 0$ d'où $P(B sect C^c) = 0$. Soit $B in cal(F)$, on en déduit
  $ P(B) &= P(B sect C) + P(B sect C^c) \
    &= P(B sect C) \
    &= P(union.big_(n>=1) B sect A_n) \
    &= sum_(n=1)^(+oo) P(B sect A_n) "par" sigma"-additivité de" P. $
])

#corollary([
  Soit $seq(A)$ un système complet sur $(Omega, cal(F), P)$.
  Alors pour tout $B in cal(F)$on a

  + $P(B) = sum_(n=1)^(+oo) P(A_n)P(B|A_n)$,

  + $forall i >= 1, P(A_i|B) = display((P(A_i)P(B|A_i))/(sum_(n=1)^(+oo) P(A_n)P(B|A_n))).$
])

#theorem(title: "Continuité de la mesure de probabilité", [
  Soit $(Omega, cal(F), P)$ un espace probabilisé.
  + Soit $seq(A)$ une suite croissante d'événements. Alors on a
    $ lim_(n->+oo) P(A_n) = P(union.big_(n>=1) A_n). $
  + Soit $seq(A)$ une suite décroissante d'événements. Alors on a
    $ lim_(n->+oo) P(A_n) = P(sect.big_(n>=1) A_n). $
])

#proof([
  + Pour tout $n >= 1$, on pose $B_n := A_n without A_(n-1)$ avec $A_0 = emptyset$, tel que les $seq(B)$ forme un système complet sur $union.big_(n>=1) A_n$, on en déduit alors
    $ P(union.big_(n>=1) A_n) = P(union.big_(n>=1) B_n) &= sum_(n=1)^(+oo) P(B_n) = sum_(n=1)^(+oo) P(A_n) - P(A_(n-1)) $
    on reconnait une somme téléscopique et on a donc
    $ P(union.big_(n>=1) A_n) = lim_(n->+oo) P(A_n) - P(A_0) = lim_(n->+oo) P(A_n). $
  + On obtient directement le résultat par passage au complémentaire.
])

#definition([
  Soit $seq(A)$ une suite d'événements de $(Omega, cal(F), P)$.
  - On appelle _limite supérieure_ de la suite $seq(A)$ la valeur
    $ limsup_(n->+oo) A_n := sect.big_(n>=1) union.big_(k>=n) A_k $
    intuitivement on considère les éléments qui appartiennent à une infinité d'événements.
  - On appelle _limite inférieure_ de la suite $seq(A)$ la valeur
    $ limsup_(n->+oo) A_n := union.big_(n>=1) sect.big_(k>=n) A_k. $
])

#corollary([
  Soit $seq(A)$ une suite d'événements de $(Omega, cal(F), P)$.
  Alors on a
  $ P(limsup_(n->+oo) A_n) &= lim_(m->+oo) lim_(n->+oo) P(union.big_(k = m)^n A_k) \
    P(liminf_(n->+oo) A_n) &= lim_(m->+oo) lim_(n->+oo) P(sect.big_(k = m)^n A_k) $
])

#proposition([
  Soit $seq(A)$ une suite d'événements de $(Omega, cal(F), P)$.
  Alors on a $ P(union.big_(n>=1) A_n) <= sum_(n=1)^(+oo) A_n. $
])

#proof([
  On sait que le résultat est vérifié pour un nombre fini d'événements. Par passage à la limite et par continuité de la mesure $P$ on a
  $ P(union.big_(n>=1) A_n) = lim_(m->+oo) P(union.big_(n=1)^m A_n) <= lim_(m->+oo) sum_(n=1)^m P(A_n) = sum_(n=1)^(+oo) P(A_n). $
])

#definition([
  Soit $A$ un événement de $(Omega, cal(F), P)$.
  - On dit que $A$ est _négligeable_ si $P(A) = 0$.
  - On dit que $A$ est _presque-sûr_ si $P(A) = 1$.
])

#corollary([
  Soit $(Omega, cal(F), P)$ un espace probabilisé. Alors
  - L'union dénombrable d'événements négligeables est négligeable.
  - L'intersection dénombrable d'événements presque-sûrs est presque-sûre.
])

#proposition([
  Soit $cal(A)$ une famille d'événements de $(Omega, cal(F), P)$.
  Alors il existe une unique tribu $sigma(cal(A))$ telle que $sigma(cal(A))$ soit la plus petite tribu contenant $cal(A)$.  
]) <prop-tribu-engendree>

#proof([
  Il existe au moins une tribu contenant $cal(A)$, à savoir $cal(P)(Omega)$. Alors l'intersection de toutes les tribus contenant $cal(A)$ est une tribu et convient.
])

#definition([
  Soit $cal(A)$ une famille d'événements de $(Omega, cal(F), P)$.
  On appelle _tribu engendrée_ par $cal(A)$, notée $sigma(cal(A))$, la tribu de la @prop-tribu-engendree.
])

#example([
  Soit $A$ un événement de $(Omega, cal(F), P)$. Alors $sigma({A}) = {emptyset, A, A^c, Omega}$.
])

== Exemples d'espace probabilisés

#definition([
  Soit $(E, cal(O))$ un espace topologique. On appelle _tribu borélienne_ sur $E$, notée $borel(E)$, la tribu engendrée par les intervalles ouverts de $E$, c'est-à-dire $borel(E) := sigma(cal(O))$.
])

#lemma([
  Soit $seq(mu)$ une suite de mesures de probabilité sur $(Omega, cal(F))$ et $seq(lambda)$ une suite de nombres réels positifs telle que $sum_(n=1)^(+oo) lambda_n = 1$. Alors $mu = sum_(n=1)^(+oo) lambda_n mu_n$ est une mesure de probabilité sur $(Omega, cal(F))$.
])

=== Univers $Omega = RR$

#example(title: "Mesure de Dirac", [
  Soit $x in RR$, l'application $fun(delta_x, borel(RR), RR_+)$ définie par
  $ forall A in borel(RR), delta_x (A) = cases(0 "si" x in.not A, 1 "si" x in A) $
  est une mesure de probabilité sur $RR$.
])

#example(title: [Mesure uniforme sur ${1, ..., n}$], [
  L'application $mu = 1/n sum_(k = 1)^n delta_k$ est une mesure uniforme sur $RR$.
])

#example(title: "Mesure de Poisson", [
  Soit $lambda > 0$, l'application $mu = sum_(n=1)^(+oo) e^(-lambda) lambda^n/n! delta_n$ est une mesure de Poisson sur $RR$.
])

#definition([
  Soit $fun(f, RR, RR)$ une fonction borélienne.
  On dit que $f$ est une _densité de probabilité_ sur $RR$ si elle vérifie :
  + pour $lambda$-presque tout $x in RR, f(x) >= 0$,
  + $integral_RR f(x) dif lambda(x) = 1$. 
])

#lemma([
  Soit $f$ une densité de probabilité sur $RR$.
  Alors l'application $fun(mu_f, borel(RR), RR_+)$ définie par
  $ forall A in borel(RR), mu_f (A) = integral_A f(x) dif lambda(x)$
  est une mesure de probabilité sur $RR$.
])

#proof([
  On a bien $forall A in borel(RR), mu_f (A) >= 0$. De plus $mu_f (RR) = 1$. Soit $seq(A)$ une suite d'éléments de $borel(RR)$ deux à deux disjoints. On pose $A := union.big_(n>=1) A_n$, alors $ind(A) = sum_(n=1)^(+oo) ind(A_n)$ et
  $ mu_f (A) = integral_A f(x) dif lambda(x) = integral_RR ind(A) (x) f(x) dif lambda(x) = integral_RR sum_(n=1)^(+oo) ind(A_n) (x) f(x) dif lambda(x) $ 
  d'après le théorème de convergence monotone on a
  $ mu_f (A) = lim_(m->+oo) integral_RR sum_(n=1)^(m) ind(A_n) f(x) dif lambda(x) = lim_(m->+oo) sum_(n=1)^(m) mu_f (A_n) = sum_(n=1)^(+oo) mu_f (A_n). $
  Donc $mu_f$ est bien une mesure de probabilité sur $RR$.
])

#remark([
  On dit que $mu_f$ est une _mesure de densité_ $f$.
])



// === Univers $Omega = RR^d$
