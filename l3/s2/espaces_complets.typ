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
]) <lem-cv-abs-sim>

#proof([
  Notons $sequence(U_n)$ la suite des sommes partielles de $sum_(n in NN) u_n$.
  Soit $M, N in NN$ tels que #box($M >= N$), alors par une inégalité triangulaire, on obtient
  $
    norm(U_M - U_N) = norm(sum_(n=N+1)^M u_n) <= sum_(n=N+1)^M norm(u_n) = sum_(n=0)^M norm(u_n) - sum_(n=0)^(N) norm(u_n) -->_(M, N -> +oo) 0
  $
  donc la suite $sequence(U_n)$ est de Cauchy, puisque $E$ est un espace complet, la suite $sequence(U_n)$ converge.
  Donc la série $sum_(n in NN) u_n$ converge simplement
])

#definition([
  Soit $(E, norm(dot))$ un espace vectoriel normé, $F$ un sous-ensemble de $E$ et $func(f, F, F)$ une application.
  On dit que $f$ est _contractante_ s'il existe $alpha in [0, 1[$ tel que :
  $ forall x, y in F, norm(f(x) - f(y)) <= alpha norm(x - y). $
])

#theorem(
  title: "Théorème du point fixe",
  [
    Soit $(E, norm(dot))$ un espace de Banach, $F$ un sous-ensemble fermé de $E$ et $func(f, F, F)$ une application contractante.
    Alors $f$ admet une unique point fixe sur $F$.
    De plus, la suite récurrente définie par :
    $ cases(x_0 in F, forall n in NN\, x_(n+1) = f(x_n)) $
    converge vers cette unique point fixe.
  ],
) <thm-point-fixe>

#proof([
  Puisque $f$ est contractante, il existe $alpha in [0, 1[$ tel que :
  $ forall x, y in F, norm(f(x) - f(y)) <= alpha norm(x - y). $
  Considérons la suite $sequence(x_n)$ et la série $sum_(n in NN) (x_(n+1) - x_n)$.
  Soit $n in NN without {0}$, on remarque que :
  $ norm(x_(n+1) - x_n) = norm(f(x_n) - f(x_(n-1))) $
  puisque $f$ est contractante, on a :
  $ norm(x_(n+1) - x_n) <= alpha norm(x_n - x_(n-1)) $
  par récurrence directe, on obtient :
  $ norm(x_(n+1) - x_n) <= alpha^n norm(x_1 - x_(0)) $
  donc d'après le théorème de comparaison, la série $sum_(n in NN) (x_(n+1) - x_n)$ converge absolument.
  Or comme $E$ est un espace de Banach, d'après le @lem-cv-abs-sim, la série $sum_(n in NN) (x_(n+1) - x_n)$ converge simplement.
  En particulier la suite des sommes partielles :
  $ S_n = sum_(k=0)^(n-1) (x_(k+1) - x_k) = x_n - x_0 $
  converge vers un élément de $E$.
  On en déduit que la suite $sequence(x_n)$ converge vers un élément de $E$.
  Puisque la suite $sequence(x_n)$ est dans $F$, qui est fermé, elle converge vers un élément $l in F$.
  Enfin puisque $f$ est contractante, elle est continue, par passage à la limite de l'égalité $x_(n+1) = f(x_n)$, on obtient $f(l) = l$.


  Soit $l, m in F$ deux points fixes de $f$. Puisque $f$ est contractante, on a :
  $ norm(l - m) = norm(f(l) - f(m)) <= alpha norm(l - m) $
  d'où $norm(l - m) = 0$ et $l = m$.
])

#remark([
  Le @thm-point-fixe possède de nombreuses applications :
  - Le théorème de Cauchy-Lipschitz qui donne l'existence de solutions d'équations différentielles.
  - Le théorème d'inversion locale.
  - La résolution d'équations de dérivées partielles.
])

== Applications

#theorem([
  Soit $(E, norm(dot)_E)$ et $(F, norm(dot)_F)$ deux espaces de Banach, $func(f, E, F)$ une application linéaire continue.
  Si $f$ est bijective, alors $f^(-1)$ est une application linéaire continue.
])

