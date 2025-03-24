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
  $
    forall epsilon > 0, exists N in NN, forall p, q in NN, p >= N "et" q >= N => forall i in {1, ..., d}, abs(u^i_p - u^i_q) <= epsilon
  $
  on en déduit que pour tout $i in {1, ..., d}$, la suite $sequence(x^i_n)$ est de Cauchy dans $RR$ et converge vers une limite $x^i in RR$. Alors $sequence(x_n)$ converge vers une limite $x := (x^1, ..., x^d) in E$. Donc $E$ est un espace de Banach.
])

= Complétude des espaces de fonctions continues

#proposition([
  Soit $(E, norm(dot)_E)$ et $(F, norm(dot)_F)$ deux espaces vectoriels normés, $A$ un sous-ensemble de $E$ et $(C_b^0 (A, F), norm(dot)_oo)$ l'espace vectoriel normé des fonctions continues et bornées de $A$ dans $F$.
  Si $F$ est un espace de Banach, alors $C_b^0 (A, F)$ est aussi un espace de Banach.
])

#proof([
  Soit $sequence(f_n)$ une suite de Cauchy d'éléments de $C_b^0 (A, F)$.
  Soit $epsilon>0$, alors puisque la suite $sequence(f_n)$ est de Cauchy, il existe $N in NN$ tel que
  $
    forall p, q in NN, p >= N "et" q >= N => forall a in A, norm(f_p (a) - f_q (a))_F <= epsilon
  $
  en particulier, pour tout $a in A$, la suite $sequence(f_n (a))$ est de Cauchy dans $F$.
  Puisque $F$ est complet, la suite $sequence(f_n (a))$ converge vers $f(a) in F$.
  Montrons que la fonction $f$ est continue et bornée.

  On remarque en passant à la limite que l'on peut écrire
  $ forall q in NN, q >= N => forall a in A, norm(f(a) - f_n (a)) <= epsilon $
  donc la suite $sequence(f_n)$ converge uniformément vers $f$. Puisque les $f_n$ sont continues, la fonction $f$ est continue.

  De la même manière en remarque que pour tout $a in A$, on a $norm(f(a) - f_N (a))_F <= 1$, par une inégalité triangulaire inversée, on obtient
  $ norm(f(a))_F <= 1 + norm(f_N (a))_F $
  donc la fonction $f$ est bornée.
])

= Théorème du point fixe de Banach-Picard

#lemma([
  Soit $(E, norm(dot))$ un espace de Banach et $sum_(n in NN) u_n$ une série à termes dans $E$.
  Si $sum_(n in NN) u_n$ converge absolument, alors $sum_(n in NN) u_n$ converge simplement.
])

#proof([
  Notons $sequence(U_n)$ la suite des sommes partielles de $sum_(n in NN) u_n$.
  Soit $M, N in NN$ tels que #box($M >= N$), alors par une inégalité triangulaire, on obtient
  $
    norm(U_M - U_N) = norm(sum_(n=N+1)^M u_n) <= sum_(n=N+1)^M norm(u_n) = sum_(n=0)^M norm(u_n) - sum_(n=0)^(N) norm(u_n) -->_(M, N -> +oo) 0
  $
  donc la suite $sequence(U_n)$ est de Cauchy, puisque $E$ est un espace complet, la suite $sequence(U_n)$ converge.
  Donc la série $sum_(n in NN) u_n$ converge simplement
  // TODO
])
