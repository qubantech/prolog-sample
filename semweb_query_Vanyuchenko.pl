    /*
(с) Sergey Sinitsa 2016.
DBPedia rdf query example.
Example query:
rdf('http://dbpedia.org/resource/World_War_II', 'http://dbpedia.org/ontology/commander', X).
Use sub_string(X, 28, _, 0, S) to cut 'http://dbpedia.org/resource/' prefix.

Find all subclasses of a person:
rdf(X,'http://www.w3.org/2000/01/rdf-schema#subClassOf','http://dbpedia.org/ontology/Person').

Find all Object Properties with Person Range:
rdf(X,'http://www.w3.org/2000/01/rdf-schema#range', 'http://dbpedia.org/ontology/Person').

Use with DCG:
load.
parse([где, вышла, игра, cities, skylines, ?], Answer).
parse([кто, выпустил, игру, hearts, of, iron, 3, ?], Answer).

*/
:-use_module(library(semweb/rdf_db)).
:-use_module(library(semweb/turtle)).

/*
Optionally use metaphones to fix typos:
:-use_module(library(double_metaphone)).

?- double_metaphone('seknd wrld vor', X).
X = 'SKNT'.*/

rdf_assert_data([rdf(X,Y,Z)|T]) :-
  rdf_assert(X,Y,Z), rdf_assert_data(T).
rdf_assert_data([_|T]) :- rdf_assert_data(T).
rdf_assert_data([]).

load_data :-
  rdf_read_turtle('mappingbased-objects_lang=ru.ttl', T, []),
  rdf_assert_data(T).

load :-
  load_data.

событие('http://ru.dbpedia.org/resource/Cities:_Skylines', именительный_падеж) --> [игра, cities, skylines] | [cities, skylines].
событие('http://ru.dbpedia.org/resource/Hearts_of_Iron_III', именительный_падеж) --> [игра, hearts, of, iron, 3] | [hearts, of, iron, 3].

событие('http://ru.dbpedia.org/resource/Cities:_Skylines', винительный_падеж) --> [игру, cities, skylines] | [cities, skylines].
событие('http://ru.dbpedia.org/resource/Hearts_of_Iron_III', винительный_падеж) --> [игру, hearts, of, iron, 3] | [hearts, of, iron, 3].

действие('http://dbpedia.org/ontology/computingPlatform', единственное_число, изъявительное_наклонение, прошлое_время, женский_род) --> [вышла] | [есть].
действие('http://dbpedia.org/ontology/publisher', единственное_число, изъявительное_наклонение, прошлое_время, мужской_род) --> [выпустил] | [издал].


поиск_личности(Что, Где) --> [где], действие(Что, единственное_число, изъявительное_наклонение, прошлое_время, женский_род), событие(Где, именительный_падеж), ['?'].
поиск_личности(Что, Где) --> [кто], действие(Что, единственное_число, изъявительное_наклонение, прошлое_время, мужской_род), событие(Где, винительный_падеж), ['?'].

parse(Tokens, Answer) :- phrase(поиск_личности(Что, Где), Tokens, _), rdf(Где, Что, Answer).

parse(_). 


/* Convert to lower case if necessary,
skips some characters,
works with non latin characters in SWI Prolog. */
filter_codes([], []).
filter_codes([H|T1], T2) :-
  char_code(C, H),
  member(C, ['(', ')', ':']),
  filter_codes(T1, T2).
filter_codes([H|T1], [F|T2]) :- 
  code_type(F, to_lower(H)),
  filter_codes(T1, T2).
