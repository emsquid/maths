#import "../../template.typ": *

#show: maths.with(title: "Espaces complets", color: "#718355")

#set-maths(sequence: (ind: $n$, dom: $NN$))

= Suites de Cauchy

#definition([
  Soit $(E, norm(dot))$ un espace vectoriel normé et $sequence(x_n)$ une suite d'éléments de $E$.
  On dit que $sequence(x_n)$ est de _Cauchy_ si elle vérifie :
  $
    forall epsilon > 0, exists N in NN, forall p, q in NN, p >= N "et" q >= N => norm(x_p - x_q) <= epsilon.
  $
])

#proposition([
  Soit $(E, norm(dot))$ un espace vectoriel normé, $sequence(x_n)$ et $sequence(y_n)$ deux suites de Cauchy, et $lambda in RR$.
  Alors :
  + $sequence(x_n + y_n)$ est une suite de Cauchy.
  + $sequence(lambda x_n)$ est une suite de Cauchy.
  + $sequence(norm(x_n))$ est une suite de Cauchy.
])

#proof([
  + Soit $epsilon > 0$.
    Puisque $sequence(x_n)$ est de Cauchy, il existe $N_1 in NN$ tel que
    $
      forall p, q in NN, p >= N_1 "et" q >= N_1 => norm(x_p - x_q) <= epsilon / 2
    $
    et puisque $sequence(y_n)$ est de Cauchy, il existe $N_2 in NN$ tel que
    $
      forall p, q in NN, p >= N_2 "et" q >= N_2 => norm(y_p - y_q) <= epsilon / 2.
    $
    Posons $N := max(N_1, N_2)$. Soit $p, q in NN$ tels que $p >= N$ et $q >= N$. Alors
    $
      norm(x_p + y_p - (x_q + y_q))
      <= norm(x_p - x_q) + norm(y_p - y_q)
      <= epsilon / 2 + epsilon / 2
      = epsilon
    $
    donc $sequence(x_n)$ est de Cauchy.

  + // TODO cas lambda = 0 et lambda != 0
  + // TODO inégalité triangulaire inversée
])

#proposition([
  Soit $(E, norm(dot))$ un espace vectoriel normé et $sequence(x_n)$ une suite de Cauchy.
  Alors la suite $sequence(x_n)$ est bornée.
])

#proof([
  Puisque $sequence(x_n)$ est de Cauchy, il existe $N in NN$ tel que
  $ forall p, q in NN, p >= N "et" q >= N => norm(x_p - x_q) <= 1 $
  en particulier en posant $q := N$, on a
  $ forall p in NN, p >= N => norm(x_p - x_N) <= 1 $
  d'après l'inégalité triangulaire inversée, on a
  $ forall p in NN, p >= N => norm(x_p) <= 1 + norm(x_N). $
  Posons $M := max(norm(x_0), ..., norm(x_N), 1 + norm(x_N))$. Alors $sequence(x_n)$ est bornée par $M$.
])

#proposition([
  Soit $(E, norm(dot))$ un espace vectoriel normé et $sequence(x_n)$ une suite convergente.
  Alors la suite $sequence(x_n)$ est de Cauchy.
])

#proof([
  Soit $epsilon > 0$. Puisque $sequence(x_n)$ converge, il existe $N in NN$ et $cal(l) in E$ tel que
  $ forall n in NN, n >= N => norm(x_n - cal(l)) <= epsilon / 2 $
  Soit $p, q in NN$ tels que $p >= N$ et $q >= N$. Alors
  $
    norm(x_p - x_q) = norm(x_p - cal(l) + cal(l) - x_q) <= norm(x_p - cal(l)) + norm(x_q - cal(l)) <= epsilon / 2 + epsilon / 2 = epsilon
  $
  donc $sequence(x_n)$ est de Cauchy.
])

#proposition([
  Soit $(E, norm(dot))$ un espace vectoriel normé et $sequence(x_n)$ une suite de Cauchy.
  Si la suite $sequence(x_n)$ admet une sous-suite convergente, alors $sequence(x_n)$ est convergente.
])

