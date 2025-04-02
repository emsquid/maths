#import "../../template.typ": *

#set-maths(sequence: (ind: $n$, dom: $ZZ$))

#show: maths.with(
  title: "Problème du rectangle inscrit",
  authors: ("Emanuel Morille",),
  color: "#718355",
)

#pagebreak()

= Homologie

== Axiomes d'Eilenberg-Steenrod

#definition([
  Une théorie de l'homologie sur la catégorie des paires d'espaces topologiques dans la catégorie des groupes abéliens est une suite de couples de foncteur et de transformation naturelle, notée $sequence(H_n\, partial_n)$, vérifiant les axomes suivants.
])

#axiom(
  title: "Transport de l'homotopie",
  [
    Soit $(X, A)$ et $(Y, B)$ deux paires d'espaces topologiques, $func(f_0 \, f_1, (X, A), (Y, B))$ deux applications.
    Si $f_0$ et $f_1$ sont homotopes, alors les applications induites en homologie $f_(0*)$ et $f_(1*)$ sont égales.
  ],
)

#axiom(
  title: "Transport de l'excision",
  [
    Soit $(X, A)$ une paire d'espaces topologiques et $U$ un sous-ensemble de $A$.
    Alors l'inclusion $func(i, (X without U, A without U), (X, A))$ induit un isomorphisme en homologie.
  ],
)

#axiom(
  title: "Dimension",
  [
    Soit $P$ l'espace constitué d'un unique point.
    Alors le groupe $H_n (P, emptyset)$ est non-trivial si et seulement si $n != 0$.
  ],
)

#axiom(
  title: "Additivité",
  [
    Soit $sequence(X_i, ind: i, dom: I)$ une famille d'espaces topologiques deux à deux disjoints.
    Alors pour tout $n in ZZ$, les groupes $H_n (union.sq.big_(i in I) X_i)$ et $plus.circle.big_(i in I) H_n (X_i)$ sont isomorphes.
  ]
)

#axiom(title: "Exactitude", [
  Soit $(X, A)$ une paire d'espaces topologiques.
  Alors pour tout $n in ZZ$, la suite
  $... -> H_(n+1)(X, A) -> H_n (A, emptyset) -> H_n (X, emptyset) -> H_n (X, A) -> ...$ est exacte.
])

== Homologie singulière
