sentence(s(NP,VP)) --> noun_phrase(NP), verb_phrase(VP).
noun_phrase(np(D,N)) --> det(D), noun(N).
verb_phrase(vp(V,NP)) --> verb(V),noun_phrase(NP).
det(d(the)) --> [the].
det(d(a)) --> [a].
noun(n(cat)) --> [cat].
noun(n(bat)) --> [bat].
verb(v(eats)) --> [eats].