#proof([
  Soit $epsilon > 0$.
  Puisque $sequence(x_n)$ admet une sous-suite convergente, il existe $func(phi, NN, NN)$ strictement croissante, $N_2 in NN$ et $cal(l) in E$ tels que
  $ forall n in NN, n >= N_2 => norm(x_phi(n) - cal(l)) <= epsilon / 2 $
  et puisque $sequence(x_n)$ est de Cauchy, il existe $N_1 in NN$ tel que
  $
    forall p, q in NN, p >= N_1 "et" q >= N_1 => norm(x_p - x_q) <= epsilon / 2
  $
  en particulier en posant $q := phi(p) >= p >= N$, on a
  $ forall p in NN, p >= N => norm(x_p - x_phi(p)) <= epsilon / 2. $
  Posons $N = max(N_1, N_2)$. Soit $n in NN$ tel que $n >= N$. Alors
  $
    norm(x_n - cal(l)) = norm(x_n - x_phi(n) + x_phi(n) - cal(l)) <= norm(x_n - x_phi(n)) + norm(x_phi(n) - cal(l)) <= epsilon / 2 + epsilon / 2 = epsilon
  $
  donc $sequence(x_n)$ est convergente.
])

= Complétude

#definition([
  Soit $(E, norm(dot))$ un espace vectoriel normé et $A$ un sous-ensemble de $E$.
  On dit que $A$ est _complet_ si toute suite de Cauchy de $A$ est convergente dans $A$.
  Si $E$ est complet, on dit que $E$ est un _espace de Banach_.
])

#examples([
  $(RR, abs(dot))$, $(CC, abs(dot))$ et $(RR^n, norm(dot))$ sont des espaces de Banach.
])

#proposition([
  Soit $(E, norm(dot))$ un espace vectoriel normé et $A$ un sous-ensemble de $E$.
  Si $A$ est complet, alors $A$ est fermé.
])

#proof([
  Soit $sequence(a_n)$ une suite d'éléments de $A$ qui converge vers $cal(l) in E$.
  Puisque $sequence(a_n)$ converge, $sequence(a_n)$ est de Cauchy. Puisque $A$ est complet, $sequence(a_n)$ converge dans $A$, alors $cal(l) in A$. Donc $A$ est fermé.
])

#proposition([
  Soit $(E, norm(dot))$ un espace vectoriel normé et $A subset B$ deux sous-ensembles de $E$.
  Si $A$ est fermé et $B$ est complet, alors $A$ est complet.
])

#proof([
  Soit $sequence(a_n)$ une suite de Cauchy d'éléments de $A$. Alors $sequence(a_n)$ est une suite de Cauchy d'éléments de $B$. Puisque $B$ est complet, $sequence(a_n)$ converge dans $B$. Mais puisque $A$ est fermé, $sequence(a_n)$ converge dans $A$. Donc $A$ est complet.
])

#proposition([
  Soit $(E, norm(dot))$ un espace vectoriel normé. Si $E$ est de dimension finie, alors $E$ est un espace de Banach.
])

#proof([
  Notons $d$ la dimension de $E$ et $(e^1, ..., e^d)$ une base de $E$. Puisque $E$ est de dimension finie $norm(dot)$ est équivalente à $norm(dot, oo)$. Soit $sequence(x_n)$ une suite de Cauchy. Alors
  $ forall epsilon > 0, exists N in NN, forall p, q in NN, p >= N "et" q >= N => forall i in {1, ..., d}, abs(u^i_p - u^i_q) <= epsilon $
  on en déduit que pour tout $i in {1, ..., d}$, la suite $sequence(x^i_n)$ est de Cauchy dans $RR$ et converge vers une limite $x^i in RR$. Alors $sequence(x_n)$ converge vers une limite $x := (x^1, ..., x^d) in E$. Donc $E$ est un espace de Banach.
])