#theorem([
  Soit $(E, norm(dot)_E)$ et $(F, norm(dot)_F)$ deux espaces de Banach, $U$ un ouvert non-vide de $E$, $a$ un point de $U$ et $func(f, U, F)$ une application de classe $C^1$.
  Si $dd(f, a)$ est bijective, alors il existe un voisinage ouvert $V$ de $a$ et un voisinage ouvert $W$ de $f(a)$ tels que $func(f, V, W)$ soit un $C^1$-difféomorphisme.
])

#proof([
  On pose $M := norm(dd(f, a)^(-1)) > 0$.
  Soit $x in U$ et $y in F$.
  On considère l'équation $y = f(x)$ et on pose $func(phi, U, F, x, f(x) - f(a) - dd(f, a)(x - a))$, alors on a :
  $ y - f(a) - dd(f, a)(x - a) = phi(x) $
  puisque $dd(f, a)$ est bijective, on a :
  $ x = a + dd(f, a)^(-1)(y - f(a) - phi(x)). $

  On observe que $phi(a) = dd(phi, a) = 0$. Par continuité il existe $r_1 > 0$ tel que :
  $ forall x in overline(B)(a, r_1), norm(dd(phi, x)) <= 1 / (2M) $
  d'après le théorème des accroissements finis, on a :
  $
    forall x_1, x_2 in overline(B)(a, r_1), norm(phi(x_1) - phi(x_2)) <= 1 / (2M) norm(x_1 - x_2)
  $
  en particulier pour $x_2 = a$, on obtient :
  $
    forall x in overline(B)(a, r_1), norm(phi(x)) <= 1 / (2M) norm(x_1 - a) <= r_1 / (2M).
  $
  On pose $func(F_y, overline(B)(a, r_1), B(a, r_1), x, a + dd(f, a)^(-1)(y - f(a) - phi(x)))$. Soit $x in overline(B)(a, r_1)$, alors on a :
  $
    norm(F_y (x) - a) = norm(dd(f, a)^(-1)(y - f(a) - phi(x))) <= M norm(y - f(a) - phi(x))
  $
  on pose $r_2 := r_1 /(2M)$ et soit $y in B(f(a), r_2)$, alors on obtient :
  $ norm(F_y (x) - a) < M (r_1 / M) = r_1 $
  ainsi $F_y (x) in B(a, r_1)$.

  Soit $x_1, x_2 in overline(B)(a, r_1)$, alors on a :
  $
    norm(F_y (x_1) - F_y (x_2)) &= norm(a + dd(f, a)^(-1)(y - f(a) - phi(x_1)) - (a + dd(f, a)^(-1)(y - f(a) - phi(x_2)))) \
    &= norm(dd(f, a)^(-1)(phi(x_2) - phi(x_1))) \
    &<= M norm(phi(x_2) - phi(x_1)) \
    &<= M / (2M) norm(x_2 - x_1) = 1 / 2 norm(x_1 - x_2)
  $
  donc $F_y$ est contractante.

  D'après le théorème du point fixe, $F_y$ admet un unique point fixe dans $B(a, r_1)$.
  En particulier l'équation $y = f(x)$ admet une unique solution dans $B(a, r_1)$. \
  On pose $W := B(f(a), r_2)$ et $V := B(a, r_1) inter f^(-1)(W)$ de sorte que $func(f, V, W)$ est bijective.

  Soit $y_1, y_2 in W$, alors $f^(-1)$ vérifie :
  $
    f^(-1)(y_1) - f^(-1)(y_2) &= F_y_1 (f^(-1)(y_1)) - F_y_2 (f^(-1)(y_2)) \
    &= dd(f, a)^(-1)(y_1 - y_2) - dd(f, a)^(-1)(phi(f^(-1)(y_1)) - phi(f^(-1)(y_2))) \
  $
  on en déduit :
  $
    norm(f^(-1)(y_1) - f^(-1)(y_2)) <= M norm(y_1 - y_2) + 1 / 2 norm(f^(-1)(y_1) - f^(-1)(y_2))
  $
  donc $f^(-1)$ est lipschitzienne, et en particulier continue.
  On peut alors montrer que $f$ est un $C^1$-difféomorphisme.
])
