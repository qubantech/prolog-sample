/*
(с) Sergey Sinitsa 2016.
DBPedia rdf query example.
Example query:
rdf('http://dbpedia.org/resource/World_War_II', 'http://dbpedia.org/ontology/commander', X).
Use sub_string(X, 28, _, 0, S) to cut 'http://dbpedia.org/resource/' prefix.
*/
:-use_module(library(semweb/rdf_db)).
:-use_module(library(semweb/turtle)).

load_ontology :-
  rdf_load('dbpedia_2016-04.owl', []).

rdf_assert_data([rdf(X,Y,Z)|T]) :-
  rdf_assert(X,Y,Z), rdf_assert_data(T).
rdf_assert_data([_|T]) :- rdf_assert_data(T).
rdf_assert_data([]).

load_data :-
  rdf_read_turtle('mappingbased_objects_en_uris_ru.ttl', T, []),
  rdf_assert_data(T).

load :-
  load_ontology,
  load_data.
